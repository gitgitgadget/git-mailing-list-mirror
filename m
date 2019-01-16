Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB3A51F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 23:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfAPXke (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 18:40:34 -0500
Received: from mail-eopbgr780091.outbound.protection.outlook.com ([40.107.78.91]:17685
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727529AbfAPXkd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 18:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTlmBv67NlDCwY6x/6f9En/F7YeUs4GMV32tv6wyEnI=;
 b=HKWVicBcqj/rqD7zh33Shy8nXE3jA2FjDNu8GUrXxjFm0zqjqIb9m6neVlf0bezVy7RiY7A2AdNSLnma1F0K3bBxZPoapeqHR1+kqtFdRk5DltsClQLMr257JVuPfZTN6Y3ixA9K2v47cXjytqZ7qW6+SeXGTKHUrfHJ5YgrE/Q=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB6106.namprd08.prod.outlook.com (20.178.28.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 23:40:23 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::a907:18b6:6650:573b]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::a907:18b6:6650:573b%4]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 23:40:23 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "luke@diamand.org" <luke@diamand.org>
CC:     "Mazo, Andrey" <amazo@checkvideo.com>,
        "aoakley@roku.com" <aoakley@roku.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>
Subject: Re: [PATCHv2 1/2] git-p4: add failing test for shelved CL update
 involving move
Thread-Topic: [PATCHv2 1/2] git-p4: add failing test for shelved CL update
 involving move
Thread-Index: AQHUrGSkkPoIhh2oTkywZGfnpNnpoqWykM+A
Date:   Wed, 16 Jan 2019 23:40:23 +0000
Message-ID: <20190116234001.15234-1-amazo@checkvideo.com>
References: <20190114235524.3947-2-luke@diamand.org>
In-Reply-To: <20190114235524.3947-2-luke@diamand.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:405:1::27) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR08MB6106;6:MNIJBUdFYaSyJrWPz152sz429EmHM9zcEnxlzbkK77VuGdRPgmj+pKYCtNaU3NwQ0gFsDtIO4/G1k7y2ht9WNAMxLFC/qgO3SNLN/NS/ZjZYHCUnCgamTBTX1+2QTk5ikSNq4RwSBsdaJayNR9JgMo/HNOK9lbX9NvM8+TR58tn6RhvgwRSefsCSECtfF4S/cSQSr9GwqUszekjwP3Yo8V9tcnBN2dH9lcUTA7x8C2hJxoeXB1XtrTa4uuHAupHdWAjZvli7Pwt5/rm1eZkHcgE9YKi5eEP21ePpBq8SC+jKfGmp9RBS2upQUZGSJJbddI9Y57+TuoXhkvQlly2syyZpoONGfUEkOOmI4apI1hyDERX+EOo0uPbgyW+ikIbmlcmSAL8vBACMw+cjzxFZBpv4kW0TMi/6zunupqTra+3mUeB0ZTxZGUvq+aULiqFIsn87bLuTDn5a1BTv4VXBPg==;5:XNd1BzZTYHpekL3/oLK7yIdk8WSCNji1QL1k3elTJr0Z2FEpjBKJf7JINj6GnEkh9oTU6FTuM5EmNU2cJq5eSO86I9zW2JMk3nM5gqan0e7nIvnkyOqbEWaHATCAqMde8LWZnqU5ZkUBHWwG3VQuu97OBaFSEnNleyanQOwiXqQ/g00d41xczty1Gz9D1uHAEYTAVUoqUnpwaZiscA9xgQ==;7:g4voXmncWFDet4XabZeJimLW4QiBhZytHB/2r6fIwF4xodqWWyMhSXSIcsCkOsadGhBCnQh5+dF+IN0re2cepACY+P5DY3Url1oBKgyl6HpSqAKsXF9DeNTc8vapv8tPKYRkLG98XFusWpjW4Bvb3Q==
x-ms-office365-filtering-correlation-id: 7e29ee21-a233-4142-3ff9-08d67c0bfb9e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB6106;
x-ms-traffictypediagnostic: DM6PR08MB6106:
x-microsoft-antispam-prvs: <DM6PR08MB6106F8F2AC55AE2F06559DA8DA820@DM6PR08MB6106.namprd08.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(346002)(136003)(199004)(189003)(305945005)(7736002)(68736007)(97736004)(478600001)(39060400002)(4326008)(6246003)(25786009)(81166006)(81156014)(8676002)(1730700003)(8936002)(50226002)(14454004)(36756003)(6512007)(2906002)(53936002)(105586002)(256004)(2501003)(99286004)(106356001)(6116002)(3846002)(486006)(4744005)(316002)(54906003)(71200400001)(71190400001)(66066001)(5640700003)(1076003)(2351001)(6916009)(102836004)(52116002)(26005)(186003)(6506007)(76176011)(386003)(229853002)(446003)(476003)(11346002)(2616005)(6486002)(86362001)(5660300001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB6106;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5szfLKUqMYMpGxQYos4Fy4mvUSQspO1mTUGHUZ0t+GRHu5htWI5uIzUd6XLXX7OMCa5aTKam058xnCqA24xOtV9cfXcKKCzusE8kTBwgezEsh4RVO79aTyzDhhhwR5KOr8Qs9xRO7YV8gGt401clIPooG7UH98XdZRpd5R5wcWAW2ZsBQ7xKeOuMSzTiTrysrU2HfCuIwqQb1PLRLEJA2qIr93LcvEnWfcZDCgWKiafbl6r189J2dvWn6yn1ml1vi8yQQemxq5yy5TaKiKWP/I43JDy2G2CqEcVm0ablRSDP94Ff7DuDytdPaE/lOlkkWi9Tloo0UwJVRcUnI8PkwuKU3/2fONgIeceZWevQmbJuyfqlkEpsZlJP9ecb33n3w4LBBjstgzWd5m35x49eyqaRc2ULekmfRESPRVbWwWI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e29ee21-a233-4142-3ff9-08d67c0bfb9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 23:40:22.2717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB6106
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>=20
> Updating a shelved P4 changelist where one or more files have
> been moved does not work. Add a test for this.
>=20
> The problem is that P4 requires a complete list of the files being
> changed, and move/rename only includes the _source_ in the case of
> updating a shelved changelist. This results in errors from Perforce
> such as:
>=20
>   //depot/src - needs tofile //depot/dst
>   Submit aborted -- fix problems then use 'p4 submit -c 1234'
>=20

Shouldn't a similar test case and a fix be added for the "copy" case too?
The code looks very similar to the "move" case, so will probably fail in a =
similar way, right?

For the "move" test case and the fix, please, feel free to add my
Acked-by: Andrey Mazo <amazo@checkvideo.com>
(if it's of any use)

Thank you,
Andrey
