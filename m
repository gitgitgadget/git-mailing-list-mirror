Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302911;
	b=qQd4jEgAfeGTjfexAVU/032Rg2z9QgXhHnYA9+MpoErMZuyMYoeuoUaAtiltI6dyINgC
	 JYT9TfWkchkE3bDdg9Kf+uQAEexhUuE9YJIDQE+1hbKuSput9GNJP06fYdpj+3FJ0sf+C
	 CElX6g3S5j+QlxDygl9ThiMP01sKucjQhX9qxFyVf9vmC52utq5pdiJgrjUQ15EbcJcNS
	 4uo87j4wgj7ydrVObKqak/e+8XXb+tQXcI+Sv+gS3hFwTE/8p7YHNpEXGggSx4NHDdfyB
	 J54eN5hdooquQ9D7t5ayN8xVSgm3AE0Y7AL2spp08XHdw8Q3P5Qk3CDSgtHW/rauqVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Bw/wBcvmuZ+yllcgBY69e6+x9aC20gVCwKqIC8sHwl8=;
	b=367VEaYfY39EnOuSsW/0p2sBegQvNBJucxbLyXyG5hqzOh2uO5lQOSTbuNC43AxLWgb7
	 YMwktUvh2gQtlcBiZI9gV6U+PZskbx2lWZzAyOmjpM7zTp8dMMdW056K3rrnKQ1r7Or+/
	 x0vOcwpzu/E8ciwtmF3BhAIW2vmz2M8yT12gHw99oJDaIG437u9uaBLCXJVFJiwVX0vpq
	 UyyAKF7M1LoCVE5xyJHk8/CMH1yFFtLjxzh9HpyBMg416AUr3EoCjMEkA2WG0qY0XotWW
	 yBntM9CGHXfKkfbHuf6qzB4N9lNQBtxNc7fJ8fb6iFQqd/M2iP6eCjnjrLz9wDU+u5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrrcScy5;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC2606A327
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 19:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3CC2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrrcScy5
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so23975695e9.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793302909; x=1793907709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bw/wBcvmuZ+yllcgBY69e6+x9aC20gVCwKqIC8sHwl8=;
        b=jrrcScy5BhQ6tnrgWQkc8G1RPrhIoK/sFE2JAquY3CfAazyonwbdMA2iJhewyIfEWG
         Ei5Zp0mNz0Qm+vp8iGsMvL981oz40uwm2csXAPmxZ4X1SH474hPO8sx/S9WHupBxQmQ6
         bcuFksviK81sYCRzx2zCOgyvJCS+CbcRC3d/yGVouA/LGCleE79He3PNsDqjNaO2N7fl
         Xb/o+Ltz/sgJsAlJ3lV+KHfKh3hxKmIDhuLbrpbZpV78YixPkYUuSVz6GVZ4cr/4+LW0
         t0yLrVzcrVrEPNA7ooLQKeLJVWwO4yF3BGjT2xVlxNP8v/ckjLsbHSjti2jPc7NZaGZ4
         8Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793302909; x=1793907709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bw/wBcvmuZ+yllcgBY69e6+x9aC20gVCwKqIC8sHwl8=;
        b=OrZFzpjG3wAV+gVzZ00JetI+x0l0lZAEXGNKooLpev5cA5T2+/ycGl4XZ4FdRA7IYH
         YcofA7vHmIMB3uZV7tNAEuLUcfNu+/fIE01u/pnR/XBLlyji+9VbmpoiMoLJYzqyiFz8
         JE63FeNdr9Fx53ij9UuMZf99ttoeWEdFGEMcMv8Vwt1HY+2XXAWTr6zBkoGh9EOQZ3ZK
         HNwgE6lGNzsFf1+u//qHzH0S1XW9qFQlP+Lqs6EoiltObe0kqJCR2+N7fsq0CLO6od2I
         50yaRPAp1AXgYsWhCYFQlC2BDJLB7Cg5eymtLRASuugklNV6lh+WcY+Gl8KyK3IIVTgh
         HyzA==
X-Gm-Message-State: AFq9FYKp+TrZdJTqjy8yV1RRZnMg8y4jLeWMNNAmhrK961bL7AfBOpKx
	7fbKFvCgqMb3OMWipfT22mp/6aj3V9kuIYaPDKJFnFWLWVz0HL9yRvkMClNu/327QVw=
X-Gm-Gg: AYBFou2SBEImeiPIqkVdPbg0dcm6WZQuCMdgFeKatDrMMf7EeK6blMBpFSs5fYzWFza
	CSvL2Pfg08Jjl1ewKvuAX+aQL/HGBPv8jGi+UwJbvPOMNvXiXMQe3AL57hFQIg1ixym/0JUhHt1
	9vsFiz6tqrF1o/Dtu8zpfgPz830ysXh/i2dy2d+DfF2CHzgR6+rfH6gHNtKBb1QpX9+UgxFwRPZ
	+cwrFN1Gw9GjFgdWcInz+uNPWVNV25R5fRrU9Onj0oJy22jq3TKmUM5gPTWkJhY6T7zOdBOpRM3
	IMowZpHZeQ611RzGw0tZbj6bkWaE+Gk5D9ZIgWc+Tv6zwB0asQtGiOvFMG5qIslMyZN6QelJoGn
	M9ualLCuYyQytK18YkrVXwZboojVluM+fNvWQbgreLQvymTch4sfzPMkACMxyRqyfcq54M9Nsxb
	SnJ9tvLNJDVMg5/nHvZJYihUGRbwf50f7YOJFBdAXvqh0XiAI3fD350PJpXI0GMFqFX8KotZNDn
	H34955QXW79qwKofEQx3OWLauuR7G0wDYRqdOd9aFVPLk1WKrxE6UqQ9qXmHQ60Ac6dyHnjNU64
	QMPmlpR0IHszimCmw+jpLQTAtWvjJZNG5GMetnypK3sBdB3TaEvJ69Fbj0gShGMA+6erolzt2yl
	hEO2m/JT5B11FPIXZ7oYr2HJPIJBAUjm34BzPs+bOwESVPG54dn+PUzT42aZ0M8KTfxDDBkXOn3
	ws8owpSTYCjN4ebCBxInqaqvwl/u+w
X-Received: by 2002:a05:6000:22c3:b0:48e:61c9:4e32 with SMTP id ffacd0b85a97d-48e6e505515mr809810f8f.32.1793302909038;
        Thu, 29 Oct 2026 12:41:49 -0700 (PDT)
Received: from localhost.localdomain ([102.88.133.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb8bc12sm353769f8f.34.2026.10.29.12.41.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 12:41:48 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH] pseudo-merge: use writer->repo instead of the_repository
Date: Thu, 29 Oct 2026 20:41:16 +0100
Message-ID: <20261029194116.63464-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions in pseudo-merge.c receive a bitmap_writer whose repo
field names the repository the bitmap is written for, yet they
look up commits, peel refs, show progress and walk refs in
the_repository. push_pseudo_merge() also allocates its commits in
the_repository. If the writer was set up for another repository,
these functions would still read from the global one.

Use writer->repo instead. push_pseudo_merge() does not have the
writer, so add a repository parameter to it and let its callers in
select_pseudo_merges_1() pass writer->repo.

Drop USE_THE_REPOSITORY_VARIABLE, as pseudo-merge.c no longer uses
the_repository.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 pseudo-merge.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index 22b8600d68..368c56efc2 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -233,13 +232,13 @@ static int find_pseudo_merge_group_for_ref(const struct reference *ref, void *_d
 	uint32_t i;
 	int has_bitmap;
 
-	if (!reference_get_peeled_oid(the_repository, ref, &peeled))
+	if (!reference_get_peeled_oid(writer->repo, ref, &peeled))
 		maybe_peeled = &peeled;
 
-	c = lookup_commit(the_repository, maybe_peeled);
+	c = lookup_commit(writer->repo, maybe_peeled);
 	if (!c)
 		return 0;
-	if (repo_parse_commit(the_repository, c))
+	if (repo_parse_commit(writer->repo, c))
 		return 0;
 	if (!packlist_find(writer->to_pack, maybe_peeled))
 		return 0;
@@ -298,13 +297,14 @@ static int find_pseudo_merge_group_for_ref(const struct reference *ref, void *_d
 	return 0;
 }
 
-static struct commit *push_pseudo_merge(struct pseudo_merge_group *group)
+static struct commit *push_pseudo_merge(struct repository *r,
+					struct pseudo_merge_group *group)
 {
 	struct commit *merge;
 
 	ALLOC_GROW(group->merges, group->merges_nr + 1, group->merges_alloc);
 
-	merge = alloc_commit_node(the_repository);
+	merge = alloc_commit_node(r);
 	merge->object.parsed = 1;
 	merge->object.flags |= BITMAP_PSEUDO_MERGE;
 
@@ -353,7 +353,7 @@ static void select_pseudo_merges_1(struct bitmap_writer *writer,
 		struct commit *merge;
 		struct commit_list **p;
 
-		merge = push_pseudo_merge(group);
+		merge = push_pseudo_merge(writer->repo, group);
 		p = &merge->parents;
 
 		/*
@@ -395,7 +395,7 @@ static void select_pseudo_merges_1(struct bitmap_writer *writer,
 		struct commit_list **p;
 		uint32_t size, end;
 
-		merge = push_pseudo_merge(group);
+		merge = push_pseudo_merge(writer->repo, group);
 		p = &merge->parents;
 
 		size = pseudo_merge_group_size(group, matches, i);
@@ -461,11 +461,11 @@ void select_pseudo_merges(struct bitmap_writer *writer)
 		return;
 
 	if (writer->show_progress)
-		progress = start_progress(the_repository,
+		progress = start_progress(writer->repo,
 					  "Selecting pseudo-merge commits",
 					  writer->pseudo_merge_groups.nr);
 
-	refs_for_each_ref(get_main_ref_store(the_repository),
+	refs_for_each_ref(get_main_ref_store(writer->repo),
 			  find_pseudo_merge_group_for_ref, writer);
 
 	for (i = 0; i < writer->pseudo_merge_groups.nr; i++) {

base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8
-- 
2.56.0

