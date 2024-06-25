Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FFC176AC5
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337201; cv=none; b=P5bbwap3t4lTQql3yfbEVUx+MYO0uTKYyjehb5OxA1ysLKuoB4fcln8cCYbuJFSaqqs2zNy2zgLbXLgvaEsRGiqcfYeyBANRYFL2FX3t1O3E8WyVXu1rA9O47P2ldJv7/ZhykoZJ1ww7AyDfWkQQPWzVX9Ye1xDWCqH00GFamUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337201; c=relaxed/simple;
	bh=uuf6Qkp5eRaQyMMLmuQsuR92oFbDgOwgNn8tf1nVnNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgYfxQK8DSFrS0J/825zN5axag3LrS0ohRlTBfpTGCqLAeW8iJEBxw+j/quCsT/4YE52cqUJBWPAZi59XAezex5AbfFAWrtqKfQwmIFhVxWUHBrI1LP/VrrVaK05xuqJysN2JWwy1DHw4kXnRUbQhjdRdeS0+SY/4GcsxUA3wTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=g4NZovwk; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="g4NZovwk"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b2c6291038so45758636d6.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337199; x=1719941999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9YxQ/CZVncWLlMe30ZL35K6LfZ16N4CyQDQIJ8XtVbQ=;
        b=g4NZovwkId5xMECXNwZ24eZGThmvTWTSjwS4XAqOygihvh9Wat354KczSzHWe6w6zV
         Ml6Yac/WKO3q81rm5M5dNIOmzCv8aS53Cd6j36dl/e+KwbQgjL+3s9ywvmfRIsn1ylbK
         fv6F8mAvZ8KkqYt8zKnaKN6RqTrF6Nf2f0JAK8wrF5VvAohdY2rAnP2n+revZ+Y8b60d
         CfL3OlhiyqErXv+2bY0xo/8FFhmNva/y52UcOJWAs+Zr1DFJL1BHdeWDtW04AYiW2jJx
         faJ6MDDwKfBT9RCffBu38PwhFAF9T1ZIgSmu80wCIj5Sf3d6yCDc0mpE11e4mvy4tunc
         k3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337199; x=1719941999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YxQ/CZVncWLlMe30ZL35K6LfZ16N4CyQDQIJ8XtVbQ=;
        b=ugd3iGxHYiUID2H7oYLU7lneJli6MbGNvSxJOV0jRNZAdiPOuZnnGWDzQusnZoHaZh
         xqSe6Yu7Xl1vy8FpB5P1MoWHXMdLrOm5ELWKZKe+2aRCiO0qv0QKJDOtf53Q0t7bz6dd
         eJj0Fqo0fvvpKoAxek1HOUwJ3qS6fw6Vt+d06h/brcll2PCByPeJe1yW4bQa0u7zEQbz
         a5oNyjyFeOMgLoh9gj/OFCFZ1/FCIl4abRWbgyMIlw7RL59mr1fKoyXIpwm6bp7zmdCx
         +qS6ePO5ezg6oQ+bvldD+PaAydG22tgk+M6w59Bz94q8auPviw8x04RCqOB3B613hzjL
         altw==
X-Gm-Message-State: AOJu0Yw5olgKTjRHkYPmYP+Akrf4k5qjw2JgJ/VHY9rIA8Y4uAYcgtGI
	+IflWdIihQrHvs8ZQc5/xa3dhVGVwQH7+mU92CaOO0gKtZDJ2W1XMEPqTAHVNet5ihLb4i0yetM
	AqZs=
X-Google-Smtp-Source: AGHT+IGK18hXFoWigF0xdbsf9P5QCItsqIUWHblrJ6qjTWWip1gEFk3SgJLmaPNPUZgdoljhRjS8qw==
X-Received: by 2002:ad4:4d4a:0:b0:6b4:ff88:5363 with SMTP id 6a1803df08f44-6b56330a5d6mr65941856d6.13.1719337198943;
        Tue, 25 Jun 2024 10:39:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5223fa4d4sm44329756d6.78.2024.06.25.10.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:39:58 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:39:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 11/16] bloom: prepare to discard incompatible Bloom filters
Message-ID: <99ab9cf448eea65db1a561a79223fe70073d1be0.1719333276.git.me@ttaylorr.com>
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

Callers use the inline `get_bloom_filter()` implementation as a thin
wrapper around `get_or_compute_bloom_filter()`. The former calls the
latter with a value of "0" for `compute_if_not_present`, making
`get_bloom_filter()` the default read-only path for fetching an existing
Bloom filter.

Callers expect the value returned from `get_bloom_filter()` is usable,
that is that it's compatible with the configured value corresponding to
`commitGraph.changedPathsVersion`.

This is OK, since the commit-graph machinery only initializes its BDAT
chunk (thereby enabling it to service Bloom filter queries) when the
Bloom filter hash_version is compatible with our settings. So any value
returned by `get_bloom_filter()` is trivially useable.

However, subsequent commits will load the BDAT chunk even when the Bloom
filters are built with incompatible hash versions. Prepare to handle
this by teaching `get_bloom_filter()` to discard filters that are
incompatible with the configured hash version.

Callers who wish to read incompatible filters (e.g., for upgrading
filters from v1 to v2) may use the lower level routine,
`get_or_compute_bloom_filter()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c | 20 +++++++++++++++++++-
 bloom.h | 20 ++++++++++++++++++--
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index e64e53bc4c..c24489dbcf 100644
--- a/bloom.c
+++ b/bloom.c
@@ -220,6 +220,23 @@ static void init_truncated_large_filter(struct bloom_filter *filter,
 	filter->version = version;
 }
 
+struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c)
+{
+	struct bloom_filter *filter;
+	int hash_version;
+
+	filter = get_or_compute_bloom_filter(r, c, 0, NULL, NULL);
+	if (!filter)
+		return NULL;
+
+	prepare_repo_settings(r);
+	hash_version = r->settings.commit_graph_changed_paths_version;
+
+	if (!(hash_version == -1 || hash_version == filter->version))
+		return NULL; /* unusable filter */
+	return filter;
+}
+
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 struct commit *c,
 						 int compute_if_not_present,
@@ -245,7 +262,8 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						     filter, graph_pos);
 	}
 
-	if (filter->data && filter->len)
+	if ((filter->data && filter->len) &&
+	    (!settings || settings->hash_version == filter->version))
 		return filter;
 	if (!compute_if_not_present)
 		return NULL;
diff --git a/bloom.h b/bloom.h
index c9dd7d4022..052a993aab 100644
--- a/bloom.h
+++ b/bloom.h
@@ -108,8 +108,24 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 const struct bloom_filter_settings *settings,
 						 enum bloom_filter_computed *computed);
 
-#define get_bloom_filter(r, c) get_or_compute_bloom_filter( \
-	(r), (c), 0, NULL, NULL)
+/*
+ * Find the Bloom filter associated with the given commit "c".
+ *
+ * If any of the following are true
+ *
+ *   - the repository does not have a commit-graph, or
+ *   - the repository disables reading from the commit-graph, or
+ *   - the given commit does not have a Bloom filter computed, or
+ *   - there is a Bloom filter for commit "c", but it cannot be read
+ *     because the filter uses an incompatible version of murmur3
+ *
+ * , then `get_bloom_filter()` will return NULL. Otherwise, the corresponding
+ * Bloom filter will be returned.
+ *
+ * For callers who wish to inspect Bloom filters with incompatible hash
+ * versions, use get_or_compute_bloom_filter().
+ */
+struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c);
 
 int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
-- 
2.45.2.664.g446e6a2b1f

