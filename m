Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4783B2AF
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741569; cv=none; b=KbAz++73XZ9OUkT9+OecyjOfNPyw+aPBzumsdpuxxsxeqb736L7M7gt26QRHW5X1P3etX0k/a/9di0oNHYISRuBE1ZYolKfnOaDwxxPw+tvAiSaHkeDWRT9PsJN4UuYeKVw6JDwR6gTcqn9CfAlz03mLU3BiywW/12ayPat8LDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741569; c=relaxed/simple;
	bh=ZCgThCsRmOwQ1+xIGt/3w+tcFn4H8aq/vJ9EJ0M7aWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+BUnS97UFWrEcJrRQZNfHh36z//2G9icaKKTOm96RzLUKruXji8vGEcY6MKkVgnaIv8PQHOYVo4NzDxcVwa2s5/I1YkvabWyOxTk0gDDffx0UUAra/qghDnsJ3M/CTQSRsnB2DTaukZAUOattvwNTsd6BLAgrrbGVKTZiKLcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=q/sbZzLW; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="q/sbZzLW"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bd884146e9so228553b6e.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741567; x=1707346367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D6GHsYvyBHhvzMYU5PMG4d+UGghW4W5NWZxOZg1CJR8=;
        b=q/sbZzLW4owBYn6uHtaVuvdEW7gfn+pxHAmdKYws4KRK1JqOddl/w19lpp72+eLXtv
         xsaWnC5lqjuoiylVM/vCdy5HfIegDq7SR/vWNllb6NtsR2G2bde5a5eE4qrlDSQnacNa
         BVyc6KIkVR1fjcLPr8ydEXkunOQG0ViOSNp1Rx7s2bpK0gPSeIREiIYTIdjroKM12ZsI
         xtunDgiauEJJdUvL00Wbcji6nnVYV0CjewE/3s4+ps1arSNyueReTDgwBOjFfSo9IvwS
         lN6GRM/2SkZVxXejoOCyLFSmZzddI7JqFzeIUGAMgOw9/CnwnnLwiKIP7T5FOwZkBw57
         T9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741567; x=1707346367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6GHsYvyBHhvzMYU5PMG4d+UGghW4W5NWZxOZg1CJR8=;
        b=DnSXs6Y+zNMJmcDDL+l8466HDKo1RKSscgpMmwzJDpYA5O8IwY1G5dNj2/PAkbDNJ7
         CoCDqaRa4dXgehK1Geqp0ZNEBEmIG26k8N5a2k8pRxfI3740Pgjauu5yVScH4TBkB29E
         C+gv+A0BzEUwk+Slxh+yGI3xWWb5PVDzpLvyFcZedZjYBKtsD1O+HKeFgpT1sO28O0Pi
         R/QkaJ8bZKajTxEIzyxC1KFlmV5xnywexcvcqjMyfTJ1Z0Yh3PfjBEK+NO/PODR0OtBB
         RWhN5QUftZ0Q7gPqKKjBZmedJUIUM/fNrJAJYJLaNrcYZFtXnucF69FnmYsCQPc4zY4G
         srkw==
X-Gm-Message-State: AOJu0Yx9f2bW3LvpIjHhxkLKoSnqhxIbmrIFVgUG4LiHFLPDIY+J7CDT
	FPoqCu6ioBQ7nt6lv8QshpxUihyRMS0V6soSvLlEWB3c0bb+GOivIX0MmANpU6hgOuG7157fxpX
	RXBQ=
X-Google-Smtp-Source: AGHT+IFAhYwy8WNfBFWCep3nqRqYTXDn7p9L67EBh9OQBC9Yf40g0Pv5DjFu9sg2pBnxauD4+zKoaQ==
X-Received: by 2002:a05:6808:23d3:b0:3be:b756:a456 with SMTP id bq19-20020a05680823d300b003beb756a456mr3654081oib.4.1706741566879;
        Wed, 31 Jan 2024 14:52:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t8-20020a05620a034800b007840164c230sm2624623qkm.79.2024.01.31.14.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:46 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:45 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 10/16] bloom: annotate filters with hash version
Message-ID: <09c44c51a53026d757a5d08acd9a7e0aa6288eb1.1706741516.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1706741516.git.me@ttaylorr.com>

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
2.43.0.509.g253f65a7fc

