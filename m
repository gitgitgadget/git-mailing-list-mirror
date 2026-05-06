Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0037FF66
	for <git@vger.kernel.org>; Wed,  6 May 2026 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099358; cv=none; b=oFLbkgCXPc+jJg+aM2sEi+qKX8ry0J6SL+cNxBWZ2eA8JhlJxwF+gjB6K4urUDaa3VumeStWi7f47yhMKsd7/ACZd56xkgSw90wDzl7bMZlPzFZ3d3Yd1pbGRHL0jEK4/AOrhPNNtQ0Odi57BOoAgWCAEgpyrtwSluJ3o1E5uJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099358; c=relaxed/simple;
	bh=e2S3rgTGlng4xcW0aciz1+LVhYvK0Z5dn+Hsp/sk3DI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GXUm8Fj8ArQ8HaatIR/5RhM21ZrO2Gw8kqdR3IBDybcXBT9oM8CeWphLuoH+uPYfntbgm9lKh9e6OeZ6Rwiagpf61X6/IypZpF6ThKCxvUZqJcv7QMTxGemqxmYAATtC8dzBBg6xxLMr5gLkvH0yQi5/u4lln8oRG8KJvp00p7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=H8TmbNqP; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="H8TmbNqP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778099343;
	bh=oB5T9WGgGd29IGFrJ22eR0GaSHlIZ74uyl4lvgKisoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H8TmbNqPQMSwtkyOsRR84aqCzNAnhED0qrM47oRJjZDqStYzAPNW+VXALUjlldHTs
	 Nz8HLquHiCXMp6dAZNbH39u+SWG/bPMFa0S96ivJQGQgsDApe3sMiijhYimMgQIOJi
	 4BDDd6zOYvslV4tIXOucYcdwB58guuDLu1gupCY4=
Received: from DESKTOP-31CF0TC ([58.209.116.75])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 72BB2671; Thu, 07 May 2026 04:28:43 +0800
X-QQ-mid: xmsmtpt1778099340tpkraik69
Message-ID: <tencent_16BC933B6ECB562A74F4EE334828A2D23605@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqfBTBXS99olIxzJrI2km2IQWfsGBduioiTOITKdiJx7LE3AoG7ao
	 h0MENw4drft2rl0JEaGMBRKTNjeI13CVoj0dZlDDgAs5p7eeCzQZXk66qffx2q483KkuZqexj9wA
	 X4HuV4dD06e4yTuBiDY/Y2v0ZlxVILFRkBYB34zrzjjTFOxbIludmKBKuz4Bqt3jVNdZrJiBywTA
	 76yPy5mxJAs3OXm+vZV4zgvymgf6ZCVYuvNUSIdQTI3HZl20Hc1BWaq09FgJDfz9CZgae6i/Qslr
	 VOD5tH3zxYzGcZ5OUezaO6RZ3huGGHBk+Ra9/UqD5ue2bLLHL6X5mWAUXu1xMPpsjm7t2WyESxhY
	 xMAE8Xax88RVpaWgXTjwN/F15RpQJGN22fmyK23vJ/b4WvmhwsikdPGoST9TU8y/ADlmqgfmLj6e
	 TWx6Lm8SfTlBa6epeYEO5H/9/CYrc2bL5ymNPva0WeaQ2m76Td8Q/b08ilwt81ommk4D4qBlu5CO
	 eiXgIKKZOdksmt0jAzUTEjl15Q21QKTe7cL/7VY0Jkyi6hZhSiwgeB/cLyMwyfhFNEEYdHLIYVSl
	 hZAviH8NMA78YB3xjJSPJRJitbkK0tgIDOfkGETeefmy5i+vtsz11PxTrv/m33s61HRNj250hp9+
	 771tdHaB+9bMPknR8rkCw5jlS/xD3ZjlY4OCccQPqsLsFLe+NJ9tlEY4XbY4DY2SVdt3kHxdVtPv
	 m/4QYVVrq/VsZFAr+MxB5Wrnx+KLRPL7fc1uXfA/KqXAh7P1Ozxcjd6gsVP5YZ5QE/z5UTTBh8NA
	 usVpf+ldx2HhNiyvhQOSnJFQLTaR1sumcoYX65QRsdoFgDS2ambBCglsoGjOnlm2X11by/fVYykr
	 /weAbX+rGxRS1IeCK5mAyzQ0vX0pkfHr/Y0yixxrzTlojUeKMu6PREljyy3oeb6TksBlv7CAaB/C
	 OYogFKDNjP2+EiJSnH3397U/I10b1W8HNdfeHNaa+7NBQXCbvSJArkU4hEXbUBMxY4SBGWgmXLKy
	 W81k8H6i33BvceGXRqbeGjG5wascWORod0Inw6M1f1PLxNm4CAFrqsEiVDKvs=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Shroom Moo <egg_mushroomcow@foxmail.com>
Subject: [PATCH v6 3/3] git-gui: handle GIT_DIR and GIT_WORK_TREE early
Date: Thu,  7 May 2026 04:27:51 +0800
X-OQ-MSGID: <20260506202751.3294-4-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260506202751.3294-1-egg_mushroomcow@foxmail.com>
References: <tencent_78B80FB7A0A42E464B3EF1841E2AF3C39509@qq.com>
 <20260506202751.3294-1-egg_mushroomcow@foxmail.com>
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
  inherit it.

- At the end of startup, only export GIT_DIR.  The current directory
  is already at the top of the worktree (when a worktree exists), so
  Git can discover the worktree automatically.  Not exporting an
  empty GIT_WORK_TREE fixes `git gui blame` in bare repositories.

When only GIT_DIR is set without GIT_WORK_TREE, the existing logic
remains unchanged for backward compatibility.  Setting only
GIT_WORK_TREE is not a valid Git use-case and is silently ignored.

Helped-by: Mark Levedahl <mlevedahl@gmail.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
---
 git-gui/git-gui.sh | 84 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 18 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 1191e6654c..ca651dc576 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1122,25 +1122,69 @@ unset argv0dir
 ##
 ## repository setup
 
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
+		unset env(GIT_WORK_TREE)
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
@@ -1228,7 +1272,11 @@ if {[lindex $_reponame end] eq {.git}} {
 
 # Export the final paths
 set env(GIT_DIR) $_gitdir
-set env(GIT_WORK_TREE) $_gitworktree
+# Do not export `GIT_WORK_TREE`. The current directory is already
+# the top-level of the working tree (if it exists), and Git will
+# automatically identify the working tree. For bare repositories,
+# `_gitworktree` is empty, and exporting an empty value would cause
+# commands like `git branch --show-current` to fail
 
 ######################################################################
 ##
-- 
2.52.0.windows.1

