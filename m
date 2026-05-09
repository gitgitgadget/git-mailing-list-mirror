Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D593932E0
	for <git@vger.kernel.org>; Sat,  9 May 2026 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334265; cv=none; b=rYbVwz55+KQ/6UYXDqgQXyfE8Jkqi1zgjDXVMESvTVFuVns2jrhbfCxsiKHv7ciYs4ugUr4ZnpjDvhZ15GP7TkwmCbap8OrPyzw18Re4l+Zacuecp90/Gp/fIg+oa/3YsNK2r42jqkxgliLFeBHuzpP6mKX3UoX4JbuUmp2BArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334265; c=relaxed/simple;
	bh=QT5zd9XaAyOWygfHesYxr3AQiSD6FUZcMiahhWUsSt0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3s/4qvaeziW8169eLHICv88HKVwEB/xQO/7vg5MnGYka6cEmCeodyvE3PAQRUGEUTlaATAqgNHCwk2W0g8gbAJJSWmDXbplvGzNGzbvoeNLxiKAOom5CSD6vmsiilUq9tX9bgU8exMOhPg6WCLP0RDuVbTJcvuIlBCb1auW+Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=jBi6I0Tx; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="jBi6I0Tx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778334252;
	bh=LrGRyDtBiVtT3mLAyz2G53UiIBnGEt0IoczI75mgbAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jBi6I0TxC9T0tNp+VIRVK/QYyeCGRMS5RTKBjmMiL0wgOa3qQTuI6UwIL4eclWhJj
	 fIDYp9xVsgFhx1E7P83SN/Pqc71lYFBbuqcSgwR8i5qm0pFxvAimVTk6TCcp5mjtIO
	 G2rrpU9a2p1h1KddQZOan/pNkgBQcmyMV7RVX8UA=
Received: from localhost.localdomain ([58.209.116.75])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id B052222E; Sat, 09 May 2026 21:44:05 +0800
X-QQ-mid: xmsmtpt1778334247t6wzzzicj
Message-ID: <tencent_2D0A6C14E8B34348B6F236BC8E7B66AB5105@qq.com>
X-QQ-XMAILINFO: M1h92L4NZssZ4VkxBW9L+2O2ecVqZ6XpWpfbQyWfoLiCPu5iCeUrB0GC4OWr/D
	 oCbOq7EQ/EXC0G4AUvn2bbeg0PgUHk0pphzMTrbY+LOcBLgrnULI7d0UPXmrCBc9BxfrNT1fp995
	 hQ2t7NvPuCkIbMDBAVE9UsIxGonhXeveM2y+yhnTqKYUIjI9Jmq7fzzC38RD4wcmb2vTXdIt3oeI
	 gxzghzoxg72uoudPI1S1kx6xdIEzMGgROUzUGIGXa2RZmyBIZeTJBJDT6L2hBj+gINk0dEB82seP
	 hEhXvUBKwysatQNXu1y6E+xOXj2QgS1/OZyLpKgpSo7o9T17TF2qTAbGtjyRQnnOKfkCMlgHQm0d
	 jlBXuyFll1vfKqgIuVIvXTuyjcVhHGbqTdkXHhI62mT8iLB/o0LdzTeN9qUdTOcT+tygCT/oSpVO
	 zX/dwFe/NVuAopYbJB92rfyhsyZsxSiKqWDCvw6EYlNpD4WPmJKptgwCO9Frf//8hfoM/vx9amyp
	 2NYMjMk8C4tyNaKj6VixD3VvuKq+JWG832js3yECJ9jHyL0drXxFzYEdhiSto5oSqs1628vnt6h6
	 G9xVEmX/yonKnwAiQYIKka9xuNrOaoG/P96qwTdoPbygKon5o8RxcFr83Xi+wfQwPGzJBPzS8hxP
	 I5HWY3X/8n3ava19ClC/y65EAFgOr8+74cexadlTlaQ0qXA5IGspZ8zWqe50kffkfH33YPT/THeN
	 KECrM7KaITUmKSVLOg03OmOv5xm8uND0MhXfYqgqAJEOpnMu1ecWZz56+cDGhJgQg3PVz/v/cTaV
	 /6sqvszyqDV2zVC4okr9LLcTzTXPtf91Y5wyVw/mdG+C7HnhkKe13+29I1qy/SzsHnA2YstuEpvv
	 jwE528zB3cpEvXTxDOGTwcJBzx98ugBOs99GoGadDgqydOr/SF7fcqZ8frrHLzRck5mkb3iWg8Hk
	 U5jOCYAXivvljV3QW9d0k4BPYfSlpv2/zBOpC+f7TdNj/LFdPcYBTmKPG8PmNhYBNr32FWfswryA
	 hNUftqUUbH0wDHa1r2GtjGVMgF4MfzZNNh5/qG6H7/I7qBkxCG2F3zFVEk8u5rx3xv7Vh5tbmDQt
	 CgYJbRPLr/theDifo=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Aina Boot <bootaina702@gmail.com>,
	Shroom Moo <egg_mushroomcow@foxmail.com>
Subject: [PATCH v7 1/3] git-gui: restructure repository startup
Date: Sat,  9 May 2026 21:37:53 +0800
X-OQ-MSGID: <20260509133756.1367-2-egg_mushroomcow@foxmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When git-gui is started inside a .git directory of a non-bare
repository, it should treat the parent directory as the worktree,
as it did before commit 2d92ab32fd (rev-parse: make --show-toplevel
without a worktree an error, 2019-11-19).  However, a bare repository
or a separated gitdir without a worktree must be rejected early.

Protect the previously unguarded calls to `git rev-parse
--show-object-format` and `--show-toplevel`.  Restructure the startup
sequence to:

- Check for a bare repository right after loading the config.  If the
  repository is bare and the current subcommand does not allow bare
  repos (e.g. normal commit mode), show "Cannot use bare repository"
  and exit.

- When `rev-parse --show-toplevel` fails and the repository is
  non-bare, the gitdir path ends with ".git", and we are inside that
  gitdir, use the parent directory as the worktree.  This preserves
  the ability to start git-gui from within a regular repository’s
  .git directory, which was intentionally supported since 87cd09f43e56
  (git-gui: work from the .git dir, 2010-01-23).

- Otherwise, show a descriptive error and exit.

- Wrap `rev-parse --show-object-format` in a catch to avoid a crash
  when the repository configuration is broken (e.g. core.worktree
  pointing to an invalid path).

Also removes the old `_prefix`‑based fallback that computed a relative
path to the worktree top from a subdirectory, and the unconditional
`[file dirname $_gitdir]` guess.  Both are unnecessary now that
`rev‑parse --show‑toplevel` directly provides the absolute top‑level
path and we can `cd` to it.  The guess is further unsafe in
multi‑worktree setups, where a gitdir may have more than one worktree.
The only remaining fallback is the explicit “.git directory” rule for
non‑bare repositories, which mirrors the historical behaviour.
Additionally, only export GIT_WORK_TREE when it is not empty, to avoid
confusing commands in bare-repository subcommands.

This fixes the fatal Tcl error when the working tree is missing, while
keeping the .git startup feature and avoiding any automatic directory
switching that could be dangerous in multi‑worktree setups.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Helped-by: Mark Levedahl <mlevedahl@gmail.com>
Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
---
 git-gui/git-gui.sh | 76 ++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 27 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 23fe76e498..9eb93a76b5 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1129,7 +1129,8 @@ if {[catch {
 		}]
 	&& [catch {
 		# beware that from the .git dir this sets _gitdir to .
-		# and _prefix to the empty string
+		# and _prefix to the empty string; this is handled by
+		# the startup safety checks below
 		set _gitdir [git rev-parse --git-dir]
 		set _prefix [git rev-parse --show-prefix]
 	} err]} {
@@ -1142,8 +1143,20 @@ if {[catch {
 	set picked 1
 }
 
+if {![file isdirectory $_gitdir]} {
+	catch {wm withdraw .}
+	error_popup [strcat 
+		[mc "Git directory not found:"] "\n\n$_gitdir\n\n" \
+		[mc "Please ensure GIT_DIR points to a valid Git repository"]]
+	exit 1
+}
+
 # Use object format as hash algorithm (either "sha1" or "sha256")
-set hashalgorithm [git rev-parse --show-object-format]
+if {[catch {set hashalgorithm [git rev-parse --show-object-format]} err]} {
+	catch {wm withdraw .}
+	error_popup [strcat [mc "Failed to determine hash algorithm:"] "\n\n$err"]
+	exit 1
+}
 if {$hashalgorithm eq "sha1"} {
 	set hashlength 40
 } elseif {$hashalgorithm eq "sha256"} {
@@ -1160,46 +1173,52 @@ if {$_gitdir eq "."} {
 	set _gitdir [pwd]
 }
 
-if {![file isdirectory $_gitdir]} {
-	catch {wm withdraw .}
-	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
-	exit 1
-}
 # _gitdir exists, so try loading the config
 load_config 0
 apply_config
 
-set _gitworktree [git rev-parse --show-toplevel]
-
-if {$_prefix ne {}} {
-	if {$_gitworktree eq {}} {
-		regsub -all {[^/]+/} $_prefix ../ cdup
-	} else {
-		set cdup $_gitworktree
-	}
-	if {[catch {cd $cdup} err]} {
+# Handle bare repository and determine working tree
+if {[is_bare]} {
+	# Bare repository: only allowed for certain subcommands
+	if {![is_enabled bare]} {
 		catch {wm withdraw .}
-		error_popup [strcat [mc "Cannot move to top of working directory:"] "\n\n$err"]
+		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n" [file normalize $_gitdir]]
 		exit 1
 	}
-	set _gitworktree [pwd]
-	unset cdup
-} elseif {![is_enabled bare]} {
-	if {[is_bare]} {
-		catch {wm withdraw .}
-		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n$_gitdir"]
-		exit 1
+	# Allowed bare repo does not have a worktree
+	set _gitworktree {}
+} else {
+	# Non-bare repository: we must find a worktree
+	if {[catch {set _gitworktree [git rev-parse --show-toplevel]} err]} {
+		# The only acceptable failure is when we are inside
+		# the .git directory of a regular repository.
+		set inside_gitdir 0
+		catch {set inside_gitdir [git rev-parse --is-inside-git-dir]}
+		if {$inside_gitdir eq {true} && [file tail $_gitdir] eq {.git}} {
+			# Use the parent directory as worktree (historic behavior)
+			set _gitworktree [file normalize [file dirname $_gitdir]]
+		} else {
+			catch {wm withdraw .}
+			error_popup [strcat [mc "Cannot determine working tree:"] "\n\n$err"]
+			exit 1
+		}
 	}
+
 	if {$_gitworktree eq {}} {
-		set _gitworktree [file dirname $_gitdir]
+		catch {wm withdraw .}
+		error_popup [mc "Cannot determine working tree (unexpected empty result)"]
+		exit 1
 	}
+
 	if {[catch {cd $_gitworktree} err]} {
 		catch {wm withdraw .}
-		error_popup [strcat [mc "No working directory"] " $_gitworktree:\n\n$err"]
+		error_popup [strcat [mc "Cannot move to working directory:"] "\n\n$err"]
 		exit 1
 	}
 	set _gitworktree [pwd]
 }
+
+# Derive a human-readable repository name
 set _reponame [file split [file normalize $_gitdir]]
 if {[lindex $_reponame end] eq {.git}} {
 	set _reponame [lindex $_reponame end-1]
@@ -1207,8 +1226,11 @@ if {[lindex $_reponame end] eq {.git}} {
 	set _reponame [lindex $_reponame end]
 }
 
+# Export the final paths
 set env(GIT_DIR) $_gitdir
-set env(GIT_WORK_TREE) $_gitworktree
+if {$_gitworktree ne {}} {
+	set env(GIT_WORK_TREE) $_gitworktree
+}
 
 ######################################################################
 ##
-- 
2.52.0.windows.1

