Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D52320248
	for <e@80x24.org>; Sun, 21 Apr 2019 08:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfDUIL2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 04:11:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41389 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDUIL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 04:11:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so4326325pfd.8
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 01:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wrqY35OffwIk/CRgdxskcpAs6xPOXUlgAECFzIg2odY=;
        b=nkBdxU60+pkZUOO92gmOOpdK7IuEVmAAmpBvu6cBGpWpZoYRIN6odLbsHppJzYXNki
         aS0gTgYnS7BCZXCuzQS4T6nzHEMr7f+1ugLwxRtrNSHjxyldUguAbVVroyS/FiCRvEQu
         TfHgCs/Q4SobgLiEpYpuZqOMf/1BBw0UePfBmNgLZO9Ll0MS9ep3IPtjWC887ywL5d6k
         YGg0y5G2NUvO6TIFE22d8R91Ryh4A508AcAYlXzTxz6e0+VRmrhauYPmJChpdg8/fD7U
         k/QoR5RlI5CtJXqnefBLcFXw/x8SYyGLUxio1s1+nDA/gp3ZQeWwCupH8puyXobUyAok
         oXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wrqY35OffwIk/CRgdxskcpAs6xPOXUlgAECFzIg2odY=;
        b=XADbP7qtJ50RrIbmuJmIxQOf5Dyr1UOiTPJRHdn1u4G+I1sWyebH/6DWcxyBz+iBNy
         25FZ0QVySpQULn2AZWYomkcNBZU5VKgiV3qCkCC83+MgbWNqN1iD2TptBwNJREg97D27
         4FXOMIJ3o0e8mOGlNZIvCo/V0GsF55WnbciEC9Xxn/xptIXTsChcxWs4S41XEEEu3/z4
         ddVkzRO5zy2S47aLlFI0AHzdFscEURf7wT55Eggot/9NzokDVHyBW68bqJGGY4yI7HMi
         fviWsp8NVRiHrayVTyI9tzw1yEBG9AkkzLLwYRmGC0YwBSANdX2mzrrWraf1x7ySpXHg
         YNqA==
X-Gm-Message-State: APjAAAXKSKem6XPZjWyoLpVq4aEo3rmcJatmqYai3Ogvo5tUYqQeBbxR
        etdu5eWAk6IAZFgjaI4WgbU6t+uS
X-Google-Smtp-Source: APXvYqxGjgkcvi+qP0wPVtZSf3Tm/xxpjvTxZ8uQRedTbmP2VzZ6MRB2+zuwNH2OhHdeXnY15jZ9WQ==
X-Received: by 2002:a65:41ca:: with SMTP id b10mr13243179pgq.256.1555834286483;
        Sun, 21 Apr 2019 01:11:26 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:647:4b00:5d::661d])
        by smtp.gmail.com with ESMTPSA id b63sm26974020pfj.54.2019.04.21.01.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 01:11:25 -0700 (PDT)
Date:   Sun, 21 Apr 2019 01:11:24 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v7 3/6] rebase: refactor can_fast_forward into goto tower
Message-ID: <3d348d2c37751b8ecbbd244e03bd9fdd860290e2.1555832783.git.liu.denton@gmail.com>
References: <cover.1555523176.git.liu.denton@gmail.com>
 <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, can_fast_forward was written with an if-else statement. However,
in the future, we may be adding more termination cases which would lead
to deeply nested if statements.

Refactor to use a goto tower so that future cases can be easily
inserted.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 77deebc65c..de10b6f5ad 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -899,21 +899,27 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
 			    struct object_id *merge_base)
 {
 	struct commit *head = lookup_commit(the_repository, head_oid);
-	struct commit_list *merge_bases;
-	int res;
+	struct commit_list *merge_bases = NULL;
+	int res = 0;
 
 	if (!head)
-		return 0;
+		goto done;
 
 	merge_bases = get_merge_bases(onto, head);
-	if (merge_bases && !merge_bases->next) {
-		oidcpy(merge_base, &merge_bases->item->object.oid);
-		res = oideq(merge_base, &onto->object.oid);
-	} else {
+	if (!merge_bases || merge_bases->next) {
 		oidcpy(merge_base, &null_oid);
-		res = 0;
+		goto done;
 	}
-	free_commit_list(merge_bases);
+
+	oidcpy(merge_base, &merge_bases->item->object.oid);
+	if (!oideq(merge_base, &onto->object.oid))
+		goto done;
+
+	res = 1;
+
+done:
+	if (merge_bases)
+		free_commit_list(merge_bases);
 	return res && is_linear_history(onto, head);
 }
 
-- 
2.21.0.967.gf85e14fd49

