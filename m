Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 508FE20248
	for <e@80x24.org>; Mon, 25 Mar 2019 17:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfCYRU7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 13:20:59 -0400
Received: from mail-eopbgr780105.outbound.protection.outlook.com ([40.107.78.105]:4384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729106AbfCYRU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 13:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVCQGp2owIXdDs8h884MSNqFqLMmySpKz9gkA/zQJGM=;
 b=afk0t3ox80AaZ5ImV5dm3SVUC9bdnw5NEgxguP+9pNkRALSXN+A8UYaCzqXUkwIQwl5/JUStN8JVT2C2QWQb5OVYRTPAfTPP+CQi/R+xmCzJote9wnRoGhkfs5DDttAap1I1mIC5Z3MNUpntjZcfEBeaPDuHQ4j5mDn7AC5eRn8=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4331.namprd08.prod.outlook.com (20.176.82.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 17:20:55 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 17:20:55 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "luke@diamand.org" <luke@diamand.org>
CC:     "ahippo@yandex.com" <ahippo@yandex.com>,
        "Mazo, Andrey" <amazo@checkvideo.com>,
        "aoakley@roku.com" <aoakley@roku.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>
Subject: Re: [PATCH v2 2/7] git-p4: match branches case insensitively if
 configured
Thread-Topic: [PATCH v2 2/7] git-p4: match branches case insensitively if
 configured
Thread-Index: AQHU4DYGwpQ0yt3xbE+SDG6OAdz4sqYY8ZUAgAOsHoA=
Date:   Mon, 25 Mar 2019 17:20:55 +0000
Message-ID: <20190325172037.32373-1-amazo@checkvideo.com>
References: <CAE5ih7-W9vw4siwc=YQD36863LaCm1RzatAZ4Ajjk8MjYimOdA@mail.gmail.com>
In-Reply-To: <CAE5ih7-W9vw4siwc=YQD36863LaCm1RzatAZ4Ajjk8MjYimOdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR19CA0089.namprd19.prod.outlook.com
 (2603:10b6:404:133::27) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3d8df0c-ddca-4f08-f93a-08d6b1463d1b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4331;
x-ms-traffictypediagnostic: DM6PR08MB4331:
x-microsoft-antispam-prvs: <DM6PR08MB433156C2BC4347331D9C6775DA5E0@DM6PR08MB4331.namprd08.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(136003)(346002)(396003)(199004)(189003)(8936002)(8676002)(186003)(81156014)(7736002)(1730700003)(81166006)(71190400001)(6916009)(6486002)(26005)(14454004)(1076003)(6436002)(2501003)(446003)(25786009)(229853002)(50226002)(68736007)(99286004)(478600001)(476003)(2616005)(66066001)(6246003)(4326008)(2351001)(305945005)(106356001)(5640700003)(105586002)(486006)(53936002)(6506007)(386003)(102836004)(11346002)(316002)(54906003)(256004)(19627235002)(76176011)(6512007)(36756003)(86362001)(7416002)(2906002)(97736004)(3846002)(5660300002)(6116002)(71200400001)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4331;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S+uf7AmR5bESTNcUQ5D7kIuKI4Xbz46DZ47MtGHfZn12m3ZJB9mWdUmanJ6HyfPt23lrqyVOOaG7wubs+/QDFHWksen1OgpXVKgsWYrDEs8s4uzwacTLjZgGjNr+0l+HUzUqAwBMg2lxmGzCJlzQXqZ+kEs0yy77CseiS7FKa4PNjWt44mNbZGBtBOOU52bSwhAsBoYyeQlRLWFZ8JXCQIeEOGKjXGfjRnNWOgEJooF2os07N6DdDJiOHJlajTR64O2qGYr9by+yQyGfIQHItZop4t6Ww2j1Lg4dax09IzKQEFsG3SBzFHtlqI/ZNSbaQD+wW6vGn0BgEVYC7knqqu+dnv6wW0W+oUdtj8CBsbFRgCpkG0kjO2KZbXj526Yiy8a9reYpdChMVvedHeL/r3obIRnnJvn4y1Xqx+fxfpk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d8df0c-ddca-4f08-f93a-08d6b1463d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 17:20:55.4197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4331
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Mazo, Andrey" <amazo@checkvideo.com>


23.03.2019, 05:16, "Luke Diamand" <luke@diamand.org>:
> On Thu, 21 Mar 2019 at 22:32, Mazo, Andrey <amazo@checkvideo.com> wrote:
>>  git-p4 knows how to handle case insensitivity in file paths
>>  if core.ignorecase is set.
>>  However, when determining a branch for a file,
>>  it still does a case-sensitive prefix match.
>>  This may result in some file changes to be lost on import.
>>
>>  For example, given the following commits
>>   1. add //depot/main/file1
>>   2. add //depot/DirA/file2
>>   3. add //depot/dira/file3
>>   4. add //depot/DirA/file4
>>  and "branchList =3D main:DirA" branch mapping,
>>  commit 3 will be lost.
>>
>>  So, do branch search case insensitively if running with core.ignorecase=
 set.
>>  Teach splitFilesIntoBranches() to use the p4PathStartsWith() function
>>  for path prefix matches instead of always case-sensitive match.
>
> I wonder what other code paths break due to this problem!
>
> Looks reasonable but I fear there may be some other holes in there -
> quickly looking through the code suggests there are several other
> places this problem occurs.

From a quick search for .startswith(), I only see that stripRepoPath() migh=
t have a similar problem in useclientspec case.
If you see other apparent problematic places, could you, please, point them=
 out?

Or let me try to come up with a test case, and see what other places break.

Thank you,
Andrey.
