Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180033E344
	for <git@vger.kernel.org>; Sun, 31 May 2026 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268588; cv=none; b=d9woYLIG88+I2BUP9+1kgsVjgLkTML0bendXc86Fk35mPUc/AAT0cNyY2fgedyqt2p4pNB50FK2opvSl1WbJzPz2Ps2pW9A5DBewlHRIZT3i39JTnWrNodkn6aW6lGpTkDV3zNOKM52FrcE6qvQFeFhTjwln5kEuaVGyzuAWDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268588; c=relaxed/simple;
	bh=9+g/1zK/LVsoMGwUZearav/FC3f+CT+TjCydhisFubU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/QdNOGcYzVTWgN24OO2yoRIrAPfIZqB0bvFO5CwBlDtbn0PYfCcG+jquuduVwIV5UdF9GvIW23sCAkSkMhATkttPfDepnUppwNX3yvXBXC1N3J1b6On6SFWHjdn1WHQ9742EYs3M1HjWzyXyaFHcWvuH7JigpNydOkxXU15JEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4X6xClE; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4X6xClE"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ce9df48e1bso9862466d6.1
        for <git@vger.kernel.org>; Sun, 31 May 2026 16:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780268586; x=1780873386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjOeQJzGG7H7XrycqiIG8heGUeDDT1NYwuaM/QmOy5Y=;
        b=a4X6xClEG9AUWx3UtydDsANs3UJDtdKGfgxnoU6WCgTU5V6zm9qY3oSpl5UVWBSb+A
         Fyclm938TFn4G6n09MHeP8k/l9X+qOgJRFaHcgdeCVUYAn37ldJ5H3eGqQhwtViCr4xp
         TXXGyuHAUqGKSnGM1xaF5lo+Ep1n25i5m/YqWSoQ0C+5u7zEsFbz7YTSyLGBMxTFjo/B
         AMVTpPqDffaoxA0bkEk6/x2TGW5bISaQazT3LXeDebGUn2T0RrT+rjj7tUgny2K7rVv/
         Jgt8qzqHSZMZwKhjZmplE6ax/i6PtXTQ7CWjKUnYmsE3TVrqsPcxWaIC0BKqRPdN4zAz
         6H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780268586; x=1780873386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YjOeQJzGG7H7XrycqiIG8heGUeDDT1NYwuaM/QmOy5Y=;
        b=kWcJzfCbwiUrL7gQAbjzJ1YiP6JKM3sHfsNbSJ93RrWCZhuRCNtLpDAMKz+X7srRAh
         z8t8STrqnNZUUFDhwko+cq9KShvjr6hlNldE/t706DuhSRfA13gi/ZusE4r1aUaA42TA
         cNRTyruvPG/Ol34yjmFPBKMsKobqg8TQdtuX2KonncloUZEj382MwvkSa8kyoOEI9gRL
         3JC4LGmHmhVWDxNq/OraOT+VTzmwE0QG+KjcU3Iy9aNAm0gO2Ldo97r9eakTX1CtybZL
         N6QeeUHrPTFQIisqR3j1PqziiTrROzcSy78AKjkneOgS8Vs/DyX/5VpBnPFdV/gQQ1+j
         Rk3w==
X-Gm-Message-State: AOJu0Yy9yiPKpHa8jF2T0qc0C9IqZlz5VkOQqdNADiUUozPES2Kd7Ss3
	+8lOcR5l+IlXWTYnZdi22J2AlNCzNKD0yV0NOx2c0YK/m0Eeh6ErcZobFRci1Vu6
X-Gm-Gg: Acq92OGUplaYczJp0OgCyjpVQXSdo9+cJqTDupyQ6XOXemqLk9IYWih/jqsj1knFRNB
	fsB3VhwvR1LIZ2g+8/cUqc2PbR8YT5xcN1UE3vDMCtOPJNwy0jxlaehVEf5Fh/SqXRynsRFQGnX
	d6cQgmG/EXaBVScleZOk3XSLHmMpPhGcCt3nhfmX7EtX8OA925mHwjRosEvDHsoUotKE9LjH3Bz
	eYIe/0Br5arahaG9spQn9twCIv/36jvdzymLTEyegbh9Fly3aXUDnDzyToTvpz7LskbYc8Wjb10
	m+QHYaHZbGhSnSJnE/BVqF56lj/EmjgYpff3SoyvWFiyn/fG5M3HF2gZwIdRiK8IDNFGBE09flM
	3hH3mWWS+0p6rCTd+gjpQyLzd9CaY+Y5noe1xjgRN4+omhm2FoDJe1vDrrED/DHd+J03MRij+MU
	M3b6RWdXHjjMjUtzXsEnDo4pxodazhp0CI+kgi
X-Received: by 2002:a05:6214:54c5:b0:899:f0b1:7332 with SMTP id 6a1803df08f44-8ccefdaa82cmr146934456d6.32.1780268585775;
        Sun, 31 May 2026 16:03:05 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm78268426d6.8.2026.05.31.16.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:03:05 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v3 07/12] git-gui: use git rev-parse for worktree discovery
Date: Sun, 31 May 2026 19:02:20 -0400
Message-ID: <20260531230225.126817-8-mlevedahl@gmail.com>
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
of git's control, so trap that independently.

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
is unaffected by when git-gui loads its own config data. Also, we cannot
be sure the worktree dependent configuration can be loaded before
full discovery is complete.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 61 ++++++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index aed3bc7200..53b6859345 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1187,6 +1187,33 @@ if {$_gitdir eq {}} {
 	set picked 1
 }
 
+# find worktree, continue without if not required
+if {[catch {
+		set _gitworktree [git rev-parse --show-toplevel]
+		set _prefix [git rev-parse --show-prefix]
+	} err]} {
+	if {[is_gitvars_error $err]} {
+		exit 1
+	}
+	set _gitworktree {}
+	set _prefix {}
+}
+
+if {![is_bare]} {
+	if {[catch {cd $_gitworktree} err]} {
+		catch {wm withdraw .}
+		error_popup [strcat [mc "No working directory"] " $_gitworktree:\n\n$err"]
+		exit 1
+	}
+} elseif {![is_enabled bare]} {
+	catch {wm withdraw .}
+	error_popup [strcat [mc "Cannot use bare repository:"] "\n\n$_gitdir"]
+	exit 1
+}
+
+# repository and worktree config are complete, export them
+set_gitdir_vars
+
 # Use object format as hash algorithm (either "sha1" or "sha256")
 set hashalgorithm [git rev-parse --show-object-format]
 if {$hashalgorithm eq "sha1"} {
@@ -1202,37 +1229,6 @@ if {$hashalgorithm eq "sha1"} {
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
@@ -1240,9 +1236,6 @@ if {[lindex $_reponame end] eq {.git}} {
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

