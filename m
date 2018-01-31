Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEE0C1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 09:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753513AbeAaJb3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 04:31:29 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40679 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753479AbeAaJb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 04:31:26 -0500
Received: by mail-pf0-f193.google.com with SMTP id i66so12016825pfd.7
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 01:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xIyLCYV/Tw5RMInINAGK77fdAoqni3pLvVOIsMykbcg=;
        b=r1Co9BeVewvXlqyDCJ24IvOabG03QaPUyY+DWDzTjTgkwdE91cWPwgh+9+lQ2iBpYM
         ZxjLwP7XJezRruzwIji0qYxR9tUkeJI6NHgBrmKVqtN4oE9zf4VB+NMvg2oKe/i8jvQF
         iabRWnCKaZKxzDsV/MbW9MXtzldzECQvgRvcTME/wfsuxLqenWpGUB2/JjOvrJQFMYGj
         Ux77ZYTaT6hXDcDxKHJM4cBKID2WCRc9xAqHIu5+3r6uH8JO3r7o69JYFRr+1BAjppDn
         9y/Ge0UnNpnyDdz4aCnVVyn9VCp+oqAhIy4P7TsgMFAp89/Ti6k+nPbWi/1iOeqDcn4M
         qfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xIyLCYV/Tw5RMInINAGK77fdAoqni3pLvVOIsMykbcg=;
        b=i2cQyYyFMEY/HLgOOq1IrNprLeF0Qet6bptVU2/AEZxQlI/vol3QO1fOd7yLaMQh+q
         IosKjq5of5TJJ5AheQzI5YW21/XsA5EBLMn1Qz/G3BHgNjR1kcF6lNBC8ylQCKZqLbTC
         B4llxO+GmW9yE/PFxUZwEAyy1i4u19FdH17yhjp7Nt2aWr4ZMfm7ZklII6/1ehxrnw56
         nnCdv/A8FaSORUN0Iw8ZspZrxmZTflPbFte/F0PUZ+2yGVWP91riBb2L7dTJt4mKmWR2
         F0hZhSMwteU7gemnZAkap5l/ojhKBOC1E7036jvGwBBpIZVLzW4/VOVwmI43TQXqyXwW
         SfSw==
X-Gm-Message-State: AKwxytdQECyaXndyzDYoyUdguPRjsYZrH+Jl8Ivd5v/1py2QzhB6dLXq
        GwDcaKmUQqGaEEPfUWoueVbaVA==
X-Google-Smtp-Source: AH8x227sf4un7T1Trl03q2zd3Q+gHuR74z80VX0CH5KR2GJhDJkPN7JOUBpFsYcbAFcW1CQsxAS0Jw==
X-Received: by 2002:a17:902:1683:: with SMTP id h3-v6mr27096345plh.433.1517391085605;
        Wed, 31 Jan 2018 01:31:25 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id n82sm43242813pfa.45.2018.01.31.01.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 01:31:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 16:31:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        tim@tim-landscheidt.de,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 3/3] rebase: introduce and use pseudo-ref ORIG_COMMIT
Date:   Wed, 31 Jan 2018 16:30:51 +0700
Message-Id: <20180131093051.15525-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131093051.15525-1-pclouds@gmail.com>
References: <20180126095520.919-1-pclouds@gmail.com>
 <20180131093051.15525-1-pclouds@gmail.com>
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
want with the new pseudo ref ORIG_COMMIT.

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
 sequencer.c                            | 3 +++
 t/t3400-rebase.sh                      | 3 ++-
 t/t3404-rebase-interactive.sh          | 5 ++++-
 9 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 7ef9577472..6da9296bf8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -252,7 +252,8 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 
 --show-current-patch::
 	Show the current patch in an interactive rebase or when rebase
-	is stopped because of conflicts.
+	is stopped because of conflicts. This is the equivalent of
+	`git show ORIG_COMMIT`.
 
 -m::
 --merge::
diff --git a/builtin/am.c b/builtin/am.c
index caec50cba9..bf9b356340 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1011,6 +1011,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 
 	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
 		die_errno(_("failed to create directory '%s'"), state->dir);
+	delete_ref(NULL, "ORIG_COMMIT", NULL, REF_NO_DEREF);
 
 	if (split_mail(state, patch_format, paths, keep_cr) < 0) {
 		am_destroy(state);
@@ -1110,6 +1111,7 @@ static void am_next(struct am_state *state)
 
 	oidclr(&state->orig_commit);
 	unlink(am_path(state, "original-commit"));
+	delete_ref(NULL, "ORIG_COMMIT", NULL, REF_NO_DEREF);
 
 	if (!get_oid("HEAD", &head))
 		write_state_text(state, "abort-safety", oid_to_hex(&head));
@@ -1441,6 +1443,8 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
 
 	oidcpy(&state->orig_commit, &commit_oid);
 	write_state_text(state, "original-commit", oid_to_hex(&commit_oid));
+	update_ref("am", "ORIG_COMMIT", &commit_oid,
+		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 
 	return 0;
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2bd30d68cf..deea688e0e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -439,7 +439,7 @@ __git_refs ()
 			track=""
 			;;
 		*)
-			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
+			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD ORIG_COMMIT; do
 				case "$i" in
 				$match*)
 					if [ -e "$dir/$i" ]; then
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c0f8abbf9..ef72bd5871 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -199,12 +199,14 @@ make_patch () {
 
 die_with_patch () {
 	echo "$1" > "$state_dir"/stopped-sha
+	git update-ref ORIG_COMMIT "$1"
 	make_patch "$1"
 	die "$2"
 }
 
 exit_with_patch () {
 	echo "$1" > "$state_dir"/stopped-sha
+	git update-ref ORIG_COMMIT "$1"
 	make_patch $1
 	git rev-parse --verify HEAD > "$amend"
 	gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
@@ -841,7 +843,7 @@ To continue rebase after editing, run:
 	exit
 	;;
 show-current-patch)
-	exec git show "$(cat "$state_dir/stopped-sha")" --
+	exec git show ORIG_COMMIT --
 	;;
 esac
 
@@ -858,6 +860,7 @@ fi
 
 orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
 mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
+rm -f "$(git rev-parse --git-path ORIG_COMMIT)"
 
 : > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
 write_basic_state
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 0a96dfae37..70966c32c3 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -57,6 +57,7 @@ call_merge () {
 	echo "$msgnum" >"$state_dir/msgnum"
 	cmt="$(cat "$state_dir/cmt.$msgnum")"
 	echo "$cmt" > "$state_dir/current"
+	git update-ref ORIG_COMMIT "$cmt"
 	hd=$(git rev-parse --verify HEAD)
 	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
 	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
@@ -138,13 +139,14 @@ skip)
 	return
 	;;
 show-current-patch)
-	exec git show "$(cat "$state_dir/current")" --
+	exec git show ORIG_COMMIT --
 	;;
 esac
 
 mkdir -p "$state_dir"
 echo "$onto_name" > "$state_dir/onto_name"
 write_basic_state
+rm -f "$(git rev-parse --git-path ORIG_COMMIT)"
 
 msgnum=0
 for cmt in $(git rev-list --reverse --no-merges "$revisions")
diff --git a/git-rebase.sh b/git-rebase.sh
index 41c915d18c..1db4301b90 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -182,6 +182,7 @@ You can run "git stash pop" or "git stash drop" at any time.
 }
 
 finish_rebase () {
+	rm -f "$(git rev-parse --git-path ORIG_COMMIT)"
 	apply_autostash &&
 	{ git gc --auto || true; } &&
 	rm -rf "$state_dir"
diff --git a/sequencer.c b/sequencer.c
index 4d3f60594c..fe907a0701 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1792,6 +1792,8 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
 	p = short_commit_name(commit);
 	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
 		return -1;
+	update_ref("rebase", "ORIG_COMMIT", &commit->object.oid,
+		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 
 	strbuf_addf(&buf, "%s/patch", get_dir(opts));
 	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
@@ -2043,6 +2045,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			unlink(rebase_path_author_script());
 			unlink(rebase_path_stopped_sha());
 			unlink(rebase_path_amend());
+			delete_ref(NULL, "ORIG_COMMIT", NULL, REF_NO_DEREF);
 		}
 		if (item->command <= TODO_SQUASH) {
 			if (is_rebase_i(opts))
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 09943d6a9b..2be4abcb7b 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -306,7 +306,8 @@ test_expect_success 'rebase--merge.sh and --show-current-patch' '
 		test_must_fail git rebase --merge --onto init HEAD^ &&
 		git rebase --show-current-patch >actual.patch &&
 		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
-		grep "show.*$(git rev-parse two)" stderr
+		grep "show.*ORIG_COMMIT" stderr &&
+		test "$(git rev-parse ORIG_COMMIT)" = "$(git rev-parse two)"
 	)
 '
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3af6f149a9..c0fe0193bb 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -227,7 +227,10 @@ test_expect_success 'stop on conflicting pick' '
 
 test_expect_success 'show conflicted patch' '
 	GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
-	grep "show.*$(cat "$state_dir/stopped-sha")" stderr
+	grep "show.*ORIG_COMMIT" stderr &&
+	# the original stopped-sha1 is abbreviated
+	stopped_sha1="$(git rev-parse $(cat ".git/rebase-merge/stopped-sha"))" &&
+	test "$(git rev-parse ORIG_COMMIT)" = "$stopped_sha1"
 '
 
 test_expect_success 'abort' '
-- 
2.16.1.205.g271f633410

