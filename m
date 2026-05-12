Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AAC3803F7
	for <git@vger.kernel.org>; Tue, 12 May 2026 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620944; cv=none; b=KfXYRHvTCdlLCm/ZNDU0IkK5tUBL1Qz+vCeKN+FpnzTt2w5ACwsox/NQ1+omhCric35B4fIHK+GVWiXQ0Qyyj+FSGGX44EemGZTZUo+wGPBnEJ67NPGVLnn/P6B3vhuXPtGk6pVIW4OpdlI1KhIvm7ueoWqXEUa54HWY3cjagO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620944; c=relaxed/simple;
	bh=r9CaUrTmSHXBQF8ZYgKSf0+CyA8MA+ljXWYpl4H3pig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4LUkbE+txxGPbrq28lWKjhLQheCvUuMpZXzBulFZLTGkaK2RXDs8ZURyQvCqyf6Iol1IvZZZxBe9ZqPyM3ryFQG3u/YSYkuCjT4CUTBWvBGJjE/90kkfT2QUiIDZO2PoRGi/A8DUjdojcmRGr7ZHgBjI97Mny+GWsQLt4WFICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fblr+U6B; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fblr+U6B"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64d5a7926cfso5669456d50.2
        for <git@vger.kernel.org>; Tue, 12 May 2026 14:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778620941; x=1779225741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCBOCC6LBPQbjQN8Z/gaTGK4issScZUU7oT3fb5JKJw=;
        b=Fblr+U6BXY+/y2aNz+UaQdA6hqT9ZBIfumNuXOgpKEHSNi+swmzqaQ47ofIc96UNDx
         9Md+9ZyXYMuQJVfSFZ0V9dWS0S3kzNlT8g+egvIxvCiNNinPIAXCVc3kNUpOXHMsNqaM
         j09n5iCiQiYO3rCQ6rZR7XoAGC3r2IMscXlIKZ9joUN8WIpLc5UiFpjRo3hgal5XnkQJ
         tS3jqRtS44Oy856Pquz5Ugb/5MGO2Lyplg68i3mMm2mMQcpUE+ZH1AiwlUrqtCeT2FhO
         mLIW16LoJ5Tbz2EKvj92ovIXVBACKWYGeGrz9bSbGCkXB9SopVGZDLPuCHi9OdthTJN9
         z4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620941; x=1779225741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCBOCC6LBPQbjQN8Z/gaTGK4issScZUU7oT3fb5JKJw=;
        b=chsFYtSIkhD1GIkVq1+ciFFXSllh348yx2u4IvSAd3bmDUD7Bz9Xzx/AYf4gAmixps
         eDsHkYmuQBL0W4ZLSp3e/MCdNQsuPc3mjSMT5pbs9w6eymkW+rfkNz31HtWPANuievMx
         gDJzPPRFt1AQqeBdNOhpfNrz4teHQbg5PR8/kzvk1MXNf2TCXTiVxdrOPojeVRqhR6Zy
         acIgPPFJCjX2NgDtx1CSNDg765ICyWz/Og/28+GSnuxDJTMPh+0gecB3f8avJ0j55Q0U
         3PHHv1+GoNHRdkJWHf0M8LP9DFUdbUn4J2tD5fGN72gPUwXxG+Kd7Mhs/f2opwMWMQIF
         fP3g==
X-Gm-Message-State: AOJu0YzYJkc+ArKTedfM7yn+cMwEcdR2Oh/bW6yI1ESZ7G4oQ0AFlgHN
	2lVOusVM6+qouhQJAmyyxtKOhF5atytq5JTliKiFtbgH10B7LMsAKoMPhuTBRLpZ
X-Gm-Gg: Acq92OFpvOC3bl///fq7z3u3X2lpO0FB1J2TrJDvXqALvEs0J9rbWxfBpni7+34+Tqk
	7jaHoPrqX53uLvTUgBvzF71JNQ0rY20uAPI9yKpzv6M2SpXyKZlo/NRX5q8IbqSDaRItMaA9XL5
	kUeGILAq2xD+BVZsB6MNO8Wdk+F15HIPNYDNRJC5R7B3iFd124k7UvuDndHdSSeAQwgaTxUSZPM
	N23etgRdRDaOthiQAuUtJ5kSwc0owBdg0RQCvqm32R8zogdfDoGTwUPWf5ok9QbQpc/IGvBrMvD
	BftDog9Huly2+XuHteQHzIpKVVA9U6G4demm1MiJgcprrZBWWSdoh0wsEYGLKMKrwBdZBH2+KU/
	ZYo/cYyWx8XBJ2jvnN/JSLLNRmloVnCk00H1g7HAmjnaA+QEGRHxBy9j/GkkYqT7ojeUdwt2nwM
	JfLoi0Gv8tWzRIlwl1As0a/oeDOGg5ewTE/hrUj/eH00hliPbq+ducLE+tZQFAnBgN6k6K1NCQk
	hX41+IhQ4Zv6w0i+A==
X-Received: by 2002:a53:acc9:0:20b0:65d:b511:3aaa with SMTP id 956f58d0204a3-65df814956dmr43961d50.18.1778620940913;
        Tue, 12 May 2026 14:22:20 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90fb:c300::2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96be4aa2sm7645007d50.15.2026.05.12.14.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:22:20 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Caleb White <cdwhite3@pm.me>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Andrew Berry <andrew@furrypaws.ca>,
	Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
	Dan Drake <dan@dandrake.org>,
	Alex Galvin <agalvin@comqi.com>
Subject: [PATCH v3] ignore: note info/exclude lives in GIT_COMMON_DIR, not GIT_DIR
Date: Tue, 12 May 2026 17:21:43 -0400
Message-ID: <ec97ad3f054e90b675f099a36a81a23bb4b2a0ed.1778620784.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.54.0.564.ge3ee0a11b5.dirty
In-Reply-To: <d58b6e921d3005c6170fc6c47f175214acb3fa68.1778249267.git.ben.knoble+github@gmail.com>
References: <d58b6e921d3005c6170fc6c47f175214acb3fa68.1778249267.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gitignore(5) says that the per-repository ignore file is
$GIT_DIR/info/exclude, but in a worktree that is not the case:

    git rev-parse --git-path info/exclude
    /path/to/main/worktree/.git/info/exclude
    git rev-parse --git-common-dir
    /path/to/main/worktree/.git

We actually use $GIT_COMMON_DIR/info/exclude. Adjust the documentation
and some code comments to say so.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes (benknoble/commits):
    Changes in v3:
    
    Adjust more occurrences
    
    Link to v2: <d58b6e921d3005c6170fc6c47f175214acb3fa68.1778249267.git.ben.knoble+github@gmail.com>
    
    Changes in v2:
    
    Only adjust the documentation.
    
    brian points out that a more general extension would allow using more
    info/ files as "per-worktree," which I don't have the impetus to
    implement myself.
    
    Phillip and Junio asked for a concrete use case:
    
        A colleague is developing a tool for managing the "skill files" of
        various LLM tools (Claude, Windsurf, etc.). The files have
        requirements that make it hard to generically ignore them (e.g.,
        filenames and front-matter have to match), but different tasks
        (corresponding to worktrees) may want different active skills, so it
        is desirable to ignore the files. Think of this like node_modules.
    
        Unfortunately, since per-worktree ignores don't work, the current
        solution is to put a .gitignore file in the corresponding directory
        with the installed skills that ignores itself and the installed
        skills.
    
    Since overall reactions seem fairly negative (or require a more general
    extension, which I think is probably the right course but not simply
    implemented), I've opted to adjust the docs. They originally confused
    me, as I was surprised when my colleague reported that per-worktree
    ignores didn't work (the docs imply they should by use of $GIT_DIR).
    
    Link to v1: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
    
    v1 notes:
    
    Discussed briefly at https://lore.kernel.org/git/CALnO6CCXmA+ATT7CuyWkU6P8qmLCCpMi5Ppr1c78s0heznpVyw@mail.gmail.com/T
    
    This is based on next (4f69b47b94 (Merge branch 'ps/test-set-e-clean'
    into next, 2026-04-23)) but cleanly applies to master (94f057755b (Git
    2.54, 2026-04-19)) and seen (50541634cb (Merge branch
    'js/parseopt-subcommand-autocorrection' into seen, 2026-04-23)).

 Documentation/git-ls-files.adoc    |  2 +-
 Documentation/git-svn.adoc         |  2 +-
 Documentation/gitformat-index.adoc |  4 ++--
 Documentation/gitignore.adoc       | 12 ++++++------
 dir.c                              |  4 ++--
 dir.h                              |  2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-ls-files.adoc b/Documentation/git-ls-files.adoc
index 58c529afbe..2b175388e1 100644
--- a/Documentation/git-ls-files.adoc
+++ b/Documentation/git-ls-files.adoc
@@ -331,7 +331,7 @@ can give `--exclude-per-directory=.gitignore`, and then specify:
   1. The file specified by the `core.excludesfile` configuration
      variable, if exists, or the `$XDG_CONFIG_HOME/git/ignore` file.
 
-  2. The `$GIT_DIR/info/exclude` file.
+  2. The `$GIT_COMMON_DIR/info/exclude` file.
 
 via the `--exclude-from=` option.
 
diff --git a/Documentation/git-svn.adoc b/Documentation/git-svn.adoc
index c26c12bab3..2a7fa60465 100644
--- a/Documentation/git-svn.adoc
+++ b/Documentation/git-svn.adoc
@@ -439,7 +439,7 @@ Any other arguments are passed directly to 'git log'
 'show-ignore'::
 	Recursively finds and lists the svn:ignore and svn:global-ignores
 	properties on directories. The output is suitable for appending to
-	the $GIT_DIR/info/exclude file.
+	the $GIT_COMMON_DIR/info/exclude file.
 
 'mkdirs'::
 	Attempts to recreate empty directories that core Git cannot track
diff --git a/Documentation/gitformat-index.adoc b/Documentation/gitformat-index.adoc
index 145cace1fe..f6a427cb49 100644
--- a/Documentation/gitformat-index.adoc
+++ b/Documentation/gitformat-index.adoc
@@ -291,14 +291,14 @@ Git index format
     sequence in variable width encoding. Each string describes the
     environment where the cache can be used.
 
-  - Stat data of $GIT_DIR/info/exclude. See "Index entry" section from
+  - Stat data of $GIT_COMMON_DIR/info/exclude. See "Index entry" section from
     ctime field until "file size".
 
   - Stat data of core.excludesFile
 
   - 32-bit dir_flags (see struct dir_struct)
 
-  - Hash of $GIT_DIR/info/exclude. A null hash means the file
+  - Hash of $GIT_COMMON_DIR/info/exclude. A null hash means the file
     does not exist.
 
   - Hash of core.excludesFile. A null hash means the file does
diff --git a/Documentation/gitignore.adoc b/Documentation/gitignore.adoc
index a3d24e5c34..7979e50f18 100644
--- a/Documentation/gitignore.adoc
+++ b/Documentation/gitignore.adoc
@@ -7,7 +7,7 @@ gitignore - Specifies intentionally untracked files to ignore
 
 SYNOPSIS
 --------
-$XDG_CONFIG_HOME/git/ignore, $GIT_DIR/info/exclude, .gitignore
+$XDG_CONFIG_HOME/git/ignore, $GIT_COMMON_DIR/info/exclude, .gitignore
 
 DESCRIPTION
 -----------
@@ -34,7 +34,7 @@ precedence, the last matching pattern decides the outcome):
    includes such `.gitignore` files in its repository, containing patterns for
    files generated as part of the project build.
 
- * Patterns read from `$GIT_DIR/info/exclude`.
+ * Patterns read from `$GIT_COMMON_DIR/info/exclude`.
 
  * Patterns read from the file specified by the configuration
    variable `core.excludesFile`.
@@ -50,7 +50,7 @@ be used.
    specific to a particular repository but which do not need to be shared
    with other related repositories (e.g., auxiliary files that live inside
    the repository but are specific to one user's workflow) should go into
-   the `$GIT_DIR/info/exclude` file.
+   the `$GIT_COMMON_DIR/info/exclude` file.
 
  * Patterns which a user wants Git to
    ignore in all situations (e.g., backup or temporary files generated by
@@ -97,7 +97,7 @@ PATTERN FORMAT
    match at any level below the `.gitignore` level.
 
  - Patterns read from exclude sources that are outside the working tree,
-   such as $GIT_DIR/info/exclude and core.excludesFile, are treated as if
+   such as $GIT_COMMON_DIR/info/exclude and core.excludesFile, are treated as if
    they are specified at the root of the working tree, i.e. a leading "/"
    in such patterns anchors the match at the root of the repository.
 
@@ -146,8 +146,8 @@ CONFIGURATION
 
 The optional configuration variable `core.excludesFile` indicates a path to a
 file containing patterns of file names to exclude, similar to
-`$GIT_DIR/info/exclude`.  Patterns in the exclude file are used in addition to
-those in `$GIT_DIR/info/exclude`.
+`$GIT_COMMON_DIR/info/exclude`. Patterns in the exclude file are used in
+addition to those in `$GIT_COMMON_DIR/info/exclude`.
 
 NOTES
 -----
diff --git a/dir.c b/dir.c
index fcb8f6dd2a..33c81c256e 100644
--- a/dir.c
+++ b/dir.c
@@ -2985,7 +2985,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		return NULL;
 
 	/*
-	 * We only support $GIT_DIR/info/exclude and core.excludesfile
+	 * We only support $GIT_COMMON_DIR/info/exclude and core.excludesfile
 	 * as the global ignore rule files. Any other additions
 	 * (e.g. from command line) invalidate the cache. This
 	 * condition also catches running setup_standard_excludes()
@@ -3078,7 +3078,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		istate->cache_changed |= UNTRACKED_CHANGED;
 	}
 
-	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
+	/* Validate $GIT_COMMON_DIR/info/exclude and core.excludesfile */
 	root = dir->untracked->root;
 	if (!oideq(&dir->internal.ss_info_exclude.oid,
 		   &dir->untracked->ss_info_exclude.oid)) {
diff --git a/dir.h b/dir.h
index 20d4a078d6..83e0f648a8 100644
--- a/dir.h
+++ b/dir.h
@@ -153,7 +153,7 @@ struct oid_stat {
  *   - The list of files and directories of the directory in question
  *   - The $GIT_DIR/index
  *   - dir_struct flags
- *   - The content of $GIT_DIR/info/exclude
+ *   - The content of $GIT_COMMON_DIR/info/exclude
  *   - The content of core.excludesfile
  *   - The content (or the lack) of .gitignore of all parent directories
  *     from $GIT_WORK_TREE

base-commit: 59709faab07346122d819453f4ad6f3ccdaf618e
-- 
2.54.0.564.ge3ee0a11b5.dirty

