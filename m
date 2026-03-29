Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD0184540
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820495; cv=none; b=qEFnB3SwCQQUieEmH4XaVhKFNThJE6yNrcT44SO1TcrBwbtMYi2ALENl/VQ4tsr7qSLaKnd8/xkvsRjC7zrzr0nNlVBkwJYs3SD2BKF4yV8xbIQGygGS87TtpSLxHbXCA8btBhU4B0fzwX3Y80Ft/3G1kp6xQIlqAGd7xOyMLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820495; c=relaxed/simple;
	bh=Z/W1S6kPGwwTlgBjcc31bvFCKzBJiJS4d+f4ZhKEBeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izhI2aZS5sR5SagzQLVJZk7mxWYPynTf8wG0ro9REFIzsBwvFfbgpfuL1UnH+5mogVgIBqp0Xycg2kZrXbJDgXb6x+BPJMa3trHUljmaYnhAK3JQ4ptbL8YOhVe5vOqPUHpv/hYbbGwyMjLm9DquwOlquNcGHCqsyiPRydUt+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=YBcxDsQI; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="YBcxDsQI"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64e87a81639so4664593d50.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820493; x=1775425293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y/6FYJu4e1nJzJntdn/GsDi7r0g5adoxfi72vscAEkc=;
        b=YBcxDsQIcevJDRuVXR+gYGtF1avkPFo0I7enBibpvFDSS62/TZcnQ8G0OQjhAFpxSC
         wsukOfUHRHjVQIx/NCiWgvzxQ0UlZxubhhNmsZ076/uuvNwPIln06FXS8WBBfk7KjYmY
         SpmiqK4afR4IyQ9HWzv4WIma0FH+rfji3JA5YoSf1fQCwi0u+hoO8SKTab2ACePoO2Cs
         5NCRKze7Zef5JmEva1JRAXONc7K4SemL8PT7eja5kbojv03m5KHBJgK6afej/scqw/x5
         Af0yLfaTAptMkqV7SVcDZVH+Angr7fJ9KPCXzo7FIhie72lrIxxf/9QoHa6jehddDhWQ
         BJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820493; x=1775425293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/6FYJu4e1nJzJntdn/GsDi7r0g5adoxfi72vscAEkc=;
        b=rXAQMlULY152WsOMau/drUGklDdzAk3SX9f01okXpqldhLAnaH9IKuzYUeC0IMhVD0
         dXgOcJHkrJV48BglC3tKZZ/RdHMaA6TQxlX7h9gzBIv+Y/pyOrURTKIZcQp65Py7va08
         xGtf4XuIPm2bLWPiStYsDTS4cOHP0qv5aq5w03wv3xjJ/7Ds0YXxajj64DaNSTtyAQSB
         eBRaT3B7oUAr6pAmYHqYIvHQzn7Um/LeZvKH7NMz5MzF9kEdcdENe7zXLkGFZ0XZk8pE
         I/AUaW49dufpC3ji1kaMQTsn5EOd8vIhgcUul/DPB3J/eoMmenZybvbA2IMxFw/OZrqx
         JFqA==
X-Gm-Message-State: AOJu0YyGVNYYY20GQ4jUSf1Fl/UAI/72kVIKsxgTRgUSk8KXBPfCgTYe
	HMl1BA4XvCg5I3IwcdcCfVkWQGsLqsQewc5Q4w8yT127yLqXylMHqrC3vSAoL82jcJ4Ntagzhaq
	aI9fw/P0zKw==
X-Gm-Gg: ATEYQzz3OS/htwdJ5/USaAMzsa3a8zBZoiSbINth54JAuG36pbLsDfPP4zCEIVCdTgD
	wji0GKPHgv1rZ+OsuB3hfHR15JaXGf+RtGrJ6U9MjetIrnkGhbwqRsenlVnVu7BxfT8VWkumDrY
	4lc+et16Tg6H+BmQ+L+rZfFTzu0JW4RG1bcmdm875Yd5saKdhfweqKzN9NRzPb2RIxZJS3H/N1+
	ZaIOpFT11CSOnLEfuskFTSBt2GK64GN4z5pBFhwm+y9bLSRIAz7wbz7Lv4tIenOF5XNBVIPbPZm
	fkiM93cEiRIp/tQolpSYTwZFqOfhrvK0wnShOFfv881gu0HD2zV+YK6VrnxwrmDVyT/WHpAWIdc
	pfYobV4Zlcq6vmZ6cub52/RyOSQ7wkYhGTrKB97NMWh4g+do2e0rizx0fN/BLJeba4gzqeewb4Y
	ah2xZq5RHg0RBvjLyEq0zDlcUJFRiw3FM9ClhhII9JccJmhUNbQ/E48VMepJOfuoiRiJ1hTb1iC
	IG54KU4WluNBNqtN4/nnNN1EkPQlWUNEt+Yv9Ed
X-Received: by 2002:a05:690e:1342:b0:650:1d21:d6af with SMTP id 956f58d0204a3-6501d21d909mr483647d50.40.1774820492666;
        Sun, 29 Mar 2026 14:41:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65009326eddsm2983072d50.13.2026.03.29.14.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:41:32 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:41:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 16/16] repack: allow `--write-midx=incremental` without
 `--geometric`
Message-ID: <79d5a12a3902fc58f4ff824403603e252b3cf62a.1774820449.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774820449.git.me@ttaylorr.com>

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
 repack-midx.c                      | 64 ++++++++++++++++++++++++++++--
 t/t7705-repack-incremental-midx.sh | 35 +++++++++++++---
 4 files changed, 103 insertions(+), 18 deletions(-)

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
index 9e070f35868..8e187322fe4 100644
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
index 5bf5df03d5d..055aa4c1356 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -555,6 +555,60 @@ static void midx_compaction_step_release(struct midx_compaction_step *step)
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
@@ -911,9 +965,13 @@ static int write_midx_incremental(struct repack_write_midx_opts *opts)
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
index f81c2c67060..562554e69b4 100755
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
-- 
2.53.0.729.g817728289e1.dirty
