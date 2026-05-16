Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228E73E5A33
	for <git@vger.kernel.org>; Sat, 16 May 2026 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778947187; cv=none; b=Kn3q+T5zIFxPX2BaEnfDvg8YR9wIg40GgA+4IyTHg6VZcgt3z5bBlS0l31CanaREsENU0hPvAY6WkfXSB8wr06A+ZUL0IakRYqu2m70ZkosJ+CFO0QWEuEK63Abutm8dEIB6TO2/GAPlDDHLWS3YBTCKNKncOSr03C6Q/7OjYg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778947187; c=relaxed/simple;
	bh=E3VON3do09vs20bQYpxjaupgf2QNXsJQ4yJxNpJAEUk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nxppsgEgs2xWy/cw+7PPbw+UThseCgecarQAZpxaNc3NvoYga7lcus6dr1flgUZtltRQCKQr44kVeWkxYX8QKKBiHAZL4Lp0c3SLsrJDE3IwabrecNGWLchsZr1V/sW32fa06IzmQNGq/IdO+XwIV+h9qVBLbkYW3PtUQvfCGTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc08ged4; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc08ged4"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c8f9846c8so936226c88.0
        for <git@vger.kernel.org>; Sat, 16 May 2026 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778947185; x=1779551985; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufeFCFjYHciUgRv320DEOzunlz9r5P1xLDmKYNzv9oo=;
        b=Mc08ged4hwvmWUn7TI6Q/UouV3NkSyfXdVR1HeTMzQo7U2Va3yM+5BU/clIEYhb3Yx
         Bzv4ZGCGAdZj0plLSzxpmjaPPWMGUKJsM3iTQ5NzXcPjMAJi3raQoWSvqPrVVJ3Pbqvb
         DWatGe020fNtCFTWiGUqVExSXn0Nb9uKr169dL9n+sOmRjN77Pni4NfS5s+7m5Mx4DrQ
         P+biufgSo4cUtqHh9N39tr1YcGdhSGsP2OJ6x8IQbM53EGr720Phl7NM1ReNAKpC/vFq
         MdMz7oHN8d4KDbSSAEsP+gcKZMB2vdBzGw2B7QdCOXpkG0ghZ4mjPXz3Q3/E2tZ/cdq7
         hUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778947185; x=1779551985;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ufeFCFjYHciUgRv320DEOzunlz9r5P1xLDmKYNzv9oo=;
        b=mWJiGeiM94P+1w0oPmznvI1o2lSLgcXNtUtFmN9GB/Z8rrn4Sr80SnnbYQTD04wvL3
         cn54Q4SISykjox4ch5DI96bTgaAszeMoYEI3vMe1R5fTJwtGptuIRCJ895D2S4oblSvG
         wTN0y2prCzFEz27bnnfjnDGYXYywb+hRxM+ASt1enUYG5nUSXHw18kZevd7BAwrZs2vt
         9bdEPDtTMRO6Nx55EGvWUuoZFICxnmrrGf5kzgyx79jqnbWf3g2xGFY2zMRs3qbLUW9t
         eov1lc5JU33DNy0iGzXH7lzBc4xbptG4XN/a3EL0h53HZlrS5JOiBQ6TnMKDwGTnC9HC
         qBRw==
X-Gm-Message-State: AOJu0YyfUjXp9K49PuahCW6I9yk1QqqoMYU6Xf86AmlbBjxiQOkUN4vW
	dXKvC3+3gck0HN+m8HcHleyf0n55KnSJgDVe7fnIDVgbv3vqRRvH4OIpc1PLqw==
X-Gm-Gg: Acq92OEkdFwTjXeQ6trkMPr7puuuhptb4Yx4npM/vVu+Q+0JwEtlQdeRpXb5wXQYQZN
	tE3PReGtgpZk8sy8SFlvVQv/jhtOE2+p7SuqOCNEnmusZJNXH7I5j123Zoi/Tvuc2gm48jfBVR7
	RTiHadbTkRCYFMrAo24no7am4alvBdqECj6/Y1RAo82z5shgarcOOOZc7I3Z59fzsz5ejxvKWOb
	DN9plNjwhKKc9F11E/xlmGPppO1Ydlq+uqI+VMr9YSwmrrRcIekIY4HBU/c/qJ6Al0Yy04RcS1x
	r6H8xu9alinDBhbasJFJRuouLGUT1m1tzNJ0z4SLPhFRkBd3Usxs8qfGsm31pVc+nyqk84nQK8B
	3RSj7YFVbK4/BeeW7Rg0kk052SJxTB8yePAE6ZXGjpb1EHDx01lR74wNb19PZwYJE1cv0EyGsQ+
	a4DsstifYKMzgIQS9oUiIhaoZwxvPn
X-Received: by 2002:a05:7022:ff42:b0:12c:8b9:7200 with SMTP id a92af1059eb24-1350451728amr3677811c88.17.1778947185091;
        Sat, 16 May 2026 08:59:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc3490bcsm12176694c88.15.2026.05.16.08.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 08:59:44 -0700 (PDT)
Message-Id: <7399a12518e2021bc8f7cf3fc1f2996099f787b6.1778947182.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2116.v3.git.1778947182.gitgitgadget@gmail.com>
References: <pull.2116.v2.git.1778922993480.gitgitgadget@gmail.com>
	<pull.2116.v3.git.1778947182.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 May 2026 15:59:40 +0000
Subject: [PATCH v3 1/2] commit-reach: use object flags for
 tips_reachable_from_bases()
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
Cc: Jeff King <peff@peff.net>,
    Kristofer Karlsson <krka@spotify.com>,
    Derrick Stolee <stolee@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

tips_reachable_from_bases() walks the commit graph from a set of base
commits to find which tip commits are reachable.  The inner loop does
a linear scan over the tips array to check whether each visited commit
is a tip, making the overall cost O(C * T) where C is commits walked
and T is the number of tips.

Use the RESULT object flag to mark tip commits, replacing the linear
scan with a single flag test per visited commit.  This reduces the
per-commit tip check from O(T) to O(1) and the overall cost from
O(C * T) to O(C + T).

When multiple refs point to the same commit, the shared object gets
the flag once, so all duplicates are handled automatically.  The
early-termination advancement loop checks the flag on the sorted
commits array directly, which naturally handles duplicates since the
flag is on the shared commit object.

This also removes the index field from struct commit_and_index, since
the indirection through the original tips array is no longer needed.

This function is called by `git for-each-ref --merged` and
`git branch/tag --contains/--no-contains` via reach_filter() in
ref-filter.c.

Benchmark on a merge-heavy monorepo (2.3M commits, 10,000 refs):

  Command                           Before    After   Speedup
  for-each-ref --merged HEAD        6.57s     1.59s     4.1x
  for-each-ref --no-merged HEAD     6.67s     1.66s     4.0x
  branch --merged HEAD              0.68s     0.61s      10%
  branch --no-merged HEAD           0.65s     0.61s       8%
  tag --merged HEAD                 0.12s     0.12s       -

On linux.git with 10,000 synthetic branches at the root commit (worst
case for the DFS walk):

  Command                           Before    After   Speedup
  for-each-ref --merged HEAD        1.35s     0.35s     3.9x
  for-each-ref --no-merged HEAD     1.82s     0.31s     5.9x

The large speedup for for-each-ref is because it checks all 10,000
refs as tips, making the O(T) inner loop expensive.  The branch
subcommand only checks local branches (fewer tips), so the improvement
is smaller.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index d3a9b3ed6f..82614d2409 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1125,7 +1125,6 @@ void ahead_behind(struct repository *r,
 
 struct commit_and_index {
 	struct commit *commit;
-	unsigned int index;
 	timestamp_t generation;
 };
 
@@ -1165,7 +1164,6 @@ void tips_reachable_from_bases(struct repository *r,
 
 	for (size_t i = 0; i < tips_nr; i++) {
 		commits[i].commit = tips[i];
-		commits[i].index = i;
 		commits[i].generation = commit_graph_generation(tips[i]);
 	}
 
@@ -1173,6 +1171,9 @@ void tips_reachable_from_bases(struct repository *r,
 	QSORT(commits, tips_nr, compare_commit_and_index_by_generation);
 	min_generation = commits[0].generation;
 
+	for (size_t i = 0; i < tips_nr; i++)
+		commits[i].commit->object.flags |= RESULT;
+
 	while (bases) {
 		repo_parse_commit(r, bases->item);
 		commit_list_insert(bases->item, &stack);
@@ -1183,20 +1184,16 @@ void tips_reachable_from_bases(struct repository *r,
 		int explored_all_parents = 1;
 		struct commit_list *p;
 		struct commit *c = stack->item;
-		timestamp_t c_gen = commit_graph_generation(c);
 
 		/* Does it match any of our tips? */
-		for (size_t j = min_generation_index; j < tips_nr; j++) {
-			if (c_gen < commits[j].generation)
-				break;
-
-			if (commits[j].commit == c) {
-				tips[commits[j].index]->object.flags |= mark;
+		{
+			if (c->object.flags & RESULT) {
+				c->object.flags |= mark;
 
-				if (j == min_generation_index) {
-					unsigned int k = j + 1;
+				if (commits[min_generation_index].commit->object.flags & mark) {
+					unsigned int k = min_generation_index + 1;
 					while (k < tips_nr &&
-					       (tips[commits[k].index]->object.flags & mark))
+					       (commits[k].commit->object.flags & mark))
 						k++;
 
 					/* Terminate early if all found. */
@@ -1232,6 +1229,8 @@ void tips_reachable_from_bases(struct repository *r,
 	}
 
 done:
+	for (size_t i = 0; i < tips_nr; i++)
+		commits[i].commit->object.flags &= ~RESULT;
 	free(commits);
 	repo_clear_commit_marks(r, SEEN);
 	commit_list_free(stack);
-- 
gitgitgadget

