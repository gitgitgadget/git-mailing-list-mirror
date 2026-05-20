Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89B36A036
	for <git@vger.kernel.org>; Wed, 20 May 2026 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308676; cv=none; b=IRtm3XYnN3Ihq1tazP1vpQ7M4UXoVv7TFar/pKC2ckFEhzCenLSD5uWJL/pG+gObBh4T6/lDu15uvUeyZoTn3M+DMBKfJtI9PU62SXq7uHm6TPZjPeBOnTLH7D8QoeFHeEv7p1Tnze0m0hSXD/N/wweh8HPQDjXA7iy5LSPqxK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308676; c=relaxed/simple;
	bh=yWxV9z04YhKDR5qvrWnvalbzChs1wLWh0nMLZZMapZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bprwO+V+GHuvyPIFuKfLJgHfTc5jQWhsnbvVh/ImKR9T2vRLMOQDc9SPTm7bb9MBJ9kktVxITXpNv89f0ahH1Pk/7fNatk71++XEwcUYxDEiUh84ppV+AYE+NLdClQqdCVM2c3eYWDcldn4xAt2imVgdrVDnCdZv5lSauwjdtZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNElonk3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNElonk3"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-912278ed3b5so572792685a.0
        for <git@vger.kernel.org>; Wed, 20 May 2026 13:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308674; x=1779913474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyrVznUKvHvby3pNi9jvGNzJq+624m2dUnvOnh6Rtqo=;
        b=rNElonk3Huy3rhXluJqc9MW9hcCGEAwbksmtdUt/QMnGUl4XYlyhVZWGAEYmV5sgfp
         jEfkHPrTEbiQZnXIylkwZY8Rl8GQAtmWCcvKTq0XBDgtjufDrEoBbnzZrgPCRiQCD2RI
         2GiNUYMMEzrXAGNwdbt2myleJSE33pjrzL5KZ2T5mh3IzpwI6CvrtVq9y+s8Sy0ybdT8
         48qxe2ZYf6ZxMlF6VySJxUTSJxSo2D1ycSIvItJcrtV3zATemynP70S+y90x6o/Ti/Q7
         6Z3GjS89nePliwhhE6t7t58dVKmWsSlVK0h5sNxXLsFQDmdbfBSv2GKJjBApb9yTchl8
         73UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308674; x=1779913474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LyrVznUKvHvby3pNi9jvGNzJq+624m2dUnvOnh6Rtqo=;
        b=biaJLf0zRz9O8TIPOa0W+zFC1xqlvFILFqm/zdP3vc06XV1CiiWTy1bI7lHLCvYlOq
         3pcAf6ARjsNslOhh1lSt/mouYQbFD9lXs9YVBQRF/khv/PgoVo9fHMLsaJ9RetlJeWHA
         BnmW1Fw6FLXerx0BER0fLm6au7GTCQhvpml6Dg1NbZRoah0CkdIZkzeWR6iYIUqc4UR+
         Kt799lIFy6tC8LvgH3ahx2AQBuC6Ly2FAbA/Mc0toM6UF/w0IURH5OJjs2t8zFp5jg6P
         6c3IEyNkdy5lYoBgEgmQ0iNhJm6SdGHjvZbgamz3GxF9OBwJIy0viBcnKSqeM7cQ213Y
         /2ig==
X-Gm-Message-State: AOJu0YzhyFk48i/kCcCo9kwnW808iOoxVOJGi0TMNhYbQc6YEM+Te9GJ
	rEewfoh8SLSxPdgVDSZ+jUOvtqI/wpPCM/91H8Tx1sQjNwI1ikwgNgur8NBIVyzW
X-Gm-Gg: Acq92OEoVeLSIZPOZdAiJ/liNb4zZpuTCqvuNqMCrfsRbJnB6TsQJgfV8IqZvjMi+Vq
	gQhFVLJ9zVlD95nukV+WUW17T/U48U5HuapaUqJDZlDjX2QuShuHCP0UopVRDDqKybD7j1FXHLf
	8VCtMutoFWz3nxqlg5tlmMa2kBjoJc/dbHyKjUDZkrnbYWsXeXR925es5hfWUq4Q50xwem94Jbu
	HpU6IhCXHudBSR34K2y1f6QQJDd62l+JX8q31qXTLyZC/OJiFXCoaA2N6yE2iroTGLeXh5TIDn8
	jAGrCzJk3SiWEsnXRA/L18FtmUIusmWKPr2zsX6YE3HGzzRJ1a5h7txG+riKhXrTctH+5P1LwCM
	IGRDbC2NW4oM06ZS0ucK+kXvG/8FfkxvFlJ7MVH9W8GgaPj4aHa70H3F90Vm/0olAopZSLWZaKH
	GucAgHoSIQ0vUQNwB6C6oPIpcu5w==
X-Received: by 2002:a05:620a:b1c:b0:914:9f68:cd00 with SMTP id af79cd13be357-9149f68d138mr203680585a.18.1779308673731;
        Wed, 20 May 2026 13:24:33 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361905d4sm129891136d6.32.2026.05.20.13.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:24:33 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 02/11] git-gui: return status from choose_repository::pick
Date: Wed, 20 May 2026 16:24:01 -0400
Message-ID: <20260520202411.108764-3-mlevedahl@gmail.com>
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

The repository picker (choose_repository::pick) on success always
returns with the current directory at the root of the selected worktree,
and with the global variable _gitdir holding the name of the git
repository, possibly as a relative path. On failure, _gitdir = {}. If
the selection was from the "recent" list, no validation has occurred.

There are too many side effects in this interface. Note that the picker
only supports worktrees with a .git entry in the worktree root, so git
repository and worktree discovery will work starting in the current
directory on return. So, let's change pick to return a 0/1 value, 1
meaning a worktreee + repo was selected and the current directory is the
worktree root, and leave validation and setting of _gitdir,
_gitworktree, and _prefix to the caller. Note: pick actually does not
return if something was not selected, rather it terminates git-gui.
But, let's pretend at the call site that pick returns 0/false instead.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh                | 10 ++++++++--
 lib/choose_repository.tcl | 21 ++++++++-------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 4ba25da7b6..4a736190a9 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1151,10 +1151,16 @@ if {[catch {
 	} err]} {
 	load_config 1
 	apply_config
-	choose_repository::pick
-	if {![file isdirectory $_gitdir]} {
+	if {![choose_repository::pick]} {
 		exit 1
 	}
+	if {[catch {
+		set _gitdir [git rev-parse --git-dir]
+	} err]} {
+		catch {wm withdraw .}
+		error_popup [strcat [mc "Unusable repo/worktree:"] " [pwd] "\n\n$err"]
+	}
+	set _prefix {}
 	set picked 1
 }
 
diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index 7e1462a20c..4b06afee93 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -15,7 +15,7 @@ field w_recentlist ; # Listbox containing recent repositories
 field w_localpath  ; # Entry widget bound to local_path
 
 field done              0 ; # Finished picking the repository?
-field clone_ok      false ; # clone succeeeded
+field pick_ok           0 ; # true if repo pick/clone succeeded
 field local_path       {} ; # Where this repository is locally
 field origin_url       {} ; # Where we are cloning from
 field origin_name  origin ; # What we shall call 'origin'
@@ -220,6 +220,8 @@ constructor pick {} {
 	if {$top eq {.}} {
 		eval destroy [winfo children $top]
 	}
+
+	return $pick_ok
 }
 
 method _center {} {
@@ -327,8 +329,7 @@ method _git_init {} {
 	}
 
 	_append_recentrepos [pwd]
-	set ::_gitdir .git
-	set ::_prefix {}
+	set pick_ok 1
 	return 1
 }
 
@@ -409,6 +410,7 @@ method _do_new2 {} {
 	if {![_git_init $this]} {
 		return
 	}
+	set pick_ok 1
 	set done 1
 }
 
@@ -621,7 +623,7 @@ method _do_clone2 {} {
 	}
 
 	tkwait variable @done
-	if {!$clone_ok} {
+	if {!$pick_ok} {
 		error_popup [mc "Clone failed."]
 		return
 	}
@@ -632,18 +634,12 @@ method _do_clone2_done {ok} {
 	if {$ok} {
 		if {[catch {
 			cd $local_path
-			set ::_gitdir .git
-			set ::_prefix {}
 			_append_recentrepos [pwd]
 		} err]} {
 			set ok 0
 		}
 	}
-	if {!$ok} {
-		set ::_gitdir {}
-		set ::_prefix {}
-	}
-	set clone_ok $ok
+	set pick_ok $ok
 	set done 1
 }
 
@@ -721,8 +717,7 @@ method _do_open2 {} {
 	}
 
 	_append_recentrepos [pwd]
-	set ::_gitdir $actualgit
-	set ::_prefix {}
+	set pick_ok 1
 	set done 1
 }
 
-- 
2.54.0.99.14

