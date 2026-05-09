Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F03939C1
	for <git@vger.kernel.org>; Sat,  9 May 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334272; cv=none; b=om32J6aQBNG7jMAXbRhZ0UAP5NfI7jrmlqqeaAzy7IakMIPOllwvGxSb1gzJidFTNh1URloSH5YcJDcUAKehWuoNG3CgSISPtKcBEldNP3Yra22RXOaZhdyId4hCyVPtOxS8d7x8gxBs7StAHuZgkXTRz22CZqGl29WrdCCU88Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334272; c=relaxed/simple;
	bh=vG9akcKZU0669d4kF2A8zTObbC/6qQQnhORYSaK041I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Nq6J9lUWk7FF02jp191r4eLfpn6UwnBH4ABOLwoBln8tROjOHOWM9MynwZ045JaHSVLBaswWzfHkufmkYdn3rsZC1FwqbLC/UomlavAq9igSF5MMGZmaLEzAHBR7ha7vNnSSkWYlHEdUKPCceq+DQnlVK0IjChjk5MQF/Fw63tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=HAXP0yCV; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="HAXP0yCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778334259;
	bh=NEWj80+CfcbtZViydu0O4AKH5c2WI6IILA2YMrAPppw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HAXP0yCVoIJfVKaNmglXx6GvdwzrobMjLJk1WyHuUUEj5q929HW+BBfHMpIFQBfGO
	 LrrEB9tXQGu/HikH5LJmnLbS9SncU/3qif06cYDwoR1H0+TW+uFctJk7IXAtpmyb7s
	 89DYarNp9yPL87DGEAJ9ZDTO1+porJLKaa4trsRE=
Received: from localhost.localdomain ([58.209.116.75])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id B052222E; Sat, 09 May 2026 21:44:05 +0800
X-QQ-mid: xmsmtpt1778334256t3qro3hej
Message-ID: <tencent_C4AD92361C8D7B76EB4C8A6F14EA33496805@qq.com>
X-QQ-XMAILINFO: MWB4vRr41pZmaJLAGpnfHr+z3UjZ88gHO8B24ydADI40AfIM7p6gLr0hpCMmBn
	 y4fcJ3w4SwVZh/0XHOWChUWxclcP/MsHETY67qhsAR4yIZIR23YppBvODt6axXQk06Lj7DBBZ3h9
	 rz5+vShYuEerzD9TWuBKacW+MZFDCzxnZB4tHaGT6Jiv1U8DLxdzMumTrlWN3iWrSHPvrYWHuezT
	 ScnZoSpxpGPL35PS1PjAwmtN4hMO3HZAXoqVuUDCTxw+lDl0ZNjr2SxfDKeTep+B+MsMTefhsiHL
	 q6Hx4yWHe2eq9CLc37gsWSqhlDVPvE/lwjmySjQLQz7YX8ZDVM3YY6LyzRHQtCmoXTUPsiLfH1vb
	 Iaz/cc3+cmFNA9rdFPsUtRZdLY13upLySziNtwSPKGZD1QLfVvvcMD/dDLxlZS3dtE38ep1FCvyZ
	 9TStakubDvUS+K10cn2S2eRtaQAwSQA4nkNzHwZQy8BaY+T5PmnhlRCY8vn3hMhx5MSyIPVrj/K0
	 mWihOGuKkqGtQOA318u3KaDbH3W6EiPRQeuT6t+sd7R8sH9pJ6PECoMYYbEb+LEwbPP1Pqnxez0M
	 efvrwmlJYE24e+8TLEDT5kq0Su1D3S9fBCAu9VY09rfyoZdKsXe1q32CkSt8RuAJurcy1VVwdPqs
	 wml1eE17MlEBMhvnteAsyIDx/QABKd9q4yljtGCuj8f/42hz2MpliHVcwBN1qCO+VEYZ4TTTAkmE
	 Bwu0R+fgHOObDWjH0ZRrEV05EvZeArLzTWmLuDADvlw+8T33CoGkT2LqXiWI2Vqn5mDfdeVDYBNs
	 GLaVJ573mGHDnT+QnXtQMhFuSSofFTOcFTGwxcXvtjFee/4Ybzowz/82ab8NRubERvX45+E66GLB
	 r5TLZSYua413pV8BX+oW2P05fl8EOnmz3Q8MwQd5hz2m3Fw5K/mxNbIECOWNNoQsg/bx1JG4pdrL
	 wQRe3pP5+DCYNz4eRSxEmJY31IE8qb97H+vYALXly9xHm7T8oekuly7ZlFElngPW2terZG7zhvTV
	 eiFhGSDduo73DUrMUnv2DM+EdQHA5yWU+DoNbkSY+R7GPqJXHT5JQFOprnMDM=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Aina Boot <bootaina702@gmail.com>,
	Shroom Moo <egg_mushroomcow@foxmail.com>
Subject: [PATCH v7 3/3] git-gui: handle GIT_DIR and GIT_WORK_TREE early
Date: Sat,  9 May 2026 21:37:55 +0800
X-OQ-MSGID: <20260509133756.1367-4-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20260509133756.1367-1-egg_mushroomcow@foxmail.com>
References: <tencent_DDD6467B3F6184562B51C23BB9DBB79EA409@qq.com>
 <20260509133756.1367-1-egg_mushroomcow@foxmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users expect these two invocations to be equivalent:

    GIT_WORK_TREE=/some/path GIT_DIR=/some/path/.git git gui
    git -C /some/path gui

Currently, the environment variable variant often brings up the
repository picker or ignores the requested worktree because
GIT_WORK_TREE is processed too late.  Moreover, after determining
the working tree, git-gui unconditionally exports GIT_WORK_TREE.
When no worktree is found (e.g., in a bare repository with a
read-only subcommand like blame), an empty value is exported, which
confuses commands like `git branch --show-current`.

Fix both issues:

- Introduce resolve_initial_environment, which is called before any
  repository detection.  When both GIT_DIR and GIT_WORK_TREE are
  set, it changes to the specified worktree, verifies that it is a
  valid worktree, and adopts the given GIT_DIR.  In this case, the
  subsequent automatic detection is skipped.  After successful
  validation, GIT_WORK_TREE is unset so that later steps do not
  inherit it.  Export the absolute GIT_DIR before changing directory
  to ensure Git commands see the intended repository.

- Introduce set_worktree_env and unset_worktree_env helper procedures
  to safely manage the GIT_WORK_TREE environment variable:
  set_worktree_env sets it only when $_gitworktree is non-empty,
  and unset_worktree_env removes the variable without error.
  Replace all direct manipulations of GIT_WORK_TREE with these
  helpers to avoid accidentally exporting an empty value or
  causing 'unset' errors.

- At the end of startup, use set_worktree_env instead of exporting
  GIT_WORK_TREE unconditionally.  This leaves the variable unset
  when no worktree exists (bare repository), fixing commands that
  would fail with an empty GIT_WORK_TREE.

When only GIT_DIR is set without GIT_WORK_TREE, the existing logic
remains unchanged for backward compatibility.  Setting only
GIT_WORK_TREE is not a valid Git use-case and is silently ignored.

Helped-by: Mark Levedahl <mlevedahl@gmail.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
---
 git-gui/git-gui.sh | 103 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 24 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index ff022c5bbb..1123f9855b 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1122,25 +1122,82 @@ unset argv0dir
 ##
 ## repository setup
 
+# Safely set/unset GIT_WORK_TREE
+proc set_worktree_env {} {
+    global _gitworktree
+    if {$_gitworktree ne {}} {
+        set ::env(GIT_WORK_TREE) $_gitworktree
+    }
+}
+
+proc unset_worktree_env {} {
+    catch {unset ::env(GIT_WORK_TREE)}
+}
+
+proc resolve_initial_environment {} {
+	global _gitdir env
+
+	# Only act if both GIT_DIR and GIT_WORK_TREE are set
+	if {[info exists env(GIT_DIR)] && [info exists env(GIT_WORK_TREE)]} {
+		# Validate GIT_DIR by resolving its absolute path
+		if {[catch {set _abs [git rev-parse --absolute-git-dir]} err]} {
+			catch {wm withdraw .}
+			error_popup [strcat [mc "Invalid GIT_DIR:"] "\n\n$err"]
+			exit 1
+		}
+		set env(GIT_DIR) $_abs
+
+		# Change current directory to GIT_WORK_TREE
+		if {[catch {cd $env(GIT_WORK_TREE)} err]} {
+			catch {wm withdraw .}
+			error_popup [strcat [mc "Cannot change to GIT_WORK_TREE:"] "\n\n$err"]
+			exit 1
+		}
+
+		# Verify that GIT_WORK_TREE is a valid Git worktree
+		if {[catch {git rev-parse --show-toplevel} err]} {
+			catch {wm withdraw .}
+			error_popup [strcat [mc "GIT_WORK_TREE is not a valid worktree:"] "\n\n$err"]
+			exit 1
+		}
+
+		# Use repository path specified by environment variables
+		set _gitdir $_abs
+		set ::_prefix {}
+
+		# Unset GIT_WORK_TREE to prevent it from being inherited by child processes
+		unset_worktree_env
+
+		return 1
+	}
+
+	# Other cases (only GIT_DIR, only GIT_WORK_TREE, or neither):
+	# Do nothing here and let the existing logic handle it later
+	return 0
+}
+set force_gitdir [resolve_initial_environment]
+
 set picked 0
-if {[catch {
-		set _gitdir $env(GIT_DIR)
-		set _prefix {}
-		}]
-	&& [catch {
-		# beware that from the .git dir this sets _gitdir to .
-		# and _prefix to the empty string; this is handled by
-		# the startup safety checks below
-		set _gitdir [git rev-parse --git-dir]
-		set _prefix [git rev-parse --show-prefix]
-	} err]} {
-	load_config 1
-	apply_config
-	choose_repository::pick
-	if {![file isdirectory $_gitdir]} {
-		exit 1
+if {!$force_gitdir} {
+	if {[catch {
+			set _gitdir $env(GIT_DIR)
+			set _prefix {}
+			}]
+		&& [catch {
+			# beware that from the .git dir this sets _gitdir to .
+			# and _prefix to the empty string; this is handled by
+			# the startup safety checks below
+			set _gitdir [git rev-parse --git-dir]
+			set _prefix [git rev-parse --show-prefix]
+		} err]} {
+		load_config 1
+		apply_config
+		choose_repository::pick
+		if {![file isdirectory $_gitdir]} {
+			exit 1
+		}
+		set picked 1
 	}
-	set picked 1
 }
 
 if {![file isdirectory $_gitdir]} {
@@ -1228,9 +1285,7 @@ if {[lindex $_reponame end] eq {.git}} {
 
 # Export the final paths
 set env(GIT_DIR) $_gitdir
-if {$_gitworktree ne {}} {
-	set env(GIT_WORK_TREE) $_gitworktree
-}
+set_worktree_env
 
 ######################################################################
 ##
@@ -2077,12 +2132,12 @@ proc do_gitk {revs {is_submodule false}} {
 			# by setting these to the appropriate values to allow gitk
 			# to skip the heuristics to find their proper value
 			unset env(GIT_DIR)
-			unset env(GIT_WORK_TREE)
+			unset_worktree_env
 		}
 		safe_exec_bg [concat $cmd $revs "--" "--"]
 
 		set env(GIT_DIR) $_gitdir
-		set env(GIT_WORK_TREE) $_gitworktree
+		set_worktree_env
 		cd $pwd
 
 		if {[info exists main_status]} {
@@ -2111,7 +2166,7 @@ proc do_git_gui {} {
 		# see note in do_gitk about unsetting these vars when
 		# running tools in a submodule
 		unset env(GIT_DIR)
-		unset env(GIT_WORK_TREE)
+		unset_worktree_env
 
 		set pwd [pwd]
 		cd $current_diff_path
@@ -2119,7 +2174,7 @@ proc do_git_gui {} {
 		safe_exec_bg [concat $exe gui]
 
 		set env(GIT_DIR) $_gitdir
-		set env(GIT_WORK_TREE) $_gitworktree
+		set_worktree_env
 		cd $pwd
 
 		set status_operation [$::main_status \
-- 
2.52.0.windows.1

