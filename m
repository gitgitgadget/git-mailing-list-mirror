Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B928226D15
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493401; cv=none; b=F4KHwgLBsHilAGoMQUqyyGoWXGLC1AgUrpU3ap81YIm65Sca6UaOzMBDJNUm/3q9i4aVDjDf3pZ0kYMZd0MTvXyLxYZ3OZCZZ6OoRsKB/UZBwz8Sfrnc2TEgUMoDqqxDLZVcE/R09Gxm5fpLmAEVYTwCO10ihGpomXk1S+Tr8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493401; c=relaxed/simple;
	bh=vkWXuI5XQwptlWXD8LJXY5ETixKyybnQCmQNn9+ccUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHHqclzrOcIFp33LOl9+G3rwCeuBZzYffp9+ar2BAyJwrMXzA21nNykoYSfpDKAQ/CJE1B/0UAtIm4tzKdfu/NA6xG4efYx66A0FmNhk37gLLYYfxoVWoEDkvQKVtBBbfNzpoj97CJsUZZNvxOy4DgFWYC0fuRju84AP6vWirJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=m2NIzx7f; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="m2NIzx7f"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd1962a75bso8392156d6.3
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493399; x=1743098199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iuJYfc2WVdHkQ1d4xMSLkhVlfdAMjk3b4MIrQVtjuRg=;
        b=m2NIzx7fPpU68es8kdPTGliLyMO2adwKzOseEduv4p0e1XKBTwea3ksmCPYFlS20Px
         SGjwq0L+UibiXXmNDCaN4rMmcznKAjjd4AXMQUVkflPKXttHVln+c72rY/fdcpIZviRk
         occ9Le/g2XYzc4ggyvY5EpEUcPJTqhCTWWkR05LDypMBVQIb3Bs0lq9bmZ2EHv0zop+c
         dWDbS4bqqKzLyqTqaH5ERrei3pjmJm3XXZ5Urb71DvykG/HPA6/Ms1UQUZWq07QLS+2I
         4iv54reQxEkwyAebjxh7/EqjvYfr8kMNWcVuM2f3L+ECWeN9ElH4peUnQvp94g5Yb7b/
         Rijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493399; x=1743098199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuJYfc2WVdHkQ1d4xMSLkhVlfdAMjk3b4MIrQVtjuRg=;
        b=BIKwFDzwqbbIaQFNCv2kSOa7D1hio/Ly/cFh09+m1kmc2Qe1nhh9U/5jCnY4+G6+lH
         nBmOlp7v9Q73wA8Ne1ggHcwVBtRzPTrYhKTaGE6JPYUX5GFrzvfwZ4lJKvWJQpTKlKhs
         NXWT5iTICChmoq9iH56p5Q31hgZWQjVl6hwS+5kdSm3sM/rriZ857+pOJY4/wWk6uPlb
         V45vtKKeDjBe83h7XfGOQRyp3DyHxjJM0Qy3OKM4q3NWy0WzOZ0B5E7ehsRsxJCMx3GW
         O1/xwmcfe6xJ0kITS8rECSXGnFfUK8sF6YJS4REbx8Spk/mkO+vQdBfYLhF+xpGDGa4M
         BZUA==
X-Gm-Message-State: AOJu0YylhX4xoAAlce6/jBwHfso3LAmYUt3EAKgvxwQTb8gH2m2MqySC
	oe4QELMTNTe+LCXb6y4FuZYw46ASR6boQwbWeEfdrXCPHxGeG5zVnrSt/QcJRHTetqare1ZdSzj
	Keks=
X-Gm-Gg: ASbGncvrIPsGT7Qa8Rma7ZSwvJFWce2nbAghhLCrrClvGXamog58TBKxyGVYGvQrZOk
	c7rvlNgt48fb4hK6wWhLDengpRreODQk/YUKnIL7xe5FeLM6eusPAF+/dn/W98tAe9IITppejUg
	JOFeQfDXuiv0jKhJ/C2wHuiox2uFTBbG8Z3ni/oNAYDu388ZdyFPgklrjcAVs227IwLjaj/aR+W
	3FXAXH2KSpDneyLWgMt9a5/j7tYlQhuf2rvLZAQMFGdYuPc1djsihswiAwQZj1TYfxf0ak//kH9
	OBmDf+EKigogtCpTzo17mi1IhkoLLcS6ADJVKW4MjZzTfEIU2QwEtHaQvKSha5FSDYmZF61nEBT
	1VGweZw1aw4eX8+j+
X-Google-Smtp-Source: AGHT+IFnIa5Vzkwp+NrCLiYHECs6dxK4Z03yCu8TjtIilL3N/llIwh4nOfWXwaWGVB5ZRK5uRNfWyg==
X-Received: by 2002:ad4:5beb:0:b0:6e8:ffb6:2f90 with SMTP id 6a1803df08f44-6eb3f2c84a7mr3911886d6.11.1742493398805;
        Thu, 20 Mar 2025 10:56:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb3ef1f82asm1132856d6.32.2025.03.20.10.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:56:38 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 05/14] pack-bitmap.c: teach `bitmap_for_commit()` about
 incremental MIDXs
Message-ID: <8fedd9661497c4f74f061f55438014f2726d199d.1742493373.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1742493373.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742493373.git.me@ttaylorr.com>

The pack-bitmap machinery uses `bitmap_for_commit()` to locate the
EWAH-compressed bitmap corresponding to some given commit object.

Teach this function about incremental MIDX bitmaps by teaching it to
recur on earlier bitmap layers when it fails to find a given commit in
the current layer.

The changes to do so are as follows:

  - Avoid initializing hash_pos at its declaration, since
    bitmap_for_commit() is now a recursive function and may receive a
    NULL bitmap_index pointer as its first argument.

  - In cases where we would previously return NULL (to indicate that a
    lookup failed and the given bitmap_index does not contain an entry
    corresponding to the given commit), recursively call the function on
    the previous bitmap layer.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e84211de15..17f1087fba 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -941,18 +941,21 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 				      struct commit *commit)
 {
-	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
-					   commit->object.oid);
+	khiter_t hash_pos;
+	if (!bitmap_git)
+		return NULL;
+
+	hash_pos = kh_get_oid_map(bitmap_git->bitmaps, commit->object.oid);
 	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
 		struct stored_bitmap *bitmap = NULL;
 		if (!bitmap_git->table_lookup)
-			return NULL;
+			return bitmap_for_commit(bitmap_git->base, commit);
 
 		/* this is a fairly hot codepath - no trace2_region please */
 		/* NEEDSWORK: cache misses aren't recorded */
 		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
 		if (!bitmap)
-			return NULL;
+			return bitmap_for_commit(bitmap_git->base, commit);
 		return lookup_stored_bitmap(bitmap);
 	}
 	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
-- 
2.49.0.14.g88b49c1b34

