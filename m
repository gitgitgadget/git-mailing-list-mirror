Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9F01F576
	for <e@80x24.org>; Sun, 11 Feb 2018 09:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeBKJoD (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 04:44:03 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42595 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeBKJoC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 04:44:02 -0500
Received: by mail-pg0-f67.google.com with SMTP id m28so5763526pgc.9
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 01:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u43yZ3wEhgijDBFANzOSwZ/o5O+/AttDTZmV8M3sRgo=;
        b=ZogsfEMqlsdZ/2xcjtx+E+ge33vae287BfHHTIYIy7tmsofC4uSiYxqud6H6UjWtai
         bLrDyjKUreubURHlt4lI9+DXwHqXDQFCY5AJK0ajfGB+VkOAvPh+5p3Pb3hI6YuXdHAt
         nmvyRiC+bjsoeqxtDqKNsURxsQV9ACEXhwQuA2FgMLABfGQLqrKjCblveqE3cAD7Lnez
         DYQyLTJbZB5rxoQxcOOTcJIP3coxjZ5GDdSWCH4WZqKqUtiEg33cd2w3uZuXlNYOiXtV
         tpO5AOf8L2fkBq5GJDrZ7riK1s1j+1T7etwW34K+rgRYobk6jAoBW0c1OKp3YogAt2Ct
         P0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u43yZ3wEhgijDBFANzOSwZ/o5O+/AttDTZmV8M3sRgo=;
        b=Jhf0vdSLcJ9s4jOoAQDIq0Ta7W4ZIslVp0+36J6b6uWv8nCvjmtGi2fhiPnCGWU+v5
         Lb7KkXpHbLCGNySxUykuIA9SjOyLSzPn6Ntd1nJ5CqbRluFQ4kToPhFbwLezWUKohqiM
         iVn+RaPVTOFytzsTPI61PRpDhZkIwu1pwSnqlj2rLUjsowWF2+I1VHDwYX9ibRDFhBk2
         3GWEufd4pM7YJZTkDDzFS4a7qB0M5nfkCFzUyoV/P/milKuThIfOxRnmLvYv1qWkph2U
         y+uGjsKrA1w5J8Kvo5ZX6zmNF/HT3JxQhLJeidoEDQmCC6xgiuLnjkI3LvGKl7UZDIOG
         3QjA==
X-Gm-Message-State: APf1xPAQdGEwQdqVBxiXcxVQyNgp4OoBbMGhs4NiUtuEFHqbyliOsKGD
        mDGoJEF/C793Po2jNXWsZynFNw==
X-Google-Smtp-Source: AH8x225L2hXfNQmZyIa0t0zw4mBRZjyS55A74HM2WhOLb/r87+fgGR+UMAmhc03DaWTmNzhi2sqcDQ==
X-Received: by 10.99.9.193 with SMTP id 184mr169966pgj.372.1518342241513;
        Sun, 11 Feb 2018 01:44:01 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id z186sm16969412pgb.70.2018.02.11.01.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Feb 2018 01:44:00 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 11 Feb 2018 16:43:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        tim@tim-landscheidt.de,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 3/3] rebase: introduce and use pseudo-ref REBASE_HEAD
Date:   Sun, 11 Feb 2018 16:43:28 +0700
Message-Id: <20180211094328.6157-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180211094328.6157-1-pclouds@gmail.com>
References: <20180131093051.15525-1-pclouds@gmail.com>
 <20180211094328.6157-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new command `git rebase --show-current-patch` is useful for seeing
the commit related to the current rebase state. Some however may find
the "git show" command behind it too limiting. You may want to
increase context lines, do a diff that ignores whitespaces...

For these advanced use cases, the user can execute any command they
want with the new pseudo ref REBASE_HEAD.

This also helps show where the stopped commit is from, which is hard
to see from the previous patch which implements --show-current-patch.

Helped-by: Tim Landscheidt <tim@tim-landscheidt.de>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-rebase.txt           | 3 ++-
 builtin/am.c                           | 4 ++++
 contrib/completion/git-completion.bash | 2 +-
 git-rebase--interactive.sh             | 5 ++++-
 git-rebase--merge.sh                   | 4 +++-
 git-rebase.sh                          | 1 +
 sequencer.c                            | 4 ++++
 t/t3400-rebase.sh                      | 3 ++-
 t/t3404-rebase-interactive.sh          | 5 ++++-
 9 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 7ef9577472..0b29e48221 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -252,7 +252,8 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 
 --show-current-patch::
 	Show the current patch in an interactive rebase or when rebase
-	is stopped because of conflicts.
+	is stopped because of conflicts. This is the equivalent of
+	`git show REBASE_HEAD`.
 
 -m::
 --merge::
diff --git a/builtin/am.c b/builtin/am.c
index 37219fceb0..21aedec41f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1011,6 +1011,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir);
+	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 
 	if (split_mail(state, patch_format, paths, keep_cr) < 0) {
 		am_destroy(state);
@@ -1110,6 +1111,7 @@ static void am_next(struct am_state *state)
 
 	oidclr(&state->orig_commit);
 	unlink(am_path(state, "original-commit"));
+	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 
 	if (!get_oid("HEAD", &head))
 		write_state_text(state, "abort-safety", oid_to_hex(&head));
@@ -1441,6 +1443,8 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
 
 	oidcpy(&state->orig_commit, &commit_oid);
 	write_state_text(state, "original-commit", oid_to_hex(&commit_oid));
+	update_ref("am", "REBASE_HEAD", &commit_oid,
+		   NULL, REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
 
 	return 0;
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2bd30d68cf..8777805c9f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -439,7 +439,7 @@ __git_refs ()
 			track=""
 			;;
 		*)
-			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
+			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD; do
 				case "$i" in
 				$match*)
 					if [ -e "$dir/$i" ]; then
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c0f8abbf9..a613156bcb 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -199,12 +199,14 @@ make_patch () {
 
 die_with_patch () {
 	echo "$1" > "$state_dir"/stopped-sha
+	git update-ref REBASE_HEAD "$1"
 	make_patch "$1"
 	die "$2"
 }
 
 exit_with_patch () {
 	echo "$1" > "$state_dir"/stopped-sha
+	git update-ref REBASE_HEAD "$1"
 	make_patch $1
 	git rev-parse --verify HEAD > "$amend"
 	gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
@@ -841,7 +843,7 @@ To continue rebase after editing, run:
 	exit
 	;;
 show-current-patch)
-	exec git show "$(cat "$state_dir/stopped-sha")" --
+	exec git show REBASE_HEAD --
 	;;
 esac
 
@@ -858,6 +860,7 @@ fi
 
 orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
 mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
+rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 
 : > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
 write_basic_state
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 0a96dfae37..957688f236 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -57,6 +57,7 @@ call_merge () {
 	echo "$msgnum" >"$state_dir/msgnum"
 	cmt="$(cat "$state_dir/cmt.$msgnum")"
 	echo "$cmt" > "$state_dir/current"
+	git update-ref REBASE_HEAD "$cmt"
 	hd=$(git rev-parse --verify HEAD)
 	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
 	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
@@ -138,13 +139,14 @@ skip)
 	return
 	;;
 show-current-patch)
-	exec git show "$(cat "$state_dir/current")" --
+	exec git show REBASE_HEAD --
 	;;
 esac
 
 mkdir -p "$state_dir"
 echo "$onto_name" > "$state_dir/onto_name"
 write_basic_state
+rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 
 msgnum=0
 for cmt in $(git rev-list --reverse --no-merges "$revisions")
diff --git a/git-rebase.sh b/git-rebase.sh
index 41c915d18c..a13a581fe6 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -182,6 +182,7 @@ You can run "git stash pop" or "git stash drop" at any time.
 }
 
 finish_rebase () {
+	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 	apply_autostash &&
 	{ git gc --auto || true; } &&
 	rm -rf "$state_dir"
diff --git a/sequencer.c b/sequencer.c
index 4d3f60594c..f692221999 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1792,6 +1792,9 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
 	p = short_commit_name(commit);
 	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
 		return -1;
+	if (update_ref("rebase", "REBASE_HEAD", &commit->object.oid,
+		       NULL, REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
+		res |= error(_("could not update %s"), "REBASE_HEAD");
 
 	strbuf_addf(&buf, "%s/patch", get_dir(opts));
 	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
@@ -2043,6 +2046,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			unlink(rebase_path_author_script());
 			unlink(rebase_path_stopped_sha());
 			unlink(rebase_path_amend());
+			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 		}
 		if (item->command <= TODO_SQUASH) {
 			if (is_rebase_i(opts))
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 09943d6a9b..72d9564747 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -306,7 +306,8 @@ test_expect_success 'rebase--merge.sh and --show-current-patch' '
 		test_must_fail git rebase --merge --onto init HEAD^ &&
 		git rebase --show-current-patch >actual.patch &&
 		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
-		grep "show.*$(git rev-parse two)" stderr
+		grep "show.*REBASE_HEAD" stderr &&
+		test "$(git rev-parse REBASE_HEAD)" = "$(git rev-parse two)"
 	)
 '
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3af6f149a9..23a54a4c49 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -227,7 +227,10 @@ test_expect_success 'stop on conflicting pick' '
 
 test_expect_success 'show conflicted patch' '
 	GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
-	grep "show.*$(cat "$state_dir/stopped-sha")" stderr
+	grep "show.*REBASE_HEAD" stderr &&
+	# the original stopped-sha1 is abbreviated
+	stopped_sha1="$(git rev-parse $(cat ".git/rebase-merge/stopped-sha"))" &&
+	test "$(git rev-parse REBASE_HEAD)" = "$stopped_sha1"
 '
 
 test_expect_success 'abort' '
-- 
2.16.1.399.g632f88eed1

