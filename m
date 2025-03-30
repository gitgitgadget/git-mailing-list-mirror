Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE01DB34B
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743354972; cv=none; b=lNmUbYuxDb47BUjQX5TTPkc6yZcjcv/ukuZ7YeM8qgIkVw4t9dBG2H0wDU3t/XrOsHFG3L12R6OVhiELvfR7rVb3pG8P8lUUQdyKw+2O21ViqEkwWk5vGcLTfzNSF3e0k+9hxNstcoLPSLRj+aN2CSnHaDFYmjGjvr6cef6Mrkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743354972; c=relaxed/simple;
	bh=kgd3FnPKqcGOVrBfmitKmUn72IOTMS3iAB0VCZuwJ34=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=DFDsac1gs76W2rn9a0v7CPBNRHNW+/lbWc/syCFhJeHcy3KpuhVR3DeBsbqfL80Z5HQLCRt9C0+3Nr7Pc1utDLXyIwhx8aXNWeturWKQLlG9ooM/h77MraRlVz3z42QTjXhdAD/DKckDIJlUxZlYlZsiH/CV1LiyCYeMu2Jg41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez44kjsm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez44kjsm"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43948021a45so37534865e9.1
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743354969; x=1743959769; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fScNan+Ond41LaX1EqUvHLJhdrFe2S3eahrTPKEZEUs=;
        b=Ez44kjsmFyWqK840KLtC9OT5+1G1yaqn2RJnwkhfxV+uxwlojacn/DLsn8dflI3773
         TnB3qnzeXHk52zfLgIc7Yp7zJBB0d/dIK3pBx6vxg6eb51H/xAFBXEagxmxPjyOtrJ7X
         CbLwP4Y+BCZyOri0T/OXv7JSwOwyIux92xka5Koe1rlNi8Fe87JaEAQ0sORbKNWDZWNT
         aGJFfkmkTX3QhzU7tQNUiXfIOxMd2HIGkTmmBY2z0xlcBQLxwqM/ARI6endF8yz6KvXs
         ecZ0XvcBxdH2CsoiLdLXPAf8CilXZR63coUmKzuCfP/yEM1z9DDEu7sIONRFQmZTJMfX
         Nh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743354969; x=1743959769;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fScNan+Ond41LaX1EqUvHLJhdrFe2S3eahrTPKEZEUs=;
        b=YkgLo8tooeOHN66K8YPDmzBfsVuj3SHTfp+S/KQD8ma28M58YbGGgR60yshTOef+xF
         8SUd9ft/yQ1WISFxJ8pvihuVWGSW32Pt7xz1elexN7tSitIf4jYhRI9FgVBROJRM4Rjw
         qitPcwoEe8Kgh/hoF29PynTo3I7TFPpeKwwjmgxvdwFVOKqGkQsdv2f9WvkIv4aLveL1
         bCL9W42GS7ThEg9Ry53ldfpFMzTRQ8y26vL8hwFvE5jrlxjz1Q40tooYEzSKW1l9PGe8
         bLrqz47m/TEOB5tHHdGVVcpHSPIg2HZ21SbhKFrn2PDbufQJs4/7VtdXufSILjZov8BK
         KRdg==
X-Gm-Message-State: AOJu0Yxu5Ng9CxzD8cdIkars0e5EJm3THQZ/5WoeNKWqJfoUSWI9NIrd
	RRwweh54vrlzrcKNAvExj/7wu95CyM1gm/qmTkfE6LF+vKGp3Hx7v7Y8zw==
X-Gm-Gg: ASbGncuEgerI75l8SRm0njDx3L+dq6wMKdAs0xbuSzbfdj2xdHhrJlVfkUUeDkBpISE
	BuZuIkSX9FZ0U5gIe7UwYlEUvvZMOH7sJg6Ltwlrs87RlsTf9oG0H7ElDVyhde2dMriBjGy/pRF
	t5+L8cN4FMVG5vPrsTGYJqcXEbvs4Em2t/wZlUMSl0Bf0vHjypzqqv6o+yNRTG3dR/6MPlfyRFy
	kILu2Llqgmebp4Q6IVWY19ac+tMgC5TApTK1sIhRzqOIhV3EZLUTFnjZ+MiOIPNnR9lxVjxkKfW
	fVJVmmqreHLzMMWECCc9NT6nY7nDmB1EhMwradOKoJaqOw==
X-Google-Smtp-Source: AGHT+IEqNVjed+LZrd2h1DohpDqNQJV3P+TGlYyCPequPFcdHGG80n2aScXb99Hkw9BeweHgyrhbvw==
X-Received: by 2002:a5d:6daf:0:b0:391:4914:3c6a with SMTP id ffacd0b85a97d-39c120e34b1mr3737975f8f.29.1743354968916;
        Sun, 30 Mar 2025 10:16:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d900013afsm96962215e9.36.2025.03.30.10.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 10:16:08 -0700 (PDT)
Message-Id: <41a01969d9394ba4997e729d58c5b566bab315b7.1743354964.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 30 Mar 2025 17:16:02 +0000
Subject: [PATCH 3/5] doc: convert git-rm to new documentation format
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-rm.adoc | 56 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-rm.adoc b/Documentation/git-rm.adoc
index 363a26934f5..b5ead867963 100644
--- a/Documentation/git-rm.adoc
+++ b/Documentation/git-rm.adoc
@@ -7,10 +7,10 @@ git-rm - Remove files from the working tree and from the index
 
 SYNOPSIS
 --------
-[verse]
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch]
-	  [--quiet] [--pathspec-from-file=<file> [--pathspec-file-nul]]
-	  [--] [<pathspec>...]
+[synopsis]
+git rm [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch]
+       [--quiet] [--pathspec-from-file=<file> [--pathspec-file-nul]]
+       [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -30,7 +30,7 @@ sparse-checkouts are in use (see linkgit:git-sparse-checkout[1]),
 
 OPTIONS
 -------
-<pathspec>...::
+`<pathspec>...`::
 	Files to remove.  A leading directory name (e.g. `dir` to remove
 	`dir/file1` and `dir/file2`) can be given to remove all files in
 	the directory, and recursively all sub-directories, but this
@@ -43,57 +43,57 @@ directories `d` and `d2`, there is a difference between using
 `git rm 'd*'` and `git rm 'd/*'`, as the former will also remove all
 of directory `d2`.
 +
-For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
+For more details, see the _<pathspec>_ entry in linkgit:gitglossary[7].
 
--f::
---force::
+`-f`::
+`--force`::
 	Override the up-to-date check.
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Don't actually remove any file(s).  Instead, just show
 	if they exist in the index and would otherwise be removed
 	by the command.
 
--r::
+`-r`::
         Allow recursive removal when a leading directory name is
         given.
 
-\--::
+`--`::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
 	for command-line options).
 
---cached::
+`--cached`::
 	Use this option to unstage and remove paths only from the index.
 	Working tree files, whether modified or not, will be
 	left alone.
 
---ignore-unmatch::
+`--ignore-unmatch`::
 	Exit with a zero status even if no files matched.
 
---sparse::
+`--sparse`::
 	Allow updating index entries outside of the sparse-checkout cone.
 	Normally, `git rm` refuses to update index entries whose paths do
 	not fit within the sparse-checkout cone. See
 	linkgit:git-sparse-checkout[1] for more.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	`git rm` normally outputs one line (in the form of an `rm` command)
 	for each file removed. This option suppresses that output.
 
---pathspec-from-file=<file>::
-	Pathspec is passed in `<file>` instead of commandline args. If
-	`<file>` is exactly `-` then standard input is used. Pathspec
-	elements are separated by LF or CR/LF. Pathspec elements can be
+`--pathspec-from-file=<file>`::
+	Pathspec is passed in _<file>_ instead of  args. If
+	_<file>_ is exactly `-` then standard input is used. Pathspec
+	elements are separated by _LF_ or _CR_/_LF_. Pathspec elements can be
 	quoted as explained for the configuration variable `core.quotePath`
 	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
 	global `--literal-pathspecs`.
 
---pathspec-file-nul::
+`--pathspec-file-nul`::
 	Only meaningful with `--pathspec-from-file`. Pathspec elements are
-	separated with NUL character and all other characters are taken
+	separated with _NUL_ character and all other characters are taken
 	literally (including newlines and quotes).
 
 
@@ -153,15 +153,15 @@ SUBMODULES
 ----------
 Only submodules using a gitfile (which means they were cloned
 with a Git version 1.7.8 or newer) will be removed from the work
-tree, as their repository lives inside the .git directory of the
+tree, as their repository lives inside the `.git` directory of the
 superproject. If a submodule (or one of those nested inside it)
-still uses a .git directory, `git rm` will move the submodules
+still uses a `.git` directory, `git rm` moves the submodules
 git directory into the superprojects git directory to protect
-the submodule's history. If it exists the submodule.<name> section
+the submodule's history. If it exists the `submodule.<name>` section
 in the linkgit:gitmodules[5] file will also be removed and that file
-will be staged (unless --cached or -n are used).
+will be staged (unless `--cached` or `-n` are used).
 
-A submodule is considered up to date when the HEAD is the same as
+A submodule is considered up to date when the `HEAD` is the same as
 recorded in the index, no tracked files are modified and no untracked
 files that aren't ignored are present in the submodule's work tree.
 Ignored files are deemed expendable and won't stop a submodule's work
-- 
gitgitgadget

