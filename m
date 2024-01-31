Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3308F3A8EF
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741585; cv=none; b=IM39ae9N1LXOsfBrPnqtb2xih9+FmU1KI8zlruh7e0sTQJqLHWg+emt5IxmYQrTUMU+91wMPI8qfZYks+EUp8/T1V4tHxMswPkXX5zLY0X4F8yfC+B/wGMmU2+nqBloO2IMlcKKmWPWerB3JUKLhgV6GOzPTJaDniUlDm/AzJbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741585; c=relaxed/simple;
	bh=TG03iqpczV3tLPyif87DeBzhQYXYsK5w8rtoUrswU4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1afFsmBVkwOyFyzWMHvOTTEAqkQ0gdjzW1Cvtn6ki4DOqiZVBYxKddDPbAC4/RzZOnMOZa+LKH6+RIQ70YT8KqsCUc0yKB/+/3wsMjjb9vuse4xgKIu2ij5h2qVwiQ8jZLqhcRovNXxVR/lPyWsw5/LlzXdxrQ44hwVeiyvWpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qupn2PnL; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qupn2PnL"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-783cd9ca29eso17607085a.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741583; x=1707346383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AoXFd8aZI+HRPO7Aqwkb8bI5B96LhDXQk+2y/4N+w3Q=;
        b=qupn2PnL8AMMvtZAP3+bn0dX3RVZivzSM7rveaTsKU3GpucZB0mLdK5Fff/a5DhR3f
         eiFmPcMiNQIbOXr52xPkNBxvR1DaEQ+fVpidStp2qUMqnvjosTVA4DZv+nbIeEe+aArS
         /q06kD+Iyx6nEUaVUvmNHVmFqeC+bzAhZHS9740st25hlyYoFLLb1B254QSkRZ7ARjog
         lvloEJ4C1JzWYTChWEQ0RzAaiXXlRzGSvPRAWr4jCtpnx158w8Crt6YWV81u0NJDXiPL
         +U1zLn2xO/18i65AU9S3HdVzO0h2hfhTPg89AzX4ZN3fUIiGsmgfhn5kQSf4UniGHfU+
         F9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741583; x=1707346383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoXFd8aZI+HRPO7Aqwkb8bI5B96LhDXQk+2y/4N+w3Q=;
        b=aLtxEbTi8VMf/pNLCws+kHpR98hgh1G7lHms2MwBRIV6Ke/4qPPoCKuFDr21xZqLmD
         k1umn2mVprw1C6vas9PAtKOZNmnG3oeKI4fL/nBKIou8r7/LDzESaGZhDe2ZeH0ujSzp
         fMEDVdqHOZuSHL2aNk3y/ekDghndfYjVcE/v41Rj07Cj4/pRhtiJVrdZAy9nJEbKYueW
         /P048lOet32c71EWTK24NWnhrhnqpOyvbUa6UW1zIseF0xcR0UzVV98c5Bv5glQKJTgc
         UfgMf/tu3lGQ1wrZjjQ4kNXHAUHuVZJgcztImqc40tKvf1EmQ8DLt/hVPZyaf3NohVmo
         p2mg==
X-Gm-Message-State: AOJu0YzXLPzTlCVI+BDNysK8Mcobgu/LYZiMPGWlUnWjTz5ime8YkIRK
	tfdeE3HZZWyiR4KzjJhCfym+lvnJ5vDryTqX0z7Q4ann8N441HDigmFUjEwBAwL84QBWRTkkI5I
	RhQ0=
X-Google-Smtp-Source: AGHT+IEG4mweCW/b7Bz5JpNgLnIH6k5endr5lof0pfcAAVy4crDLgmUS4V+2o0EvJJVc9KI9Pq1mUQ==
X-Received: by 2002:a05:620a:a88:b0:783:b5ca:2a39 with SMTP id v8-20020a05620a0a8800b00783b5ca2a39mr630152qkg.19.1706741582786;
        Wed, 31 Jan 2024 14:53:02 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c18-20020a05620a165200b007840c63ad70sm1664099qko.15.2024.01.31.14.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:53:02 -0800 (PST)
Date: Wed, 31 Jan 2024 17:53:01 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 16/16] bloom: introduce `deinit_bloom_filters()`
Message-ID: <12058a074d8fa5a936f672c24943ebffc9c8ab0e.1706741516.git.me@ttaylorr.com>
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

After we are done using Bloom filters, we do not currently clean up any
memory allocated by the commit slab used to store those filters in the
first place.

Besides the bloom_filter structures themselves, there is mostly nothing
to free() in the first place, since in the read-only path all Bloom
filter's `data` members point to a memory mapped region in the
commit-graph file itself.

But when generating Bloom filters from scratch (or initializing
truncated filters) we allocate additional memory to store the filter's
data.

Keep track of when we need to free() this additional chunk of memory by
using an extra pointer `to_free`. Most of the time this will be NULL
(indicating that we are representing an existing Bloom filter stored in
a memory mapped region). When it is non-NULL, free it before discarding
the Bloom filters slab.

Suggested-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c        | 16 +++++++++++++++-
 bloom.h        |  3 +++
 commit-graph.c |  4 ++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/bloom.c b/bloom.c
index a1c616bc71..dbcc0f4f50 100644
--- a/bloom.c
+++ b/bloom.c
@@ -92,6 +92,7 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
 					sizeof(unsigned char) * start_index +
 					BLOOMDATA_CHUNK_HEADER_SIZE);
 	filter->version = g->bloom_filter_settings->hash_version;
+	filter->to_free = NULL;
 
 	return 1;
 }
@@ -264,6 +265,18 @@ void init_bloom_filters(void)
 	init_bloom_filter_slab(&bloom_filters);
 }
 
+static void free_one_bloom_filter(struct bloom_filter *filter)
+{
+	if (!filter)
+		return;
+	free(filter->to_free);
+}
+
+void deinit_bloom_filters(void)
+{
+	deep_clear_bloom_filter_slab(&bloom_filters, free_one_bloom_filter);
+}
+
 static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 		       const struct hashmap_entry *eptr,
 		       const struct hashmap_entry *entry_or_key,
@@ -280,7 +293,7 @@ static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 static void init_truncated_large_filter(struct bloom_filter *filter,
 					int version)
 {
-	filter->data = xmalloc(1);
+	filter->data = filter->to_free = xmalloc(1);
 	filter->data[0] = 0xFF;
 	filter->len = 1;
 	filter->version = version;
@@ -482,6 +495,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 			filter->len = 1;
 		}
 		CALLOC_ARRAY(filter->data, filter->len);
+		filter->to_free = filter->data;
 
 		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
 			struct bloom_key key;
diff --git a/bloom.h b/bloom.h
index e3a9b68905..d20e64bfbb 100644
--- a/bloom.h
+++ b/bloom.h
@@ -56,6 +56,8 @@ struct bloom_filter {
 	unsigned char *data;
 	size_t len;
 	int version;
+
+	void *to_free;
 };
 
 /*
@@ -96,6 +98,7 @@ void add_key_to_filter(const struct bloom_key *key,
 		       const struct bloom_filter_settings *settings);
 
 void init_bloom_filters(void);
+void deinit_bloom_filters(void);
 
 enum bloom_filter_computed {
 	BLOOM_NOT_COMPUTED = (1 << 0),
diff --git a/commit-graph.c b/commit-graph.c
index 320ac856ca..6f5f8f158f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -831,6 +831,7 @@ void close_commit_graph(struct raw_object_store *o)
 		return;
 
 	clear_commit_graph_data_slab(&commit_graph_data_slab);
+	deinit_bloom_filters();
 	free_commit_graph(o->commit_graph);
 	o->commit_graph = NULL;
 }
@@ -2649,6 +2650,9 @@ int write_commit_graph(struct object_directory *odb,
 
 	res = write_commit_graph_file(ctx);
 
+	if (ctx->changed_paths)
+		deinit_bloom_filters();
+
 	if (ctx->split)
 		mark_commit_graphs(ctx);
 
-- 
2.43.0.509.g253f65a7fc
