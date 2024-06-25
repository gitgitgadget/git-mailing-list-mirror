Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523AD135A69
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337188; cv=none; b=K3MvoS45wfnkesGWRHZuJND5Smf5yP934QCSwRNvGc6nAga4N1BStK6qVI5K7mun0G7VOieo7AZwpvcOuGlD0cDX50IvxcAyphSsqmUF1qpJYffO5G82Q04X9rC15EvVCvOTM/xoQ946ZCIX3uqMaPLIxybyyLSevr2+13Saofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337188; c=relaxed/simple;
	bh=hxMf0mMFOS+sn9ANpDYwiVnkPu3yRLvIHC7ipzUjl3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSgtKtpIVHkJYXKmNJINQ3M6Jdr+wNhIDEY1uREYJvCOigjwk+OyAHysgG66YIK/pytXaTEE3sgoXZyxgSFkPd6xk/6z4euK6Cfg3/b7hMwNbaYNTIQLYDJhjZ6ErENb7y4k52iCoaM3u1KZ7Hr/fY9czyqHajCs+kj+MQn4DQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xjOwNn4/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xjOwNn4/"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79c04e6e1b9so66574185a.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337186; x=1719941986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NTgOHYrKELet2F67+EI2R71m0GwI1ZMN3b2KiqVBW9g=;
        b=xjOwNn4/slRFtEZByZjrgKzAjvXYiaCscNbngVltRJ5nqnsDQ8kazEqIzCbX05+pVe
         XD64qs7xhseFiUfn9R7pOUYhEDPdqB6xqbqOl+Z+N94XP5JURQ6dqoAchif9OV30ZMLh
         nfndXJb2X9N21JF3IfVgLNdJlp+ikZRvSeRazFse6k3oDPxkP6CjWfYB+qNsz2bJvE5O
         8wgF2cZSVIZs9CwJpGMQxQrybWwOF1ZZPDSIznE6yifVvlX0gt/K+x/Ne6hkrQtCq4wo
         WFzq+E3snRtfr7BH3T3MZUmDaY3C8Wc/7co+DtZGxKUzuvMsKqfeJNv3BYn64uiNP3bu
         95Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337186; x=1719941986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTgOHYrKELet2F67+EI2R71m0GwI1ZMN3b2KiqVBW9g=;
        b=IB82vs7kKKnFHJvNCNDL3Yd42sZMRdzsTTTCxl5bDGhU//Abmt4fbItyKXpV07ZrI5
         6J3MtIJljZkK0fU+7blw7rpQyLoUS75eOlhTHqE4sA7MZuErUJGYpVggC7WQFeTrFJRs
         LcWfTlZVz1W+Um3E+sm0+7LRUgGr1/YJpIjyZBii1UjtiE9SUmYnYWP5IsF2aVmoP2T8
         EB+jGYcYankMHxsV+BbIfuiMV8Tp+d9AsBVjIR3aMKXihEbX5UcdH4q6mdxk6w2zPgiw
         d61K5Rqu7qdkz3pcc05iWdDlOGM2PzMA37O2rsl9Rg5XjBVF4q8fX4/EnXc2mHErlY4G
         RRfA==
X-Gm-Message-State: AOJu0YwNquKtvT4A3S/veYjyk+3uabkcXJDQ3084lKEatcKWfxAmTSxd
	rfOsyyijqNqOAnazBiYmjde9dkINC29Q7HXzalQ1aJjp7Y6SD6AxOuPYHPe+7W6aZu2WRnRyzpK
	8Vj8=
X-Google-Smtp-Source: AGHT+IFoR/HQRF8/QBUDG9aSOxR/q8lXZMRlb0bIV7KS6wVgWwcOIT7GzM+n4BLgTNoWvkyZXpLX3Q==
X-Received: by 2002:a0c:c983:0:b0:6b2:d51c:f5b3 with SMTP id 6a1803df08f44-6b5363ceea0mr88900236d6.18.1719337186107;
        Tue, 25 Jun 2024 10:39:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b526616900sm40646736d6.66.2024.06.25.10.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:39:45 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:39:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 07/16] t/helper/test-read-graph: implement `bloom-filters`
 mode
Message-ID: <0dfd1a361e93bb4eab672f94f9447b99f63fc4c0.1719333276.git.me@ttaylorr.com>
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

Implement a mode of the "read-graph" test helper to dump out the
hexadecimal contents of the Bloom filter(s) contained in a commit-graph.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 44 +++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 3375392f6c..da9ac8584d 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -47,10 +47,32 @@ static void dump_graph_info(struct commit_graph *graph)
 	printf("\n");
 }
 
-int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+static void dump_graph_bloom_filters(struct commit_graph *graph)
+{
+	uint32_t i;
+
+	for (i = 0; i < graph->num_commits + graph->num_commits_in_base; i++) {
+		struct bloom_filter filter = { 0 };
+		size_t j;
+
+		if (load_bloom_filter_from_graph(graph, &filter, i) < 0) {
+			fprintf(stderr, "missing Bloom filter for graph "
+				"position %"PRIu32"\n", i);
+			continue;
+		}
+
+		for (j = 0; j < filter.len; j++)
+			printf("%02x", filter.data[j]);
+		if (filter.len)
+			printf("\n");
+	}
+}
+
+int cmd__read_graph(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
 	struct object_directory *odb;
+	int ret = 0;
 
 	setup_git_directory();
 	odb = the_repository->objects->odb;
@@ -58,12 +80,24 @@ int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
 	prepare_repo_settings(the_repository);
 
 	graph = read_commit_graph_one(the_repository, odb);
-	if (!graph)
-		return 1;
+	if (!graph) {
+		ret = 1;
+		goto done;
+	}
 
-	dump_graph_info(graph);
+	if (argc <= 1)
+		dump_graph_info(graph);
+	else if (!strcmp(argv[1], "bloom-filters"))
+		dump_graph_bloom_filters(graph);
+	else {
+		fprintf(stderr, "unknown sub-command: '%s'\n", argv[1]);
+		ret = 1;
+	}
 
+done:
 	UNLEAK(graph);
 
-	return 0;
+	return ret;
 }
+
+
-- 
2.45.2.664.g446e6a2b1f

