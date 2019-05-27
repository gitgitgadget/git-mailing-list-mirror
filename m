Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2D61F462
	for <e@80x24.org>; Mon, 27 May 2019 10:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfE0KID (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 06:08:03 -0400
Received: from mx07-002aaa01.pphosted.com ([185.132.180.47]:29644 "EHLO
        mx07-002aaa01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbfE0KID (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 May 2019 06:08:03 -0400
Received: from pps.filterd (m0118689.ppops.net [127.0.0.1])
        by mx07-002aaa01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4R7xpCo001036
        for <git@vger.kernel.org>; Mon, 27 May 2019 08:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edenred.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=dk201811; bh=vTlWBtFlqXBlnxiBznGdU20onI4VXluMFpv7SjDIrLk=;
 b=1hR37vEffCMGv9hLFSVR8OrwtFDLKzMVtN3cL8Xn48kzN8tVg8lMb39eb0ESb44qAyHn
 KIF5QnxsZHUtZa5VDNh47KK/AQdirfEZD1xs+WXarHwzApzN3XQQXssRnLeagHjyym9l
 IMpc/zf1oy1YLvVXdDkQr/fXR9wAl/RbP5LqEleQaDAnQ5OSJkaCgN7bhdISafUnXTBA
 NIyVlrP4rCjvowjzEkV/qOvg1zd128RQTRXzMjy1W3aXRpcrK8YLunpoKs/E3W8Gf83G
 25dQyfV9VJ6glQW23vzqUkXj56QK9ZO3TLtHMoEuQqdC6541dJFaKHK9k+y0st+tigWy Rg== 
Received: from ehq-smtp-usr-p.edenred.com ([204.103.47.130])
        by mx07-002aaa01.pphosted.com with ESMTP id 2srb0p85cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Mon, 27 May 2019 08:01:16 +0000
Received: from ehq-smtp-usr-mx1p20-p.edenred.com () by
 ehq-smtp-usr-mx1p18-p.edenred.com () with  (TLS) id
 15.0.1395.4; Mon, 27 May 2019 10:01:16 +0200
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (104.47.6.51) by
 ehq-smtp-usr-mx1p20-p.edenred.com () with 
 (TLS) id 15.0.1395.4 via Frontend Transport; Mon, 27 May 2019 10:01:16 +0200
Received: from DB7PR05MB5573.eurprd05.prod.outlook.com (20.177.193.214) by
 DB7SPR01MB0019.eurprd05.prod.outlook.com (20.177.122.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.22; Mon, 27 May 2019 08:01:15 +0000
Received: from DB7PR05MB5573.eurprd05.prod.outlook.com
 ([fe80::d93a:e741:155:318d]) by DB7PR05MB5573.eurprd05.prod.outlook.com
 ([fe80::d93a:e741:155:318d%6]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 08:01:15 +0000
From:   LU Chuck <Chuck.LU@edenred.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "chuck.lu@qq.com" <chuck.lu@qq.com>
Subject: git filter-branch re-write history over a range of commits did
 notwork
Thread-Topic: git filter-branch re-write history over a range of commits did
 notwork
Thread-Index: AdUUYk+0TU9swc+jQ+aKfvGwOQfe0w==
Date:   Mon, 27 May 2019 08:01:15 +0000
Message-ID: <DB7PR05MB5573AD842E430342E2BD011B8D1D0@DB7PR05MB5573.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [140.207.1.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d39fb7e-6ba6-4157-cf66-08d6e2797e00
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB7SPR01MB0019;
x-ms-traffictypediagnostic: DB7SPR01MB0019:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <DB7SPR01MB001921784DC7AFCEB07CA2208D1D0@DB7SPR01MB0019.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(376002)(39860400002)(51874003)(189003)(199004)(76116006)(73956011)(53936002)(64756008)(68736007)(66946007)(6506007)(66446008)(2351001)(26005)(102836004)(486006)(99286004)(6306002)(9686003)(6436002)(5640700003)(14454004)(8936002)(476003)(25786009)(7696005)(55016002)(4326008)(3846002)(52536014)(6116002)(5660300002)(316002)(86362001)(305945005)(7736002)(186003)(81156014)(71200400001)(81166006)(2906002)(6916009)(8676002)(71190400001)(66556008)(66476007)(2501003)(66066001)(478600001)(33656002)(966005)(74316002)(72206003)(1730700003)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7SPR01MB0019;H:DB7PR05MB5573.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: edenred.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VxH15z/QKhKtQJjK8hTdqnQXKS0h1JNix2l9d4WbdxyT+FQgbuoYlEkhQwWNFM2aOpIh8ms/eC2op1MDKiB1RN5sujEyrrc2GUyoyrvS/vjenJp7eXDBUEcK7ajEqlSspi8/wUkWEye2i8L5rxdXvRczVlsvHEWM3ZOvnmpukVYkPhC7xDYvYnIEpnp8QF/MQ6oazT7Kn26dQlpVx7GIUzkzRCZc8vh/81VldjF7tJfxm9oQZ3abqI5DHCJQpQj3XnQ3IiyPeQuBkEu7gSRtbehs7hDcT1la9D8QPkVnrJuC11Dpusx6pTchiB1JxtJvY2wzKfbIQybeMHegVA25GIbf3T4AbQfRsNpSLmxByAAz8sZo48qFMOok4xeXuzc4m/0o1N+Z2J6xLfe1q1q/bzbQJippq6dV0qIS5r+8ZBc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d39fb7e-6ba6-4157-cf66-08d6e2797e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 08:01:15.1426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c1d9e0f-5c27-4228-a35a-de7b4083ff7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chuck.lu@edenred.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7SPR01MB0019
X-OriginatorOrg: edenred.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-27_05:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

    The issue comes from https://github.com/git-for-windows/git/issues/2206=
.

    I want to re-write history by filter-branch command over a range of com=
mits, but the command did not work.
    I have referred to the following three documentation about how to use g=
it filter-branch:
    https://stackoverflow.com/questions/15250070/running-filter-branch-over=
-a-range-of-commits
    https://stackoverflow.com/questions/28536980/git-change-commit-date-to-=
author-date
    https://git-scm.com/docs/git-filter-branch

    You can reproduce the problem by the following steps
    1. clone the repository https://github.com/chucklu/LeetCode/
    2. checkout to the temp branch
    3. run the command git filter-branch --env-filter 'export GIT_COMMITTER=
_DATE=3D"$GIT_AUTHOR_DATE"' ... 67d9d9..f70bf4
    4. You will got the info "Found nothing to rewrite"
=20
    However, it was supposed to overwrite the history from commit 9c1580 to=
 commit f70bf4, make the commit date same as date.
    I am not sure if I am using the filter-branch correctly, or if there is=
 a bug in git?

    Anyone can help me? Thanks in advance.

Chuck Lu
Regards
