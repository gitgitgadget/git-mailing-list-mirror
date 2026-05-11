Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6662DB7A3
	for <git@vger.kernel.org>; Mon, 11 May 2026 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482717; cv=none; b=ex0JqHDi2ipuk03xfQZf8cIXWmj/BhKbLHYAxAjqoDP4GMUzjd+pb+toefYsPQIYu80aQ9b1jaizFotQbPo2yxFXHJ+tZBuAUJ+7OtKx6AuH7ql3D9CNc1P1BL7UHndH8mdUp7wYY6MLhIg00XEMRQTkYZ2pYnDxIlwA5aawC8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482717; c=relaxed/simple;
	bh=yT+o62yAXT/D84VrkzQ9c5MAKAq4vhT81AvBDf2HMeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RqOaAVXdO2HhhTdc1lAr0zj7SwLKq6oihZOIrf98niWHpuFgYouSVI57OqAztOGUzPnwXRsOyJ3iuSnVWZPVR2EeAV7gp8A0XqZu5paSX4kmBTACwxWlwZ3nltC7ojMUTVioAl11OTAqp+vs6zn/Txao2HH05Az3jdl4yT/uhnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKBO8YBh; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKBO8YBh"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51306c36c3eso36405351cf.0
        for <git@vger.kernel.org>; Sun, 10 May 2026 23:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778482714; x=1779087514; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yeg66v6kvOfuzDGUnbddN5gBrn3lQF4J1+DDnlwVl0A=;
        b=EKBO8YBhfHPth2c8pEOxzPiNE/+6cPdc9V335RgEuuo5HuYxPqUsGUgDmZ579i91ve
         WF9EsMVxF1mnO8EGiZHgaSBujt1uQWtkgMntGHPacqKld6/cEk74UVL8DAPnz2iFeVPr
         CsnYdDhNvfc/UxGd4C1CE4HmnRoUR0rpirE3tkNcvauxqlb3nS6Zj0/zNWzqBklKjsGp
         Yb7mtHRXMcynfzUUewV9bSWMODL9Zw51d+oTqYRw+LyZpIqcGj0c21FEKh/s8YVpDmRG
         Zd+ENwxyYl1VuDgjXO/IGtA/LWMn5DDc8BVLbIBH6UkiVD7WmPRcFG/zoumRsiaE5itU
         xutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778482714; x=1779087514;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yeg66v6kvOfuzDGUnbddN5gBrn3lQF4J1+DDnlwVl0A=;
        b=pkCCsE0rNEcynx8w/+IlXMDI3fL5FkMvRpAW0PxCKHh+ieGYdwNdB50z1TXMiDQ5eO
         T2+uKiToa07LLx/Sk08v/mcS5uSFxszdnSkfjO2vggRMr863f39rAR2DwEWfrJcoxllY
         33xjuGhUy4NX4s5Vgf5VQ2jtTeGBKvXV8B8QJOE1DksPZEYnvebxHhoWcLvGCqBEB5F+
         1h7ZPmO/DMwC7HVgpeN7rSiaswB7Njp8CHJopqF4FxIjSEyc1ONhcFkA2higabyTSruc
         PsIEREQky90LbSBHd3kbX7ZRZOOnCgryadqkDORAy5b5yQrdr+DpMaEj+QRlm95wvrU3
         q9Mw==
X-Gm-Message-State: AOJu0YxpBhdAaKKe1qfL4nPPaccmBtvc9pVn7Iy1fGV5PKkFS9GZcUhv
	BKcsTfZ0KkIElYbw8rIiqRM0mEWh6RigxmLxdXtZr2+sL8BPOcZ6nNWpIiUv8l8Y
X-Gm-Gg: Acq92OHIJrmvOcz1zYDuUySGVeWU/h4lgQAFJA3n2MyosydXgN3ITNZ/RZOBF1kMJcx
	OARZiZ/a0P43Q4EfJ/xqqORictyGpGitKbqX7PfYk85UN9ATAS8Q3G4yJ88xJXl4o2pTN/kV+9M
	d3j6aUgWdJSGX9/tu4us5zKypfNTljBPatdBgLxf5eVMwZo2rN8oYv27YoR3L3rBi3R9UCJ0w7+
	52qVxGpcGhSVjXmRNAgxtWCtK188HoJKGAdsgkUT8+GI31lpQ3qyPv/wsxiErMZ5B2zmKspl3qa
	1P9ZEFMlC5MwQYmZIQkRKm2M6msKhjQhtgEe9Usnl0AWwMTGalPuInCGCf5Gu6D8yqbsl3ahnEZ
	lW5jtzxCkqTwKpEqIl663eRUACI/wjiGEvfsvfbLINi63qeZqjaq6x07PicP1p7kBXBr0NO24dQ
	BFMCjxbXdyaXKP4hiDyI1ru/0J6xw=
X-Received: by 2002:a05:622a:19aa:b0:50b:487c:f3d1 with SMTP id d75a77b69052e-51461be05a8mr294887101cf.3.1778482714050;
        Sun, 10 May 2026 23:58:34 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.236.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bdf9081f49sm112070676d6.41.2026.05.10.23.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:58:33 -0700 (PDT)
Message-Id: <807c9f981fa05bd6e06228e54ddacb0a397a0f98.1778482708.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
References: <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
	<pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 06:58:25 +0000
Subject: [PATCH v5 2/5] branch: let delete_branches warn instead of error on
 bulk refusal
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
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add two new parameters to delete_branches() and the helper
check_branch_commit():

* warn_only switches the per-branch refusal from a hard error
  ("error: the branch 'X' is not fully merged" plus a four-line
  hint about 'git branch -D X') to a one-line warning, and
  causes the function to skip those branches without setting its
  exit code. Each refused branch is still skipped from deletion.
* n_not_merged, when non-NULL, is incremented for each branch
  refused on the not-merged path, so a bulk caller can summarize
  rather than print per-branch advice.

All existing call sites pass 0 / NULL and so are unaffected. Both
parameters are wired up so a bulk-deletion caller can suppress
the noise normally appropriate for a one-shot 'git branch -d'.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b3289a8875..1941f8a9ad 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -192,7 +192,8 @@ static int branch_merged(int kind, const char *name,
 
 static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
-			       int kinds, int force)
+			       int kinds, int force, int warn_only,
+			       int *n_not_merged)
 {
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
@@ -200,10 +201,18 @@ static int check_branch_commit(const char *branchname, const char *refname,
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged"), branchname);
-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
-				  _("If you are sure you want to delete it, "
-				  "run 'git branch -D %s'"), branchname);
+		if (warn_only) {
+			warning(_("the branch '%s' is not fully merged"),
+				branchname);
+		} else {
+			error(_("the branch '%s' is not fully merged"),
+			      branchname);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					  "run 'git branch -D %s'"), branchname);
+		}
+		if (n_not_merged)
+			(*n_not_merged)++;
 		return -1;
 	}
 	return 0;
@@ -219,7 +228,7 @@ static void delete_branch_config(const char *branchname)
 }
 
 static int delete_branches(int argc, const char **argv, int force, int kinds,
-			   int quiet)
+			   int quiet, int warn_only, int *n_not_merged)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -309,8 +318,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 
 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
-					force)) {
-			ret = 1;
+					force, warn_only, n_not_merged)) {
+			if (!warn_only)
+				ret = 1;
 			goto next;
 		}
 
@@ -961,7 +971,8 @@ int cmd_branch(int argc,
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
+		ret = delete_branches(argc, argv, delete > 1, filter.kind,
+				      quiet, 0, NULL);
 		goto out;
 	} else if (forked) {
 		ret = list_forked_branches(argc, argv);
-- 
gitgitgadget

