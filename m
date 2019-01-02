Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 672A11F770
	for <e@80x24.org>; Wed,  2 Jan 2019 15:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfABPih (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 10:38:37 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34204 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbfABPig (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 10:38:36 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so26597492ede.1
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 07:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bTnhFVrBKPqRp8kmvCLCF8LL7kWj8b6dTtSZXts0Q7M=;
        b=RoPAcA8GYaBC6FGXAOjXFtqND2X1tRyB2Hj4h1PO+Gm+v8YoHCR9bbn80F+51O+Nnx
         THNZaxtcI3kblI/dhV8FXxVaEm6ZTG10tkZlEv9vDq8GtKGa4JyFiyd2Cowbv4T/Ox4s
         /S0HqB4OeE2/JDoR8xsdxRjTSrojf/uekwxwXTcBD6tI9+qAE9Lt9HvfN4qSTNvzptGX
         yltRekEI8JpK0Pp5aBROayGSuFen9fIFjlKlKbaHY9feoIa6dVduluVJxcI+I2MW1FcY
         pQ2mrQeWKj6lS/b/8aFLfs1gC1m2COMdrWCABdg9V6yaIAuIc4dY0Lrj4VeUjOn8Kchr
         H9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bTnhFVrBKPqRp8kmvCLCF8LL7kWj8b6dTtSZXts0Q7M=;
        b=r8p+r9cxR4QG0Ja4pCRWbElPvm/v4G2dhinMhK4dROcR+5XL9OMgdERm0SC7QvSMsd
         44zTCOl3qMzjkGz5QoeuZT92X4qf7D45nL2gjM35MmnwxpskGaVzjC1eg/ZrMiNDPygP
         BtOYKQW/xzTDkXN9gjVMINesVU1c/NHYhKVnKi0T7XRVPzElsCWvRqoR7hv2Evw+b2Jf
         VeSXCLF9MPmhPqH1yXDfudr6zK7dqAV2B1c9B2CkJerNC5ULmuT5I8YRP0Q0E74AwrtZ
         ggMfH2nOS5VIijTEHmOi4cbPrzGpyNARzhFakFns0YRTjNdn2Y9P0H72d5Ftbp3wM4Wl
         uJEQ==
X-Gm-Message-State: AA+aEWaQZQB2xFpboqH6+Q9LcMPAKLbNRMXlKi6OZKZRNJtJYRI7cZQB
        t/Ab3i24sGkMWO+DQRHObba12afs
X-Google-Smtp-Source: AFSGD/VMGwoQx46S5vQJy3o4PTKoSdN2v0zDPbehUp63PFnu6DjLQJVzsh33IDkOlWixkbZ1qlLaAA==
X-Received: by 2002:a50:de49:: with SMTP id a9mr40346231edl.18.1546443513981;
        Wed, 02 Jan 2019 07:38:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p20-v6sm12616467ejj.54.2019.01.02.07.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 07:38:33 -0800 (PST)
Date:   Wed, 02 Jan 2019 07:38:33 -0800 (PST)
X-Google-Original-Date: Wed, 02 Jan 2019 15:38:25 GMT
Message-Id: <4e97a08a10b2d23d83c1d1b53b78b39fcc6af6ad.1546443509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.101.v17.git.gitgitgadget@gmail.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
        <pull.101.v17.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v17 4/7] bisect--helper: `check_and_set_terms` shell function
 in C
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

Reimplement the `check_and_set_terms` shell function in C and add
`check-and-set-terms` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--check-and-set-terms` subcommand is a temporary measure to port
shell function in C so as to use the existing test suite. As more
functions are ported, this subcommand will be retired but its
implementation will be called by some other methods.

check_and_set_terms() sets and receives two global variables namely
TERM_GOOD and TERM_BAD in the shell script. Luckily the file BISECT_TERMS
also contains the value of those variables so its appropriate to evoke the
method get_terms() after calling the subcommand so that it retrieves the
value of TERM_GOOD and TERM_BAD from the file BISECT_TERMS. The two
global variables are passed as arguments to the subcommand.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 39 ++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 36 ++++--------------------------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index df821be4b2..02ea5a9611 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,6 +20,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
+	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	NULL
 };
 
@@ -234,6 +235,33 @@ static int bisect_write(const char *state, const char *rev,
 	return retval;
 }
 
+static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
+{
+	int has_term_file = !is_empty_or_missing_file(git_path_bisect_terms());
+
+	if (one_of(cmd, "skip", "start", "terms", NULL))
+		return 0;
+
+	if (has_term_file && strcmp(cmd, terms->term_bad) &&
+	    strcmp(cmd, terms->term_good))
+		return error(_("Invalid command: you're currently in a "
+				"%s/%s bisect"), terms->term_bad,
+				terms->term_good);
+
+	if (!has_term_file) {
+		if (one_of(cmd, "bad", "good", NULL)) {
+			set_terms(terms, "bad", "good");
+			return write_terms(terms->term_bad, terms->term_good);
+		}
+		if (one_of(cmd, "new", "old", NULL)) {
+			set_terms(terms, "new", "old");
+			return write_terms(terms->term_bad, terms->term_good);
+		}
+	}
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -242,7 +270,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
-		BISECT_WRITE
+		BISECT_WRITE,
+		CHECK_AND_SET_TERMS
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -258,6 +287,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
 			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
+		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
+			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -296,6 +327,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, argv[3], argv[2]);
 		res = bisect_write(argv[0], argv[1], &terms, nolog);
 		break;
+	case CHECK_AND_SET_TERMS:
+		if (argc != 3)
+			return error(_("--check-and-set-terms requires 3 arguments"));
+		set_terms(&terms, argv[2], argv[1]);
+		res = check_and_set_terms(&terms, argv[0]);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index ebf445223c..9e993a8187 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -238,7 +238,8 @@ bisect_skip() {
 bisect_state() {
 	bisect_autostart
 	state=$1
-	check_and_set_terms $state
+	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD || exit
+	get_terms
 	case "$#,$state" in
 	0,*)
 		die "Please call 'bisect_state' with at least one argument." ;;
@@ -390,7 +391,8 @@ bisect_replay () {
 			command="$bisect"
 		fi
 		get_terms
-		check_and_set_terms "$command"
+		git bisect--helper --check-and-set-terms "$command" "$TERM_GOOD" "$TERM_BAD" || exit
+		get_terms
 		case "$command" in
 		start)
 			cmd="bisect_start $rev"
@@ -482,36 +484,6 @@ get_terms () {
 	fi
 }
 
-check_and_set_terms () {
-	cmd="$1"
-	case "$cmd" in
-	skip|start|terms) ;;
-	*)
-		if test -s "$GIT_DIR/BISECT_TERMS" && test "$cmd" != "$TERM_BAD" && test "$cmd" != "$TERM_GOOD"
-		then
-			die "$(eval_gettext "Invalid command: you're currently in a \$TERM_BAD/\$TERM_GOOD bisect.")"
-		fi
-		case "$cmd" in
-		bad|good)
-			if ! test -s "$GIT_DIR/BISECT_TERMS"
-			then
-				TERM_BAD=bad
-				TERM_GOOD=good
-				git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
-			fi
-			;;
-		new|old)
-			if ! test -s "$GIT_DIR/BISECT_TERMS"
-			then
-				TERM_BAD=new
-				TERM_GOOD=old
-				git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
-			fi
-			;;
-		esac ;;
-	esac
-}
-
 bisect_voc () {
 	case "$1" in
 	bad) echo "bad|new" ;;
-- 
gitgitgadget

