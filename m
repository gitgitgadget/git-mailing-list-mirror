Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795386595;
	b=cMUnkbl/cykSJZaJAh9Ge/Wt9TVjpZoubVMbyl04EYRbyMlcLWUOMEIRf1JkyMAuCuA5
	 rNM/VUv0bWQ+DCebPTqK7gg8LoujGgcobAFizB/+Du7/kvNLGui0v2wQxF8Vx343XDyjp
	 qrClY0tNckR1VK8ojUuJzXlb8VJVXfB4mCUi69sMuTzDe/aSMEiyTfTWVzujer162R+BQ
	 82v6ZRitpUQ5Vz4L9jtMO3RjWc/PQQh9ILJ8IeZadVqUHUa3YgVvY+VykZn6kkV6uN+0H
	 4TRCrMyXah9qkC0yuDLir0gPtoDATvydmtdM1Knbf+no5ujGm+IYaxjnTifCc1myhug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795386595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=mjnyTzQ5ibTzqJ/Sq8ZJw79kPAzgU5Yl3gjcGMkQliM=;
	b=BKAQVbaZrJcU24BQZbFgChpjPQmYG9QzO0lNIfVNpiXtdD/3iTEgHh/vB8ue30Qhx6lF
	 12nH3dyrDhJyKtpa5LlVbpOVkLy2WHkzqh5SD9IEAMXjeQGY4fgOiAASPd1sJJUbn42zf
	 0KBJ6zTE+20FyXUPL4BU7loriS9J9WkjmkW8ynu+FpYQACXtwEDcoSOGc3INVLC5Cp7LC
	 CBIPmMj5LcrBG1vVGELeAA+q8d3M+aUFmS5gt7wo/8Auam73hJpzq/fcSityEisMAOG0E
	 mXjI9FAld7GdcOaGOSaKrUekeYCCZHEXjryuUfUUqkyRzS9ZLYmc5YzOquiQtDMOwUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kbFEMFK8;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF96606A31A
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 22:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BF96606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kbFEMFK8
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-5642e0910a3so1273229b6e.0
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795386594; x=1795991394; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mjnyTzQ5ibTzqJ/Sq8ZJw79kPAzgU5Yl3gjcGMkQliM=;
        b=kbFEMFK8oSZPJs/9Q/b51BXpjIYNfvbgIoANauTetFtATUxsP1dPhvBnwGKrHzyBtg
         /ZwzL8/TyGMFZ2Y194mHPxTHg4j5rOy5MeRetnLDI3Ek77xh4hapqGNr0hR3po+egCve
         wFkoYawxCfkg//2IH7m7UU36/i+S2hHXsyiLw12e9uW9Mo8JVUkVnTd4RKWt+rcWkUSn
         gbBEIJjdFwJEGRlETCtwkuH4OOS/20vr1CoPKdu8ddFujzDHJMkojmZeW1nRNb8hlNJ1
         bTs7VeVZ4w62uiUkIXZvDVvLSliGEP/iXnN2OrqRyf4/DCgDRMUY6dSzJMvNUPW9o1uy
         CDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795386594; x=1795991394;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mjnyTzQ5ibTzqJ/Sq8ZJw79kPAzgU5Yl3gjcGMkQliM=;
        b=vq4gRFwM0NOFHgt16jGgMhavJjJL+FUWxg3WhVzGuXG6ZnKSq3s3vKluST4RXXzZpq
         bWE3SEGFA6MPNWXuIiEfS4PX1Hjv0ngluETQGs6UFCzu3h4J3vzaVFi4QzhF0qjbYG+c
         Mw/DgaKnHSP0d6KqLP8zz3NdATcI8NcStwmHXWJdXOxaYmga45RiHFzITw86PT0b8IJC
         njt4x6swnCWUS8IAYjg/29jaPgpmDwYWMzcKkecHa+iGy4I13lqZ/JDR9Z+AzdwaeG87
         0WI3GrYTvcz5FuaADVN+K07j3EJ3EZDre+WxF4/+FH3jBzxbfCWA1z9coCR+QHHVyuTS
         1lKQ==
X-Gm-Message-State: APuU4Z9EmUkrndz/XpUAm3iXkZ8Z3r9xN0M8MUTaY+FuTvRLrbO9lo+d
	QAun1D5bbVpPyFwyC9J6VqeZxX3KdMjNWlblSA8UCyqkZDU96HRHlyjAQ57zKHf5
X-Gm-Gg: AZFdTZdFjclK7+dCjtIlh3kJ4gU0tV0HsKVIz0cXECY3p7eB494QBqc4aGFg3vMS+cW
	LRObIYDvRwj9y5Dyr5q8Ff7Y4yEk27yAuYbw0zPTyc5ROVA0P6bw5U3GGDHAVLBiT42+FtJAoHO
	4KisHszqFv48VUoQfMLxDG1A0h9Q2OZqDBdPW2DovqkQvEqs1Z7fEnJXdGLmkjxRJ0weDU7QxiO
	KZTFPD7XibmmdBEUkOsUcIzZJhjWyUFoY4WxaYdkebGdewi8hN+9FpdtzOm1Cj/3quzueJfD4g7
	/xD6gxsr8EiLOJUOoqO7fe13wrJnLtFAQupV7/VixlBS2sH/bfALv9zNqDkAOvUo43HNbmH4SBU
	9ZUi+wWznUsk/uDzjUcQZWqZXW6Etp8fwXo8wD5WSIaEcuY/7ppKT9iJkQ/MW0rmr+QvQJs3Gqh
	ueu3aNEXkNmL9hRsSneXbq1LWtuC2XTq3EvG2oz31qg958R9Nk7woeXtQENoRf+hQVbGovrmyQv
	6weE5hpxkKxDi7fU3uxdFJaRi6e+TFYzgZ4bWa5vEbPdK6qkrJW1wA6ibDd3QH7dhEyInRDJnYU
	PtGgzoe5Vua0DEEDFhNYHmKlU1rN5yUy
X-Received: by 2002:a05:6808:1907:b0:574:6f37:6721 with SMTP id 5614622812f47-57a0a930350mr11554356b6e.11.1795386593843;
        Sun, 22 Nov 2026 14:29:53 -0800 (PST)
Received: from [127.0.0.1] ([52.183.219.68])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc60497300sm9582434fac.11.2026.11.22.14.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:29:52 -0800 (PST)
Message-Id: <pull.2501.git.git.1795386591089.gitgitgadget@gmail.com>
From: "Stepan Koltsov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Nov 2026 22:29:51 +0000
Subject: [PATCH] dir: skip prep_exclude() when fsmonitor is trusted
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ilia K <ki.stfu@gmail.com>,
    Paul Tarjan <github@paulisageek.com>,
    Stepan Koltsov <stepan.koltsov@gmail.com>,
    Stepan Koltsov <stepan.koltsov@gmail.com>

From: Stepan Koltsov <stepan.koltsov@gmail.com>

"git status" calls prep_exclude() for every directory in the
untracked cache, to drop a cache entry if its .gitignore rules
changed. That matches every directory against the exclude patterns
and reads every .gitignore. With fsmonitor it is unnecessary:
fsmonitor already drops the cache entry when anything in the
directory changes, including .gitignore.

Skip the call in valid_cached_dir() when fsmonitor is on and the
cache entry is still valid.

One case is left: a .gitignore is edited while the monitor is not
watching, for example while the daemon is stopped. The monitor then
sends a trivial response. Since 1cf98cb4d9 (fsmonitor: check the
untracked cache after a trivial response, 2026-11-09) the cached
directories are rechecked after one, but only by their stat data.
Editing a file in place does not change the stat data of its
directory, so only prep_exclude() notices the edit. Make that
recheck also invalidate every directory that has a .gitignore.

This is a trade-off: each such directory is read again once per
trivial response. Hashing its .gitignore instead would avoid that,
but would have to reproduce how add_patterns() chooses the object
name it records, so prefer the simpler check.

On macOS with the builtin fsmonitor daemon, in a tree of about
89,000 directories with a warm untracked cache,
"git status --untracked-files=all" went from about 310 ms to about
65 ms, and the time spent in read_directory() from about 255 ms to
about 8 ms.

Assisted-by: LLM
Signed-off-by: Stepan Koltsov <stepan.koltsov@gmail.com>
---
    dir: skip prep_exclude() when fsmonitor is trusted

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2501%2Fstepancheg%2Ffsmonitor-skip-prep-exclude-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2501/stepancheg/fsmonitor-skip-prep-exclude-v1
Pull-Request: https://github.com/git/git/pull/2501

 dir.c                        | 15 ++++++-
 dir.h                        |  7 +--
 t/t7527-builtin-fsmonitor.sh | 82 ++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 4f748800b1..48b11b1636 100644
--- a/dir.c
+++ b/dir.c
@@ -2568,6 +2568,14 @@ static int valid_cached_dir(struct dir_struct *dir,
 	if (untracked->check_only != !!check_only)
 		return 0;
 
+	/*
+	 * With fsmonitor, a still-valid entry has had no working-tree
+	 * changes, including to .gitignore, so the prep_exclude()
+	 * check below is redundant.
+	 */
+	if (dir->untracked->use_fsmonitor && untracked->valid)
+		return 1;
+
 	/*
 	 * prep_exclude will be called eventually on this directory,
 	 * but it's called much later in last_matching_pattern(). We
@@ -4076,8 +4084,13 @@ static int invalidate_stale_dirs(struct untracked_cache *uc,
 	int nr_invalidated = 0;
 	unsigned int i;
 
+	/*
+	 * Editing .gitignore in place does not change the stat data of
+	 * its directory, so do not trust a directory that has one.
+	 */
 	if (ucd->valid &&
-	    (lstat(path->buf, &st) ||
+	    (!is_null_oid(&ucd->exclude_oid) ||
+	     lstat(path->buf, &st) ||
 	     match_stat_data_racy(istate, &ucd->stat_data, &st))) {
 		invalidate_one_directory(uc, ucd);
 		nr_invalidated++;
diff --git a/dir.h b/dir.h
index 7af1562b44..b945068072 100644
--- a/dir.h
+++ b/dir.h
@@ -605,9 +605,10 @@ void untracked_cache_invalidate_trimmed_path(struct index_state *,
 					     const char *path,
 					     int safe_path);
 /*
- * Invalidate every cached directory that no longer exists or whose
- * stat data no longer matches the working tree. valid_cached_dir()
- * skips this check while the file system monitor is trusted.
+ * Invalidate every cached directory that no longer exists, whose
+ * stat data no longer matches the working tree, or that has a
+ * .gitignore, which may have been edited in place. valid_cached_dir()
+ * skips these checks while the file system monitor is trusted.
  * Returns the number of invalidated directories.
  */
 int untracked_cache_invalidate_stale_dirs(struct index_state *);
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index f2770e9056..d46b90739f 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -1429,4 +1429,86 @@ test_expect_success UNTRACKED_CACHE 'untracked cache is checked after a trivial
 	test_cmp expect actual
 '
 
+test_expect_success UNTRACKED_CACHE 'untracked cache sees .gitignore edit after a trivial response' '
+	test_when_finished "stop_daemon_delete_repo test_trivial_gi" &&
+
+	git init test_trivial_gi &&
+	mkdir -p test_trivial_gi/dir/sub &&
+	echo secret >test_trivial_gi/dir/sub/.gitignore &&
+	echo x >test_trivial_gi/dir/sub/secret &&
+	echo y >test_trivial_gi/dir/sub/visible &&
+	git -C test_trivial_gi add dir/sub/.gitignore &&
+	git -C test_trivial_gi commit -m initial &&
+	git -C test_trivial_gi config core.fsmonitor true &&
+	git -C test_trivial_gi config core.untrackedCache true &&
+
+	# A directory changed in the same second as the index was
+	# written is rechecked anyway. Make dir/sub older, so that
+	# only its .gitignore can get it invalidated.
+	test-tool chmtime =-60 test_trivial_gi/dir/sub &&
+
+	echo "?? dir/sub/visible" >expect &&
+	git -C test_trivial_gi status --porcelain >actual &&
+	test_cmp expect actual &&
+	git -C test_trivial_gi status --porcelain >actual &&
+	test_cmp expect actual &&
+
+	# Edit .gitignore in place while no daemon is running. "git add"
+	# then starts a new daemon, receives its trivial response, and
+	# does not look for untracked files.
+	git -C test_trivial_gi fsmonitor--daemon stop &&
+	echo visible >test_trivial_gi/dir/sub/.gitignore &&
+	echo other >test_trivial_gi/other &&
+	GIT_TRACE2_EVENT="$PWD/trace_trivial_gi" \
+		git -C test_trivial_gi add other &&
+	have_t2_data_event fsm_client query/trivial-response <trace_trivial_gi &&
+	git -C test_trivial_gi fsmonitor--daemon status &&
+
+	cat >expect <<-\EOF &&
+	 M dir/sub/.gitignore
+	A  other
+	?? dir/sub/secret
+	EOF
+	git -C test_trivial_gi status --porcelain >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success UNTRACKED_CACHE 'untracked cache sees .gitignore edit reported by fsmonitor' '
+	test_when_finished "stop_daemon_delete_repo test_gitignore" &&
+
+	git init test_gitignore &&
+	mkdir -p test_gitignore/dir/sub &&
+	echo secret >test_gitignore/dir/.gitignore &&
+	echo tracked >test_gitignore/dir/sub/tracked &&
+	echo x >test_gitignore/dir/sub/secret &&
+	echo y >test_gitignore/dir/sub/visible &&
+	git -C test_gitignore add dir/.gitignore dir/sub/tracked &&
+	git -C test_gitignore commit -m initial &&
+	git -C test_gitignore config core.fsmonitor true &&
+	git -C test_gitignore config core.untrackedCache true &&
+
+	# The first status starts the daemon and builds the untracked
+	# cache, the second one saves what the trivial response of the
+	# new daemon left invalid, and the third one trusts all of it.
+	echo "?? dir/sub/visible" >expect &&
+	git -C test_gitignore status --porcelain >actual &&
+	test_cmp expect actual &&
+	git -C test_gitignore status --porcelain >actual &&
+	test_cmp expect actual &&
+	GIT_TRACE2_EVENT="$PWD/trace_gitignore" \
+		git -C test_gitignore status --porcelain >actual &&
+	test_cmp expect actual &&
+	test_trace2_data read_directory opendir 0 <trace_gitignore &&
+
+	# dir/sub has no .gitignore of its own, the rules for it change
+	# with the one in its parent directory.
+	echo visible >test_gitignore/dir/.gitignore &&
+	cat >expect <<-\EOF &&
+	 M dir/.gitignore
+	?? dir/sub/secret
+	EOF
+	git -C test_gitignore status --porcelain >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
