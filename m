Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	UNWANTED_LANGUAGE_BODY,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF461F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 20:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437384AbfJQURk (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 16:17:40 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33161 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJQURj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 16:17:39 -0400
Received: by mail-pg1-f201.google.com with SMTP id f10so2610596pgj.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q72mRa+DvPKvsvKcKotCMdsPLS1mELrWagxkQdQbawU=;
        b=UmCeCcfuMcdzxJS98vsy6/PVj1ecX0yfpWR6+Tb0VorTWa1rr8KvzsJ1eUuZlhjmBT
         6HYQ/ljMIXBeOWlAK/wU9ZFBFQub8K+nPKvyAz7P7iTbrIsUnMQpiEEqTjqsioTysuMb
         PXAtTn+wzqxSgGJyGVxLjitPl4+NppK1G5tGcNoE3R5nlSOgOIVKQ32+w3ImYfonyhK7
         8S7aK5dG3KdVvfTtN8/OCx6ThPOFu2XMn4ZK/kOV8YPWhXhI2PLtF72AnwP6Imhhuus9
         ks5jpyb+Z0MzE4W6JeuD8glpxya6HljTPWBZSe+9Wm4vSfTXVMMoi78WulzZgYCuj0ro
         sQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q72mRa+DvPKvsvKcKotCMdsPLS1mELrWagxkQdQbawU=;
        b=RhXDvg4ukhtbKw1YBFh0ETOXTn6cRtLUzacOVQqe8n9Kd4DlQQEjHFJBLERs09sGAK
         NcoD27hD2emF5Dd+TkVQ1L2QJ5CMygElXXSOoBFCSXQ1dDDW860jQrQ09JRol6R+RQm0
         RpoZJ7HTQixdAQn7n44WulPQb1R/76YJme+qb16rNUQSLoCZ0HgoFFsBZxSaYQ+j3NKS
         1tn1skg0E7u8iEA6L+EDJ3wIPf8mDMUlhSlo6ZEb8g4l6l4Q1Ms52G+V0+d/kh0+GhG5
         bVc8ypT60DPH+euRG3apgaTtG+bJxNtxvrQKXDhGqPa+lrPj1MUPOSOYYYx/hDzT7Uw3
         DSPw==
X-Gm-Message-State: APjAAAV7Q7WU3GlCfgT0U8VALzkjurUrMc5ge8yNXftSHbdk2SgvE5kP
        jj2pJtcWOU/ZunBfN8+xz5T4tRngRbImOQiWPH8GACwG4CvP/hQ3dLP2u0R4+amB8mb4c5tH+sE
        Id9TF9asbJ/bw2gNb2lBjtmvvtaV8zRGIEs3pUV38WyC3u7lerUWBxjUg3GtEl1t3aNEOwjRaVH
        b0
X-Google-Smtp-Source: APXvYqyR/+JGp9ERPcwpqn0icjhvqyT5VsFzbRIXVSg9tbK3bRd9hKHAoyw2dw8KaFazVaV8MKVQ79bGRBwUrBwa1SXq
X-Received: by 2002:a63:5712:: with SMTP id l18mr5863278pgb.197.1571343457148;
 Thu, 17 Oct 2019 13:17:37 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:17:15 -0700
In-Reply-To: <cover.1571343096.git.jonathantanmy@google.com>
Message-Id: <910b15219f0875663953e0087529ab19815ef3f4.1571343096.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570663470.git.jonathantanmy@google.com> <cover.1571343096.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 6/7] index-pack: make resolve_delta() assume base data
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will make the quantum of work smaller, necessitating
more locking. This commit allows resolve_delta() to be called outside
the lock.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d21353757d..31607a77fc 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -926,7 +926,7 @@ static struct base_data *make_base(struct object_entry *obj,
 static struct base_data *resolve_delta(struct object_entry *delta_obj,
 				       struct base_data *base)
 {
-	void *base_data, *delta_data, *result_data;
+	void *delta_data, *result_data;
 	struct base_data *result;
 	unsigned long result_size;
 
@@ -941,8 +941,8 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 		obj_stat[i].base_object_no = j;
 	}
 	delta_data = get_data_from_pack(delta_obj);
-	base_data = get_base_data(base);
-	result_data = patch_delta(base_data, base->size,
+	assert(base->data);
+	result_data = patch_delta(base->data, base->size,
 				  delta_data, delta_obj->size, &result_size);
 	free(delta_data);
 	if (!result_data)
@@ -1000,6 +1000,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 					   base->obj->real_type))
 			BUG("child->real_type != OBJ_REF_DELTA");
 
+		get_base_data(base);
 		result = resolve_delta(child, base);
 		if (base->ref_first == base->ref_last && base->ofs_last == -1)
 			free_base_data(base);
@@ -1014,6 +1015,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 
 		assert(child->real_type == OBJ_OFS_DELTA);
 		child->real_type = base->obj->real_type;
+		get_base_data(base);
 		result = resolve_delta(child, base);
 		if (base->ofs_first == base->ofs_last)
 			free_base_data(base);
-- 
2.23.0.866.gb869b98d4c-goog

