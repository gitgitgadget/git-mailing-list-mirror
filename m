Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7F133A033
	for <git@vger.kernel.org>; Wed, 20 May 2026 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280315; cv=none; b=m3eU3f8PtgCS03MC3MlvdYBvL9it/TSxMtnGo+PVS9lfaJ11qUgMt2dIU5wYdA3SuTquWyo50pwM7Zxjm0MFixq/NgSx1qKQU1DDpHUXYbmI7VkB4yNnJlowWBAFsKfd6LkB4CBgwhZE7qFxADU2iAmgHV/oQCjY0rFpx0zmv6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280315; c=relaxed/simple;
	bh=m2fKZWIUyDuZ29tcFgnexWVkoA34Qn1PX6kbFghnFF0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U/29OWk7frBsinYHl91h3bpAlbjKX2Yi4z1u2S7xK5JIBTaWaOiUP7iEYZ8opJGfOuISjbZgyDDGnidgLH3W7PjBXhRXQ+FKXqQK+PQlyqdbg/VD+nV7COQ8QuQP4hq2d8K9VvCW9ZlCocWy3ypDMFUzW4pcF/7QMT/mP6FTPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFPP5oW8; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFPP5oW8"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1332772f6b3so6031462c88.1
        for <git@vger.kernel.org>; Wed, 20 May 2026 05:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779280312; x=1779885112; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ1UEAJZaoYfyq1r7yuAzu/kVupEM1L6QYURMbbLubM=;
        b=ZFPP5oW8lCfZ/7Ng9iXexVWdkg2MJqMIngBhvaIsBoSSOQw1hGsY9ZrLWZzVDixN9i
         eeM4rK7DOKgDu3gUNFWQFnBBvm4yRoxDb3HzSuULA+8UxWN1P3jdzpfQR11/5NM+qqS0
         whwJ+aWJroEz7agGM/whneSgajFQRGwHjWYxcD+6wyRrQ5eunD37vT12MfP06E27nXXQ
         ZIuSp9W4RwekIu8GrH+h59IkBo88I3tSbZCwlyNs+4ZMHuYgJB+zrzCfNIY0vwgiacZ2
         4+vwv5BziXxT9bRuKv93GdtUbsmGeBVgUP3liyjWkHConxZxSCRbZaomXYrG7Zzc+EZS
         gacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779280312; x=1779885112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZ1UEAJZaoYfyq1r7yuAzu/kVupEM1L6QYURMbbLubM=;
        b=js2Jf+pt1N4ixvleF5rM7szc1/9n5yP4IESGJlc/kYFh3FVisz0H7/pW5DW6IbFGNH
         SXMXrhJN0t4naytRwl8SYCV82bvXOganwxXfngtwlkBwt9FN3ymHL6dYCDPIDMgem/CS
         tQFwNt/k/qtPja6rrGO03kXckSHeseqakao9rUIVaz2vJMWJLc/9JPxwQ5cYWfIj3Sz0
         uHGLlApW1v8dugxwaF8RAty2nuQwwpahgAJSLmH2rxJ1QwFfStfgMXkmmyn/8U5/yPBI
         ji+pR+U5eACrIR8S3DbQuvCc4jyR25nxpdsL0ylMILuTAle7lzMvSI6QhRSyR9eUc0CI
         /ujA==
X-Gm-Message-State: AOJu0YxMmBU6bXBXYvXoz6WRmVsd2K3Y/W6GJSzo3xpPl8yaVtbGRd65
	DvU9u2eiJhSfCxa4LiPoB7hvdYJ+4GV1bTtkMvTGez3fS/XqTM4/fNM2etMr7g==
X-Gm-Gg: Acq92OGdF0awKfoW9p1w5Fw8XIuGd0h3HqTfZejccGJ5WTfTH9KPmW6QThY0gVURqVK
	PT9R8t6v+uttr7YERJG64t9TiBozkZGXPsa4WPV3cBx0vSsNJ8Qqq8OUYm5/RtQ98lNNY3Bf4j2
	1CQLQyR6dXn778TeZjbjZwr+VJUg12x3vb0/wFs6ZnP7DNxj96m+vALiAAYe6cU5z932k5ymtq1
	o88YB3N9MAFl2tsYM5Ym8pUZp0aCqt+0XMbsxgMqm3IhsdbIQo0FjxQxxgTLm+7PAc0fnyg0BuP
	ntC5dYy6Eh9evN0xb2K2R+RNFzjLFSsMHyqqBZchYtcqrPCyeHasrTnoLULcz0pCR5uikS9jm3e
	vJl9a1MFyK5VSLiD1UXQ8oqxwAfD++EY7KCcf3nOBgopj8v8DCnn8RHFrDZJDiiPLWtb6srCNnl
	vRJASbv+sg3v0Q0m/ml+OO7X1BGA==
X-Received: by 2002:a05:7022:2523:b0:12a:6c4b:9d01 with SMTP id a92af1059eb24-1350430f349mr9110993c88.7.1779280311364;
        Wed, 20 May 2026 05:31:51 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.58.147])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed2232sm27231972c88.7.2026.05.20.05.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:31:48 -0700 (PDT)
Message-Id: <pull.2108.v2.git.1779280307112.gitgitgadget@gmail.com>
In-Reply-To: <pull.2108.git.1778231254871.gitgitgadget@gmail.com>
References: <pull.2108.git.1778231254871.gitgitgadget@gmail.com>
From: "Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 20 May 2026 12:31:46 +0000
Subject: [PATCH v2] git-jump: pick a mode automatically when invoked without
 arguments
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
Cc: Jeff King <peff@peff.net>,
    Greg Hurrell <greg@hurrell.net>,
    Erik Cervin Edin <erik@cervined.in>,
    Greg Hurrell <greg.hurrell@datadoghq.com>,
    Greg Hurrell <greg.hurrell@datadoghq.com>

From: Greg Hurrell <greg.hurrell@datadoghq.com>

When `git jump` is invoked with no positional arguments (and no
arguments after `--stdout`) it currently prints usage and exits with
status 1.

But there are several situations where we can usefully infer the most
valuable and likely mode that a user would want to use, and select it
automatically:

1. When there are unmerged paths in the index, the user likely
   wants `git jump merge`.

2. When the working tree has unstaged changes, the user likely
   wants `git jump diff`.

3. In the presence of conflict markers or whitespace errors (as reported
   by `git diff --check`), the user likely wants `git jump ws`.

In this commit we teach `git jump` a new "auto" mode which detects these
cases and dispatches to the corresponding mode automatically. The user
can either explicitly spell out `git jump auto`, or just leave it at
`git jump` (because "auto" is the default).

If none of the interesting cases listed above applies, then auto mode
falls back to the existing usage-and-exit behavior.

Signed-off-by: Greg Hurrell <greg.hurrell@datadoghq.com>
---
    git-jump: pick a mode automatically when invoked without arguments
    
    Changes since v0:
    
     * Added explicit "auto" keyword/mode.
     * Updated additional detail to usage info and README.
     * (Bonus) Added ws usage example to README.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2108%2Fwincent%2Fauto-jump-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2108/wincent/auto-jump-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2108

Range-diff vs v1:

 1:  87fa66d233 ! 1:  5fbc8480ef git-jump: pick a mode automatically when invoked without arguments
     @@ Commit message
          arguments after `--stdout`) it currently prints usage and exits with
          status 1.
      
     -    But there are two situations where we can usefully infer the most
     +    But there are several situations where we can usefully infer the most
          valuable and likely mode that a user would want to use, and select it
     -    automatically when they run `git jump` without arguments:
     +    automatically:
      
          1. When there are unmerged paths in the index, the user likely
             wants `git jump merge`.
     @@ Commit message
          2. When the working tree has unstaged changes, the user likely
             wants `git jump diff`.
      
     -    Detect these two cases and dispatch to the corresponding mode
     -    automatically, falling back to the existing usage-and-exit behavior
     -    when neither holds.
     +    3. In the presence of conflict markers or whitespace errors (as reported
     +       by `git diff --check`), the user likely wants `git jump ws`.
     +
     +    In this commit we teach `git jump` a new "auto" mode which detects these
     +    cases and dispatches to the corresponding mode automatically. The user
     +    can either explicitly spell out `git jump auto`, or just leave it at
     +    `git jump` (because "auto" is the default).
     +
     +    If none of the interesting cases listed above applies, then auto mode
     +    falls back to the existing usage-and-exit behavior.
      
          Signed-off-by: Greg Hurrell <greg.hurrell@datadoghq.com>
      
       ## contrib/git-jump/README ##
     -@@ contrib/git-jump/README: To use it, just drop git-jump in your PATH, and then invoke it like
     - this:
     +@@ contrib/git-jump/README: git jump grep foo_bar
     + # arbitrary grep options
     + git jump grep -i foo_bar
       
     - --------------------------------------------------
     ++# jump to places with conflict markers or whitespace errors
     ++# (as reported by # `git diff --check`)
     ++git jump ws
     ++
     + # use the silver searcher for git jump grep
     + git config jump.grepCmd "ag --column"
     ++
      +# pick a mode automatically: "merge" if there are unmerged paths,
     -+# "diff" if the worktree has unstaged changes, otherwise show usage
     -+git jump
     ++# "diff" if the worktree has unstaged changes, "ws" if there are
     ++# whitespace problems; otherwise show usage
     ++git jump auto
      +
     - # jump to changes not yet staged for commit
     - git jump diff
     ++# with no explicit mode, same as "auto"
     ++git jump
     + --------------------------------------------------
       
     + You can use the optional argument '--stdout' to print the listing to
      
       ## contrib/git-jump/git-jump ##
      @@
     @@ contrib/git-jump/git-jump
      +usage: git jump [--stdout] [<mode>] [<args>]
       
       Jump to interesting elements in an editor.
     - The <mode> parameter is one of:
     -@@ contrib/git-jump/git-jump: while test $# -gt 0; do
     - 	shift
     - done
     - if test $# -lt 1; then
     --	usage >&2
     --	exit 1
     +-The <mode> parameter is one of:
     ++The <mode> parameter is one of the following,
     ++defaulting to "auto" if omitted:
     + 
     + diff: elements are diff hunks. Arguments are given to diff.
     + 
     +@@ contrib/git-jump/git-jump: grep: elements are grep hits. Arguments are given to git grep or, if
     + 
     + ws: elements are whitespace errors. Arguments are given to diff --check.
     + 
     ++auto: select one of the other modes based on worktree state;
     ++      "merge" if there are unmerged paths, "diff" if there are
     ++      unstaged changes, "ws" if there are whitespace errors.
     ++
     + If the optional argument `--stdout` is given, print the quickfix
     + lines to standard output instead of feeding it to the editor.
     + EOF
     +@@ contrib/git-jump/git-jump: mode_ws() {
     + 	git diff --check "$@"
     + }
     + 
     ++mode_auto() {
      +	if test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" != "true"; then
      +		usage >&2
      +		exit 1
      +	fi
     -+	if test -n "$(git ls-files -u)"; then
     -+		set -- merge
     -+	elif ! git diff --quiet; then
     -+		set -- diff
     ++	if test -n "$(git ls-files -u "$@")"; then
     ++		mode_merge "$@"
     ++	elif ! git diff --quiet "$@"; then
     ++		mode_diff "$@"
     ++	elif ! git diff --check >/dev/null 2>&1; then
     ++		mode_ws "$@"
      +	else
      +		usage >&2
      +		exit 1
      +	fi
     ++}
     ++
     + use_stdout=
     + while test $# -gt 0; do
     + 	case "$1" in
     +@@ contrib/git-jump/git-jump: while test $# -gt 0; do
     + 	shift
     + done
     + if test $# -lt 1; then
     +-	usage >&2
     +-	exit 1
     ++	set -- auto
       fi
       mode=$1; shift
       type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }


 contrib/git-jump/README   | 12 ++++++++++++
 contrib/git-jump/git-jump | 29 +++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 3211841305..ac35792e55 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -75,8 +75,20 @@ git jump grep foo_bar
 # arbitrary grep options
 git jump grep -i foo_bar
 
+# jump to places with conflict markers or whitespace errors
+# (as reported by # `git diff --check`)
+git jump ws
+
 # use the silver searcher for git jump grep
 git config jump.grepCmd "ag --column"
+
+# pick a mode automatically: "merge" if there are unmerged paths,
+# "diff" if the worktree has unstaged changes, "ws" if there are
+# whitespace problems; otherwise show usage
+git jump auto
+
+# with no explicit mode, same as "auto"
+git jump
 --------------------------------------------------
 
 You can use the optional argument '--stdout' to print the listing to
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 8d1d5d79a6..43d3b42a41 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -2,10 +2,11 @@
 
 usage() {
 	cat <<\EOF
-usage: git jump [--stdout] <mode> [<args>]
+usage: git jump [--stdout] [<mode>] [<args>]
 
 Jump to interesting elements in an editor.
-The <mode> parameter is one of:
+The <mode> parameter is one of the following,
+defaulting to "auto" if omitted:
 
 diff: elements are diff hunks. Arguments are given to diff.
 
@@ -16,6 +17,10 @@ grep: elements are grep hits. Arguments are given to git grep or, if
 
 ws: elements are whitespace errors. Arguments are given to diff --check.
 
+auto: select one of the other modes based on worktree state;
+      "merge" if there are unmerged paths, "diff" if there are
+      unstaged changes, "ws" if there are whitespace errors.
+
 If the optional argument `--stdout` is given, print the quickfix
 lines to standard output instead of feeding it to the editor.
 EOF
@@ -82,6 +87,23 @@ mode_ws() {
 	git diff --check "$@"
 }
 
+mode_auto() {
+	if test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" != "true"; then
+		usage >&2
+		exit 1
+	fi
+	if test -n "$(git ls-files -u "$@")"; then
+		mode_merge "$@"
+	elif ! git diff --quiet "$@"; then
+		mode_diff "$@"
+	elif ! git diff --check >/dev/null 2>&1; then
+		mode_ws "$@"
+	else
+		usage >&2
+		exit 1
+	fi
+}
+
 use_stdout=
 while test $# -gt 0; do
 	case "$1" in
@@ -99,8 +121,7 @@ while test $# -gt 0; do
 	shift
 done
 if test $# -lt 1; then
-	usage >&2
-	exit 1
+	set -- auto
 fi
 mode=$1; shift
 type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }

base-commit: 1c00d2d8392f603a6263f11f1a50fde96ae5475e
-- 
gitgitgadget
