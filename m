Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A095D20248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfBXKLj (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:39 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34096 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbfBXKLe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id a16so5241311edn.1
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OIJHk7VSL4iQyI0dnDPtYDbapOs8CNWw2zszEvxXEKA=;
        b=ohMC3YU7zx1LJyBL5o6ZRZ6bnKzAFhPvbjwwFNyCivnBmCI5TdTaOhOYZtFFyuNnp1
         RYT5zWBJ/FDLo2BoZIaOTtLFbab+bFEccsvl4BFIDCApT5z1REa1rnFnpLu8tDvmUynT
         VarxKunoI7BAWzzmi87LHFyH+RtSLpPlHg4U2Ph9xK3vY0SuPScWAOilkokISusN3ArW
         MaoRBp6TpMycZkVQGmpKrLXdu4ld2aFsxLSqgybcphBHYc0EP952U6Zk8nPPimhdnhdu
         fUA3cGWNwDZM2UIzqvkYefB9nwuZS3av6bJ5W/KfU7drGwWJT51duWR1f5cSW5E4/SRP
         8XkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OIJHk7VSL4iQyI0dnDPtYDbapOs8CNWw2zszEvxXEKA=;
        b=mEC3AbCwkSM7GrxyUXJJlrV77ykaj8Yjc78gD9uWX356nQ6w8W7uXqIVNMR8AjFFMr
         ucxu1M3z0jEWdB5zZxR5b/uZV40XZiQ9qq+rAG7rt9AwJVxrrRSHCd5Oika56Of2Zm0u
         rcHUVO+bRP5cgk03mV/FbDO1SR0f6YFHbGVy8cjSudmBSXegAI5cjW+UNvyuJJRbMOEM
         4n2YmOJXko6MQg5iEEKLlXRoIMVif/XoCx8oFrdvHqKoofhZ3tCEL2L5duMxjQf6Z7xK
         NI+NChGZ3wixM4gbQnWy4n464SDPWtuH67z4r+BgJ3wnW1iVRFUx3AOF2m9X6NAMdkH/
         A1JA==
X-Gm-Message-State: AHQUAuYs7+FC4aJq1zV+AqMHv0jw1CB7BwILL/VxnCq7+vpHyibmLowc
        ylSCJB3aDDyGaIwXtgP9gO3NgcBR
X-Google-Smtp-Source: AHgI3IZ1Gra1E8l87VDspz6f4gYoFp3hrPBYodvnHF796Nw2BbIZsoTmj2lcC3rc6muGfaSPxsoGYg==
X-Received: by 2002:a17:906:7b0f:: with SMTP id e15mr8802875ejo.143.1551003091271;
        Sun, 24 Feb 2019 02:11:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w48sm1817780eda.88.2019.02.24.02.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:30 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:30 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:08 GMT
Message-Id: <1e9034bb9de0e44be8ecfcc27ebc97d0dd4b44fd.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 20/26] bisect--helper: `bisect_replay` shell function in C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_replay` shell function in C and also add
`--bisect-replay` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--bisect-replay` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other method.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 123 ++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            |  32 +---------
 2 files changed, 123 insertions(+), 32 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 0a482d67cf..6a1920d3e7 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -32,6 +32,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-autostart"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
+	N_("git bisect--helper --bisect-replay <filename>"),
 	NULL
 };
 
@@ -899,6 +900,117 @@ static int bisect_log(void)
         return status ? -1 : 0;
 }
 
+static int get_next_word(const char *line, int pos, struct strbuf *word)
+{
+	int i, len = strlen(line), begin = 0;
+	strbuf_reset(word);
+	for (i = pos; i < len; i++) {
+		if (line[i] == ' ' && begin)
+			return i + 1;
+
+		if (!begin)
+			begin = 1;
+		strbuf_addch(word, line[i]);
+	}
+
+	return i;
+}
+
+static int bisect_replay(struct bisect_terms *terms, const char *filename)
+{
+	struct strbuf line = STRBUF_INIT;
+	struct strbuf word = STRBUF_INIT;
+	FILE *fp = NULL;
+	int res = 0;
+
+	if (is_empty_or_missing_file(filename)) {
+		error(_("cannot read file '%s' for replaying"), filename);
+		res = -1;
+		goto finish;
+	}
+
+	if (bisect_reset(NULL)) {
+		res = -1;
+		goto finish;
+	}
+
+	fp = fopen(filename, "r");
+	if (!fp) {
+		res = -1;
+		goto finish;
+	}
+
+	while (strbuf_getline(&line, fp) != EOF) {
+		int pos = 0;
+		while (pos < line.len) {
+			pos = get_next_word(line.buf, pos, &word);
+
+			if (!strcmp(word.buf, "git")) {
+				continue;
+			} else if (!strcmp(word.buf, "git-bisect")) {
+				continue;
+			} else if (!strcmp(word.buf, "bisect")) {
+				continue;
+			} else if (starts_with(word.buf, "#")) {
+				break;
+			}
+
+			get_terms(terms);
+			if (check_and_set_terms(terms, word.buf)) {
+				res = -1;
+				goto finish;
+			}
+
+			if (!strcmp(word.buf, "start")) {
+				struct argv_array argv = ARGV_ARRAY_INIT;
+				sq_dequote_to_argv_array(line.buf+pos, &argv);
+				if (bisect_start(terms, 0, argv.argv, argv.argc)) {
+					argv_array_clear(&argv);
+					res = -1;
+					goto finish;
+				}
+				argv_array_clear(&argv);
+				break;
+			}
+
+			if (one_of(word.buf, terms->term_good,
+			    terms->term_bad, "skip", NULL)) {
+				if (bisect_write(word.buf, line.buf+pos, terms, 0)) {
+					res = -1;
+					goto finish;
+				}
+				break;
+			}
+
+			if (!strcmp(word.buf, "terms")) {
+				struct argv_array argv = ARGV_ARRAY_INIT;
+				sq_dequote_to_argv_array(line.buf+pos, &argv);
+				if (bisect_terms(terms, argv.argc == 1 ? argv.argv[0] : NULL)) {
+					argv_array_clear(&argv);
+					res = -1;
+					goto finish;
+				}
+				argv_array_clear(&argv);
+				break;
+			}
+
+			error(_("Replay file contains rubbish (\"%s\")"),
+			      word.buf);
+			res = -1;
+			goto finish;
+		}
+	}
+finish:
+	if (fp)
+		fclose(fp);
+	strbuf_release(&line);
+	strbuf_release(&word);
+	if (res)
+		return -1;
+
+	return bisect_auto_next(terms, NULL);
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -912,7 +1024,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_AUTO_NEXT,
 		BISECT_AUTOSTART,
 		BISECT_STATE,
-		BISECT_LOG
+		BISECT_LOG,
+		BISECT_REPLAY
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -938,6 +1051,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
 			 N_("output the contents of BISECT_LOG"), BISECT_LOG),
+		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
+			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -1015,6 +1130,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			return error(_("--bisect-log requires 0 arguments"));
 		res = bisect_log();
 		break;
+	case BISECT_REPLAY:
+		if (argc != 1)
+			return error(_("no logfile given"));
+		set_terms(&terms, "bad", "good");
+		res = bisect_replay(&terms, argv[0]);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 151358aeda..0555191c41 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -77,36 +77,6 @@ bisect_visualize() {
 	eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
-bisect_replay () {
-	file="$1"
-	test "$#" -eq 1 || die "$(gettext "No logfile given")"
-	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
-	git bisect--helper --bisect-reset || exit
-	while read git bisect command rev
-	do
-		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
-		if test "$git" = "git-bisect"
-		then
-			rev="$command"
-			command="$bisect"
-		fi
-		get_terms
-		git bisect--helper --check-and-set-terms "$command" "$TERM_GOOD" "$TERM_BAD" || exit
-		get_terms
-		case "$command" in
-		start)
-			eval "git bisect--helper --bisect-start $rev" ;;
-		"$TERM_GOOD"|"$TERM_BAD"|skip)
-			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
-		terms)
-			git bisect--helper --bisect-terms $rev || exit;;
-		*)
-			die "$(gettext "?? what are you talking about?")" ;;
-		esac
-	done <"$file"
-	git bisect--helper --bisect-auto-next
-}
-
 bisect_run () {
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
@@ -202,7 +172,7 @@ case "$#" in
 	reset)
 		git bisect--helper --bisect-reset "$@" ;;
 	replay)
-		bisect_replay "$@" ;;
+		git bisect--helper --bisect-replay "$@" ;;
 	log)
 		git bisect--helper --bisect-log ;;
 	run)
-- 
gitgitgadget

