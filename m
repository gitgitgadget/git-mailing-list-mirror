Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57B31F404
	for <e@80x24.org>; Wed, 14 Feb 2018 15:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031659AbeBNPmB (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 10:42:01 -0500
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:51584
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031640AbeBNPl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 10:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NLOWDBRp0nnylq20psOmkeDHWaLX0m3+lhD8p9jQ6CM=;
 b=DMkrBPNBigt2zaOIGwgHp8w3Gvded1i9Clk+i3DefGkNP1kns449trpCh6dWicJFaW5wsCuAjd1ab6rl4+osJBwb2BBo3fsoIUGjzQ3rVUiKoMLjZGbVcSFvAiyU3Ty7KDhAJG+EzIc9yNKDQcZeok6WIU+O35BFOTTFP1quxAE=
Received: from localhost.localdomain (70.33.148.227) by
 DM5PR2101MB0902.namprd21.prod.outlook.com (2603:10b6:4:a7::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.527.2; Wed, 14 Feb 2018 15:41:57 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1] fsmonitor: update documentation to remove reference to invalid config settings
Date:   Wed, 14 Feb 2018 10:41:30 -0500
Message-Id: <20180214154130.111708-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.15.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [70.33.148.227]
X-ClientProxiedBy: BN6PR08CA0096.namprd08.prod.outlook.com
 (2603:10b6:404:b6::34) To DM5PR2101MB0902.namprd21.prod.outlook.com
 (2603:10b6:4:a7::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b9106c9-ee14-4ffd-a069-08d573c17b0e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:DM5PR2101MB0902;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB0902;3:M7eYn4GHiXKWqVMLz/vqrpq9zKI30LtPJeds52WTRxoZLGXwi2W28xHjYIeq1GzlozcRDsq2B1aKxZjeVTkI4y6PdhPXkzdLH4ceRBGV0TpSDCWgCLVj/4SUOwfOxigF2lfz/TuSpWQbQ/5JPNwW/HYVWG7tb4Sv/qOwmlgflhEmIZvNdTMUQLj2smyUDBgQ/DdOO28xbfiD/tWdeILdT4sJI0Lcg4jaJAY72rUNXrudoCzRMMIADRAwATv64cIZ;25:4o0BImlmJlIQvApj08ocMA3ygWwz7SU5f/I6G3LfmN79A1nki3ymbwd2rdQS1kQxv4LU8kK+W2orYdQGV4a0GC5+969mlbhZ9vgYDKgTzzz5pSFul1gSPxkSDNXTmVWTTREtAWdi055OkuYtbvUEfPQuOZbv2ylMhWIPHBnKd5MXXa35BMDB5a836QaZf6JrMnudUluhdDn6NXSJolh/LSIiV7o+8sjuHkBDfexm9050O3wQ/gN736PRRzmiOTZxmsbvlueYdg1RN5gBhj09xC3Q9ErLgtQ3OYJepp5kzL+SRLPY7p/a/3Ao0b3cV/9wY8fWas+riUwK8ZM5+upKeA==;31:2El1OVCU+klnrApVGUZng3ujA0qsMwQqabMBJbjivPTE8l332Go+Fb7kSv7MuKUFySHrigGv9l2FvilBy6NsLuzl+T/GOL8KuWrFS8DvQKm4bw4CVflnkWip3ooQMFkfZE22unEcG46TlBuUdXOZoz3a7b6Z+5UwqCRf67Oh/6zmzB7mOKxfEaAXPTlCyGzMskoA1vEtxQN0XLuAsVVt1rDSDdIDEbJEtHc6uSwoO7Y=
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0902:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB0902;20:5sm9T2Lj8Uf3ObOcxDHLXExDCOYOvtcxvbuyVOeJb74Mq4IsnO66vKGKE6fQ20ztGo2T3qiwDJwoSXuZrCUw6sLmTxVGbLo6laBrT0PgzOGNlJIPYbxLuj3Lq5+O80eiAf46n3fSu5MitBkgkzCvYnl3aRNXXBvXfyq50p5mSMyKpo7tRUE+y/6i+XDS6prDWjss74XS7RF+bqvVxtcg4a/dvWtA8BwigsUBAm1bqVgbzBbmbHJ95CQxCDs6CLpaukkAGI7949/nrWJqwzHi82mT0ahLHPHmSftFRlv+HslvydqhhfY7aHaFAU4VlnqlG1LA+eB0jIinRe8tokhnFxvYDjYy4hyUHLxnzSe9int+SFXmQBEbe3OMT6uuAF8h00/dm/Sqnu5vZjubNX0tk+vLxAzAjDBI1HUQk5iTvMEgU9oKu6N5NGvBaCrK9qtVZNsP81J+9i+TmTBzV+gvvbxSY02LWHPSAX/t2IYC/2kjILdsCZRifrpNXpsv70it;4:XyqRdEJk5+5wbbuTDiT2/GMfMTh6hkEbLWZ7opKpKdKWd9T1HARRvBRqnaJKVBuuhemtL9oSoOJsq7x9rhVDpdoWSuyh9IKL/9p8JENbHUUw8zA4+boQkfLZHRHVIb1GMdzp/rtiQDM9MJpvi4L6ujJoPxqEeF9wwGtftFGVxmua7E6u0YifhQ40cya4Fu7klR5VzUQvAQKO2TdNUc/WSmb+JvFH+bzvbcA5jRbjrhv7fO9Bz62UgyrM+0KCCEJsp2xYSrl885s31LXgXJrUEHPE4nQ1EzIbo28Y5B7XnXicaSc2OqXxhxpcoTY+w6sR5tAJRgpnOSVCNLTARtNcBYLKopSgyxnRi0HczguxrAViE3a7cVE6gQOGKskf9IvG
X-Microsoft-Antispam-PRVS: <DM5PR2101MB09025404A3C89EB311212090F4F50@DM5PR2101MB0902.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001016)(61425038)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231101)(944501161)(6055026)(61426038)(61427038)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39860400002)(376002)(396003)(346002)(39380400002)(366004)(199004)(189003)(966005)(8936002)(6306002)(59450400001)(6346003)(50226002)(6666003)(2906002)(48376002)(50466002)(72206003)(105586002)(5660300001)(4326008)(6506007)(106356001)(53936002)(6486002)(1076002)(386003)(26005)(22452003)(3846002)(10290500003)(8676002)(107886003)(6512007)(81156014)(81166006)(6116002)(66066001)(86612001)(68736007)(51416003)(15650500001)(52116002)(478600001)(36756003)(16586007)(16526019)(316002)(7736002)(575784001)(305945005)(8656006)(25786009)(47776003)(10090500001)(97736004)(186003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR2101MB0902;23:tNTDdByepsQzWcJ61W8Myha/V9skRKIfPaG7Wnp?=
 =?us-ascii?Q?W5Eqc1c59lyfzHk2h8EXpwJxKT/DuubDQzfKj7out0nBCzKOma5U1t1MRKE1?=
 =?us-ascii?Q?CmLVsFeI7tpVDylEHMApVjiPRI26QAxwfGKfHLs/lC5Qk06JvhuM9QKhKgS2?=
 =?us-ascii?Q?G2Kt/CeFRmlnUzUkVMui/2br5FpPoBMcco0jOUOiqkQUbQCsDg/N3oX+zjAV?=
 =?us-ascii?Q?zxIb3OxXAuP2ckhu1JxHbMcqetWyNfjYOpVb3/WaLj5vhusfkWdKWikw0hh2?=
 =?us-ascii?Q?E7qCn0ihDfFdzdyz0mMou1ZeJOBbLc6BMaJbtibQSy4qlzAVXfyzOtjfS/11?=
 =?us-ascii?Q?PipMV1/4xGdVm1bKnGwg7UgpR0cnRREEl73Q5uFyh7FNsvRM874u3cLQtvpg?=
 =?us-ascii?Q?Pa4FUOhsGrTAMBgqCcbdzOMIc+8pkSG84XqJVS9b1MCDy5JKXLFZTSoTnyTM?=
 =?us-ascii?Q?3qxzehjeGjKbl6C7yf2PXguoLyVvnYiyNe8xOHcNUxzvoR75iLT2jEBN4iq5?=
 =?us-ascii?Q?VxxW7fgqOwRSblKdqFIvlcK/eMUejJi0e/x8tjWP3RKVp9jpeMqJHANzRtip?=
 =?us-ascii?Q?u5K+VuB8sK7i6jq0cdrJlycXV9Li6B0xyyODsCwNuRdh7PknTEB6ruTCMrW1?=
 =?us-ascii?Q?JyGH+2Bq9jk9mhNUpMI7lpz/EWU9CTvJmaosZsZwmiPHOGAivI97iuy+CNTo?=
 =?us-ascii?Q?l6AH8my4q8CSfVwyqIkmw19HgIN/yscwzvXq50ePRtoQFmtrENvaEUra1qmh?=
 =?us-ascii?Q?90BnrEBeJeopPeoM6XqDRTUYDfecsFu4xGKXx/ZqjJKW5NDqroczzqbxrGYz?=
 =?us-ascii?Q?4EpsyK2aHwqLoY0F4LmFANxHh8qY0Y9BaFdsXTm9A4vO7MfpH7UiEL80jbfP?=
 =?us-ascii?Q?ZItmdxxIfk4jGfnTo2fQOZTjUYKqPMtpV2+6CsZFmkNfz7/9sCGfF9CnPho9?=
 =?us-ascii?Q?g0UVPKWLU2aKuqTzqIxw/nvh/xGuCx2Gy+p+h8iEAVpS2Tz7ni1FsuFh9FV3?=
 =?us-ascii?Q?R+dDjK1YfkfVWZtuKiLxtNLOMS8s+WdzJu14Z4IYnBXhvdM99cYT6WsChe5M?=
 =?us-ascii?Q?/mR5jbme+BW/xXnUn/LM5MIsl/NDECeE45jD74S+9myJZYLzsCUFV0YkaIF8?=
 =?us-ascii?Q?su1gjfWI5Mw+KNlmQ2GxmJaza+sHz4VC4A4Rm6UV3VlKwPbrEVRtvM34KliE?=
 =?us-ascii?Q?1VsCdhtmqCm7Ln7m+h5cNC8W+Wc4eAHKoPFEHdJ42rJP54WYF9QhXa0UPe1T?=
 =?us-ascii?Q?xpy19FQU/Nylz+tK5KW2vEt9jTabLIsZoZ/vqqfUS9apYM/jIQ+/WN2r7gS+?=
 =?us-ascii?Q?Ud3wx5++fA+cmLTh9oDFfvAjLdEspWPEfwedaYgQNcbTLaiHF3ASWRUi39l0?=
 =?us-ascii?Q?W9Ngn5w=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB0902;6:WU3c0Al9GgsVPNHjkHASK4mXnWbt+A9vFajHnzxppmZhpP0/7Uv4voTYyH9Wz79bv8dsdRhkyswH9MS4IxOjPsD45JH5g6gUUDBEgqwlzGjDfFWP2L+KsdkcfEk9L+Eqx5olSq5Ve9DIS3pOQ5pa+8CFXF/9zYB1xhODnnfCo8pnk6buZqrE2W9A8O7c/NG3ioehPr0H9mV+G97KKQgmg4REZKEKSTZJ0Ag1Zcxf2WGznHeWojfEW3usAXvdGDDrV903UvX92eJ5W32mRTC4PLVgoZxwrT4iOeZ2K0YvHMXk9KZbsresN6tL457swHMuDqdMcTiGTFMmx+J/czTfuh6RPR3sAE2JzwK+kO7Hx3o=;5:TOBrziwvrMEN2HqITQP6iWeFjZCG7vcMmoMOFrV5aSKQ1SGOYXUImLHB3VJqrtHOwcPM51sQVjr87blt1qZFXD35wd8xZ4F1q7VqujSdOnzCdU/bzoMy5vrHr6Uq79uf+c+/d+vBkDf/qujHq335Tfc9okfW80Dgtkie7sT/Rb0=;24:76r2+cbqa8fpO2b8I5I+xK/TjRSBh+DdMsdRoWkdNE5sXu4n16BSxJwMz58bv7UeqxpfjUS4rCg22Xu8my6HWTEL2YybyAwN3hb4HKCD3sc=;7:CheeCilvDcrBG/ADS7W3cnd6JaqxWNHo8OEfC7UV2uU1kJM2G9cUkhBZbviaEwYzSJKFCWnv8R6JbXRrmgSLr8CyYWMVliFFw9CKcHZDpZzvagaweVvj1vgCw+pI3vYdITU4/jSzh0Mw44Ippnpkx+PXU7hL1ModC2AXtE+2sDlDufWdldZTexqdnTL0UluYkWBokIcKyTYMuh6xcqQiKgBZZWjffF2gHEr48xAPFl+6zdFFCn1HE/a82GdBS3G+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 15:41:57.0609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9106c9-ee14-4ffd-a069-08d573c17b0e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the reference to setting core.fsmonitor to `true` (or `false`) as those
are not valid settings.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/4b7ec2c11e
    Checkout: git fetch https://github.com/benpeart/git fsmonitor_docs-v1 && git checkout 4b7ec2c11e

 Documentation/git-update-index.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index bdb0342593..ad2383d7ed 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -484,8 +484,8 @@ the `core.fsmonitor` configuration variable (see
 linkgit:git-config[1]) than using the `--fsmonitor` option to
 `git update-index` in each repository, especially if you want to do so
 across all repositories you use, because you can set the configuration
-variable to `true` (or `false`) in your `$HOME/.gitconfig` just once
-and have it affect all repositories you touch.
+variable in your `$HOME/.gitconfig` just once and have it affect all
+repositories you touch.
 
 When the `core.fsmonitor` configuration variable is changed, the
 file system monitor is added to or removed from the index the next time

base-commit: e7e80778e705ea3f9332c634781d6d0f8c6eab64
-- 
2.15.0.windows.1

