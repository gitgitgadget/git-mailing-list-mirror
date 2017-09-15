Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2EB120281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbdIOTVh (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:21:37 -0400
Received: from mail-dm3nam03on0117.outbound.protection.outlook.com ([104.47.41.117]:20724
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751581AbdIOTVf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=C/2t2CNCHRcJe1ulijh8gr/iaX31pnC68NJxFTVIjsM=;
 b=XEqyYJs6WDDECddG4GczDQvw9p8qhRbh3Q5Poi8oHVbyVGTLAgjmrelpCADUQ8VbYNa20QcajX1iXTi1Y+1CcUl68dDcofqCxQ6bfjrSpDkLPnSuSuu5i3fFka9b1N6XPUrKpkJddWbbu77WuFSHTB/R94KfMxUK5VXNK51olpw=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Fri, 15 Sep 2017 19:21:25 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v6 05/12] fsmonitor: add documentation for the fsmonitor extension.
Date:   Fri, 15 Sep 2017 15:20:36 -0400
Message-Id: <20170915192043.4516-6-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170915192043.4516-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR2201CA0010.namprd22.prod.outlook.com (10.174.119.23)
 To CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da4293ad-a98a-40fe-2299-08d4fc6ef5be
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0469;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;3:UYTx7xZF0Zx6YOf78EboFNlI3QYTGr5gunUy8OAN+yGB8NL8I6UsINSn0WAh2/jKp57uzcQchE025PiBnq2OJ32GDmEe8yZXRtzh6D4KRVC+sFE8rtBATd5YfGmbrMar3dPRlzPdX1wCMSI4ccABIx1IdIE8wKiIvEarTvOtRj0h4iIgu9pYvGhdn+5Y3ZhK9FZDSmh0i7mWPbNqNdVgfShAukPlqn2s6s4DwITPBcaMOyuallFj+9iJTd+X7RKE;25:weLp6YfAlnyLS6zu10NdqHMiI3x3CeATK+rXep44t3fPEJ/X2NxoZPD0JPD2OxvyoN62HlZONYqiy3yvabuv8SxEJWkCHMAMt46Gu0bq/uxhd0kSqNu08Rxa0d3eO15MYzMpPXhNbPeIMeKk5VLUivD5SAoIxsiPY/OhftrLJ6nsERo/gVoxRSU76TVUkfRPyYqne8u0F6x3IMEK58tFVSNPSei+4QL7IR78zH3vURhs8pLOFctOuyInjJ4iGKULgPL3YyoPpn1BJC9YmNRq2hKcnIbbS6PU8JpQMlRtL1vyrdCX7ybFd4ZWYOPaWaimy5dnd28guqLBS3hf91rFyQ==;31:idY6qmLTa3fx5mN74KqNofjCQ5kbRkay8g3iDvRmfytLwDoJGYKGZ/MSlIywfsXp3bT7l9Kknux/vVEUgb+2sWd6QT8gvJgjQXxHQNqydVFwhoIKIJFozQ9u1gjzmj1oP6m7Mnc9my5kczFeYh+2H3LgirzeF7gWejBwSAfJt9kLN2xUnPuF6ZScf6STGg2ppwpSZbcz+xP7SGEwtDWM/zBRA4lPqPDzBFAasCrsfYA=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0469:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;20:UGDGBikjgF88DYX0e0J/FavK4DKe9Yj/xyz08+FnYJLhtf2A94NSBTZFywhFejcytOaoNxG0vA4iLOfywyxR53SO5vl99GFgHcUlnYPj5Pt4yB5OY1Xq8fvEJVcIkVjienhWNIC7U3A1HJyV3miBzF713sxI29JXABJ5vca1/3uBvW0RBuEr2Wq8jFTC6j3X+EDySvGkrCnB1yao+w3Qiwd6QibYDyZXJWvfiNhr84glkBOqWBDkFaqjzcYQE4yG8+YwEFfRi0QEU5fSN8gLVdL35MkSMBJN+tNr03xayU7x8T7Mhgi5WcN02OK0BAZgtbK0wnymjbD8O6y1Y8rjQlCnUAyN4HK1F58vJFvuZl9H3MBG++JnVniiwKdH9dr5Pz/x5kfS8gfbEL+o1dBs85n5xYO4OAsDgPoK1A9k9XaaxUhYAPOFSVdOtTbbvSvFwDWDHAwmoOiQKhLFXHVz8pkp+pzlmEUDB/4vvuS0NT0yBCpRxYvJaPkHFxpY4eMW;4:MN4OvHd6xUXn2OuPwtkkO4iFJjJeVea9xvk5GhIRlj1YTmNjjVwzOGT8igfOVmXR9UImXpXXFon83JSditLis9jsI3hBUaLOpC5NXnLCXmtPI3tduEnOMhdPfXGPHmXVHf0inXPsfGlgZIdq4AOy+wlqO0Ulo1ssK7Lts6Xzi92Ng7wqbpdHyVEsIgp8GkefZwr0e6VA+opUHgFqVyVAqkEa+tJfAlRuecTl2fQh2dsfMTQEhmOffNsJeQXaZK8apfVrvkwlJ5VvtGjJYU3iLTf4p9h7XdejWTdT1hVtG3s=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB04691B8DA436CC9FE762E324F46C0@CY4PR21MB0469.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0469;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(101416001)(4326008)(39060400002)(110136004)(34206002)(8656003)(25786009)(97736004)(2906002)(2351001)(50986999)(76176999)(22452003)(48376002)(50466002)(2421001)(33646002)(68736007)(36756003)(105586002)(50226002)(2361001)(478600001)(106356001)(16526017)(1511001)(316002)(16586007)(47776003)(10090500001)(5660300001)(6666003)(6506006)(2950100002)(72206003)(5003940100001)(66066001)(6486002)(6512007)(81156014)(81166006)(6116002)(7736002)(305945005)(8936002)(575784001)(8676002)(3846002)(53936002)(10290500003)(1076002)(86612001)(189998001)(8666007)(37006003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0469;23:NtC6iiHBKwD8GopZsTECfUxnptQkpkqfb8/wMhOLH?=
 =?us-ascii?Q?eIjBzwG0S38IEMMAp4BSC90zoQHfL+1wW29EDqUPC3Dm3Cn2lETHb3idooXR?=
 =?us-ascii?Q?LoEXJlJ9wrJK2Yo2OnMRBdYLvl9t3F1w6N1nm5zbm1UOKaSKbQlR3zirGjQe?=
 =?us-ascii?Q?Px2oJAEghRxwdJ50pA8gGnCDM/YAUgbpDErYK/Oyg+tQYrWHJZD1xiw57CT1?=
 =?us-ascii?Q?PnM9vSxMLJhl4oyBU4tOv6b1CrHEyQQkF/FMcsiN7wpJ7Z0Dn9H3D9Nysgg2?=
 =?us-ascii?Q?bLqkatakuQ+34hS6Cy87+aB8VaaAcV5LjDzGFT2+W/1s41q0c3H/N+tHIJvr?=
 =?us-ascii?Q?NNaux3uxSU7pSuqPOHBAjszzPm8u/dnAvYM68oLd2R1qWczroI4yVkorXg14?=
 =?us-ascii?Q?xd0Cj0TVlJPADntwjaVf0yG5a20oW35cgkIkAO+dE89VA41UNdlSuQtFzGyt?=
 =?us-ascii?Q?frkZjGPcbITLBMHg2r51hhCOfo2pvPi7XzUhjVMqiGg5IRBkNMOWWHPpdOva?=
 =?us-ascii?Q?UXiigtkuyPeosIxzCXgHtdhxSQHQ56l+JFc/fEjjNxeWXH3F48ZgsnQ/qIvB?=
 =?us-ascii?Q?uyI4XY1VUoUHk3of+Mdb9n9wzuI/7KaPBFfpYXBu9E8KacpHhr9gqc0G1Z0m?=
 =?us-ascii?Q?xEomqsK+JXfxbsqYkmM9wTVWAz2GD9rDa8w+E+yCiywfcgRZII++TfQabG7q?=
 =?us-ascii?Q?/2/tdfhVZ9QRsTgvNlByW+8K9CwFOkBdFHacuoCAjHuVVL3HpRrQCqtfsbAR?=
 =?us-ascii?Q?Cl3pG01TNIp6eAFX7Vu2Glwq66qFx7tiuvGoe++58AhsF9XmZXmXIVIOqQIE?=
 =?us-ascii?Q?stfJHvrbOwIgpYIEBejwIQUmjEeTBPGUPQheMUDIYUUgAy0lCibcpEno5XDG?=
 =?us-ascii?Q?ILU3ZK+yUIBU7qtzNfaN9xYEEJO3Q1Y+ek/X2GUal0pELzTcBpawpNfP+sR0?=
 =?us-ascii?Q?2/mqE9s0hqQ8lwAnm73KnxhY4RTg+E4p9Bys+jWhL5Aw0G1iLJYZipcrDttO?=
 =?us-ascii?Q?3+P00u00dwwXY8yFI/yrcS5XjtZf7ndwBoYqXsYX+hhG8GT0SJjoRhCvMlJg?=
 =?us-ascii?Q?WwdD0wTN9tJE8++WFqj/Ax/LjH/MOSgBpJKpvAMe45LWF2cEbyg+i/eCatpT?=
 =?us-ascii?Q?Sy85w/Ment+bN9JWJflNnBYa03sG35x2TOlQhEy+YpxnzlYoigtvZQhbAnHB?=
 =?us-ascii?Q?X64gbvRz7WzkjTW0fu69DyypFJ1/aKg2lB1Tx4UtVRnyxrUe1HXW36Bxo7R1?=
 =?us-ascii?Q?QcSdEr6DD9PO9KzdWxX7zJqe/N67b2JcZoIdyCiOyssDAifrb4mLE0sMyt6j?=
 =?us-ascii?Q?9QVa6nOpZuEa9QC5D2is2V75kZuSABCp9HGqcQFBZvUGp8ybh0N07BCtNGNj?=
 =?us-ascii?Q?zp6h5lg7nkJxSLwNt/fhNZceHv3wUsxClq7ZutQ5hXa2xHT3VeBh65ATBNy6?=
 =?us-ascii?Q?dxQYS/dZAIYFLhZIouBAh1f/Z0xC3gy5xTv34htsDbYk6B4uH/w3NMm2fK/m?=
 =?us-ascii?Q?zN85ZCpIUcaWQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;6:MwRh9tBFdlMpq+VFRGd8AgulUAyg2SqvbrmjPm938uMea/5TVPpYGGaZSxvRxWw/CkotCXNk4U1rB6QsKREkM6BWZI6MlXW+j8gwUloBOrV6YcQmkrqfBy/+pXPRcXL00PmCMkjww5xUt7BS3bJg2c/OH8SAtlvHdp7poyB50X0wt7OszJtaQNDk9yMZNsPBK9TYM/e43oBt7wIk7/WnKDiTIMa5bJ0ZJfjAduKgE57GISyj7769YR9vOsBE89iaAJt1r2wLbIGLN5HknCrDcWkr5D9rqcY9aKNfvA4jSoN4OxMPwJT6TAf2KouKc9CMp9l0abh23lMITRs38C7gqg==;5:aPUjM9bXiwwt8QuLT+OhRC3E0GB1g3Vgvbnbjt9RA4I4DTESgysr0e4ZkUAjSqlOLIYNWCsJHwZCVCe82jdffYUPOxPBPVVc1C2/qmi/Tpa5hsXQjsvANN7FXHF7AHRiTgyCCJl0O2oOaNljhL99tg==;24:vPQzwQScu9tHu7FA4dTuBxzoPLfQRvXKiqABLHfevH3cFNPj3EhEKFnwN9G6FzGk1ECKnwok7ek+dOuNqmRrb7OSB8U0udw+gycXyivqGPU=;7:OXKmFSWivPpniTjwSn6uz4g+boWxgTdO8j27+5tosISo6uDxyPHWJEAtKX0FU06rGSYwYD9SSd+8QNYyzJ3SJzH1FZTUCmU2i4lxK+O7YNAWQMejZCCk45PIAFE/I85cTtJgw7B0BS++BZyYVFC0pMVYAQ3lpW+NFTzbLZzvZXSwlxkRdwF2aCefNg9WBbVIMGXZUXziYgNj50lwFM2AsOvf2SxHb+8glhlL4yji6Mg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 19:21:25.0406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This includes the core.fsmonitor setting, the query-fsmonitor hook,
and the fsmonitor index extension.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/config.txt                 |  6 ++++++
 Documentation/githooks.txt               | 23 +++++++++++++++++++++++
 Documentation/technical/index-format.txt | 19 +++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dc4e3f58a2..c196007a27 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -413,6 +413,12 @@ core.protectNTFS::
 	8.3 "short" names.
 	Defaults to `true` on Windows, and `false` elsewhere.
 
+core.fsmonitor::
+	If set, the value of this variable is used as a command which
+	will identify all files that may have changed since the
+	requested date/time. This information is used to speed up git by
+	avoiding unnecessary processing of files that have not changed.
+
 core.trustctime::
 	If false, the ctime differences between the index and the
 	working tree are ignored; useful when the inode change time
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 1bb4f92d4d..da82d64b0b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -456,6 +456,29 @@ non-zero status causes 'git send-email' to abort before sending any
 e-mails.
 
 
+[[fsmonitor-watchman]]
+fsmonitor-watchman
+~~~~~~~~~~~~~~~
+
+This hook is invoked when the configuration option core.fsmonitor is
+set to .git/hooks/fsmonitor-watchman.  It takes two arguments, a version
+(currently 1) and the time in elapsed nanoseconds since midnight,
+January 1, 1970.
+
+The hook should output to stdout the list of all files in the working
+directory that may have changed since the requested time.  The logic
+should be inclusive so that it does not miss any potential changes.
+The paths should be relative to the root of the working directory
+and be separated by a single NUL.
+
+Git will limit what files it checks for changes as well as which
+directories are checked for untracked files based on the path names
+given.
+
+The exit status determines whether git will use the data from the
+hook to limit its search.  On error, it will fall back to verifying
+all files and folders.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index ade0b0c445..db3572626b 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -295,3 +295,22 @@ The remaining data of each directory block is grouped by type:
     in the previous ewah bitmap.
 
   - One NUL.
+
+== File System Monitor cache
+
+  The file system monitor cache tracks files for which the core.fsmonitor
+  hook has told us about changes.  The signature for this extension is
+  { 'F', 'S', 'M', 'N' }.
+
+  The extension starts with
+
+  - 32-bit version number: the current supported version is 1.
+
+  - 64-bit time: the extension data reflects all changes through the given
+	time which is stored as the nanoseconds elapsed since midnight,
+	January 1, 1970.
+
+  - 32-bit bitmap size: the size of the CE_FSMONITOR_VALID bitmap.
+
+  - An ewah bitmap, the n-th bit indicates whether the n-th index entry
+    is not CE_FSMONITOR_VALID.
-- 
2.14.1.548.ge54b1befee.dirty

