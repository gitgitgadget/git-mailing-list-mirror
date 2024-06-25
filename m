Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57544147C74
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337219; cv=none; b=OZ7MSfRlATytIOKe5FwcukiTwrO990KVLaYYeRBgti/O8bK5eIRjPJRNEUWWhtHnsBtVuengW/o+UeC0DDKiTN5hIbZENE//0PrMs0RF/Qb4CefKn7DNFhP5XAZOpvYe5NIZ0jjm188EoGEjHJUsYhlD0INlVaUuGJZq8PqmSHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337219; c=relaxed/simple;
	bh=ojcbMuB1E2tSdBKHQAD3AmRSmi3YgxAw3pW7HuOE/d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJup2CkUYv7dBD+NM1i+q4xbJBBhgQtLIaOap789DQ3E0eNVhflrEq7IHfO2GEfiOPwmHae0Hx3xhzcwDYgvEk1PpYMaxhqwDGbpQeDEnQFcQSWjBX0n1VSluPjxuAUPwfkY8aAF2qIyedGxFCn58XIK+JyrOoT4xRd5dqt98Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=d0OB/zzo; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="d0OB/zzo"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79c10f03a5dso21373585a.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337217; x=1719942017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfNKn3C7TDjPbsX5uodEZ/FaBSWhJexijVXkNTwpPow=;
        b=d0OB/zzoZZ1wdgnOB5pQn0WgAw3bHcCR1IB9jSql9rHIAmCV9s2UnOkplOhus5NNAX
         saYACm5gjiTOC50cY9mTVFSbbPYtgNeSjtg0necOo33lv8NsZExi2CSN8/41uXbnflOu
         gcfausvHRq87HO4hLsjferuK6nPxjYiIegKDta/vqgs+AHXJeJ1AQ/wHsbhDR+CMVLqL
         F5c2xpH3VeTc7KPj35lP0C/NDZQP8O6zOhEwn3q2m7MOrc9t5Q6UZ80VwIVbXobPbxqF
         JoWXGqto5fnyotj8zNqoxttz0Y7XEXHVoJDeWmV31j8xVTwhDTcyZapYrfzUoAWTv+fS
         5iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337217; x=1719942017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfNKn3C7TDjPbsX5uodEZ/FaBSWhJexijVXkNTwpPow=;
        b=RC5DHcHoxYyOZYr0HxHMlw3kPQ+8uxuS8kZyaC6IajtI68vGCds8dmfFC2Kn58iknB
         Ghw+FxPGSIroPEX1H/TeC71CgERHl67SUhEVCmzrB2w58QDscGXWZck09Ibb/mBIeRcH
         9eBVjiUrwAZ0LKxIs40db4VENnKGUWdTXc5Pg0gNL7yBWgufpzLBucM1Ev9uKaPkBvEr
         8icOQcMFYl9fCZ5HeOR7d9xMU5DiTt8vT6xeWIwh6+1AGKT3a7Sheu1+Qcxh7ETquWAc
         UBrS6UnMYvc4WlaW8GVt9/gNeZHAq1w05396SVaXmHzvN9K0ucKhWl+m0Jxv7goJS/66
         WgyA==
X-Gm-Message-State: AOJu0YwVtBdq3soSP7J2K9SVlUL3bzluNC1v9hacLGBTpl5CxUQHI1sC
	MRWzTPg1TdLsvmDunMWzqJWTJGf6PTBU+al4vKEb0Ug+ooqYr1MwZtv3EbssfNyZpx/38dDFTaq
	TFCE=
X-Google-Smtp-Source: AGHT+IHoH75bcqnqrF3HsIqfsUz3TP4rpsabEL0/3+6IfSeGgYm5dXNQDEsch5X4GS5jQsdZ2E5Jzg==
X-Received: by 2002:a0c:8bca:0:b0:6b0:7a47:ca7a with SMTP id 6a1803df08f44-6b540a92d85mr74417886d6.42.1719337216696;
        Tue, 25 Jun 2024 10:40:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef694fcsm46127716d6.131.2024.06.25.10.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:40:16 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:40:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 16/16] bloom: introduce `deinit_bloom_filters()`
Message-ID: <db9991f339377d64b3328cfc1b5e41548b2f8407.1719333276.git.me@ttaylorr.com>
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
index 740c1767ea..d080a1b616 100644
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
index 2f0a08f302..c02bef7e72 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -831,6 +831,7 @@ void close_commit_graph(struct raw_object_store *o)
 		return;
 
 	clear_commit_graph_data_slab(&commit_graph_data_slab);
+	deinit_bloom_filters();
 	free_commit_graph(o->commit_graph);
 	o->commit_graph = NULL;
 }
@@ -2647,6 +2648,9 @@ int write_commit_graph(struct object_directory *odb,
 
 	res = write_commit_graph_file(ctx);
 
+	if (ctx->changed_paths)
+		deinit_bloom_filters();
+
 	if (ctx->split)
 		mark_commit_graphs(ctx);
 
-- 
2.45.2.664.g446e6a2b1f
