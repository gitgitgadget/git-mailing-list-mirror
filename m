Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9E431F42D
	for <e@80x24.org>; Wed, 23 May 2018 19:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934242AbeEWTip (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 15:38:45 -0400
Received: from mail-sn1nam01on0125.outbound.protection.outlook.com ([104.47.32.125]:21408
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934223AbeEWTio (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 15:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oHcW8flYNdO2wk+l4hc93bYcg3liLCCy5hTpQwy2k4=;
 b=E4agwQsWZ80W4KZKwjtVqElgaYhRsUiOjyELX6rHq+ugK2CERayBfa001eAKEelm1lQ1Jp+llk01G0ykGhvq5h34BWE9qtyxvMffp22zwRZtK61y8gUiWi4dmZQbLIItuQ+n9SBWnX0HmJ4giDeey3eecqzBnEDpBtppWesuzFg=
Received: from BYAPR08MB3845.namprd08.prod.outlook.com (52.135.193.27) by
 BYAPR08MB3847.namprd08.prod.outlook.com (52.135.193.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.776.11; Wed, 23 May 2018 19:38:41 +0000
Received: from BYAPR08MB3845.namprd08.prod.outlook.com
 ([fe80::5d83:1086:8c95:496]) by BYAPR08MB3845.namprd08.prod.outlook.com
 ([fe80::5d83:1086:8c95:496%13]) with mapi id 15.20.0776.015; Wed, 23 May 2018
 19:38:41 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     Luke Diamand <luke@diamand.org>
CC:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        "Romain Merland" <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        "Lars Schneider" <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Subject: Re: [PATCH 1/1] git-p4: unshelve: use action==add instead of
 rev==none
Thread-Topic: [PATCH 1/1] git-p4: unshelve: use action==add instead of
 rev==none
Thread-Index: AQHT8airjeXQ5f01pkuKAZVmKCNFT6Q7iFGAgAAup4CAANq2qIAA78JdgAAvToCAAAPhQQ==
Date:   Wed, 23 May 2018 19:38:41 +0000
Message-ID: <BYAPR08MB38455AFE85AE6B04EB31EF92DA6B0@BYAPR08MB3845.namprd08.prod.outlook.com>
References: <20180522084109.29787-1-luke@diamand.org>
 <20180522084109.29787-2-luke@diamand.org>
 <CAM0VKjkdGByfTtj5cunUzqeneu4Bi8Qw4vj428zV1h3ezHXyQg@mail.gmail.com>
 <CAE5ih79_Ai8F48zFpJ09e8saGrySoiyVdsgkk8ZpRrQAd15a4g@mail.gmail.com>
 <xmqqk1rvw2i1.fsf@gitster-ct.c.googlers.com>
 <BYAPR08MB38451D101964D3B4D10436EBDA6B0@BYAPR08MB3845.namprd08.prod.outlook.com>,<CAE5ih79RoyA87gsb8PTOz9n1niTU5tDM_WkzbpFADS1d00h8eQ@mail.gmail.com>
In-Reply-To: <CAE5ih79RoyA87gsb8PTOz9n1niTU5tDM_WkzbpFADS1d00h8eQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB3847;7:JZn9mlOfi9gC6VKjVH4myfRcXhgP7qPekL/60eB7iKXsvYHSAV60iM7IQE4jUh9yoN1woP4e5kN2wCPwCsVdFKb3Z4v0J3QDGJg/NzYe3s7XPLZQ+nN+//WIFUtzTb7LWMR1MG8wqGcIlhIxO0vLVHmbFCAQ9GYYwZJQgWQz0HdV46UBmvEuLGNeyC3skVq7a46SKY9wfNTMhtC5M/4OB1QjtiugAJdUULy95ctS7YxkZIRziTo20qMZTIDkYlfy
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB3847;
x-ms-traffictypediagnostic: BYAPR08MB3847:
x-microsoft-antispam-prvs: <BYAPR08MB3847534BC007BBBDC2B9EC65DA6B0@BYAPR08MB3847.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB3847;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB3847;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(55674003)(199004)(189003)(6306002)(186003)(2900100001)(102836004)(478600001)(25786009)(5250100002)(26005)(5660300001)(39060400002)(7696005)(575784001)(99286004)(55016002)(76176011)(6246003)(4326008)(9686003)(53936002)(74316002)(86362001)(966005)(8656006)(229853002)(33656002)(3846002)(6116002)(66066001)(7736002)(97736004)(476003)(6506007)(8936002)(6916009)(81156014)(446003)(2906002)(11346002)(316002)(54906003)(6436002)(68736007)(3660700001)(105586002)(106356001)(3280700002)(14454004)(305945005)(486006)(8676002)(93886005)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB3847;H:BYAPR08MB3845.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4sJimvuTbbwrCgijNhkUKcuVDoezROeJPUHbmbNe1m2qGKqCNqWr2sZDPN4AU++JRurWIeIfw8IwFpQSNj1yKNbuSMq8s6IZYrgIlbQ97SJNmjdSEEsMhDGr4L83aR2JNv5Vr9gpcXfIpXkyrBaT6l2FrnzWz089mfto4U6kTDDQVzvCG/l+WKUqxd7kRVW+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 67facc99-f59e-4cdf-4632-08d5c0e4c9b9
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67facc99-f59e-4cdf-4632-08d5c0e4c9b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 19:38:41.1138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB3847
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> This was actually discussed in a separate thread [1] some time ago with =
patches proposed by Thandesha and me.
>> I haven't yet got time to cook a final patch, which addresses both Thand=
esha's and mine use-cases though,
>> so this wasn't submitted to Junio yet.
>> In the meantime, I guess, one of the patches [2] from that thread can be=
 taken as is.
>>
>> [1] "[BUG] git p4 clone fails when p4 sizes does not return 'fileSize' k=
ey"
>>=A0=A0=A0=A0=A0=A0  https://public-inbox.org/git/CAJJpmi-pLb4Qcka5aLKXA8B=
1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com/t/#mee2ec50a40242089741f808f0621=
4a44278055b3
>> [2] "[PATCH 1/1] git-p4: fix `sync --verbose` traceback due to 'fileSize=
'"
>>=A0=A0=A0=A0=A0=A0  https://public-inbox.org/git/2e2b2add4e4fffa4228b8ab9=
f6cd47fa9bf25207.1523981210.git.amazo@checkvideo.com/
>
> Should I re-roll my patch without this change then?
If it's the question to me, then I'm fine either way -- I can rebase my cha=
nges easily.
However, re-rolling your patch would probably make the aforementioned fileS=
ize patch apply cleanly to both maint and master branches.


Thank you,
Andrey Mazo=
