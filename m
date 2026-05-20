Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9ED36C0DC
	for <git@vger.kernel.org>; Wed, 20 May 2026 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308678; cv=none; b=MBwEyHldH3M96OOPeKNKem2rS9AyiDdYM/mnqfRp0GXFW2h+bx44EiLSiH9ckaZkZzxJrJ0vAD9A2T1xo83O/dP2sq5YrRv5FU894WEsAyJ4/kdinxHPfMt/8aIsPQNIjRpjKqeOWC34cbEuxi67FvEXxQxPvQt9Eme9a7zs68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308678; c=relaxed/simple;
	bh=k/h7PiQzxNuX49hm7AtP2l6x09X7ZOJ3itA9jHx8Vzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kinea9EFBJetMDLTxFgsErvj6YwEBFeYU7iGgESIUhs5dR2RqtOSmotzRNhMRp8hl+sQTZwvsWaQuT9D5RatjeyZjxRgrOJV/YlRB8WngYg01EJTO9iWW49dXlBUl1mQKfJAItjWQVZ/roz7PS3GZUxWIrdUr38MsZSuppnzWLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6D6mwnK; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6D6mwnK"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so96695016d6.2
        for <git@vger.kernel.org>; Wed, 20 May 2026 13:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308676; x=1779913476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxL200UFaVp9iJy6LGiTRFvfCbVKJiv/oDeyqAae/xI=;
        b=H6D6mwnKjvFnxzt6KizpblyJxSW1M36mJmSGikd+/inghxc0RCTpJPszygVGyhgax1
         uuvhtn3+nLd+OP4+eQ5/YhI6Gv9wjUzrr2DD+n3Z4fTnfO/zOreo5I1CkShRo2vU1qYO
         /P5ZbDN7/nE+BILypvjCXt382LBA0URiBufr3SGlbmHxdZlOhKqcU+sLDb3xKcgbJTOi
         cR1baP++hcvCV9ISmToVx4UuTAtyb810fU0dPKwiMuUlbVtEoezPwi48tK01MzLShjyi
         yKeeYhnTMtaKgDpZ56h4mg9PAeAsfg0JKtePuda1lll7h38MhsO1QqVfrWQz13/ABJav
         NXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308676; x=1779913476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XxL200UFaVp9iJy6LGiTRFvfCbVKJiv/oDeyqAae/xI=;
        b=dRFqUr2LRAgf6efxNYLBp83MhUnhnx5QTdH1HaM2FPSrnjWVumlcBGwd/keRXiR4XJ
         HwyvmbMJYIR1klIZsyUN3kkrvphhMxoSECFsWBJszsF3XH568No85G1IlnmJBnQO5gey
         vuHpQ5rIcDDYNOEik6wVFdp3pa5B2CL+BdzeBO8383cZsyZKUK9KblM+k1SLCeu6Qs96
         /bnIJN58GZ6mWw2i/JGOsFaHECxjBBHBfSKfL80pEuurhzUWB03PJo5xICV4BQ7nQY4N
         CerPc9UJHfocraMdbEzENaKafTwQznNAOLE8OTWj/ueq0FOBlUfKLKa/WeZHF3ls5vTB
         qpPA==
X-Gm-Message-State: AOJu0Yzek7nQtnfoNq6RN+3K0piJCdmYtv3EcdUqn5T72rXA20zt5E3V
	mTomjx1Z1e/AC5fiaietFnQMzvNpd1vU/4JYksK4nJ9E5HUAwe9FRYhesy61Rnwk
X-Gm-Gg: Acq92OEcOwniaXzEn6bgXTMBKtxHQWw16bEOn0B+EnsX11Xo3LAJq5wPcgb//ePNWQR
	gOX2y1Dge/MKfFwXd5T0odGakVPLpyEOOfLv3qVmV/AsrpQ5rCVdq91TGZKc5BYVcS2iVXDCunj
	E7kkBtSpe8TLQc/jy4N0hekUY+tDon3xgjaIXgCIdOqgLQKwrizt+Fq9wasnwe+ukfyZ3w4F+2U
	DCgb/Wmiflme+F1ZOFgQOo/3XND2oubCakNqqH+TK2OhopZd3w30y8sVwNhP8R+COHjNaqoHOjV
	6XIu6M7aFhqqb1tk2co/+4Vu7btoiuTPtdrs22qntcVKAgbZ6wfcKPkM5pUA5OgOKNWWd6XOOjT
	1n1UlWMmfUF2jSBjFdhEyUlx+iGDj91tjWHXCr/81fo8MiHRNsVurVkW/OJITxaWwX5luMW/wBZ
	id3WSYTFT0ZO34EXEUIQ5frjAMNg==
X-Received: by 2002:a05:6214:3f86:b0:8ca:164c:a851 with SMTP id 6a1803df08f44-8ca164cab11mr376275356d6.41.1779308675896;
        Wed, 20 May 2026 13:24:35 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361905d4sm129891136d6.32.2026.05.20.13.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:24:35 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 04/11] git-gui: use rev-parse exclusively to find a repository
Date: Wed, 20 May 2026 16:24:03 -0400
Message-ID: <20260520202411.108764-5-mlevedahl@gmail.com>
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

git-gui attempts to use env(GIT_DIR) directly as the git repository,
accepting GIT_DIR if it is a directory. Only if that fails is git
rev-parse used to discover the repository.  But, this avoids all of
git-core's validity checking on a repository, thus possibly deferring an
error to a later step, possibly unexpected. Repository validation should
be part of initial setup so that later processing does not need error
trapping for configuration errors.

Let's just invoke rev-parse so all error checking is done.

While here, let's cleanup the error handling.

Stop if an error occurs and the user set GIT_DIR or GIT_WORK_TREE.
Use of either or both of those variables is supported by git, but their
use also means the user has taken responsibility that they are correct,
so a failure is something the user must address.

Otherwise on error, continue the existing behavior and show the
repository picker. But, let's move the possible invocation of
repository_chooser::pick to a separate code block. This permits adding
separate conditions on using pick indepent of repository discovery, and
will be exploited later in the series.  Note that the picker always
returns with the current directory in the root of a worktree with the
git repository is in the .git subdirectory.  The variable "picked" is
used by git-gui to automatically execute the "Explore Working Copy" menu
item after the repository picker is run.  This is controlled by config
variable gui.autoexplore, and happens after all discovery is complete.

Remove a later check on whether _gitdir is a directory: that code
cannot be reached without rev-parse already validating the repository.

_prefix should not be set before worktree discovery: the prefix is only
known after the worktree is found, and at this point we have only
discovered the repository. This is true even when running the repository
picker: that option provides a list of prior selections, and does no
validation on the list beyond checking that the directories exist.  For
now, just initialize _prefix along with other global variables.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 48 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 233c975786..c61a6cbd8f 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -374,6 +374,7 @@ set _gitdir {}
 set _gitworktree {}
 set _isbare {}
 set _githtmldir {}
+set _prefix {}
 set _reponame {}
 set _shellpath {@@SHELL_PATH@@}
 
@@ -1122,6 +1123,24 @@ unset argv0dir
 ##
 ## repository setup
 
+proc is_gitvars_error {err} {
+	set havevars 0
+	set GIT_DIR {}
+	set GIT_WORK_TREE {}
+	catch {set GIT_DIR $::env(GIT_DIR); set havevars 1}
+	catch {set GIT_WORK_TREE $::env(GIT_WORK_TREE) ; set havevars 1}
+
+	if {$havevars} {
+		catch {wm withdraw .}
+		error_popup [strcat [mc "Invalid configuration:"] \
+		   "\n" "GIT_DIR: " $GIT_DIR \
+		   "\n" "GIT_WORK_TREE: " $GIT_WORK_TREE \
+			"\n\n$err"]
+		return 1
+	}
+	return 0
+}
+
 proc set_gitdir_vars {} {
 	global _gitdir _gitworktree env
 	if {$_gitdir ne {}} {
@@ -1138,17 +1157,22 @@ proc unset_gitdir_vars {} {
 	catch {unset env(GIT_WORK_TREE)}
 }
 
-set picked 0
-if {[catch {
-		set _gitdir $env(GIT_DIR)
-		set _prefix {}
-		}]
-	&& [catch {
-		# beware that from the .git dir this sets _gitdir to .
-		# and _prefix to the empty string
+# find repository.
+set _gitdir {}
+if {$_gitdir eq {}} {
+	if {[catch {
 		set _gitdir [git rev-parse --absolute-git-dir]
-		set _prefix [git rev-parse --show-prefix]
 	} err]} {
+		if {[is_gitvars_error $err]} {
+			exit 1
+		}
+		set _gitdir {}
+	}
+}
+
+set picked 0
+if {$_gitdir eq {}} {
+	unset_gitdir_vars
 	load_config 1
 	apply_config
 	if {![choose_repository::pick]} {
@@ -1160,7 +1184,6 @@ if {[catch {
 		catch {wm withdraw .}
 		error_popup [strcat [mc "Unusable repo/worktree:"] " [pwd] "\n\n$err"]
 	}
-	set _prefix {}
 	set picked 1
 }
 
@@ -1175,11 +1198,6 @@ if {$hashalgorithm eq "sha1"} {
 	exit 1
 }
 
-if {![file isdirectory $_gitdir]} {
-	catch {wm withdraw .}
-	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
-	exit 1
-}
 # _gitdir exists, so try loading the config
 load_config 0
 apply_config
-- 
2.54.0.99.14

