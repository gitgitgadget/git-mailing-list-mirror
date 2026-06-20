Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE212348C5A
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781978162; cv=none; b=bpLHAMHKEguhnDFd8YNXqkpYfkl8KFFy+tSz0v+hn+x6M31AZqbPdKCUSEQgGqv3nYHm2sAFLAigUv7hL9ef9gsLc0NmNKSQgb8l7uo/pdjPRPGXt0oo2ntxx/FENF3/jVz0FwyFRbIWFylNf/15yMVmoKRhxT17V3pEQKX6VA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781978162; c=relaxed/simple;
	bh=IwTEgdEDsA74iO7xiVPfd7dhb3NV3bFOOr7lBgnin3M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DftfYjDhfN1+diSI9zVOL4+vVbvcHjv5MCpRAbNG2V+Ha8eRClN2bEyTddvhCJThg3YYygWYo/jBIPTzvmQrmp7/mkgtkWp/IaBR26K6J+d7mOKsO1HBeCFgrwxPR7zlgIV+SaLVrwnbKR4Wg631nbimjdTNFy4TkVdD5lfbP9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0P4Jl+y; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0P4Jl+y"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-91ae31bbaa9so282715085a.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781978160; x=1782582960; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tNMmww2e7jruQfr0O35uHhPxrfPmj3x500H1MOYmDo=;
        b=V0P4Jl+yJjU9sOfnthEsCXUs+DSHwq7wV1uHjh+E+jxKAimvDOX5tkVi4fZhEYzDC6
         ah6O7yTDVwR7QtiRouaMq68/AUBrEw0P/OVKnI2RgY3GMvS73sYTrGsoG3gAe+ZRLlKf
         4nVONlC9fe3GMGWYwBZYACqNOm5gHQFyrptYGSLqjT/iKnXplMXyjoLKJxG5pXYgA34C
         /43uPJTBlXaA1WzzKaQHiq2WgoVdmZjrggx5gVGtTRgR56Pd3fJkrdX5ulP7hPIiFWqp
         lnw+XeNkQnhHsna03aiAiLzay8kgtrd0FlqUb2WWcqF29pRqN0+LWiFiNVquEh4iRPiF
         e5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781978160; x=1782582960;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9tNMmww2e7jruQfr0O35uHhPxrfPmj3x500H1MOYmDo=;
        b=MPg82svzpYbVfevfPdUVayD3rmzYDkX4FqyJf4G9T1BQU3iWtXBmPLJNjAfo3CawQ5
         hqY5rUl+ksZ2Uh3JeXVzHAUciEn22Swqw9ULvU9Av2rdGzMOrlnMFgZXR5AQsk87QGku
         sIitEPj87JvlyGfunMGj7xsIDBVEpwDoVQNDapPFNyOBu1BLDXUR26Ve0mXowEkOYJuT
         9q06b1tPh52zyB4CQ3RnXdKwz3va6mSfQ4aUDgT1PtEq9AoEUo6NN+zT+EcdSk6weHZd
         HIeq2+CuJRUlfm+7BVBvxSgn7fxkrncIWTvHWS3SM8u8W6prdxri6xPfkPW3BmkB2mAe
         tmJw==
X-Gm-Message-State: AOJu0YwgfDvboCGcqD6snvz6s2s8RjyswYx5ewvbFWxqWaAHcDOyXGCV
	oiKU9vLHqvGCIzF6npSb5aMzXFc3SJhkQWCycY7jZLmfnLvb5zemHoDiddx8Zg==
X-Gm-Gg: AfdE7cm/OyXItMK0z8xGSJujTdqehhCRVmilo2LZbzQUpB5Yj3SMv+jw2MxrmwXHi/2
	rmpIKOo9yhN4vnZaHUCoVu3E70/JWg50WuuP+LQIImnoYn9cucZLBOTvaHD6izaPK47QQPQ8Idy
	J9kF30UDuWzMWKO20TqoWnLOpj/TpREZMOYATrUODF0h0RSRa1wETDeqHukg9yxe8H1LDcS0Gmr
	VVjHenxXuxQmIKniDNRtN7q8xe2lDciChi8vkbU+4v+LRg45xobMjjVV5t1uLmeEh2VkFXenCS7
	5fz9O44VNUFiDMtRqbXfVbv4zpJ0y8mNuOXEoNerswRlGt6xqBkSAfXIySraCaK/khTrCibbSQs
	NVNyBXNaFGLkNF0+Bg7STjZLCtjfDhrFjXwk+2ZFz5w2J69V0iReS5hF8Pfrdj08ZVAPAwmd6Rh
	XWWz26QKBgYLNGlOaaSeVWCgb7CEs=
X-Received: by 2002:a05:620a:370b:b0:915:d32a:1cba with SMTP id af79cd13be357-920d403b483mr1183462985a.27.1781978159707;
        Sat, 20 Jun 2026 10:55:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.134.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921d4c5cac9sm352104085a.0.2026.06.20.10.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 10:55:59 -0700 (PDT)
Message-Id: <7482ee46454606a0883117d6cded6df809de710c.1781978156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2311.v3.git.git.1781978156.gitgitgadget@gmail.com>
References: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
	<pull.2311.v3.git.git.1781978156.gitgitgadget@gmail.com>
From: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jun 2026 17:55:56 +0000
Subject: [PATCH v3 2/2] completion: hide dotfiles by default for path
 completion
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
Cc: Zakariyah Ali <zakariyahali100@gmail.com>,
    Zakariyah Ali <zakariyahali100@gmail.com>,
    Zakariyah Ali <zakariyahali100@gmail.com>

From: Zakariyah Ali <zakariyahali100@gmail.com>

The previous implementation required callers to explicitly pass a
"hide-dotfiles" flag to __git_complete_index_file to avoid cluttering
completions with hidden files. This led to inconsistent behavior across
commands (e.g., `git add` and `git mv` behaved differently) and forced
callers to maintain repetitive logic.

As suggested by Junio C Hamano, this commit simplifies the logic:
1. __git_complete_index_file now unconditionally hides dotfiles when
   no match pattern is provided.
2. The awk loop in __git_index_files is refactored to check the dotfile
   condition in a single, obvious place after handling path dequoting,
   removing the previous duplication.
3. Callers no longer need to pass "hide-dotfiles".

This provides a cleaner API and ensures a consistent, expected behavior
where dotfiles are hidden unless explicitly requested by typing a dot.

Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
---
 contrib/completion/git-completion.bash | 65 ++++++++++++--------------
 t/t9902-completion.sh                  |  9 +++-
 2 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e8f8fab125..b0b1b3c27a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -638,20 +638,23 @@ __git_ls_files_helper ()
 }
 
 
-# __git_index_files accepts 1 to 4 arguments:
+# __git_index_files accepts 1 to 3 arguments:
 # 1: Options to pass to ls-files (required).
 # 2: A directory path (optional).
 #    If provided, only files within the specified directory are listed.
 #    Sub directories are never recursed.  Path must have a trailing
 #    slash.
 # 3: List only paths matching this path component (optional).
-# 4: Hide paths whose first component starts with a dot if this is
-#    "hide-dotfiles" and the third argument is empty (optional).
+#
+# If the third argument is empty, paths that begin with a dot (dotfiles)
+# are hidden. This matches user expectations where dotfiles are considered
+# hidden configuration files/directories and shouldn't clutter default
+# completions unless explicitly requested by typing a dot.
 __git_index_files ()
 {
-	local root="$2" match="$3" hide_dotfiles="${4-}"
+	local root="$2" match="$3"
 	local hide_dotfiles_awk=0
-	if [ "$hide_dotfiles" = "hide-dotfiles" ] && [ -z "$match" ]; then
+	if [ -z "$match" ]; then
 		hide_dotfiles_awk=1
 	fi
 
@@ -661,28 +664,22 @@ __git_index_files ()
 	}
 	END {
 		for (p in paths) {
-			if (substr(p, 1, 1) != "\"") {
-				# No special characters, easy!
-				if (hide_dotfiles == 1 && substr(p, 1, 1) == ".")
+			if (substr(p, 1, 1) == "\"") {
+				# The path is quoted.
+				p = dequote(p)
+				if (p == "")
 					continue
-				print pfx p
-				continue
-			}
-
-			# The path is quoted.
-			p = dequote(p)
-			if (p == "")
-				continue
 
-			# Even when a directory name itself does not contain
-			# any special characters, it will still be quoted if
-			# any of its (stripped) trailing path components do.
-			# Because of this we may have seen the same directory
-			# both quoted and unquoted.
-			if (p in paths)
-				# We have seen the same directory unquoted,
-				# skip it.
-				continue
+				# Even when a directory name itself does not contain
+				# any special characters, it will still be quoted if
+				# any of its (stripped) trailing path components do.
+				# Because of this we may have seen the same directory
+				# both quoted and unquoted.
+				if (p in paths)
+					# We have seen the same directory unquoted,
+					# skip it.
+					continue
+			}
 
 			if (hide_dotfiles == 1 && substr(p, 1, 1) == ".")
 				continue
@@ -731,15 +728,13 @@ __git_index_files ()
 	}'
 }
 
-# __git_complete_index_file accepts 1 or 2 arguments:
-# 1: the options to pass to ls-file
-# 2: Hide paths whose first component starts with a dot if this is
-#    "hide-dotfiles" and the current word is empty (optional).
+# __git_complete_index_file accepts 1 argument:
+# 1: the options to pass to ls-files
 #
 # The exception is --committable, which finds the files appropriate commit.
 __git_complete_index_file ()
 {
-	local dequoted_word pfx="" cur_ hide_dotfiles="${2-}"
+	local dequoted_word pfx="" cur_
 
 	__git_dequote "$cur"
 
@@ -752,7 +747,7 @@ __git_complete_index_file ()
 		cur_="$dequoted_word"
 	esac
 
-	__gitcomp_file_direct "$(__git_index_files "$1" "$pfx" "$cur_" "$hide_dotfiles")"
+	__gitcomp_file_direct "$(__git_index_files "$1" "$pfx" "$cur_")"
 }
 
 # Lists branches from the local repository.
@@ -2176,7 +2171,7 @@ _git_ls_files ()
 
 	# XXX ignore options like --modified and always suggest all cached
 	# files.
-	__git_complete_index_file "--cached" hide-dotfiles
+	__git_complete_index_file "--cached"
 }
 
 _git_ls_remote ()
@@ -2409,9 +2404,9 @@ _git_mv ()
 	if [ $(__git_count_arguments "mv") -gt 0 ]; then
 		# We need to show both cached and untracked files (including
 		# empty directories) since this may not be the last argument.
-		__git_complete_index_file "--cached --others --directory" hide-dotfiles
+		__git_complete_index_file "--cached --others --directory"
 	else
-		__git_complete_index_file "--cached" hide-dotfiles
+		__git_complete_index_file "--cached"
 	fi
 }
 
@@ -3231,7 +3226,7 @@ _git_rm ()
 		;;
 	esac
 
-	__git_complete_index_file "--cached" hide-dotfiles
+	__git_complete_index_file "--cached"
 }
 
 _git_shortlog ()
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 02aaf71876..7a7594455c 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2360,6 +2360,7 @@ test_expect_success 'setup for path completion tests' '
 	      "spaces in dir" \
 	      árvíztűrő &&
 	touch simple-dir/simple-file \
+	      simple-dir/.dotfile-in-dir \
 	      "spaces in dir/spaces in file" \
 	      "árvíztűrő/Сайн яваарай" &&
 	if test_have_prereq !MINGW &&
@@ -2380,6 +2381,11 @@ test_expect_success '__git_complete_index_file - simple' '
 	test_path_completion simple-dir/simple simple-dir/simple-file
 '
 
+test_expect_success '__git_complete_index_file - dotfiles' '
+	test_path_completion "simple-dir/" "simple-dir/simple-file" &&
+	test_path_completion "simple-dir/." "simple-dir/.dotfile-in-dir"
+'
+
 test_expect_success \
     '__git_complete_index_file - escaped characters on cmdline' '
 	test_path_completion spac "spaces in dir" &&  # Bash will turn this
@@ -2789,7 +2795,8 @@ test_expect_success 'complete files' '
 	echo "out_sorted" >> .gitignore &&
 
 	git add .gitignore &&
-	test_completion "git commit " ".gitignore" &&
+	test_completion "git commit " "" &&
+	test_completion "git commit ." ".gitignore" &&
 
 	git commit -m ignore &&
 
-- 
gitgitgadget
