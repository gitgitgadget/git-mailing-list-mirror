Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F01E98FB
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460462; cv=none; b=E6IrTujoElgmdrDpMIoCaw1kNPde0WNvZLjrC2XqgcQTq7Bpi+HjGtmOxRgW7JC0FMRb1b7C2fUEKOQRlG3qhikEijGLuTy5s+0IVkoR9ViDbX2hDJsXflXxzlzENS3tBcQ/Wk1DwDHF+G7n0gaRsBPisVVSKHXeptReJEDdN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460462; c=relaxed/simple;
	bh=LXAE70IImfTUK5YaBYvBwBQ+S+xRE7elUo7kf6bf/Vo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=rz3WmRV/YadMPAvAtut3t7LVbX0R0h+hYUaDY7TUcbjvsK8k/69FDj1rFb2PfAH/zUjFxOs7Wj1DZ3zNbH+FNKZFEQCGtLFU/oRb3IH+H31ki7cwfDUnyImrAmTNZWwU6PAsXNziD9qBIDAqo1rEqY7SNSdBrm1IS8/H/1ogc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUZQ0sZQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUZQ0sZQ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c1efc457bso1817195f8f.2
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 05:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744460458; x=1745065258; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFeOG/FeXWczRRyvqTSuTljoyMmqPhblRAyeE850ubI=;
        b=QUZQ0sZQ+AtGfmSLm8VS75060Cmbc8/zBQcyFrEppBEnI48rCP2g5h0hGGcat42t6I
         D1ulyE8pUUVbBMUr2nGOGSf7/J1A6hszj7eKiFCz2Oo3fxTVk9JU4mZuDHPdirWr0bl7
         T+bc0hh9rQ+mhJDWFcmaXSF15YBBnLOdLOhv918QFP0jhwyhj2r7z4AAkusBgc6kwjxT
         mW32Dc6SYOhp21JnyX9aOd7aLlt4clJhQOIwHFHLTG7j6Nsuwd5hsP9Fx9zLAhkf5Zie
         ctpQzuJUjqScOd31RtULsfuqxlBc3Af6JrBo0MnI+1XfSC3suoeuD2UMFPyN58CyYA1h
         mbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460458; x=1745065258;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFeOG/FeXWczRRyvqTSuTljoyMmqPhblRAyeE850ubI=;
        b=BbY48LcQMAdi1eB0+9ngEPe1a5Dzeck2UchFk/4wyu9F58WoSoZjDbC2paezcph5rz
         +idCRBiWofuyE80+iiwYqCYX0INep/Xi5CFjMxgEIK0FHsLgeSqco/mChM+DxjZssw1y
         8QntcVqa2IpcE0kSe+uxtHhB4m8RjfTCLNUMs5nVBaTvV1BCeBnnyY4jpW9mbDLJMRLX
         ctFGXOW1oi4GtcZjsa5nnb206Wo3IUtKuPw6v3EfFW6tnzmQJ0KE5gNJx+Js6H1HVf5U
         Nb+4YQ6hWnAmmtMqNaKbhLQAVpsYq8gxIKlx8m1BRMxDptkx6cd+PpUc1zoI4pn+hA7u
         jFNw==
X-Gm-Message-State: AOJu0Yw+0WE1tStxTPwH4/g3eyFV0Wkhh0WcDmes557IKZbZxX4mnXZg
	8vhjBo57Mk8Gzp6yelkeGXl5qX421Uk+t+Dd9KbIl4rW2hKtGM49WKltbQ==
X-Gm-Gg: ASbGncudYh90ZPq+Cthde4r0bQg8k5bB0JdTx5YpEq6JWYrbdGy/OeXzQ0H0p4VjPPh
	LwKy0e69OUmdvm43OoH37lr03F7Bdy0yTVhgTCVoc5bEnIBNXIqpfEJxtE0a0l/7KjwiT/d6XBY
	4JokcJ31uhwHpiyzW6jeR+prRagA+OPcojrGvSSSn7TfbgdGibNSPvpNwfm82wx7VmY0LTddBAN
	/zlDujNHJkLH4dnZva8QctHGw03vmPGvYC+c4K+zBu5aQ9isN5kmsQNVy0BX5IutRe6boQUdcc5
	lauWhyVOf+Fwl/XTY0ep6NysgaIIP522Fcn6cEslcg==
X-Google-Smtp-Source: AGHT+IEll42sSYm9e2bXCCuvzDvgn3tvna/asa0MgM74jGfFdi2VnEnsjS83E9YapOTv030MIfCdIQ==
X-Received: by 2002:a5d:5f92:0:b0:39c:266c:d82 with SMTP id ffacd0b85a97d-39ea51ec9cbmr5467924f8f.10.1744460458080;
        Sat, 12 Apr 2025 05:20:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9640fdsm4906353f8f.7.2025.04.12.05.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:20:57 -0700 (PDT)
Message-Id: <1868dfc3282636ba20feacd5ebfc5107869b26e2.1744460450.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
	<pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Apr 2025 12:20:48 +0000
Subject: [PATCH v2 5/7] doc: convert git-mv to new documentation format
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
Cc: Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Unfortunately, there's an inconsistency in the synopsis style, where
the ellipsis is used to indicate that the option can be repeated, but
it can also be used in Git's three-dot notation to indicate a range of
commits. The rendering engine will not be able to distinguish
between these two cases.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-mv.adoc | 31 ++++++++++++++++---------------
 builtin/mv.c              |  2 +-
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-mv.adoc b/Documentation/git-mv.adoc
index 08d660643fc..f707e998f77 100644
--- a/Documentation/git-mv.adoc
+++ b/Documentation/git-mv.adoc
@@ -8,17 +8,18 @@ git-mv - Move or rename a file, a directory, or a symlink
 
 SYNOPSIS
 --------
-[verse]
-'git mv' [-v] [-f] [-n] [-k] <source> <destination>
-'git mv' [-v] [-f] [-n] [-k] <source> ... <destination-directory>
+
+[synopsis]
+git mv [-v] [-f] [-n] [-k] <source> <destination>
+git mv [-v] [-f] [-n] [-k] <source>... <destination-directory>
 
 DESCRIPTION
 -----------
 Move or rename a file, directory, or symlink.
 
-In the first form, it renames <source>, which must exist and be either
-a file, symlink or directory, to <destination>.
-In the second form, the last argument has to be an existing
+In the first form, it renames _<source>_, which must exist and be either
+a file, symlink or directory, to _<destination>_.
+In the second form, _<destination-directory>_ has to be an existing
 directory; the given sources will be moved into this directory.
 
 The index is updated after successful completion, but the change must still be
@@ -26,20 +27,20 @@ committed.
 
 OPTIONS
 -------
--f::
---force::
+`-f`::
+`--force`::
 	Force renaming or moving of a file even if the <destination> exists.
--k::
+`-k`::
 	Skip move or rename actions which would lead to an error
 	condition. An error happens when a source is neither existing nor
 	controlled by Git, or when it would overwrite an existing
 	file unless `-f` is given.
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Do nothing; only show what would happen
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Report the names of files as they are moved.
 
 SUBMODULES
@@ -47,8 +48,8 @@ SUBMODULES
 Moving a submodule using a gitfile (which means they were cloned
 with a Git version 1.7.8 or newer) will update the gitfile and
 core.worktree setting to make the submodule work in the new location.
-It also will attempt to update the submodule.<name>.path setting in
-the linkgit:gitmodules[5] file and stage that file (unless -n is used).
+It also will attempt to update the `submodule.<name>.path` setting in
+the linkgit:gitmodules[5] file and stage that file (unless `-n` is used).
 
 BUGS
 ----
diff --git a/builtin/mv.c b/builtin/mv.c
index 9e36b616ab6..d673a6c83ef 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -29,7 +29,7 @@
 
 static const char * const builtin_mv_usage[] = {
 	N_("git mv [-v] [-f] [-n] [-k] <source> <destination>"),
-	N_("git mv [-v] [-f] [-n] [-k] <source> ... <destination-directory>"),
+	N_("git mv [-v] [-f] [-n] [-k] <source>... <destination-directory>"),
 	NULL
 };
 
-- 
gitgitgadget

