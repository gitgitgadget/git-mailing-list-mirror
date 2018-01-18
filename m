Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4610D1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 15:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932690AbeARPgJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 10:36:09 -0500
Received: from mout.gmx.net ([212.227.15.15]:52111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932640AbeARPgH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 10:36:07 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJSLz-1efDAt06f5-0034Gg; Thu, 18
 Jan 2018 16:36:04 +0100
Date:   Thu, 18 Jan 2018 16:36:03 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 7/8] pull: accept --rebase=recreate to recreate the branch
 topology
In-Reply-To: <cover.1516225925.git.johannes.schindelin@gmx.de>
Message-ID: <59228b6446bd86863850665d0e1b29954b88f305.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:c+0bc6AbKWK6Q4jVEGTkUcGZ4zRS1OMlIZQWe+T1faaWXe/gwVP
 InGCnO3ke09/iR+A11hTXp0+iLHmBH83BL80IPV8FkoBIAz7lQ/7Qw779CaspdT8rMUjHJS
 NVivMtUM4I6Jf6ja1c75xTB+SqN2xMpOoTPeD0lMlAJl4jWDhmhWOtHNxbdPSfWMoJRF6GV
 jF7gqA00v72AOx0V0y68g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I1Dqtk5zPUg=:U3fRj4ae0grxgNIaqvIvVb
 WWjzWGylQFrOh2PkVtBvyLlE2o+xHpsZ2NsIb+/AYIAQc5xQjsRhdHo/RujuDvqvP2HFC9xT4
 WLIH6HsoGbWjRwELLM8gEiEP3mWyFsLl96xmddzFk4PjZ3PshBc/fdEh/2jZLt1WwuZBFkpDz
 96y/g/DUxKH42imXc9HNkM4H9oc/U6SSxuXoynoFbOwxeWYD3B7jOz9EeFHGdJKKjoDjptj8T
 L0KX27LSiBsuohK+Ab2bsOW/WFYVyzYvh4HO2u9Q7AuJE7r77ZBxBQRp9fJ9XHHG2aYXPx8aN
 0AZOXUPPOjuiW6ADk564SWCJZltSSnVKkskzeam6FedODCL4Q172clISdJ/nI56akqEvvkvDC
 TfDKUqN7MKw9HTYTlEIaSCTt+KrqieOtqUJdrMyqGIigKDkAtnM0HGOuv0wQthEUf4bFFk/os
 x5gBQq1ep0g7UqxzOZYb0A+qj7GMRnWxbZgwMukzw6/0zyslCVuR/jG2HVzOWOyX4xo+xtL6u
 kd+zDp13FP0KF2H51IQ61zvVY/Qb/Exv2Pco9cpO/LIiBYN7Xx1TgDcJbm6HqN7GEJ4cjtM8U
 ASLptcbsZBgz519jT9spMOlcGcEZIhINteJ57Gf+ID6vj2bvQIFI8/45SBOTahmGTPANELZow
 1V/0sjesn0GLsw3+EkUOfqa2FTcuuVktb0Vaz8TNcPX8kmE+L0TY8CCnGOnihCblC9bjaauFW
 OsBAPLlYCU/0fwPhQCJ5Om6eUE9rdAIuEoa+I+CWd/l+73wB2r7mTLnQ2rAdhrm0h9bZFXAnf
 VT1jm7hew091tQltxKmm+B9jdjKNgYAZMnCJ+Muz7hf7ygZMK8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the `preserve` mode simply passing the `--preserve-merges`
option to the `rebase` command, the `recreate` mode simply passes the
`--recreate-merges` option.

This will allow users to conveniently rebase non-trivial commit
topologies when pulling new commits, without flattening them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt               |  8 ++++++++
 Documentation/git-pull.txt             |  5 ++++-
 builtin/pull.c                         | 14 ++++++++++----
 builtin/remote.c                       |  2 ++
 contrib/completion/git-completion.bash |  2 +-
 5 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e25b2c92b3..da41ab246dc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1058,6 +1058,10 @@ branch.<name>.rebase::
 	"git pull" is run. See "pull.rebase" for doing this in a non
 	branch-specific manner.
 +
+When recreate, also pass `--recreate-merges` along to 'git rebase'
+so that locally committed merge commits will not be flattened
+by running 'git pull'.
++
 When preserve, also pass `--preserve-merges` along to 'git rebase'
 so that locally committed merge commits will not be flattened
 by running 'git pull'.
@@ -2607,6 +2611,10 @@ pull.rebase::
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
 +
+When recreate, also pass `--recreate-merges` along to 'git rebase'
+so that locally committed merge commits will not be flattened
+by running 'git pull'.
++
 When preserve, also pass `--preserve-merges` along to 'git rebase'
 so that locally committed merge commits will not be flattened
 by running 'git pull'.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index ce05b7a5b13..b4f9f057ea9 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -101,13 +101,16 @@ Options related to merging
 include::merge-options.txt[]
 
 -r::
---rebase[=false|true|preserve|interactive]::
+--rebase[=false|true|recreate|preserve|interactive]::
 	When true, rebase the current branch on top of the upstream
 	branch after fetching. If there is a remote-tracking branch
 	corresponding to the upstream branch and the upstream branch
 	was rebased since last fetched, the rebase uses that information
 	to avoid rebasing non-local changes.
 +
+When set to recreate, rebase with the `--recreate-merges` option passed
+to `git rebase` so that locally created merge commits will not be flattened.
++
 When set to preserve, rebase with the `--preserve-merges` option passed
 to `git rebase` so that locally created merge commits will not be flattened.
 +
diff --git a/builtin/pull.c b/builtin/pull.c
index 511dbbe0f6e..e33c84e0345 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -27,14 +27,16 @@ enum rebase_type {
 	REBASE_FALSE = 0,
 	REBASE_TRUE,
 	REBASE_PRESERVE,
+	REBASE_RECREATE,
 	REBASE_INTERACTIVE
 };
 
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
- * "preserve", returns REBASE_PRESERVE. If value is a invalid value, dies with
- * a fatal error if fatal is true, otherwise returns REBASE_INVALID.
+ * "recreate", returns REBASE_RECREATE. If value is "preserve", returns
+ * REBASE_PRESERVE. If value is a invalid value, dies with a fatal error if
+ * fatal is true, otherwise returns REBASE_INVALID.
  */
 static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		int fatal)
@@ -47,6 +49,8 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		return REBASE_TRUE;
 	else if (!strcmp(value, "preserve"))
 		return REBASE_PRESERVE;
+	else if (!strcmp(value, "recreate"))
+		return REBASE_RECREATE;
 	else if (!strcmp(value, "interactive"))
 		return REBASE_INTERACTIVE;
 
@@ -130,7 +134,7 @@ static struct option pull_options[] = {
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
 	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
-	  "false|true|preserve|interactive",
+	  "false|true|recreate|preserve|interactive",
 	  N_("incorporate changes by rebasing rather than merging"),
 	  PARSE_OPT_OPTARG, parse_opt_rebase },
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
@@ -798,7 +802,9 @@ static int run_rebase(const struct object_id *curr_head,
 	argv_push_verbosity(&args);
 
 	/* Options passed to git-rebase */
-	if (opt_rebase == REBASE_PRESERVE)
+	if (opt_rebase == REBASE_RECREATE)
+		argv_array_push(&args, "--recreate-merges");
+	else if (opt_rebase == REBASE_PRESERVE)
 		argv_array_push(&args, "--preserve-merges");
 	else if (opt_rebase == REBASE_INTERACTIVE)
 		argv_array_push(&args, "--interactive");
diff --git a/builtin/remote.c b/builtin/remote.c
index d95bf904c3b..b7d0f7ce596 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -306,6 +306,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				info->rebase = v;
 			else if (!strcmp(value, "preserve"))
 				info->rebase = NORMAL_REBASE;
+			else if (!strcmp(value, "recreate"))
+				info->rebase = NORMAL_REBASE;
 			else if (!strcmp(value, "interactive"))
 				info->rebase = INTERACTIVE_REBASE;
 		}
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6893c3adabc..6f98c96fee9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2182,7 +2182,7 @@ _git_config ()
 		return
 		;;
 	branch.*.rebase)
-		__gitcomp "false true preserve interactive"
+		__gitcomp "false true recreate preserve interactive"
 		return
 		;;
 	remote.pushdefault)
-- 
2.15.1.windows.2.1430.ga56c4f9e2a9


