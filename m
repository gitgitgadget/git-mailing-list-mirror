Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300F42E64E
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705610620; cv=none; b=EYXnpnW3ocvYvt2fkJbM78BboS/0zxPrTBxrRX85VOVfbrXNb5J/FdvSEaNvyYgK+4PpVliJPjG2J7V4cz98GymE6XFMGPlZM+am6r4ov+jTrnDRongAglSe3IGa3Bfi6D+AUmJ+nL75CDBukC5WMToonEJ+vjYw62XIasVc+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705610620; c=relaxed/simple;
	bh=hNgCvCXxLlbJhZsgD5zHasyR/ZTu1PQqmR8dgnScSZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKQRgiArdN+kqYxfqjcjYUyouslr7EgGuV3JxJEXTAQpFLr1VujDXTwmf0HKlfCLyWDzpxrPcZ2B0oIRUtOETWMaCrspC+dKXLJmjUmEcHFJolU7sdurMoLjyNOhUMM35SCko24O8INGKASLdFb9syAn0z3J7cxCOzGbsPbZWEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiAZADJH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiAZADJH"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d71cb97937so170215ad.3
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 12:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705610618; x=1706215418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCvZbqb0BgzjI2Mi0k98LO28lzNNTVewcUzt0X9Y9CQ=;
        b=ZiAZADJHU4WjbrrfZSPmLkW3P8BlpltkqcFsBotyZH+26nfot/OId3nZsilz+1t0vo
         9hHzBMPb8Ts9pNnm6R3xC//fsonUTWhhUkYAYu/qLzcrD6J3foSrmEXM6Yx5Ql8hBq5D
         NmuiBupLRTWnKOvJkD1F0vBYrwfY2tmorXCmcF3cJRhlcwsj//alz2O0XIbuIx/EBLL5
         mdaLlaNealJkU++C9k8Up6yk2rkSlZiE9dsWEFFvDLgOWwsiLvDZg5tbBCbGy6qIg4Pg
         G1NsKC+dg+XxcHGbMiOVUgs58E5G9oMkqt9p7xE16AB5GZpKnk9FiwwX+qkL4ONWNFCT
         u0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705610618; x=1706215418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCvZbqb0BgzjI2Mi0k98LO28lzNNTVewcUzt0X9Y9CQ=;
        b=nyVzyBYnhbDuBv1X1JF62KrQKTHsvM8e6bl1xPCyXxnil4R92UFmpHL3JW39biWyJF
         hANVv1wa4kAOj5j+H3kF0WSong/aMkduOICXYBRZkWIXh4oblsvaMgPxnHAzmdNFaSey
         MCaiNaEtykbHGnDLxhe7sC7JR6dDdVl+pGTRBNZAMR47F1c1DHe6MBaa8RS7zA/6G9CC
         3fDyoj4Tt1DZWQ9yhLeFZYZOeyMjJUldM56aPgVYPEHglgtQejAm89M5M2EXZBl7bkVA
         pBNWfZnsRsCWJ4GzcCxujkCOvmaPB64rMDbaoxm9fuyeMRXu6lGWFaoyPTJvjYNG1pvl
         4tMw==
X-Gm-Message-State: AOJu0Yy2u59+A4qTPnk+0fGMaaWlx6r4Pz174TccP8NZ+Q7Hxi7bf9Md
	CwrqvlfnjguVoJr1PgCOXanswcyT+Alx7x6HoOBXQeYYg8waqxw4
X-Google-Smtp-Source: AGHT+IG2Tn9ZCiZoXILQSs9GQ8Zg6WyPhQ1MjjpxcT/mtzJnAa1kmYZiHrSxFXNxF9b7oulQ2pNk2A==
X-Received: by 2002:a17:903:2343:b0:1d5:907a:41aa with SMTP id c3-20020a170903234300b001d5907a41aamr1443514plh.21.1705610618544;
        Thu, 18 Jan 2024 12:43:38 -0800 (PST)
Received: from brittons-large-Vivobook (mobile-166-176-186-78.mycingular.net. [166.176.186.78])
        by smtp.gmail.com with ESMTPSA id jx16-20020a170903139000b001d4e058284esm1793921plb.89.2024.01.18.12.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 12:43:35 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 1DA80520276; Thu, 18 Jan 2024 11:43:33 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v3 3/5] completion: move to maintain define-before-use
Date: Thu, 18 Jan 2024 11:43:21 -0900
Message-ID: <20240118204323.1113859-4-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118204323.1113859-1-britton.kerin@gmail.com>
References: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
 <20240118204323.1113859-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 269 ++++++++++++-------------
 1 file changed, 134 insertions(+), 135 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c16aded36c..63ca8082a4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1445,6 +1445,140 @@ _git_archive ()
 	__git_complete_file
 }
 
+# Options that go well for log, shortlog and gitk
+__git_log_common_options="
+	--not --all
+	--branches --tags --remotes
+	--first-parent --merges --no-merges
+	--max-count=
+	--max-age= --since= --after=
+	--min-age= --until= --before=
+	--min-parents= --max-parents=
+	--no-min-parents --no-max-parents
+"
+# Options that go well for log and gitk (not shortlog)
+__git_log_gitk_options="
+	--dense --sparse --full-history
+	--simplify-merges --simplify-by-decoration
+	--left-right --notes --no-notes
+"
+# Options that go well for log and shortlog (not gitk)
+__git_log_shortlog_options="
+	--author= --committer= --grep=
+	--all-match --invert-grep
+"
+# Options accepted by log and show
+__git_log_show_options="
+	--diff-merges --diff-merges= --no-diff-merges --dd --remerge-diff
+"
+
+__git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-combined cc remerge r"
+
+__git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
+__git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default human raw unix auto: format:"
+
+# Check for only porcelain (i.e. not git-rev-list) option (not argument)
+# and selected option argument completions for git-log options and if any
+# are found put them in COMPREPLY.  COMPREPLY must be empty at the start,
+# and will be empty on return if no candidates are found.
+__git_complete_log_opts ()
+{
+	[ -z "$COMPREPLY" ] || return 1   # Precondition
+
+	local merge=""
+	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
+		merge="--merge"
+	fi
+	case "$prev,$cur" in
+	-L,:*:*)
+		return	# fall back to Bash filename completion
+		;;
+	-L,:*)
+		__git_complete_symbol --cur="${cur#:}" --sfx=":"
+		return
+		;;
+	-G,*|-S,*)
+		__git_complete_symbol
+		return
+		;;
+	esac
+	case "$cur" in
+	--pretty=*|--format=*)
+		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
+			" "" "${cur#*=}"
+		return
+		;;
+	--date=*)
+		__gitcomp "$__git_log_date_formats" "" "${cur##--date=}"
+		return
+		;;
+	--decorate=*)
+		__gitcomp "full short no" "" "${cur##--decorate=}"
+		return
+		;;
+	--diff-algorithm=*)
+		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
+		return
+		;;
+	--submodule=*)
+		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
+		return
+		;;
+	--ws-error-highlight=*)
+		__gitcomp "$__git_ws_error_highlight_opts" "" "${cur##--ws-error-highlight=}"
+		return
+		;;
+	--no-walk=*)
+		__gitcomp "sorted unsorted" "" "${cur##--no-walk=}"
+		return
+		;;
+	--diff-merges=*)
+                __gitcomp "$__git_diff_merges_opts" "" "${cur##--diff-merges=}"
+                return
+                ;;
+	--*)
+		__gitcomp "
+			$__git_log_common_options
+			$__git_log_shortlog_options
+			$__git_log_gitk_options
+			$__git_log_show_options
+			--root --topo-order --date-order --reverse
+			--follow --full-diff
+			--abbrev-commit --no-abbrev-commit --abbrev=
+			--relative-date --date=
+			--pretty= --format= --oneline
+			--show-signature
+			--cherry-mark
+			--cherry-pick
+			--graph
+			--decorate --decorate= --no-decorate
+			--walk-reflogs
+			--no-walk --no-walk= --do-walk
+			--parents --children
+			--expand-tabs --expand-tabs= --no-expand-tabs
+			$merge
+			$__git_diff_common_options
+			"
+		return
+		;;
+	-L:*:*)
+		return	# fall back to Bash filename completion
+		;;
+	-L:*)
+		__git_complete_symbol --cur="${cur#-L:}" --sfx=":"
+		return
+		;;
+	-G*)
+		__git_complete_symbol --pfx="-G" --cur="${cur#-G}"
+		return
+		;;
+	-S*)
+		__git_complete_symbol --pfx="-S" --cur="${cur#-S}"
+		return
+		;;
+	esac
+}
+
 _git_bisect ()
 {
 	__git_has_doubledash && return
@@ -2052,141 +2186,6 @@ _git_ls_tree ()
 	__git_complete_file
 }
 
-# Options that go well for log, shortlog and gitk
-__git_log_common_options="
-	--not --all
-	--branches --tags --remotes
-	--first-parent --merges --no-merges
-	--max-count=
-	--max-age= --since= --after=
-	--min-age= --until= --before=
-	--min-parents= --max-parents=
-	--no-min-parents --no-max-parents
-"
-# Options that go well for log and gitk (not shortlog)
-__git_log_gitk_options="
-	--dense --sparse --full-history
-	--simplify-merges --simplify-by-decoration
-	--left-right --notes --no-notes
-"
-# Options that go well for log and shortlog (not gitk)
-__git_log_shortlog_options="
-	--author= --committer= --grep=
-	--all-match --invert-grep
-"
-# Options accepted by log and show
-__git_log_show_options="
-	--diff-merges --diff-merges= --no-diff-merges --dd --remerge-diff
-"
-
-__git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-combined cc remerge r"
-
-__git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
-__git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default human raw unix auto: format:"
-
-
-# Check for only porcelain (i.e. not git-rev-list) option (not argument)
-# and selected option argument completions for git-log options and if any
-# are found put them in COMPREPLY.  COMPREPLY must be empty at the start,
-# and will be empty on return if no candidates are found.
-__git_complete_log_opts ()
-{
-	[ -z "$COMPREPLY" ] || return 1   # Precondition
-
-	local merge=""
-	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
-		merge="--merge"
-	fi
-	case "$prev,$cur" in
-	-L,:*:*)
-		return	# fall back to Bash filename completion
-		;;
-	-L,:*)
-		__git_complete_symbol --cur="${cur#:}" --sfx=":"
-		return
-		;;
-	-G,*|-S,*)
-		__git_complete_symbol
-		return
-		;;
-	esac
-	case "$cur" in
-	--pretty=*|--format=*)
-		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
-			" "" "${cur#*=}"
-		return
-		;;
-	--date=*)
-		__gitcomp "$__git_log_date_formats" "" "${cur##--date=}"
-		return
-		;;
-	--decorate=*)
-		__gitcomp "full short no" "" "${cur##--decorate=}"
-		return
-		;;
-	--diff-algorithm=*)
-		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
-		return
-		;;
-	--submodule=*)
-		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
-		return
-		;;
-	--ws-error-highlight=*)
-		__gitcomp "$__git_ws_error_highlight_opts" "" "${cur##--ws-error-highlight=}"
-		return
-		;;
-	--no-walk=*)
-		__gitcomp "sorted unsorted" "" "${cur##--no-walk=}"
-		return
-		;;
-	--diff-merges=*)
-                __gitcomp "$__git_diff_merges_opts" "" "${cur##--diff-merges=}"
-                return
-                ;;
-	--*)
-		__gitcomp "
-			$__git_log_common_options
-			$__git_log_shortlog_options
-			$__git_log_gitk_options
-			$__git_log_show_options
-			--root --topo-order --date-order --reverse
-			--follow --full-diff
-			--abbrev-commit --no-abbrev-commit --abbrev=
-			--relative-date --date=
-			--pretty= --format= --oneline
-			--show-signature
-			--cherry-mark
-			--cherry-pick
-			--graph
-			--decorate --decorate= --no-decorate
-			--walk-reflogs
-			--no-walk --no-walk= --do-walk
-			--parents --children
-			--expand-tabs --expand-tabs= --no-expand-tabs
-			$merge
-			$__git_diff_common_options
-			"
-		return
-		;;
-	-L:*:*)
-		return	# fall back to Bash filename completion
-		;;
-	-L:*)
-		__git_complete_symbol --cur="${cur#-L:}" --sfx=":"
-		return
-		;;
-	-G*)
-		__git_complete_symbol --pfx="-G" --cur="${cur#-G}"
-		return
-		;;
-	-S*)
-		__git_complete_symbol --pfx="-S" --cur="${cur#-S}"
-		return
-		;;
-	esac
-}
-
 _git_log ()
 {
 	__git_has_doubledash && return
-- 
2.43.0

