Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E8233932
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782021203; cv=none; b=Q3dQobqK5Zps5jQGbfNpgHBLSMRmdjJOJBI6Dmv69fwuChvCdfIn8oJYmLa3kwjoZYUhqbEujCqxr4CQYvGKropmNd3IG5+gCBAHMHOgIqUZwOmxYemW3vZQHi1FscDQ/r8pQNpSyATk+NGIEcGyh2/izipdgwZyz8VUbJR2O5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782021203; c=relaxed/simple;
	bh=vyKFyDsJWvEH5/3VmQogtptzNjQnDBYFSPkJgIr2H+g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VM8d1gxaINTz2bf/sE+btxz0ppDD2rMpvAR045qmPvXe0T7rEcBYKFz6DXQY3Qg+m0FK+lT7RcdG5GymBzmw7QLVv8Q4I0oZrDOmpFzi5fVnWEwYnSJB11obgfogjUPiocITx0poboYteRx+GO8tJhdlW1s7kdygM3Phcse5YvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV/zYp5T; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV/zYp5T"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-519eedc30a3so21204941cf.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 22:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782021201; x=1782626001; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sKTEllek34/Q+S8T2rwfc1PDoPkR7+Mi2Hzxj7GD8c=;
        b=jV/zYp5TExu1lGaK48GqaxKWmepRx7wxITpt6I/UaX6CIoeCfrmxonpab6FhRgYv1A
         NKErVIt0kmRcITIaFxNvhuvfd0M0oIJQxzEe2FQmC1HAJ13zSCJY6Ds91sMdxGeXojoi
         fKl+aEe7VqFKyCOy+hv9zjNs8z6vINwL0hm/SdJyF9EE7+HPkZjjOM7qHHaBlwYX095A
         y3v5KXa0OGb1t4cVyBOH/bzVFCEGac/WwAjWwkaTnYON9HhmsoAnNl0B2oKL0QPStGmz
         ZX78+vlHJjTfGxufEglqlq+JvaD/LN69mAsRM+FxCw5aJm/TNeblAWPzuoOf9oY86KBJ
         t0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782021201; x=1782626001;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/sKTEllek34/Q+S8T2rwfc1PDoPkR7+Mi2Hzxj7GD8c=;
        b=JPWohI7eT8YX0IgEqwWe0dZrX0vakZCypdBS0PohH+ipUtv3M6XTJnBb6NS8JUC6Xk
         bmuAAjIrmxlolGp1S6maKbh2S0iwF+l1kY0ETZYQCmwfeg9qSJmgFn0JU5pgKUTtRWSx
         1C7VhiRIEe83BFibDT4C6oybsKOqvPFlwnMe2DuBh7DBVLasABxNedxsSUSc/QI7ZwUa
         pQXBo80LnuYnUTtvX7cj4Nzqfn5jyljb442z3YBX07/i6sLsvYYdJf5GARa1iUJLX3IG
         MLH9DcEzatp/4FYRdisZ8sMs+5dH0H2TJYThKOLpbuRufbQ08FQWZVL43neWoIGtND2p
         /koQ==
X-Gm-Message-State: AOJu0YwsrayzN57DwRlcSy9+Hw0X/pVuNl51xVtioo7Edo0arM5Xdmiu
	d0TuHwoGlzErgNd6N8DSIONvsLJU5T8jeDLy5Bi572uOt8tU5hYbPeIybBkKJQ==
X-Gm-Gg: AfdE7cls5s3dB3u9qkQptz4mAXHM4Ui3QZlHcL8HnuQZp1rcYQ8pte0sFW2xzJUEIu7
	s3ZdwUukiiBjbj3gT8BF8dDZP5fVYbR6NVNTCwbJ9Z8IXjOnH+lAYpIuDxAhiguGdr2kTP17gaG
	vZM4yHl7dh8e22HGYN6QdnE/Et6+AmYHWyEoLDWOBhMa3sH0jpTxyY5y3rF+hLQaC1LEF6ObriD
	Y/+GYXfZ9/+3207UHVzudykbfCiHpGm5hBsNzXUX/NOVHlKxQGDa4o7IxLic8kxGAiexuYqWmm/
	aGoSO5+K7gsKWH5oK+G9x4xh9g6yBAKHqeTz/DwxGHQ0/MOQ9qyp7Rc9RMWvcI9r++xTpZxvmCu
	Zx9S1gK+vhOeH6F2L4/sfhGVdaBaBh2pIvIdnmG3xLl4ujymliN7JiyXKIzLURz31VzBYpdKo99
	cdFI0aj64LI3g+6O3Py/ZUqYfLN48R
X-Received: by 2002:a05:622a:1482:b0:517:8f2e:5d84 with SMTP id d75a77b69052e-519e4913abfmr149737801cf.3.1782021201087;
        Sat, 20 Jun 2026 22:53:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.178.117.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde4b3sm51696176d6.28.2026.06.20.22.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 22:53:20 -0700 (PDT)
Message-Id: <85c7817d7eb2f2598940ae9dfa065aaedd9fe5a9.1782021195.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
References: <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
	<pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Jun 2026 05:53:15 +0000
Subject: [PATCH v4 4/4] history: re-edit a squash with every message
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

Gather the messages of every commit in the range, oldest first, and use
them as the editor template when re-editing, mirroring how "git rebase
-i" presents a squash. The combined message is built before the
descendant walk so it is not disturbed by the flags that walk leaves on
the commits.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-history.adoc |  5 +--
 builtin/history.c              | 61 +++++++++++++++++++++++++++++++++-
 t/t3455-history-squash.sh      | 37 +++++++++++++++++++++
 3 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 6716749cde..df389015aa 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -111,8 +111,9 @@ history squash @~3..` folds the three most recent commits into one, and
 `git history squash @~5..@~2` squashes an interior range while leaving
 the two newest commits in place.
 +
-The oldest commit's message and authorship are preserved by default,
-unless you specify `--reedit-message`. A merge commit inside the range is
+The oldest commit's message and authorship are preserved by default. With
+`--reedit-message`, an editor opens pre-filled with the messages of all the
+folded commits so you can combine them. A merge commit inside the range is
 folded like any other, but the range must have a single base, so a range
 that reaches more than one entry point (for example a side branch that
 forked before the range and was later merged into it) is rejected.
diff --git a/builtin/history.c b/builtin/history.c
index 4f1baea56c..ff3bc9f945 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1068,6 +1068,56 @@ static int find_interior_ref(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
+static int build_squash_message(struct repository *repo,
+				struct commit *base,
+				struct commit *tip,
+				struct strbuf *out)
+{
+	struct rev_info revs;
+	struct commit *commit;
+	struct strvec args = STRVEC_INIT;
+	int n = 0, ret;
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
+	while ((commit = get_revision(&revs))) {
+		const char *message, *body;
+		struct strbuf one = STRBUF_INIT;
+
+		message = repo_logmsg_reencode(repo, commit, NULL, NULL);
+		find_commit_subject(message, &body);
+		strbuf_addstr(&one, body);
+		strbuf_trim_trailing_newline(&one);
+
+		if (n++)
+			strbuf_addch(out, '\n');
+		strbuf_addbuf(out, &one);
+		strbuf_addch(out, '\n');
+
+		strbuf_release(&one);
+		repo_unuse_commit_buffer(repo, commit, message);
+	}
+
+	ret = 0;
+
+out:
+	reset_revision_walk();
+	release_revisions(&revs);
+	strvec_clear(&args);
+	return ret;
+}
+
 static int cmd_history_squash(int argc,
 			      const char **argv,
 			      const char *prefix,
@@ -1092,6 +1142,7 @@ static int cmd_history_squash(int argc,
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
+	struct strbuf message = STRBUF_INIT;
 	struct oidset interior = OIDSET_INIT;
 	struct commit *base, *oldest, *tip, *rewritten;
 	const struct object_id *base_tree_oid, *tip_tree_oid;
@@ -1131,6 +1182,12 @@ static int cmd_history_squash(int argc,
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
@@ -1139,7 +1196,8 @@ static int cmd_history_squash(int argc,
 	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
 	commit_list_append(base, &parents);
 
-	ret = commit_tree_ext(repo, "squash", oldest, NULL, parents,
+	ret = commit_tree_ext(repo, "squash", oldest,
+			      message.len ? message.buf : NULL, parents,
 			      base_tree_oid, tip_tree_oid, &rewritten, flags);
 	if (ret < 0) {
 		ret = error(_("failed writing squashed commit"));
@@ -1160,6 +1218,7 @@ static int cmd_history_squash(int argc,
 
 out:
 	strbuf_release(&reflog_msg);
+	strbuf_release(&message);
 	oidset_clear(&interior);
 	commit_list_free(parents);
 	release_revisions(&revs);
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index 821c801153..1fb3b9b63e 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -135,6 +135,43 @@ test_expect_success 'preserves authorship of the oldest commit' '
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
+	cp "$1" buffer &&
+	echo combined >"$1"
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash --reedit-message start.. &&
+
+	test_grep "re-one subject" buffer &&
+	test_grep "re-one body line" buffer &&
+	test_grep re-two buffer &&
+	test_grep re-three buffer &&
+	git log --format="%s" -1 >actual &&
+	echo combined >expect &&
+	test_cmp expect actual
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
 test_expect_success '--dry-run predicts the rewrite without performing it' '
 	git reset --hard three &&
 	head_before=$(git rev-parse HEAD) &&
-- 
gitgitgadget
