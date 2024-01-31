Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F913AC0C
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741555; cv=none; b=jqKWrl4N6of4MU7MyomVAdBeQqlWJ+zkazWTmqLzngxZ18t/1E88TheyFxdUbBmuTLFfZ9/s2595FoJB67YEhX3ti4487GdhD9BfQcj7qa85vLVZNI4/X5mCK5+PFM/t0YvlqNmxSvCuowEDfY5D9jRsYjwkyNLhDiLMQmeVUxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741555; c=relaxed/simple;
	bh=4XhSqhJ8JVRpKFDRekH/n+lbH+xqkm2X1r3AFFo+4uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaJPVzf+c1xv/E/y73W4vKRP4gmsApWksoAPqnK+aELzBC5ACYB59owhjFlD0pE/lGiYi96F7FYPBwGnE8w9EnGAhHgJqiLD8M3gxst06G240ki8stlLQjgZZPMgTx0V3gc+JyJxwXGvSYMLSFm7/QhkaEQZ3bwk7WOLp1AmEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=THg/lgQ0; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="THg/lgQ0"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68c3d51ecebso1639646d6.3
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741553; x=1707346353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr9AYQwXdBciiOcJb83i1K/quz2L7bBhtA0Rvd+PWnQ=;
        b=THg/lgQ0UDqXGFcZI3k9/DRisD9or198GZvMuUpBL/5ZokJNB/Ts+yFhcss1l/H9jt
         8m74yyRHv7JWuDpxYAe1DxXxcUk27ihy5Dabg5h0wFHz3PqD4mdrkfB85qygr4vl7pKx
         phOzdIPjsIOFFZAFbhfNv0nHaskipBENF7ADk99P8KbBTJzxxtpiOTCwAM9rUUgKlVJT
         2W6jF7LdO6cOE2z6vmRTlRgeUrKVxfbqTx/dsopX2OGh+RCARkHOgqkvQJpsHV6GIKmC
         o2faZ6ywUz3fmdglZ/fDTs0tYJ7KN8KXWBsFfOFR7W3IeHrUwBJED/DxOGE0liaGfGwH
         EJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741553; x=1707346353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wr9AYQwXdBciiOcJb83i1K/quz2L7bBhtA0Rvd+PWnQ=;
        b=ZLh44SE/KtgumFtphDU9gfaVuUww/MwFdDyq0xKHzSrQRtbSpIWGmo2qM/EO+X37tC
         AP7o/tz0l53zke9gPd3VjDKgN4c6GpjXSGnnUCiIoiCf99AdMZ6Uu1qqKwhTjfV8fJTo
         S5eYm2+awsP0HaBWYhwBb0Pv6D/RZrHabFurDw6fglBcs1YnYWLK764ucarvKfsMuc7I
         h4gFRnrSd505qZxPR8QDrt15DDUr5YMSPPZGcQKSX3JKr6s8886/OCMZRxs6NE+z1EP4
         fh7lyf/24QA+hzA/yq9GaXQALJMsrBGvAPThqvBhHZVjxab/UaBzXdplDs/JN76cMvNR
         kZvw==
X-Gm-Message-State: AOJu0Ywme1QB9NBzHa+J/4Pa8rfGn7xodgQIaZOai9ZUOsDaM94L2EQ8
	x55StTXtBGApy7zTT7wylTfaeM6fVy1U7dMME1UYBkTlIOeek301SfqnrqeP63YTnyPlehogBqF
	n23c=
X-Google-Smtp-Source: AGHT+IHcz983P/VvH/L0uRPPmPC2ZDFWSry9CTUM7jAcUn/aT/1FtGezZ/RDpkEOnxsG9HU1QwvBDw==
X-Received: by 2002:a05:6214:c8b:b0:686:10cc:f695 with SMTP id r11-20020a0562140c8b00b0068610ccf695mr3394150qvr.21.1706741552960;
        Wed, 31 Jan 2024 14:52:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id lu19-20020a0562145a1300b00686a4f9312bsm5952677qvb.50.2024.01.31.14.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:32 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:31 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 05/16] t/helper/test-read-graph.c: extract
 `dump_graph_info()`
Message-ID: <7484a82f7f3dc2cae32fac90d6f8e94f3d46aa93.1706741516.git.me@ttaylorr.com>
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

Prepare for the 'read-graph' test helper to perform other tasks besides
dumping high-level information about the commit-graph by extracting its
main routine into a separate function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 8c7a83f578..3375392f6c 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -5,20 +5,8 @@
 #include "bloom.h"
 #include "setup.h"
 
-int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+static void dump_graph_info(struct commit_graph *graph)
 {
-	struct commit_graph *graph = NULL;
-	struct object_directory *odb;
-
-	setup_git_directory();
-	odb = the_repository->objects->odb;
-
-	prepare_repo_settings(the_repository);
-
-	graph = read_commit_graph_one(the_repository, odb);
-	if (!graph)
-		return 1;
-
 	printf("header: %08x %d %d %d %d\n",
 		ntohl(*(uint32_t*)graph->data),
 		*(unsigned char*)(graph->data + 4),
@@ -57,6 +45,23 @@ int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
 	if (graph->topo_levels)
 		printf(" topo_levels");
 	printf("\n");
+}
+
+int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+{
+	struct commit_graph *graph = NULL;
+	struct object_directory *odb;
+
+	setup_git_directory();
+	odb = the_repository->objects->odb;
+
+	prepare_repo_settings(the_repository);
+
+	graph = read_commit_graph_one(the_repository, odb);
+	if (!graph)
+		return 1;
+
+	dump_graph_info(graph);
 
 	UNLEAK(graph);
 
-- 
2.43.0.509.g253f65a7fc

