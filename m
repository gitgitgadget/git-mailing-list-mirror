Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5636BCF2
	for <git@vger.kernel.org>; Wed, 20 May 2026 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308680; cv=none; b=GK0FZd8aj/6sQCkKonxooqwcjVBJaEy94eMbb9wrfQMkl31mU+103lGO6/gP5uoc64HPFRocnmcv8jkdWRhFroKpX0tbGIOANd0Co5ak5UHf/LBMpI/fPIWkUITTzunvgzEqz21eBLSW4VAf7TVzmY2CocvF9UkVgH4O8R+V2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308680; c=relaxed/simple;
	bh=2VKke2zkSa1YP1xI1s+x3SwGxgM4jrWFkZvBI9Sl4hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtnfhbMw8eObj/rWTncloFCA90vt7VqlL/c+X/t0vGf9MOs/40gs/sqapHm8HoZ40d/1D/QxfUKrOcLEcS/Pf6n7JZG0iVg2FP8oQ7TlVNGuZuXv8gucVlwxy9lxDiBBvvyn8B4PxJE9+L5oWCMDJHq+5lSMdPSyO5oeEdbVhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYT3GHlB; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYT3GHlB"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-913cc4d7c71so536413585a.2
        for <git@vger.kernel.org>; Wed, 20 May 2026 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308678; x=1779913478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYnR73ewjwy2dTZV+UDd7phVxf3+d7xM+5f9pP77ofY=;
        b=aYT3GHlBcmBcIpRdYKpiqffIfwsErXo6XLeFC2FPnpxpGBh4YBvidcH4lCIt5d7Yje
         qTWFESNlO9a4N5NBIym0IurpvyVlqJSGY3MLJlU4hFxFQpsFrtzDvQmMUJyepg2fxWdA
         QUHm6Xihd2XcKP7NFNlY5d0zafn0q1MdKtRr++Zu0HabJfM1+Gs1Vj93VpKThHKX65tD
         Q3c8WWyQ11RDLn2QlF3Lri5FyagVBKFHFVqqbblABD1miUL6Zwsd0JnVcWAQnX6kSt3q
         GpWBLd9S28nZrMbooyrTvELVNdJ2oTBbF8TiHe2/G3xrGMCSXNc8AGWMm9Fkhz0PGzSS
         2pDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308678; x=1779913478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DYnR73ewjwy2dTZV+UDd7phVxf3+d7xM+5f9pP77ofY=;
        b=pRds1/OkD0szXhIXEMiZ9W2u5EKV5w7ggfsCXnjGhGKw4I6FwG/6qgvWHOPZds7/Bc
         cEb6JKSeB1JjDudVwFc4StaWLTfT8GoQykxIkB+01UoCt+jXmvsUHDji+s90gq6VrRqr
         tD6Yjf+aPkfG65F75kmMgEWUZguS7NotONSN3bF+XX2e0uCE9VQiTXFlYCyIbUj8s084
         lsCcljL84vvN6qp25jCxRqI/+NDPKYoMwzuKUKo4LK3NTQDp4bXV/4jfR6lQRdk4z+m2
         tbuJUkJZLYkVv9IHmd1jS8z/zOTcsvl6AM3c4fvaKhJQQIvxb6tyQUupseRgyy5WcHlF
         VsYw==
X-Gm-Message-State: AOJu0Yw+kFQ2/B48pfA+zOXfpatWNXZhjgdOCpJ1uAEWei2fr9cazwSt
	sRgekGFKcemgBL6HKTsXo2iM5GoyVx6A9S77k+l/VExiW1O7o+7rwrfLVImf0w==
X-Gm-Gg: Acq92OEQYE+lHBCHMtw/Eqs9JdJ6gYK8ANqes4M8sFvhnWuTtKS7C5M951SJiAl0TUq
	yJ9X7mg2CRGHq4WDrBXHM5ieHKjDZWZqZf9c4xeGDJbz4JOd6M/D9QriTjUDcrRQptmxnmzI/5Z
	cpJsuNlD/9idSr1jiB1OKv+hrAR5EQLVRb1nxa1kKE2UpGxB/v341CwRtKvDVRs0rUVwgVWSlD+
	t9rNN18EMzcxEQs59QhbJbjsdJq+m0Q8eRX/ZsGHsJWHhIBSODy3nNQUCzgtjWJN2gqPjRsRzdP
	l2ZIHBFGTxW1IGVvBKMnH5OxcGfBdjqrGckr0OJ1F18ugHS+YvF74ekyLYmB+GmK6jB8nZR25YI
	sBwVGQDcRtHsryKseI4ILBBvWkrwOz7oklkMP1UdDd66hiRR58b2AColGSvUHdYph07DXLJieLT
	saEdRUR8AmaNhxtbTeLY/sKB00J7TrnfU6wwLL
X-Received: by 2002:a05:620a:6641:b0:911:fc2c:c079 with SMTP id af79cd13be357-911fc2cd055mr2725902485a.10.1779308677601;
        Wed, 20 May 2026 13:24:37 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361905d4sm129891136d6.32.2026.05.20.13.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:24:37 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 06/11] git-gui: use git rev-parse for worktree discovery
Date: Wed, 20 May 2026 16:24:05 -0400
Message-ID: <20260520202411.108764-7-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260520202411.108764-1-mlevedahl@gmail.com>
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git gui uses a combination of tcl code and git invocations to determine
the worktree and the location with respect to the worktree root
(_prefix). But, git rev-parse provides all of this information directly,
and assures full error and configuration checking are done by git
itself. The entirety of discovery in normal configurations involves

	git rev-parse --show-toplevel (gets worktree root)
	git rev-parse --show-prefix (shows location wrt the root)

An error thrown on either of these lines means the worktree discovered
by git is unusable, or git did not discover a worktree because the
current directory is inside the repository. If the user has defined
GIT_DIR or GIT_WORK_TREE, this is a user configuration error and git-gui
should stop.

Otherwise, the blame or browser subcommands can be used without a
worktree.

A separate error might occur when changing to the root of the discovered
worktree. The cause would be file system related and completely outside
of git's control. So, the final "cd $worktree_root" is separately
trapped.

Discovery of the repository and the worktree must be guarded to trap
errors: the intent is that any configuration problems are caught during
discovery, and later processing need not include error trapping and
recovery. So, move all worktree discovery code to be immediately after
repository discovery.

This does move configuration loading to occur after worktree discovery
rather than before. None of the code executed in worktree discovery has
any option controlled by a git-gui configuration variable, so no impact
is expected. git itself will always read the repository configuration,
including worktree specific configuration data if that exists, so this
is unaffected by when git-gui loads its own config data, and we cannot
be sure the full worktree dependent configuration can be loaded before
full discovery is complete.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 64 +++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 936c309e59..8fe25fe188 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1164,6 +1164,36 @@ if {$_gitdir eq {}} {
 	set picked 1
 }
 
+# find worktree, continue without if not required
+if {[catch {
+	set _gitworktree [git rev-parse --show-toplevel]
+	set _prefix [git rev-parse --show-prefix]
+} err]} {
+	if {[is_gitvars_error $err]} {
+		exit 1
+	}
+	set _gitworktree {}
+	set _prefix {}
+}
+
+if {![is_bare]} {
+	if {[catch {
+		cd $_gitworktree
+	} err]} {
+		catch {wm withdraw .}
+		error_popup [strcat [mc "Cannot change to discovered worktree: "] \
+			"$_gitworktree" "\n\n$err"]
+		exit 1;
+	}
+} elseif {![is_enabled bare]} {
+	catch {wm withdraw .}
+	error_popup [strcat [mc "Cannot use bare repository:"] "\n\n" $_gitdir]
+	exit 1
+}
+
+# repository and worktree config are complete, export them
+set_gitdir_vars
+
 # Use object format as hash algorithm (either "sha1" or "sha256")
 set hashalgorithm [git rev-parse --show-object-format]
 if {$hashalgorithm eq "sha1"} {
@@ -1179,37 +1209,6 @@ if {$hashalgorithm eq "sha1"} {
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
-		catch {wm withdraw .}
-		error_popup [strcat [mc "Cannot move to top of working directory:"] "\n\n$err"]
-		exit 1
-	}
-	set _gitworktree [pwd]
-	unset cdup
-} elseif {![is_enabled bare]} {
-	if {[is_bare]} {
-		catch {wm withdraw .}
-		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n$_gitdir"]
-		exit 1
-	}
-	if {$_gitworktree eq {}} {
-		set _gitworktree [file dirname $_gitdir]
-	}
-	if {[catch {cd $_gitworktree} err]} {
-		catch {wm withdraw .}
-		error_popup [strcat [mc "No working directory"] " $_gitworktree:\n\n$err"]
-		exit 1
-	}
-	set _gitworktree [pwd]
-}
 set _reponame [file split [file normalize $_gitdir]]
 if {[lindex $_reponame end] eq {.git}} {
 	set _reponame [lindex $_reponame end-1]
@@ -1217,9 +1216,6 @@ if {[lindex $_reponame end] eq {.git}} {
 	set _reponame [lindex $_reponame end]
 }
 
-# Export the final paths
-set_gitdir_vars
-
 ######################################################################
 ##
 ## global init
-- 
2.54.0.99.14

