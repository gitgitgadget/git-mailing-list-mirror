Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868C35E1A6
	for <git@vger.kernel.org>; Sun, 31 May 2026 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268584; cv=none; b=q8CbtlDwz322bgE6UJzsrzHSV6+iqJLrBM8Ld8VmbAha0wkSJC1+p+iYtP6N1zvyY9HzTe+vFsH95mn3zo52rh/wMgNPPzHrLePEfJ/oxTpH0vawozCA14lDFfvBZNgITQr7Ob/3RT2+QifKKcWXndsRo7w/F4Fu0skDFrLnTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268584; c=relaxed/simple;
	bh=jBJ+Vp67+8pyha5tqqBcrjtcdYF9kbdT8NxwQ/CmLCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXOeevBvoj6s2IynGuAOLI0DiX6r7JHgoNxnK3+cCXa7qzFuBJ5ZvepEcJ41Bb0icuc5VeLLZt6Gky2wTUeJH4rx9uTciiyalTRiQhj9EWtjsa3T7UORqMIVB8YX+Tp5fDjnorx1VNwoeTuIvVDKbScNgZc/PV5FLFNP+SjIc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCsjO+je; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCsjO+je"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ce9df4732cso8632636d6.1
        for <git@vger.kernel.org>; Sun, 31 May 2026 16:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780268582; x=1780873382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNSAuAkkD/045jEdvFRZJQI8dYGYuT+eFZ4XELAJCJs=;
        b=PCsjO+je7idBSp8AlbecODYUZniD5h3nVag6tYMs9IguN+YrS1kBURdOBYZuezI12+
         TXhho9pE+xf6+vAchyqwF4OOFWA4paaDdhTA0s1u2Yct5hjf0KyYscVTboh0eaa48jNb
         Vm31vUkXFE5DNm9QDBryt1vYTnJDSolAx1wAsh802i1/cO6Ezddw0ww/I6J2eDARrIdS
         +AuHCbQki48t62sB85q1iYWoBv9iXrnF4sdA4l0m6uhyA6YcIrZWUWh3K/t1qdkqQ8Bp
         37MHWCobIljVbttoIriqs0DK3s2o8HmH5HR8aRckchVIezd8Wr99XHO+l2ekE959ejxb
         C5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780268582; x=1780873382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iNSAuAkkD/045jEdvFRZJQI8dYGYuT+eFZ4XELAJCJs=;
        b=Cuf9vPNYy7vRxi1kHYbxXivNJ+jNig4CaZ2knG8rkkkI70ZOpfjhnDlJwTDSgeP7xq
         c3fxYSpl7kRpF52KR/tMRxybJToBvtcc2T8AEcPTyBSxrcEzxYB7VfeTebWX9Th7PH4R
         Lhq83rsjPonJOvdtmcfRHlVg8OpJ00eFhM9mPck7V48uEcg+QjwWkOeyjbN96sospsJM
         gk271igglZel52DtO8aYuSxJPAr4GsjoBCWUp5I8DDD1ip83lKhjospF/Wm3iK/r4IO/
         54oJO6+ia+w6tTqGfCEYHT0AJzIBlM28gAuMScLn3P2B4y6OHgKIOcB/urmC/xif6tww
         6VzQ==
X-Gm-Message-State: AOJu0YzLNeG0y1MPr9rWBwRV8xVRllh6NGS7UNyB6EfiVQhXyivzkcku
	j5lhym6HXoyidshlDf+Kdgog7+2F35Kd6rTuZ+X2GJzswARhN0whE+0yZIzoKbS/
X-Gm-Gg: Acq92OEzbKzfQetdl/dT3mK2XQwGlrryCTvis/iqKufHQAHD9+OWRAtKu/FWuxTL/UI
	nhKjwPUlX5zkEfpekzUGDq4K85alVQu6XJCHIBDtHUa93Rmirw3Xi2WnH+WshLhcHqecXf0y3QD
	VgGleO90Nd2nwlmfhGr0RI57JHVxrEJ/JHzMlhD0f5BGsp3YGeb/k+lpB4T6zrQdTt8XmY7fftt
	yd6EiPplyNCAGCH0nDOQp7AfkHpXS1AqdpO0JAmJRGzDTIa29IMQQHSAI3oTmOAR90jNXXIVbPH
	vewwDwXN0W/bIHk/4vTq/+3gkpf5+k0S4NuSX40+kdlRmCV8eFiz08Niw2FERUxo1lmn7XdthwQ
	FGKxwCusPmd23J+XnK95R24b/RgKzRiV8zK166Yl1qGd0Pkx3n69Pe7jruSVWE9PoJkQa1K5G2O
	7B+GcCNGpr1zM8XtDfX9NjajSsnW6v/LgFeXE3
X-Received: by 2002:a05:6214:33ca:b0:8b5:84:aa1b with SMTP id 6a1803df08f44-8ccefb2bf0cmr148227726d6.9.1780268582517;
        Sun, 31 May 2026 16:03:02 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm78268426d6.8.2026.05.31.16.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:03:02 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v3 04/12] git-gui: do not change global vars in choose_repository::pick
Date: Sun, 31 May 2026 19:02:17 -0400
Message-ID: <20260531230225.126817-5-mlevedahl@gmail.com>
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

The repository picker (choose_repository::pick, AKA pick) on success
always returns with the current directory at the root of the selected
worktree, with the global variable _gitdir holding the name of the
git repository, possibly as a relative path, and _prefix {}. The
worktree root (_gitworktree) is not filled out, and if the selection was
from the "recent" list, no validation has occurred beyond testing that
the worktree root exists. So, repository and worktree validation are
still needed to be sure the new repo + worktree is usable.

pick only supports worktrees with a .git entry in the worktree root, so
git repository and worktree discovery will work starting in the current
directory on return. In cases of error, or user abort, pick exits the
process rather than returning.

So, let's change pick to not alter any global values, with success
indicated by the process returning to the caller. In this case, the
current directory is the worktree root, with a .git entry. The caller
then proceeds with normal discovery to find and validate both repository
and worktree.

With this, pick now returns 1 in the success case, but additional work
would be necessary to return from conditions where 0 should be returned.
Checking this return value would be superfluous.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh                |  7 ++++++-
 lib/choose_repository.tcl | 21 ++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 2cf14d0dd5..44914bddcf 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1153,9 +1153,14 @@ if {[catch {
 	load_config 1
 	apply_config
 	choose_repository::pick
-	if {![file isdirectory $_gitdir]} {
+	if {[catch {
+			set _gitdir [git rev-parse --git-dir]
+		} err]} {
+		catch {wm withdraw .}
+		error_popup [strcat [mc "Unusable repo/worktree:"] " [pwd] \n\n$err"]
 		exit 1
 	}
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

