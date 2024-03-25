Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71A05A7A8
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398901; cv=none; b=kZxDvb6bC0zkxc4fzNui3nxI97SHCJsx6V0ICTXm8Ryo2DLprjdZGU7HNpaeVsvrZ6H/Ypr68ICdwmbMJaf1Ji+kfhURpruLQnUAfpH6/bpZ33+lGXfEz/yN8E8ZDOr8lbwLkhgBCzswmWXEKh9fLYYSJ211JlukRqKrxIeZxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398901; c=relaxed/simple;
	bh=1x8iFP/nALyBGbkKeHOnxJoqZUOyuBPRtx86LIc/LmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EP8DpZVpOsO9UWfkwOovup0/t6z+m/HTE9z471UHa9DGxr3YyJkv0Qv6ZDI/o/c8pLG/shSkpEg7Jc2SJ8kKfthosisTnUnEDpGIJYXAH3K7S2dndCAKtNRKt2HUaIRusPQ+KOBID/QIy0RC7NT0dHHSEYAn4svidUdLHqICR6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=P/BLjf7r; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="P/BLjf7r"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711398896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QD8mcqCZbhqjABUtk4xdp50N6wYeMw20cjxnWMELgVk=;
	b=P/BLjf7rc2MGupRd/QMch/C9gXyk4C9EuVqgTCrIGZRaJ9e7INqTEqDAJqbAH5z+mb9Six
	sxo9nM23qDmUyTKzoeXWxWYLXGhF+UptUd/4s/Pj5bwcoZV+QV0oYUXsfsuQlTYjnn9zd6
	1ULYOKkWc9XRmUZBsKgEmbDqAL36qb+9akX+bCMeTE9XH3mbKYpAn5ZWYvMV4FfcJ4vHOx
	wfOx1tGUGmgahC7ZlwJYVpMQqKp4oSZtSJml6gFj85+hIKi2SnvcwPR0UtI23zC1bcWVVk
	ebDrUWXlbCtnJY2z84Bs38YNvpyKX5LUwUMd6Ty1119F+bmWzJEygc3l2zk0hg==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	sunshine@sunshineco.com,
	jn.avila@free.fr
Subject: [PATCH v3 2/3] grep docs: describe --recurse-submodules further and improve formatting a bit
Date: Mon, 25 Mar 2024 21:34:52 +0100
Message-Id: <cf9d3f4833f121b271fd8aacf4c0e2e4a9920585.1711398665.git.dsimic@manjaro.org>
In-Reply-To: <cover.1711398665.git.dsimic@manjaro.org>
References: <cover.1711398665.git.dsimic@manjaro.org>
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
    Changes in v3:
        - No changes were introduced
    
    Changes in v2:
        - No changes were introduced
    
    This patch is salvaged from my earlier series, [2] for which it has been
    concluded to be not acceptable for merging, because of possible issues
    with various git scripts. [3]
    
    Compared to the version in the earlier series, this version adds some more
    small formatting improvements of the same kind, and also changes a couple
    of "<tree>" placeholders to "_<tree>_", as suggested by Eric Sunshine. [1]
    
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
