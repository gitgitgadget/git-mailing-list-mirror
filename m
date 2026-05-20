Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324236A036
	for <git@vger.kernel.org>; Wed, 20 May 2026 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308679; cv=none; b=ppgHpUaFOARqveU16N+dKE34bo/RfEt3DngjBW8wBiPkd6bDuWiB18QU2HRqofWEYPx6mnTv9+WQwnyCTW7MPljBLLVGziOFUKA7BLLC2nEWd95DbcsV8L8RiA6ItOxbCI/1DYRm7Q9XmcUXZZBb4NnCmLDBfAvX3fSF2KxOslk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308679; c=relaxed/simple;
	bh=SPqhH4imTpAFeYWCiZG5UzaDiCDu/sE/92er8ElaZhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUeEbHcHn5gzlnszKZP7RQBb0oSBvLJNmGXrhrV69W0ABCxBmXzqfaRyHOZP+OzcGn0XIokkq5Q6TBawxWqp1DdDH8Js+6bj9K+CtmuTgizy/DZongRXOrmeAEaaI2gFaVWOH4RGor/Z/7oSB73Lr9h6MnBn+syolaNXFS0gUQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1b/Jzhg; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1b/Jzhg"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ca12973e15so72458936d6.1
        for <git@vger.kernel.org>; Wed, 20 May 2026 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308677; x=1779913477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2HORxDk49WWFM4yPHgO4jj8Z7i2OAkf0gvVSt0CsCs=;
        b=F1b/JzhgF7vlNLFZoYUyJv1a3ZRP5sNTE2hAo1FLDCHZvZ6pdX+pxZUhKaOnORCOB0
         lN7uCNPY3i/JZa2S5EK5S+7V/cOhU4idJuaeIoZuFCb4W7WkMtaVPP/vbmz1HUP+R3FF
         6rfqGiXgSzc6PuCAbJ2YDxEz28HpawAp31v1ki6V5CFFVReT3Pba45hcSftYS0ybv/We
         vNzRD1mc28e2fOEQpua3CdNPtm1u0gLMluw/ZkByerJkSjNwft5SkwnZ3CGzxC/Q0fLK
         2ZnRJl06/ecGMm8kbFQMA4owtmseGhOVfb6KZ7JwBQ6SWNz0MqKmL6n3mIj9QDBtwDUq
         06oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308677; x=1779913477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2HORxDk49WWFM4yPHgO4jj8Z7i2OAkf0gvVSt0CsCs=;
        b=mMPxs3wXQEwJIpU2KiGo599B+VGbD5mTRF2nkCepXgBN/WI5fR9zAAbmg6ki6eOrnG
         Ja6PlirB4Zb93x7CQExC1WJlPHeTUe5ms+bmJFhYoISTwBmhOdzUofvWhosGj8mgemQw
         BjsWGBig179thidC98AlTFiNnjeYdpdBrmEsVhFvQL7fTH+oQWwcP7ykrEpJb9CdNoRA
         8w/VEIy65my5ww/NOpAwj8cfYGgKefet7ovN/tA302/DXtI/Ypd5Tc5v5a2WDnkD8nH/
         ITmBdjfz8A+tE9RlVddUbM//ynq6RMK3eYr5tXfYsjaaTFFQd0dXBmWfrY+EqR3xMdRe
         08fw==
X-Gm-Message-State: AOJu0YxyUIW0DUToQHvSx0c8hAS23Sq2HAA7eEJuExgWT2YZFiAD+qcf
	t8FA436OqRhwo2HmBrPYIAncUWwLlvCiS3dxcj7YOlotB3RIh/mo6r2Fu9qLGmif
X-Gm-Gg: Acq92OFSjtuu/pGdF5BdxNCHYL+nrRK7X+rUTiN0RrUPzdYRVDEjA0Id9gClJHQx4KV
	LetXerj54ZMN/gBwWy2+BvT0eCfRMdRnF24arQomEA0lQaQpvNejYR2bDLf4yhK8qfdv3Pn7G69
	cfymLx2ReDGgcJgfdDYN/0FyBH2fv866hGCxCfdcgVSbG3cGa/tpl1nwQ9ltga1w3mWBrTgUoR8
	a8T3zW1IP/xfH+iHsdjy0jDo/wMPJiWmzZtnRrDC6D7H84cywHPwjzwzhLU8gpAbvwd3I9YKGlR
	jvapCIZlPRjMt++wPlV1CAydSJot+bmyvUs96vG8I4dfD4Cix72saLPFDktRYYE5Y6VxjU3Hmps
	KpbK+YwWwuBDRxGznR/z8Nxsu1LBLbwnn0FuMd4O26eZTZnpc0G+i18LwxhGlL03OpRgmSUJgya
	OOYfBG0AATmo454Ru7atznHX0YQg==
X-Received: by 2002:a05:6214:310e:b0:8cb:eab6:74ea with SMTP id 6a1803df08f44-8cc6e3480ebmr227546d6.22.1779308676847;
        Wed, 20 May 2026 13:24:36 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361905d4sm129891136d6.32.2026.05.20.13.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:24:36 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 05/11] git-gui: simplify [is_bare] to report if a worktree is known
Date: Wed, 20 May 2026 16:24:04 -0400
Message-ID: <20260520202411.108764-6-mlevedahl@gmail.com>
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

git-gui includes proc is_bare, used in several places to make decisions
on whether a worktree exists, but also in discovery to tell if a
worktree can be supported.

But, is_bare is out of date with regard to multiple worktrees, safe
repository guards, and possibly other relevant features known to git
rev-parse. Also, is_bare caches its result on the first call, so is not
useful if a later step in the discovery process finds a worktree.

So, simplify is_bare to report whether git-gui has a worktree or is
working only from a repository.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index c61a6cbd8f..936c309e59 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -372,7 +372,6 @@ if {[tk windowingsystem] eq "aqua"} {
 set _appname {Git Gui}
 set _gitdir {}
 set _gitworktree {}
-set _isbare {}
 set _githtmldir {}
 set _prefix {}
 set _reponame {}
@@ -524,29 +523,7 @@ proc get_config {name} {
 }
 
 proc is_bare {} {
-	global _isbare
-	global _gitdir
-	global _gitworktree
-
-	if {$_isbare eq {}} {
-		if {[catch {
-			set _bare [git rev-parse --is-bare-repository]
-			switch  -- $_bare {
-			true { set _isbare 1 }
-			false { set _isbare 0}
-			default { throw }
-			}
-		}]} {
-			if {[is_config_true core.bare]
-				|| ($_gitworktree eq {}
-					&& [lindex [file split $_gitdir] end] ne {.git})} {
-				set _isbare 1
-			} else {
-				set _isbare 0
-			}
-		}
-	}
-	return $_isbare
+	return [expr {$::_gitworktree eq {}}]
 }
 
 ######################################################################
-- 
2.54.0.99.14

