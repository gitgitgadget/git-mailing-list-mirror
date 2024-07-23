Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E86413DDC6
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762317; cv=none; b=Bcgj3Li73ZU4Fkh8cQ0lmMzhL0xqgbCc1I4p0cAPjI6Jxl1cR8FYiUro8Ca09IBTM1ixedl6AF/fSTZYnuGv3AgiLv8ArtNSRWU7eEEZskfwrxLZMo0YxHeb3F+Idkkv67bIErAajJH8VMngPNEu7jgZLcMKVFguJxix2VPSp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762317; c=relaxed/simple;
	bh=Y/eflf72LHbfyadXjodWb8yDEzd6vBwvAvyrlVdBjOc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NxGuG7U3ss0agTTpYvmprmka0jPpkwj1wLj45bj+/iqRnCs2mVmJhcCoSrZWkEaXcRjJ6TXgX2Ocu2HixfpsT2GOQIkGfT8cLB/DYOssp5QYUMLkR7IOTnNG8vDVAOp6YI50qKllR/fd4JyDe7VbZvP0uWVNPvylWXYDzXh6j8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPrqLVV5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPrqLVV5"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so33156666b.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721762314; x=1722367114; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHG2sFf1oXdGYAQiFJCppD/TIS+KE4TS3ITpeGhcpNk=;
        b=NPrqLVV56Y11fQ8hwubKi9QJQ5h/8de2zfwyaU9VlM9hKxeVNmJtpuE5wOCOUekq67
         DhMps+NBGP0apgU1LvCI1NC+FBzpwmzW1xbaLiLxqQfH3AKueZLbdNmzfmwf6cyj6IVX
         5/u68GknDa5NbE0bBcIgTbDw/wPS8Rtf8P0oXIAz7ZMuLBuRt3b1TCm6CEbldsqctU74
         3EwA1kU+p2aw9/cZ9gXwnf3/7LHpjr544nUQfBNqhR3excq7lWYRLmyTeghZXzZh397/
         hHkHtE1Txc8TgQHwpL02hWhNajqMYN7a9z4eqJyqXbIRjGHcYTeiKWYKHpwxdkF5xbfF
         lBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721762314; x=1722367114;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHG2sFf1oXdGYAQiFJCppD/TIS+KE4TS3ITpeGhcpNk=;
        b=DTtNTXJ4v/ZcqotI8lgWJFG91G40IyLIXce2koa/C78tfuIuq4bNRqbk279lvcFZpf
         GJjpbpAo6Enomi39j1TCNzpU4z44qrW21D5O75G09b1Ckm1UBvNvx+2HOtEmmRLpYi18
         42X2DVb9Sbuq7fMh/X2g/bxUzPencVQxzbhrPT4CFelZIgI++ZK9S7hdXcRUzVEXlyVT
         bL/5mF9NamRCT7/IklaDUbOG+knkq50tWlfWo2YngK6z3AjtiG7t33x6dyTY4g5dOu8T
         KiKIpFKnSLYAsRejTBKBr7mXm2a83yBrVohYdoffA5XvvXVkwVlek+EjdJcApZsanbjI
         MdeQ==
X-Gm-Message-State: AOJu0Yyx/gfK2WrNl81dAB7tDlq/w+m8/NDbD46yCXDOvaOQ9s8Jj+3b
	IhsApxcWN0g+04RKS0Jdbe3AhUE1bljijC/QXCQkQJtjrXRZymni/IDdPg==
X-Google-Smtp-Source: AGHT+IENQsD1QnAF8VZBpDVAmM4fitwG22Qlepc1OAP4uYlyuYrwInheTh9u2u8IkFjqiZ3AuVjNig==
X-Received: by 2002:a17:907:1b22:b0:a7a:9f0f:ab2b with SMTP id a640c23a62f3a-a7a9f0fb5e5mr190115666b.32.1721762313906;
        Tue, 23 Jul 2024 12:18:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aaa7a4a76sm24137866b.96.2024.07.23.12.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 12:18:33 -0700 (PDT)
Message-Id: <232340902a1feeafe526528eb88b8d0814d11545.1721762306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 19:18:22 +0000
Subject: [PATCH 4/8] git-prompt: replace [[...]] with standard code
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
Cc: Avi Halachmi <avihpit@yahoo.com>,
    "Avi Halachmi (:avih)" <avihpit@yahoo.com>

From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>

The existing [[...]] tests were either already valid as standard [...]
tests, or only required minimal retouch:

Notes:

- [[...]] doesn't do field splitting and glob expansion, so $var
  or $(cmd...) don't need quoting, but [... does need quotes.

- [[ X == Y ]] when Y is a string is same as [ X = Y ], but if Y is
  a pattern, then we need:  case X in Y)... ; esac  .

- [[ ... && ... ]] was replaced with [ ... ] && [ ... ] .

- [[ -o <zsh-option> ]] requires [[...]], so put it in "eval" and only
  eval it in zsh, so other shells would not abort on syntax error
  (posix says [[ has unspecified results, shells allowed to reject it)

- ((x++)) was changed into x=$((x+1))  (yeah, not [[...]] ...)

Shells which accepted the previous forms:
- bash, zsh, ksh93, mksh, openbsd sh, pdksh.

Shells which didn't, and now can process it:
- dash, free/net bsd sh, busybox-ash, Schily Bourne sh, yash.

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 75c3a813fda..4781261f868 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -126,7 +126,7 @@ __git_ps1_show_upstream ()
 		case "$key" in
 		bash.showupstream)
 			GIT_PS1_SHOWUPSTREAM="$value"
-			if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
+			if [ -z "${GIT_PS1_SHOWUPSTREAM}" ]; then
 				p=""
 				return
 			fi
@@ -187,14 +187,14 @@ __git_ps1_show_upstream ()
 				upstream_type=${svn_upstream#/}
 				;;
 			esac
-		elif [[ "svn+git" = "$upstream_type" ]]; then
+		elif [ "svn+git" = "$upstream_type" ]; then
 			upstream_type="@{upstream}"
 		fi
 		;;
 	esac
 
 	# Find how many commits we are ahead/behind our upstream
-	if [[ -z "$legacy" ]]; then
+	if [ -z "$legacy" ]; then
 		count="$(git rev-list --count --left-right \
 				"$upstream_type"...HEAD 2>/dev/null)"
 	else
@@ -206,8 +206,8 @@ __git_ps1_show_upstream ()
 			for commit in $commits
 			do
 				case "$commit" in
-				"<"*) ((behind++)) ;;
-				*)    ((ahead++))  ;;
+				"<"*) behind=$((behind+1)) ;;
+				*)    ahead=$((ahead+1))   ;;
 				esac
 			done
 			count="$behind	$ahead"
@@ -217,7 +217,7 @@ __git_ps1_show_upstream ()
 	fi
 
 	# calculate the result
-	if [[ -z "$verbose" ]]; then
+	if [ -z "$verbose" ]; then
 		case "$count" in
 		"") # no upstream
 			p="" ;;
@@ -243,7 +243,7 @@ __git_ps1_show_upstream ()
 		*)	    # diverged from upstream
 			upstream="|u+${count#*	}-${count%	*}" ;;
 		esac
-		if [[ -n "$count" && -n "$name" ]]; then
+		if [ -n "$count" ] && [ -n "$name" ]; then
 			__git_ps1_upstream_name=$(git rev-parse \
 				--abbrev-ref "$upstream_type" 2>/dev/null)
 			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
@@ -265,7 +265,7 @@ __git_ps1_show_upstream ()
 # their own color.
 __git_ps1_colorize_gitstring ()
 {
-	if [[ -n ${ZSH_VERSION-} ]]; then
+	if [ -n "${ZSH_VERSION-}" ]; then
 		local c_red='%F{red}'
 		local c_green='%F{green}'
 		local c_lblue='%F{blue}'
@@ -417,7 +417,7 @@ __git_ps1 ()
 	# incorrect.)
 	#
 	local ps1_expanded=yes
-	[ -z "${ZSH_VERSION-}" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=no
+	[ -z "${ZSH_VERSION-}" ] || eval '[[ -o PROMPT_SUBST ]]' || ps1_expanded=no
 	[ -z "${BASH_VERSION-}" ] || shopt -q promptvars || ps1_expanded=no
 
 	local repo_info rev_parse_exit_code
@@ -502,11 +502,13 @@ __git_ps1 ()
 					return $exit
 				fi
 
-				if [[ $head == "ref: "* ]]; then
+				case $head in
+				"ref: "*)
 					head="${head#ref: }"
-				else
+					;;
+				*)
 					head=""
-				fi
+				esac
 				;;
 			*)
 				head="$(git symbolic-ref HEAD 2>/dev/null)"
@@ -542,8 +544,8 @@ __git_ps1 ()
 	fi
 
 	local conflict="" # state indicator for unresolved conflicts
-	if [[ "${GIT_PS1_SHOWCONFLICTSTATE-}" == "yes" ]] &&
-	   [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
+	if [ "${GIT_PS1_SHOWCONFLICTSTATE-}" = "yes" ] &&
+	   [ "$(git ls-files --unmerged 2>/dev/null)" ]; then
 		conflict="|CONFLICT"
 	fi
 
-- 
gitgitgadget

