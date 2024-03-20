Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7B85940
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968936; cv=none; b=urEbZ5oq0UPeojftbHm7bwGn5FgFMi4KK66y84MI5ZSjqZnYw5MMDJRN9a/rqJH/TQm64Dv8RZIphffN9+W/b/viTkOApbdpxhSeSR0BICl1eCgiHl3B8+koSxwcs29cHKWyDT7SxNvyPdRIi3rlnpABAIvT4T/xJbsj/JQ6FmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968936; c=relaxed/simple;
	bh=W7QeZYqzKxvmUUBmbmlc5JVn/em2NE3kxjWs2HhcTxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NtwIXOk/mU3oxHDO93iR9hIBz2N56CJ7uQGgPX6a7+b3dOMEbBxnhpmw5PJx6hTyQREat5VAeG2TrWuDhfbXbVTMJIxZe5Dx2Hqk4qXkOt8Xeo60HU6ZOQ8UW6AT6VJcq+82sIPGd0EzrHA+gv7rG2cimo7+IpiHXruSY1sOaJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Ex/Y1egc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Ex/Y1egc"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710968932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIHh8AthG203xFHWbY048Bd+qHEXpIlHXNytFTWOd2c=;
	b=Ex/Y1egcSfLnCG5QZhLQtHl5HtzAo74wcUpl1fr/sIQFMrEFcv6yMEQBmVUYhSNfazbdyL
	RjYmjj8E53PczQ36nPdZw2YFNZJ2a8qJ65fUcAGdVoO7pEzZASB7nBRx9tL7LFrZ7bn638
	BYqmlcALo55/lfNNABcDF9qbi9dmUOCvvQUxt+WDhVzFSD6SUFJM12DXIJ5AvWYmMUwEGc
	kNz67u2SKY31F/MUmii7ynKdNR+ox4Vfba3V17mng6Cf7NQ8WgAz7QXKRU2ETirthhTUU+
	1jTmGwFnOn2Hd3OOEWFKYK7+P3WKJ9yZYqW0/lCLCbWuEpQrBZthLYRA/V95Fw==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com
Subject: [PATCH 2/3] grep docs: describe --recurse-submodules further and improve formatting a bit
Date: Wed, 20 Mar 2024 22:08:45 +0100
Message-Id: <eebe88d753b5e56126e26a5f69cbe3c1b1db1483.1710968761.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710968761.git.dsimic@manjaro.org>
References: <cover.1710968761.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Clarify that --recurse-submodules cannot be used together with --untracked,
and improve the formatting in a couple of places, to make it visually clear
that those are the commands or the names of configuration options.

While there, change a couple of "<tree>" placeholders to "_<tree>_", to help
with an ongoing translation improvement effort. [1]

[1] https://lore.kernel.org/git/CAPig+cQc8W4JOpB+TMP=czketU1U7wcY_x9bsP5T=3-XjGLhRQ@mail.gmail.com/

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    This patch is salvaged from my earlier series, [2] for which it has been
    concluded to be not acceptable for merging, because of possible issues
    with various git scripts. [3]
    
    Compared to the previous version, this version adds some more small
    formatting improvements of the same kind, and also changes a couple of
    "<tree>" placeholders to "_<tree>_", as suggested by Eric Sunshine. [1]
    
    [2] https://lore.kernel.org/git/cover.1710781235.git.dsimic@manjaro.org/T/#u
    [3] https://lore.kernel.org/git/d8475579f014a90b27efaf6207bc6fb0@manjaro.org/

 Documentation/config/grep.txt |  2 +-
 Documentation/git-grep.txt    | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index e521f20390ce..10041f27b0c8 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -24,5 +24,5 @@ grep.fullName::
 	If set to true, enable `--full-name` option by default.
 
 grep.fallbackToNoIndex::
-	If set to true, fall back to git grep --no-index if git grep
+	If set to true, fall back to `git grep --no-index` if `git grep`
 	is executed outside of a git repository.  Defaults to false.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 0d0103c780af..f64f40e9775a 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -64,9 +64,9 @@ OPTIONS
 --recurse-submodules::
 	Recursively search in each submodule that is active and
 	checked out in the repository.  When used in combination with the
-	<tree> option the prefix of all submodule output will be the name of
-	the parent project's <tree> object. This option has no effect
-	if `--no-index` is given.
+	_<tree>_ option the prefix of all submodule output will be the name of
+	the parent project's _<tree>_ object.  This option cannot be used together
+	with `--untracked`, and it has no effect if `--no-index` is specified.
 
 -a::
 --text::
@@ -178,7 +178,7 @@ providing this option will cause it to die.
 	Use \0 as the delimiter for pathnames in the output, and print
 	them verbatim. Without this option, pathnames with "unusual"
 	characters are quoted as explained for the configuration
-	variable core.quotePath (see linkgit:git-config[1]).
+	variable `core.quotePath` (see linkgit:git-config[1]).
 
 -o::
 --only-matching::
@@ -332,7 +332,7 @@ EXAMPLES
 NOTES ON THREADS
 ----------------
 
-The `--threads` option (and the grep.threads configuration) will be ignored when
+The `--threads` option (and the `grep.threads` configuration) will be ignored when
 `--open-files-in-pager` is used, forcing a single-threaded execution.
 
 When grepping the object store (with `--cached` or giving tree objects), running
