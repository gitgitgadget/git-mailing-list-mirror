Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 470621F404
	for <e@80x24.org>; Fri, 23 Feb 2018 12:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeBWMjs (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 07:39:48 -0500
Received: from mout.gmx.net ([212.227.15.19]:58875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeBWMjr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 07:39:47 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ledpu-1eOR8t3gsQ-00qNpg; Fri, 23
 Feb 2018 13:39:41 +0100
Date:   Fri, 23 Feb 2018 13:39:26 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 11/12] pull: accept --rebase=recreate to recreate the
 branch topology
In-Reply-To: <cover.1519389319.git.johannes.schindelin@gmx.de>
Message-ID: <f475b92b9ae8ef946512841cc539f7881372b63d.1519389319.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519389319.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YNcTbvsW2Velnc3wIh3vR0EQIokrHqYYUkXbV4A8aFa6TKRmYaS
 0wJ1JPhHeUx1kcJJn1FLIdqe79q+deRxxWtYSU03FiDBxyYZYkybkyN/AsUhO3ADmk+gcix
 crAB09N3eNAnLCsPaOa3m7a2yfnXkMwLkmbct37DwU2Xrq9WJiW62rJNXyznB6Sm0WVVhBl
 jVw2ePub3DKqFR4gTea4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c2CsQMC5vts=:FqHfI8oAalLp0BTfuTwa9E
 AYFDEV4EniWinfIl1GJtR45O1BjmPGPb4I+R7NSLncuMf5GfmyZPttPQzCUWdCCzd2yG06A7y
 53cGsOjxNcpYV8QhGi8MAnNXaZlOlQ/QR5FL2dSaYYc8dY6K8gKAqMHVDR+N2TidP9MaxBnmw
 Ejvahk2P5Dc6qPndn2olERQdhh8w0RTIeFYbMeDZZrQN1rF+DHGnD7bNoQx9gOxVuP3a1KRpZ
 d+DNiLJc5HSiswFLkNqI91SUdNLV3jpim6OEcz0TVJiJ1jzPb0MLE7LlDF5UdLdwmijDsiSIU
 G2bOFqlcGXxlmLt/JxVmWxo66PuMBK8m3OgjuVkAcYqR7FUaUEnXyaARmqu3icsRivHs9q540
 IbV1NAHTQwTLf6u/mx2n+RcU2HfAR/3YOrhoE3NJSyVr3VOPniXuXmU5t05C34mhBgNr8uc2S
 H0ldjanhnVpAEh7Xqm18L1SHAT2eHo79EIYCl6ubd2fmdFe7oL+iBJwX/W3SR8TaJnw833Yb9
 QtZduJ+RelliVFQJD/KbW03KOKWv1WSLPflhfjQc2RyTgLMxOpQnYT5gqUJTmAqwx/hJbfeZz
 zlgkVDBgCZ9ln/B2bIgZ/rX7F8xxPz4TtXnOEZR6o4w1gjLFbQdndhnIWh7FE+UHN4ea+RzZY
 ceolWbzeWmkrmKmWghrhO0lztDqsV5Ja8KR239Qx7iMMcJPZ5Spm3I7fRWor17Cak0gjHRU83
 68AtKDzCvVRI6Ak7+6cTymO4TOs9uloDlzKa33m4ScKblePW8P2V2PS1b/pTUwt64mk7IOVWS
 jYrq48njvVzJFkwykRgUoGr7ObN4WEui/t2BH8WhLtUnfl1zjA=
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
index f57e9cf10ca..8c9adea0d0c 100644
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
index 1876271af94..9da2cfa0bd3 100644
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
@@ -800,7 +804,9 @@ static int run_rebase(const struct object_id *curr_head,
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
index 38bba3835c6..3d44cb6890c 100644
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
2.16.1.windows.4


