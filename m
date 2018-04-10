Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A96D1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeDJMad (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:30:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:54191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753174AbeDJMaa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:30:30 -0400
Received: from minint-aivcfq2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MSdNs-1ew0Vf0ry8-00RYEG; Tue, 10 Apr 2018 14:30:23 +0200
Date:   Tue, 10 Apr 2018 14:30:22 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v6 13/15] pull: accept --rebase=merges to recreate the branch
 topology
In-Reply-To: <cover.1523362469.git.johannes.schindelin@gmx.de>
Message-ID: <e975f86e5598923e98ab4ddbdba1d3e344f2dc89.1523362469.git.johannes.schindelin@gmx.de>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lGKyeyW8jcA9QHrxDIx09OnD0ZljrW6r+8FCcpNV5SxGqFIAPNG
 W/hNGMAP4PoePTdHWotudgrS2sL6kicrKsJ16bCbPp9svKr69b4AuYNq6yXWCxeVq79Z/Pj
 UItD7YSVGeYrIUhpZbqahOlu/4i6K/1Jv9NkWotuCvwwJLLDmQKs8uhEDCq0mRx/6tOO7xp
 CDsflaGb2Ed0yjF9avlVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H7E5IQCReIg=:z7QQ/ERS3A4iMOt+wIb4Vh
 LPmfzY1xaMZJfxkbLlXTkNzAwFrJB9kx0d0P8ubM/uLp9h9VLGG67h5YgT5l6rgtTIcTPQBko
 nvc/PTSXC2XHZ9lm82itSseN+SqXIYGH0or+PudM+g6PpC+hMo+jOfw7DZEgIzTwXiycb4mp/
 2f27y4CQ9X1qrFTPdSAdPt+iXW5bqIGyPrKNmyH6zNXqyJJpTffskgI8thZ3z+9s2U9zpOkw1
 Kfb5gV3FDNy7X3fb228PADeF/mPZijCZaiTYCaCN8bzJteohxoiXDOfaLd3/cvHuPa6jomjGd
 WMlGKho9TlUgAaajfmsIkE2+LLbGHH7ZimZ1Xczws88diccHD4Qr2tDpgu0+w1Szdy29lZait
 VeSkLLcXdFD86fQ3aCVx4zVERlE1AJv80rnv/TiDVqRdNL3r5PZh/K7CE70utblFW2JsgNsyG
 eRVYgiMLATWD/btPkiNGtf51R7jWrE+JnMDjLQc0iArHSJGs1DBihtNvWthM69vMhULswg8uX
 4Zxu7gAv6o1QPNpoWov3ov4hch0JHkJTJpbluEVeT4gnJyF2KPHG337Ff3qYQR+yKl0Wu27z8
 tT133PG+431nY7rpRrGR8qaYEEsLT2o1emaO4dbo4WOS/E9egv7+wXIfsO+zYp+VtTjhALX2R
 bd/yiBw3AmoQx4SbofX7ec0rj5y7YNcZ2vWPq15WvH751MhEvqR79VUPKktzQUfWbBdugHBx6
 y8Cz7gZA8bfUEL2pKo+Zeje6pmnkfIbV7l8sqQodLzHU7lAb15bnSK7kD8wQcPFAjpmhmqd1Z
 l4JFCHYh2Y1e0+Xw/4n6NCzu3+AWnhgfCK6HW9Ko60YUj572JM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the `preserve` mode simply passing the `--preserve-merges`
option to the `rebase` command, the `merges` mode simply passes the
`--rebase-merges` option.

This will allow users to conveniently rebase non-trivial commit
topologies when pulling new commits, without flattening them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt               |  8 ++++++++
 Documentation/git-pull.txt             |  5 ++++-
 builtin/pull.c                         | 14 ++++++++++----
 builtin/remote.c                       | 18 ++++++++++++++----
 contrib/completion/git-completion.bash |  2 +-
 5 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4e0cff87f62..45916ea8104 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1058,6 +1058,10 @@ branch.<name>.rebase::
 	"git pull" is run. See "pull.rebase" for doing this in a non
 	branch-specific manner.
 +
+When `merges`, pass the `--rebase-merges` option to 'git rebase'
+so that locally committed merge commits will not be flattened
+by running 'git pull'.
++
 When preserve, also pass `--preserve-merges` along to 'git rebase'
 so that locally committed merge commits will not be flattened
 by running 'git pull'.
@@ -2616,6 +2620,10 @@ pull.rebase::
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
 +
+When `merges`, pass the `--rebase-merges` option to 'git rebase'
+so that locally committed merge commits will not be flattened
+by running 'git pull'.
++
 When preserve, also pass `--preserve-merges` along to 'git rebase'
 so that locally committed merge commits will not be flattened
 by running 'git pull'.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index ce05b7a5b13..6f76d815dd3 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -101,13 +101,16 @@ Options related to merging
 include::merge-options.txt[]
 
 -r::
---rebase[=false|true|preserve|interactive]::
+--rebase[=false|true|merges|preserve|interactive]::
 	When true, rebase the current branch on top of the upstream
 	branch after fetching. If there is a remote-tracking branch
 	corresponding to the upstream branch and the upstream branch
 	was rebased since last fetched, the rebase uses that information
 	to avoid rebasing non-local changes.
 +
+When set to `merges`, rebase using `git rebase --rebase-merges` so that
+locally created merge commits will not be flattened.
++
 When set to preserve, rebase with the `--preserve-merges` option passed
 to `git rebase` so that locally created merge commits will not be flattened.
 +
diff --git a/builtin/pull.c b/builtin/pull.c
index e32d6cd5b4c..70b44146ce4 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -27,14 +27,16 @@ enum rebase_type {
 	REBASE_FALSE = 0,
 	REBASE_TRUE,
 	REBASE_PRESERVE,
+	REBASE_MERGES,
 	REBASE_INTERACTIVE
 };
 
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
- * "preserve", returns REBASE_PRESERVE. If value is a invalid value, dies with
- * a fatal error if fatal is true, otherwise returns REBASE_INVALID.
+ * "merges", returns REBASE_MERGES. If value is "preserve", returns
+ * REBASE_PRESERVE. If value is a invalid value, dies with a fatal error if
+ * fatal is true, otherwise returns REBASE_INVALID.
  */
 static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		int fatal)
@@ -47,6 +49,8 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		return REBASE_TRUE;
 	else if (!strcmp(value, "preserve"))
 		return REBASE_PRESERVE;
+	else if (!strcmp(value, "merges"))
+		return REBASE_MERGES;
 	else if (!strcmp(value, "interactive"))
 		return REBASE_INTERACTIVE;
 
@@ -130,7 +134,7 @@ static struct option pull_options[] = {
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
 	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
-	  "false|true|preserve|interactive",
+	  "false|true|merges|preserve|interactive",
 	  N_("incorporate changes by rebasing rather than merging"),
 	  PARSE_OPT_OPTARG, parse_opt_rebase },
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
@@ -800,7 +804,9 @@ static int run_rebase(const struct object_id *curr_head,
 	argv_push_verbosity(&args);
 
 	/* Options passed to git-rebase */
-	if (opt_rebase == REBASE_PRESERVE)
+	if (opt_rebase == REBASE_MERGES)
+		argv_array_push(&args, "--rebase-merges");
+	else if (opt_rebase == REBASE_PRESERVE)
 		argv_array_push(&args, "--preserve-merges");
 	else if (opt_rebase == REBASE_INTERACTIVE)
 		argv_array_push(&args, "--interactive");
diff --git a/builtin/remote.c b/builtin/remote.c
index 805ffc05cdb..45c9219e07a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -245,7 +245,9 @@ static int add(int argc, const char **argv)
 struct branch_info {
 	char *remote_name;
 	struct string_list merge;
-	enum { NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE } rebase;
+	enum {
+		NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE, REBASE_MERGES
+	} rebase;
 };
 
 static struct string_list branch_list = STRING_LIST_INIT_NODUP;
@@ -306,6 +308,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				info->rebase = v;
 			else if (!strcmp(value, "preserve"))
 				info->rebase = NORMAL_REBASE;
+			else if (!strcmp(value, "merges"))
+				info->rebase = REBASE_MERGES;
 			else if (!strcmp(value, "interactive"))
 				info->rebase = INTERACTIVE_REBASE;
 		}
@@ -963,9 +967,15 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 
 	printf("    %-*s ", show_info->width, item->string);
 	if (branch_info->rebase) {
-		printf_ln(branch_info->rebase == INTERACTIVE_REBASE
-			  ? _("rebases interactively onto remote %s")
-			  : _("rebases onto remote %s"), merge->items[0].string);
+		const char *msg;
+		if (branch_info->rebase == INTERACTIVE_REBASE)
+			msg = _("rebases interactively onto remote %s");
+		else if (branch_info->rebase == REBASE_MERGES)
+			msg = _("rebases interactively (with merges) onto "
+				"remote %s");
+		else
+			msg = _("rebases onto remote %s");
+		printf_ln(msg, merge->items[0].string);
 		return 0;
 	} else if (show_info->any_rebase) {
 		printf_ln(_(" merges with remote %s"), merge->items[0].string);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d4c0a995c39..6af65155c59 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2120,7 +2120,7 @@ _git_config ()
 		return
 		;;
 	branch.*.rebase)
-		__gitcomp "false true preserve interactive"
+		__gitcomp "false true merges preserve interactive"
 		return
 		;;
 	remote.pushdefault)
-- 
2.17.0.windows.1.4.g7e4058d72e3


