Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2143A40FDAE
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542059; cv=none; b=ViKl1Vk1jw7InfR5hFXrHmTzBaMW8YO81H0sLmaoW91MQ/3Jzu86+X4T4fDFynm1N8KWlGY++DyUG9ylJISG8RhcR410iQaa+pl8az+yAdY3kokiR4e+hHAgsIzDtvtw07DMW/hBvfnMkFMgXLGM5eoJMR5XwuxWVTOkxv1fRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542059; c=relaxed/simple;
	bh=AwOhpUcHUsWr+T8M2Vc671I+TIYdPJ/BTufJRfA/A8g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nw9sNgghUXNjecNaTgU6fFtjfWkN6P2/rnBhnXjidu8kwMbWNyQKKIQhT6qe9/BqH5GUSxtHZ7itmM+SwaAGRdwPUOGiomqwvGo6sao1ok4hshCyQePTflESCjutj1+tB6p/uwks6gjh+ykGn3ERAwO15XfSf6gTbTuT/ljiP3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4Kyup8b; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4Kyup8b"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304cf518c9dso5694080eec.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781542057; x=1782146857; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Vjgb/ZBKmAAL4rY4srEyFFd3yV6SamM468Jr/rqP0E=;
        b=c4Kyup8bov0uovyZYhyNk1G/VPtBrQGOJtF4O5dhOdCDmZNQn3D9RKHT2C4rfWK0WU
         JclTvNvbFUgkudco+0kMeN0/RDl7OnhrBS119iJRnARvVjRqJHGhZBKyUU1mpMTDnI1z
         pkO0uhyuyCIdTcTOAF5UlE4WAz5nKNolwGa0yPtk9QAn1fC0YgCrgkyNPIdHjddMiGpZ
         zSCJ/npmAfLpTtSJZirs22/ZdyWQK+vUO2+5AMRxMiSXojt8yodIrw1lzM/SaORsbVqs
         Ta9iIEdoiCWdEFZaLlhGnCa9P1NnSu7MIv8y+j3cbtyCPll21H8Dbf6qojPLuzpFUYBb
         s9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542057; x=1782146857;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Vjgb/ZBKmAAL4rY4srEyFFd3yV6SamM468Jr/rqP0E=;
        b=JPTGAoTB0kUtmfnF7M28v75dHfOU20hpCgFNubUVt2PPc1kWw2wlqyHX+R7soloeiF
         BKjfRJQGkbC0O07oLFRVCK0a6szVNmFW8YyyhxRHCDdYl09zYEyalvprJKjOSO44l9I2
         LcaqzZOuTmfWTbYbirrnc3NF2T4HPIb5yBib/TQ0cia82mmfdZx2+l6Vwxpk6y4b2WhI
         JPDEX5Tp6lACdCPMlYMYD2VdqA5jadbtRglr6c6ccLkggqUqby5m9PVKqhpgC13gSQGK
         aeIknvWn/PgKWNjhQ1bgjg8KTT8ZK1Ha89+wNn0RMoVpzPRz58lO3juBezoJJa4vSD4T
         Nisw==
X-Gm-Message-State: AOJu0YxgbXkEGv55Xr56iDwljNLOLUMKwI/8r8GI+sTY9Q7b5XBDLNdu
	lvRx/IUgRA8Nw4ePsdcC4kq6o+zZfOSXc3vy2qhVrOQhU9tsYr4HFYTi6xnHyA==
X-Gm-Gg: Acq92OFeQ5bMFMTMDIGSKWhxQtgYTI6VbpFeT1AsIyraaAeQaSV1pMWRdvnmbgCmejf
	j2bBbYm0t11vyr47KgMhy2yRsjhdghROkG6vFdm+wgct7FKf22J7+dfKlTGapW1abZswphVD5sv
	2CjQbHTNHvlCjqyv5F18Jv7GBxaqB4yZyQj+vjvLC9EqdG1E59wfA5zMWHUWgjXR3mivNybrX5p
	LU1Axbt1qdmlz0tCo4oZ45ggaDmuTizBiATWYCse4BNw1S6KL4pLcatiIQwiMzfGg1LRF4WhcwE
	c9jOn1ozzazG7gAGD9P9RmgQEWfJbjjEITVSiPDabCbNcHd8asDBaufCaxi2KZH9E85y0zevacI
	5zXzvy3yqOVaGrXTasDla3najNxDPd0bv51s9rab+VxTQFH8JiAfJsFfZANuecgWyrEx7Csu1vl
	L6ILHflUOuOcxtPfPEem78qQm6
X-Received: by 2002:a05:7300:730e:b0:304:dc05:607e with SMTP id 5a478bee46e88-30936a4b4cemr6185056eec.14.1781542057102;
        Mon, 15 Jun 2026 09:47:37 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.162.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0828sm16855770eec.10.2026.06.15.09.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:47:36 -0700 (PDT)
Message-Id: <72aaca0666457a29705de9525ee0210b4fc5805f.1781542042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
References: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
	<pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 16:47:21 +0000
Subject: [PATCH v15 6/7] branch: add branch.<name>.deleteMerged opt-out
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Setting branch.<name>.deleteMerged=false exempts that branch from
"git branch --delete-merged", which is useful for a topic you want
to keep developing after an early round of it has been merged
upstream. Unless --quiet is given, each skip is reported so the
user knows why their topic was kept.

Explicit deletion with "git branch -d" still uses the normal merge
check and ignores this setting.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |  7 +++++++
 Documentation/git-branch.adoc    |  5 +++--
 builtin/branch.c                 | 14 ++++++++++++++
 t/t3200-branch.sh                | 30 ++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..d8483acb4f 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -102,3 +102,10 @@ for details).
 	`git branch --edit-description`. Branch description is
 	automatically added to the `format-patch` cover letter or
 	`request-pull` summary.
+
+`branch.<name>.deleteMerged`::
+	If set to `false`, branch _<name>_ is exempt from
+	`git branch --delete-merged`.  Useful for a topic branch you
+	intend to develop further after an initial round has been
+	merged upstream.  Defaults to true.  Explicit deletion via
+	`git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index f82cfa36d0..91700f2e8a 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -215,10 +215,11 @@ A branch is not deleted when:
 +
 --
 * its upstream remote-tracking branch no longer exists,
-* it is checked out in any worktree, or
+* it is checked out in any worktree,
 * its push destination (`<branch>@{push}`) equals its upstream
   (`<branch>@{upstream}`), so it cannot be distinguished from a
-  branch that just looks "fully merged" right after a pull.
+  branch that just looks "fully merged" right after a pull, or
+* `branch.<name>.deleteMerged` is set to `false`.
 --
 +
 A branch whose work has not yet been merged into its upstream is
diff --git a/builtin/branch.c b/builtin/branch.c
index f01e03cc26..0e1e7c2e6f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -739,6 +739,8 @@ static int delete_merged_branches(int argc, const char **argv,
 		const char *short_name;
 		struct branch *branch;
 		const char *upstream, *push;
+		struct strbuf key = STRBUF_INIT;
+		int opt_out;
 
 		if (!skip_prefix(full_name, "refs/heads/", &short_name))
 			BUG("filter returned non-branch ref '%s'", full_name);
@@ -753,6 +755,18 @@ static int delete_merged_branches(int argc, const char **argv,
 		if (!push || !strcmp(push, upstream))
 			continue;
 
+		strbuf_addf(&key, "branch.%s.deletemerged", short_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!quiet)
+				fprintf(stderr,
+					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
+					short_name, short_name);
+			strbuf_release(&key);
+			continue;
+		}
+		strbuf_release(&key);
+
 		strvec_push(&deletable, short_name);
 	}
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index b74e119d3b..5ac3c2bb5d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2030,4 +2030,34 @@ test_expect_success '--delete-merged takes positional <branch> arguments' '
 	test_must_fail git -C pm-positional rev-parse --verify refs/heads/two
 '
 
+test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
+	test_when_finished "rm -rf pm-optout" &&
+	git clone pm-upstream pm-optout &&
+	git -C pm-optout remote add fork ../pm-fork &&
+	test_config -C pm-optout remote.pushDefault fork &&
+	test_config -C pm-optout push.default current &&
+	git -C pm-optout branch one one-commit &&
+	git -C pm-optout branch --set-upstream-to=origin/next one &&
+	git -C pm-optout branch two two-commit &&
+	git -C pm-optout branch --set-upstream-to=origin/next two &&
+	test_config -C pm-optout branch.one.deleteMerged false &&
+
+	git -C pm-optout branch --delete-merged "origin/*" 2>err &&
+
+	git -C pm-optout rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-optout rev-parse --verify refs/heads/two &&
+	test_grep "Skipping .one." err
+'
+
+test_expect_success 'branch -d still deletes a deleteMerged=false branch' '
+	test_when_finished "rm -rf pm-optout-d" &&
+	git clone pm-upstream pm-optout-d &&
+	git -C pm-optout-d branch one one-commit &&
+	git -C pm-optout-d branch --set-upstream-to=origin/next one &&
+	test_config -C pm-optout-d branch.one.deleteMerged false &&
+
+	git -C pm-optout-d branch -d one &&
+	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
+'
+
 test_done
-- 
gitgitgadget

