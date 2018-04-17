Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E281F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeDQRdc (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:33:32 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:62156
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752192AbeDQRdb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iPCCAjotOQWOV6DLbSYFDeRBA/eVgJG6wlJn1s7cJbQ=;
 b=p0kMjnVhrY3dbbThpHR2YHwcC165MRIFe8VPuc1XehhhO6V8PKp3ivU9EUs0clb0n1T9d4Nxai2sdvD9ZEob6tX7XtNZD3IZveZCH26f7u2cC5J0tEDz5VDzY3G1cEtxsXQUGhD8U/NRApSGdiRvd4ZszXeZ6H4PFEveECQV0Q4=
Received: from BYAPR08MB3845.namprd08.prod.outlook.com (52.135.193.27) by
 BYAPR08MB4117.namprd08.prod.outlook.com (52.135.196.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.675.14; Tue, 17 Apr 2018 17:33:27 +0000
Received: from BYAPR08MB3845.namprd08.prod.outlook.com
 ([fe80::496c:14e1:20ef:ca62]) by BYAPR08MB3845.namprd08.prod.outlook.com
 ([fe80::496c:14e1:20ef:ca62%13]) with mapi id 15.20.0675.015; Tue, 17 Apr
 2018 17:33:27 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     Thandesha VK <thanvk@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "luke@diamand.org" <luke@diamand.org>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>
Subject: Re: [BUG] git p4 clone fails when p4 sizes does not return 'fileSize'
 key
Thread-Topic: [BUG] git p4 clone fails when p4 sizes does not return
 'fileSize' key
Thread-Index: AQHT1du7X51QcloYSUG+Lp9Mls7MJ6QFJMMAgAAQcACAAAD9Bg==
Date:   Tue, 17 Apr 2018 17:33:26 +0000
Message-ID: <BYAPR08MB384591845049E50D98A42303DAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
References: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
 <cover.1523981210.git.amazo@checkvideo.com>,<CAJJpmi9OQicqEonVwWMo+yimU5MBdJ9gwzbtY1GXSMB+E69AGA@mail.gmail.com>
In-Reply-To: <CAJJpmi9OQicqEonVwWMo+yimU5MBdJ9gwzbtY1GXSMB+E69AGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4117;7:z/bGMEAFAiqGPRvdX5geKLg91aq4esjnqelEh4+6Eg8azeu7SYjo5A0wqrbTRfLUkGm5z/+rTSPf7zBmVsH1fM4Chg8HDoiptuAgFe3f598vLJlbkC0jkcJtNoSkW6quKY7YNN93FHngMaT5yehPptt9ox0rTN35Yi8WD3NzQdYNnnjGFFKwvvTq5MeXxq/NxE0OeiblrlY13SjUBbwhVEcPcYwNto8rLxuXnsZ5DCgoRyTIhq+LU3EmHeYjuO67
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4117;
x-ms-traffictypediagnostic: BYAPR08MB4117:
x-microsoft-antispam-prvs: <BYAPR08MB411798A03488A9E180ABD517DAB70@BYAPR08MB4117.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BYAPR08MB4117;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4117;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(4326008)(6246003)(8676002)(55016002)(66066001)(2900100001)(53936002)(9686003)(6436002)(54906003)(3660700001)(74316002)(486006)(81156014)(81166006)(305945005)(3846002)(6116002)(14454004)(3280700002)(106356001)(39060400002)(478600001)(68736007)(8936002)(25786009)(316002)(11346002)(6916009)(229853002)(99286004)(97736004)(7696005)(102836004)(476003)(105586002)(33656002)(76176011)(6506007)(26005)(53546011)(7736002)(2906002)(86362001)(186003)(446003)(5250100002)(1411001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4117;H:BYAPR08MB3845.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Dh/wPkiaVEKr5pcUzaNdAraX+vECrHgyy5Bc4lEC0f2OzKixNaj0Ph9+Agy0PeFFQFqbddfGr8lLkXdF1UDyXV20Woo9V7S0YZ2Xbn3zwfQhnlYnMhkWT5IO3F059YviesMuQqggJR+RTzBNsc5Yvepg2qiXQUu2uM82PqgrzBtBLK8IYES1Bv9RahgbZUPq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2d56c451-2ff7-45ef-87f6-08d5a4895409
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d56c451-2ff7-45ef-87f6-08d5a4895409
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 17:33:26.9085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sure, I totally agree.
Sorry, I just wasn't clear enough in my previous email.
I meant that your patch suppresses "%s --> %s (%i MB)" line in case "fileSi=
ze" is not available,
while my patch suppresses just "(%i MB)" portion if the "fileSize" is not k=
nown.
In other words,
 * if "fileSize" is known:
 ** both yours and mine patches don't change existing behavior;
 * if "fileSize" is not known:
 ** your patch makes streamOneP4File() not print anything;
 ** my patch makes streamOneP4File() print "%s --> %s".

Hope, I'm clearer this time.
    =20
Thank you,
Andrey

From: Thandesha VK <thanvk@gmail.com>
> *I* think keeping the filesize info is better with --verbose option as
> that gives some clue about the file we are working on. What do you
> think?
> Script has similar checks of key existence at other places where it is
> looking for fileSize.
>=20
> On Tue, Apr 17, 2018 at 9:22 AM, Andrey Mazo <amazo@checkvideo.com> wrote=
:
>> Huh, I actually have a slightly different fix for the same issue.
>> It doesn't suppress the corresponding verbose output completely, but jus=
t removes the size information from it.
>>
>> Also, I'd mention that the workaround is trivial -- simply omit the "--v=
erbose" option.
>>
>> Andrey Mazo (1):
>>=A0=A0 git-p4: fix `sync --verbose` traceback due to 'fileSize'
>>
>>=A0 git-p4.py | 8 ++++++--
>>=A0 1 file changed, 6 insertions(+), 2 deletions(-)
>>
>>
>> base-commit: 468165c1d8a442994a825f3684528361727cd8c0
>> --
>> 2.16.1
>>
>=20
> --=20
> Thanks & Regards
> Thandesha VK | Cellphone +1 (703) 459-5386=
