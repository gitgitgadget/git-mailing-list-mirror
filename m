Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AA15202AA
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfBXKLp (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:45 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42401 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbfBXKLa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:30 -0500
Received: by mail-ed1-f66.google.com with SMTP id j89so5191285edb.9
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KlJ9cMpqDkWyoV0Jjrl+Y9ejaSD6ZiIhkgFYc47D9Co=;
        b=FmAa/ntyjpJnHa9wBd8htHWvqb165X7Qhr6TbhyPk2rvl8hRoQR3nn5iwByVj5vbNA
         SVndSRNKAWy7n0S5WlbK0FbEqXcpq+60CCYRo1SVkaPRQIEr7nlxik/xpM+0CIjekz/B
         Ee/r/GXwS45dppiAS2nDecKzDNHVlrMovvQnDAjamnseYf30ItAqpfmjoFwdPK3K8dcl
         QJnpAkFC9Ps33UJvjw/jKcZwoMfEUuX0XCGZWy5e797sC7EQ8n9GdAh0xbOOyI3fhXFi
         xptnSvd6fAUmwv+NOj4DYRJz8XA2kw8wo1YXDVZBV5Fk0mlr39Qm8Zn+yqhqKybpnaSl
         Dw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KlJ9cMpqDkWyoV0Jjrl+Y9ejaSD6ZiIhkgFYc47D9Co=;
        b=jE8a8AjRuLIz2AZyYT3pQCJBU0WehQk4yI7N4gNOz758P00ddq+9w8lt0dxXLZyMHr
         tqqEYw+JLjD4HwE2S944JXsq/4n/iNVOPw6pzbnbD+MoRnVURjSjzG0CLks78jFAzOHw
         RkxNWnYpC8d3jpY2981kzpSp1f0FPb4skzkdesQkweJqBD3jMI/MLdlLrYChcSx2xhxm
         DnfRUaQRy5Ib4+CQeavxPxkmOjzOLMoLIyoONoHKJFOYojttND3g6R0dHgdt8U6aMMaR
         6RlrluLTyiXndCJ+HwsFcccvoBuDuovbcEaWLZW7trPkOCr/Xd4HC0NrhDznyldXAmqS
         QYog==
X-Gm-Message-State: AHQUAua3I7IwYgM8EfAEE4MLc8J5T37mfM3fF4yOX6NopkaqgExG9ftX
        x8UcwwIEvYeSSaMhLrcNm1pewQ1x
X-Google-Smtp-Source: AHgI3IahJ5JBdw5srMVBqD5hkla6m7r5cx5KDc/QpDDX57QUSg4oQCAure1cZx87B/ioyxmRg+37wQ==
X-Received: by 2002:a50:a7e6:: with SMTP id i93mr10158363edc.193.1551003088187;
        Sun, 24 Feb 2019 02:11:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h22sm202440ejj.43.2019.02.24.02.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:27 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:27 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:04 GMT
Message-Id: <8e011fa67a0bf64a4ee0aeb0c76a943260316ed4.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 16/26] bisect--helper: `bisect_state` & `bisect_head` shell
 function in C
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

Reimplement the `bisect_state()` shell function in C and also add a
subcommand `--bisect-state` to `git-bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-state` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other methods.

`bisect_head()` is called from `bisect_state()`, thus it is not required to
introduce another subcommand.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 80 ++++++++++++++++++++++++++++++++++++++++
 git-bisect.sh            | 55 ++-------------------------
 2 files changed, 84 insertions(+), 51 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 61c3cc517a..49ef0ff6bc 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -31,6 +31,8 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
 	N_("git bisect--helper --bisect-autostart"),
+	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
+	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	NULL
 };
 
@@ -818,6 +820,74 @@ static int bisect_autostart(struct bisect_terms *terms)
 	return 0;
 }
 
+static char *bisect_head(void)
+{
+	if (is_empty_or_missing_file(git_path_bisect_head()))
+		return "HEAD";
+	else
+		return "BISECT_HEAD";
+}
+
+static int bisect_state(struct bisect_terms *terms, const char **argv,
+			int argc)
+{
+	const char *state = argv[0];
+
+	if (check_and_set_terms(terms, state))
+		return -1;
+
+	if (!argc)
+		return error(_("Please call `--bisect-state` with at least one argument"));
+
+	if (argc == 1 && one_of(state, terms->term_good,
+	    terms->term_bad, "skip", NULL)) {
+		const char *bisected_head = xstrdup(bisect_head());
+		const char *hex[1];
+		struct object_id oid;
+
+		if (get_oid(bisected_head, &oid))
+			return error(_("Bad rev input: %s"), bisected_head);
+		if (bisect_write(state, oid_to_hex(&oid), terms, 0))
+			return -1;
+
+		*hex = xstrdup(oid_to_hex(&oid));
+		check_expected_revs(hex, 1);
+		return bisect_auto_next(terms, NULL);
+	}
+
+	if ((argc == 2 && !strcmp(state, terms->term_bad)) ||
+			one_of(state, terms->term_good, "skip", NULL)) {
+		int i;
+		struct string_list hex = STRING_LIST_INIT_DUP;
+
+		for (i = 1; i < argc; i++) {
+			struct object_id oid;
+
+			if (get_oid(argv[i], &oid)) {
+				string_list_clear(&hex, 0);
+				return error(_("Bad rev input: %s"), argv[i]);
+			}
+			string_list_append(&hex, oid_to_hex(&oid));
+		}
+		for (i = 0; i < hex.nr; i++) {
+			const char **hex_string = (const char **) &hex.items[i].string;
+			if (bisect_write(state, *hex_string, terms, 0)) {
+				string_list_clear(&hex, 0);
+				return -1;
+			}
+			check_expected_revs(hex_string, 1);
+		}
+		string_list_clear(&hex, 0);
+		return bisect_auto_next(terms, NULL);
+	}
+
+	if (!strcmp(state, terms->term_bad))
+		return error(_("'git bisect %s' can take only one argument."),
+		      terms->term_bad);
+
+	return -1;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -832,6 +902,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
 		BISECT_AUTOSTART,
+		BISECT_STATE
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -857,6 +928,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
 			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
+		OPT_CMDMODE(0, "bisect-state", &cmdmode,
+			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -929,6 +1002,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_autostart(&terms);
 		break;
+	case BISECT_STATE:
+		if (argc == 0)
+			return error(_("--bisect-state requires at least one revision"));
+		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
+		res = bisect_state(&terms, argv, argc);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 97bb15b38f..4a5afc7a93 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -39,16 +39,6 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 
-bisect_head()
-{
-	if test -f "$GIT_DIR/BISECT_HEAD"
-	then
-		echo BISECT_HEAD
-	else
-		echo HEAD
-	fi
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -61,43 +51,7 @@ bisect_skip() {
 		esac
 		all="$all $revs"
 	done
-	eval bisect_state 'skip' $all
-}
-
-bisect_state() {
-	git bisect--helper --bisect-autostart
-	state=$1
-	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD || exit
-	get_terms
-	case "$#,$state" in
-	0,*)
-		die "Please call 'bisect_state' with at least one argument." ;;
-	1,"$TERM_BAD"|1,"$TERM_GOOD"|1,skip)
-		bisected_head=$(bisect_head)
-		rev=$(git rev-parse --verify "$bisected_head") ||
-			die "$(eval_gettext "Bad rev input: \$bisected_head")"
-		git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
-		git bisect--helper --check-expected-revs "$rev" ;;
-	2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
-		shift
-		hash_list=''
-		for rev in "$@"
-		do
-			sha=$(git rev-parse --verify "$rev^{commit}") ||
-				die "$(eval_gettext "Bad rev input: \$rev")"
-			hash_list="$hash_list $sha"
-		done
-		for rev in $hash_list
-		do
-			git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
-		done
-		git bisect--helper --check-expected-revs $hash_list ;;
-	*,"$TERM_BAD")
-		die "$(eval_gettext "'git bisect \$TERM_BAD' can take only one argument.")" ;;
-	*)
-		usage ;;
-	esac
-	git bisect--helper --bisect-auto-next
+	eval git bisect--helper --bisect-state 'skip' $all
 }
 
 bisect_visualize() {
@@ -185,8 +139,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 			state="$TERM_GOOD"
 		fi
 
-		# We have to use a subshell because "bisect_state" can exit.
-		( bisect_state $state >"$GIT_DIR/BISECT_RUN" )
+		( git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN" )
 		res=$?
 
 		cat "$GIT_DIR/BISECT_RUN"
@@ -201,7 +154,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 		if [ $res -ne 0 ]
 		then
 			eval_gettextln "bisect run failed:
-'bisect_state \$state' exited with error code \$res" >&2
+'git bisect--helper --bisect-state \$state' exited with error code \$res" >&2
 			exit $res
 		fi
 
@@ -242,7 +195,7 @@ case "$#" in
 	start)
 		git bisect--helper --bisect-start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		bisect_state "$cmd" "$@" ;;
+		git bisect--helper --bisect-state "$cmd" "$@" ;;
 	skip)
 		bisect_skip "$@" ;;
 	next)
-- 
gitgitgadget

