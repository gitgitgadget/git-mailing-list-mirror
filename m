Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1F446A3
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481295; cv=none; b=WQANQCIV8l214kVWTPwQyTsgcwscwDeqQEjpujx19wqCWYULa82zgVNtM+thVh5slJJ5nQpksbmxomPZkCv1D6ETR6iDsiTbPL/I28GV91TQSJcIneRgkANSYAFayGs2eUXrHPXiefbMVJvEifxHzRb6uVMNmHgWSqVWpuiQH7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481295; c=relaxed/simple;
	bh=IEHfSRE4Jbp24UVMXHHlUG8xKOwgs/qdfLp53XN930o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kobQ2k90vVH5Hv5J/uSmrIJGG0UjfMq94dMSiKErItUcgXrJQ80dWnbphuhB62eWYZwakfCkmLMPqGnbXiIkJB0Eu9y6d+FF/vsgdmBa22xLYctbaoO/O8+jWPcewrcmIUfVWodTYifNBIZ0xIn5EasBFQN9/rmv1dDv7byXAE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU4olZpE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU4olZpE"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d780a392fdso16875545ad.3
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 14:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706481293; x=1707086093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APniPNMLisqNBc4JkIPP6z4qfYZD3deOqVuZPMXusTg=;
        b=MU4olZpE7euGuTWtAmUdn2IgjBu+YiMjGJ9mFmKRXVrY7hfnQ+0JQ6AzqFNU90pKOH
         u3pRAZoBTvKQxogYsYbYmEOZyJhJ9qX0uWOB+kUaW0Plq/IONQG0NqKtHKVXJ64MNGLe
         8HOzj0wPwzOQBxrB1SXozri1mAO1yy3qbAf8rlO29ZqLmiYQ88RxAlwN4Cty53oDqko7
         B33aA7b6J9LPZM2tTXxmqdlQRW9BG4OdE8jntYUXQDp9F3oReupQHPpRmysxFH2M8IBr
         atXrDynyZPmdFx53AHS/VjIbqkPe0XSTM5aTzMTwqf+EIPXYUkjX1J3jlguPhiYs4a3v
         H9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706481293; x=1707086093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APniPNMLisqNBc4JkIPP6z4qfYZD3deOqVuZPMXusTg=;
        b=LwbFmdksUcGbfgzWjzzW7Ya8ygFWBIdyYiQIPye7qb5LCC+pi/nmUQO+IEx+6CpEgH
         OTANDQtlxwaWgvHp4c+PNxzbL/gmFzfKhbGhNzmEu/9BxH+hsa3oGhxW/CA3FHSc+14A
         kKRGjMafV4ioaIZMZYJytdo+fMl5LE8OsZR2Ote63GjvPNzlcRqVGir1tQGnBa9f+dRo
         NfoEVkVJCvZ24vRAbiqvUqJDRQ/Dd71XPF+qRtMO95hlNvZrM66BU659986/iJBHNjW0
         ZlwWTlKb/z6j5wlxjb8vjowxbc7Mx2S+59JLZyGuofvZjky/hcXFwM05aeRat1eo27yC
         aQpA==
X-Gm-Message-State: AOJu0YzbVe7pbdqnLxsgZbQcU2ZZich30OAltJq0GHubIt3D+6hjiu6b
	lcQZ6YoQ7khcs07+Q597Nx+s3zKNoPn5gVDibwa0uM+H97JxsiOVoNHNmbMm
X-Google-Smtp-Source: AGHT+IFxtN3jJ+YvrFrT6miZNpJnFqTtLwVdoDYlMEUVCd3NNhCAiaC/bOLMrvyPHVHmaAANu56crQ==
X-Received: by 2002:a17:903:1107:b0:1d5:4b18:17d1 with SMTP id n7-20020a170903110700b001d54b1817d1mr4473244plh.106.1706481293086;
        Sun, 28 Jan 2024 14:34:53 -0800 (PST)
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id jy15-20020a17090342cf00b001d71eac34a6sm4077282plb.294.2024.01.28.14.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:34:52 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 6E2B2520292; Sun, 28 Jan 2024 13:34:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v4 4/8] completion: new function __git_complete_log_opts
Date: Sun, 28 Jan 2024 13:34:43 -0900
Message-ID: <20240128223447.342493-5-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128223447.342493-1-britton.kerin@gmail.com>
References: <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240128223447.342493-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The options accepted by git-log are also accepted by at least one other
command (git-bisect).  Prepare to factor out the common option and
option argument completion code by defining a new function.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 101 +++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2ed600244a..dfd504c37e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2089,6 +2089,107 @@ __git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-c
 __git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
 __git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default human raw unix auto: format:"
 
+# Complete porcelain (i.e. not git-rev-list) options and at least some
+# option arguments accepted by git-log.  Note that this same set of options
+# are also accepted by some other git commands besides git-log.
+__git_complete_log_opts ()
+{
+        COMPREPLY=""
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
 _git_log ()
 {
 	__git_has_doubledash && return
-- 
2.43.0

