Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823CFC433F5
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 08:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E9BB61075
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 08:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhKMIgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 03:36:21 -0500
Received: from mail-eopbgr1320118.outbound.protection.outlook.com ([40.107.132.118]:56189
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230095AbhKMIgU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 03:36:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPz7OjHFyjOxQWnQzB5VUOZ6hvfJ4qaKaIQfoEauDrOCDXQ+y+cSrTJODRa6/YLe+QklYs+YTA5T0ypnChKou9H4mT7VEN3c3NRkUYmSFMbI1xomjHeF6wSfZdU2ROM7T0nDM4y51+5PSDxrePNVaD+K9JPWadpO4i6Tf21yKOn4zzyXtLoMDNoOsug9FkjzYrWINjIEtUfOZjlnEzGVqbiIl246/tt2PuiqTo16sT+Vdj5oTmIsgEa5TAR1OxK8o0mktKhUwNQLy7dkhQONFwgaMFBXFJ7Zth9kpYMxMq2CPrk9aESJyu+eq53Rs7T1WphHNo5IwYWftdNefhPsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OK2ZMnCOYnPnS54wVo2JXZGgFfl7pjC2gSp+IoVqAg8=;
 b=Vw1MGzRNz4agQCcOxtBCn9D7dt5kyHVT026HCr7jvvhlLuH/9YSxVsmSyb9I34js3ixN03vaWabsO+/OJzLF1CMlu6ESDksowhkoAUlRyP6dn+ajqaQ5FjUDkiMRxiDt20k7jvwg0fASul40B3gfmwJNrTPynCq5vK7+aM0VrlVHL3YIAquJH6wX6YWZFQaVezvuDlF4h/ST/yXXmdk2O6HIQnIK4ayI1E/BXZ6bGPEykRb7JzsbPDneREJHrH6uIfWM/s1q0qMGL4TwfKc5Tm6NbPFokrtXQcJmVcwsNSYmuSa3loJinBgurR5w7hntzdiBWKhXZGVz92WpTNjg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=u.nus.edu; dmarc=pass action=none header.from=u.nus.edu;
 dkim=pass header.d=u.nus.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nusu.onmicrosoft.com;
 s=selector1-nusu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OK2ZMnCOYnPnS54wVo2JXZGgFfl7pjC2gSp+IoVqAg8=;
 b=DFxeVGjTU6KUGVGQSDfJxAtQyyNWUCpGQjePgHfICcQPiPrlK9DGQ6tXE0Jov5R26w0E5bdZKzXw7gu7wl92LV5+OCyCfto5P2p+4ycZvrNBvZSo2RjthvM27UCr3dXDJL/uWiTEow0f4XfFqmUssRBaf64nSbIeb9eb80MQuGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=u.nus.edu;
Received: from TY2PR06MB3056.apcprd06.prod.outlook.com (2603:1096:404:a0::20)
 by TY2PR06MB3391.apcprd06.prod.outlook.com (2603:1096:404:97::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Sat, 13 Nov
 2021 08:33:27 +0000
Received: from TY2PR06MB3056.apcprd06.prod.outlook.com
 ([fe80::d867:20cb:7dab:ab1c]) by TY2PR06MB3056.apcprd06.prod.outlook.com
 ([fe80::d867:20cb:7dab:ab1c%5]) with mapi id 15.20.4669.015; Sat, 13 Nov 2021
 08:33:27 +0000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Deng Kaisheng <kaisheng.deng@u.nus.edu>
Date:   Sat, 13 Nov 2021 16:33:24 +0800
Subject: Anything I can contribute?
Message-Id: <AF2AC77C-EA0B-468B-9B31-24CCC3DF70A3@u.nus.edu>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (18F72)
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To TY2PR06MB3056.apcprd06.prod.outlook.com
 (2603:1096:404:a0::20)
MIME-Version: 1.0
Received: from smtpclient.apple (2401:7400:6004:e7db:d8c3:f270:6738:18b2) by SI2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15 via Frontend Transport; Sat, 13 Nov 2021 08:33:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fef91428-3d09-44ad-9409-08d9a680437f
X-MS-TrafficTypeDiagnostic: TY2PR06MB3391:
X-Microsoft-Antispam-PRVS: <TY2PR06MB33919EAD40B7A18FCC9FF7A4A1969@TY2PR06MB3391.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QvZn259mlJOB7zkjOQDoLottfCiUQUxCacO/t0hpvUS+qQnQ20djLX0lXIj9Op1JDElf4YFl8/HxDQwi20S0GguFLS7o6rlt61KSTZbCSHwGBJIwXuS+41JQo8HOGsFYg3RWrK0acizZnjwzHIzM67UjjA5vN5B2znttrqSVeZP7HYBI2HdubknOhxkWl629uEXZfuugXfnMaTzSePrBeWhiSfuzZmY4wdvUpEwhwfm1rTVinA396buyMmVY/7yGq6FhibXoJyW3tI7lDIoSlokCJh+7lt8fa4IAnF1tYsxJYp0UO2Rp/K/wr4K1coxkHqJxDKGrojC+TyUPVrgdiQ63Or5wRQOjcZjjB3U9zqApXNEfczLoTgnZ1ulmlN/y+EXyEdfypXf5nuw/mtiJ5CtvLFhB5ooEaMoZ4e7mVObz5C7tMaa+WXCT9mkSQTegoUX+CQ8wJidWG1SLDeUjc9QAewbA4fK+8PRMJ+Y5YlsKYyFNp0cNo/8Nini73s9+ot8RCcZKvzUe253oZj++ZquwZKKwQChEviruQvIt0TW4Hyuckjpljld6abxfgHqS/Obt3t+Kc3NZbyh9IzcG9SNNneKP5mA/PcDode/9mLYFbmN6XarGrIm0OCnDrmRJKYxCQyn0YeWs/zq/pS5KelmftdlLAdoRb0zgLKc9ggTgocZF5kRbYf5C3IcQ56VMJInOuQaTAQhtcdq2YQ//vdB1VbKHq9Pr3smsVpwR8B8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3056.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(6486002)(508600001)(52116002)(316002)(786003)(6916009)(8936002)(5660300002)(186003)(38100700002)(8676002)(86362001)(75432002)(6506007)(3480700007)(66476007)(2906002)(66556008)(2616005)(4744005)(33656002)(66946007)(45980500001)(36394004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TUv5eaKZYBWUwYN8hBvnCNdENz1vWafsZ41AOgSM4MMDF8dSqSdLfw9d4emN?=
 =?us-ascii?Q?Sapa+dqY1335u3s+XjiWmILNMkZ7m9m+52o5cj9rIPeF5rPO0aRDEXnZXlTH?=
 =?us-ascii?Q?7yWHrBxyEpeiGjpx8WAewx6C1afj/E9Tm5EZGhOQPao1a12M505712qubBBx?=
 =?us-ascii?Q?9Lct1oqSJjIF75JWon7APB+Q5IfDtjWovjWaztonCgfPWQNWAl4Is6rNIf51?=
 =?us-ascii?Q?vWxBtwqtZ7kqGmVBtKeRxDE+P0M7BE72XCf1g0Lbr+rgfJy1Ao6lLOMteiYN?=
 =?us-ascii?Q?r7PY6utm/qHmEfrvr8HjIrNFpdqzRyEoCiNFErdhA8a8mfSqETTmmXHGU23l?=
 =?us-ascii?Q?Osqg3ggDZ0QHj0L7LxVHTiAUQXpJSpJ34NTnaSNMyu9iMQYHL+EEbQ55FE/4?=
 =?us-ascii?Q?w38asIvcTDoFCtBfTbeNCyBpa2v7XEGM/PM4X4YUcfTLP5Pyf4jCXOm/saZF?=
 =?us-ascii?Q?gzCniOvIA/1i0zqpAhl7gLsUA+K2gCnRa1koIoCZ9PNJr6p/dnc8Qa24a79i?=
 =?us-ascii?Q?AwX2wx/GyeGYqQnL36muI4Po6kzHBeEVfq/6jP9OZZGZq9a41b0fkRWeBYQh?=
 =?us-ascii?Q?MfR++qpFgxzskYUT//JjE45DH1e2DYxjjXcLdEksWLjIrO1uomXr8M0/Z9oB?=
 =?us-ascii?Q?6FNpipY4Q51hbWUz0mYAqenlexBxpEYsRe/iounIqZnT++ENkau35ZLqJmn0?=
 =?us-ascii?Q?cNwLT5GLcIIhH8u+ubgNlgEnsaehwIu4Uq6b178emnNuvvTcYq9nAfSDPga6?=
 =?us-ascii?Q?rJxfYex2ChrREHeKR59xmJC6bbX/8ajm0hBCZq1ERoWZObVccHYq0NGO4k+l?=
 =?us-ascii?Q?8OH0aOmdXijxWn+H9VaYuOkSGGZlA6tZdAKurNQvJUh7icZEKyNkUC2l/wRU?=
 =?us-ascii?Q?tr8I0MWVC/a7lNn5r4W5npO0U2ZLp4lWDJsQj/vvWPIfYjJUEcPn7tgpF0uK?=
 =?us-ascii?Q?LAKvLjrMkoVUAxeDHpyuZPW7naNormEwDKXbnGTG4L2OVkCMhRF5piVXXQ9a?=
 =?us-ascii?Q?H0cwa9PBWx8soH4bQGwmYpNzaL+CkU5pYRUSUxJWM3ICdaeNcsywuFqI5UBC?=
 =?us-ascii?Q?aZF/H7qvAj0An05sDPMEvH6qyLMlC0sI+2Pi0vbFGVkqOzFQ+XgKTvqS9mtc?=
 =?us-ascii?Q?Ml+iU6XXC3obPgg0ZA7KnSet2UKJ41wTSMMlQLNyK436UuoQB0YRHcg/jQL4?=
 =?us-ascii?Q?Fyrw1Z9MQPy8DSmSCs58zDwu88JQNu2fe8AaScqKmomWOYLVFerWAAg9tfpv?=
 =?us-ascii?Q?mIVIfdnVPRbQCxoVDnflFS3o1KE3Tz73bpqKJhurlBha4qryfvlrCF+Ohf1e?=
 =?us-ascii?Q?GfDXo2WEcCjXVtPtIfIkmvz6B62b+bg0JwXzb1ilNglEOs6NIEJH0IER1cDW?=
 =?us-ascii?Q?JyntFmWDIKZbFwjDkNTu9EVJqrwUB4rJK9RziBeX9cJfyHYRlCpP6YqxKiZk?=
 =?us-ascii?Q?7xQg8bW/ekuhBNshANDTYSyRk+Q9KaiqyQFELVdN6/3UYvGufqCblxPv7yta?=
 =?us-ascii?Q?PA/M4Axj1IdlnSyMSLHjFsgJ3kPLOQO3qCJvG0mp/bmSPV/Lc13/bf5ZSxuj?=
 =?us-ascii?Q?IpiDsvs/ADlJPElD/eLw70Ec5/rXLXBidP0NuoOwG4o6H7RYgz1jGo01rQlh?=
 =?us-ascii?Q?Trc9BmrtH+tOUztwC3pXArW61k70qRJxPPlW6dO3RXd3oHXrXoaJ0oIaVW3p?=
 =?us-ascii?Q?/uFMxjSx5VTRdRYX7VNQ9TS4Gm8=3D?=
X-OriginatorOrg: u.nus.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fef91428-3d09-44ad-9409-08d9a680437f
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3056.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2021 08:33:26.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5ba5ef5e-3109-4e77-85bd-cfeb0d347e82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYWbygBppJw5/aRUSRtssyM0klQbVWSFwvhKaFVX0IbTulj8cVpxIKDBcBbrSyrGjdM1UVb+NdK1tUcX5bA9aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3391
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

My name is Deng Kaisheng, a graduate student in National University of Sina=
pore (NUS) now major in computer science. I've read the introduction of you=
r organization and I'm quite interested in what you're doing.

I want to do something and contribute to the community, and I wonder if the=
re is something I can do. I major in computer science since undergraduate w=
ith a solid foundation in CS, and I'm also confident in my fast-learning sk=
ills. I have programming skills in C++, Python, Java, Objective-C, etc., an=
d database skills in MySQL and Cassandra.=20

I wonder if your organization is going to take part in the GSoC 2022, if po=
ssible, I would like to contribute to your project in GSOC 2022.

I am looking forward to your reply!

Best regards,

Kaisheng=
