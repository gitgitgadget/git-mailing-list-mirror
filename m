Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 009C51F576
	for <e@80x24.org>; Sun, 11 Feb 2018 09:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeBKJnr (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 04:43:47 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36742 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeBKJnp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 04:43:45 -0500
Received: by mail-pf0-f194.google.com with SMTP id p8so878503pff.3
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 01:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cOL5XXYSE7y0lXkyNZKGcWIz+bJryYsyyMHLv1X8P5k=;
        b=j4iXH0HOC9wQ+Wzsk9ecsr59EJUzXGQEBSytR0CSXxVmK6yoy00nyb1QT2qojuVwd9
         tpE39tJKX845U7kd99W/+7Oraww5unf3ygYC1kEueE40W4ToCDQyPzQAuLq+PF7pGQ3a
         nKK2tz60G/gI/ZWpmAjcE5wrzkALvO6obAAyRMkZSeE7damL3v81pRuvLLP6UDKPNqcR
         HH3Bk2M38+GQczBTj4c6yEjpjzbrGRMV6pqhDfTeBi+9q5Ay8oBSNvZ39+ViFsa+LUwi
         xDF+7Y+1WbtcfmwWJxXe+9WQNVk6o9BcfevlB8ylLce+HV82vr5zMRSSXp5d0HMNOLtV
         k2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cOL5XXYSE7y0lXkyNZKGcWIz+bJryYsyyMHLv1X8P5k=;
        b=Q5dz4tIJy4+J33/IYE1VUHmt7Q/Loe8iEJQ7bAy+PS73+E73u2he+xGeFJG/Pae0nL
         EmB7Yn54RI1aDrErZfMVFZ53z21RRLwJBzQqtQZqP1YhvOM3WKSd0fazJkKFN60juxVI
         DdZBqD46DZFV13I3I6iF56lJ1M3no+SbdxJztqo5htUgVM8A5Utjm69CD8lZqaZ49doD
         nsd7cj7rcRsWDWEpQwikXVF1Ai+2jbkbIPo4upYwI4+j+9nnKR9eusgrkOEsT3h0+FoU
         Em1lHM3h8QW3x/iqw6QHRW3e45U20rSfLP4dzhAcgSNp0WtDcxEoZofUnDrFV7VyJBSa
         sdCQ==
X-Gm-Message-State: APf1xPDMqrFcRgwE/JwjeJPrxiH+Na49zlFERVTyPj7xVWzdls+BHCrr
        ABao0uMszZLec01k5pzf/t9ISw==
X-Google-Smtp-Source: AH8x2264eBbRv9UzaNQ/5VgUwW5BseZWpU60ZQOaTxqputNRISD2dht9ptaMhpGjxO7LTbLQKlBZGQ==
X-Received: by 10.101.66.76 with SMTP id d12mr6695182pgq.45.1518342224944;
        Sun, 11 Feb 2018 01:43:44 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id l84sm20259789pfb.153.2018.02.11.01.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Feb 2018 01:43:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 11 Feb 2018 16:43:37 +0700
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
Subject: [PATCH v3 0/3] Add "git rebase --show-current-patch"
Date:   Sun, 11 Feb 2018 16:43:25 +0700
Message-Id: <20180211094328.6157-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180131093051.15525-1-pclouds@gmail.com>
References: <20180131093051.15525-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to v2:

- the potential loss of errno before it's printed out in builtin/am.c
  is fixed.
- keep update_ref() in sequencer.c non-fatal like this rest
- rename ORIG_COMMIT to REBASE_HEAD

Interdiff:

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6da9296bf8..0b29e48221 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -253,7 +253,7 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 --show-current-patch::
 	Show the current patch in an interactive rebase or when rebase
 	is stopped because of conflicts. This is the equivalent of
-	`git show ORIG_COMMIT`.
+	`git show REBASE_HEAD`.
 
 -m::
 --merge::
diff --git a/builtin/am.c b/builtin/am.c
index bf9b356340..21aedec41f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1011,7 +1011,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir);
-	delete_ref(NULL, "ORIG_COMMIT", NULL, REF_NO_DEREF);
+	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 
 	if (split_mail(state, patch_format, paths, keep_cr) < 0) {
 		am_destroy(state);
@@ -1111,7 +1111,7 @@ static void am_next(struct am_state *state)
 
 	oidclr(&state->orig_commit);
 	unlink(am_path(state, "original-commit"));
-	delete_ref(NULL, "ORIG_COMMIT", NULL, REF_NO_DEREF);
+	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 
 	if (!get_oid("HEAD", &head))
 		write_state_text(state, "abort-safety", oid_to_hex(&head));
@@ -1443,8 +1443,8 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
 
 	oidcpy(&state->orig_commit, &commit_oid);
 	write_state_text(state, "original-commit", oid_to_hex(&commit_oid));
-	update_ref("am", "ORIG_COMMIT", &commit_oid,
-		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	update_ref("am", "REBASE_HEAD", &commit_oid,
+		   NULL, REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
 
 	return 0;
 }
@@ -2127,6 +2127,7 @@ static void am_abort(struct am_state *state)
 static int show_patch(struct am_state *state)
 {
 	struct strbuf sb = STRBUF_INIT;
+	const char *patch_path;
 	int len;
 
 	if (!is_null_oid(&state->orig_commit)) {
@@ -2140,10 +2141,10 @@ static int show_patch(struct am_state *state)
 		return ret;
 	}
 
-	len = strbuf_read_file(&sb, am_path(state, msgnum(state)), 0);
+	patch_path = am_path(state, msgnum(state));
+	len = strbuf_read_file(&sb, patch_path, 0);
 	if (len < 0)
-		die_errno(_("failed to read '%s'"),
-			  am_path(state, msgnum(state)));
+		die_errno(_("failed to read '%s'"), patch_path);
 
 	setup_pager();
 	write_in_full(1, sb.buf, sb.len);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index deea688e0e..8777805c9f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -439,7 +439,7 @@ __git_refs ()
 			track=""
 			;;
 		*)
-			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD ORIG_COMMIT; do
+			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD; do
 				case "$i" in
 				$match*)
 					if [ -e "$dir/$i" ]; then
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ef72bd5871..a613156bcb 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -199,14 +199,14 @@ make_patch () {
 
 die_with_patch () {
 	echo "$1" > "$state_dir"/stopped-sha
-	git update-ref ORIG_COMMIT "$1"
+	git update-ref REBASE_HEAD "$1"
 	make_patch "$1"
 	die "$2"
 }
 
 exit_with_patch () {
 	echo "$1" > "$state_dir"/stopped-sha
-	git update-ref ORIG_COMMIT "$1"
+	git update-ref REBASE_HEAD "$1"
 	make_patch $1
 	git rev-parse --verify HEAD > "$amend"
 	gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
@@ -843,7 +843,7 @@ To continue rebase after editing, run:
 	exit
 	;;
 show-current-patch)
-	exec git show ORIG_COMMIT --
+	exec git show REBASE_HEAD --
 	;;
 esac
 
@@ -860,7 +860,7 @@ fi
 
 orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
 mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
-rm -f "$(git rev-parse --git-path ORIG_COMMIT)"
+rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 
 : > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
 write_basic_state
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 70966c32c3..957688f236 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -57,7 +57,7 @@ call_merge () {
 	echo "$msgnum" >"$state_dir/msgnum"
 	cmt="$(cat "$state_dir/cmt.$msgnum")"
 	echo "$cmt" > "$state_dir/current"
-	git update-ref ORIG_COMMIT "$cmt"
+	git update-ref REBASE_HEAD "$cmt"
 	hd=$(git rev-parse --verify HEAD)
 	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
 	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
@@ -139,14 +139,14 @@ skip)
 	return
 	;;
 show-current-patch)
-	exec git show ORIG_COMMIT --
+	exec git show REBASE_HEAD --
 	;;
 esac
 
 mkdir -p "$state_dir"
 echo "$onto_name" > "$state_dir/onto_name"
 write_basic_state
-rm -f "$(git rev-parse --git-path ORIG_COMMIT)"
+rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 
 msgnum=0
 for cmt in $(git rev-list --reverse --no-merges "$revisions")
diff --git a/git-rebase.sh b/git-rebase.sh
index 1db4301b90..a13a581fe6 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -182,7 +182,7 @@ You can run "git stash pop" or "git stash drop" at any time.
 }
 
 finish_rebase () {
-	rm -f "$(git rev-parse --git-path ORIG_COMMIT)"
+	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 	apply_autostash &&
 	{ git gc --auto || true; } &&
 	rm -rf "$state_dir"
diff --git a/sequencer.c b/sequencer.c
index fe907a0701..f692221999 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1792,8 +1792,9 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
 	p = short_commit_name(commit);
 	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
 		return -1;
-	update_ref("rebase", "ORIG_COMMIT", &commit->object.oid,
-		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	if (update_ref("rebase", "REBASE_HEAD", &commit->object.oid,
+		       NULL, REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
+		res |= error(_("could not update %s"), "REBASE_HEAD");
 
 	strbuf_addf(&buf, "%s/patch", get_dir(opts));
 	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
@@ -2045,7 +2046,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			unlink(rebase_path_author_script());
 			unlink(rebase_path_stopped_sha());
 			unlink(rebase_path_amend());
-			delete_ref(NULL, "ORIG_COMMIT", NULL, REF_NO_DEREF);
+			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 		}
 		if (item->command <= TODO_SQUASH) {
 			if (is_rebase_i(opts))
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 2be4abcb7b..72d9564747 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -306,8 +306,8 @@ test_expect_success 'rebase--merge.sh and --show-current-patch' '
 		test_must_fail git rebase --merge --onto init HEAD^ &&
 		git rebase --show-current-patch >actual.patch &&
 		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
-		grep "show.*ORIG_COMMIT" stderr &&
-		test "$(git rev-parse ORIG_COMMIT)" = "$(git rev-parse two)"
+		grep "show.*REBASE_HEAD" stderr &&
+		test "$(git rev-parse REBASE_HEAD)" = "$(git rev-parse two)"
 	)
 '
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c0fe0193bb..23a54a4c49 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -227,10 +227,10 @@ test_expect_success 'stop on conflicting pick' '
 
 test_expect_success 'show conflicted patch' '
 	GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
-	grep "show.*ORIG_COMMIT" stderr &&
+	grep "show.*REBASE_HEAD" stderr &&
 	# the original stopped-sha1 is abbreviated
 	stopped_sha1="$(git rev-parse $(cat ".git/rebase-merge/stopped-sha"))" &&
-	test "$(git rev-parse ORIG_COMMIT)" = "$stopped_sha1"
+	test "$(git rev-parse REBASE_HEAD)" = "$stopped_sha1"
 '
 
 test_expect_success 'abort' '
-- 
2.16.1.399.g632f88eed1

