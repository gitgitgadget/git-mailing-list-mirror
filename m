Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2060E1FAE2
	for <e@80x24.org>; Mon, 29 Jan 2018 22:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeA2WzR (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:55:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:52114 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbeA2WzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:55:14 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MCtql-1eWdQW14jr-009gdD; Mon, 29 Jan 2018 23:55:07 +0100
Date:   Mon, 29 Jan 2018 23:55:06 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 09/10] pull: accept --rebase=recreate to recreate the
 branch topology
In-Reply-To: <cover.1517266437.git.johannes.schindelin@gmx.de>
Message-ID: <b944d8674039072972089e09bb10b9797f1f7070.1517266437.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <cover.1517266437.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NoGcSqH6RVBLX9LlC1wxnYZUrnYhAffKXKGTdgRykOhGlDKo0j0
 RTobZezx5xay+61LhZETxTWZO1e3RVgmLstebshtqyNrv+onoc+EErW0GRGjbeb30L9ht0a
 5u95CKgaCqdD5USulqbKlivzIbYP8Uh4ARV2dYuurXaYRcSr9RufPEQ70bH0HCFn0NcIZxB
 ZWOfEYaW9/uCTqNcivHeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TLQGVFmrMj8=:/fzZFLTJR3ADcsfroz/aLL
 xrwxA4/gRl8qqIfqn80ysJx0jbEhP0lRbheb+rZs34LJuZBVGiKjsSlkrASYAixqg6al3luWa
 bWlqn1NYcA7SagR3e5n4oPEuzaRTayMEteW0CBacn2+uS95/yr6LBWr16ny404XWkIHn9BJsB
 hQJFgAMU5DCAGaOvxnZ07zfzPgjpVrQIDELrjH8o7rVt1YqjmpY6lK99BNaoQmc5TM4/UMrkY
 Kme3K91qCAVqjf8iqvJfXY5C3rVoVJflNap5KeD6+eUW0aHXQHoWWhHTohGWIQsxvjyoaInu/
 7DxZcErA590j58paPbFZPBZNg3BpF5d1WpQZnBCVeHCPqlLc1v0/1SQkkksePM5XU9alqgJl7
 gZMYpIn0tf6uKQHbHCYbSwBFwjNCUo5P+HdngL/5UYMWRlCUO1gztafZQGTingJAtX6ki+Zny
 W1BFFHtnnbc/X1e9SAce7SZyTAAbj/CAYhBmvwNAO7Y/fSplQm/q/hzzGMp9NgjKSnMWgfeWy
 twHtEIRHOD6Uh1NtNXE33VMEthIMZZtTzf9T72FEjwkx4rvuwFMnMTeX4HzCowAK90VpbkhTq
 ZI/hd5SpY2OlXbgyrC+aSQOz+tCktgjX8aiOF9iEhh2t9sKrVtHmNkepBp3g4GlNY3VjsFi0E
 pBW35kUbGgJZxE5rtExNlH1yw6lD2ETVpTZfBslaDsaNkigFBHW3jpMFTAvJxyMSoYnSDGt/O
 xmpd9azoyt0odl2+IyLnuzoaLlGspM2f/Fi7VoFEbKaJyX33awLrQTACvt+SC8nJghcGh1tcj
 FUY5DRUVgsdYU7yqHQiSfTIHXfC5Zai+QmsTJJ0kIbmzTeaWSnUdtSipnIoUhbqyBaKsaYB
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
2.16.1.windows.1


