Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADAB2FC2D
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwSbU4F4"
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638BE102
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:12 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-da7238b3eb4so6552938276.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699991651; x=1700596451; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xd4IpdCEHxKY34PcwA7ZtdeQFczqMO6R4iJjYlLTNv8=;
        b=OwSbU4F4jFq2tMiK73ydYZDINjIBFsV8P2BlBvt/MT4MfA5c5Av58RkCguMGvtkvoq
         VQNBdLpsJvktUmg79vKHyeDHOQp2K3xTox3n3/CEEC1Cj0nPFPutKiAqBkj2iQa19l6s
         lF+7kyC8QB6ZKJ+G266u8kpWcDXFfSmAA/2WKkM3gHw4kH5lCYFj8st/ZyGQOan1SuwI
         /KjSy1BQqWMfKONHlhkYVCO9DH8x4YFC1HZp/vjS+D9y0gRA3MQ3bmvdTmtzvXQ51A8o
         XHWR1AN6xsf+XY+zLd7w5DvB+wUFTML/7khq1bBuy/252TP2K/fAjXvR1PkwkrI9koWM
         y7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699991651; x=1700596451;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xd4IpdCEHxKY34PcwA7ZtdeQFczqMO6R4iJjYlLTNv8=;
        b=YyIIk6TYgvY8ZZq5fVDURpp2PLQ7oei2naaez8WifNyS2Wjs3miegq+nUO826dtS39
         1Ly9+ok+2gkaGGfAHdrZvFb6nztg+TO4pafwEIXHDUpuSuPdTyHKKPxJMxz4o4Ff2Ci5
         4sLkks7vYdmKwGW7ucqTGZcuLpp9K/OMtntC+Mh3e5lcIw0vXF+eaWnDM9KiEZbxE2HI
         C+GWDNOWunHt4WqYfrjqJ/w2z2xclWLb8uNLTDqr5vKx+KaqSHKzD3n215FkajDtrvsQ
         bSgIxmE4keiTRHV1//1c3KB4BZQZT194mtjoK93s67uTOOQ+InpvnPrg8Y05PGlvvmy3
         2GPA==
X-Gm-Message-State: AOJu0YxYR+cnGGhglmnXGQKvp3lg/Hov6j+1boTuXrnY2Ari7E3hnVHr
	qCSp5u4+g68J6/LTeQDiiRutsrDz/XU=
X-Google-Smtp-Source: AGHT+IHFdidTKAQyW67J8dfMmcv9/VpFWNibD+TcEstubITdfHEVcHIzRgOMQlJs2vzWS13Mk201YA==
X-Received: by 2002:a25:cc8:0:b0:dae:b67e:7cd4 with SMTP id 191-20020a250cc8000000b00daeb67e7cd4mr9722595ybm.46.1699991650708;
        Tue, 14 Nov 2023 11:54:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5-20020a05620a158500b007756e75b91bsm2889265qkk.78.2023.11.14.11.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:54:10 -0800 (PST)
Message-ID: <040d291ca458ef0068e3fd543e7f441b2e5e71ad.1699991638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 19:53:53 +0000
Subject: [PATCH v2 05/10] ref-filter.c: rename 'ref_filter_handler()' to
 'filter_one()'
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
    =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Rename 'ref_filter_handler()' to 'filter_one()' to more clearly distinguish
it from other ref filtering callbacks that will be added in later patches.
The "*_one()" naming convention is common throughout the codebase for
iteration callbacks.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 ref-filter.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8992fbf45b1..5186ee2687b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2770,7 +2770,7 @@ struct ref_filter_cbdata {
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-static int ref_filter_handler(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int filter_one(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_filter *filter = ref_cbdata->filter;
@@ -3001,15 +3001,15 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		 * of filter_ref_kind().
 		 */
 		if (filter->kind == FILTER_REFS_BRANCHES)
-			ret = for_each_fullref_in("refs/heads/", ref_filter_handler, &ref_cbdata);
+			ret = for_each_fullref_in("refs/heads/", filter_one, &ref_cbdata);
 		else if (filter->kind == FILTER_REFS_REMOTES)
-			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata);
+			ret = for_each_fullref_in("refs/remotes/", filter_one, &ref_cbdata);
 		else if (filter->kind == FILTER_REFS_TAGS)
-			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata);
+			ret = for_each_fullref_in("refs/tags/", filter_one, &ref_cbdata);
 		else if (filter->kind & FILTER_REFS_ALL)
-			ret = for_each_fullref_in_pattern(filter, ref_filter_handler, &ref_cbdata);
+			ret = for_each_fullref_in_pattern(filter, filter_one, &ref_cbdata);
 		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
-			head_ref(ref_filter_handler, &ref_cbdata);
+			head_ref(filter_one, &ref_cbdata);
 	}
 
 	clear_contains_cache(&filter->internal.contains_cache);
-- 
gitgitgadget

