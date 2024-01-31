Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EEB3B7A8
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741575; cv=none; b=e/fjozNJCt11jrPAcOx2kQAGq/JEOdsTaiyoEmEu95m1ctb+cy4Du/dNIZN9xF+Xzr7tUeKvd7U7OgB02kXldJ3UVd3uazBnPuB3uYp0gDteUxfeBp/NAQ7JRC/ryvqB2f8AAnpHuHrSVFAvZ69fCOWj3oL7ufBgnzQkJpNJL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741575; c=relaxed/simple;
	bh=9sKSru5iEog9Wdq1YNqplmrnhrJSDJCsLl62t4LuWwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkCex/veqv6lL9m+SvSjqcdkUeyHaMie/Pr0oWALS5gqQa570LaqkxpKeMtntMxJQMGB9xqgop7Obh6F+kmwGmarXfhPPlXLTKvJro6jqfCdh8ciwFuHHWIQmkMeW979X6QLsv8xYtaEHXRhwxGk1hT27Bj+mW5+pQu78xy+rP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fvndLF07; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fvndLF07"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a4516ec5dso2269991cf.3
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741572; x=1707346372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OtyqUkEgrQnnMAkBDyGmD5wWrqdoe4EurbjMO3timpA=;
        b=fvndLF07mDT2iTiqGoCQtEsB6Omxk51PZORL2aFcnIw8VQsjRCzVhcNzUi/Hf2ZCem
         na0d6dSUZM0ECs1wywrfHhqUVrssl1aSwU+0Eevc9FXEydO05n4gnDjAmWaeNJ60Ls9y
         WLw7gAFC8y8tGMdkvjorbPqA/LVKfGkWxJkHBkOSpk7Yj3p+ZHOyEzuaDCKUXWVrP8sh
         8CD6j7gwBsZSJaCpYeOQ4P5LCXs0lm6/nL8WFgr9afs4Tdr5nzmecZt3qRTd3FD5T9yj
         X/d1lwbkctLN2aX70IuMe3FhalVnbAPgE2Vc2ddz1YdMunBEwUZF8MdhKGnubcZ7Hla8
         Pidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741572; x=1707346372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtyqUkEgrQnnMAkBDyGmD5wWrqdoe4EurbjMO3timpA=;
        b=obuMBUzcK+nuUZzPYIn43svWkoJbwTKqbZSbgr5CvUqtjS3jKGg50hDTfh1C2uLm4g
         rvqbg/UVNub/yYPscZthchAZtPPJewv/WCHLyB/xZpTsXe5iT13obm982i0ok9vMK8vq
         0zBmAEbNIGbdHS9bKg26ULKLOWoaXT8jGvVBSp9YXnzd6JuB8xwstoe6q/a78QB2dbm1
         oyGGrlkgey9O5mFhJWwcOHqmBC2KwtJj98sV045ueOlUA1GoKT5xnHDVrUdWq3C7TQvP
         mTS80ZlPD/mNQjguWyxijiWJmULuJ44nECeArJ4cJ7GEYLskea+Kp+WFpqV3QUzxEX96
         uuRg==
X-Gm-Message-State: AOJu0YytP9gHBGv50FdZ+2yed5C3YQ1tCVgDXvJYywkKJ0y1FZkuNYdY
	gapY32dSbOacFOqCmeMu35NdDMyPsbKqI7ropOwkBg8hyER1RBrTTs+wQcRJq5KKEle1CWPS/Cu
	+n1o=
X-Google-Smtp-Source: AGHT+IEXR6gsZNMBziNI669xqvo6uFJ3Pfyu7k/98kxW7QunSYjV3iPA8l3IHyNG5izHufF2x9fWow==
X-Received: by 2002:a05:6214:f25:b0:686:964a:fda with SMTP id iw5-20020a0562140f2500b00686964a0fdamr867862qvb.49.1706741572338;
        Wed, 31 Jan 2024 14:52:52 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id os21-20020a05620a811500b007853eb72c49sm617218qkn.46.2024.01.31.14.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:52 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:51 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 12/16] commit-graph: unconditionally load Bloom filters
Message-ID: <c8e9bb7c88e6adb0dc28ea78db8065bd3cedb59c.1706741516.git.me@ttaylorr.com>
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

In an earlier commit, we began ignoring the Bloom data ("BDAT") chunk
for commit-graphs whose Bloom filters were computed using a hash version
incompatible with the value of `commitGraph.changedPathVersion`.

Now that the Bloom API has been hardened to discard these incompatible
filters (with the exception of low-level APIs), we can safely load these
Bloom filters unconditionally.

We no longer want to return early from `graph_read_bloom_data()`, and
similarly do not want to set the bloom_settings' `hash_version` field as
a side-effect. The latter is because we want to wait until we know which
Bloom settings we're using (either the defaults, from the GIT_TEST
variables, or from the previous commit-graph layer) before deciding what
hash_version to use.

If we detect an existing BDAT chunk, we'll infer the rest of the
settings (e.g., number of hashes, bits per entry, and maximum number of
changed paths) from the earlier graph layer. The hash_version will be
inferred from the previous layer as well, unless one has already been
specified via configuration.

Once all of that is done, we normalize the value of the hash_version to
either "1" or "2".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b80bf36720..6c3fbae142 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -358,9 +358,6 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 	g->chunk_bloom_data_size = chunk_size;
 	hash_version = get_be32(chunk_start);
 
-	if (hash_version != 1)
-		return 0;
-
 	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
 	g->bloom_filter_settings->hash_version = hash_version;
 	g->bloom_filter_settings->num_hashes = get_be32(chunk_start + 4);
@@ -2516,6 +2513,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
 	ctx->num_generation_data_overflows = 0;
 
+	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version;
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
 	bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
@@ -2547,10 +2545,18 @@ int write_commit_graph(struct object_directory *odb,
 		/* We have changed-paths already. Keep them in the next graph */
 		if (g && g->chunk_bloom_data) {
 			ctx->changed_paths = 1;
-			ctx->bloom_settings = g->bloom_filter_settings;
+
+			/* don't propagate the hash_version unless unspecified */
+			if (bloom_settings.hash_version == -1)
+				bloom_settings.hash_version = g->bloom_filter_settings->hash_version;
+			bloom_settings.bits_per_entry = g->bloom_filter_settings->bits_per_entry;
+			bloom_settings.num_hashes = g->bloom_filter_settings->num_hashes;
+			bloom_settings.max_changed_paths = g->bloom_filter_settings->max_changed_paths;
 		}
 	}
 
+	bloom_settings.hash_version = bloom_settings.hash_version == 2 ? 2 : 1;
+
 	if (ctx->split) {
 		struct commit_graph *g = ctx->r->objects->commit_graph;
 
-- 
2.43.0.509.g253f65a7fc

