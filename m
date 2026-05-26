Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769130FC33
	for <git@vger.kernel.org>; Tue, 26 May 2026 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808992; cv=none; b=tQ+j/P6aMo7Ttj8Zqi1bhRwWCeAtMOTgL26vREie8Q89EEvOMojz6dsJrVhUNd+YQqXZgOeVqfxDDwAvV4eTNQ4XB2BhX+ogCvdiIE4aeueeEBhKHSAJg3PyOYtMa3Rju20XKXWeyFrCZJxjmcC270aD2mnRk6NrooaMdO76J6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808992; c=relaxed/simple;
	bh=D6ZuU8eikAGwFg9BQ4qet/CTy7tOTpGsR0MQ1cYrHWQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ni8R5TZ8rQkOK0qR5VS6GRjfzhP/hx3Z/5q3fxddyBGNwrk9N1VXLG3G5YKt9bMp7IoINr9Qm1oF3RFL/Qpro7DzdMbBxXUZXvwE9h/Q4Jg8dUkOGI56VP8j2MnjA0Xc/QhqGanOlImkWvlPxpMyXpeVBF3XMKaQCIvdiX9rEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKrR/NjG; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKrR/NjG"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-914a8522bc6so599390285a.0
        for <git@vger.kernel.org>; Tue, 26 May 2026 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779808989; x=1780413789; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9wTky/dAS33ZGUcX8XonogGyTYJAGHu9DsUxf7CfcY=;
        b=mKrR/NjGQxHN5MyYuSgBJ8tJuCwvLtHNukuBrw/c1nSNi7KjDHawSXYTieOpl08RNg
         cCSAqVu3PdoOoyZQAhAyhjbqEbqTdFCEPEdVzfMPGRpFuG4YeBlKNlJKN+wP5RnhI7Ns
         W1O5b0yKAuK2oqVsfhPc8RVttSBNE9TrRCyCCOVfLqhTz90Go8sHXYY2NOy76+qyavVa
         Frdm+5myIsfj78Ofd4fkDgAIrIH0+nbM+x10JhakO6obfJ26DyBWd7AHRljAQ6EeMET/
         BujfIeJIKbELN4dbJbWJ4pNPYwkgHXvSdy3B/fcbemHyisO4tIpl4vpyn14eLUvFqVkF
         c/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808989; x=1780413789;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9wTky/dAS33ZGUcX8XonogGyTYJAGHu9DsUxf7CfcY=;
        b=rWHi5CCFe/PwjSUUmkjila5ZOliIMtDRnPOQYif8mVRQoZMyUpYMmuohHaXUFkpisF
         0FeE+E7Voe6LV+nR/DtId9h8Tsm2ENPp5vLm3v7upXKCsUo9AYu2XgfgTytaRZL+NoHB
         FYWvOU0Hw66BtWNWZfiNNCZ3TZEem+3kPH+3HBXjCCzkOQceyqRZlOOQliIlBqNCgSSV
         jza+FGBF7lMtloRHJrwswenYwc5XSBr+o9vzG29lfnhd2it+NbACb3hGQtovTN4csg2/
         htmUN2W6XLZ6ZPTJUlUC37+A8vzwOLQn5oQ+hKHNZ+SS6872pEoAD+sRkbVozar6Pb+K
         FmkQ==
X-Gm-Message-State: AOJu0YyWyp0jAD+gIIyRf5sO9Lfg8bRR3I9sV/Xlck98OQdW64+2sHIl
	weQD/0+qTGqC/3dGGedfFawzz/AW0Vr0XOoP715qF2sXZvAQpfx+014kzpUPdARs
X-Gm-Gg: Acq92OF196Z7QYCo536pTvsaFm9X2cqjZCtkxKGkFVs0EQYeQcJDFw9H3Q2byf22v+c
	A3x/LOMFsVoHK6cY+yp1SAdR2g9toyOoVyb/Ss0+yMk3Wlx67JFeE9YSwv+DN9sXs0HJw6Fj6tz
	gAgeeLIiKwDBsEC6rNcLRaG6PSs4qnO6Avhk+hCWFSbhjUmqpGyd8AfyzUSJ+2jyBidPGqIdjaP
	w6pgK120FJIU0z7WBMXMxZq8v1KgPj78trbmT3gdBJW5ljvQ42s4crUiIblQjt42cPwlQ0ioK9B
	YpDFFiC4JJH/CfRBgQdVtrDl1Aqio4R44pkU4wRfdEtdrEQjUSwQfB+DShb5P5ForKpSkEmotEC
	L9J/Goj8QLdo6LQqaQ+VEO2zgm5xcpWRqifvVnF04pp24Cz/ihMWhgqJ8ukIAj47HRYZA7gXixZ
	BKYb8PUu5J0X/G5/Bk78pPXJx3XGbWc/8DtBfc
X-Received: by 2002:ad4:5c65:0:b0:8a1:8ddd:e12e with SMTP id 6a1803df08f44-8cc7b5feacdmr318133316d6.48.1779808989087;
        Tue, 26 May 2026 08:23:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.195.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81302a98sm140418046d6.33.2026.05.26.08.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:23:08 -0700 (PDT)
Message-Id: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
In-Reply-To: <pull.2311.git.git.1779590184752.gitgitgadget@gmail.com>
References: <pull.2311.git.git.1779590184752.gitgitgadget@gmail.com>
From: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 15:23:07 +0000
Subject: [PATCH v2] completion: hide dotfiles for selected path completion
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

The completion helper for index paths uses git ls-files rather than
shell filename completion. As a result, leading-dot paths such as a
tracked .gitignore were offered even when the user had not started the
path with ".".

Hide leading-dot path components for git rm, git mv, and git ls-files
when completing an empty path component. Explicit dot completion is
still preserved, so git rm . can still complete .gitignore.

This matches standard shell filename completion behavior, where dotfiles
are hidden by default unless the user starts their input with a dot.
This also resolves four TODO comments in t/9902-completion.sh which
have been present since 2013 (commit ddf07bddef9a, "completion: add file
completion tests", 2013-04-27), expecting that .gitignore would not be
shown when completing on an empty path component.

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2311%2Falibaba0010%2Fcompletion-hide-dotfiles-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2311/alibaba0010/completion-hide-dotfiles-v2
Pull-Request: https://github.com/git/git/pull/2311

Range-diff vs v1:

 1:  5ccb408fd5 ! 1:  056e239e06 completion: hide dotfiles for selected path completion
     @@ Metadata
       ## Commit message ##
          completion: hide dotfiles for selected path completion
      
     +    The completion helper for index paths uses git ls-files rather than
     +    shell filename completion. As a result, leading-dot paths such as a
     +    tracked .gitignore were offered even when the user had not started the
     +    path with ".".
     +
     +    Hide leading-dot path components for git rm, git mv, and git ls-files
     +    when completing an empty path component. Explicit dot completion is
     +    still preserved, so git rm . can still complete .gitignore.
     +
     +    This matches standard shell filename completion behavior, where dotfiles
     +    are hidden by default unless the user starts their input with a dot.
     +    This also resolves four TODO comments in t/9902-completion.sh which
     +    have been present since 2013 (commit ddf07bddef9a, "completion: add file
     +    completion tests", 2013-04-27), expecting that .gitignore would not be
     +    shown when completing on an empty path component.
     +
          Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
      
       ## contrib/completion/git-completion.bash ##


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
