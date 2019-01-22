Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E501F453
	for <e@80x24.org>; Tue, 22 Jan 2019 18:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfAVSQF (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 13:16:05 -0500
Received: from mail-eopbgr790123.outbound.protection.outlook.com ([40.107.79.123]:28176
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbfAVSQF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 13:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAduipjALC/qelGGLNzleim/fqIade17DdQnXBXXRRM=;
 b=X89VMWsoiflU+6gAsmowdw1vAWYYPcq3xGnasnuUpomu4Af0yxWpHMF8GN4ptqo8thtgcStuFeo5wYqNK0Cd5S0mHdHQd4eByGtq4d3ZcW7KyO4Q6bemUl+LjLfP1cIYAhhYcdvTs/IstWmEld+n3KLvl/DQmrF94XTlNslBKow=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB3964.namprd08.prod.outlook.com (20.176.68.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Tue, 22 Jan 2019 18:16:02 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::e03b:4bd5:4777:f739]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::e03b:4bd5:4777:f739%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 18:16:02 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "luke@diamand.org" <luke@diamand.org>
CC:     "Mazo, Andrey" <amazo@checkvideo.com>,
        "aoakley@roku.com" <aoakley@roku.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>
Subject: Re: [PATCHv3 0/2] git-p4: shelved change update with move/copy
Thread-Topic: [PATCHv3 0/2] git-p4: shelved change update with move/copy
Thread-Index: AQHUrxFgl0Pp9vVYwkWnNd5psouvQ6W7ntuA
Date:   Tue, 22 Jan 2019 18:16:02 +0000
Message-ID: <20190122181547.2172-1-amazo@checkvideo.com>
References: <20190118093656.16521-1-luke@diamand.org>
In-Reply-To: <20190118093656.16521-1-luke@diamand.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN4PR10CA0009.namprd10.prod.outlook.com (2603:10b6:403::19)
 To DM6PR08MB4956.namprd08.prod.outlook.com (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR08MB3964;6:gRBKKCl24lb6kUMclFTG60GhkWPE4f6gdhfec9hHdfDo27OySj8KQUpSsGPYRhtl9LPDaKB6jC/ebU/k/xdpJ7+5PAhO47Y6Ewok0Brl8AvILjDB0L2Zekoaur/LmUzU4HCLFmTpst1OF7um/ZyT6pGTk5mwVIvvV6/3bSP4ftOVrBUn8Is0ZSuQW4zL10JNclCwyPK4MDiJge57Uq6724UYaaIpGYdGtXdmXA273j3dVFOfIuBRzxAMPNxbKWMCPeYSHjr37cXLjeVWAGKEfS6T9Qp3b5HC5q3nuBHCn1deKpLArV6svsXF9BVgW8VjsdNElTHNWmgg6Je7thtgH5U1V5vnz45iGgjP3EQSrOXKLnHOKXDkI9T13444XNwt0NMCwJQmjfx6dKXYIcY8CvkjO7aD22P/+790w3+JYlsUhmrx3xfKHnMPVB27K+KrLIHvqCKG3RWsB3zlapCCJA==;5:zvifQwH5gNuLrD3GkJ+PEeewEQP9qzvs9H1nF56nHpA/6g22sVHCBVgaPGxPu+P0sr5A7tu/iqBrlElTK/rMrR9aXfwN83QlkBso+7s8n2SAWal+LSEc9TlCAK2PnEQR3Ea3Za59ogdZmhE9+WBGbprztVyKBZCA5lE0cY4p2qrI6L8fLbMPiTC5x7V9IQrMTgbUsGRk2y3toP7uLcgouQ==;7:sOTEE/69Su5fPrfMa16aTJRPDW7dACOIf1xZgzvfyasc00vf/1++P6nq1cLXKTvO6WvQDbi9d2rEWZoRKlmTTaHanqqBRWBzMz3uVgiqjRamQI9CwI3qnU6f/g0bW6ZIGYZhgLuRBZ9kt7wZjjAaSw==
x-ms-office365-filtering-correlation-id: 67c36baf-84dc-4723-6206-08d68095aa70
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB3964;
x-ms-traffictypediagnostic: DM6PR08MB3964:
x-microsoft-antispam-prvs: <DM6PR08MB3964020E552550269E17F573DA980@DM6PR08MB3964.namprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(136003)(366004)(376002)(189003)(199004)(76176011)(316002)(5640700003)(25786009)(26005)(6916009)(446003)(68736007)(186003)(256004)(14444005)(53936002)(6436002)(52116002)(4326008)(6486002)(54906003)(386003)(7736002)(102836004)(6506007)(478600001)(2351001)(6116002)(71200400001)(71190400001)(3846002)(305945005)(97736004)(14454004)(4744005)(229853002)(99286004)(11346002)(105586002)(15650500001)(106356001)(2906002)(1730700003)(8676002)(6246003)(81156014)(81166006)(1076003)(36756003)(86362001)(6512007)(8936002)(39060400002)(2616005)(345774005)(486006)(50226002)(66066001)(2501003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB3964;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kLAjFOjcozD7CX7kntDSOUgChnyx6Jr1oxZSkIyoKJ6jgRRhw/OS/WV0K4DJ4SDlRcNnExr7uudtTF0XN6bZDvlAzwpHyhd0bTjYPSMXUFqsT698/9T/DK9D0EuZAcYE7cDKhudTAiffXz9n7dSTLFb+Da0XxbrtgqejXR7DXdx+/tcY8CKMlNA8Dx2HeK0er8WWwpk4VspO/lkrvqsuAhGCw66E+ODrCXo14BmbIDwudZv49pQeKJjZM9A3yK8Fah/U9bkEKKsZDSmP3IYBKDslOmwkXyzRiSSAYo4C+dNOxzpCGnrWfxpzSZ8woLTqX0sGTQWn7if7UbEliNYx1Ck8qPG0Pi7mSijM/D4Fu4dbYer8LLJYPNUixz7TnOmnBAxGg7h6XP6QS9Dc6LHzydyLJ0Fdu1qkTyTNaeeb/GY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c36baf-84dc-4723-6206-08d68095aa70
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 18:16:01.2321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB3964
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This updates the patchset to support copy, as suggested by Andrey.
>=20
> Luke Diamand (2):
>   git-p4: add failing test for shelved CL update involving move/copy
>   git-p4: handle update of moved/copied files when updating a shelve
>=20
>  git-p4.py                |  2 ++
>  t/t9807-git-p4-submit.sh | 57 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 56 insertions(+), 3 deletions(-)

Thank you for addressing my comments!
The updated patchset looks good to me:
Acked-by: Andrey Mazo <amazo@checkvideo.com>

Thank you,
Andrey
