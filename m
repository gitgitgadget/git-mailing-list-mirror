Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66819308C
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731785778; cv=none; b=DmNqeehH9kWswpSCbgqa98zJjo5+LIn6BS2RQmlziS62Gvnj8VP7nkS3WXC09pdV12f9+WEPAoURtxzSDkZQJw85XS9tkg3Bx4y0U/WI2ul6RvYF3hSvz7viYDOsQQ344YWhyTbSbxOMUCeMSo9FiE8xmuqBd20mNlYvJdPjMCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731785778; c=relaxed/simple;
	bh=pG6TIZ6xgd+s1fIdq8rfLkuWWrAPW2H9w5TlT5+aHZs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=eqT8DsYvofXEQTpXpdlW2LLjnDm6m4JCBtfeQIoju5cYBguvkVluaTWGX5HlFchthPu41+KPPOT/182Oje4l5RPSoHn8mrwr/IMyZO1dp63Ozwqe2cg7uU5u048N1oXNBkh5UQVKFDgRSVBcc8U/wLatPuLmri0rpXwHh+U+E9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QazmgDEX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QazmgDEX"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so1898098f8f.1
        for <git@vger.kernel.org>; Sat, 16 Nov 2024 11:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731785774; x=1732390574; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGYn9kokVEziW7GMIR8t/uCLNBW/YLPTAxPVqIWcoe8=;
        b=QazmgDEXda1WBbQZjWhC8d2kQEceeldrlL8N8jfgQYPVjbnVDSCzWdvZvBPOxPQ3Fd
         6hXD8kxZ23N1tzVliDLMgw4CTVGqbWdy7J+2rCjf44uBH+2kuKEYEQzBqz57JEZLJ/Ur
         M2ygjz4o4hQcFt7unU74EyIuxOK3uSmKyiMwOoNsjZ7yJ53q3AlJ+pdhLTTOrrRcGBJ0
         2U/cmCsT+QgYHQ3OjiKhnS9I/rSwheeCaFshaPEo/AL4sRD9r68AvYaqNRWs658gY10B
         ITrZMuxTJrEVPwUgCpAPbCtbtc20Fu8n8uuhqK//begpFnKN4lHDQ/5jBsrtmOWySITP
         5Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731785774; x=1732390574;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGYn9kokVEziW7GMIR8t/uCLNBW/YLPTAxPVqIWcoe8=;
        b=Jt2Dgg5miWMHwrj6a3HY0HYZ4LeQaEQ8ctHvDBhdKoIXJJplsjpMyvbQrxAtCw9wIN
         pt3B8Hk2QzQILxRh7CSqoEpK8PyBaS70dcH5RlgDTicfWgSnhkv3ydWvlpqu/jAlohOX
         Y2IoMQcTCRoxpZjpNBguuU15mnvob2rsFPf0fVNykR6LOseV2qc81DApUcsLfU1ueYYZ
         jtQiHm4Qb1isBDaQ08OEErwB19Ry0f2AmQ3rQoudBrVPnV07Tuo6TEdFa5BTy6ZIuYC/
         eaRjYhuM6xmHXf52CrIhOEMqNw2QcyFl7Frqm0d1pa+Zqb8ZiiSrWqjSajGsVLhv5zSM
         eGfQ==
X-Gm-Message-State: AOJu0Yzv/X2k4bCp+W3qdM51+3LIbLVGdUOMVCCbyVXjWqUn3zocQS+d
	0zr2lT3s77EwbnawMrNAF3HWvqSEoLHFGPEzP4M5D88ToBerNTeUJIWQrg==
X-Google-Smtp-Source: AGHT+IF7X2AYKSwj2ueYD/uzJn2zObwO6bZsWpMFhcjcdh165C8KIc783SuaW8eVIyWSa7FiLYd34A==
X-Received: by 2002:a5d:59af:0:b0:382:3efc:c6d8 with SMTP id ffacd0b85a97d-3823efcc7e9mr517154f8f.12.1731785773665;
        Sat, 16 Nov 2024 11:36:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adad619sm7909470f8f.27.2024.11.16.11.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 11:36:13 -0800 (PST)
Message-Id: <698628e076bcbba2e0c5ec2758c2a31adf9c91b8.1731785769.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
References: <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
	<pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Nov 2024 19:36:06 +0000
Subject: [PATCH v3 3/5] doc: git-diff: apply format changes to diff-format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/diff-format.txt | 42 +++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index a3ae8747a22..c72fb379867 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -1,25 +1,25 @@
 Raw output format
 -----------------
 
-The raw output format from "git-diff-index", "git-diff-tree",
-"git-diff-files" and "git diff --raw" are very similar.
+The raw output format from `git-diff-index`, `git-diff-tree`,
+`git-diff-files` and `git diff --raw` are very similar.
 
 These commands all compare two sets of things; what is
 compared differs:
 
-git-diff-index <tree-ish>::
-        compares the <tree-ish> and the files on the filesystem.
+`git-diff-index <tree-ish>`::
+	compares the _<tree-ish>_ and the files on the filesystem.
 
-git-diff-index --cached <tree-ish>::
-        compares the <tree-ish> and the index.
+`git-diff-index --cached <tree-ish>`::
+	compares the _<tree-ish>_ and the index.
 
-git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]::
+`git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]`::
         compares the trees named by the two arguments.
 
-git-diff-files [<pattern>...]::
+`git-diff-files [<pattern>...]`::
         compares the index and the files on the filesystem.
 
-The "git-diff-tree" command begins its output by printing the hash of
+The `git-diff-tree` command begins its output by printing the hash of
 what is being compared. After that, all the commands print one output
 line per changed file.
 
@@ -54,19 +54,19 @@ That is, from the left to the right:
 
 Possible status letters are:
 
-- A: addition of a file
-- C: copy of a file into a new one
-- D: deletion of a file
-- M: modification of the contents or mode of a file
-- R: renaming of a file
-- T: change in the type of the file (regular file, symbolic link or submodule)
-- U: file is unmerged (you must complete the merge before it can
+- `A`: addition of a file
+- `C`: copy of a file into a new one
+- `D`: deletion of a file
+- `M`: modification of the contents or mode of a file
+- `R`: renaming of a file
+- `T`: change in the type of the file (regular file, symbolic link or submodule)
+- `U`: file is unmerged (you must complete the merge before it can
   be committed)
-- X: "unknown" change type (most probably a bug, please report it)
+- `X`: "unknown" change type (most probably a bug, please report it)
 
-Status letters C and R are always followed by a score (denoting the
+Status letters `C` and `R` are always followed by a score (denoting the
 percentage of similarity between the source and target of the move or
-copy).  Status letter M may be followed by a score (denoting the
+copy).  Status letter `M` may be followed by a score (denoting the
 percentage of dissimilarity) for file rewrites.
 
 The sha1 for "dst" is shown as all 0's if a file on the filesystem
@@ -86,7 +86,7 @@ verbatim and the line is terminated by a NUL byte.
 diff format for merges
 ----------------------
 
-"git-diff-tree", "git-diff-files" and "git-diff --raw"
+`git-diff-tree`, `git-diff-files` and `git-diff --raw`
 can take `-c` or `--cc` option
 to generate diff output also for merge commits.  The output differs
 from the format described above in the following way:
@@ -128,7 +128,7 @@ other diff formats
 ------------------
 
 The `--summary` option describes newly added, deleted, renamed and
-copied files.  The `--stat` option adds diffstat(1) graph to the
+copied files.  The `--stat` option adds `diffstat`(1) graph to the
 output.  These options can be combined with other options, such as
 `-p`, and are meant for human consumption.
 
-- 
gitgitgadget

