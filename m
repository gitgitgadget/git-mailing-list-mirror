Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A2946A
	for <git@vger.kernel.org>; Sun, 24 May 2026 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779590188; cv=none; b=Aew4flBNAtcmvhIL1RoVUHYAUivk70SykMgWygQHzm4q7F5Dutb/3KCHpqizfHK6T45QKFAESJuIQLuettgqyFcZb+HH80RAcnz5fqNijSxl80mmRZwkajbndQ4VI4zl9M1xEKZ5XhaGS4GDX/QaZdgNLYBrkWBlrSm4iM+28OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779590188; c=relaxed/simple;
	bh=vSlQV5FhKUPYWiQ+IvEu14hf2pL7DxhxlD2MGIt0aPc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=iBsbK5a7UR8wNz81TIB6Grdnr99BFhw28EbuPT19g9L5n4f4dnN/pM7vylNmEaPPZAf0ZBLROxA7+i54tObRJ5c9iPHAm53CH+u9bVKbeUzgq0TUwdgdycLEq7m45Imd7eqUZJH7+iETHEq4sLhaGQFbasyENv61xNruOOrpuNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEJ0z7vk; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEJ0z7vk"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-516e1525aa3so12341601cf.3
        for <git@vger.kernel.org>; Sat, 23 May 2026 19:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779590186; x=1780194986; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9spt+pyVcSxubuqkkBmCxgnjVfumF9IzqKwfjp+w/JI=;
        b=sEJ0z7vkZ1mhe2+2dYUBtfjhJKGTDn2ChSsPsih3Gq8jTG0WR3Bux5v8Y4/ftNKY6v
         ELdPcpr8/slbW0HHLPs4vl7f+Oxcni8rVh9ApPJZl16tsiNBslw3ZlWeXsJPRPSQBLpY
         QV+eveK9M3645Nemr0w2xlegfYb3hdU3nul/GcT21B5J11e1q6lsdcFPF/cpAOwZXwrf
         he4PSqJCRGMerdL7mhJ1x0DNgZSiC+buQDvYODykQn72kkxdA8uL6uy0gjxoHR84x/7J
         XvTkhFXzj5Sw+D7x7KBM0R0KGcCZ8Hfh/608qtv25q45XFbBxTYzqK7r69Bou/GobBhI
         64UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779590186; x=1780194986;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9spt+pyVcSxubuqkkBmCxgnjVfumF9IzqKwfjp+w/JI=;
        b=SkMsjoQ/cGPxd6+nURb7bdikztW2LbsM9+uRTj2aO3igp5keIAxWucQXa2LBpI2PqJ
         0YE4dHs9m/dKqyHrKQyAZCDtfEdbfLCp8Qj+u2LeTIF6SOoYdHpdJ+Re7UJa5cuhU1gr
         jEfRet4lvQNsci/swxTyDtwG0s7wX0GrMKsdDpZBle8cnRiKGCeSzEPO25877uLEv2Wv
         XcMqQOFTbrcgBjuU0cUxqEanU5ZoXkyJmIbxghzsWEORfX2MszNgvnZrJ5Y1XiN/jCMI
         M0zjR3jjZZtr6Wx4zVOrvCeZsuzzM0BKwT7jJs4e5Dq91DhRkXryyRSFJNOHGL26+hvh
         DxuQ==
X-Gm-Message-State: AOJu0Yxwhx2rYXkZ/8kmqe3Y06PC5movD516o974eu7QjPiOAoQVK7Bt
	cK28GADa/KxatGVZKPfqtYn0oQ3XsgeBjk83/+XZDLlgI+XSLokJwf7rJzGF4A==
X-Gm-Gg: Acq92OHO9mISSh91990ftXQYTaM0WAkoDnoZNucdtKXegjk3sRHA+jJg4WwBWz+5j85
	aLtU1hkXcAdvh/o/Xw7XjD/Ajq47Z9kGyA8Rguh5QBQ02WGOXvHOC5pZRuIwg1dTw1Hzw7EduTQ
	nVnqg7QhGial0CZfkcZI8EzgiDm2hpugjWr4H37GmcEfymhJrTeQruo5B7bxgr2qI1Be7DW6pjU
	BKyK6voFuk2Xw5Fn194UAtChJzxXfOM5krorPYLPpYb4AUU2B7auEPnbePlETDAF3lxRvcnM76/
	QBbuD5bDxs6sohTUBE5U2ashW7cPmP4TZ5kfUMgwNX83PERU1WeNbkSMwJsjamJ6lA98DoQmuGB
	kdWudjlHmtr00MtT0WJNZtVuyhanxtfyPRavfYDl3Kv/W1TFjyOmZMiDY6QcIvy1psLqT31H7m5
	IH5SYOSI4nZFUfs+r7WxLxC6dndKrJ+vtpgrmNuw==
X-Received: by 2002:a05:622a:608c:b0:510:2506:1ba9 with SMTP id d75a77b69052e-516d43dd982mr125030531cf.49.1779590185967;
        Sat, 23 May 2026 19:36:25 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.141.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8132f780sm67120556d6.49.2026.05.23.19.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 19:36:25 -0700 (PDT)
Message-Id: <pull.2311.git.git.1779590184752.gitgitgadget@gmail.com>
From: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 May 2026 02:36:24 +0000
Subject: [PATCH] completion: hide dotfiles for selected path completion
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
    Zakariyah Ali <zakariyahali100@gmail.com>

From: Zakariyah Ali <zakariyahali100@gmail.com>

Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
---
    completion: hide dotfiles for selected path completion
    
    The completion helper for index paths uses git ls-files rather than
    shell filename completion. As a result, leading-dot paths such as a
    tracked .gitignore were offered even when the user had not started the
    path with ..
    
    Hide leading-dot path components for git rm, git mv, and git ls-files
    when completing an empty path component. Explicit dot completion is
    still preserved, so git rm . can still complete .gitignore.
    
    This removes the existing TODO expectations in t/t9902-completion.sh and
    adds coverage for explicit dot completion.
    
    Validation:
    
     * git diff --check -- contrib/completion/git-completion.bash
       t/t9902-completion.sh
     * bash -n contrib/completion/git-completion.bash
     * ./t9902-completion.sh

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2311%2Falibaba0010%2Fcompletion-hide-dotfiles-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2311/alibaba0010/completion-hide-dotfiles-v1
Pull-Request: https://github.com/git/git/pull/2311

 contrib/completion/git-completion.bash | 36 +++++++++++++++++---------
 t/t9902-completion.sh                  | 10 ++-----
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a8e7c6ddbf..e8f8fab125 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -638,25 +638,33 @@ __git_ls_files_helper ()
 }
 
 
-# __git_index_files accepts 1 or 2 arguments:
+# __git_index_files accepts 1 to 4 arguments:
 # 1: Options to pass to ls-files (required).
 # 2: A directory path (optional).
 #    If provided, only files within the specified directory are listed.
 #    Sub directories are never recursed.  Path must have a trailing
 #    slash.
 # 3: List only paths matching this path component (optional).
+# 4: Hide paths whose first component starts with a dot if this is
+#    "hide-dotfiles" and the third argument is empty (optional).
 __git_index_files ()
 {
-	local root="$2" match="$3"
+	local root="$2" match="$3" hide_dotfiles="${4-}"
+	local hide_dotfiles_awk=0
+	if [ "$hide_dotfiles" = "hide-dotfiles" ] && [ -z "$match" ]; then
+		hide_dotfiles_awk=1
+	fi
 
 	__git_ls_files_helper "$root" "$1" "${match:-?}" |
-	awk -F / -v pfx="${2//\\/\\\\}" '{
+	awk -F / -v pfx="${2//\\/\\\\}" -v hide_dotfiles="$hide_dotfiles_awk" '{
 		paths[$1] = 1
 	}
 	END {
 		for (p in paths) {
 			if (substr(p, 1, 1) != "\"") {
 				# No special characters, easy!
+				if (hide_dotfiles == 1 && substr(p, 1, 1) == ".")
+					continue
 				print pfx p
 				continue
 			}
@@ -675,8 +683,10 @@ __git_index_files ()
 				# We have seen the same directory unquoted,
 				# skip it.
 				continue
-			else
-				print pfx p
+
+			if (hide_dotfiles == 1 && substr(p, 1, 1) == ".")
+				continue
+			print pfx p
 		}
 	}
 	function dequote(p,    bs_idx, out, esc, esc_idx, dec) {
@@ -721,13 +731,15 @@ __git_index_files ()
 	}'
 }
 
-# __git_complete_index_file requires 1 argument:
+# __git_complete_index_file accepts 1 or 2 arguments:
 # 1: the options to pass to ls-file
+# 2: Hide paths whose first component starts with a dot if this is
+#    "hide-dotfiles" and the current word is empty (optional).
 #
 # The exception is --committable, which finds the files appropriate commit.
 __git_complete_index_file ()
 {
-	local dequoted_word pfx="" cur_
+	local dequoted_word pfx="" cur_ hide_dotfiles="${2-}"
 
 	__git_dequote "$cur"
 
@@ -740,7 +752,7 @@ __git_complete_index_file ()
 		cur_="$dequoted_word"
 	esac
 
-	__gitcomp_file_direct "$(__git_index_files "$1" "$pfx" "$cur_")"
+	__gitcomp_file_direct "$(__git_index_files "$1" "$pfx" "$cur_" "$hide_dotfiles")"
 }
 
 # Lists branches from the local repository.
@@ -2164,7 +2176,7 @@ _git_ls_files ()
 
 	# XXX ignore options like --modified and always suggest all cached
 	# files.
-	__git_complete_index_file "--cached"
+	__git_complete_index_file "--cached" hide-dotfiles
 }
 
 _git_ls_remote ()
@@ -2397,9 +2409,9 @@ _git_mv ()
 	if [ $(__git_count_arguments "mv") -gt 0 ]; then
 		# We need to show both cached and untracked files (including
 		# empty directories) since this may not be the last argument.
-		__git_complete_index_file "--cached --others --directory"
+		__git_complete_index_file "--cached --others --directory" hide-dotfiles
 	else
-		__git_complete_index_file "--cached"
+		__git_complete_index_file "--cached" hide-dotfiles
 	fi
 }
 
@@ -3219,7 +3231,7 @@ _git_rm ()
 		;;
 	esac
 
-	__git_complete_index_file "--cached"
+	__git_complete_index_file "--cached" hide-dotfiles
 }
 
 _git_shortlog ()
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 28f61f08fb..02aaf71876 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2811,17 +2811,15 @@ test_expect_success 'complete files' '
 
 	touch untracked &&
 
-	: TODO .gitignore should not be here &&
 	test_completion "git rm " <<-\EOF &&
-	.gitignore
 	modified
 	EOF
 
+	test_completion "git rm ." ".gitignore" &&
+
 	test_completion "git clean " "untracked" &&
 
-	: TODO .gitignore should not be here &&
 	test_completion "git mv " <<-\EOF &&
-	.gitignore
 	modified
 	EOF
 
@@ -2832,9 +2830,7 @@ test_expect_success 'complete files' '
 
 	mkdir untracked-dir &&
 
-	: TODO .gitignore should not be here &&
 	test_completion "git mv modified " <<-\EOF &&
-	.gitignore
 	dir
 	modified
 	untracked
@@ -2843,9 +2839,7 @@ test_expect_success 'complete files' '
 
 	test_completion "git commit " "modified" &&
 
-	: TODO .gitignore should not be here &&
 	test_completion "git ls-files " <<-\EOF &&
-	.gitignore
 	dir
 	modified
 	EOF

base-commit: 9b7fa37559a1b95ee32e32858b0d038b4cf583e5
-- 
gitgitgadget
