Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0D266A7
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753627779; cv=none; b=jPQ9wf5zS9jrgrjA3/vrOUCmT/I5/oArr9JMfygeuEm2+YjSK/VdjSZh7b04mmhSZ4WfAzz7Jphqobh+e9VWzL+75swBKaD1utJRshPQIxHKdpX/mqHMaNnz3VQ4WwjJkl95YXZPg7A3ZA/WFXACvUyvqI3lcXD+lhHFJjZnj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753627779; c=relaxed/simple;
	bh=BIq9K+lO4sTZzNuSt0UE6ZikkSzRlo2ugfDnoP+6U+0=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=rgWrdTsk+Nhc8NtM4jz8SuGqltdnil9+B5sPg0PHZeAbX+ClY3/GxIP3hkKf4mLdsRd812qgYgkBzbZ+4Fd/qFkcI10faO5q2bKnkVEOJq11KFeNMMm407TN5fahIo65RI3Rl/d+CtpcTvPDdc7s7AmQ6qQqA/GQoOR3NPbeSN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfRPR4PU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfRPR4PU"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b78294a233so609658f8f.3
        for <git@vger.kernel.org>; Sun, 27 Jul 2025 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753627775; x=1754232575; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nBHxYpJsl8ycneAGE3JaWO0LzS9pPNWyGJW+D6jsTnM=;
        b=VfRPR4PU5RYDyIdKieKTsm3T/rUbe+kFZww9Nz8iAEoFtTXalbGurV7YKl/+pnCW4m
         O1ebrPYHh0Yr1AZmZC0XW/X1krILBmzsMH7SWusgN3iDQfaLtq4O6ujra+fQiV4ng0+I
         V/wsn0pbw5WbTTl9cBXoFVMNvDhdNi86dz3RHITbCpGlh3iN5edim/O3cP73269SWisd
         1MDuHOitnkbo9J7lQOaeh8DctZ9Ab0M4fLjeUIkSOB2RRs/M0uwEiGAi47BfjEVjtYD6
         62q6/+wX9esps9m0UxG5CUKI95nP7HrPZ/R6wkKWcnnpMqWQTHvolGDIpQcNFpgLklMl
         Ew3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753627775; x=1754232575;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBHxYpJsl8ycneAGE3JaWO0LzS9pPNWyGJW+D6jsTnM=;
        b=YBenOq8Lq4VfZP9ZVn5I1BSYWUWWGWMgaykFwLFmEnDu6AntEK4VJzhziKvnaVnORB
         7BDyjFser58cy18lpfis7nx45C0nxTzDlUSSHxd+jemT8m6lfQ5DkICRmzYvA7ieelDk
         e27zZ9RsQH+mS/E1NXuPfuNuaAAIW+lj1qMZ6XDk5/6wQ8h+iuuMTUM/CLggMbsQctoH
         eSb2ceTVvOvf9uen0fxLGTbBwbpgj0eUZZjubABKFCmP/Z+UbIWSIo8F3hPpqgnHhaWc
         YgVRHV4r0x5fAmoQ94+vrDQvcsZk0X2SbkFoFagWv3aINxjaCGAN88u9dPdJVvxlsIz/
         Fy5g==
X-Gm-Message-State: AOJu0YxaFFnIdNqSM6RdjW6B3WoewM1BYpMDtWzaj+6Aicop3vrPhus0
	gvwAbyn5rrXL5snqgnJBJprAjKyEuTgnWp5vUVidpoB55VkHM9cTVHbw9vfonw==
X-Gm-Gg: ASbGnctD3v7N/rnFWnZdLS5HUXWmUNZ07Hf/WoXoKYSrypQbohuK87ceH+mefT2e47/
	dNs4eC7YbDwBcuRUa+6j7GZSCO6amsHDQqRP7gFdhcIuZcPk7ksg6LCWbiNmQk87fpuYfEc9i6V
	QcqGrMPfcat9zM8HIjA7K+uX2oWvENjSrkcJvPqqSaVM7ji6fdCLNsOpuBR9y2Lo+IP8x3w3rI/
	ZnOOuHzzWbcNEsp45b9jU8EkuRrAjS58rTrHs4ZysylJ8hR3fVaE8X8bQw3mt5Be8Ebcprs318u
	aINgtJhBvQjdWXGBxrO7ikp1tGFFXiWJGvCXJheBjDQ1hehG1tcyGYN7yN02xUrmrIyLnCuMQMw
	L4veStOJWs8alf0eGyFgNYiY=
X-Google-Smtp-Source: AGHT+IEc9mEAufNhxCFCqJOniSLNmly/KgixANOTuXcJYn92UecXSJj9JHaokbvWFZGLyMXiWz8nkw==
X-Received: by 2002:a05:6000:1ac6:b0:3b5:e2ca:1c2 with SMTP id ffacd0b85a97d-3b7767267bbmr5883808f8f.2.1753627775037;
        Sun, 27 Jul 2025 07:49:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac59bcasm64294775e9.16.2025.07.27.07.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 07:49:34 -0700 (PDT)
Message-Id: <pull.1946.git.1753627773304.gitgitgadget@gmail.com>
From: "Nelson Benitez Leon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 27 Jul 2025 14:49:33 +0000
Subject: [PATCH] completion: new config var to use --sort in for-each-ref
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
Cc: Nelson Benitez Leon <nbenitezl@gmail.com>,
    =?UTF-8?q?Nelson=20Ben=C3=ADtez=20Le=C3=B3n?= <nbenitezl@gmail.com>

From: =?UTF-8?q?Nelson=20Ben=C3=ADtez=20Le=C3=B3n?= <nbenitezl@gmail.com>

Currently when completing refs, e.g. by doing "git checkout <TAB>", all
refs are shown in alphabetical order, this is an implicit ordering and
cannot be changed.

This commit will make the sort criteria to now be explicit, mandated by
a new config var which will be used for the --sort=<val> of for-each-ref

This new config var will have a default value of alphabetical order,
so Git's default behaviour remains unchanged.

Also add '-o nosort' to 'complete' to disable its default alphabetical
ordering so our new explicit ordering prevails.

Signed-off-by: Nelson Benítez León <nbenitezl@gmail.com>
---
    completion: new config var to use --sort in for-each-ref
    
    Hi, I'm submitting a patch for the Bash completion script, to be able to
    change the default implicit alphabetical ordering used when returning
    refs e.g. when doing "git checkout "
    
    I wanted the completed refs to be sorted by "recently worked on", I
    achieve it by using committer date field in descending order i.e.
    --sort="-committerdate" because that shows on top the branches that have
    recently been worked on. The completion script does not allow to set a
    custom sort order, so we're stuck with the default alphabetical one, so
    I'm sending a patch which adds a new config var where the user can set
    their desired custom sort criteria.
    
    I've not added tests because I'm not familiar with the test machinery,
    hopefully this is still useful.
    
    I'd also like to ask the Git audience about their preference for
    changing the default sort value in a future patch:
    
     1. stay the same (alphabetical order)
     2. change it to show recently worked on branches first (like me)
    
    I people agree 2. is more useful then we can change it in a follow-up
    patch.
    
    Regards,
    
    PD. I previously sent this to the mailing list but resulted in a bad
    formatted email because I use Gmail (and I don't want to activate 2FA
    authentication just for this) so I'm sending this time through
    GitGitGadget and incorporating some fixes from review comments I got,
    like adapting commit message to 72 chars wide.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1946%2Fnbenitez%2Fbash_completion_explicit_sort-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1946/nbenitez/bash_completion_explicit_sort-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1946

 contrib/completion/git-completion.bash | 56 +++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e3d88b06721..59964a8056e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -80,12 +80,37 @@
 #     When set, uses for-each-ref '--ignore-case' to find refs that match
 #     case insensitively, even on systems with case sensitive file systems
 #     (e.g., completing tag name "FOO" on "git checkout f<TAB>").
+#
+#   GIT_COMPLETION_REFS_SORT_BY_FIELDNAME
+#
+#     Fieldname string to use for --sort option of for-each-ref. If empty or
+#     not defined it defaults to "refname" which is the same default git uses
+#     when no --sort option is provided. Some example values:
+#       '-committerdate' to descending sort by committer date
+#       '-version:refname' to descending sort by refname interpreted as version
+#       More info and examples: https://git-scm.com/docs/git-for-each-ref#_field_names
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
 esac
 
+# Reads and validates GIT_COMPLETION_REFS_SORT_BY_FIELDNAME configuration var,
+# returning the content of it when it's valid, or if not valid or is empty or
+# not defined, then it returns the documented default i.e. 'refname'.
+__git_get_sort_by_fieldname ()
+{
+	if [ -n "${GIT_COMPLETION_REFS_SORT_BY_FIELDNAME-}" ]; then
+		# Validate by using a regex pattern which only allows a set
+		# of characters that may appear in a --sort expression
+        if [[ "$GIT_COMPLETION_REFS_SORT_BY_FIELDNAME" =~ ^[a-zA-Z0-9%:=*(),_\ -]+$ ]]; then
+            echo "$GIT_COMPLETION_REFS_SORT_BY_FIELDNAME"
+            return
+        fi
+	fi
+	echo 'refname'
+}
+
 # Discovers the path to the git repository taking any '--git-dir=<path>' and
 # '-C <path>' options into account and stores it in the $__git_repo_path
 # variable.
@@ -751,7 +776,9 @@ __git_heads ()
 {
 	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
 
-	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
+	local sortby=$(__git_get_sort_by_fieldname)
+
+	__git for-each-ref --sort="$sortby" --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
 			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
 			"refs/heads/$cur_*" "refs/heads/$cur_*/**"
 }
@@ -765,7 +792,9 @@ __git_remote_heads ()
 {
 	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
 
-	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
+	local sortby=$(__git_get_sort_by_fieldname)
+
+	__git for-each-ref --sort="$sortby" --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
 			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
 			"refs/remotes/$cur_*" "refs/remotes/$cur_*/**"
 }
@@ -776,7 +805,9 @@ __git_tags ()
 {
 	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
 
-	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
+	local sortby=$(__git_get_sort_by_fieldname)
+
+	__git for-each-ref --sort="$sortby" --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
 			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
 			"refs/tags/$cur_*" "refs/tags/$cur_*/**"
 }
@@ -818,7 +849,9 @@ __git_dwim_remote_heads ()
 		}
 	}
 	'
-	__git for-each-ref --format='%(refname)' refs/remotes/ |
+	local sortby=$(__git_get_sort_by_fieldname)
+
+	__git for-each-ref --sort="$sortby" --format='%(refname)' refs/remotes/ |
 		PFX="$pfx" SFX="$sfx" CUR_="$cur_" \
 			IGNORE_CASE=${GIT_COMPLETION_IGNORE_CASE+1} \
 			REMOTES="$(__git_remotes | sort -r)" awk "$awk_script" |
@@ -847,6 +880,7 @@ __git_refs ()
 	local match="${4-}"
 	local umatch="${4-}"
 	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
+	local sortby=$(__git_get_sort_by_fieldname)
 
 	__git_find_repo_path
 	dir="$__git_repo_path"
@@ -905,7 +939,8 @@ __git_refs ()
 				"refs/remotes/$match*" "refs/remotes/$match*/**")
 			;;
 		esac
-		__git_dir="$dir" __git for-each-ref --format="$fer_pfx%($format)$sfx" \
+		__git_dir="$dir" __git for-each-ref --sort="$sortby" \
+			--format="$fer_pfx%($format)$sfx" \
 			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
 			"${refs[@]}"
 		if [ -n "$track" ]; then
@@ -929,7 +964,8 @@ __git_refs ()
 			$match*|$umatch*)	echo "${pfx}HEAD$sfx" ;;
 			esac
 			local strip="$(__git_count_path_components "refs/remotes/$remote")"
-			__git for-each-ref --format="$fer_pfx%(refname:strip=$strip)$sfx" \
+			__git for-each-ref --sort="$sortby" \
+				--format="$fer_pfx%(refname:strip=$strip)$sfx" \
 				${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
 				"refs/remotes/$remote/$match*" \
 				"refs/remotes/$remote/$match*/**"
@@ -2861,7 +2897,8 @@ __git_complete_config_variable_value ()
 	remote.*.push)
 		local remote="${varname#remote.}"
 		remote="${remote%.push}"
-		__gitcomp_nl "$(__git for-each-ref \
+		local sortby=$(__git_get_sort_by_fieldname)
+		__gitcomp_nl "$(__git for-each-ref --sort="$sortby" \
 			--format='%(refname):%(refname)' refs/heads)" "" "$cur_"
 		return
 		;;
@@ -3983,8 +4020,9 @@ ___git_complete ()
 {
 	local wrapper="__git_wrap${2}"
 	eval "$wrapper () { __git_func_wrap $2 ; }"
-	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
-		|| complete -o default -o nospace -F $wrapper $1
+	complete -o bashdefault -o default -o nospace -o nosort \
+		-F $wrapper $1 2>/dev/null \
+		|| complete -o default -o nospace -o nosort -F $wrapper $1
 }
 
 # Setup the completion for git commands

base-commit: e4ef0485fd78fcb05866ea78df35796b904e4a8e
-- 
gitgitgadget
