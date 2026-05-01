Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F9E384238
	for <git@vger.kernel.org>; Fri,  1 May 2026 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777632963; cv=none; b=Rce+DvzOgbZhD4UloSMcUqMD3GVYahDss143+xZ837kzHEBtZhPs+xKkKRDTZgG65K094dWD+1A5ljHh3iAYZNYSrdqELiSC+Fh6lthmALUQmFVxHpDNz+MHgKFKDE0Gv9BlSxM4MMH0EZmveDEFYbzW4l6W9yMJZw3dsrpyOms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777632963; c=relaxed/simple;
	bh=YVnPdbu23Z/AweksD9+q3YHTSTVhzOiyxbIIrTCKc2U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEY3GI66rgsiQdc63ca/+eCB/ELsElLFpFdp2OE/vkM8xDm0a2J4hXuY88WNIrOXxM4SKPUVmCaeEEnRA5Qe2LtvT+IMnPOCMDtRgNasMViCOGER9TC4xv8pyd/SynzOuyY4YHSrGCIHwBkVqOB6a/pwlCWsv2SOsNRBzelRiO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=bGZqHWU1; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="bGZqHWU1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1777632953;
	bh=rDuVQqOEi2UPGyEV9gCMeTnU1vYuKAK35YetlPB8mq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bGZqHWU1w837hxpmJH+tZ8DGkaryAalMA2iM6BFYWaMG4a6FWMfETwuA8dn7HjqKb
	 nqc2xKYnR+Y9+7J/aB+SNue6l2tox2BoP9wfPCNkqgAcCCyFaayAufW510ddimflGo
	 KJ1ySsbSGtKzaZIJz/Gai3dFTYy9rnifeO+T3woI=
Received: from DESKTOP-31CF0TC ([117.188.244.93])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id DA2A94D3; Fri, 01 May 2026 18:54:34 +0800
X-QQ-mid: xmsmtpt1777632874t9c9j0nvy
Message-ID: <tencent_277823B7C5D69914E168E5679A907C655606@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAAZklMOMLMQzJh++Q6+4ftkmi0b+Wenwpcfw+a29g+o+LUUHgqa
	 OuuY7ekQWlFYt3Bz8iOGw1Tf0rSBfRL+QW7expSTa84/4pjhGUXaF75RYfbi/t/PVudAlbo4sbbL
	 BlWI5Mw2d4s1fzz6DR6yr73GzAUqs5eEFEvx0eMgoQoKU+bBBr3zexUCSYBkFBeekTSCI3WjN9oA
	 gT5GEYIyIVtBfD2BlLQnXXmjtIPa7LUM9+BR3c17PEEIgR6TT4ThG0NG7vP/msJQWlwmCCEe+5fb
	 oAh214luGejoBOz0/jrZp1Y9lb9bPMgmFHZOYV4CmUEFk8bd+cYXwQnciybJiOT0/uiKEvQCd+4N
	 MbnPXAiUk9VuRNqpgdR99fRX8uSIlZECerz0K6+ikW0J2szzaXOUx/Vnyd3VhlJrQBoGELxdx1IO
	 30dNsRJjxN3s8h2MVj46u9dvA/I7SpnLVJa/cvwMVKoloVETw+6p9pqns4Z0fSMF1HDYlkefwE0t
	 DlLKXbqF4or1hmJGwSOureeGmmGSceUZTa4ShzWhKB6o6Y3mqqEbZg/6huY5hMcqYM6JWpHdq/fp
	 sqnl5IqJvGlXQclmeIrEBTJ1Vm8+rLbh2SKsGWLn/WzQOH9juBIFCRC3bvDmra0y5H9YyFdxWAcH
	 4fqh6DF4uPgBOKSdV7+aiDlhWMbAa/Q2ndGwUJCE+XU3gp2du0LWDKBql1UZVQlIAaOsLXAlmM+1
	 Al/duSGi6/vOjGMpGrtokip087JtJpqndJc6ZzruzOYBl6Pqh8izdZRZVo3WPY+o8dXPNirnQI0f
	 AF0WlFH/NgWptO1+19BQ2Xe6kaCtflbGWZa0JHmKNGQdv9gWgzH8NNbNqigBENi3VrKwuLHbgok2
	 Wt2FPZwlk90KzP/QFKV7CjYpBxrdtkKXEDFLwu4TpTA7BCUR1WcVxZHaBb+jfRYQBw6ikhkq/hL9
	 kGG09xp2ZYbeydVvUfPs4W26+CEmJgOTTX4ksOFZTFlCQjuVCUmzBPFWzzOtfmgnMRCpBtUDGEZ2
	 XX93SB0xiO7fosZrFWZbVBURXjGYWtGpKFhXy1j9bmuLNrSNBtEp74kUbidCgDOEQcmrX1ag==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	mlevedahl@gmail.com,
	Shroom Moo <egg_mushroomcow@foxmail.com>
Subject: [PATCH v4 1/1] git-gui: handle missing worktree and separated gitdir
Date: Fri,  1 May 2026 18:54:13 +0800
X-OQ-MSGID: <20260501105413.477-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
References: <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
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

- If we are inside the gitdir (i.e., `--is-inside-git-dir` is
  `true`), refuse to start with a clear message: "Cannot start
  git-gui from inside the Git directory. Please run git-gui from a
  working tree."  This prevents dangerous operations in a separated
  gitdir or when starting from a .git subdirectory, where ordinary
  Git commands like `git status` also refuse to run.

- Otherwise, leave `_gitworktree` empty so that the existing error
  paths (e.g., missing worktree) can display their own diagnostics.

This fix intentionally drops the previous ability to start git-gui
from within a regular repository's .git subdirectory.  That behavior
was never reliable (Git itself forbids operations inside .git) and
broke completely in the multi‑worktree case where the parent
directory is not guaranteed to be the intended worktree.  The error
message guides the user to start git-gui from a worktree instead.

Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
---
 git-gui/git-gui.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 23fe76e498..9e848aa26b 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1169,7 +1169,17 @@ if {![file isdirectory $_gitdir]} {
 load_config 0
 apply_config
 
-set _gitworktree [git rev-parse --show-toplevel]
+if {[catch {set _gitworktree [git rev-parse --show-toplevel]}]} {
+    if {![catch {set bare [git rev-parse --is-bare-repository]}] && $bare eq {true}} {
+        set _gitworktree {}
+    } elseif {![catch {set inside [git rev-parse --is-inside-git-dir]}] && $inside eq {true}} {
+        catch {wm withdraw .}
+        error_popup [mc "Cannot start git-gui from inside the Git directory\nPlease run git-gui from a working tree"]
+        exit 1
+    } else {
+        set _gitworktree {}
+    }
+}
 
 if {$_prefix ne {}} {
 	if {$_gitworktree eq {}} {
-- 
2.52.0.windows.1

