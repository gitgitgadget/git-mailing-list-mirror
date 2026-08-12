Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE53AA1A7
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521819; cv=none; b=OHw2NkJanoksQumuEXaSSoAlr3choEpCFtuHE/gTPPC/s3/b+NPHpKO9BdHIAxEPSm/xWuHPCnVqXrfmmIeQpbGwxjiVjn+5xG+Sy+fH5dXJAv1i0IKlHPhn5bGZ8pSKTH4mRDVhfOwP/wyqOL5q9PqUJcaICVuv4DdgGkb1/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521819; c=relaxed/simple;
	bh=9p1d/2ZxlkVC6Ot/WuXtaSnMCGa4vkRpA7CvJs0SmKM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uYt5rhxRIWtghlhGIcaInJknXu0Drya6nTYlvQV44qsqyCODK0gFgHACGcucAs0BpuSVDkcvA3KYpxlWQN+NMFPo06qNEqO9+waIOZgHvhl9gRhcOImy7KVPlExtfPTE+/5eK35Rh3lVC4UlWF7hArg7ulTVWoKBQ2Jj8Z8yFkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh+XVymG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh+XVymG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc73e322dbso9325515ad.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521817; x=1787126617; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xd/A+hmKtkRs01f13DH9aAmHgIzByKpFOtQFV3wiz/s=;
        b=Dh+XVymGkizyUgAIh/2RhzX6GsRGCFEdFCdUK2VFqtU3hpgszsxokgER6N03bhPs8v
         vLt/2f92sXRBIKgbxa0TuZ7KFuZXlc8BJn5WT7qV2abeEJcAEx5y+X+OkOazZx+LZFve
         PfN3uCkG0QSxnS/dpDifWE2nVMjE+g7BRt9oQgmIgU7TOtlA4idYYzWvGEWj5keSg4o7
         avJnl898YH8Att2gqZl68lgLnVaCCqXFUxcdClavhC5jrcqybtZ8WXAKYEi1nRMX1Ski
         5hP9VuaYjeq46PaRfHUMdH0XqFqqQJAwhjNVrP0egjzD9IZhEurFTj9xr834VaDN48cL
         suog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521817; x=1787126617;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xd/A+hmKtkRs01f13DH9aAmHgIzByKpFOtQFV3wiz/s=;
        b=XEDqIrzhb6+hSyDMgXNbUCFdlOkFjMEOOO4CxZs4jQTHZG5DqTBPhPilQqTla7HWsS
         DFdIAG7jYQudoahHlKRpwhr137BmgMTRiLdn2RS3td4baGhQJE4PFXXjNvDsRmTDbQOM
         a1kjcznQBJemroXVuWVxHGmGxGTYmDENhCrkaWCiRswAqjoCjualw2Bqh/P4T0JFTfLd
         Ej1HxGSDjV5mselzK3c1c74gqjN0CYbsqi0HKkSFnXCqoH84X9rLEBXHPQB3EZu4RIZ7
         CNlPc2NT/gUYNM5t02NVXsMtYYrHBSFJ+Y7DHoRM5PIXat9BwOUHKvU1QEn68BxChQ9u
         xhoA==
X-Gm-Message-State: AOJu0YwI1e+sTa3GiYiBRyiGQ83YfPUnoN8rpcjbkDa2uzUsb5Ruvo/1
	qrEzICtGfAFqyYmIebEQ65URlXSdzsFDtp9sMqQgZBeiKSYTAYEvaO0aAePR6CHv
X-Gm-Gg: AR+sD125nt5uEAlkdaPKqZwAhg++rraM5rBqVOj0D8607JBXxQqtalEUxU2oKl4bfNh
	DMybFEkRNlY95AC7CWn7gFBZO/IjRYM79S6yu8DNTMP2DVFnXN+VB9ZgVMZG3+MFRwERC52lNcB
	lJEoWEOrwZpbBwRmvimqfBhpfsJRHuq5cqox4MGcbkT/vJ97zUDc+5WJV9jrpJjEQHHYOj3w9hB
	7p9dWzp/jt1bwhwU9Q2Df4+lEzoV9Z3B05ZJ+FO4cKol1zk1XG51rJXquMCWT4KPG+yI7ZgyNVS
	izaVPIUlzXUkwF7IM1Bt6T7EjmVvbB/Ku2wGSBSkW+H18NOSVuf8HbXcRuZfJcjM23NGDuSubRr
	M7e7b1H8/cH1+p/IUdoaw6cqLCgtTWlPhZPTebysGrZfoYML3qDV1sn7mYQ2IlBswGk8o0f/5hR
	CKFXbJsv2GSsoIXfiqAt+gjc3nyR6XDoJ0PbuuMHTCNSDt1Ou7J03p/9CI53rwJQ==
X-Received: by 2002:a17:903:19d0:b0:2cf:a108:7605 with SMTP id d9443c01a7336-2d345582c53mr38148395ad.11.1786521816931;
        Wed, 12 Aug 2026 01:03:36 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3522328eesm2913785ad.82.2026.08.12.01.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:03:36 -0700 (PDT)
Message-Id: <bf062397320e3e3b5a25505c023eb5c3b2eab87f.1786521801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 08:03:14 +0000
Subject: [PATCH v3 06/12] last-modified: handle repo_parse_commit() failures
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

last_modified_run() and process_parent() call repo_parse_commit()
without checking the return value at three sites. When a commit
object is corrupt or unavailable (e.g., a shallow clone boundary
or a missing object in a partial clone), the parse fails and the
commit's internal fields (parents, tree, date) are not populated.

The consequences depend on which call site fails:

At line 417 (the main walk loop), c->parents stays NULL after a
failed parse. The parent-walking loop at line 440 simply does not
execute, silently treating the unparsable commit as a root commit.
This produces incorrect "last modified" results: paths changed in
ancestors beyond the corrupt commit are attributed to the wrong
commit or not reported at all.

At line 423 (the --not exclusion walk), n->parents stays NULL,
causing the exclusion walk to stop prematurely. Commits that
should be excluded from the output may be incorrectly included.

At line 293 (process_parent), the parent's tree and parents are
unavailable, so diff operations against it produce wrong results
and the parent's own ancestors are never enqueued for walking.

Skip unparsable commits by checking the return value and
continuing to the next iteration (or returning early in
process_parent). This matches the defensive pattern used in other
revision walkers such as limit_list() and get_revision_internal().

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/last-modified.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 5478182f2e..3846244dfc 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -290,7 +290,8 @@ static void process_parent(struct last_modified *lm,
 {
 	struct bitmap *active_p;
 
-	repo_parse_commit(lm->rev.repo, parent);
+	if (repo_parse_commit(lm->rev.repo, parent))
+		return;
 	active_p = active_paths_for(lm, parent);
 
 	/*
@@ -414,12 +415,14 @@ static int last_modified_run(struct last_modified *lm)
 		 * Otherwise, make sure that 'c' isn't reachable from anything
 		 * in the '--not' queue.
 		 */
-		repo_parse_commit(lm->rev.repo, c);
+		if (repo_parse_commit(lm->rev.repo, c))
+			goto cleanup;
 
 		while ((n = prio_queue_get(&not_queue))) {
 			struct commit_list *np;
 
-			repo_parse_commit(lm->rev.repo, n);
+			if (repo_parse_commit(lm->rev.repo, n))
+				continue;
 
 			for (np = n->parents; np; np = np->next) {
 				if (!(np->item->object.flags & PARENT2)) {
-- 
gitgitgadget

