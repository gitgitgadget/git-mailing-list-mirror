Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B5EAC7
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508035; cv=none; b=Oi1XsXqVI/1FPJDVR3qE85ayPztPzBXQP94x1ilO+8iRP/oe0jg6hsG1t+SJvsed/EEAzKxt7223+OIO4wipvIeuTiu1GOqe+0S1Gphd1u4ozztJDkBMmDOXPogvBSe+OEF+6VAqAisgVXmix9PNx+FIaVwvHBIj84pHuWpoc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508035; c=relaxed/simple;
	bh=cpQVaJtJj1l5oEJhcymttYr7j9g58uKCsiGTdPqeaMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsFSTZtCvFm0SE0M1pnfrb/XmovlKUZxGsNJBALGnFbTR7DYzNp2bIq3vCdzY7Y0dItD9LSkJoTeqaXgC+L7goHBZB+Y5/9FcpBsZTzhywR8tFAfZJAIGysZEpf3n8DolLiZZhQJQLVDhn7Eono7W4VuZGBZgeSyQE2so2lyTKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=aEZTporv; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="aEZTporv"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6587cee8b57so341232d50.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777508033; x=1778112833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2UnUMS18S5av2TitcfnG5GlKRZfdByixS+bpOlcts5A=;
        b=aEZTporviO6ZVQeY26aknBfMJkK57wi36lUE/XxIl6EmC0YZYr5eZkIFsKEZW8oFco
         JZY2G1B8ENTv449l8xiJRPnsye5J1gxACp5OIYpimlofHRg5sprwhiNr/W1usAdBVtbT
         l507AOKjh/9cSHPa48I/l21DYAuOL4KzlxPUBzzHXyu9LgUDJT5jO2qipx4JIx8ne34z
         rkiI9St+nZ+CiXqjlguJks6FIYW1wedlj5NjCzAQPlqyToz6jtuNgNYzyjBOspcX6aJH
         PrIi11RWrPYy0JTqRISJ8WoStShGTvKxPDJi+XZORRpV7P8cLcp0Ppmgdd0w8lqBZI1Y
         Q3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777508033; x=1778112833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UnUMS18S5av2TitcfnG5GlKRZfdByixS+bpOlcts5A=;
        b=P2Ua5wiKOfbhCcc8J5Fe4ad82MbPw6s4wbhgKCDmz+3cPL5F18xJ1YQ1zSq9NF2cJI
         leL3bT1QYx5brpTeHFmumLXVq00ZUjHrPrCy8rKVcoEu3vj33QOM6MDIw+8nktYkgL+H
         aGtIQqwavDNYA/L7oDkIK6OroxwjdS/Jk4T2F2qZ8MwDKJUeKgCd5rKCyHYVSBPeKTQb
         ILx1JzDlocMW03s/jlpnmVELtJNWYmwfd0Xrs4bqFW6GVBy1fkISoEq4bPVF4QrJHYJW
         z5J+mVq9fpAi31OMbTrXtO0KWhpZ9hAKu5fmvyv/UD2SakK3Wv3AMyiIDm3juqaaBCEc
         upGA==
X-Gm-Message-State: AOJu0YwyHE1RXU91gDey2ZjrryLEf7KEyu8bXbo/KG94Xn79BJHLE2gz
	45BzU1a6HDEe33VpTVNNrlg6N6mhD4D/hto1PH9Dt3ung2L8Gj3wmPPLSb+RnRaKNnZhxDuQd+v
	4YIzSqDeo/g==
X-Gm-Gg: AeBDieuraP5zRbcwN2r+7rWjvXRyH7WUOKc8cf+bppjOvzRUNKIw8u/yQ24f4KCP2N2
	yFKW7jzVKt1KBopGNtxpwV4buE7lQ8ZjL8cC5a+jXJglOUb/7VpYv1H5gRUGX0mf/tlDEYEW2f7
	42ZmSUsdfkatXF49z7VlTZBSgfDwp05i5FBIA8zR0IAPfm46+nvv4aXylJE5sdfPSeEA/S3B9pO
	TIVhDA6Bd9ee5Y6G5vFaboP/lpZyMKNsxoBOSFWU7CY0PfKTzBe2lFZv4v4mKALRmYtnk8ep8WQ
	Eo8LsTgsH0d7GA0wJg+ybSSE5pxpbukD8qhbvJPRXJNUf3ro3PkHYPpTi/0ujLUlM6REcBxTOu9
	VLR16rkP5pw4G+kaw3AkZ7HTPBNS9oVzmXoi9ZRWfkiDHdoAi37JgDjqLgB/Q9kz+Msq/eGscGB
	CCinrKV55oE5UTn5Y91YHzS205YSHXSE1gRITxZQ4bKg9FxjBdWn/e4y7fg1lauiOhoFo1KUupG
	yNHMzEDhMxdKxdNseiGsEtiYa8YNQO7Z1c4sHUbLMVTgCgFmepd2iunHYXs+drZ0WS5CXYD3u7l
	85NxQtuptlWZZXuee2d/X3zFizeRi4L2H205Tw==
X-Received: by 2002:a05:690e:492:b0:64c:9f31:e33 with SMTP id 956f58d0204a3-65c18ff60e8mr296575d50.65.1777508033246;
        Wed, 29 Apr 2026 17:13:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff736512sm1957664d50.16.2026.04.29.17.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 17:13:52 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:13:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 16/16] repack: allow `--write-midx=incremental` without
 `--geometric`
Message-ID: <1c05dfce579fe7067adc148e02557493924adc64.1777507303.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1777507303.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777507303.git.me@ttaylorr.com>

Previously, `--write-midx=incremental` required `--geometric` and would
die() without it. Relax this restriction so that incremental MIDX
repacking can be used independently.

Without `--geometric`, the behavior is append-only: a single new MIDX
layer is created containing whatever packs were written by the repack
and appended to the existing chain (or a new chain is started). Existing
layers are preserved as-is with no compaction or merging.

Implement this via a new repack_make_midx_append_plan() that builds a
plan consisting of a WRITE step for the freshly written packs followed
by COPY steps for every existing MIDX layer. The existing compaction
plan (repack_make_midx_compaction_plan) is used only when `--geometric`
is active.

Update the documentation to describe the behavior with and without
`--geometric`, and replace the test that enforced the old restriction
with one exercising append-only incremental MIDX repacking.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-repack.adoc      | 19 +++++----
 builtin/repack.c                   |  3 --
 repack-midx.c                      | 64 +++++++++++++++++++++++++++--
 t/t7705-repack-incremental-midx.sh | 65 +++++++++++++++++++++++++++---
 4 files changed, 133 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 27a99cc46f4..72c42015e23 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -263,14 +263,19 @@ linkgit:git-multi-pack-index[1]).
 
 	`incremental`;;
 		Write an incremental MIDX chain instead of a single
-		flat MIDX. This mode requires `--geometric`.
+		flat MIDX.
 +
-The incremental mode maintains a chain of MIDX layers that is compacted
-over time using a geometric merging strategy. Each repack creates a new
-tip layer containing the newly written pack(s). Adjacent layers are then
-merged whenever the newer layer's object count exceeds
-`1/repack.midxSplitFactor` of the next deeper layer's count. Layers
-that do not meet this condition are retained as-is.
+Without `--geometric`, a new MIDX layer is appended to the existing
+chain (or a new chain is started) containing whatever packs were written
+by the repack. Existing layers are preserved as-is.
++
+When combined with `--geometric`, the incremental mode maintains a chain
+of MIDX layers that is compacted over time using a geometric merging
+strategy. Each repack creates a new tip layer containing the newly
+written pack(s). Adjacent layers are then merged whenever the newer
+layer's object count exceeds `1/repack.midxSplitFactor` of the next
+deeper layer's count. Layers that do not meet this condition are
+retained as-is.
 +
 The result is that newer (tip) layers tend to contain many small packs
 with relatively few objects, while older (deeper) layers contain fewer,
diff --git a/builtin/repack.c b/builtin/repack.c
index 5ffa18e085e..1524a9c13ad 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -263,9 +263,6 @@ int cmd_repack(int argc,
 	if (pack_everything & PACK_CRUFT)
 		pack_everything |= ALL_INTO_ONE;
 
-	if (write_midx == REPACK_WRITE_MIDX_INCREMENTAL && !geometry.split_factor)
-		die(_("--write-midx=incremental requires --geometric"));
-
 	if (write_bitmaps < 0) {
 		if (write_midx == REPACK_WRITE_MIDX_NONE &&
 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
diff --git a/repack-midx.c b/repack-midx.c
index bb3bee03ace..799f2b03697 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -548,6 +548,60 @@ static void midx_compaction_step_release(struct midx_compaction_step *step)
 	free(step->csum);
 }
 
+/*
+ * Build an append-only MIDX plan: a single WRITE step for the freshly
+ * written packs, plus COPY steps for every existing layer.  No
+ * compaction or merging is performed.
+ */
+static void repack_make_midx_append_plan(struct repack_write_midx_opts *opts,
+					 struct midx_compaction_step **steps_p,
+					 size_t *steps_nr_p)
+{
+	struct multi_pack_index *m;
+	struct midx_compaction_step *steps = NULL;
+	struct midx_compaction_step *step;
+	size_t steps_nr = 0, steps_alloc = 0;
+
+	odb_reprepare(opts->existing->repo->objects);
+	m = get_multi_pack_index(opts->existing->source);
+
+	if (opts->names->nr) {
+		struct strbuf buf = STRBUF_INIT;
+		uint32_t i;
+
+		ALLOC_GROW(steps, st_add(steps_nr, 1), steps_alloc);
+
+		step = &steps[steps_nr++];
+		memset(step, 0, sizeof(*step));
+
+		step->type = MIDX_COMPACTION_STEP_WRITE;
+		string_list_init_dup(&step->u.write);
+
+		for (i = 0; i < opts->names->nr; i++) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "pack-%s.idx",
+				    opts->names->items[i].string);
+			string_list_append(&step->u.write, buf.buf);
+		}
+
+		strbuf_release(&buf);
+	}
+
+	for (; m; m = m->base_midx) {
+		ALLOC_GROW(steps, st_add(steps_nr, 1), steps_alloc);
+
+		step = &steps[steps_nr++];
+		memset(step, 0, sizeof(*step));
+
+		step->type = MIDX_COMPACTION_STEP_COPY;
+		step->u.copy = m;
+		step->objects_nr = m->num_objects;
+	}
+
+	*steps_p = steps;
+	*steps_nr_p = steps_nr;
+}
+
 static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 					    struct midx_compaction_step **steps_p,
 					    size_t *steps_nr_p)
@@ -904,9 +958,13 @@ static int write_midx_incremental(struct repack_write_midx_opts *opts)
 		goto done;
 	}
 
-	if (repack_make_midx_compaction_plan(opts, &steps, &steps_nr) < 0) {
-		ret = error(_("unable to generate compaction plan"));
-		goto done;
+	if (opts->geometry->split_factor) {
+		if (repack_make_midx_compaction_plan(opts, &steps, &steps_nr) < 0) {
+			ret = error(_("unable to generate compaction plan"));
+			goto done;
+		}
+	} else {
+		repack_make_midx_append_plan(opts, &steps, &steps_nr);
 	}
 
 	for (i = 0; i < steps_nr; i++) {
diff --git a/t/t7705-repack-incremental-midx.sh b/t/t7705-repack-incremental-midx.sh
index 9e317ff6e8f..25a8c40e8ee 100755
--- a/t/t7705-repack-incremental-midx.sh
+++ b/t/t7705-repack-incremental-midx.sh
@@ -63,10 +63,36 @@ create_layers () {
 	done
 }
 
-test_expect_success '--write-midx=incremental requires --geometric' '
-	test_must_fail git repack --write-midx=incremental 2>err &&
+test_expect_success '--write-midx=incremental without --geometric' '
+	git init incremental-without-geometric &&
+	(
+		cd incremental-without-geometric &&
 
-	test_grep -- "--write-midx=incremental requires --geometric" err
+		git config maintenance.auto false &&
+
+		test_commit first &&
+		git repack -d &&
+
+		test_commit second &&
+		git repack --write-midx=incremental &&
+
+		git multi-pack-index verify &&
+		test_line_count = 1 $midx_chain &&
+		cp $midx_chain $midx_chain.before &&
+
+		# A second repack appends a new layer without
+		# disturbing the existing one.
+		test_commit third &&
+		git repack --write-midx=incremental &&
+
+		git multi-pack-index verify &&
+		test_line_count = 2 $midx_chain &&
+		head -n 1 $midx_chain.before >expect &&
+		head -n 1 $midx_chain >actual &&
+		test_cmp expect actual &&
+
+		git fsck
+	)
 '
 
 test_expect_success 'below layer threshold, tip packs excluded' '
@@ -334,8 +360,7 @@ test_expect_success 'kept packs are excluded from repack' '
 		# entirely, so no rollup occurs as there is only one
 		# non-kept pack. A new MIDX layer is written containing
 		# that pack.
-		git repack --geometric=2 -d --write-midx=incremental \
-			--write-bitmap-index &&
+		git repack --geometric=2 -d --write-midx=incremental &&
 
 		test-tool read-midx $objdir >actual &&
 		grep "^pack-.*\.idx$" actual >actual.packs &&
@@ -433,6 +458,36 @@ test_expect_success 'repack -ad removes stale incremental chain' '
 	)
 '
 
+test_expect_success 'repack -ad --write-midx=incremental is safe' '
+	git init ad-incremental-midx &&
+	(
+		cd ad-incremental-midx &&
+
+		git config maintenance.auto false &&
+
+		# Build a MIDX chain with multiple layers referencing
+		# distinct packs.
+		test_commit first &&
+		git repack -d &&
+
+		test_commit second &&
+		git repack -d --write-midx=incremental &&
+
+		git multi-pack-index verify &&
+		test_line_count = 1 $midx_chain &&
+
+		# Now do a full -ad repack. The new pack contains all
+		# objects, but any retained MIDX layers still reference
+		# the now-deleted packs.
+		test_commit third &&
+		git repack -ad --write-midx=incremental &&
+
+		git multi-pack-index verify &&
+		git fsck &&
+		git rev-list --all --objects >/dev/null
+	)
+'
+
 test_expect_success 'repack rejects invalid midxSplitFactor' '
 	test_when_finished "rm -fr bad-split-factor" &&
 	git init bad-split-factor &&
-- 
2.54.0.16.g1c05dfce579
