Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB319C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097251; cv=none; b=JOk8qQLcOrxWJkW1NX6+ZQG4GD+Ir6IjgGDEUAFt74e1yO/H3/7Xk8a8nmmRZ6J0tnLySVxEO7IDW43XVFvQL3fci1ANJ3KM4wP5FqQLFkL+td8q6ZwHlAFtHHDVa+BmDujS/XOphAbeJTUSmAU7Z+9VV2I1QeBCfnJVh6pS0R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097251; c=relaxed/simple;
	bh=bQiUFX3C6xAhAtQQHdBe4pH66NJN80WWporfs3Pi8LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLWof2oXTFv0ajttZ/AioK/IY6Ahf4GPfOUi58HZi7I9ZDsTGoV6HfATnjfH8XropBT6BNQLKBEi8qrkzetDkO3xx0DMpBzdUJqBscFGMxNcP+6G/OZZPEkqmnSxVvIxQViQWitJqxze3RmMerJ7Prnrmc3CrXxJpr8HF9E8Htw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=pW4vsuEo; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="pW4vsuEo"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d60157747so41828637b3.0
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097248; x=1759702048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=78+6IZ8JBbb37dn5R5UIymYRmsw/t8mLdEXFqZiLhIo=;
        b=pW4vsuEoxFerPaHjvUN5RpxVl2wcS3wkI21rmrEux04O3THdRqFqx2M6Uv+kYcvOKv
         xyX+PQ3kGzhZ5wegj/W9ap4QsMKmfBqpfeMsOV+nyvEixgO5+9auGyKVhxA2Kp6+Ypb6
         ubnMlXs6jl8CCXVxKRAMYl64Eejf3PZpb1pUoAFQkahcei/yMxQ2t69EiKa8H5+vM15W
         GIPZlUCU6mPKd2R2f3YGQQAYBj5GyJ0ZJglQMdjFVOncerdTSbXh72dP7YilNLlj6uNJ
         lt1IYoplJGKkRMgAElO6uKm9p2DI8VLG8kw3bygDjBA+AHjfWaWCQ0qmLozGGIP9Z8T3
         LbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097248; x=1759702048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78+6IZ8JBbb37dn5R5UIymYRmsw/t8mLdEXFqZiLhIo=;
        b=YtnEXOkMf87stwdD4iSrTBexZ3786unMkxInn1U81bkHqHVh3I7ioLnTYiEkzpBw7c
         3ycpVgs6Bqo9wYSkSY8S1yQ/5EKw9eI49Mz2v4S/oi1JMyZg1D9wKLU2K7uvhueBBHov
         Wna9Qz8t4ik82pb3XktVAWOIRpMJVIycjBDYTpBfn2pIAbzO6oeH4i7zsPG8X6QWCJnY
         oYRIJwN5PGJd8Ebm2Zy0N8+IsN1oNvlrcwakFUBe6bfbIsQZjAWMaxv3rah+BNebQIaB
         X28IcYqs0s0V42pBIwWcLLI/V/BPjZHPhLhoEHhQj8mgrKUJPUMlSdg+35PGZxfCtrOB
         a1fw==
X-Gm-Message-State: AOJu0YzSmOKQgD4G+DvUluGqmf2vNnIeI5Hx4scM7Qvme55X3lgAZAvC
	QNKQVPQC0FJAp3tuseN7dLeW+ra63ivIgdTBMoUH+XhaZJJ9P8UscqCGtAl7wayTL5f92NPpcBI
	xwDw/1rfpJA==
X-Gm-Gg: ASbGncuq+SxYkePCGLt9yKbgKA3Qo0oeO+oXeEufVwa2EHU0AbFQbReUe+swuNxbhda
	W8Q0KMRFqEvRq7yv+BTGba8H0I5osqA4SLs3bJumUaZh/lZDW81H36h+06IvrbpPDaUEAVAHYfC
	Q7NT6TsCDhCAlniTB+M8D5jcoRmIMr3JF/SL9rpVaxil4apSVMRoeUTyLa5nxs3D2FMZV54V0X7
	RkLLIRnL0GxiPi5D0/+0Ty5A4SXGtXmWEgHr51tq5+lHbmFILRMKRjHeNpsJhIKdNTf1V5JL/wh
	Guiw8a+s+FF/KiyIbbf1vTdOgM2j6QmZk8vxelsouku4jBul65uP8G9F6c2Bkv4Ja3xuii8+G1I
	aU5Y+EG9wl5Iv4FGwNF5H8+LGJUE9+H6ZoNNJMCTl7v5C+WqIrndwD9tgtgmlmN1/gUvDN9IonV
	ioayfn8CI1PBeLu7MP8jLqMPfmxA==
X-Google-Smtp-Source: AGHT+IFuhvl/MLkIK8OavPC59pzbVBkxAk7AdvCgzftCrJfUgWKbkzt69T3FvixsmGFjnImlDlXq7w==
X-Received: by 2002:a05:690c:c85:b0:71f:9a36:d342 with SMTP id 00721157ae682-764054e0921mr163329347b3.52.1759097248334;
        Sun, 28 Sep 2025 15:07:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-636d5b1d881sm1910869d50.19.2025.09.28.15.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:07:28 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:07:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 04/49] builtin/repack.c: avoid "the_repository" when removing
 packs
Message-ID: <f404dfa34f06a882e5ebf0b6ffa01ba365ac866b.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

The 'remove_redundant_pack()' function uses "the_repository" to obtain,
and optionally remove, the repository's MIDX. Instead of relying on
"the_repository", pass around a "struct repository *" parameter through
its callers, and use that instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 113f5fc67f..93802531e1 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -221,33 +221,35 @@ static void mark_packs_for_deletion(struct existing_packs *existing,
 	mark_packs_for_deletion_1(names, &existing->cruft_packs);
 }
 
-static void remove_redundant_pack(const char *dir_name, const char *base_name)
+static void remove_redundant_pack(struct repository *repo,
+				  const char *dir_name, const char *base_name)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct odb_source *source = the_repository->objects->sources;
+	struct odb_source *source = repo->objects->sources;
 	struct multi_pack_index *m = get_multi_pack_index(source);
 	strbuf_addf(&buf, "%s.pack", base_name);
 	if (m && source->local && midx_contains_pack(m, buf.buf))
-		clear_midx_file(the_repository);
+		clear_midx_file(repo);
 	strbuf_insertf(&buf, 0, "%s/", dir_name);
 	unlink_pack_path(buf.buf, 1);
 	strbuf_release(&buf);
 }
 
-static void remove_redundant_packs_1(struct string_list *packs)
+static void remove_redundant_packs_1(struct repository *repo,
+				     struct string_list *packs)
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, packs) {
 		if (!pack_is_marked_for_deletion(item))
 			continue;
-		remove_redundant_pack(packdir, item->string);
+		remove_redundant_pack(repo, packdir, item->string);
 	}
 }
 
 static void remove_redundant_existing_packs(struct existing_packs *existing)
 {
-	remove_redundant_packs_1(&existing->non_kept_packs);
-	remove_redundant_packs_1(&existing->cruft_packs);
+	remove_redundant_packs_1(existing->repo, &existing->non_kept_packs);
+	remove_redundant_packs_1(existing->repo, &existing->cruft_packs);
 }
 
 static void existing_packs_release(struct existing_packs *existing)
@@ -685,7 +687,7 @@ static void geometry_remove_redundant_packs(struct pack_geometry *geometry,
 		    (string_list_has_string(&existing->kept_packs, buf.buf)))
 			continue;
 
-		remove_redundant_pack(packdir, buf.buf);
+		remove_redundant_pack(existing->repo, packdir, buf.buf);
 	}
 
 	strbuf_release(&buf);
-- 
2.51.0.243.g16eca91f2c0

