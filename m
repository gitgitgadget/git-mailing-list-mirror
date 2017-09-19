Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF2F20A28
	for <e@80x24.org>; Tue, 19 Sep 2017 19:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdIST2j (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:28:39 -0400
Received: from mail-dm3nam03on0134.outbound.protection.outlook.com ([104.47.41.134]:8672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751397AbdIST2h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=p6fs8GJcuRsc6oDfUnBic62Lx+ptTXQSLTsUdzkCOhc=;
 b=nDsGLtvBQGUUyA6TY+gRsQkgEe1SPFADWj+I36GXC6boWAW716h/TlAo7tNwtLuByAHGfifbrzG+42cpOHk8gnwZJsV4xDIXNVSbSafQBpVnueP/p9U2C9IvILK2iQqVVAyfOV8GE2krUui8wXNIlqp0GT/1Mcf7+RibNOAHkBM=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.1; Tue, 19 Sep 2017 19:28:31 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v7 05/12] fsmonitor: add documentation for the fsmonitor extension.
Date:   Tue, 19 Sep 2017 15:27:37 -0400
Message-Id: <20170919192744.19224-6-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170919192744.19224-1-benpeart@microsoft.com>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: DM5PR03CA0030.namprd03.prod.outlook.com (10.174.189.147) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f44fc73d-bc4d-4bed-2bce-08d4ff949d66
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:AI3VUvWlDBQAIobTMFDyzg1Paid3hk0J6pyBLgu767DoLx8Q6cRUB0Ic3WiKWy7suaSg1uGUhebpZNOjsQkny6AMEv1VudHcb355x3rJ5JZQ3xpDLKw4i+E/1WOuCrjjr8wUJf/QluJArV4++Dwo9E0ziqppZJYQQCuxMj8owEE41tfHE3saDRR3dGF1EnfWvHlHA85uiprDICZkA3OWXNk0iEPEgGiEDBMIIi3mWdNKoEAOk1MSkXRNRpUFij6w;25:WFxxy2VcEKdoF3+wGvMrHoizhJAjBxZf1UbJpOYUfoP82stClSNqIptHSMUSwxVo+Hbp7e+zrjBUnLouiPH9a+1TcyxoZKD7e4Y3U6JUVLbHoWTxcaP7MjHikgsz+RUpHCYCEAQicYbR0EuQePtA6NfEgdPUkcerio64U37PrEZWdeDN+StJbSDRTv6gps8jupDuy8moCOxNjg9SKypM5mh1byNhBMOj2zpr2+3T0ISjNF2w4x6JWKoQzbHpTgfunLKshH7n/T6qVWaOU11/6b3kGmg2xsmTISV7eC6T9STFzHG+I84V2AnticxC+5RF5LRsjyTskOy0c4U1CpMqHA==;31:GT8NcWIoqagqx0ENG+dTuRSY2ygvOEQJ9gFbj90VaJTN0MO636QczzwDlLfAGaCmX3fWKNWNu5xwSAQ4CfDkypdw8Vam1HXp8cVQPwCMm2yDDi6xZBfO/ptKxduXwVkynJJwwb1+LXqsg+AErpPMYKZkBBaGmyd/BP+0VgUA0SQjR4jlnKIjsz+5heRzjoPYspYHgMvzCc+WVlU7W/wDunNgByhVfbEM4jfMgbzL/IE=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:pmzIhRBySgpO4IZoXII+79UeuKpNYPKI2v7XUEdgtLrQkK7P6YRKDKtQlO99zTBMEhsH+nENJNQOZPPzP5wIHoYf8aBY8ft9R1xc3XbVfbdMHowkWEpXw3uK+lHEPFpgstrh9a3TtSIeaQO9IDud3AWDJmngM4fC8bZ2IyBQ7zH8Jsznm+/j86Q2Vqdhqidi8TY7BqG0GzljkgU0H0gwICclXUf7vTUQgb2mCkcdsvSw+liw5N+gVDzF7omQMmtxFYlTykMYqC9tLJSQYXMj3qD4J31MyTQHG+Y9Nl2rXVhVn+LaZmVJvjAXMjKuYlGaYFWjxYNbokbE98Lj+uQoSLhhhNrg+xqVHWtce+YzOl/3avoWUPAdoHYbYnta4OVM8XL/8y0ZO7Aib9900qQli/+QzkNcgwbOcywaf2T4XZEK+iFtiMq3a4bedGlog8+dm35YKQUw/ujYwjKbultbyekeMP1NyGhFmpAksJyVAzWTMF9obOXyfv89NXNESPyH;4:WEq/7VsyupexCVboUjptPcY9WRAJ+/+UBaR4srhky5+DPYZt/H7AyxsFGbT06JNH8vaaIHJQsAMk5DaI8ARehNjQTKHLSR0lte4UTamqe6DooRU1APUPRUtZAJYc8sOgCvO4KuLaslQS/mTzhhRY8K0U5VE8nFKJ/ApQ99MCuKGipybLMqVYpcOap5fdiz2v7AjcE/CmrXTm4e9S/3IjflzHnokEWuzteAdD2AZNADukALZxKJE25+Km9ovLd1JgSgvq82HQC+5abj8uq5X+AIzeF2pUCDsJeQknSt3s6F4=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB0471EA3D1FE801BE05F8AB3DF4600@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 04359FAD81
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(25786009)(1076002)(2906002)(50226002)(478600001)(6486002)(5660300001)(33646002)(48376002)(50466002)(36756003)(8676002)(16526017)(10290500003)(316002)(16586007)(37006003)(189998001)(97736004)(3846002)(22452003)(86612001)(81166006)(575784001)(6116002)(305945005)(6512007)(4326008)(34206002)(101416001)(39060400002)(106356001)(105586002)(8656003)(76176999)(50986999)(68736007)(53936002)(2351001)(7736002)(10090500001)(5003940100001)(81156014)(8666007)(72206003)(2361001)(1511001)(8936002)(47776003)(66066001)(2950100002)(6506006)(2421001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0471;23:1fcD3omL3Np4t+Jsy+aeWsH/YO5bTNUcpAROonWua?=
 =?us-ascii?Q?A6a9LVdpqDhM6tGtSveXu6f9YaAb96PWve5XfzzUdgmY8dI40enyexkdIgOL?=
 =?us-ascii?Q?uKsrGpkyogbkYMZupOabtZsYL2Bq6nm/xrD8GiV4tNgQ0Fh0kOTrCVYcN/c0?=
 =?us-ascii?Q?1TwPn9XlGSgI81ZcVmUM1yFC7g+wWykAzwkUqlPUyI9PVJUUWacYEmw42M0c?=
 =?us-ascii?Q?3FhpOaIe+5tamahFt6BbJGrbPPzSk78YilWh594py9I6+sjK2bfJC3E8iyvA?=
 =?us-ascii?Q?6qe+7B316Iht5LdVEU3tXFTYOika7ygUbVa0IU5ywTWdUG56ZZHx89JuICw0?=
 =?us-ascii?Q?PdmbKbWejcdlVeWwTV4EjK6Y9YZfV80mRnGhtczsOLXQC1zhX8MxiThh1olU?=
 =?us-ascii?Q?8h+SAoAk1t7LrjcA2NNYgQHzINqaX1L9HRV3uzGkt1i9EgL8UkF8YImSWgDV?=
 =?us-ascii?Q?8m581G2c4jmNAgmgnwk+dOCzOvO2Lz9ozwrsNEKHCNIE/4ZuXutANefMmVpu?=
 =?us-ascii?Q?uxAKDnZCj3+tIb8K79IuNKUa5ThN5HZ6VTtPR+68OC3H37Xz1DkAO0xItjUh?=
 =?us-ascii?Q?gCD1gYWPBTfhqcJ2nJVjJe1RP2CQMRExnOQkSi4ODO4b28MYmrA2svCc9Jsv?=
 =?us-ascii?Q?OHXeWlp8ZGlBm5dpzKaBUkbR1FyqEHBdaeI8uwaiwPD4x2NC28aWylOH1Ocw?=
 =?us-ascii?Q?IFofZ07OQR7ko+LVHtLmVP4ZgVLUGB3J3UFoAUCTH1e0OJKA1UVXgt2BjlxO?=
 =?us-ascii?Q?Nlw4a+aZs9nT1f7IpxKCCiFoM/kACqKcskpCJlXzxJBUH98b6ybzViReqvWF?=
 =?us-ascii?Q?ONax236qAX29skCNlY7yB1TiieztEtQYtX44nET8hqubcwutDjFaALM6Vv3F?=
 =?us-ascii?Q?xPMid9rJHc63He8WC+yo6rNZZfOz290eaIYc1d/bo8JPmlrJjXcCzKgQTP+g?=
 =?us-ascii?Q?VqVgmtwnlXK3WngqNMoX3RyjWC0aAFlGuMkU0xra/4sDbxkbZ+0ZrK2nEkNq?=
 =?us-ascii?Q?PwIqqOl75BwvQ5t2Ts2evFwbbBZn7cV5KDZXAZ1sez26GszCAbM+2l3i3b0f?=
 =?us-ascii?Q?CNpQDNcIAy2ikI3impBAZwAjBZDQSRX7gn3Xx9EGfZ/ZFIQ3waS6p1/eaNWF?=
 =?us-ascii?Q?o60ZWSzYcYf6om+rWTqsZ1QbVawrw1DtY0Qbob7vo2tW6pWXKJveoPr1ANJ/?=
 =?us-ascii?Q?L+muGfs/JQOBINRkD8OwehdmuR2XvnTFIOwcNdFh8WHlumr/BzBsr/pm9z9G?=
 =?us-ascii?Q?ukEAsapjRguH2k8TC5sRIX7O/7wai2dtSe6xuiNTJagi7PqUIMBJxMU4Hy7+?=
 =?us-ascii?Q?bGsxyfrlpWEAZXvX1Zye7SfCSQqSTkCDnOVtpi6ttaivs0qQFZdnI+2QF+bP?=
 =?us-ascii?Q?KFET8vQDCPBy7w7Xs0nTS8/jWQgSojJyt03ZS/2O7GHa2sSDXYBuA0pldo7x?=
 =?us-ascii?Q?vccWGJEbMfyfYuNA35G996ebkUzAto=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:p0JWuwraU1QIjjv3stv+Y1IGGg0xgyve4bvc/AbhcdgHRBI0v3ZwanIGyNKbF7Gobz1tUYeEqHeqOLKp+yqa6RiRc0vcTXLabO+oLuK2lun5BBtfiTHXOClTX8LaFUAMetTfLYES/FPmFvg5yN+YUCut7E3lMw+vEOyPk+RSdgMvN4PbYyfsvjXk9br2fMRj0ua7wdiyMmaWOuFIHSYvLAUXZRheGjKc31wI7RwyAzsSs6Yp+/yVmoJxvzAfAPBFKMdiyP2mEeS7jz73RXbMh2q5oca6XI+PdlEyjLH3mwEkMMKBmQFKE6uTORCV3rl/UDC33vlUCJEfv8bJv9X4JQ==;5:7n0sFV3MPqdMFuQ7u2RgWXNG0hyyeTzCdjtUe3ui2NFyZ1bs6ExAWXdtgCo4++V9S0sV+lT5DorIHFypEd5SpAsOCpgixx/ykUlb95iCZEk11tVWLAkDQ9X7qmxzW7FoMGfa8UjEjq+ZuI/B5DZQWg==;24:3vEw1lqXKIpy05GPO1Urb1m1GacLgb8jgUxXwqm0qw7h5lN1+qGwnnPeGnQlIPnJ43BV/Iw5L/yLHoAMBheF/Pp3qaTqkw0tkTo2/Qmd8HQ=;7:M60V5VoCcLfm7lxLjl+mMBkUFVfOmfwzHJBoL7yrMKI+6lZVwQMxZKW4P28kOkQ0xXIMS1oAhNyF7T8HIl8qHyR90Jz9KBhtVwHQhinfIOzpQRyHQEMJw2suev9jGSlJEkcAvY/QpBDSGFne/WW/HHN5a+UuqPgI37z5ILBOBfpU0coKYT9BiFFGzRaqMGLMRzr0krIiVyofwkmTCr/+NFV45Ca9st6VinzhxfIHBoc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2017 19:28:31.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This includes the core.fsmonitor setting, the query-fsmonitor hook,
and the fsmonitor index extension.

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
index e19eba62cd..95231dbfcb 100644
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
+performance by avoiding the cost of scaning the entire working directory
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
2.14.1.windows.1

