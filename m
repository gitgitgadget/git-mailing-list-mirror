Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A723FADF8
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327878; cv=none; b=j9cT9F6UlTcsKrJCrdxMlVkxfqLWMRxuoluZy7rbABXhflfSm9zTT3gmPGEs3wQ9KERXPR51rrLMmeFtg0MAvut3Xh0T4tS+k/jvY9vZHTRaC1w0GPnn6BU+wGyvr7p5XyrLnmSb9l5aVH7yjZhGA73QCteVIV9ztu5NjdCt8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327878; c=relaxed/simple;
	bh=Pb/wZOxFHFNuldrvQawBatDb3J30zgQPQ69GSW3j6Bg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=llu5/5zlkENAcP34Wf92ZmQQv31GE8KF0Aobo+/xMUN4ayUgvRXvim1aNfKd3qqiR4KHvV+T5CTDtsdqonm/Y+obstP4uBjh0553izPuJC9pxQMloUlMZ42UJNMuc67w2kzkj5+HYKL7csQqByNmwBuww3mMmGwZN0n2YVUWG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmSmrhKO; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmSmrhKO"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f18d92172aso39134956d6.2
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 01:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783327863; x=1783932663; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vXdLGHeYhZPPogyhRNJJ0Bu5GKxMw7/f5iK79zbcjyg=;
        b=EmSmrhKOh0k3jc6H3kXCFP3k9nvZ08iDVpeNx6iwuxZgS7WF2jnByuOnqk86xs2QBS
         M2EqOsLvyfw8WZ0mOvPoW6ZZFETAZZcYIq7doY4eXGn+OcFe5pQ6hkU2Cf820Q/t6lvs
         Kx82zFbsn8XYrYvNhszpA1vPw8HUVGgS/oHFyGbYkfGgKqwQpPr/dVVBRcwCNwlvK1ua
         ZrSYO5nxqxpnRFWQv3mAyRd8xr5PisLQ46pfKyw1F02+OekpJlK0mBiSCP6PigY6RFyl
         J6ZF+v10Fz+VW6a2Z3in18HPKCP+7GFWJPnxwd7ihsNvP3PU2l2gjC6t3hHteRfQgYmJ
         U+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783327863; x=1783932663;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vXdLGHeYhZPPogyhRNJJ0Bu5GKxMw7/f5iK79zbcjyg=;
        b=FnFOQryzGEmN5JU8oVlRviVb8ji6ycE80HlNxPSNxqmH832WWLSd6zrl1Wl0iDsShd
         sb7KN/sDExIqJWQFIAGv5L/F9DqwNnNSkN6Y0s1HHeibbVVJdatknZueT1xVkoA3QGCu
         HPCLCKCPmEMYwySheGyjOlJPGVvJEG6eNVtzax35DbZA6XfE4f7BHoE57b5toTB6Rc+Z
         h7Mo9sqYaTYLYCf9gzkQlY7IkSylRhx8GX46bHXsndp8oPykapUCnE3KV4p+QTfQ1scu
         4bQ7pTMJp0XoUejcwXjCZIKoQM0cErw5Ea1hvAPdLNvSaUOozcapqpA58F2KmVpY7m/4
         3nbQ==
X-Gm-Message-State: AOJu0YzCvrMkEb1v4tAIqZGuKt1uzaB8g2vfRNyvUgyF4hM7HAFBP4WV
	vlOtUhWx7u3AFV+VYq8ZuuSia4/R3CiooSrNLYrJ7DmDjzwxMVGfbZ7+KjpwanA8
X-Gm-Gg: AfdE7cmeDWHSNnLFMGui3mxtRMuqc2uf3ji3jNQivf5Nk+z/KStLNdLAIiUDmjs59AZ
	ujzM86z2WpDLPYNr/cFhqamfVk1hAysSHE2BsYKqIv1j+7/SmJ0vbltyjNjRIVp1/1YHmn/C+Yw
	qqRpPUul6JFJ1Xn+G0v7u4UwlqX/clEBHaic3kNYtcLFJWqr9405za8slLXWM4pw4cWXGWzrlI1
	ldwW//DRii+rltsMXHUGFKxhTDZm8VZV/lvvR20F2B4EejWnpTPv4EFMj4KcJb74gHUsnyUZ7LX
	JUBnp1Qk1K7CJJuZvnBsC4sWzvleacWjkAoeZmt3zjiwJ5zQ8XFs3z7nlQTVqm/x5NDdb+l/ejE
	kim0uh4ntvD4JmIwXzVtrp469xMxVyTb4DF6SRNBQxCBZtQuQ1boIE0gwIMgFutgSQzFKTxw9BV
	8k2nY0Q3jFpoAEiDU=
X-Received: by 2002:a05:6214:628:b0:8f3:e0ce:611e with SMTP id 6a1803df08f44-8f74a234a02mr149814896d6.19.1783327863152;
        Mon, 06 Jul 2026 01:51:03 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.174.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e188c30sm131071916d6.6.2026.07.06.01.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:51:02 -0700 (PDT)
Message-Id: <615fe4dd3f3ad13ada8a605433f79b5012530018.1783327849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
References: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
	<pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 08:50:49 +0000
Subject: [PATCH v7 5/5] history: re-edit a squash with every message
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

By default "git history squash" reuses the oldest commit's message.
When --reedit-message is given it only reopened that one message, so the
messages of the folded-in commits were lost.

Gather the messages of every commit in the range, oldest first, and build
the same editor template that "git rebase -i" shows for a squash, using
add_squash_combination_header(), add_squash_message_header() and
squash_subject_comment_len(). Only the message text differs, the changes
are always folded in. Following autosquash, a fixup!'s message is
commented out in full under a "will be skipped" header, while a squash! or
amend! keeps its body with only the marker subject commented.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-history.adoc |  12 +++-
 builtin/history.c              |  73 ++++++++++++++++++++-
 t/t3455-history-squash.sh      | 115 +++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 783ddf4a51..f51332e731 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -117,15 +117,21 @@ like the arguments to linkgit:git-rev-list[1], so several arguments may be
 given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
 already on `topic`.
 +
-The oldest commit's message and authorship are preserved by default,
-unless you specify `--reedit-message`. A merge commit inside the range is
+The oldest commit's message and authorship are preserved by default. With
+`--reedit-message`, an editor opens pre-filled with the messages of all the
+folded commits so you can combine them. A merge commit inside the range is
 folded like any other, but the range must have a single base, so a range
 that reaches more than one entry point (for example a side branch that
 forked before the range and was later merged into it) is rejected.
 +
 Because the oldest commit's message is reused, the range may not begin
 with a `fixup!`, `squash!`, or `amend!` commit, whose target is
-necessarily outside the range.
+necessarily outside the range. The changes from every commit in the range
+are always folded in. Only the message text differs. With
+`--reedit-message` the template mirrors `git rebase -i`: the message of a
+`fixup!` elsewhere in the range is commented out in full, while a
+`squash!` or `amend!` keeps its message body with only the marker subject
+commented, so you can fold the remark into the result.
 +
 A branch or tag that points at a commit inside the range would be left
 dangling once those commits are folded away, so with the default
diff --git a/builtin/history.c b/builtin/history.c
index 63911a493d..8999ba9533 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1114,6 +1114,68 @@ static int find_interior_ref(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
+static int build_squash_message(struct repository *repo,
+				struct commit *base,
+				struct commit *tip,
+				struct strbuf *out)
+{
+	struct commit_list *commits = NULL, **tail = &commits, *c;
+	struct rev_info revs;
+	struct commit *commit;
+	struct strvec args = STRVEC_INIT;
+	int n = 0, total, ret;
+
+	repo_init_revisions(repo, &revs, NULL);
+	strvec_push(&args, "ignored");
+	strvec_push(&args, "--reverse");
+	strvec_push(&args, "--topo-order");
+	strvec_pushf(&args, "%s..%s", oid_to_hex(&base->object.oid),
+		     oid_to_hex(&tip->object.oid));
+	setup_revisions_from_strvec(&args, &revs, NULL);
+
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+
+	while ((commit = get_revision(&revs)))
+		tail = &commit_list_insert(commit, tail)->next;
+	total = commit_list_count(commits);
+
+	for (c = commits; c; c = c->next) {
+		const char *message, *body;
+		size_t commented_len;
+		int skip;
+
+		message = repo_logmsg_reencode(repo, c->item, NULL, NULL);
+		find_commit_subject(message, &body);
+
+		skip = starts_with(body, "fixup! ");
+		commented_len = skip ? strlen(body) :
+			squash_subject_comment_len(body, 1);
+
+		if (!n)
+			add_squash_combination_header(out, total);
+		strbuf_addch(out, '\n');
+		add_squash_message_header(out, ++n, skip);
+		strbuf_addstr(out, "\n\n");
+		strbuf_add_commented_lines(out, body, commented_len, comment_line_str);
+		strbuf_addstr(out, body + commented_len);
+		strbuf_complete_line(out);
+
+		repo_unuse_commit_buffer(repo, c->item, message);
+	}
+
+	ret = 0;
+
+out:
+	commit_list_free(commits);
+	reset_revision_walk();
+	release_revisions(&revs);
+	strvec_clear(&args);
+	return ret;
+}
+
 static int cmd_history_squash(int argc,
 			      const char **argv,
 			      const char *prefix,
@@ -1138,6 +1200,7 @@ static int cmd_history_squash(int argc,
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
+	struct strbuf message = STRBUF_INIT;
 	struct oidset interior = OIDSET_INIT;
 	struct commit *base, *oldest, *tip, *rewritten;
 	const struct object_id *base_tree_oid, *tip_tree_oid;
@@ -1181,6 +1244,12 @@ static int cmd_history_squash(int argc,
 		}
 	}
 
+	if (flags & COMMIT_TREE_EDIT_MESSAGE) {
+		ret = build_squash_message(repo, base, tip, &message);
+		if (ret < 0)
+			goto out;
+	}
+
 	ret = setup_revwalk(repo, action, tip, &revs);
 	if (ret < 0)
 		goto out;
@@ -1189,7 +1258,8 @@ static int cmd_history_squash(int argc,
 	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
 	commit_list_append(base, &parents);
 
-	ret = commit_tree_ext(repo, "squash", oldest, NULL, parents,
+	ret = commit_tree_ext(repo, "squash", oldest,
+			      message.len ? message.buf : NULL, parents,
 			      base_tree_oid, tip_tree_oid, &rewritten, flags);
 	if (ret < 0) {
 		ret = error(_("failed writing squashed commit"));
@@ -1210,6 +1280,7 @@ static int cmd_history_squash(int argc,
 
 out:
 	strbuf_release(&reflog_msg);
+	strbuf_release(&message);
 	oidset_clear(&interior);
 	commit_list_free(parents);
 	release_revisions(&revs);
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index 6598649971..1985c83fbb 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -186,6 +186,121 @@ test_expect_success 'preserves authorship of the oldest commit' '
 	test_cmp expect actual
 '
 
+test_expect_success '--reedit-message offers every folded-in message' '
+	git reset --hard start &&
+	echo b >file &&
+	git add file &&
+	git commit -m "re-one subject" -m "re-one body line" &&
+	test_commit --no-tag re-two file c &&
+	test_commit re-three file d &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited &&
+	echo combined >"$1"
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash --reedit-message start.. &&
+
+	cat >expect <<-EOF &&
+	# This is a combination of 3 commits.
+	# This is the 1st commit message:
+
+	re-one subject
+
+	re-one body line
+
+	# This is the commit message #2:
+
+	re-two
+
+	# This is the commit message #3:
+
+	re-three
+
+	# Please enter the commit message for the squash changes. Lines starting
+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+	# Changes to be committed:
+	#	modified:   file
+	#
+	EOF
+	test_cmp expect edited &&
+	echo combined >expect &&
+	git log --format="%s" -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--reedit-message handles fixup!, squash! and amend! like rebase' '
+	git reset --hard start &&
+	test_commit --no-tag mark-base file b &&
+	printf "fixup! mark-base\n\nfixup body\n" >msg &&
+	echo c >file &&
+	git add file &&
+	git commit -qF msg &&
+	printf "squash! mark-base\n\nsquash remark\n" >msg &&
+	echo d >file &&
+	git add file &&
+	git commit -qF msg &&
+	printf "amend! mark-base\n\namended message\n" >msg &&
+	echo e >file &&
+	git add file &&
+	git commit -qF msg &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash --reedit-message start.. &&
+
+	cat >expect <<-EOF &&
+	# This is a combination of 4 commits.
+	# This is the 1st commit message:
+
+	mark-base
+
+	# The commit message #2 will be skipped:
+
+	# fixup! mark-base
+	#
+	# fixup body
+
+	# This is the commit message #3:
+
+	# squash! mark-base
+
+	squash remark
+
+	# This is the commit message #4:
+
+	# amend! mark-base
+
+	amended message
+
+	# Please enter the commit message for the squash changes. Lines starting
+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+	# Changes to be committed:
+	#	modified:   file
+	#
+	EOF
+	test_cmp expect edited &&
+	git log -1 --format="%B" >final &&
+	test_grep ! "fixup body" final &&
+	test_grep "squash remark" final &&
+	test_grep "amended message" final
+'
+
+test_expect_success '--reedit-message aborts on an empty message' '
+	git reset --hard three &&
+	head_before=$(git rev-parse HEAD) &&
+
+	write_script editor <<-\EOF &&
+	>"$1"
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	test_must_fail git history squash --reedit-message start.. &&
+
+	test_cmp_rev "$head_before" HEAD
+'
+
 test_expect_success '--update-refs=head only moves HEAD' '
 	git reset --hard three &&
 	git branch -f other HEAD &&
-- 
gitgitgadget
