Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC18F1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 09:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeIGOd5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 10:33:57 -0400
Received: from mail-eopbgr70102.outbound.protection.outlook.com ([40.107.7.102]:40460
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727985AbeIGOd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 10:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qtcompany.onmicrosoft.com; s=selector1-qt-io;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcrXukLanhOLXLP8o0NS8MN9rJzyI9lwmwKtfa+y/CA=;
 b=IOAreNaT0tyvDC2MAD9Zqr6Eya6a/B5zqtDRpDbtK/rZ6NoZWQqRbQGAuhVBuAesu4lcsdCEJB33OMS/VcF+2okGvYkm1Xr9gCMFekJwxcXN4ajauZOxfldjHyWyDi2h5mSUWrak4e2fAznRZDCv1qq8FRs4Oa4O3Dip4JiV4hU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Allan.Jensen@qt.io; 
Received: from twilight.localnet (62.220.2.194) by
 AM0PR0202MB3378.eurprd02.prod.outlook.com (2603:10a6:208:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Fri, 7 Sep
 2018 09:53:00 +0000
From:   Allan Sandfeld Jensen <allan.jensen@qt.io>
To:     git@vger.kernel.org
Subject: Old submodules broken in 2.19rc1 and 2.19rc2
Date:   Fri, 07 Sep 2018 11:52:58 +0200
Message-ID: <2659750.rG6xLiZASK@twilight>
Organization: The Qt Company
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [62.220.2.194]
X-ClientProxiedBy: AM6PR0402CA0012.eurprd04.prod.outlook.com
 (2603:10a6:209::25) To AM0PR0202MB3378.eurprd02.prod.outlook.com
 (2603:10a6:208:6::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b982b29-fecd-403c-fcca-08d614a7b22b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR0202MB3378;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0202MB3378;3:y4SfD2TpUF5k1q3HNd5q9GWpZXdjwAck7+jsfIpEYG1qVA4U+55huRvJlBWWMyOeIMcEo2/0WLHJdwvK/6/0UPuxfbbSvXS0twzY9gr1FpmrvQDd7DnsRwIZUmgZ2ygQ17t9YhnAOhgPPoLqJ4MOdIfwDkJIoyP+nrhlpdrz7+tV9rze/EXJvEMvuwBWLfi8rfK054MFfkpAt3eXbd1mWZAdKJXdvd4vRpb718K+sy0B2zUSWo3l7Bp3P/XW/TN/;25:QsQzcxSjLSaNadl/yPxLhEXnd9HO1KwgtYPLujc3cPvf68u38IugGU3MGugh2wZSQ8xDVMnh+nLvWnIQNaPeNjPvbDHOanIbwpPGKWu6bl4dkXiyjSGf0t5dKSt8t5jFfpRTyVw7tZ9+yjTJxaJyg4tceGJGq/I6vhXw32VNM9WjohUg83rvN/4ONjCmppLPsgsvJBDMa6pF9IytG9y6XZ4/b0YU/bDw84AgCC5rWneb0uLcwi2Jghkk/RMiOUTx+/+QxM15MYyNRwzSZpPcTBDbs0moADOWdhw4X4YI8o/98zXXRwdCVVq2mcZ2/wL3ETViOIHgcPv4oHibRElZqA==;31:bQDSNbV0d7JypHDhb9Sv92v2lDPsziCGwCg9nxtkoLaLQG4mKpjtWOwyWhOjSVnPJPK55Ne4J8Ws5qoZvWRjV4DYOy2kGf0nGZKoC0Hq0+s5JNG2ZiEoNjBJTdsD+48haiSRh+e+57NtdI/OCXozoClKnxs0IzZA1rahUmg5iyoFOYKTwGhovQAkD7FerQ4Cqdezo0bBFM6HwBPIg4aRIMcsk8U1xytxPFx6j6WD0pk=
X-MS-TrafficTypeDiagnostic: AM0PR0202MB3378:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0202MB3378;20:IM1yz4AgKB49Fst4/qZ2ho4fiXmA9cdTqv/BDpm4Bywl87F8KY2bzm//LcsSXDXkQ0SEEk2F4lWCv3wB3elv3zub6RVRQmC/dXja3USpG86YwntEBnfQ3U93u+9sy3HxGRNaTmT4654BDGHlZ/f0XSlJxgWMb3jf2XyT4rD6Z8GNsrxPubk3IEUQPF3lfswEfIbyeDYvPyHb65dDoi8b8ZJo3QxYN21D5CkXTZTgyx/n8VxOQS5b0VlJtZXTfrSCZ4RnlzC++c16JneRqvlio8STCyRiYYFuvDZ1cGg30xq8YaRnJ+Edc4S2drZ9HQZ3sNUUIXAyohbfqT+qBA/j96+W5mfN/C4VN7D0sOEjl7g9IWXE53Qty2nSTY8x2iiECDWnVRY3/QcdLbkzhokviZgaLFJNMPCR1+mc8kzooakXT75hUZt3jUTnTlAkSk3tu6RlLjRQf/alTYQXCupJobSjewSzqz++k7ThOxTq8shApivfTD21M3h0eg4YXQQ/;4:/jQX4rLMYwXCtJbUCpEa3pyrNPoZ97Lnt5pFGQrMb55z5DXOcwzjF2m6LorIcuYmFNwbQfszIEj/8HnaAg5jSCe5OoRTOE9iNq6S5XZZ/ntksaLxfUfqVcHnBPmndtehlhTGZHZ/PfkfbvjB10olzIlF88CzDxPtgkUlbY2+EHGAY3Xr5d5wiLW/l4GyXfWNxgg4PDEwYv5DDVQnts8f8c8cp1DguhcNdvSfANBe0wTc08FwbTOVFcPHyyTM00aGL9KDvvwRTddH6gePlEonSQ==
X-Microsoft-Antispam-PRVS: <AM0PR0202MB3378B55774766E40B34328608E000@AM0PR0202MB3378.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:AM0PR0202MB3378;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0202MB3378;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39850400004)(366004)(396003)(376002)(189003)(199004)(6916009)(105586002)(5660300001)(72206003)(26005)(6506007)(386003)(230700001)(2906002)(106356001)(68736007)(486006)(33716001)(46406003)(7736002)(3846002)(476003)(305945005)(956004)(66066001)(8936002)(6486002)(81156014)(81166006)(47776003)(86362001)(25786009)(6116002)(316002)(52116002)(6512007)(9686003)(53936002)(74482002)(2361001)(8676002)(97756001)(36916002)(14444005)(478600001)(16526019)(23726003)(50466002)(33896004)(97736004)(2351001)(186003)(39026011);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR0202MB3378;H:twilight.localnet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: qt.io does not designate permitted
 sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0202MB3378;23:ObmgMEKfv/KS97bWn0Cl2RoQALAb/oyHIf2Wc/w?=
 =?us-ascii?Q?CLHtcG0KLtedWV6INUCsF4Q4JE2u4Qx9Z4ySi8pk0WOvwBl8lyOdE5wWNHj7?=
 =?us-ascii?Q?g0J6aS8p8AntY3b+okTaGR8+v4zKrHqfafWrVjquUaX9NMaZ99CMd4OWYKrx?=
 =?us-ascii?Q?Jcx+Nsz1AVnpYoOmALjnJcHduevu5xcZQ2tvD1d+tj5HpmkQOEvH+eCMQN++?=
 =?us-ascii?Q?gM/EpGbDfczWyS9+Pa0FpT7gxjeysSrzLTvARF/XxkdZabp+zbesSL46TpKQ?=
 =?us-ascii?Q?nLf6LDsQgbf+OBvoTFv/OoN0xRqLFHQUcDfM5Co3JJCz8bRFkfYDZSJJ+4ax?=
 =?us-ascii?Q?c/7WmXUOWAW+xDZsS2MATyWjRI28lnVD89bbmwPQr99PSlZF7bCuGCQFxgqM?=
 =?us-ascii?Q?L/SyEIF+Ihie/AwNlslAQjp8mgmRecWi+dh5JX6t9yRnXA29VYzv5QD/lgRG?=
 =?us-ascii?Q?JtN9yi/i7zOxxD2i7NhJ5CksFBjev5rbDPEHuo2Q03KVHGXcAGWxhdj2XpxS?=
 =?us-ascii?Q?wPedr1UDtdNNSPQfjYAxkZsMewfR/YaWtMkdt1HGOdfPQmxDztC9uVipt5gJ?=
 =?us-ascii?Q?rnUn052BZkGpTzsws5g+MmFYPwV5qMDZ+xyQvS4DEj/Gp8CvcVL2b8/k44j4?=
 =?us-ascii?Q?yhR/kMQYKeMmkokLSf1tg20dsc+t7xy4qdknWdvF1qCdykA6+9TeQb+6u5H1?=
 =?us-ascii?Q?1MJjSCFhAom0HTgPjZEj3J84RLDEOkboU5URia5yNCxB9l5MigREBqSX30KN?=
 =?us-ascii?Q?bUI32PtwES+rFsl80ZMiDC68EyX1buyfx9GatRaLWLW5FWQcJKmtH3HwCu7+?=
 =?us-ascii?Q?Qpo71eKMhHvj2i4SH825zrfWQtUnevnKRLsLILDuITRNcda09Va7Oed7S4rr?=
 =?us-ascii?Q?yM6si4G6NUzctR6q7rHgAN3pP0BE4Ldllgq7Xd5TKQZL2kC0SeTnnUKL273v?=
 =?us-ascii?Q?DZFDdDwUbSJKQObJCpEZO1PSeYFAhk7DKQLvT1OriH5qONVAKMdcef+QwBXz?=
 =?us-ascii?Q?S3kZk1TPueG1tRd6VxJIKffx0WEe6gnhhbujrkZINziJV6nvFUKpEAv+x5tV?=
 =?us-ascii?Q?GYF5NhQ6lq4Vzhz/LpDzXDanF1zH7stk52todnEc6Ol5G89IZK+QIT2M7TZZ?=
 =?us-ascii?Q?6wfMDoYqjWdV3y0cd8JlxPngyqoTSBUOxwBuG/llAghvW8/jLhzZq53VTGag?=
 =?us-ascii?Q?ptVXfwCLd1mLhUglyicBnchHWl3I3SnSlq17nRC+0vIgpYApsaHVR7GnANPQ?=
 =?us-ascii?Q?k1Q621P0NOhqQk1YjLbk=3D?=
X-Microsoft-Antispam-Message-Info: fcMey2tsxgrex3NCoEghv1MKgazHphjXBl5CBeNdiLF7MVAnwEVZb7e7KJp96e3ASwkcn7CeNt0MmwyYZE3t2BosG7A+cpDpq/koKAR2JmPaBrQoSala9Z5XLptoQ3ZuMXRBEUItJqR8JXF34N0rvx8i7qW46MzG3DdoX4jJ648TdCEhHBEE5aok2+lnxv0QjxcCHJ1mtNNVMKic2LxoqletKQ1NAf+TL0y9opciZMPWTFxiuQbxt/DIuPqVswaOHUpb7wG6AQkQU1tyCzpWjRY2fA6PGQE8lTAhsMPGfZWYBGUJ392HPpXZYABokri9k+zK84c5kMkrTL9xSOAt1ghqEvDIxq4oauJbD2FLNcw=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0202MB3378;6:8eOnQeYaIms4X3MlSIQRiy28RV7JfrY4Tq5xFBbQKz7ThiJb+QzlWKIrHg0brRTeSGJBzLcVCVtAdhptoHsv43KRm1vVynKkAmyXW0Jx95Smr3pxAIlO4aR3rw2iGI3kNlIZ19bG/jWjS0lfV0H0tIEwBUSM27A9HiuHJGcM8wd5akNxueynPbYK6Koi+KPnd3O6gaBB8tlIbYayIUw4MMsOqEPCi+Pgp/IZeXOH0iGtSUmY40o+4jtA039ZpQ+/yvjM0JqLuM24fevrbOUyFIQGA7bdkbKtaCPYqeZIZzUBDQMJxJ3GWzL2guvHOK9l9cb3LvSf18pPA1VgKXa+hOo7LxmP1juzAXqsBZpgPbgfNOEGdykgMDBu1ffjiHTeDuPIsozLDlLO+RVpMOGzOYQGqqvmtZ3+pRDmaert7myXt5IPaSzmXXlPfofp1IQfpGIbkghwqawuFI5/2nSCxA==;5:/arb9MGYEoLQRL7sJQeloOrGOIYUq86w5w/UtnKFTQmVIjfGbAX3isJxKU5rjJ2RcmRQgJekOTh459gMwNxI3sPvxetvo1b2mradPZjMzKjJ7ubCzI8ClqFQEU44GHkME9iiUQF83oec+dW9CriKzQkWRA5bZcskFqsZJHbSB68=;7:+KS26E9avCyYJ4FJL6zQ6nESQUK8FoKv/3Gm3acJ6DbggVu1p2QIns7LdcThj3LC5cRzc2HwXcimcgP95fg2VPppcQv0E9nEMfKTUkJwdveHKN5ChnCYgYi4T+1dzTA4Cm2utwoJGNywCVhgXjduCjH9RBH7xRdhQUVkeNrV0gNs927BPJypuVmRNVWwGT83+H5aKDutvsPeoI0VaNcA87kYAx2KqQohflQIgIHzxdPhJcVVs95kg4Eo7pWH3QoP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: qt.io
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 09:53:00.0200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b982b29-fecd-403c-fcca-08d614a7b22b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 20d0b167-794d-448a-9d01-aaeccc1124ac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0202MB3378
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodules checked out with older versions of git not longer works in the 
latest 2.19 releases. A "git submodule update --recursive" command wil fail 
for each submodule with a line saying "fatal: could not open 
'<submodule>/.git' for writing> Is a directory.

I checked the release notes so far, and they do not say the old submodules 
from git 2.16- were no longer supported, so I assume it is a bug?

'Allan


