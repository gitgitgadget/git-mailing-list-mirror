Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D3383C94
	for <git@vger.kernel.org>; Sat, 16 May 2026 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778922997; cv=none; b=HwiSknZSUsQnx/vsOZCz6h2xU1wt+GDyBW4OP0rJbUipajL8LXqipgj6qdJlZWBfaYoMFbiujAlotuPI+hQ756c5RIo66ieAxS5KdI4BHPhsQ723CPIVgUtAFYIcBoAwIoTjjsZbaSXfXe3IDm7RS0sSKLhV+SDyVFe1WtX9MiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778922997; c=relaxed/simple;
	bh=1F0ALbIXKz1xZaIfCYKvnt+GVHoZvGFfiXY9nrbGbas=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LD+cEgsaN6ShFa5vPUExhkUIylIWA3dEj5PKnq/6iMcraldEa/RsZyDKeFdJlQx1jUQUO3DHC+ELjlCsy4QP0fF3AjRoPXXRwl9tGnI5CIi2QLeZKC258rWv2n6N0wUevq4Ck5Z9hw4DRtJH/CUBdQTq+QVErICDF66DmtIKGMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNVHGSE6; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNVHGSE6"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d6b9bca48so15544101cf.2
        for <git@vger.kernel.org>; Sat, 16 May 2026 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778922995; x=1779527795; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVO8yDGrFHteu7Hz55eDDE69twpilqoVGzxRIuUOSrs=;
        b=qNVHGSE6whtXuAHwbmKIgLr4sWpdbRNL8HteewmVsTNaUF7xM9wThrn6c1oyPheJd4
         lc3J2A5nweiE/egP8UgIabbbdRcSHomvIpY1NdmW1+IRY5tqmpDl1kKcH8Mt+qdelyoX
         vPtfu2EylcCWpBi1O0hcX22756+jlciTPCsCmIOfpFsJ3L+IEBIs9le2cdh0YlPZC77M
         Mta7i3IvZWam/KPe2jJZWSjTueD1YQ6z7tLIG5XjfQ4Sx28mhI8XWT7g2O7MczgvgT7p
         Ep/0bk3tn0znIFgkb3bRhrUjDRiKOGrzlazZcIU3mnw9WoQMhBF8o8mavqZ8Mtux9u9Q
         UROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778922995; x=1779527795;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OVO8yDGrFHteu7Hz55eDDE69twpilqoVGzxRIuUOSrs=;
        b=MCHkDA9+Unp5vAAnDO+VpQfLNzjCMcMy93fGhTwEwIBzVy0IrEmEj+l+tlbigNWw14
         2d0zfVFqw6DVd3mOfDVTfWwVj/ZDOGjUbWInH1kpioeVA5wgIwZLrEjasoq3W375575l
         jAgkaJJGlvyNULA/h0qsAa52zEOZol1P7G5Ix7FwoI7yIyjddoHH9ChxpHV049AbiHQW
         jYJ3Ov46j/02IFcBAFbNSaIchIw2LxFWjAuOlhbfHlW4c+oLa8rl2piMabotwWzUYHWQ
         Q6HLVGBZ1jsjHDCWD+Z+x+MDXwjhOePSzLIB/C4nrAhpNg6XywT8i8ljUQmVHQRRPj+3
         txFA==
X-Gm-Message-State: AOJu0Yzs0x9a8XO0kr90VxOfSa1oj7fppzpyNJYrD7R+gGCu+rHemo1U
	bZxdMTBaFHNUj4sISPPYs2hb+PEL7hhyeCY24JTIRt3ALXtKFzGpJkasHjStCw==
X-Gm-Gg: Acq92OEnQdPbol2q6m9imcGxrNEzwEgsdCUzF6qdYcGUNnYBYOGosY0+Kadr8z4LLiC
	PMIKvOMqpLlJU/NlwnblukgX02GsS1JPnUmXx4BeT5X63hmQqAimxYcL8QIJ6cOwkrV+xd1363a
	bkhTfaDVPXPU0h+f02Rm1zLPCiqOVeGkXMTtyXnBYlItulLXKa/9RN81SRsEvgefEGoyS96Tmri
	hxEzYkwqKRKJ4886EIRpoH3oIxXQH3wopre/6IcwsUJ+6Xny0vSVKpSxPu1spyhIFJO5IK56u3b
	ONMvtKHnUwk5C3szF5NhzMLZX0Ks2ErljNPghTU8/hzlNNpibBbpVoEP5B8fDXV2Wy+HidgW6M6
	KXNiHwEh0jNIyLYfHRe6i8C6p3oqX7cayvdaxndcb2Laq4WdTbkurFy6IIDDlDcH8Xw/Rbl2oNo
	em7WgG19pJeIPgC9U8ZTu0E6/n
X-Received: by 2002:a05:622a:2514:b0:509:39b5:a97f with SMTP id d75a77b69052e-5165a0a37a6mr102875501cf.29.1778922994493;
        Sat, 16 May 2026 02:16:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456d0bd6sm69624341cf.11.2026.05.16.02.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 02:16:33 -0700 (PDT)
Message-Id: <pull.2116.v2.git.1778922993480.gitgitgadget@gmail.com>
In-Reply-To: <pull.2116.git.1778868463992.gitgitgadget@gmail.com>
References: <pull.2116.git.1778868463992.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 May 2026 09:16:32 +0000
Subject: [PATCH v2] commit-reach: use object flags for
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
    commit-reach: use object flags for tips_reachable_from_bases()
    
    This replaces the O(C*T) linear scan in tips_reachable_from_bases() with
    an O(1) flag check using the RESULT object flag.
    
    The function is called by git for-each-ref --merged and git branch/tag
    --contains/--no-contains via reach_filter() in ref-filter.c.
    
    Benchmarks on a merge-heavy monorepo (2.3M commits, 10,000 refs):
    
     * for-each-ref --merged HEAD: 6.6s → 1.6s (4.1x)
     * for-each-ref --no-merged HEAD: 6.7s → 1.7s (4.0x)
    
    On linux.git with 10,000 synthetic branches at the root commit:
    
     * for-each-ref --merged HEAD: 1.35s → 0.35s (3.9x)
     * for-each-ref --no-merged HEAD: 1.82s → 0.31s (5.9x)
    
    v2 of this patch, addressing Jeff King's feedback:
    
     * Replaced the decoration hash with the RESULT object flag (simpler, no
       extra data structure, handles duplicate tips naturally)
     * Fixed early-termination bug when multiple refs point to the same
       commit (the decoration API overwrites on duplicate keys)
     * Removed the now-unused index field from struct commit_and_index
     * Diff is +11/-12 lines

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2116%2Fspkrka%2Ftips-reachable-minimal-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2116/spkrka/tips-reachable-minimal-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2116

Range-diff vs v1:

 1:  992c0aff0e ! 1:  7399a12518 commit-reach: use the decoration hash for tips_reachable_from_bases()
     @@ Metadata
      Author: Kristofer Karlsson <krka@spotify.com>
      
       ## Commit message ##
     -    commit-reach: use the decoration hash for tips_reachable_from_bases()
     +    commit-reach: use object flags for tips_reachable_from_bases()
      
          tips_reachable_from_bases() walks the commit graph from a set of base
          commits to find which tip commits are reachable.  The inner loop does
     @@ Commit message
          is a tip, making the overall cost O(C * T) where C is commits walked
          and T is the number of tips.
      
     -    Replace the linear scan with the decoration hash for lookups, reducing
     -    the per-commit tip check from O(T) to O(1) and the overall cost from
     +    Use the RESULT object flag to mark tip commits, replacing the linear
     +    scan with a single flag test per visited commit.  This reduces the
     +    per-commit tip check from O(T) to O(1) and the overall cost from
          O(C * T) to O(C + T).
      
     +    When multiple refs point to the same commit, the shared object gets
     +    the flag once, so all duplicates are handled automatically.  The
     +    early-termination advancement loop checks the flag on the sorted
     +    commits array directly, which naturally handles duplicates since the
     +    flag is on the shared commit object.
     +
     +    This also removes the index field from struct commit_and_index, since
     +    the indirection through the original tips array is no longer needed.
     +
          This function is called by `git for-each-ref --merged` and
          `git branch/tag --contains/--no-contains` via reach_filter() in
          ref-filter.c.
     @@ Commit message
          Benchmark on a merge-heavy monorepo (2.3M commits, 10,000 refs):
      
            Command                           Before    After   Speedup
     -      for-each-ref --merged HEAD        6.64s     1.66s     4.0x
     -      for-each-ref --no-merged HEAD     6.75s     1.74s     3.9x
     +      for-each-ref --merged HEAD        6.57s     1.59s     4.1x
     +      for-each-ref --no-merged HEAD     6.67s     1.66s     4.0x
            branch --merged HEAD              0.68s     0.61s      10%
            branch --no-merged HEAD           0.65s     0.61s       8%
            tag --merged HEAD                 0.12s     0.12s       -
      
     +    On linux.git with 10,000 synthetic branches at the root commit (worst
     +    case for the DFS walk):
     +
     +      Command                           Before    After   Speedup
     +      for-each-ref --merged HEAD        1.35s     0.35s     3.9x
     +      for-each-ref --no-merged HEAD     1.82s     0.31s     5.9x
     +
          The large speedup for for-each-ref is because it checks all 10,000
          refs as tips, making the O(T) inner loop expensive.  The branch
          subcommand only checks local branches (fewer tips), so the improvement
     @@ Commit message
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## commit-reach.c ##
     +@@ commit-reach.c: void ahead_behind(struct repository *r,
     + 
     + struct commit_and_index {
     + 	struct commit *commit;
     +-	unsigned int index;
     + 	timestamp_t generation;
     + };
     + 
      @@ commit-reach.c: void tips_reachable_from_bases(struct repository *r,
     - 	size_t min_generation_index = 0;
     - 	timestamp_t min_generation;
     - 	struct commit_list *stack = NULL;
     -+	struct decoration tip_index = { "tip_index" };
       
     - 	if (!bases || !tips || !tips_nr)
     - 		return;
     + 	for (size_t i = 0; i < tips_nr; i++) {
     + 		commits[i].commit = tips[i];
     +-		commits[i].index = i;
     + 		commits[i].generation = commit_graph_generation(tips[i]);
     + 	}
     + 
      @@ commit-reach.c: void tips_reachable_from_bases(struct repository *r,
       	QSORT(commits, tips_nr, compare_commit_and_index_by_generation);
       	min_generation = commits[0].generation;
       
      +	for (size_t i = 0; i < tips_nr; i++)
     -+		add_decoration(&tip_index, &commits[i].commit->object,
     -+			       (void *)(i + 1));
     ++		commits[i].commit->object.flags |= RESULT;
      +
       	while (bases) {
       		repo_parse_commit(r, bases->item);
     @@ commit-reach.c: void tips_reachable_from_bases(struct repository *r,
      -				break;
      -
      -			if (commits[j].commit == c) {
     +-				tips[commits[j].index]->object.flags |= mark;
      +		{
     -+			size_t j = (size_t)lookup_decoration(&tip_index, &c->object) - 1;
     -+			if (j < tips_nr) {
     - 				tips[commits[j].index]->object.flags |= mark;
     ++			if (c->object.flags & RESULT) {
     ++				c->object.flags |= mark;
       
     - 				if (j == min_generation_index) {
     +-				if (j == min_generation_index) {
     +-					unsigned int k = j + 1;
     ++				if (commits[min_generation_index].commit->object.flags & mark) {
     ++					unsigned int k = min_generation_index + 1;
     + 					while (k < tips_nr &&
     +-					       (tips[commits[k].index]->object.flags & mark))
     ++					       (commits[k].commit->object.flags & mark))
     + 						k++;
     + 
     + 					/* Terminate early if all found. */
      @@ commit-reach.c: void tips_reachable_from_bases(struct repository *r,
       	}
       
       done:
     -+	clear_decoration(&tip_index, NULL);
     ++	for (size_t i = 0; i < tips_nr; i++)
     ++		commits[i].commit->object.flags &= ~RESULT;
       	free(commits);
       	repo_clear_commit_marks(r, SEEN);
       	commit_list_free(stack);


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

base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
-- 
gitgitgadget
