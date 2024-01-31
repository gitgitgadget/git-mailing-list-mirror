Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E423AC0C
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741561; cv=none; b=K988pqpHZFuefvZXoq6bf/mVaoqzC6tpdQAdRLV2SPRHOn0eGTjEJQZGQ3rgfOeJPJZfiEv4YhROIzghthQmpmc4XNCP+ThSdOXPWN3f1SurObiBKjmaXW37FnpmGZPON7kM03g7RdlaIxkYxbB3UYBYPUoiatXd6Dk+Eqjf6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741561; c=relaxed/simple;
	bh=QpKvygj6Xou3dpJDwqltvAKZw5Z6t+KtEbx3R6fAtho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK9H3qZn0Mg1CRlFT6gRSieuVxXEL8TRykv4rMY9orshF1kaflpXKzpuNlbAq/mvqDEVmM2y0ayGmbv7NUBk3pAp17EkVOjE55jXbdUNpdYNxYAf7/rvlfKehQrxwI7R/WKEb13YYkvVIIn6mOerHLPbvpW8HeuKqDvOniLeylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=i2K2g9CJ; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="i2K2g9CJ"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3be6df6bc9bso201926b6e.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741558; x=1707346358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XZLhdjkO2DzqFkBbfjp+wv5cgZ1vxqohVhDihCPq9a8=;
        b=i2K2g9CJSuaImRaIHq0C+5sidKK/pGPMV+Nj5vO1h9lAg0asdowO40EEluz4JcamU+
         xk22KfmxFoCKJvkvGA4fv6uQtV9U+WzEllSGyZoKwiuPvIMnFpFkszbqjCWOYnlLqXNM
         rlELZAcp5CPRA/TxvvUKU1sh9+8OZuadCc4CcAktvGEezLft62h2Cjn3yoKP+EFiqWok
         sZ3d1MC+AIQ76UVUZZexYjKGSi8EeWwF152V7p4td6IYyMrVvSey7sMWWAldbXjF0X5J
         zskLrnbk/i3RMUbPNpNG98hjXiZDLVCg/wf8kAZjzE9BA9O1w5JptDYRAbu2FGdW8iLK
         VVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741558; x=1707346358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZLhdjkO2DzqFkBbfjp+wv5cgZ1vxqohVhDihCPq9a8=;
        b=dsiRlWFSkVItXh9JpXsSZASE2KXEtlyB7q+6MxRGejn7b+JX6iMkQFkhWEGLQUtecI
         IjLUzZCMwtZIpSI7XagC2v/9vpJKyvwc92QnInAS7YZ+vq8pdJSKOkobhPnnyoCwrvZP
         G8Wb7VYHnLB2jFRYFYuuQ64jzuWMb1uY0hzdwDGZuNvIP6C7rSyHS+/j9DVDwkjXIjyS
         bhT2ZgK8gZb/j3LQh0VM9s3mbE6TBHSmgXB+ZmXhxeewDJjxOQbdA9Dt92Vyi9DcT5be
         U88eX2K+W+w0E4N2WjwokcSu6DBkFeMmi9j4hzVReNG/vxDqVAxl1yy/TNxm3r3v5H2U
         xing==
X-Gm-Message-State: AOJu0Yw/7BqTsSgPm/E+bwQUqMVkCjQJHO7DXG8mkkyzeebIWy7UImeG
	EOu+1JXPsZ7z4IY7iva4UscsWJ1XGqp7IPKjYmNdfJZBBHrN6g3l6yGxUm+SoGrf0XrQGLO6jXI
	JYjs=
X-Google-Smtp-Source: AGHT+IHN2AaSEIC6GGDPdm0x60xeMJ1aXSwDRjtl8vhIgwCssE1uJZr7Ni6QrIC3nrZfai8s5HQPWg==
X-Received: by 2002:a05:6808:200e:b0:3be:c20:5b72 with SMTP id q14-20020a056808200e00b003be0c205b72mr3742695oiw.7.1706741558570;
        Wed, 31 Jan 2024 14:52:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id fw8-20020a05622a4a8800b0042a0a3d29a2sm2031795qtb.49.2024.01.31.14.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:38 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:37 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 07/16] t/helper/test-read-graph: implement `bloom-filters`
 mode
Message-ID: <286fd7dcdb99af9b06b2f8e9f9adfcdc6b7d70d8.1706741516.git.me@ttaylorr.com>
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
2.43.0.509.g253f65a7fc

