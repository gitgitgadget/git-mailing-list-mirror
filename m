Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728037F010
	for <git@vger.kernel.org>; Wed,  6 May 2026 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099354; cv=none; b=ZqHs4d6llqkD0Cngm2UUr8DNjX+cO5fJrXtqb80OHL3/i6ECDFpRHy3yAcF5tVl8BONxsZAH2QAILqa5b2uPOuIkUtwJDomzkUIyiMhM1VFY8jb6PIqTzxiQcziDQXMBFLNF9mRE+Tp87WyBD1gZcMzz8rR/cDxY7dmWeKJnbl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099354; c=relaxed/simple;
	bh=rSOurxt7RmCeDBn+sjbOQF+aVhcEJ99/nMsE4S0h19U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhDbe+8XVYDJ3C/LV6/WuIszAI7MeWBzhla/5dEpD3c7YXKUF8/Tl5zjcvxrLehGNMt441XFgzrHogzsG8MJzwt/j0Ke6iih5QbK2FdcfYjrLkb4bpq7KYM33EUCTrkHFR3w7E5+6zBiYYI2rWr27003vct/Umeo4kgt9LLegl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Q8+gsMkM; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Q8+gsMkM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778099339;
	bh=h8nTsPKB23K6o2TD0UIuKUdgm7Crm95tZXQEiOrai7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q8+gsMkMfA2RYcBq9nXEWd3TFuBzl6baWSE0mQYV3egRt11IsLktaeTTP308kwYUL
	 txpTjz1/71znmkizWIGfXe2iXe1lUr1LrvrGBMo2J6bARsHkE2hiqXPvLjqZo/c0TJ
	 8cqMtlTATL/i8LbO13UyxkkoPwaElZBtBzf9sva8=
Received: from DESKTOP-31CF0TC ([58.209.116.75])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 72BB2671; Thu, 07 May 2026 04:28:43 +0800
X-QQ-mid: xmsmtpt1778099333tq42j8zbj
Message-ID: <tencent_E834EEF92D17298D51E74F26219DCA807007@qq.com>
X-QQ-XMAILINFO: OD5LcSma53sH12N/I/U9x4qTmItqBxrM6LlJyqdiXaDxaPel4EFCcui0ho45mH
	 4xHYb8Ke+krh7jYEfZZ3zNDqtMmyW0lH3WWnVQxGN/hwtgynJ5jRdHFSajmjjYrCExlbeyQwcul0
	 QdMOlGQxz1HIUu/VhXUWl6LBTOvvuv9XsvR/S4UyqK/z++4dnjuW0T7cikamdNMs/8wllI+d5MbG
	 AynFIpqNlsQC7gO792cORlGpnyQAE6KexcE60ThXXuthQbUX/OX5FvOVw2bDN1aRf5epSREDCDo7
	 W9FC2KIxJaBi3oU8ct5Jpy2GRMPIvi57WxG6TJOdelj4Ijzzs1+mi69CJFXNYs+qeIHQjXY6QIB3
	 0A7Sqtiq7tojpbmZXkhUQqgjSKl/Lz5rGNiX5sioPSRwG5Grx0+wPtUVoCJawziHJ6dZwUP/PNUP
	 z0qlQFLIwbW93BpBlky4yMpEnZVBkEgjyRyeRTTflxwD0N/8ZuF3+Mb7H5aHFG3ReeTK9DwzEM4r
	 ry8PsfwQehscy5DPBe1oU7zU9UXCo0PAT+cysydKHW8Kgv7j7cC3DS+PcLLU/obbn4R+O1RM2WeU
	 g94TqgKctja5NVAcSpoPLaeURnuPncaHYLXgngQhqcjrHOtVFbPhwch4bY4Tl9m10vpTUdpw3XlQ
	 OVT6mJqWPQkMzGqaib0FeXRdtLRsFPy64zxwR64OhS3pAKqiiZ9RhKXmIEgDwH5E8xyYpd3KslV/
	 eTcdOuMqLFfAD8gv0c5h3QPSFjCK54HSRuIQkvsEAxLq0O9Jfh+4dGOe1slIruRayZkbWrNvx0AX
	 flro1qs4hRIMDjGl7wD7WqXQvWi7fBtieCTwypPBokkMyVl6m3ZsrtTnFaVZuqjgOndO0SCBkdvO
	 2IUsCNb5Lx9i88bHimCRLNRHbXUxPDlr7VIsU/0MtTZKsmWluiBZbUStCUoZmJl6DupXC1xJ6Rh5
	 4AtZXPdl3b6o2gxH/rl9IYx2ccCBs5jO8HJzi/dNZHFaKNf1XkVmmieBpY71/IC8Wv11kAiFQAdQ
	 PBeXqf924ts6awoD2sJCOaJExHLPA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Shroom Moo <egg_mushroomcow@foxmail.com>
Subject: [PATCH v6 1/3] git-gui: restructure repository startup
Date: Thu,  7 May 2026 04:27:49 +0800
X-OQ-MSGID: <20260506202751.3294-2-egg_mushroomcow@foxmail.com>
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

Helped-by: Johannes Sixt <j6t@kdbg.org>
Helped-by: Mark Levedahl <mlevedahl@gmail.com>
Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
---
 git-gui/git-gui.sh | 72 +++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 23fe76e498..fbdc0b2a41 100755
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
@@ -1207,6 +1226,7 @@ if {[lindex $_reponame end] eq {.git}} {
 	set _reponame [lindex $_reponame end]
 }
 
+# Export the final paths
 set env(GIT_DIR) $_gitdir
 set env(GIT_WORK_TREE) $_gitworktree
 
-- 
2.52.0.windows.1

