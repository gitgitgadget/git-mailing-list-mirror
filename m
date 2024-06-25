Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EEB14D2A4
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337199; cv=none; b=k+ygpiKjrnoViPvEdwsPECKhEsr3vrevmUYuOK1XKXq1vkbT2mkwAU1mwBLXm0EEUYPkxIn3xmHjLs9uDmOHuTOawW/xVixQiC6y6LhNqVTw1adhdRueYqAeR+oFDHzxBEYg0+QRlAjk5mDsLapOWoPpVOvxHmS7bJnTh/oS5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337199; c=relaxed/simple;
	bh=OapTbIosrIajL09/vZFHJo721sPAotzCHLHUNs4iMw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw753pKhno9DohcHUL9qPXzpfHyim9cht5b+lfIejnNadib8n5vPAL84CY5/boQKvF7J3fq6YuFpbxyW7Aqs328NSAFaYp+CR5rRth1D2DyeMn+5iW+m91lD5P7YHTCi5cry7Obn5IZ88U6leUjATna+TJPFo8N945UistC3VdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=T/4L0Fz6; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="T/4L0Fz6"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d24724514eso3423574b6e.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337197; x=1719941997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbBLQT3DHpcs61UmOdhqSA2YCfp81/pB0JqciA+w0kc=;
        b=T/4L0Fz6ZMw+nDT+kKvu/9tA1Gmdkfk78Bf0RAJCDzOENEQ8Pulp6A+/BLUmmiEa0/
         sXmdsGejGpz6SJIO//WLrGtDrNpf5pY1Uz4UUTfvmPC21sfwLSNrLyf7PHwlrDSny52u
         Ymk8JjwMBQgLnWmqkAq3QR94jR9b4He/jH0s9KWLwKlBM4bHDZlL4dKl/Vj0DQFLiuB0
         TcAMGMdcUbHdX6aiesJgsAwHdcu722A11GArDJJnBbu8hSaENONcQDO+hJaHsWgi9JbF
         I/pNiaDroTWcIAiVf+d0LrJhk8RxkBmBrFqxQi8fm2cl/LH1MhPervBeEN2j98+Q3YeC
         JUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337197; x=1719941997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbBLQT3DHpcs61UmOdhqSA2YCfp81/pB0JqciA+w0kc=;
        b=qYmo48D2yjnPdI14APseiYcj35VC+MOHpoFn9bbjjw28c5oOsRDVvWockmHHvinFbK
         Um8oI7ojLeGKyFcOUF3ZUydeKbtpU8yZx2an11lCPJX5lxit8VGjIiCRZokzk8mQ8GQb
         b2UuKEKfvyK0k46HC/kNxKK9iDG1MlH6QShv98BqZiQRmTRl0ixIkLOOaTf+H9NMMlg4
         86oCnfQFWR3NcJkgTG8aB6KUYmvaEWk1IGI3cMqbC/ty1qTPLsYO+A8QoOzex0jOP2Vo
         wK6HTrYyIO5cD2FUgl4MfoVhBQlz5yY7IVPlxn9M4o9D4+5lUlSGOneDNsRIEhRvkIfM
         vPgQ==
X-Gm-Message-State: AOJu0Yx1yZkHmgwGTEK2EPwS0wBqRNQNEhkNnyXdmVsmqZDCriPz2bD0
	Lfl5b/ergFzDXSgV/gHHjQdrH/vCMUEn4+FAg/PGVMB08sV2ogP2hhJPWVoxF9iQGfr7AV2ekZG
	Zsgs=
X-Google-Smtp-Source: AGHT+IGiHo5n9j2D/MB3xpcwOMzSNPHOSNETTQx5g6+M3BzhAjmuX95SP8qr+vj47nivu4BTz7W/Lg==
X-Received: by 2002:a05:6808:1442:b0:3d5:4ecb:43af with SMTP id 5614622812f47-3d54ecb448emr5939923b6e.27.1719337195643;
        Tue, 25 Jun 2024 10:39:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2c3e5b5sm57640161cf.75.2024.06.25.10.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:39:55 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:39:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 10/16] bloom: annotate filters with hash version
Message-ID: <ce3a15a517aa74c77e68096499368a2dc9e5587d.1719333276.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
 <cover.1719333276.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1719333276.git.me@ttaylorr.com>

In subsequent commits, we will want to load existing Bloom filters out
of a commit-graph, even when the hash version they were computed with
does not match the value of `commitGraph.changedPathVersion`.

In order to differentiate between the two, add a "version" field to each
Bloom filter.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c | 11 ++++++++---
 bloom.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index 401999ed3c..e64e53bc4c 100644
--- a/bloom.c
+++ b/bloom.c
@@ -88,6 +88,7 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
 	filter->data = (unsigned char *)(g->chunk_bloom_data +
 					sizeof(unsigned char) * start_index +
 					BLOOMDATA_CHUNK_HEADER_SIZE);
+	filter->version = g->bloom_filter_settings->hash_version;
 
 	return 1;
 }
@@ -210,11 +211,13 @@ static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 	return strcmp(e1->path, e2->path);
 }
 
-static void init_truncated_large_filter(struct bloom_filter *filter)
+static void init_truncated_large_filter(struct bloom_filter *filter,
+					int version)
 {
 	filter->data = xmalloc(1);
 	filter->data[0] = 0xFF;
 	filter->len = 1;
+	filter->version = version;
 }
 
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
@@ -299,13 +302,15 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 		}
 
 		if (hashmap_get_size(&pathmap) > settings->max_changed_paths) {
-			init_truncated_large_filter(filter);
+			init_truncated_large_filter(filter,
+						    settings->hash_version);
 			if (computed)
 				*computed |= BLOOM_TRUNC_LARGE;
 			goto cleanup;
 		}
 
 		filter->len = (hashmap_get_size(&pathmap) * settings->bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
+		filter->version = settings->hash_version;
 		if (!filter->len) {
 			if (computed)
 				*computed |= BLOOM_TRUNC_EMPTY;
@@ -325,7 +330,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 	} else {
 		for (i = 0; i < diff_queued_diff.nr; i++)
 			diff_free_filepair(diff_queued_diff.queue[i]);
-		init_truncated_large_filter(filter);
+		init_truncated_large_filter(filter, settings->hash_version);
 
 		if (computed)
 			*computed |= BLOOM_TRUNC_LARGE;
diff --git a/bloom.h b/bloom.h
index 1e4f612d2c..c9dd7d4022 100644
--- a/bloom.h
+++ b/bloom.h
@@ -53,6 +53,7 @@ struct bloom_filter_settings {
 struct bloom_filter {
 	unsigned char *data;
 	size_t len;
+	int version;
 };
 
 /*
-- 
2.45.2.664.g446e6a2b1f

