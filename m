Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8DD3B389B
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543425; cv=none; b=nZbN2qlYLMM0/E0GoKgcrtyqMHgJT/roTQRYfFeHkPzH1MZX1Sslzo0jTmsUG6T8+UbyZOjaGTYFAJrec9jZfV01lyguR0zWGyTVMzH7RLPtTiY+mUTRZiVmvHwxtnFRDOjf6UoGOkmQMhh8UJUZicS/tJBA7T5WJHKgxJsWICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543425; c=relaxed/simple;
	bh=PLj81IyTz1QiNz8hwJ3nUTdtxgdn922qSb47ZUUSSTA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9LCGa9cRsS5zjF1azGWF9N99s1cCroNOWj91zMypFunagTRMoAAfMXM2Lbp6uKE9tiY8aHiN9sjV4HeKMvGzy2/PhGu0gq5HEypf5O4qx9FPyz7tEFkijovG8tkLwWsi11BK/gDbkTe+1ituYhHNINdT01wqOH+Drt4savfSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=t8UnaLY5; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="t8UnaLY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1777543413;
	bh=Ah0Q0N27dV2R3kdKhS30+KzM5PHCiMBFbkPe7b65wtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=t8UnaLY53rxoi/Q+MXR/o4O/I6k2p/g/AZquXQ8rj+YYMAdmH9t3BEvEinwv6M+PB
	 VaKhb0zpr/d+Mu+lPMRoI3fDnOEc+Pd8Pr+bLFBYgWIHYESrqam54WefdPLqFVO/oq
	 6fXzfT775GIR9j7iGknP9oip1qYl/IkyM41kdBOU=
Received: from DESKTOP-31CF0TC ([117.188.249.188])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id DB3EC7D; Thu, 30 Apr 2026 18:03:27 +0800
X-QQ-mid: xmsmtpt1777543407tbcw7mgd4
Message-ID: <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
X-QQ-XMAILINFO: N2PXJXefbcU4MRcy1nd7PFvY6ChQNnjOPe+ofpt6dPBCkZgWw7AQYkM7p9J6dA
	 nuZQfbWngoaJIvpaD36cW3JrMlWDniJlKBwklmwc5x02wouwfsdTyRSBXhopBstZrlKfW0SKV/DB
	 J/wWDJAD0bOcro08Kvwv9+Br1HjQwPPmfHrK0RkTV3C/TXjXh0hLk4a/aEz2EC7IEtruEkABJwyZ
	 /a5tcB2YFqrivmWhiAnjwQdJ6aqRAsVlo88dhHDFy3ZF2xU4IUMszFzBn4WhkctT/Hx4TseGpLEx
	 HjVTF5bscmjNvF+Wotwsr/FNSfznZ6apk5PoBf9ZEfGK503xER7TYJI4gLUje5kUkQXntTwzM/ww
	 bONY7eGCwwW2GYYIy7kZlIU4wQGYOwPDq2+ZxurG+QFQJOJK+7EPSskXjOP3Rezzu3hSVjydIs02
	 tzcQug4cTnOPFgXNd5hSt5+VinfKRSBzuvRAdRpnOp/sE3uGs9AN0HFavUzDLk3G74kx4Qj0aabv
	 HTo7kk4Pc5MAKnc3Rv/iX02hTCR7mQmUKJveouehCRfQlUBD1FDEephkkcKQ7rGJ8Z+4KS02D44G
	 /31+KiNNGG3FmX0JyMvdUzB8JiT6jQRYYcuUlOZN1rgbvdeBPL8FRCeWN7iXhjuQtT3+J8o+AWNM
	 RLmUcM+iCaRTg5cPAOrrMgEAudEcY/8w2P3EDJPhxyCrSgQIWa66sz7dT6gYJOi4M5n4DqNTyjVK
	 G5y0A0r4kQT+9VD4yvQX+89ZKfyukXvLnmTSrWlqAxDsxpicNgArkPTKRhTRR7T4t4f8FpgLX0Vu
	 HK4EL9wZt5QdagWvkK18ITFf10W4y00sEk/tU2ERbO2mahUUC+CtoJvHtGa5KE88XQiNrELsYLHa
	 xPHrVX7QhXmgqNcUumJXGBjjIF81Q4X3KljZvyg+sI4vHZwNUR95PuWIYxOQVA5bridgMIMRBiS5
	 rxDF0wYLLxcZxc4mpXWJFUiuiX1PTxXKWwCYyHEpM7SNysMji0QMk7vwmSLPTtc0vRlBMMTGLdfk
	 HEDND2veTtxD/eKiwcHBC02hpW/hK0FcuyvMdGvKr40ot8PyhGro6pBtUcwy0q5ro3iAs6EfiZ8X
	 J73qD4+nBzMEjzuXypvx+ZUy2NjbzXiY9qdIyDOKFwaqLieWw=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	mlevedahl@gmail.com,
	Shroom Moo <egg_mushroomcow@foxmail.com>
Subject: [PATCH v3 1/1] git-gui: handle missing worktree and separated gitdir
Date: Thu, 30 Apr 2026 18:02:18 +0800
X-OQ-MSGID: <20260430100219.1475-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
References: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When git-gui is started from a directory that Git recognizes as a
valid repository but the working tree is not accessible (e.g., a
separated gitdir created by `git clone --separate-git-dir`, a bare
repository, or a case where the worktree directory was removed),
it previously called `rev-parse --show-toplevel` without error
handling, causing a fatal Tcl error ("this operation must be run
in a work tree").

Wrap the call in a `catch` and handle the failure as follows:

- For bare repositories, keep `_gitworktree` empty so that the
  existing `is_bare` check shows "Cannot use bare repository" and
  exits.  No behavioral change.

- For non‑bare repositories, try to locate the worktree from the
  parent directory using `git -C $parent rev-parse --show-toplevel`.
  If the parent is a valid worktree, change to it; this covers the
  legitimate case of starting git-gui from within the .git
  subdirectory of a normal working tree.

- If the parent directory is not a worktree, refuse to start with
  a clear error message.  This prevents dangerous operations in a
  separated gitdir, where ordinary Git commands like `git status`
  would themselves refuse to run.

The approach intentionally avoids two pitfalls:

  - Testing `--is-inside-git-dir` before calling `--show-toplevel`
    would break the normal use case of starting git-gui from within
    a .git subdirectory (where --show-toplevel would succeed).

  - A simple “non‑bare” check after a failed --show-toplevel would
    reject a normal repository whose worktree was only temporarily
    removed.

The chosen method keeps the original behavior for bare repositories
and for regular working trees, fixes the crash, and properly blocks
separated gitdirs without a reachable worktree.

Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
---
 git-gui/git-gui.sh | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 23fe76e498..2392282df3 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1169,7 +1169,28 @@ if {![file isdirectory $_gitdir]} {
 load_config 0
 apply_config
 
-set _gitworktree [git rev-parse --show-toplevel]
+if {[catch {set _gitworktree [git rev-parse --show-toplevel]}]} {
+	# For bare repositories, use the existing error handling
+	if {![catch {set bare [git rev-parse --is-bare-repository]}] && $bare eq {true}} {
+		set _gitworktree {}
+	} else {
+		# Non-bare: try to find the worktree from the parent directory
+		set parent [file dirname [pwd]]
+		# Cannot go higher than the root directory; leave _gitworktree empty
+		if {[file normalize $parent] eq [file normalize [pwd]]} {
+			# Already at the filesystem root; let existing paths cope
+			set _gitworktree {}
+		} elseif {![catch {
+			set _gitworktree [git -C $parent rev-parse --show-toplevel]
+		}]} {
+			cd $parent
+		} else {
+			catch {wm withdraw .}
+			error_popup [mc "Cannot start git-gui from inside the Git directory."]
+			exit 1
+		}
+	}
+}
 
 if {$_prefix ne {}} {
 	if {$_gitworktree eq {}} {
-- 
2.52.0.windows.1

