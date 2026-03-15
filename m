Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E21370D60
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773591550; cv=none; b=Cdnq9FEsPfGvCj+EcRkBJcSfujrECWRAw5iojRr0nHDHx2bgRGHLGvlwRv/XszIRCkmRFamV2rXthGNiRLwcaNcVw9rNGJjw408BGwiDO3gXbcCCI7nxWycT65zmNEtmYCpkJDWIPKiD0CJ56Oa6FfUgsN72pXiov5vAvyeN5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773591550; c=relaxed/simple;
	bh=ocfaaDh765UUHDo1YM3wbzo0nTnlMDB/DxhFcdFqjYU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQ+CA4oRpE2p+DmPEjJ+d8mGJAQQufUJ2+KPFBWePp+lF5DG/1m3AGAQrtfKxs6LDA2uwVPv3XVNUQmIIYlri2xGJbrNUjjbHJBPBHcFSgZsUGiW6O10hAlfa28wcojUpWaafDl7x11egkNG7ld4DPEV7mLhGKjTSM5IywBwa/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT5cPM9/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT5cPM9/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so19420905e9.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773591547; x=1774196347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOzqUq5ZFnLgAd0afdEdL+HTBSILNxVT6niFIrzhO34=;
        b=VT5cPM9/OzoBblF3uIVwcHvGDqMdhFyB9XHNmQQNOZnNHZT6CcYve/BJqnrFfF6iAM
         oettkd98Y2ww0Vmj7PY1F6SAh99RkmT4GMQU49Oj92SVlUNmUzU+FP0xIUc/UKatcmq8
         5qjYVNmr2QnY3Ee+F9KD2E1BvHC/VnYraWRMwhMqYDY2ctz09HOjoJd/0IJn41Fg6qUo
         JKOHznjybYiZQvqWo7im0weIPyqZ2CfOInCM9O+Caj616iRUzZggUXK6MmBEAQ6zKlJi
         LcgstxoP5587nivvJy4blVpd6foAZxWJqduGis4C0F4e5wwI2V9cVGiU3OxTH+/Dvylk
         zA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773591547; x=1774196347;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOzqUq5ZFnLgAd0afdEdL+HTBSILNxVT6niFIrzhO34=;
        b=JbYTEdxTw67u0aGOLJ+Ger6d5N3yB/WAtSA9VeroXQbfDm9OSkTszTlg25SINmClFe
         9PA4sa6O2XYbgnwzU0Ka30By1cDICZgnWPxsZ/5gWNqEqq/eKGqTrMhmmgNBCQ+i76v+
         sFxeQboA84T25xlq1szxkl/BN3tOvHKQ4KLMNo0kDmwPTqSHJ+W/JRRT749zzwZZRb/u
         UmNvesepMZaXfnOjax5zrI+KMN2/ilAmFFnEPUJGDyHC/1H8uuckTpjmrS0S3Rpr0Zgx
         3bCgKYAT3MMsND0hRHfyHn+XAe9o/OASRgX7OjR5ehVqlYm8vEpA/gCTmeeZua2GdSB8
         MT2w==
X-Gm-Message-State: AOJu0YzLAKvMNA0zT7WVgvmVTmISm3vsm+ZPdYuN0NgI8cPaqff2j/D6
	aYqswEPLmXbhCETrTiciVFGVL9omaJf390HfMQW0UU8rZEDIDS3DSqr4QeTd0Q==
X-Gm-Gg: ATEYQzz+2WnEEcJg6h14zVjQhXR0jVR/+3ZO0eIdZWavRtfe8a3OBZ0m8Tqyx0A9QzT
	DDUG6Hq4aGsNanlLPeJvPTawMXO/PF8BSGODsO5B98HltDAv74gqd8KA/+IM35OwK5tniZfrwS4
	Qiznk+bov399cgLESHBcnMOzk/bMZu0OnJvkvw/HtomsAazTmc56KanG44d2tKKLX80njZx5myt
	u2Sj/C6RR4pxC/MjVgWKuu7CEDMPsuh/QDlPdjLvOPIi66QnteMOeJic10XA87KW9MPk0uCrVmA
	r6Oxz3FB+pA67CXeYahyCR0dPYyCyDUUMlgX0bcJztWFVr1x/FLS7lMTJ39PkFiCQ1UKgpIVhJb
	fHmStpKfzsI/0hnLC2D0y9TJ7rMGHeOpO/cMJwesVmg9cFYUA2/JMIKH9y4SRCyRty5eZ2aLHNF
	i35Q6ni1rUwklQJmJeUWEvX0SEREU=
X-Received: by 2002:a05:600c:64cd:b0:485:4533:9c47 with SMTP id 5b1f17b1804b1-48556705203mr159421315e9.22.1773591547191;
        Sun, 15 Mar 2026 09:19:07 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48558fd09d8sm200476225e9.7.2026.03.15.09.19.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 09:19:06 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH v2 0/3] worktree: stop using "the_repository" in is_current_worktree()
Date: Sun, 15 Mar 2026 16:18:49 +0000
Message-ID: <cover.1773591528.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This is a follow up to pw/no-more-NULL-means-current-worktree that removes
"the_repository" from is_current_worktree() and get_worktree_git_dir().
The first patch removes the use of "the_repository" when determining
if a worktree is current. Patches 2 & 3 require a non-NULL worktree
when calling get_worktree_git_dir() to remove the last use of
"the_repository" in that function.

Changes since V1

 - Patch 2: fixed indentation (thanks to Junio)
 - Patch 3: removed stale comment (thanks to Junio)

Base-Commit: 7f19e4e1b6a3ad259e2ed66033e01e03b8b74c5e
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fworktree-is-current-use-repo%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/7f19e4e1b...75eecc849
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/worktree-is-current-use-repo/v2


Phillip Wood (3):
  worktree: remove "the_repository" from is_current_worktree()
  worktree add: stop reading ".git/HEAD"
  worktree: reject NULL worktree in get_worktree_git_dir()

 builtin/worktree.c      | 21 ++-------------------
 t/t2400-worktree-add.sh | 28 ++++++++++++----------------
 worktree.c              | 10 +++++-----
 worktree.h              |  1 -
 4 files changed, 19 insertions(+), 41 deletions(-)

Range-diff against v1:
1:  075700a2256 = 1:  075700a2256 worktree: remove "the_repository" from is_current_worktree()
2:  ae2a368e7e7 ! 2:  c3c5767725d worktree add: stop reading ".git/HEAD"
    @@ builtin/worktree.c: static int can_use_local_refs(const struct add_opts *opts)
     -			free(wt_gitdir);
     -		}
     +		if (!opts->quiet)
    -+				warning(_("HEAD points to an invalid (or orphaned) reference.\n"));
    ++			warning(_("HEAD points to an invalid (or orphaned) reference.\n"));
      		return 1;
      	}
      	return 0;
3:  1151b5b3020 ! 3:  75eecc8492e worktree: reject NULL worktree in get_worktree_git_dir()
    @@ worktree.c: struct worktree **get_worktrees_without_reading_head(void)
      	else if (!wt->id)
      		return xstrdup(repo_get_common_dir(wt->repo));
      	else
    +
    + ## worktree.h ##
    +@@ worktree.h: int submodule_uses_worktrees(const char *path);
    + 
    + /*
    +  * Return git dir of the worktree. Note that the path may be relative.
    +- * If wt is NULL, git dir of current worktree is returned.
    +  */
    + char *get_worktree_git_dir(const struct worktree *wt);
    + 
-- 
2.52.0.362.g884e03848a9

