Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36B3202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbdIVQg0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:36:26 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:2304
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752497AbdIVQgV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YfqrJdKieOWjC/+zh8IN88ktqAT0ZixfITVrMgwtZJM=;
 b=MXg+UF0GvvyAjFarhwWb8zST5KyXsMn6VZtYerU8wlqfNw3BIXfc/fDXWDgqBeUYYCzZOwW5AXoIvKwmMqLs87HU8Flx2KJ848j1cJj70mjQ59WdEa0oeQXYTD5sJFXPcGEyUag1VL6Vqq8+041jTresYilPCCxgfWPdwg8Svx0=
Received: from localhost.localdomain (65.222.173.206) by
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.98.0; Fri, 22 Sep 2017 16:36:11 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v8 05/12] fsmonitor: add documentation for the fsmonitor extension.
Date:   Fri, 22 Sep 2017 12:35:41 -0400
Message-Id: <20170922163548.11288-6-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.549.g6ff7ed0467
In-Reply-To: <20170922163548.11288-1-benpeart@microsoft.com>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR06CA0048.namprd06.prod.outlook.com (10.174.93.37) To
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9580b2ca-0c25-4410-6b9e-08d501d80971
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN6PR21MB0466;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;3:cQWmZ7A7pMSnCJsw0Tr8qVw+Xa4GKhFqFvs/a/ZLst0JWqL0ozbZyrmg95hQxRVOnTc6Rs0Zd+NS4nlIVcXLRNtCy9XKasBdZINAx3nCJStL5teIXT2FLSs7UvuFPNOtTvGh2vkAIfpPG+wgYGr9jUhJ/wJTnvTg6oRJhRhiavFb9dLLGvnO7Gp506vnlZ6p9ojxKTSebnYd5aXHpnUB9T8CZhEsLDg/wH67jipdDZ797ExxN79ac22xJ3tnO1w2;25:ghOoi7mcm6gA0t/cSPi0fWrQ4UeEpYh/hLa6jxu1fOItEC7HpP96pj591bKyXsDvAaF5tfpbhS3h8I32nbLVw3kr2cS6gdufr9OJaKC1jKCvlqn2OIpIdZX1RfSJre7awB5I74dinndjL29Z3ESF/EN4HkYtUyDJT0iNmMfU8zlEyq534YqeafEXAAOMkHAToEA0JSb5PvURU6p8mMSxG9oK3MmbiRvBXJaXA59CWMPettwioQZSZ48ZPQPeQ2aT5zdH9JKyCkzrD3sSkvMnwIGznePZzVuMJ0+cr19E+smVocLaSmzBkOCLsggZ75rBtKFOXsnUP72wfkZNtHrKSw==;31:zSwsfzJbT3eqt/xMXb5vGqOq4wgEV2wh9Q3kvpLnvufuO78J6LC67VPZ/o1qR/VT3JHiHjBqpQNnvddnQa4HJSVGS3M5YGlPDH+Quk9CwLyoTnYikVkysB9RoI5/PV9kNuWxfLpdhwM/EIuOUwopupXIdatGjWxSwovXmPxF4hhZG0knnrVpcxYS3Cjwpibu2wGJvnFOjNKwTjEnp25lJZTAzqA48s9ZnP0vwZ8cpbM=
X-MS-TrafficTypeDiagnostic: BN6PR21MB0466:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;20:GKV2boTNM5msvZhgcDe3VX+A9L6glU0A0SlTkx3ESVtgbUewCKU5mZkBL9rfY6Njv14SHuHuGdEhabpKoFTNWncgymq82D6/GVcElOlXnBo/uYPwEJCN5OYCDwY3JZ47mbAUJcXYHp4Zl1cIClakmo1xmWAhw0937Njd6gXDgIkFpmBf0VzOxS4ED60Zvu3haCi3QomNQ5GaqktlJ7/7JAfwt31PpeiBwPR7cXx8kozrm70WxcTF0pLmpie+PoMERr6nunIYPX9Uig/CUCQemwoA34AGj8RV4MlFd+3UjXJaicS5cIqKMmYaxc7md3/PXZNcdn/Qx+CBJoIwnhRHfzv4i1PWbS7KEidk3fsQSp+twy4OR0JxAi7U/nPzoPh3knnyOpdFu5yC7VOwB4wbfTQYs8s6sbS5jK7vNRysZTtyU2u1ggFLovDJ91Eq6iXOT1TKJ8+HlrFB4dmgV3XQTgJy7rSJZUXEKtVjMDEUZbN42kRJVy+6/BbImUGn6Y82;4:mWADA6SqP42lnRzOGfOz5FbcV0sqaSiXO25xCqmfHpDNpApOn0MiQZ7ZXImlLShF6da+iwCylmPe3I4rAz/9JE1EJSBf4QyRuAtvfodplEh2CMrkagtPFkA4Nyf8OmH/cdAgx4oN5+qWJN9TyGZdiNvo7AT0GHOItAlaes0SXetpK0ijut4HcUkZewrd6gQguuY2I2K2i8I9V7n3p1FCisEDwWuPs6NKUErp7gtLvfP7NPGjKjQOqJIwieTC4gCyM0COdFgIbarbavDLnqv93jXoQnhUrNMMVq0ddknSKXA=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <BN6PR21MB04668D6187A5B5DA26917BB3F4670@BN6PR21MB0466.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0466;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0466;
X-Forefront-PRVS: 0438F90F17
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(2351001)(6506006)(10290500003)(6486002)(86612001)(2906002)(5660300001)(66066001)(4326008)(10090500001)(101416001)(97736004)(5003940100001)(1511001)(47776003)(50986999)(575784001)(68736007)(76176999)(50226002)(106356001)(16586007)(6666003)(16526017)(478600001)(53936002)(48376002)(2361001)(37006003)(50466002)(81166006)(81156014)(8666007)(8936002)(316002)(72206003)(36756003)(22452003)(6512007)(189998001)(8656003)(25786009)(2421001)(33646002)(2950100002)(6116002)(34206002)(39060400002)(3846002)(1076002)(305945005)(7736002)(105586002)(8676002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0466;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR21MB0466;23:65aMevdwZNZVbQAN87zIu/HviVys6t4OKquo1/GDW?=
 =?us-ascii?Q?k4fCznXic4Icoo+XaImxhC6F8weUIOvXcos++zAR8gcMsdk7UMsobn9sap+f?=
 =?us-ascii?Q?Uk2Pc0NnAcBjvfHPkv4vLbd6l1Jn/bdwKnatoD2yq36qoQT0/TzOHF8I/v1P?=
 =?us-ascii?Q?krTSpLSy1yPaSxhlVFcHHgeUYXlUlUIUpJhV+smw4Jzt+T01XMBxFIjNrOEx?=
 =?us-ascii?Q?vSQN3Gka7X3/yJvyspLxR4rCmQSbO4I4FDhE7/fZOIA6b/3Y7FpG4vdDZB1W?=
 =?us-ascii?Q?QjnmR379O4mhn+Zm/BiZe6DcIIQ5UWmXRMgkyMovOQ9xhXZV7d4yAbCCepGN?=
 =?us-ascii?Q?3ijlRN/+VbIu7FEp47yyiAEb99IMSrmkZuWqQB/aYISxWqqG36z73ctVSjp6?=
 =?us-ascii?Q?jcOszoA/6SFSlv1Xod1xfLHwLuboHIuUYTBMg6c/b/Yy58qVQ3ixZPXErJjb?=
 =?us-ascii?Q?BWIRqK+Oa1sGc7oIfI/D3SDIolM5N8Oi4tf3yD0wBNweECDYL/ABVzcAYLLT?=
 =?us-ascii?Q?DaVJRTdMTToozDK3UgyNLlb5bw+9Ve4PJvHJ/KWPnB3ASz/HO9oDe+PVzwtJ?=
 =?us-ascii?Q?CMGdo7oi9xvYqmisSXFB4GYdJ27jzep3pmIxFqkOBXKj4a+/ILBZ40upjcOh?=
 =?us-ascii?Q?2XGpWyv8doAtA21QIopMqFcVm3iXqSoC7nekxN5Ue/rq7IwOb//sbV3HBQI8?=
 =?us-ascii?Q?qeRiOBK7VRsXZ4cuwohilwETvLiLTacNtnvGjyYCoTf26uoiGuj+kKQgt7zW?=
 =?us-ascii?Q?w/udfmbbsJ7v1NSWZfRM9Bs+66UCzDIu45vPolrAFQ9kUkdecmlAyuslmqf5?=
 =?us-ascii?Q?i9Jsk9QM0UxWH9ShUtBuFRivUG60srNItjjmCmi8QP5TXDwIF4RQcsGVEvo1?=
 =?us-ascii?Q?5ZOpYU1CG8c+HCAu9Yl5vXKNhECYvdSL4mBBG2BFOOIEeP6frVYldLMXu2Pp?=
 =?us-ascii?Q?59bG7QubTj3M3ItPmmIyCsr6R/HdPMUKqD6KdI8BMvJZBNApfnb/ZSe+nzS3?=
 =?us-ascii?Q?TmFhnZ7poqwoJbBiMrGxjvVW6X9y1Kt526xXBW/fTNn2A/FiDetUWya/Cq26?=
 =?us-ascii?Q?zwf83dfcg6xuTeZZBccA6fxJktuSBxqSH2lyNeKeNIi3WZFoq16MELH3s2D+?=
 =?us-ascii?Q?sHh9sWPFvRp/Zz99vQ9RwLidLk8IQnNgzeMj/fkOq+cbOCvGifn24dCI4A6h?=
 =?us-ascii?Q?wnCc5mEGuNowicsv5H0b7d/cmd2TE0Oxvo3IgI1KhvFpgiNfzWwWQzS2oU4V?=
 =?us-ascii?Q?n4+Dj/2RSWAFlTX0BP2pAPbWiUUxGq0Vk/oVwY2qfu46Ck0QjjuDGzndpmvv?=
 =?us-ascii?Q?bG9r9Z4tLG84UATIWBHbQxHF4zxLBQCOMhOwcsLJLY3B1yjQIHWfH4Nv0m3M?=
 =?us-ascii?Q?Fi77/bplD+jOIHhyqP4OJmgVVYehN4IRrwB047NpBYtqm6nu2+0HauoePehW?=
 =?us-ascii?Q?tsxyVu3wKnuDiyxoIWG28R0ukBtaXJqClsotDyGT/62CnD6Zp0o?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;6:u8zHg+dCvy0tJxag0bUpdBjnCHDZANm09+/cTV8J3ZshRuiCs/zVwPpf4xNL16n7pcscLS+faKkUOK9eFul79FLWCYRRZs2x83z7htbCIYq/5xbdNva/Npr/mH9BWugxGtv92A01CNTdNOWqXXvAYcOsswSMJcimfGalsLOqrGbRbhz0K6M3qmu+di6kl2CB5qsEB+QDSp7pNZ321FIHGQnLqcJxstWXQnCJ6E1AFppk6jyYbezP4NczQr18OuS/Qxuk32E21KIJ2sXbtZZSzMxXnrWFkgVuCJqdEDt1UwiDusQZx0h1/z7Sz9HlZ3jbwScIZNWCLuldfnnOa22bcw==;5:ukRF3+lRqL8YJSszjMWY91Cc+hE8UjBOWbhWUNE4r/bFUEdSvzxKigfUMKi6Qc4nLXiOvItLFRFO9YBW4XoThtu61iOM3/mFDCpyFPIgOHjhv4II71D0yrfeSV4fr2Op/z/5BweEc5ofpwemFhqRYw==;24:Hy9kHjMeroHdKQpSn6sEcdZFD4Yg66eHQxa+eit5Q9NizHwGULKPVsMYyZopiMo/Hh8aInrjpxzfrIWiI4vpzeoODjwIRj/edJ6b3/L/NqM=;7:K6I88CoP9O/JSyOoz6xTO16UasuVpjl2UwerWjbNvKtOF1zobuhhr3vR8QaRKPqaJMNs+1oDbYobO/zU2ruknwnl++/tXzpYyCw8Oceo+TcTIbfwYmFW16hwz+CDcFgTJLG6ZglZe8HBuNkF4JZIe79PiRPFkFa+J3IIVacJbYd51c7w0PdMZpIRzt4fBJy0lEn++CGJPVO8mWj/4X9ctDtelS4FHc/ZdYLn9yipMiw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2017 16:36:11.8128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0466
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This includes the core.fsmonitor setting, the fsmonitor integration hook,
and the fsmonitor index extension.

Also add documentation for the new fsmonitor options to ls-files and
update-index.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/config.txt                 |  7 +++++
 Documentation/git-ls-files.txt           |  7 ++++-
 Documentation/git-update-index.txt       | 45 ++++++++++++++++++++++++++++++++
 Documentation/githooks.txt               | 28 ++++++++++++++++++++
 Documentation/technical/index-format.txt | 19 ++++++++++++++
 5 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dc4e3f58a2..db52645cb4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -413,6 +413,13 @@ core.protectNTFS::
 	8.3 "short" names.
 	Defaults to `true` on Windows, and `false` elsewhere.
 
+core.fsmonitor::
+	If set, the value of this variable is used as a command which
+	will identify all files that may have changed since the
+	requested date/time. This information is used to speed up git by
+	avoiding unnecessary processing of files that have not changed.
+	See the "fsmonitor-watchman" section of linkgit:githooks[5].
+
 core.trustctime::
 	If false, the ctime differences between the index and the
 	working tree are ignored; useful when the inode change time
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index d153c17e06..3ac3e3a77d 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -9,7 +9,7 @@ git-ls-files - Show information about files in the index and the working tree
 SYNOPSIS
 --------
 [verse]
-'git ls-files' [-z] [-t] [-v]
+'git ls-files' [-z] [-t] [-v] [-f]
 		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
 		(-[c|d|o|i|s|u|k|m])*
 		[--eol]
@@ -133,6 +133,11 @@ a space) at the start of each line:
 	that are marked as 'assume unchanged' (see
 	linkgit:git-update-index[1]).
 
+-f::
+	Similar to `-t`, but use lowercase letters for files
+	that are marked as 'fsmonitor valid' (see
+	linkgit:git-update-index[1]).
+
 --full-name::
 	When run from a subdirectory, the command usually
 	outputs paths relative to the current directory.  This
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index e19eba62cd..7c2f880a22 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -16,9 +16,11 @@ SYNOPSIS
 	     [--chmod=(+|-)x]
 	     [--[no-]assume-unchanged]
 	     [--[no-]skip-worktree]
+	     [--[no-]fsmonitor-valid]
 	     [--ignore-submodules]
 	     [--[no-]split-index]
 	     [--[no-|test-|force-]untracked-cache]
+	     [--[no-]fsmonitor]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
 	     [-z] [--stdin] [--index-version <n>]
@@ -111,6 +113,12 @@ you will need to handle the situation manually.
 	set and unset the "skip-worktree" bit for the paths. See
 	section "Skip-worktree bit" below for more information.
 
+--[no-]fsmonitor-valid::
+	When one of these flags is specified, the object name recorded
+	for the paths are not updated. Instead, these options
+	set and unset the "fsmonitor valid" bit for the paths. See
+	section "File System Monitor" below for more information.
+
 -g::
 --again::
 	Runs 'git update-index' itself on the paths whose index
@@ -201,6 +209,15 @@ will remove the intended effect of the option.
 	`--untracked-cache` used to imply `--test-untracked-cache` but
 	this option would enable the extension unconditionally.
 
+--fsmonitor::
+--no-fsmonitor::
+	Enable or disable files system monitor feature. These options
+	take effect whatever the value of the `core.fsmonitor`
+	configuration variable (see linkgit:git-config[1]). But a warning
+	is emitted when the change goes against the configured value, as
+	the configured value will take effect next time the index is
+	read and this will remove the intended effect of the option.
+
 \--::
 	Do not interpret any more arguments as options.
 
@@ -447,6 +464,34 @@ command reads the index; while when `--[no-|force-]untracked-cache`
 are used, the untracked cache is immediately added to or removed from
 the index.
 
+File System Monitor
+-------------------
+
+This feature is intended to speed up git operations for repos that have
+large working directories.
+
+It enables git to work together with a file system monitor (see the
+"fsmonitor-watchman" section of linkgit:githooks[5]) that can
+inform it as to what files have been modified. This enables git to avoid
+having to lstat() every file to find modified files.
+
+When used in conjunction with the untracked cache, it can further improve
+performance by avoiding the cost of scanning the entire working directory
+looking for new files.
+
+If you want to enable (or disable) this feature, it is easier to use
+the `core.fsmonitor` configuration variable (see
+linkgit:git-config[1]) than using the `--fsmonitor` option to
+`git update-index` in each repository, especially if you want to do so
+across all repositories you use, because you can set the configuration
+variable to `true` (or `false`) in your `$HOME/.gitconfig` just once
+and have it affect all repositories you touch.
+
+When the `core.fsmonitor` configuration variable is changed, the
+file system monitor is added to or removed from the index the next time
+a command reads the index. When `--[no-]fsmonitor` are used, the file
+system monitor is immediately added to or removed from the index.
+
 Configuration
 -------------
 
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 1bb4f92d4d..ae60559cd9 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -455,6 +455,34 @@ the name of the file that holds the e-mail to be sent.  Exiting with a
 non-zero status causes 'git send-email' to abort before sending any
 e-mails.
 
+fsmonitor-watchman
+~~~~~~~~~~~~~~~~~~
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
+It is OK to include files which have not actually changed.  All changes
+including newly-created and deleted files should be included. When
+files are renamed, both the old and the new name should be included.
+
+Git will limit what files it checks for changes as well as which
+directories are checked for untracked files based on the path names
+given.
+
+An optimized way to tell git "all files have changed" is to return
+the filename '/'.
+
+The exit status determines whether git will use the data from the
+hook to limit its search.  On error, it will fall back to verifying
+all files and folders.
 
 GIT
 ---
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
2.14.1.549.g6ff7ed0467

