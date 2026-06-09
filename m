Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C013F4115
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999926; cv=none; b=RMKVcWgYYRgdH43CPBMgOM++ORGfcmu6auH345ko9nISAaVMDYiGq3ncpapodXFHazDpx7w9Kr8ZQUbOHpNze7X9Vc69YHLdz1jMn0LcyGqaxsP/ri73QDDeZirRC8tUBjday2sNKyHXG+z0xiAZeHKNhXSk2OVeW8/s2Dkl+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999926; c=relaxed/simple;
	bh=ZJiOjoGvKgxgUnKw3Qtdle/FfmKWmq/m/unvsWhMAUk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sNB8pAG9tASPZtmuwUYjiv6epxWB7tTeyj18a317Kjmmd3hEsvTvjn+I9LUlW+A+qj/g0jj7bjXSjPrmI6YlVRJXmwwiUCv/ZY2RysbepEnxMkSN6LOZ3Ii8pV2+lP45amJFGLxE//WpddJzOxbxDcx+aFGp5D/a8+6AyzvjnKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzGtpsTI; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzGtpsTI"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91574384cc2so614654885a.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780999924; x=1781604724; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NyTJweUfa7oL8OAYIUfBQyBSP7mipEqOBnPGF96Le0=;
        b=AzGtpsTIDSx8Gna1y5ct/GPSRMnLXa4BEY085a8VP+4UUt8+RePsWM3SQuIhSEekhp
         QhuYpS+tugaa26Yysgqtia6UDiczLqUq34tUxGHeiZ9oiKbD8+tHFQfYPe8miKM1xXc+
         SlRUIYmUpedhc8+kIY4lj1p5YDWE25zWgvsCTuBdcPBMuGPz+wserC5Wq7KKwS6LdVEL
         P8e/r5FpfU4sxz8k33wlpOe9WJSNrSWO5SrI3/LGcrWA2nyhcWVv7svPM0/XPuGO1yvF
         cXhsv/zUDUF6s2qqBayDv8REURWpMBXxWY8r/oCDVgBa35ckD6vs41dvIswkgwAmdZDf
         T8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999924; x=1781604724;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+NyTJweUfa7oL8OAYIUfBQyBSP7mipEqOBnPGF96Le0=;
        b=aDo/gwVi10aCa/g89K7mGcREAnO+C3aDB+/n2NomiXNEtfdH59XIaEKgOFiPCXWCW5
         NaPDBBj4q4sOP15D/burT0vhIui97uTazgoA/Iv/t0PPcuczX+GsrJRAzdrtIiTHYyYl
         dKfqvRwqQscG6aBD2JGnJ/XFtOgvJubeJHwXRExiKOfLTISKeiRLdtryHzvhbXtixjgV
         Nb1kVzBr5wYyXHOjv8qT7+80RGa31EkbdFQgJ0cn+NJWO2LEUSFj21AHALoa9ipl7QJ+
         qU2xoo7C0SDr2T9WYUOgBlenRF/2YBxAvtIUjynjGvyERWu8/qlZ7M3mzkRmn//HB12f
         h12A==
X-Gm-Message-State: AOJu0YxWSQozhovxuYFJXIvdVzYbXceXOIcPdfN8jPUvNZhJxfT2pZ3H
	ig2+ZC68F/jzzsomqA3XdzOnZ9HBRduboZYtdaaW+2tTn4By1V2nE8/xsfiqT6Ak
X-Gm-Gg: Acq92OGzYjeb5ncmcl2eNFuXIoY3j3tnTh7R53WDyoAQpDPfiwc1IUXiK1os5BKy4ES
	hv8yELyT+Mz7eOJk7UlaH8+h2+CAfv+2XXoSBu75ExCN+v6BbRrZWfwGTZHM0c3JUEYqKC61dKQ
	NJeBwpXw2YQ2iS3TB2Pree51NxR3vzI1P63QzssJqmqA/vwAX6jEP6EuR4OpI6ohPrYpDK60ZPY
	z8ASAVCCqmIHQIq3TaW7FFuJACojrfxFSo5YmIz7RL0fqq20yk/9buztNsK48S0Pt0ZWtP8z/Q6
	n/y5xCKA3a2+pPGX7kQGbhDpN86YWevsfjRc7OU0TW2zr/SNFQBruiO5weUIsg5hU99QGF7OnWl
	A+L3m3waBjLkLGP+EboQdI4u/iiAkba9zyi57fjwEfWHIXvFXhNcsiypIGMIbov0DRB2F5CCJKh
	fhEUFiRwMthJjbe17LUmDKD5uhOqyrGkXYUi2MSUXFZxf5
X-Received: by 2002:a05:620a:710d:b0:915:cda5:2804 with SMTP id af79cd13be357-915e8361fbdmr277868785a.58.1780999923642;
        Tue, 09 Jun 2026 03:12:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.9.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37c4e6sm2057096885a.26.2026.06.09.03.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:12:02 -0700 (PDT)
Message-Id: <d691d5051b35a569dbd3f4a0488030a7d84d72f9.1780999917.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
	<pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Jun 2026 10:11:56 +0000
Subject: [PATCH v14 5/6] branch: add branch.<name>.pruneMerged opt-out
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

Setting branch.<name>.pruneMerged=false exempts that branch from
"git branch --prune-merged", which is useful for a topic you want
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
index a4db9fa5c8..6c1b5bb9cd 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -102,3 +102,10 @@ for details).
 	`git branch --edit-description`. Branch description is
 	automatically added to the `format-patch` cover letter or
 	`request-pull` summary.
+
+`branch.<name>.pruneMerged`::
+	If set to `false`, branch _<name>_ is exempt from
+	`git branch --prune-merged`.  Useful for a topic branch you
+	intend to develop further after an initial round has been
+	merged upstream.  Defaults to true.  Explicit deletion via
+	`git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index fdaccc9662..5c43dc55a8 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -217,9 +217,10 @@ the upstream refs refreshed.
 +
 A branch is left alone if any of the following holds:
 its upstream no longer resolves locally; it is checked out in any
-worktree; or its push destination (`<branch>@{push}`) equals its
+worktree; its push destination (`<branch>@{push}`) equals its
 upstream (`<branch>@{upstream}`), so it cannot be distinguished
-from a freshly pulled trunk that just looks "fully merged".
+from a freshly pulled trunk that just looks "fully merged"; or
+`branch.<name>.pruneMerged` is set to `false`.
 +
 Branches refused by the "fully merged" safety check are listed as
 warnings and skipped; pass them to `git branch -D` explicitly if
diff --git a/builtin/branch.c b/builtin/branch.c
index af37a0ceb7..52a0371292 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -741,6 +741,8 @@ static int prune_merged_branches(int argc, const char **argv,
 		const char *short_name;
 		struct branch *branch;
 		const char *upstream, *push;
+		struct strbuf key = STRBUF_INIT;
+		int opt_out;
 
 		if (!skip_prefix(full_name, "refs/heads/", &short_name))
 			continue;
@@ -755,6 +757,18 @@ static int prune_merged_branches(int argc, const char **argv,
 		if (!push || !strcmp(push, upstream))
 			continue;
 
+		strbuf_addf(&key, "branch.%s.prunemerged", short_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!quiet)
+				fprintf(stderr,
+					_("Skipping '%s' (branch.%s.pruneMerged is false)\n"),
+					short_name, short_name);
+			strbuf_release(&key);
+			continue;
+		}
+		strbuf_release(&key);
+
 		strvec_push(&deletable, short_name);
 	}
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 27ea1319bb..3f7b1fc3d6 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2010,4 +2010,34 @@ test_expect_success '--prune-merged takes positional <branch> arguments' '
 	test_must_fail git -C pm-positional rev-parse --verify refs/heads/two
 '
 
+test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
+	test_when_finished "rm -rf pm-optout" &&
+	git clone pm-upstream pm-optout &&
+	git -C pm-optout remote add fork ../pm-fork &&
+	test_config -C pm-optout remote.pushDefault fork &&
+	test_config -C pm-optout push.default current &&
+	git -C pm-optout branch one one-commit &&
+	git -C pm-optout branch --set-upstream-to=origin/next one &&
+	git -C pm-optout branch two two-commit &&
+	git -C pm-optout branch --set-upstream-to=origin/next two &&
+	test_config -C pm-optout branch.one.pruneMerged false &&
+
+	git -C pm-optout branch --prune-merged "origin/*" 2>err &&
+
+	git -C pm-optout rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-optout rev-parse --verify refs/heads/two &&
+	test_grep "Skipping .one." err
+'
+
+test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
+	test_when_finished "rm -rf pm-optout-d" &&
+	git clone pm-upstream pm-optout-d &&
+	git -C pm-optout-d branch one one-commit &&
+	git -C pm-optout-d branch --set-upstream-to=origin/next one &&
+	test_config -C pm-optout-d branch.one.pruneMerged false &&
+
+	git -C pm-optout-d branch -d one &&
+	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
+'
+
 test_done
-- 
gitgitgadget

