Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD73438BD
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069339; cv=none; b=stSgDtM645VTSXEXi656GgzY8scxreOajwiPa5iu/+XmaWVI+Moul/b9gb+ce5KPtzaNHTvILitHW93u6DImtV25j/XjXI8zN0pc1P/ik3/jrpE37eFfzpirM9sHtV739VX82pVxzUjmpr6lhJzS03bLX7GgtVw3Wu47Y43JUDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069339; c=relaxed/simple;
	bh=FHJtZwXM763J6rK20oCoJUORCLdf13QJ1IX6mvfI+8A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L16eVZwHI/3UGUv8PyJQtJcyUwmNu0OvR3DDHAYxAoqSguvGzaL0EdHQqWX6QsY1X3wUbqnfEBisTwQY+1t2h5GIqyTfaKOhHhaLPPyni0+JKpbEvqJsUNvAcUlSYnn3JSl60TloMqFI6pSuaDpfIrP7Qqml3UUcMlC6Pjp47gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9aKze+r; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9aKze+r"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44cedfaab6bso2083212fac.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069337; x=1784674137; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tBdP5DiDMvSqBRQAHDiyt/CeK8aRleTlQldUt9cBpmU=;
        b=k9aKze+rDBoyQmAngj0boxK6drMzUd/0Y50+eJWpvYW41ovmd8LGHydCU34XZhwTKy
         vRWt+xwTFuZ7ioNTH1ILsmcUoXH1terbLJA+C1J/p8uYBdx/dE99HeWPAYBFh8uzfQRk
         aomhpp3DXCGs9R314MltC8cowtKez6cqu9G9V/4xrJUH65rmqKP5WalLGD8WPN7Wc2lz
         Gceb4/yKiri1fyDz2PiwzGFQJlf1wJkNBg8gIrF9fyj8RiWS+SGoCbijX0ovf7DufnUC
         iSsgx3MojtWnE5/R7rfmKgO0eL1zw6aVQxa38d/HPCJvNDn/eaEr7Btzt5/9UmEqiBoC
         sc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069337; x=1784674137;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tBdP5DiDMvSqBRQAHDiyt/CeK8aRleTlQldUt9cBpmU=;
        b=OfC5AXgU14EPOqNzey6JaIny79b4qzRPupu6C9rREEsxKkjpCIffcb12eN4tklzJu2
         009hiDZ+UoROacz0ZDID0hbhg5tTMLis2iG1cy3pBeUZqi4BxCt/I7EGtuG1pz+TjI67
         4j2I2vOI4Q3/0kvvviTezVE+SsJZVev/Gtwo4AwgbW5dwKs8gA1ZqzM22CeXSbZwT+Xs
         cQ55BFiLmSeUWQNMTSk1U2mZbumc0TaLDba3bLP5daA0BNmELxd3OXqtFjDiLIbxHxJ6
         t8BT+SKGO32Y61e6yhy6eyd9qiocYuodIXBLrkmEp+f3RmibUtiFj6LaD4sRBq3aXPvI
         mgLA==
X-Gm-Message-State: AOJu0YwqmkM5X7/dbnEifOsZtPxw3aac2TBeigwja+TAs+KfXH3oq3oI
	SjXUWLeHr/SD8KME50RmqPl7oSF8uAVuqNkzeIbW2d0EhfZs6P7YeiYKtKR9tg==
X-Gm-Gg: AfdE7ckQxgxuBzp3bP+Mh+aXxb4un60rLa4aV0QELnJNZNWEei49IQDShEoNg51p4ql
	3mjmR1qrMN3bm+Nd7QPPXWhin8h8ycJ6QNxEF3yRQ87XSOajhHirGWFKUABqtQq8Mqm5O+WqqF+
	nO2SZqf90pMprqp/DnUGqV1vPSSnRTAB0rpCw/ENXfyBFIZ4d9egAGxhhBGJXiYv0JuF4OuIdW3
	oTGkVjIGJJewix8GNs5vAoVQpeG47Jir/EAfThbBUOBe6bYzdTNQhYefoNLXJMPnmI4DqM/AZTA
	gJ31KTUUS6RjYYksVVAovzWVHjT44zXmpwK8KQcV4WKdgdi3AYN8OsTx0G67EwW/0J1IVyB7mBY
	UAj+rRTR7Y68E6xY5bYDBrQsZMcvtggQwIjlgyiel6Ut5hOB43e8MBMnHorhR/bCeqrRpXFxU9+
	LCY1JD/dsgsiheG8x8
X-Received: by 2002:a05:6870:1763:b0:447:48b6:83c6 with SMTP id 586e51a60fabf-4562b5054b1mr479282fac.24.1784069336710;
        Tue, 14 Jul 2026 15:48:56 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.178.217])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-451916ce98dsm17523877fac.13.2026.07.14.15.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:48:55 -0700 (PDT)
Message-Id: <f728be4dacb0b9781ef6589a0d2c48009aa31e9e.1784069325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 22:48:38 +0000
Subject: [PATCH 05/11] last-modified: handle repo_parse_commit() failures
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
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
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/last-modified.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 5478182f2e..fe012b0c2e 100644
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
+			continue;
 
 		while ((n = prio_queue_get(&not_queue))) {
 			struct commit_list *np;
 
-			repo_parse_commit(lm->rev.repo, n);
+			if (repo_parse_commit(lm->rev.repo, n))
+				continue;
 
 			for (np = n->parents; np; np = np->next) {
 				if (!(np->item->object.flags & PARENT2)) {
-- 
gitgitgadget

