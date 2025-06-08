Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8AA94F
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749393980; cv=none; b=D2/2fVIL3UVxqxBd+fzo7d/l/UZYdVyvjd1I3JgSUbcgli9n3Ps3ESx6Ddhv0a16GG8IATffYb+U4ADkKwCXp5Zu/RLI7mcZa/wgTsHfQCtxEKAbqTH3znOd47bAxxySfkxTahuPUR9/Qipj0+qNyKW4hO58BGWGoaV8nHwTq8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749393980; c=relaxed/simple;
	bh=hCt5q+oQCrYPe/gXnOaJV5CCtj3/vprPmMZKKxeOs7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOUzc24wtg/cDKxNPopo5OD6JHDlbU1yfjwq8JhISvnxAHUTxofwRF3QFEPCg5QqbQForZOGcjmTtm3xFKD+vTvsaJppY270RX/beCF+BTGa7vztYHi/CVOkwv5mgFPpiyai0+TpTgvOK+a6f0Ll48ZyoDLlWUQi/BffT7kR9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaihSJAX; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaihSJAX"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3116db72bd7so3976617a91.2
        for <git@vger.kernel.org>; Sun, 08 Jun 2025 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749393977; x=1749998777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v+45PgHtGRPX9kA1HyWl7+jiosrKAa64tokzHAIvD0=;
        b=ZaihSJAXp8qrP5T1cAUOwkFzjHJeh8qUlkmfMW+NUMsMj5HQeLtU/WeW0K5oKWgM7V
         HAJAN05d6gysi8az1PeXlfsJCC+85h82EpuvPDgLiYCGBijJ7zUMz/ZFIV02vHuUYsGM
         3yrHN7F9kyKA2vgR0x+M3AS3lx2TDnlh+xlDjrvgpZD8onXRIrJZliu07lg7Gjy+sGZu
         COPYgs/Negb0Xg5ZkZQTLLUh075kS8G7DH1Lp+k5VTNaf5qAQdHQc+qhsQFOP5Qk3YZ/
         ElUYvx2tB5GI2w2HZdYZhycQNg4muFg7tJZKI9pnrUFXSmzHeAKEkTJ+VEZKokJa2k16
         QExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749393977; x=1749998777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9v+45PgHtGRPX9kA1HyWl7+jiosrKAa64tokzHAIvD0=;
        b=UINFbRpQZ3vqKEmyCpC6mm4a0Uki6N6dUJzDGVYnSnFHf0DrdXrUd+NDt6/bH4Z4st
         Dod9i3U56xlmsWF38UOSEAae9tgFx1dsS3C9rwaJ3twyobcnz+Gd+BF+5vZU/NbVeK/J
         7gyO2dhd6r0yEh5LzdBi0V9FLqmbwfwkVmxURW7lk+xgyCP/r90x7NK+sr8kLpLTUGgr
         WjjRaO4vff78cxqcz56M3LbbZ09KndbriMm8h9dQMjTNKt7vcc5PnRy6A/QyuecmVRVT
         kOEFgdkBm23/f4NWgtx/q/I53DnbJFdqVB8HY4G7o++f4ihjts8F17EGMTF4EmRDTH95
         ij0A==
X-Gm-Message-State: AOJu0Yw/mRq9VnTrI48cxdSVwSYpOV3PJoXi8rh48jTrgTxoNGcPrHE2
	1NVIS7tiojwEH0M4G60U49dv6dpS6XKbbPQM+ZXc5XLgnk/ej0dvRIUb2gIyVF/G
X-Gm-Gg: ASbGncuffFcpOOAsDqEtUcqJzv98/GVeSxGy3Q/4GzZ8xyXgVNpkGc0X3EWDy4Eea6p
	lQj/3OCxAPFFQdZB6+yzU70A/rZ5kAAZv8nWYqI7nmHzJ/yrYbbmxFXjH8HemHz0A3JNQZcOWlS
	6Ckz83qag7JJf/uW9AAaf0W5n/YBnsgTJlaUztEjXu6nlW14/4sQBBemh4eZywktPKYJqhEcf8g
	YXcDhh+tRN3OTyuUBYwcwTKjoIjIeFy7hfp09rQmLNAI6bWOx5avCaWydYg9debHkXLOETlcR0o
	ZcA6VYs1ZhR5TY3wvJpx5ZDwKrNQjb7JBY/Bp7pjClBL/kP6PSoleOf5c5EkGdWbPLB2x17j6SI
	=
X-Google-Smtp-Source: AGHT+IEL8ZY3y5PuIcVuqvVoMZ1QXtTl5sKogAkWRZTSS/GJqcRliG5j8Fmm9S1lTSzPSBW7FQEBWg==
X-Received: by 2002:a17:90b:540f:b0:312:e731:5a66 with SMTP id 98e67ed59e1d1-313472d087amr13897766a91.3.1749393977413;
        Sun, 08 Jun 2025 07:46:17 -0700 (PDT)
Received: from fedora ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134b044e2bsm4146588a91.5.2025.06.08.07.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 07:46:16 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: l.s.r@web.de
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jayatheerthkulkarni2005@gmail.com,
	smacdonald@kaimaging.com,
	sunshine@sunshineco.com
Subject: [PATCH v2] stash: fix incorrect branch name in stash message
Date: Sun,  8 Jun 2025 20:15:42 +0530
Message-ID: <20250608144542.275836-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <f46443ac-eb7f-47db-8f4b-a06384e6fde5@web.de>
References: <f46443ac-eb7f-47db-8f4b-a06384e6fde5@web.de>
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

All good points,
Removed multiple if else blocks and kept them 
within a single if/else block.

Removed the white space at the branch_ref = refs_r... line

removed the spaces in the test case.
Thank you for the feedback.

 builtin/stash.c  | 13 ++++++++++---
 t/t3903-stash.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index cfbd92852a..c71e20a8cd 100644
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
@@ -1401,11 +1402,16 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
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
+	} else
+		branch_name = "(no branch)";
+					    
 	head_short_sha1 = repo_find_unique_abbrev(the_repository,
 						  &head_commit->object.oid,
 						  DEFAULT_ABBREV);
@@ -1495,6 +1501,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	strbuf_release(&msg);
 	strbuf_release(&untracked_files);
 	free_commit_list(parents);
+	free(branch_name_buf);
 	return ret;
 }
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 74666ff3e4..b606827a73 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1592,4 +1592,38 @@ test_expect_success 'stash apply reports a locked index' '
 	)
 '
 
+test_expect_success 'stash reflog message uses superproject branch, not submodule branch' '
+	git init sub_project &&
+	(
+		cd sub_project &&
+		echo "Initial content in sub_project" >sub_file.txt &&
+		git add sub_file.txt &&
+		git commit -q -m "Initial commit in sub_project"
+	) &&
+
+	git init main_project &&
+	(
+		cd main_project &&
+		echo "Initial content in main_project" >main_file.txt &&
+		git add main_file.txt &&
+		git commit -q -m "Initial commit in main_project" &&
+
+		git -c protocol.file.allow=always submodule add --quiet ../sub_project sub &&
+		git commit -q -m "Added submodule sub_project" &&
+
+		git checkout -q -b feature_main &&
+		cd sub &&
+		git checkout -q -b feature_sub &&
+		cd .. &&
+
+		git checkout -q -b work_branch &&
+		echo "Important work to be stashed" >work_item.txt &&
+		git add work_item.txt &&
+		git stash push -q -m "custom stash for work_branch" &&
+
+		git stash list >../actual_stash_list.txt &&
+		grep "On work_branch: custom stash for work_branch" ../actual_stash_list.txt
+	)
+'
+
 test_done
-- 
2.49.GIT

