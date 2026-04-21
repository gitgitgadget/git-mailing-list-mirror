Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218173603C3
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789310; cv=none; b=RKk91qsGCqw0iTaTmD4M+k50oGC58gu2j4Y97Er2Kldz0DKW2DgMW7lsoPiwhXwQEd7MpMorl8YOASE2wgFdEhlnbGSBQnKK26ftyDm9y+Mj8zp/gg0vCxTYqWFtInOt9AV8nmCw+mgRb2S8igR3DdX5EfsS3Yt9Xd2TOibgceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789310; c=relaxed/simple;
	bh=+KQtEeeobsF/MSZ94FTfj5qU4PdZUGyDS+1wDqwBlIY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=gq16R/C9jmEbt849r/oSckOQqffb1v4VXasg2bn8+DYaGtb70NQ6Es5I7+5a4uqamei2CQ4NH/RaDpRo4WVNtcyKXmnaYjYskWENaZH4WE+eEjTPY3wXm6W2mdQSs9U0CZ4ZYNU6/zuwdSUAGMw5cS7xqPCx5vPrY3ZASuPSEkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=l/p0P1Ta; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="l/p0P1Ta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1776789297;
	bh=+DsFn8P1jTH5pXCS7n0iJJgUJ5hUbTEeaNUzBumEh+A=;
	h=From:To:Cc:Subject:Date;
	b=l/p0P1Taw1R2IuaboK2eoIaDfSqTm5VQf8ymYKhO690S0uf9hjfGV+E9dHM3rJNPt
	 PnqY6JwcuVg42b0XUj/sPJzLIhohTImSLSbgUP4KVBxfp6oJ/Htrh+mjv7b8YrdAdh
	 +Ferexz9Lq+2gCO3i9qGBJFFyBmeAy0B6DYjsO0A=
Received: from DESKTOP-31CF0TC ([49.72.140.205])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 81C35845; Wed, 22 Apr 2026 00:32:28 +0800
X-QQ-mid: xmsmtpt1776789148tfey8hhu9
Message-ID: <tencent_3FF7B35FE8AD7236FC9BBB628B45EA65F405@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+MKuRTJaDj9zestjPuUv/tHKqNrR7Ew4/BUgvlDGiMCXwOHQ7We
	 xKjCTtlXWO06LhxeTNNc/EmhlMsJxRPW9IBZgmZbKUn7pFL26hqaGZe4Xu7DFKt9izcnuk5NANEg
	 XOhk3kxk/XzKYccFuOEw+bNbsC3OnsqROfXsXWsrMX6hIxfhCkxdQlkWLeUAtVEDeEMxQza29tlk
	 +keC+uDMtPaRZpe96gGCtXXBGJgZ4+F/Al7qK7sAXyUlwLiHs+1zwtneIvWtuwsu00Oh7xXe60rs
	 ddwlH9gIW8QIFy7Uh+4TN8LbMrAo/zMoeVs1iTUzuCrV07gC29/jbV8ejLXdB2D4bbu+LrkqRewb
	 jxLTbrXQJKRRdwxGhtVT8strt5GknFX2u5U1br1/0oGSrpbj4Kmxaq35agXoyqowApMjnPCpLLJ7
	 QVRDsJ8rB0a7PNMgYkIJlC5qw4gT4I3fBSr8HrBxNjFvVQCTyUmOjTCvnIxmzxDNGD7njTH1ivdp
	 HPcIA90wOPx98oAYfXLSJ0MEBFpT6wam7MiSIwv9UomXOPf0aJCabjNwjVu41KSG8LZr3Kdz28nA
	 BJDN8PkltWmzJKlVO4aPnm6RivZq0tycQqvKzrzcl/tIMOIx3Agnd1ywLO/Wu+Zm3dmNIEdfiYTR
	 oLRQd5c5qWbj4KStWwWhJsbTdot6zhpLki7NLoBZlbhLKGRFbG+j5KEo3vBev8Z3ghh97WKc8gde
	 BXkZN8x44MJ6aSEfkMZBpxXdWfVZ+y87BQMQp3pco6yTw4vMufAJiHGXAguEoKMhNGgJsxdxXJDw
	 vdNrgy+c1G8SSGYNt+fdaACnH3Z3BoFrC1AubX74U+wrtiuTly+Nt1qbfp530w3hBMk1w+4TnrLQ
	 mrkiVF6903Mk5E2GuC2vaComUr89GWw+cG8I6DupOVyPcsOZpDW7Dg5pFCgTiZnalELqUBNNqhtr
	 1vXHHUQnFo22sdR08+XHKNj8q/lE7KAMPuNzI+czqgzzOBXC3rS5wgl5dSXKAg1vaf0inaavHM0u
	 c4SgVddoJ08ilFVIEL299no5BuwzZ7gVsJPHaR1SSYaipCywO1xVzLUeHx2XLKEFzRvItazD0FLy
	 jNKgBj
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Shroom Moo <egg_mushroomcow@foxmail.com>
Subject: [PATCH] git-gui: handle bare repo or missing worktree
Date: Wed, 22 Apr 2026 00:28:53 +0800
X-OQ-MSGID: <20260421162853.1687-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When starting git-gui from a directory that Git recognizes as a valid
repository but the repository is either bare or its working tree is
missing, git-gui previously attempted to execute 'rev-parse
--show-toplevel' without error handling. This caused a fatal Tcl error
("this operation must be run in a work tree") and prevented the user
from opening the repository selection dialog.

Improve the repository setup logic:
- After obtaining the git directory via 'rev-parse --git-dir', check
  whether the repository is bare or if the working tree can be
  successfully located.
- If the repository is unusable as a working tree, display a warning
  and present the "Create/Clone/Open" repository selection dialog.

This makes git-gui robust when launched from a bare repository, from
inside a .git directory without a worktree, or when GIT_DIR points to
an invalid location. No regressions observed in normal working trees.

Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
---
 git-gui/git-gui.sh | 75 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 18 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 23fe76e498..2e4bc2f226 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1123,24 +1123,63 @@ unset argv0dir
 ## repository setup
 
 set picked 0
-if {[catch {
-		set _gitdir $env(GIT_DIR)
-		set _prefix {}
-		}]
-	&& [catch {
-		# beware that from the .git dir this sets _gitdir to .
-		# and _prefix to the empty string
-		set _gitdir [git rev-parse --git-dir]
-		set _prefix [git rev-parse --show-prefix]
-	} err]} {
-	load_config 1
-	apply_config
-	choose_repository::pick
-	if {![file isdirectory $_gitdir]} {
-		exit 1
-	}
-	set picked 1
-}
+# Save temporarily for restoration later
+set _startup_cwd [pwd]
+
+set need_pick 0
+if {[catch {set _gitdir $env(GIT_DIR); set _prefix {}}]} {
+    # GIT_DIR not set in environment, attempt auto-detection
+	# beware that from the .git dir this sets _gitdir to .
+	# and _prefix to the empty string
+    if {[catch {set _gitdir [git rev-parse --git-dir]; set _prefix [git rev-parse --show-prefix]} err]} {
+        # Not inside any Git repository, proceed to repository selection UI
+        set need_pick 1
+    } else {
+        # Inside a Git repository, but need to verify its usability
+        cd [file dirname $_gitdir]
+        set bare 0
+        set worktree_missing 0
+		# Check if this is a bare repository (no working tree)
+        if {![catch {set bare [git rev-parse --is-bare-repository]}]} {
+            if {$bare eq "true"} {
+                set bare 1
+            }
+        }
+		# Check if working tree is present and accessible
+        if {[catch {git rev-parse --show-toplevel}]} {
+            set worktree_missing 1
+        }
+
+        cd $_startup_cwd
+
+        # For bare repos or missing worktrees, warn and guide to selection
+        if {$bare || $worktree_missing} {
+            set msg [mc "The repository at '%s' cannot be opened:" [file normalize $_gitdir]]
+            if {$bare} {
+                append msg "\n\n" [mc "It is a bare repository (no working tree)."]
+            } else {
+                append msg "\n\n" [mc "The working tree appears to be missing or inaccessible."]
+            }
+            append msg "\n\n" [mc "Please select a valid working repository, or create/clone one."]
+            tk_messageBox -icon warning -type ok -title [mc "Repository Unusable"] -message $msg
+
+            set need_pick 1
+        }
+    }
+}
+
+if {$need_pick} {
+    load_config 1
+    apply_config
+    choose_repository::pick
+    if {![file isdirectory $_gitdir]} {
+        exit 1
+    }
+    set picked 1
+}
+
+# Clean up working tree checking temporary variables
+unset -nocomplain _startup_cwd need_pick bare worktree_missing
 
 # Use object format as hash algorithm (either "sha1" or "sha256")
 set hashalgorithm [git rev-parse --show-object-format]
-- 
2.52.0.windows.1

