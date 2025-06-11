Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E61494A8
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749606138; cv=none; b=LhEsSS+BlYdfzIJCLdGavFi+9631kltap1gvTm00e2QawXe82V9taq+kARJZ5MoCOpGoZmcSLWl8kyu2ODxXJ9eDL98xJm8b/ZLoSGDSZ4WPQRiUl40tTqd3DSWs0lxxLq/5Aq0Xjjd0T+4wehMzv++t9QV5NFA5w7j5EEiS0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749606138; c=relaxed/simple;
	bh=hJ5vPjcAxab9nJm08ktKnEHl2OeGxJ/9RGWZYvBHIp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgomSOg+gF2qgomZDNScNYcOWmgAo9pv2cwHW/ZgLoSg5KlfQqp8lIPCkTIdLKvJoi7i3OlPb0IhkZapaqwiyagZT7yMbfJuxSVdi/DrWh0zrXOJjduVQ4+ztSyO6O2DejVi/GyCSOZUmp14hDgLygpvR/MPJGe7HLxh1M3IJbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8AlFP6L; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8AlFP6L"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so4654904b3a.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 18:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749606136; x=1750210936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWX6HBFdkl5fW6FmvNVgaknsWgO9e+mPJAb7dGonoU8=;
        b=Y8AlFP6L8VGTWbJ2pfl6lGVMUKH21VaBn2iMntoz01JltoAhiE63WXAqznWrFzAr0k
         7OiJxXKKdOAf/XBAst1wA+35x6Ye7KGdKIqInGAyj4b2NYK4sP9DLsMvrqomotKA2Byi
         eru2TfT8OKFpC3U8EaBlllmlmY95nBNkWNr6admdYogoDW0KENO1r8g81sofqAYNFx/Q
         XHAi94/KtO6tVJDMZaOz8RM6kw1m0U37Ipl4PNaaR1brKRdU4j5GY1HhdvB0CXeY5dO8
         sp4DmgafXEN25+EWGxEYsBD08XY11p27YFpWkXMQcFQ6STBkGtuFo4QiU70cgz1lSW8I
         /knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749606136; x=1750210936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWX6HBFdkl5fW6FmvNVgaknsWgO9e+mPJAb7dGonoU8=;
        b=h//jarenMvPDF+bYJQM2qaQt4F2qbnz6V7ihZuvB87F0UuDakU3p0BcuZuWi7cv994
         fRalitf1lyd444vLhRa6GhWEIWp8d6ogJuvE2oycUqohIDTiiZFkDn1c5z63PwqIhn+t
         mxf1CJk766P3qqrTyt2gN0jANdWSjPj4RZv5SuENmUN26iTsEuaX0xMmkjYap6zIz7lU
         nUeoT3Gv90gCMq0lnaUH5xg7L/QprPNFKGZpOU7wJm+E+vnEK4QjZ+iJ4XshqEZQUgAB
         laMAq3vout7lbKyT/K8dZmldASL1lY0pJ8DjqA1qgBPvcn2exUsGLm5+OpceijdNBX2E
         jRew==
X-Gm-Message-State: AOJu0YyR3ijty/pZza/lYMIFfsTzI5F7+GJwzyBsBNhyJqIGvNHpt5+n
	nO6cOjn3GaDr7RYQdifX8yfdnmYWy1QuqzbHxQm0gGN6uMoiO04CGiaP
X-Gm-Gg: ASbGnctQIIqCVG3z8cr3QWhVW2RwN2HQn8z3eUQz4RVCQvwy5mny8/gUf1ZZ54mSzC5
	UlKMCJPZaM0bsTRS7V2rEIYiSffvtuSqCKTEQm/zTSBMjDcOTLRS+uZ8Y2fFaTV7w8l5XBkezUY
	7FIBGQ6dCKGS5eUJqaPOpXzadwj2NMviBbAegAQhEGXIeg+IWviuehkyganEn80FxlAgG5IucIY
	mJXLtFud1aGhdc9LT+5GBdQJrNZTU4JY0+bUSDWZFvbgXreyihb9FCbQJ+XhdsyqUBllu5r3prJ
	OLAmJkWqoega/cIzc7yg8q+Vi9J/LI5Um8w8B0M2Pq5v6EGptLQDKkVxK+zmVCNdQQyoCyhzyns
	=
X-Google-Smtp-Source: AGHT+IHpiy9bo7WUFp4fQdQMUj1rgHx+VymppOzP11+YKM34E5Nr7IODX13n8RtK5UG+7G0YI5FmnA==
X-Received: by 2002:a05:6a00:1992:b0:740:b372:be5 with SMTP id d2e1a72fcca58-7486cb7177bmr1737428b3a.9.1749606136280;
        Tue, 10 Jun 2025 18:42:16 -0700 (PDT)
Received: from fedora ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0c1168sm8269707b3a.136.2025.06.10.18.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 18:42:15 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	l.s.r@web.de,
	smacdonald@kaimaging.com,
	sunshine@sunshineco.com
Subject: [PATCH v3] stash: fix incorrect branch name in stash message
Date: Wed, 11 Jun 2025 07:12:03 +0530
Message-ID: <20250611014204.24994-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <xmqqo6uyw6h4.fsf@gitster.g>
References: <xmqqo6uyw6h4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating a stash, Git uses the current branch name
of the superproject to construct the stash commit message.
However, in repositories with submodules,
the message may mistakenly display the submodule branch name instead.

This is because `refs_resolve_ref_unsafe()` returns a pointer to a static buffer.
Subsequent calls to the same function overwrite the buffer,
corrupting the originally fetched `branch_name` used for the stash message.

Use `xstrdup()` to duplicate the branch name immediately after resolving it,
so that later buffer overwrites do not affect the stash message.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
1. Used the hook to remove trailing whitespaces
2. Removed the else clause 
3. Changed the test title to the suggested one 
4. Avoided --quiet Flags in Tests
5. Used git -C sub ... instead of cd sub && ... && cd ...

 builtin/stash.c  | 12 +++++++++---
 t/t3903-stash.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index cfbd92852a..4215ee781c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1372,6 +1372,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	const char *head_short_sha1 = NULL;
 	const char *branch_ref = NULL;
 	const char *branch_name = "(no branch)";
+	char *branch_name_buf = NULL;
 	struct commit *head_commit = NULL;
 	struct commit_list *parents = NULL;
 	struct strbuf msg = STRBUF_INIT;
@@ -1401,11 +1402,15 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		ret = 1;
 		goto done;
 	}
-
+	
 	branch_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 					     "HEAD", 0, NULL, &flags);
-	if (flags & REF_ISSYMREF)
-		skip_prefix(branch_ref, "refs/heads/", &branch_name);
+
+	if (flags & REF_ISSYMREF) {
+		if (skip_prefix(branch_ref, "refs/heads/", &branch_name))
+			branch_name = branch_name_buf = xstrdup(branch_name);
+	}
+					    
 	head_short_sha1 = repo_find_unique_abbrev(the_repository,
 						  &head_commit->object.oid,
 						  DEFAULT_ABBREV);
@@ -1495,6 +1500,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	strbuf_release(&msg);
 	strbuf_release(&untracked_files);
 	free_commit_list(parents);
+	free(branch_name_buf);
 	return ret;
 }
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 74666ff3e4..5678223cfb 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1592,4 +1592,36 @@ test_expect_success 'stash apply reports a locked index' '
 	)
 '
 
+test_expect_success 'submodules does not affect the branch recorded in stash message' '
+	git init sub_project &&
+	(
+		cd sub_project &&
+		echo "Initial content in sub_project" >sub_file.txt &&
+		git add sub_file.txt &&
+		git commit -m "Initial commit in sub_project"
+	) &&
+
+	git init main_project &&
+	(
+		cd main_project &&
+		echo "Initial content in main_project" >main_file.txt &&
+		git add main_file.txt &&
+		git commit -m "Initial commit in main_project" &&
+
+		git -c protocol.file.allow=always submodule add ../sub_project sub &&
+		git commit -m "Added submodule sub_project" &&
+
+		git checkout -b feature_main &&
+		git -C sub checkout -b feature_sub &&
+
+		git checkout -b work_branch &&
+		echo "Important work to be stashed" >work_item.txt &&
+		git add work_item.txt &&
+		git stash push -m "custom stash for work_branch" &&
+
+		git stash list >../actual_stash_list.txt &&
+		grep "On work_branch: custom stash for work_branch" ../actual_stash_list.txt
+	)
+'
+
 test_done
-- 
2.49.GIT

