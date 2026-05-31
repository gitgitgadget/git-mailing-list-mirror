Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9922A34D916
	for <git@vger.kernel.org>; Sun, 31 May 2026 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268583; cv=none; b=buYWVzxOvxRzXs2hoSYnMcZi38l/QiNs0wcO9Y/WhgMwHJKj2oNM3nW7clixOpvPYfO9bqIjYFwxkVNl31ZUKBbQnHEvQ6ALd6lx9npGyZJQhzX/yEc0EaSPNFycy8QpQYFkzVKJ9kS0jIBUkYQbvlyThs9sF1A5XoWXjgifM4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268583; c=relaxed/simple;
	bh=03tkkR5pKcY0zzXijFUlIeY6saNNYm4IiXCO0lz7Cqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ce5gyqye98iVs9zP1P0hmAbuK55EfDuSWOI7pQl/cqGYWkYJzKZmxFsb7YHHrn1LuI8lbKxcoqh05ToljSlwKAkSqQ+SoWwvCha8gSkVTPNyHiikXt79TF6aQ9sAK01Zv2CAFe2OTIm8VbwQ7wlb4jpu2BZFLf5T5o0ZhfXUORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKopZ6dH; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKopZ6dH"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ce9df48e1bso9862126d6.1
        for <git@vger.kernel.org>; Sun, 31 May 2026 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780268582; x=1780873382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bf9EJcj8xxnNeqGGOhF0OvZNm6iQZ6gmJ+jGnBPVY4=;
        b=mKopZ6dHQxtaXdVYyFtxbVjBv1Yc4eDKsEzEC8nFseBD0JZSiWEFW5RPVhuTNfDGaQ
         UJbVdbcbPPi+YUy4sHVTegZAxWo3Flf9fslRTaclTDal3eIJfEfZGefK4tIzie5fYtGJ
         a0aPay6NzsfmdhpGN8IMXeroe+EOicL4Pmyuz07X4N4GuZI/u1JefAOWZvcabPnsC0Dp
         4uwRH6oRFvygC6xzJCJTk2OnPCqEfsSF7YipQDy1W/R4eUJYi/nCKvwdkCZ3GVLjYl4s
         8CBF7WFdWauajgITwKou09SGo0aQdUAFYKJEvvoZs9mgVcTq2eb8U/K1hsGwDMXkz1lA
         XTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780268582; x=1780873382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/bf9EJcj8xxnNeqGGOhF0OvZNm6iQZ6gmJ+jGnBPVY4=;
        b=dlzV4XkMUwmHedXZ0ooxvcVcArNAK+2Im3807KxXiyUif+3o76/i34N7xtdfGO7ocs
         4vJa/GgeBAHlsUSi8IiExKLkVkqf2GensZTQ4/IhARauIGQ52YM6ZaWc9b1xJ0B90t/A
         o2fxy5zeyOnw99ej/Yi4Gi5HGFRmJW+FuObhJtwCPq79CJIanCw1rR1iVKUgycvOVqW5
         rICigeJ7Z6zONODtE41xpB0+Z7FaqK22Gu/pe+/bS3/qFsSuztkcUv48QlDJaNJlA+Aa
         3eyIKsHZhzrpk6Rqv/XyGhGFSdhWY8TqYFxPIjS/g+XH/HomvnhOhBCWzzIn3/5Gw38Z
         Losw==
X-Gm-Message-State: AOJu0YzwPIBpGofVV/JiCGYudrbNBEjHISKr+Dty+J1dXCQ/TwUQGBGt
	dg6a15ms2UziUd0DRoENtzg86d4nA0yCdz1l1IXpzO62rL9Q53FaA5jI/kL9KPe0
X-Gm-Gg: Acq92OHl5+njxdJLUlvSogHdF0nHQxcfTVv++mpbQG2pe4IRXaZfB+7f0aSYTllxDOa
	obYhwiJumQrHQ5OTD6LdrZ2gJtHLclNgLyypAaC11Eo8Icn6TRF/vGvc3zgjf+dBTlYgkiBnquc
	E/CBHHPRGJFWBabg/A+6r5B3lpnPTLCXCEz8NzH4tQzhb5S9Bp9v9z8EsTcT7cKvbTv1VwsMV42
	bG7zA+Rhk8iEPkTcnOcUEXudUNzMqeXDBYmif2o3hQWG8U+exea6Uz+NgBsZFS9VMy9dwy6XDlF
	5mChM4+iPtj9rbcvrzDegkbv1PQqDlH0jyPa1UksouyzfJN/5CKxlZw/7sJYi2+feCtdt8kfpoH
	3MATffP0detTCv5B0E9Dh2r98rtmTx6K4vDFUgtVdQojqBKMfAzqsvmTRy6puoqdaAp4Afzl8Yh
	wfftUJABtmJ5wBVBGTXezaqxVl3tWyAZoj6RU8
X-Received: by 2002:a05:6214:2c0d:b0:8cc:e25a:675b with SMTP id 6a1803df08f44-8ccefe129ddmr142640866d6.47.1780268581725;
        Sun, 31 May 2026 16:03:01 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm78268426d6.8.2026.05.31.16.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:03:00 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v3 03/12] git-gui: guard set/unset of GIT_DIR and GIT_WORK_TREE
Date: Sun, 31 May 2026 19:02:16 -0400
Message-ID: <20260531230225.126817-4-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260531230225.126817-1-mlevedahl@gmail.com>
References: <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260531230225.126817-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui unconditionally exports _gitdir as GIT_DIR, and _gitworktree as
GIT_WORK_TREE, to the environment, and unconditionally
unsets these environment variables before invoking gitk or git-gui when
a submodule is involved. This export happens even if _gitworktree is
empty, which happens when running from a bare repository. However,
exporting GIT_WORK_TREE as empty is never valid, and causes errors in
git.

GIT_DIR must be exported if the repository is not discoverable from the
worktree (or current directory if there is no worktree). The user might
have configured this.

If there is a worktree, git-gui makes this the current directory.
However, if the repository sets core.worktree, this value can only be
overridden by GIT_WORK_TREE so the latter must be exported.

As we cannot eliminate conditions where either variable is needed, let's
implement a pair of functions to set / unset these variables without
error, and without ever exporting an empty GIT_WORK_TREE.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 52897fbd09..2cf14d0dd5 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1125,6 +1125,20 @@ unset argv0dir
 ##
 ## repository setup
 
+proc set_gitdir_vars {} {
+	global _gitdir _gitworktree env
+	set env(GIT_DIR) $_gitdir
+	if {$_gitworktree ne {}} {
+		set env(GIT_WORK_TREE) $_gitworktree
+	}
+}
+
+proc unset_gitdir_vars {} {
+	global env
+	catch {unset env(GIT_DIR)}
+	catch {unset env(GIT_WORK_TREE)}
+}
+
 set picked 0
 if {[catch {
 		set _gitdir $env(GIT_DIR)
@@ -1210,8 +1224,8 @@ if {[lindex $_reponame end] eq {.git}} {
 	set _reponame [lindex $_reponame end]
 }
 
-set env(GIT_DIR) $_gitdir
-set env(GIT_WORK_TREE) $_gitworktree
+# Export the final paths
+set_gitdir_vars
 
 ######################################################################
 ##
@@ -2010,7 +2024,7 @@ proc incr_font_size {font {amt 1}} {
 
 proc do_gitk {revs {is_submodule false}} {
 	global current_diff_path file_states current_diff_side ui_index
-	global _gitdir _gitworktree
+	global _gitworktree
 
 	# -- Always start gitk through whatever we were loaded with.  This
 	#    lets us bypass using shell process on Windows systems.
@@ -2020,8 +2034,6 @@ proc do_gitk {revs {is_submodule false}} {
 	if {$exe eq {}} {
 		error_popup [mc "Couldn't find gitk in PATH"]
 	} else {
-		global env
-
 		set pwd [pwd]
 
 		if {$is_submodule} {
@@ -2049,13 +2061,11 @@ proc do_gitk {revs {is_submodule false}} {
 			# TODO we could make life easier (start up faster?) for gitk
 			# by setting these to the appropriate values to allow gitk
 			# to skip the heuristics to find their proper value
-			unset env(GIT_DIR)
-			unset env(GIT_WORK_TREE)
+			unset_gitdir_vars
 		}
 		safe_exec_bg [concat $cmd $revs "--" "--"]
 
-		set env(GIT_DIR) $_gitdir
-		set env(GIT_WORK_TREE) $_gitworktree
+		set_gitdir_vars
 		cd $pwd
 
 		if {[info exists main_status]} {
@@ -2078,21 +2088,16 @@ proc do_git_gui {} {
 	if {$exe eq {}} {
 		error_popup [mc "Couldn't find git gui in PATH"]
 	} else {
-		global env
-		global _gitdir _gitworktree
-
 		# see note in do_gitk about unsetting these vars when
 		# running tools in a submodule
-		unset env(GIT_DIR)
-		unset env(GIT_WORK_TREE)
+		unset_gitdir_vars
 
 		set pwd [pwd]
 		cd $current_diff_path
 
 		safe_exec_bg [concat $exe gui]
 
-		set env(GIT_DIR) $_gitdir
-		set env(GIT_WORK_TREE) $_gitworktree
+		set_gitdir_vars
 		cd $pwd
 
 		set status_operation [$::main_status \
-- 
2.54.0.99.14

