Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339941BC2A
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756062421; cv=none; b=SOYf60+/FEFb7l/IaZRAQM0JcqF1OodDCfgu5CdQiECw5sOP85Ji8+aMiQ51QZxwErJYTFQatyji8BumwNiQcT6ifE0oX0DvkD0x8GZ1ppsEwdzadpMqk8KdOLaKSOfZAPfebShMDivs8o6MTgsSm4xSMJOtWBxkxoe1sm4H7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756062421; c=relaxed/simple;
	bh=aAagvpxNKHxS0va6czzLs32d+VM/pG5FvSUkBnekljY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WD14LPKosTcFKackvCORL4oPqlO/Qr+5FmrZcKROChArMuzN1XOzpd9gQzvBIK2yQJNLo+rczFDLXfaDvOF/JKs68//rESUWIzvn26qBIKYkqFQNh9hyiPTm9UA+/+q5PsMvs+nQrbDaULme6BAqBBilTDUjOaiPWazG2D3AYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+V6GEld; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+V6GEld"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b4a25ccceso20596845e9.3
        for <git@vger.kernel.org>; Sun, 24 Aug 2025 12:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756062418; x=1756667218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DGxq7ZsQmVS/3b0ddq/+pP+rL4Swdt4oVEpDJJNs/Y=;
        b=m+V6GEld0ZwxfVyYq/QTSJ0QH4P7VlydWFbVe8vp3q2mIrXnHrUXAuAuQZswp0a6RL
         0QiqftP1b23VdaMCsNYTjhytDCx5bxe2i71cKTt3UtzX2RzlCpZtnZcVk8opNDQSavxZ
         IQdbrTJOJnaUpFB79y/LW+27M4pRApmqOohSbzcPZUJVlOCf934dbJw60pJtvF7fbNX4
         do0XMMC+le2/k3yry49Y8nsGOgoxJt4Ql+Vurkkh9VVj6L6LvqDcFMwXkc8OnXWDxW9M
         2IAubYC1rx+lXKOesoU+4sYWAhEz2SlpNVH6nfNQ1CQIqZKKT+pVM/xx4UPe2lzfb7R5
         IOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756062418; x=1756667218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DGxq7ZsQmVS/3b0ddq/+pP+rL4Swdt4oVEpDJJNs/Y=;
        b=uOSIpsNpf0Oq2UT+GunuZl2mN79BJdFlb0mHGDs0tBHZz7ZmhNXR7AqvKcyH2YwwAj
         aaItextfnpRBv/bpwxG9zdCTik6Mgb7UM5Nu99j+33Xr+wrnsQ2nye/CnclinGk03UPa
         27s/iw17w0wd3B7fr/+jvlePxpUv9wmaWRunhlcEzONqLYtXbKkOe198bI/HKvHKyZeL
         D9/J5EBgKIMRV8v4lTzTptmurYJ8pHXRdjve0Z17OVOynMaWjyTiLt4jccsLqERWmZBG
         nJufaq0rrmaa5n5lDI9h7ZQWtPgRD7n9P284Sgbg9ELixzuUmrEIwR6c9qpPH3XeZl1p
         Sx0A==
X-Gm-Message-State: AOJu0Yxs5MWAHwiAiKyXiCQA6K+InWtJU6IJ49/fflLeDDz+z511YpMv
	+BxaKxQuTqEFPvwT0Kogz0qLVS40F+QUexRRN0EPBRF0VIMScjoj2xyplrm4kQ==
X-Gm-Gg: ASbGncsLtAjEWbqYBKac04eMCEtSamlVbzDjHX8yl4FtmPycdfg/IZFDI3P4oEp63Q9
	QTWEMpZ9TMTeJca1K33E3M5H59kgbRweG22VK8rBMXdUpRSlZEvat3wGxcF6sHsUTN4/PMAAut+
	FRFJ1baxZrNyOyW+qvO1HnolJIbL3diDFibqYLE89+VxjwxxkSlptOB+SfybXdFDHNaaK7y35n2
	4qIcME7GuxlrPw72kD39e6+gb6+0n9XkAT5cgqYVeO0bsnkyX51qJNZWtxQqW/e+ws7jOzBi23S
	5BNRjiSOiWKrBdHV5Jr7iVdL+XA8/Fq/F4B1CebdPsgY8+v04tRnlYcSci2dxp4bzNpY5pzZuVl
	LD/foSKmevl0MPWcU9Of8wqF0ZVDj5wcnQb2KFqJloRYtnVVO+XEuWPuSzQ2PyBg=
X-Google-Smtp-Source: AGHT+IEjSPNHBaWoH4ZGVm0tYRClB7AaEjkEYCWgMjaMrQLHcQhvFV2S/C4QZxtRSjCtijisQD9jXw==
X-Received: by 2002:a05:6000:2404:b0:3b7:9b81:73f6 with SMTP id ffacd0b85a97d-3c5dcff3702mr8552606f8f.54.1756062418300;
        Sun, 24 Aug 2025 12:06:58 -0700 (PDT)
Received: from localhost (78-131-14-231.pool.digikabel.hu. [78.131.14.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5753503esm78822465e9.1.2025.08.24.12.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 12:06:57 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/4] line-log: get rid of the parents array in process_ranges_merge_commit()
Date: Sun, 24 Aug 2025 21:06:42 +0200
Message-ID: <20250824190644.2573279-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.51.0.433.g1a66b3fb12
In-Reply-To: <20250824190644.2573279-1-szeder.dev@gmail.com>
References: <20250824190644.2573279-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We can easily iterate through the parents of a merge commit without
turning the list of parents into a dynamically allocated array of
parents, so let's do so.  This way we can avoid a memory allocation
for each processed merge commit, though its effect on runtime seems to
be unmeasurable.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 line-log.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/line-log.c b/line-log.c
index cf30915c94..b2a31ae956 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1203,7 +1203,6 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 				       struct line_log_data *range)
 {
 	struct line_log_data **cand;
-	struct commit **parents;
 	struct commit_list *p;
 	int i;
 	int nparents = commit_list_count(commit->parents);
@@ -1213,15 +1212,15 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 		nparents = 1;
 
 	CALLOC_ARRAY(cand, nparents);
-	ALLOC_ARRAY(parents, nparents);
 
-	p = commit->parents;
-	for (i = 0; i < nparents; i++) {
+	for (p = commit->parents, i = 0;
+	     p && i < nparents;
+	     p = p->next, i++) {
+		struct commit *parent = p->item;
 		struct diff_queue_struct diffqueue = DIFF_QUEUE_INIT;
 		int changed;
-		parents[i] = p->item;
-		p = p->next;
-		queue_diffs(range, &rev->diffopt, &diffqueue, commit, parents[i]);
+
+		queue_diffs(range, &rev->diffopt, &diffqueue, commit, parent);
 
 		changed = process_all_files(&cand[i], rev, &diffqueue, range);
 		diff_queue_clear(&diffqueue);
@@ -1230,9 +1229,9 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 			 * This parent can take all the blame, so we
 			 * don't follow any other path in history
 			 */
-			add_line_range(rev, parents[i], cand[i]);
+			add_line_range(rev, parent, cand[i]);
 			free_commit_list(commit->parents);
-			commit_list_append(parents[i], &commit->parents);
+			commit_list_append(parent, &commit->parents);
 
 			ret = 0;
 			goto out;
@@ -1243,14 +1242,15 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 	 * No single parent took the blame.  We add the candidates
 	 * from the above loop to the parents.
 	 */
-	for (i = 0; i < nparents; i++)
-		add_line_range(rev, parents[i], cand[i]);
+	for (p = commit->parents, i = 0;
+	     p && i < nparents;
+	     p = p->next, i++)
+		add_line_range(rev, p->item, cand[i]);
 
 	ret = 1;
 
 out:
 	clear_commit_line_range(rev, commit);
-	free(parents);
 	for (i = 0; i < nparents; i++) {
 		if (!cand[i])
 			continue;
-- 
2.51.0.433.g1a66b3fb12

