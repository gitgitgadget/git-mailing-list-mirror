Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194543090D4
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338110; cv=none; b=ZqAkHemZebdhjckLzZy7WTbco4+Nw3OwAH0vUBNMW3Tg+NMtl6C+/GXhfS0GiF4XBu2zmuuWzB6QthAkrsF4oRbM2dGiRJivYbUZ5tn7G3xtbqCy/DIFEWyEf+XTMrCBDEUnsltISc3mpIFKRIS1+Q7YTqWnws5qzZxq5u+mr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338110; c=relaxed/simple;
	bh=KfEXaWEm6s68OrGo1Cvy2k0QEK642k+b4YI10J9FgRc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Msv5B061YKtY5nLBPsAN9NCUGndxA6wV8bvkQF9ftp8RGlMAjA2fjDNo1kbAPeFIiUmKJevmJYEso935RkDwau5uZxU9sZSt+dm6b3tqeSsbWk7NzVgOtlbCTumRDvl1Rar8NUdv7Hm6ajhCFkf2LNWdAngx3/jfzkYlqAPT6h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+GO0KY4; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+GO0KY4"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92542fa7d07so32675885a.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338108; x=1782942908; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynI0FsvrbjQyHgZ/eeIWMRj3VQn3m3f6roKqpIxxb1U=;
        b=o+GO0KY4o4lnWsWuGzcTmgAzyL8Zgrml5XSY7DEdmaHJ2wXtTdRPSRqrM2JVAemsG/
         uvk6auToLUaj8nCQ3YgZ73DS+sXABIUkXWVmmf3ht/9CsQD5kCMq64+ShBIinwrGVLK9
         PQ1WYoG43gFrCVfPKfAYxB5lCZDpDGBdnJ6YyUURNWCBoK5cCiLCf5rzcSVHhK3jP64y
         /5eZv9cvhzUR2e6g4T6lgs50KHjuL4vMtWtVTyrszuHdb6r22lKPU0r6ejtGd871Zhbb
         sUBHp88uD/Kh1HDyQm8KU/NLFPirEMNopIQJWz5P8YyKUOEK2holsNjUhcueEFIGF+4k
         US/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338108; x=1782942908;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ynI0FsvrbjQyHgZ/eeIWMRj3VQn3m3f6roKqpIxxb1U=;
        b=WrTatOdyqWaiY9jxNTp1dPRnAI7uvskgf1epJPngQa+pbpZp6PoU2HbLGkcRawgntt
         nG7Rn6lZ/kZlYOh0kWB/yC87UoTQhbSF6f7d4nftQq/QCme+vf2kigK4mLnTeL0xfuxC
         6utzHVQbkUz/iP0uu3/MD1Vox6DiHOb7SLE/QObVxt6dthzkJUUyzz5ifebZpxllDGB8
         ReXT3sVWVXGVqdVhD9e9HwbvMyeFlt/EFzp9hxNXTr2n/fapyWueZ2nAJGSIZeyaMrIL
         rDtQ9nfil7fASLFD00mz5SsQUfiTKXQOqWFxSz4zMu6/RHdWeOmhb2VXtS0QFwJtO6M/
         BdAw==
X-Gm-Message-State: AOJu0Yw5GUendWVxUt/u+UsDVUah+LWf+sWMaj45r8wGlggYfWwIDLTG
	Vs52IINVYVvUZEwmxYgd/zCe00LdB/uBwRlXDpXQ15Dm+Un0FxxFeoVR6E9XMYHj
X-Gm-Gg: AfdE7ck3nZR4okNrleVoVqSubQ5aX9jZL1Ldf03TQ7/DbEsN+T7NCioIR3o3PGyaytA
	KdpmJtlRtAhuWGtCoxfMfeLZL79BMo9xyXH6d9dLtRRXCxG52EW3+wdk4lpzFawabopB/ly0S+D
	MBjSDna2Wz1nki06oKbZNiDlbfjj1BAokQaFVQsvnOlOSVM2uRoyUVx3jlZeLiyBiqboH2znyZ4
	9MiUAqC+GPLxacfB/whRZDAi/RI3uexBDaNcQAMVbNLkVwLvd55Fg8WaSO2u6pnck5zcDZSxUhx
	N77nlxJdyzgz4ekRmhLwz7OXdq0nvZRNCjBD9LcytUfEw+6jG60fdHDTyCqhV3YxiuOW4NFT4lr
	jyrv+WwjijoVEmatdSeVOi3cW/6YhtVh130SoDXqPgt2uFEf1c4Oop4xwEA6XpS3oN/NLBltxz0
	fQVGl/xlxQY2/FcBA=
X-Received: by 2002:a05:620a:4693:b0:915:fc16:2ae0 with SMTP id af79cd13be357-92601f1b941mr1484089485a.25.1782338107828;
        Wed, 24 Jun 2026 14:55:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.191.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fe040904sm660909585a.20.2026.06.24.14.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:07 -0700 (PDT)
Message-Id: <a758e1f08403893e72e606174d02278ecf9b829b.1782338102.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
	<pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:55:02 +0000
Subject: [PATCH v5 4/4] history: re-edit a squash with every message
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
index 0acfabed66..e93f8398e6 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1081,6 +1081,56 @@ static int find_interior_ref(const struct reference *ref, void *cb_data)
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
@@ -1105,6 +1155,7 @@ static int cmd_history_squash(int argc,
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
+	struct strbuf message = STRBUF_INIT;
 	struct oidset interior = OIDSET_INIT;
 	struct commit *base, *oldest, *tip, *rewritten;
 	const struct object_id *base_tree_oid, *tip_tree_oid;
@@ -1144,6 +1195,12 @@ static int cmd_history_squash(int argc,
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
@@ -1152,7 +1209,8 @@ static int cmd_history_squash(int argc,
 	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
 	commit_list_append(base, &parents);
 
-	ret = commit_tree_ext(repo, "squash", oldest, NULL, parents,
+	ret = commit_tree_ext(repo, "squash", oldest,
+			      message.len ? message.buf : NULL, parents,
 			      base_tree_oid, tip_tree_oid, &rewritten, flags);
 	if (ret < 0) {
 		ret = error(_("failed writing squashed commit"));
@@ -1173,6 +1231,7 @@ static int cmd_history_squash(int argc,
 
 out:
 	strbuf_release(&reflog_msg);
+	strbuf_release(&message);
 	oidset_clear(&interior);
 	commit_list_free(parents);
 	release_revisions(&revs);
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index 7227c5c90f..af59ddf6e3 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -137,6 +137,43 @@ test_expect_success 'preserves authorship of the oldest commit' '
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
