Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195723DF000
	for <git@vger.kernel.org>; Mon,  4 May 2026 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906809; cv=none; b=lG4jX9hOLLKXX9i2fzRug4b/ByVqmOC7HbQYxP8DvSBHWThvNW7Zs0FR2dQKndWRkfL/tbtfVa18JTfNm6875wZYj9xFy1gCpwWIChSTinbJzJAKs/x7VYm2c7Shymn7q+L5stYS+uExEaeGQ179+TN157x/4EJaKWzVPJNiL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906809; c=relaxed/simple;
	bh=yA5pKPMzKcBT6e1NQgAjIJ4cKZ+ll5BOeC1pOf/qQVw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pf2xMgnOIg+imwldQ+noRZc15S0/5cphr8IZmKF12MZU9EtulJtnSv/NzKAF0FjWVGh/Szq0luz/k37sO9sV0E7ZsVkgAK6pxd/QIkFICwezSwabqKHgOi2q0jTsGOPW6CCLZN2UnUKjCNKA71Wtdm53IVaRVX6t6XHN/BKvYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MCvsi811; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MCvsi811"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1777906794;
	bh=MBxFwUto8e0ZXU6aebTozKjlqPIdJov0WeMUSRWNDxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MCvsi8113A6PFedvJd/RfTW4zw4bVCu47dw7Iv1WNgUoQwSkOdrFZAZLfyGehvjRe
	 PHZrPyPftfXf8E1DuBh1MkaWXIKoP8I8qa/V2uNsg/nI7BhxYLntuohtMUc4bRhmZp
	 ZTFyAmw0frau8qodf+QQSCOglE3ZnsYhyqQSOtBc=
Received: from DESKTOP-31CF0TC ([58.209.116.75])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id EE1B7CF2; Mon, 04 May 2026 22:59:33 +0800
X-QQ-mid: xmsmtpt1777906773txb9q7o8h
Message-ID: <tencent_78B80FB7A0A42E464B3EF1841E2AF3C39509@qq.com>
X-QQ-XMAILINFO: Oencu6XjqQ7i/Ouaj71/V4RJ0JG56o37m2sz6xWxf0zYJnvddbFglhIKWDyTeS
	 wOgCM+FRalhnIxuTjvu3Iw0W5dl74lWCLChp4bL14UGcRLYIuH96otaSJhi2U+Y8Wxtqies9IIX2
	 PXorDWFtH+ZuwXPcKaRWwRN7aV618qgS7C6aRkd7/buwMX69JlKvXbVHbEt7w2X0Do7g2t30UiRz
	 qfKRdtJsr6hAVkDI0oLa/O+2sqzRvCbWCBRQYQ9szTY4CmJoMzjkNb2cVLm7ObkHzxe5K6LLXlFZ
	 ges0edEMWPZvkqtvgoxRHu/k5hX5TOcQv8onBYw3PFI4caLyozKyZUOipq38XNTt4TrPoAo4ciA6
	 SsUxi+vOQ37Fy3hMyyBqYqsmX7bFfZNItN8+AhUfvTt3Nf/o7pmxT4KYMhGTutdLuHDCpXbBVh2b
	 vbtFtXb0YpkeyBULbdlt2xvtNMfjw9S/g4zDCxU9h9GlXAwhIkS8iA06tYn8V0FnN6+jSSThzvui
	 u5FMGqUoPknnuELyNoNrb3iWS9QAtlBjMdKS+YXpRpCQCzTuhf0021bAF0Pl4bj8IxOSQVrUcdZi
	 z4rJlSkPLuj0N8cOqHUyJDuYZJOmwskqgUfebEXgioDVjJZ+cYbyAuFqXhOevcKbI+KumhhICnMl
	 BWkfFdqHdSCKu7HIWYlqbIhOuFCGb8OQlnQdjG1iTa4t5QSCku6eb8Jd8WmVNsnmqStJHRxm3Lt0
	 eazDLLAtZi4i+fGsm24jMlbAfTdLBelRchW/K3v3XEFY32o8nk8kpOlTPAkO7kFd30Y5HMDW5nTO
	 G59GxViurVR1KZ8Nlq4xGPW6AU6c9Za8tx/n+0h8Nf/5aYj4F3l3KaSmhBCAz+hzTJt7lZvKs5p3
	 JAyU9jhWE3GIR3ZKSXbycr3hAb7Z3mYR1kE0TjEMp/rykFCk4H1u8Umh3nWOsVoCcgzFVQiZMaP5
	 jrnrK3Azu1MxF7HMgUemitK8GR8LyHfiXV4Zd7L1YAq6thDTAsuEsN4use63qScv1LyxRSh62JrN
	 rjLZcdT2l4QvHxDW/J5fchs+HoCvslD7im7YwYPQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Shroom Moo <egg_mushroomcow@foxmail.com>
Subject: [PATCH v5 1/1] git-gui: restructure repository startup
Date: Mon,  4 May 2026 22:59:19 +0800
X-OQ-MSGID: <20260504145920.3071-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <tencent_277823B7C5D69914E168E5679A907C655606@qq.com>
References: <tencent_277823B7C5D69914E168E5679A907C655606@qq.com>
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

This fixes the fatal Tcl error when the working tree is missing, while
keeping the .git startup feature and avoiding any automatic directory
switching that could be dangerous in multi‑worktree setups.

Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
---
 git-gui/git-gui.sh | 72 +++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 23fe76e498..c06d85b8d9 100755
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
@@ -1160,46 +1173,50 @@ if {$_gitdir eq "."} {
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
+# Handle bare repository early: if not allowed, abort
+if {[is_bare] && ![is_enabled bare]} {
+	catch {wm withdraw .}
+	error_popup [strcat [mc "Cannot use bare repository:"] "\n\n" [file normalize $_gitdir]]
+	exit 1
+}
 
-if {$_prefix ne {}} {
-	if {$_gitworktree eq {}} {
-		regsub -all {[^/]+/} $_prefix ../ cdup
-	} else {
-		set cdup $_gitworktree
-	}
-	if {[catch {cd $cdup} err]} {
-		catch {wm withdraw .}
-		error_popup [strcat [mc "Cannot move to top of working directory:"] "\n\n$err"]
-		exit 1
+# Determine the working tree
+if {[is_bare] && [is_enabled bare]} {
+	set _gitworktree {}
+} else {
+	if {[catch {set _gitworktree [git rev-parse --show-toplevel]} err]} {
+		# If we are inside a .git directory of a non-bare repo,
+		# the worktree is the parent directory
+		set inside_gitdir 0
+		catch {set inside_gitdir [git rev-parse --is-inside-git-dir]}
+		if {![is_bare] && $inside_gitdir eq {true} && [file tail [file normalize $_gitdir]] eq {.git}} {
+			set _gitworktree [file normalize [file dirname $_gitdir]]
+		} else {
+			catch {wm withdraw .}
+			error_popup [strcat [mc "Cannot determine working tree:"] "\n\n$err"]
+			exit 1
+		}
 	}
-	set _gitworktree [pwd]
-	unset cdup
-} elseif {![is_enabled bare]} {
-	if {[is_bare]} {
+
+	if {$_gitworktree eq {}} {
 		catch {wm withdraw .}
-		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n$_gitdir"]
+		error_popup [mc "Cannot determine working tree (unexpected empty result)"]
 		exit 1
 	}
-	if {$_gitworktree eq {}} {
-		set _gitworktree [file dirname $_gitdir]
-	}
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
@@ -1207,6 +1224,7 @@ if {[lindex $_reponame end] eq {.git}} {
 	set _reponame [lindex $_reponame end]
 }
 
+# Export the final paths
 set env(GIT_DIR) $_gitdir
 set env(GIT_WORK_TREE) $_gitworktree
 
-- 
2.52.0.windows.1

