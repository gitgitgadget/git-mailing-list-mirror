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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FF391F609
	for <e@80x24.org>; Mon, 27 May 2019 08:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfE0IMD (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 04:12:03 -0400
Received: from mx07-002aaa01.pphosted.com ([185.132.180.47]:51304 "EHLO
        mx07-002aaa01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbfE0IMD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 May 2019 04:12:03 -0400
X-Greylist: delayed 643 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 May 2019 04:12:01 EDT
Received: from pps.filterd (m0118689.ppops.net [127.0.0.1])
        by mx07-002aaa01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4R8AdPJ011131
        for <git@vger.kernel.org>; Mon, 27 May 2019 08:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edenred.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=dk201811; bh=MEo5ia88qDQh/yJRkpggsCANnuR/iR7u9yeY3NC+xm8=;
 b=WVp3bQah4A0rW3ppCR6xuekrPdEnR6LUA4kTodKtiYjidlpPTz1ixYoIdjN5Jw6MXSa8
 gmTO7sDMuYU72QHfZL6jSPoZdeRuTS7fdbPqQkbE+ubBDk0DCckKayE/UZ4ArSnSYnaW
 X97CT07LlqgUoyopvWP6fiX/yJ9LoFNx6G1DkzD6a3+phZp6yK8gB3JU5rnx7YR7rodg
 lwyN/gQN/6s7RSWNfC7anT1AevEkeNIgNHohTtipTpCRSpldjdrQqO6kRwKYDsKqckeV
 57ZmMtpkMkUGi6aZ0K1uBTS3WzwMwxVUExh9J5w17SDvI3cwk0FU3fY6RfsY9dgKauRY bw== 
Received: from ehq-smtp-usr-p.edenred.com ([204.103.47.130])
        by mx07-002aaa01.pphosted.com with ESMTP id 2srb0p869x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Mon, 27 May 2019 08:12:00 +0000
Received: from ehq-smtp-usr-mx1p16-p.edenred.com () by
 ehq-smtp-usr-mx1p18-p.edenred.com () with  (TLS) id
 15.0.1395.4; Mon, 27 May 2019 10:11:59 +0200
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (104.47.9.50) by
 ehq-smtp-usr-mx1p16-p.edenred.com () with  (TLS) id 15.0.1395.4
 via Frontend Transport; Mon, 27 May 2019 10:11:59 +0200
Received: from DB7PR05MB5573.eurprd05.prod.outlook.com (20.177.193.214) by
 DB7PR05MB5244.eurprd05.prod.outlook.com (20.178.42.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 27 May 2019 08:11:58 +0000
Received: from DB7PR05MB5573.eurprd05.prod.outlook.com
 ([fe80::d93a:e741:155:318d]) by DB7PR05MB5573.eurprd05.prod.outlook.com
 ([fe80::d93a:e741:155:318d%6]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 08:11:58 +0000
From:   LU Chuck <Chuck.LU@edenred.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "chuck.lu@qq.com" <chuck.lu@qq.com>
Subject: git filter-branch re-write history over a range of commits did
 notwork
Thread-Topic: git filter-branch re-write history over a range of commits did
 notwork
Thread-Index: AdUUY86HV9UtTJXpQ5+zoyZPh7s07A==
Date:   Mon, 27 May 2019 08:11:58 +0000
Message-ID: <DB7PR05MB5573349C498A5680A5133F1A8D1D0@DB7PR05MB5573.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [140.207.1.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f19ad00-2091-4be5-85b1-08d6e27afd6b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR05MB5244;
x-ms-traffictypediagnostic: DB7PR05MB5244:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <DB7PR05MB52446B72A3A6958DCCA2E5688D1D0@DB7PR05MB5244.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(396003)(366004)(51874003)(199004)(189003)(33656002)(8936002)(66066001)(6436002)(71200400001)(102836004)(81166006)(8676002)(1730700003)(52536014)(71190400001)(53936002)(6306002)(76116006)(5640700003)(99286004)(966005)(9686003)(2351001)(6506007)(2906002)(81156014)(256004)(73956011)(66476007)(66556008)(64756008)(66446008)(66946007)(4326008)(74316002)(6116002)(3846002)(14454004)(55016002)(316002)(486006)(25786009)(186003)(305945005)(68736007)(478600001)(7696005)(72206003)(476003)(7736002)(86362001)(6916009)(26005)(2501003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR05MB5244;H:DB7PR05MB5573.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: edenred.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q/PPOfV175DCgbIA4Ai5TqNr33gFQXtWKVRegDQ2aXZOAf2aub3I9RoNmAimU1hivmgWT67ctMXOyS/ear0RoWOziXqPHhfatNHk1p64RUOnQp1VAU+X+g4TtreZJTxaQhBTAZSqCmHRyOuUvy2Xo5RPVKWenB62fCsgfUvmhyYw6MWGciJojmIIXLf7N4zJxWOvNNeiWzZ6SG2cOJqRRywah2l3bCcfGin5RUSgsSGxuvyaUZDSYqz9GcoMD3ux2GY1XeR2PXLIDRHa6yKxoy5krh8YYRR1S8N4FTQkgUptlcltTbNF2yX/PuuxFeeUignVcCasztfTmlNGVh69OGvx3/Nd/HyHQOB6DDYy3HYS4YCm+uS1vusl+kk0n7/ICiNVo0KERiF2xt/H0k0PANMd/Z+oenUYYI+Wj4teH24=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f19ad00-2091-4be5-85b1-08d6e27afd6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 08:11:58.3554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c1d9e0f-5c27-4228-a35a-de7b4083ff7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5244
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

=20

    I want to re-write history by filter-branch command over a range of com=
mits, but the command did not work.

    I have referred to the following three documentation about how to use g=
it filter-branch:

    https://stackoverflow.com/questions/15250070/running-filter-branch-over=
-a-range-of-commits

    https://stackoverflow.com/questions/28536980/git-change-commit-date-to-=
author-date

    https://git-scm.com/docs/git-filter-branch

=20

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

=20

   Anyone can help me? Thanks in advance.

=20

Chuck Lu

Regards
