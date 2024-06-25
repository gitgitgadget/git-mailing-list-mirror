Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B55135A69
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337185; cv=none; b=AOvkIEUBSZOwxeZ3p0Z+byDi9FmuCJniIJE/vP2/l/iGeR9suCgP1W6DpJFc6mZa+M8ac4Z5pSq4R36e/BGIMaTo+oXaH15neMF0eUqRW7sUrVqZE01QXp+SdRv6Y5+97U/AGRj1KJoqftt+aqS3rAC02ViWXJ0MKnwcBWV6rSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337185; c=relaxed/simple;
	bh=Dn9eGIGm5EPSLPBb1fjXgOSVeR1wdmbvicSwGcv+tJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ppw8YleCrZhtajXDkpoby9CwDBXoTtfb8+bAdt8w1rXw6PduqqKlXzZpbU9snngDnnBzD4JHl6WFSQWQIR5A4tssshFajT0rAIE5td2gNwOchEhAyP1Ak9Mps4BahbeqlH1L9l2LzP5btvzl8PZyWx2Rw+E91uEhiB2PEFr/jtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=OMZj6Nl5; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="OMZj6Nl5"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79c0b7af837so26025485a.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337183; x=1719941983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdZZ9UgcEgjNd+ygTbClHrOZSoHLcWTQNJuZAgMNkls=;
        b=OMZj6Nl5pjiv+6cvG8iQ8W+WM1CzeFrTwopTGdT80ewgH4PB4WlPyMeFNyQf7WaKxf
         cFBmKpAUQK1PXaTcuPvuvgkamqsTZfFPtSaKCFvJuOC6tlLkT6BmFroJNk3HKuWJijIT
         8uev7M+lKjKTlLdAP0Q9CH6TW8hyMuO3tZA9q9bJvkSMW+dWGJchsO/BLTOVMKu2VeD4
         tuDfuTYHa7OKPrxXznYBHxXhIZkYLGyogbOvtSqSph+X8r05Xx5puUN2UShKvdwcHXtq
         xcyw+jWON5gFsH/WcB01+asYL+A9SVYnHJpVIuZk46r6+O4QkGnmoZ5W6dxV7I6zETy1
         WL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337183; x=1719941983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdZZ9UgcEgjNd+ygTbClHrOZSoHLcWTQNJuZAgMNkls=;
        b=uYkqEf3LgQlPcz8yYb0OcteeIZGzmGBqlcYF2oWQIDj0egJS8efoK45Mi9I0a9cILd
         RAp3Aq7Mx32cwWDQItKimMD2pq6A/OPXMuXxXdv14KT+4O6Lawh+ZQfswLXjqk6QFDJc
         uIqmTxI0E1/kawOMMs652YSLOhoyapslLagvMzNpo2eQNwVKCyyksgF/slTfzAApWD40
         eEr6ZJ3KcATZadM+BTk61CZsdNobxR2GbmyyNQcnQ236aZIu5Hn7cZskhvxKWYvf5eyK
         yx/K8TW1TVasl8EAA5PM9swsPseMc98360bKVxavlkgivZPd2szA6rkTtf3j7odjPE56
         iuFA==
X-Gm-Message-State: AOJu0YxblMtplreciAChGoTkzK/o8hbKvWvIvAw5IRer+XdHT9Opu2VS
	ru01kk58vCQVBV2lHRLAcgTE0vHzg4saw4ZnkafxnnXgqol7ObaAE4ESmCQXUtc1nL8JlqMis4L
	PIbA=
X-Google-Smtp-Source: AGHT+IHfoV87MoQ6wYEMHPEE3STRondNuzD+3iboZ57recpEDJMpkYmNKmJKq7MhkZOXWy46whduYw==
X-Received: by 2002:a05:620a:254b:b0:797:876d:6d35 with SMTP id af79cd13be357-79be6edde67mr930976685a.30.1719337183116;
        Tue, 25 Jun 2024 10:39:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce942edasm425873385a.128.2024.06.25.10.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:39:42 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:39:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 06/16] bloom.h: make `load_bloom_filter_from_graph()`
 public
Message-ID: <ae74fbad3e1b076c97de748f72c61a6521a27391.1719333276.git.me@ttaylorr.com>
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

Prepare for a future commit to use the load_bloom_filter_from_graph()
function directly to load specific Bloom filters out of the commit-graph
for manual inspection (to be used during tests).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c | 6 +++---
 bloom.h | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index e529f7605c..401999ed3c 100644
--- a/bloom.c
+++ b/bloom.c
@@ -48,9 +48,9 @@ static int check_bloom_offset(struct commit_graph *g, uint32_t pos,
 	return -1;
 }
 
-static int load_bloom_filter_from_graph(struct commit_graph *g,
-					struct bloom_filter *filter,
-					uint32_t graph_pos)
+int load_bloom_filter_from_graph(struct commit_graph *g,
+				 struct bloom_filter *filter,
+				 uint32_t graph_pos)
 {
 	uint32_t lex_pos, start_index, end_index;
 
diff --git a/bloom.h b/bloom.h
index adde6dfe21..1e4f612d2c 100644
--- a/bloom.h
+++ b/bloom.h
@@ -3,6 +3,7 @@
 
 struct commit;
 struct repository;
+struct commit_graph;
 
 struct bloom_filter_settings {
 	/*
@@ -68,6 +69,10 @@ struct bloom_key {
 	uint32_t *hashes;
 };
 
+int load_bloom_filter_from_graph(struct commit_graph *g,
+				 struct bloom_filter *filter,
+				 uint32_t graph_pos);
+
 /*
  * Calculate the murmur3 32-bit hash value for the given data
  * using the given seed.
-- 
2.45.2.664.g446e6a2b1f

