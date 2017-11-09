Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4814A1F442
	for <e@80x24.org>; Thu,  9 Nov 2017 14:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754984AbdKIOSU (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 09:18:20 -0500
Received: from mail-co1nam03on0091.outbound.protection.outlook.com ([104.47.40.91]:11481
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754957AbdKIOSO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 09:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3W1R3wsHFFmEd64pJnTUwV5YEeD3bbD/uTxZVo8EW0k=;
 b=j5McjUCEzwNBtfDh2xtH1RGFRI7WGcq+Q7YZwkSTw+4r9+bMZqkcA/PCZkr3SzDzg/R7MmWg6Uk9LvB7+1ISSaVPDB/V7r+Uvj2nvp7G+X8BD65fVr7pBMAI3l61/3JtwdP+85vTjArA5Dq2mfh9q3wcPRZejzGBB3qoqJXhdkY=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.239.0; Thu, 9 Nov 2017 14:18:09 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com, peff@peff.net,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1 4/4] fastindex: add documentation for the fastindex extension
Date:   Thu,  9 Nov 2017 09:17:37 -0500
Message-Id: <20171109141737.47976-5-benpeart@microsoft.com>
X-Mailer: git-send-email 2.15.0.windows.1
In-Reply-To: <20171109141737.47976-1-benpeart@microsoft.com>
References: <20171109141737.47976-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR13CA0015.namprd13.prod.outlook.com (10.175.123.25) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-Office365-Filtering-Correlation-Id: e9920d81-52e7-4b06-6897-08d5277cb583
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603249);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:S3oJ60C/dJY3E9odBf8hlo5DOGXAjbvIx1QlHd7nb5r48YHhjrnmWKYhEFHsPpNDVAyoHkT2JQ3ECIlz2eeHLvfcSm2EZ3UH01GndYZgSGmRbuxIsEduiWOewwGia1Rbp7WoqpdADL1iVJ6sz500qp5x4ZXrNtcritKSbBiTIfILKeeYYcixjaIG47VvMJA10RAe5EcOopf/3viSGK0wAlDz7bpgfh4MU3URXsYKpjDRxNgIv7U3ybUpQLmbV5SE;25:M/LwmZ16E1n7meqWp1qcAFvWWcoSg7rntv7ocNQMMpydbAzoi01gPa50dhnHg5ZXioS5uvKxUgLph4OLOsT1M8NIv9h4AEiSIqtA/ESejsGmaKuiPpcbmSp/DTrWibGFdELpJb5k2kUhjCvl02JOonZzUfRrd5pTv1A/A3X7gRDzhuzSRQzifKc6fD0DfBhOZ0F3HneDPeRZWFTKBIRheXck732bSGFN2zc0CRm/r/jMmBrThPrQy5jDcm828e7XWVPILPGj3DD5jLrOoQcRDvSq9oyUiSXXyvV7pCjJSDNumVjHrRzX76OzTHzJkpPOYQZZwI9m2XQtvNMroFjCog==;31:V6gT+Z32EoyMvY3H6C/lyLOG6y5AA00sNdbsmUWwFkP15gbXSfBnth5a/32U7/o2KFvIE6vOsa8WWuB1dpYAp47FF2nmGXR2zkcFzO/7+EbucQtFBqwTiPQYh7CjVvEXir/NjKUMx8VAA2szVtCLmaZ7FjYtNkvaihlh+5BFxhAZ+JCeRiubMdNqT1UxjjFfJC38wYo1jUTAjhQT+Ayf1VBDu1065I3P5nCMUXLk3IU=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:Y4wUIXLY7GL73XR+ZJzFj23XnETua27CgXau0sd7KGAd0W9CrVj+3Oke1ndFFtO1Jpyc271m/C1Prja9ZuU07p5YXjLCl60bAJ3F5Rk4sSbRZF0P3jWr9/jNctwVAXzfvjaRRAiWDokrdm9FVCSOm1PdLqGf3El94FjqNagHHcMWKz4g3eEI5yLv5upXRXM2dTst9iFn+l+UBJAZpBWI60FIRAkoLbqL/EQoVcnYnmj/wQ9gDcxvdWHaN0nJP9bTNzEeWTWihAFzUwj0UWnEPixkXh0JNKr9f59yWGDLxLy3HUBxi0djEPoocPL816NROUPBp9VKFegmM/IO1wlvRKtih7lVJJnLyDo63ehcJ/KexxFWTwpoKpQNnv6Xhcq3oziZY4+lGQKYoauBeTN/cHasbembGANf4hmmLrYqCwxBR+FeSTlD01gCoGyOiXlHEMnSdrUYO7YjFkEvJR3zQERVTSVQRuulMsPevLB7JaogKdO5Jm9kMSRjLaqE4Xpg;4:SiVi83oDYPD+1kz47kToFzdCpbpt4jASCD5segETAa/04UuGmXhDmzi/RIrQOnauL4ru3iEkpXalKOgAfBh+UbVC36cDaC3cUc2PBIxnV1F4FOyl8Yr9BZNolndYbJCksRrzuvwT7P22KqyN4cpK8dr5Lm7quqq4bR1dyAi4jVPntcZKWgDZzVJBu/Z9/7X1slhtBpkYHUOnjDuKns0tgEsBKH493CseQcfdzdkvmCv/OBFuheOv3I8DJcARJxJBsqiORlSybKoSnijX6y2Xufgbcdn1kq8Ak9+BeoC7H01I14EzpMjoND5X8H919jxC
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB0471994BBECB15C9F88A6DA6F4570@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(3231021)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123555025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(6069001)(376002)(39860400002)(346002)(47760400005)(199003)(189002)(5660300001)(53936002)(8656006)(47776003)(68736007)(66066001)(48376002)(107886003)(101416001)(50986999)(4326008)(6116002)(8666007)(39060400002)(76176999)(81166006)(50226002)(8676002)(7736002)(16526018)(36756003)(2361001)(105586002)(1076002)(305945005)(106356001)(81156014)(6512007)(2906002)(8936002)(10290500003)(189998001)(10090500001)(2351001)(3846002)(478600001)(22452003)(16586007)(6506006)(33646002)(316002)(72206003)(6486002)(5003940100001)(6916009)(97736004)(6666003)(86612001)(575784001)(25786009)(50466002)(2950100002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0471;23:Y5HFUMjj83R7hra1L6KEU3HstPhAVfj9moOS+Z7vB?=
 =?us-ascii?Q?2qcakA2IfjNHjlFrfOsvLd5O2uX4AeehitvMWcksSY44GQ+drIgyaRg/g5IR?=
 =?us-ascii?Q?tHxkhR+VoBsT+lqDIx/4AiTwlcEm9KIJan4e535lbb4oz3HVJx1Zs1DJooIW?=
 =?us-ascii?Q?+MMleFex66IhlS+a4pni5n1Siig0UiRcspovcW7CZer5aUhJ754yKrFznKb9?=
 =?us-ascii?Q?Xs0O/l6ojNCbSmg4BG73+vJUo9gK3SK+8Yg7h9Be8StOuLp5PRoCpSvFMDRG?=
 =?us-ascii?Q?vrqDBCj0YRBi/aH4NG/OEAZemPaDBVJUD8BtnTO2qEofQBFROeoQ02dyNwV4?=
 =?us-ascii?Q?7klg5EUmvsmwVRHdaoeqt+ugjYLVbQmDydBk/brQ6weO0h8FC3TYBWd+VB+t?=
 =?us-ascii?Q?eccTA4I3p8BNvqkTdv2cI41jG1mxiXg3mNaO4pvGbFBcUM2P190YR25biMPt?=
 =?us-ascii?Q?PscVf3Jvh70Lx2CXrZqwNGwQZM5O+4DktCJDqBkB1MtxLJcbjyjQys8E0GVd?=
 =?us-ascii?Q?BPImaDhmfpwK9i0gI/k/tS2q7GGhQ5+LAzq65v8ErkcxEaaVlw3OA5qYROST?=
 =?us-ascii?Q?AbfTKGu7WYN++L2vaztQ50lq+IF4G9bjWCbhHbfSWxvpN7jdjPVU9c/YsiIC?=
 =?us-ascii?Q?PCyMXSO0VFPPWTB6p5fOXN0yUemJv84Bj1eNpQC52G6qzLLXrsU0wiW3RY68?=
 =?us-ascii?Q?68cvW4tNPRLzHcEfBSOX476zuQPHYA9CZCG9vZ6tsffhHBVsU1apWk0vLQe5?=
 =?us-ascii?Q?kSL1h7z3mfLm1PgAh8l3cYLK8k562W8/OIDpPG2HQYq8RT4WOQGReuYeom+p?=
 =?us-ascii?Q?7e4e8FfuUndCAsgoc55a8m9nSemRZmILy0X0n0hoMyKqssdbMpKu9B5vcD6N?=
 =?us-ascii?Q?NHvOwFyNGYdsAB8sYzlqoanGKTljp+9mZ4s6LnA48Vw5FBnMi16AMMWt5UPu?=
 =?us-ascii?Q?iFDEufuhq9ab4aSWDC7UVhEJIuHrMQs4Cs0ho0uxMuUOdyLx2FS7mrS+t+h/?=
 =?us-ascii?Q?WvWFXoMm61bvYbXcqGXuw+kmefQXQgKFVoPckUzvObZt6rKaTzFVuKAo3jOz?=
 =?us-ascii?Q?JngCUkG6HGPkQ479a4ss8WHlxOzgV/wWUbE5vLANrLcEfPv7AFKalvExm5m9?=
 =?us-ascii?Q?iPXaotJQDNUv7KMw4YoBwT/cecxvPnEHsv4B0SKVAaYasN4OKKoOmn0Z+Tvx?=
 =?us-ascii?Q?zPq4CxZN2RvGkApvi/vJqYlyBBBkxi4Ha8Zej67VALj1uSq6J1gsYd4CDP2W?=
 =?us-ascii?Q?TnQ0bkXRjb1fJsFrsx/8S533udmgyn9z0EB6rXM/LZ4ajTYHeWViZLs2XRNl?=
 =?us-ascii?Q?1Dz1BFkiJJcYhB4nwtefNZ50uLg3i5FDzUqeWULVVhwoO9qLvuCht4LTWHyS?=
 =?us-ascii?Q?2FeJFYU2+4On0C57o3yhjYUZDE4glaNWvWA3rNq6b3IylmVVUFhC6tDjgrtU?=
 =?us-ascii?Q?ugZ+248Mg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:uV1XSlIGaYLd55xNpVP4/WIrgBNppv/eTb539vNuiMbdcMzOOxSrM0VLlzsYyGO2F3Zj1WqlNFO1hfRO9MmTVhNUtuh3FoTOq1b+T8GcLd+EGsz2qXhneEcs18+58DWzPeGS5DtV6WY50eEidajUCoRbuzs0LmNVhzjotZfSfIiYA17bMkyCbJrzyEbrqAjB8QZ3tr3poBHaQqepa/jFHNcdN+Xvrdj5b/jNjxEu1oiYR+kCC6SN4Wr4wIjmZDDY/1LRL+lJypjraMy1N7j+wj/GaKvJyV3qxoWzIgUjOQjf0gKMK2fTue9Pb3RWC8pn4T/9OZzNLHvYNoePPzrmeqXQxwEcigdxVwRBEgKP/eg=;5:149MzzCPWd0ZU9+JkRpNKMj1MAnJBzaoWeDQZxjNgBLHhT1x9NEGKcy7HM+DUyrqsFU6fVBCippakcEWP+saMgiOlorzhcBMfOE3/waVta/QmuOD7RSBics8cG1t/iJg1gFZnik9GDIIZxuSdvS8KjaaK5S8o+eDJ7cHbM0lF88=;24:wqJ6LkTBffmNaricFezeT462Vpdq21LR98qP/z4DtjNObqOxDXRJLEGyLncGHULNBowkKLHxAk/r8Awuc2a8HT2rNBm8NsFF5uJ7GupORMw=;7:hpIoX4buETfMWTnsykInTNBu+BM2Mu7WOr2Jr9RvjWEOZidIYbFaKlbShwMLA1c41uNs7wXpAhJEESLoMmJOAsVhdE4BLw/wx2Nue2g+UOO8Rzt9zgUkZAKF3sHZqf42KBGt4AfmZ88aDKldvuzST5iA6J48q3FSjFigT7Tiht4XDgxCvwpu+/cGWtgclLcWpXv2qOIXGOa42QnrHXsC80NiXvzifcXbvq0BreWKBNt3KHXUqGZS2HCjA3rD4teu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 14:18:09.4072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9920d81-52e7-4b06-6897-08d5277cb583
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This includes the core.fastindex setting, the update-index additions,
and the fastindex index extension.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/config.txt                 |  8 ++++++++
 Documentation/git-update-index.txt       | 11 +++++++++++
 Documentation/technical/index-format.txt | 26 ++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f0d62753d..269ff97c8c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -868,6 +868,14 @@ relatively high IO latencies.  When enabled, Git will do the
 index comparison to the filesystem data in parallel, allowing
 overlapping IO's.  Defaults to true.
 
+core.fastIndex::
+	Enable parallel index loading
++
+This can speed up operations like 'git diff' and 'git status' especially
+when the index is very large.  When enabled, Git will do the index
+loading from the on disk format to the in-memory format in parallel.
+Defaults to false.
+
 core.createObject::
 	You can set this to 'link', in which case a hardlink followed by
 	a delete of the source are used to make sure that object creation
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 75c7dd9dea..7ffd285c94 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -19,6 +19,7 @@ SYNOPSIS
 	     [--ignore-submodules]
 	     [--[no-]split-index]
 	     [--[no-|test-|force-]untracked-cache]
+	     [--[no-]fastindex]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
 	     [-z] [--stdin] [--index-version <n>]
@@ -201,6 +202,16 @@ will remove the intended effect of the option.
 	`--untracked-cache` used to imply `--test-untracked-cache` but
 	this option would enable the extension unconditionally.
 
+--fastindex::
+--no-fastindex::
+	Enable or disable the fast index feature. These options
+	take effect whatever the value of the `core.fastindex`
+	configuration variable (see linkgit:git-config[1]). But a warning
+	is emitted when the change goes against the configured value, as
+	the configured value will take effect next time the index is
+	read and this will remove the intended effect of the option.
+
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index ade0b0c445..e37b4cf874 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -295,3 +295,29 @@ The remaining data of each directory block is grouped by type:
     in the previous ewah bitmap.
 
   - One NUL.
+
+== Index Entry Offset Table
+
+  The Index Entry Offset Table (IEOT) is used to help address the CPU
+  cost of loading the index by enabling multi-threading the process of
+  converting cache entries from the on-disk format to the in-memory format.
+  Because it must be able to be loaded before the variable length cache
+  entries and other index extensions, this extension must be written last.
+  The signature for this extension is { 'I', 'E', 'O', 'T' }.
+
+  The extension consists of:
+
+  - 32-bit version (currently 1)
+
+  - A number of index offset entries each consisting of:
+
+    - 32-bit offset from the begining of the file to the first cache entry
+	  in this block of entries.
+
+    - 32-bit count of cache entries in this block
+
+  - 32-bit version (currently 1)
+
+  - 32-bit size of the extension
+
+  - 4-byte extension signature
-- 
2.15.0.windows.1

