Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C854652
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781978161; cv=none; b=IovUVIwF3pLWjSRZZirtNSeVvlFHAhRxu9FG0kOR50WdFB8IoJqwrCISOgWOOaduHkQfeYgHWQULociV6LpbBJ3eZ7umAIwFMsM8Wwpg86mfXWeao4u1mYkTW5BLe2h9a7ZxOOurNla+U948fn8S0E4SaQqu18vLOHGSwQ6HzGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781978161; c=relaxed/simple;
	bh=HG9wJ3IAsQkX7MjgjD+GrwzI4j+1h8ur5YgoQPnMyHU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JZZGaggy4kEDFHXJQH2bPrJm+nN3g2yNYZIs/AdXrGumVH3cnH4tmG2F79OoFMJO7SkSHgY3r5xIzkBIC0rF6j3TDInjER3M8UcltzvGGzNHshV7aGOoOfHZeVl13+EQ9VDFKQYypd7txqAMrtbhNHQq9YKwO5DkbR2YV836EWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLhZpkrs; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLhZpkrs"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9158643e538so279511185a.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781978159; x=1782582959; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1YX1EmAkp5hmCpNL0mmPgHr7H8vsVYVU4ROu1wKNkw=;
        b=YLhZpkrsCCNf/9fcNaTCanAQto0O1W/VSN8w+OHvn3D+9znODlxWzFeyYjc9S7hb2x
         +GMu9B9NKe9806ziN+0TEfebia03psSnA9CowDu9CyLtP1xczLbyhL27inThUNXhzbwC
         /RHvhrz1DvXE06KwfCjSwvVrCiaqDynUHYfMm5XyuuFvoPWadI2zI9ioQSRGpeXh4+2j
         qddetnOO9PoYkxsbT/YcA1N1wXLV+8LLPtPL97atWi+6cUj6ODAHjJPgoMquXhILfFiY
         4ujv0h7E35kSYGA0vE0QKdPNqDsOc01pWgibrtY0HW3uMVCQ6e+Irj4GQP0n+rxafuDa
         Ppzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781978159; x=1782582959;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h1YX1EmAkp5hmCpNL0mmPgHr7H8vsVYVU4ROu1wKNkw=;
        b=q9RSm78m4qmRmi9EvEts0HTBDeKGISdLzI0BD+h2A0x+nXL5QwfNSLI2bK3icf6QIT
         Tqh5JMKPtkoYJ6BI2/2SAbRk8C2KcdeNcQMU2vJpXRAz1vGLeXvqcZeMQffvKxDSkn2+
         2B/leproL/kdr/iPQFKsDnBLZXz3nsfLS0XVuQOclHfmQ4sgCNvc2sBiHXaYTFOasP7b
         hSsBMvibWMVvenYy6Pvobljx+1CTwl9plj8s4rmYl1eXHru+v6oYezrwN0iiuSdxT3dE
         NYciH5AwZD/ZVYf7mcoF+fq8qAY0q4l/yJtLl4mXPx+ihpn7ZETbeg9UQlW9AbOBSsxX
         ynNw==
X-Gm-Message-State: AOJu0Yzx3dYzPoCft/shMQ56okabJG28SKQ3Kqn3ifScJQWcUlutN84g
	eH1sh3hDx2sy9u656JfEO6mlQbiB3vqjecZMHknmf4JU1ipA3EB+Fv9EiIrTcA==
X-Gm-Gg: AfdE7clvmTXL9oXuynyRiYc4Fx+IS7635CQ7rcfNnpzSK/7EAKZzpZgAKL73IhylaKU
	qBYwEdpWBjPtd6nAbY0tJz3gHvZ3WHvD1p4BaZF+4i6D6GCzVCRkP2uHdTBl+psdqZBmQxw24Wf
	yZqXO7K/e7/tBMxeeXA1/E2/fi8nLaaXsmUbFuwI2fFp+Mq7n1wqN5mLdDiDQcK0dkt1ZBUBoJs
	lhs5gDqSn0qf+3sxic+hcoL9YB+u6VeeSzJnKFqD5cE2yUurCqh75ABPRiwmtGCZfTQSETRltGU
	m3IlQLZr1qcFpio6K+P0ZThD7+RXgBpaOIQ2bR77ztLWSLiHvJ8XvY2K0tBDIw69fKKUvJhsn9i
	9ChAhE9BEjryuTzlwpJErM8hnXbAU+vNrPmN6y3hbHRpU32Vl29V6DnRw3PdjOGwb30wTPKESYw
	WWMesK3Am5NtE8JsXD
X-Received: by 2002:a05:620a:454c:b0:916:18b1:ea5d with SMTP id af79cd13be357-920d3d499e8mr1132334885a.39.1781978158757;
        Sat, 20 Jun 2026 10:55:58 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.134.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921d7e51047sm365026385a.13.2026.06.20.10.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 10:55:58 -0700 (PDT)
Message-Id: <056e239e06ae7f54e9d23a8adce6ea1ec4002b32.1781978156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2311.v3.git.git.1781978156.gitgitgadget@gmail.com>
References: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
	<pull.2311.v3.git.git.1781978156.gitgitgadget@gmail.com>
From: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jun 2026 17:55:55 +0000
Subject: [PATCH v3 1/2] completion: hide dotfiles for selected path completion
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
-- 
gitgitgadget

