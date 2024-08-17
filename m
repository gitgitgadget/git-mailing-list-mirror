Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB181487DF
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723886769; cv=none; b=Vm9j7iSgUjLGMj6Jl32SMn+9fo293DWRn7H70nD5GC4z7Rw4pUoDu6lJeoJiLQFiyoNPosfHKFGk7ivMfoaR4BQuBIPj/9fE/CWpxcm57NsXAIwlgyVgIQksuW+axUlzzqmEdq49Ht5EgpncffZhPv5fPLM1Hi8Rs5aJUiZJVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723886769; c=relaxed/simple;
	bh=Y/eflf72LHbfyadXjodWb8yDEzd6vBwvAvyrlVdBjOc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OFJVN/zDwhVRPEZb2UYzTBIDHA5puiSXBY9EtqtvRnVxbLDVXx+vhRRp5Hc+kGvk5qG4+j5VFJ0mjuJnGbsmq2PIEZG1Sz3KyFDMBPfxLMM7Ku4lQCOHWV80u1Owj0a4zU97bk3uKPEtGzlerDQJUnhAaTnNFYZWVXmdptIDKzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFhXaC8e; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFhXaC8e"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428141be2ddso19103825e9.2
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723886766; x=1724491566; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHG2sFf1oXdGYAQiFJCppD/TIS+KE4TS3ITpeGhcpNk=;
        b=NFhXaC8esb454RzhNrB7oTQM59SupDsyjtpIu+KcnUO3/xb+pc6BgE+TXzGLPOXfT1
         CvmHQL6ZXZL334aPcMKxMGOgJlz2Hfeq7ioy1Jng4QAxB+uNvwz9PX31aNvDxDrLXoO2
         lbd4JCpwQ7qsqFTc1c+JUX8lPtYna87spTUkkTdnrQcCx6RpFyGniUFeKGEaJ4GPg76z
         fBpl9nhw0HZG5ASK6HbzlunGG2u3JZf2+WVocOTTeGerbhJQzjxGg98EUxJF1K30d882
         P69yaTmxw5Wug3FcI8UD4oyyXsiyMKTz1D2vu+MEKehOPKmt7f/1sQn6xZ8eXVk85g+O
         a/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723886766; x=1724491566;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHG2sFf1oXdGYAQiFJCppD/TIS+KE4TS3ITpeGhcpNk=;
        b=TUq2DcRlxg6kmX6UynzOA+wVnwFaFH5EFAcQmYBIHuxxzcAVL/hVh5rDkwltr4URhW
         qNOGBHQGBzBmXsoHdsxGZuE6O2Zj4Pv5PGgPP9EEJIEqCB7Id9gAw++Xtp8rWg5TOGcp
         ZOXxPSl3ilXPdgpGqClEUGD3akEMtZBuWw8qlbGsdbSFEdRuTqbLtNuhP47y58FdDgJ7
         erdpOVhyVdTmiSgHLlV1+sU6efpEQ4aMriKi+7tGHC0h3tWnbu14TLx6NqclMivCb6zB
         pLuV4LnordMYC3bXcdGMT+BLgZPiW45XD9RgyDMNqMSGLm1xLcEUGYkO0lTXxkXisYlO
         ALrQ==
X-Gm-Message-State: AOJu0YwpL09pajw++OyUk18fua74zSvzBrgPCCQ3PTf6MqHB56Ro416s
	Ay2Sv861l5DkWHzjkPsCQpsn+6C8laL1phevXtbPp43LDy9MHm+013zhZg==
X-Google-Smtp-Source: AGHT+IFRAah2Tmkok1ISyFZ2jJ+FoUB1eeVOvMps2v5x8nU11OGgOMuAVqGt5n1DhqnAm/HJCdSC3Q==
X-Received: by 2002:a05:600c:3b04:b0:429:994:41a2 with SMTP id 5b1f17b1804b1-429ed785b80mr30050555e9.7.1723886765713;
        Sat, 17 Aug 2024 02:26:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7c93esm98103425e9.41.2024.08.17.02.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 02:26:05 -0700 (PDT)
Message-Id: <232340902a1feeafe526528eb88b8d0814d11545.1723886761.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
References: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
	<pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Aug 2024 09:25:56 +0000
Subject: [PATCH v3 4/8] git-prompt: replace [[...]] with standard code
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
Cc: "Junio C. Hamano" <gitster@pobox.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Patrick Steinhardt <ps@pks.im>,
    Avi Halachmi <avihpit@yahoo.com>,
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

