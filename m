Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0F335203A
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206313; cv=none; b=Brc5Zlw7QuTMpy4taxfkg3Ru+IVeKjuR2PJMHCre9lQCjQN/YIjxe7xS6Ttd4oZiv8gc4oVmhbU8upMB3WpmiLrDitdKikW4Li+33LgOqSr6owwEdlDFx/x5f3GHY1wyLi4AwU1LJ20PIu0y2U3bgcD27zZB+P0s126ODytjj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206313; c=relaxed/simple;
	bh=+xIwGVcfyZgBtrI/PqK6J6DM4VBYdh2HMp4vbCmajlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGA2RTVDeAulRUipau2Uu4OJ7TH5EOc5Z/CINUHicKunluHXnfY7apAjj7fR6i+DfCb66LhxBINLfZePSJB9wg2uBj5BMJCU1tcg3ZPaJH8LPOT1n8GLObLVksS8kK41j3HWNtfg00TK7Q1PoeeDPr0Hzbd47MnnucgQukXo0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=pVJWwhcA; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="pVJWwhcA"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651c5d525f6so3826415d50.3
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206307; x=1779811107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdFX4k+ENaa/x40OodSLRCJfz6XxfUpI4QBU8LEaXyI=;
        b=pVJWwhcAGP9kygSOKs9kRtwfiitm0OKovH+mSHYUg6wgpgaItGxynknVvkuQE7P218
         IUZOlc+8WysOAMcaVQCVdTRD8BaxzgnSz0v0j6oFhvRinyEPZ0L+Njke9aohfpPotaEW
         4Ij2T22xwdlOY4ZjrenJBu83tGy/8l8hh9Ep1fjTsPEmnaNUDA52UGj0SaBxOQcK2pwe
         tbnJyEDx0td7bDJCjWQhxFWUlAN7H14r2WV8ajjDbA6dL6KIYMO1tV7/8F6cWsnbchwQ
         jZZOMIE/LmgxJmSMU/47xCG4ccswWy3SMOVYLB0EEyMxHbWye5wbmQyArGupZJQRs601
         q89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206307; x=1779811107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdFX4k+ENaa/x40OodSLRCJfz6XxfUpI4QBU8LEaXyI=;
        b=VTVyuJNILcUYb+BfupJ1dncFJeelmaOx52w1DNkA72Fqn6WZPMvevXT3+Q6/5YnWJb
         9T9D8Uwsm73O/kPZx8OVTQj0ZEmJM8VmsDOyw+n7K6vQYFZmgXZGNCDGrUcoWhvzVAYk
         E60ph39apjKyDrhSd/cQ0RbzVb6PFHiZ7HLl9rR7M8gvwHWR2admChA5kuCSy1jCBXcv
         RWzwdFp2fF0uuKMnU5frt4MeqsDjmRXd+JD6TXFlQyKzpdmVWRIVSInJ5Jy+LhPaWa1I
         s4V7XAf7zl0dRm/RWNn6B/owEgTmJE39EF6X3yHK9+XQMv7q5905oXjJQ4xwhvVUcqB9
         +lgg==
X-Gm-Message-State: AOJu0YyhXlHxBQtUS/8CLCyQcTn3RF46ZZNXQLWh4wlf+NpZ1N1PH0f0
	s5vkHAm/Ax2Gw36B2DpwHUx2tR/4TcGKQZpf96qWZbUreOWxVmps53sx34w8TVQYU5lTqNMaBL5
	1CCAsGFPV+g==
X-Gm-Gg: Acq92OGCUnTtsp2qU5N6KTZHccCpsoDb1CmQIz1x/VxPJvVfUTv5va6L+lNaeFt24t8
	s0QYta/OVqROWspqR8GdqjEed82N6ykdKRUksUsBVx+ct/YS38KyMUElpI787jYwykiTlZ9MY94
	QcRBKRUDByRg7dey+8aU0q6Y4LXG9uFUui7mIJVYth3eSNjsdCITuTC4ZDN5RiMaFm6gN8Dk6RP
	K5My70GJj69duyed/Fvv/Ixv/o2ucdK7vqPq01aWyh9Mth7g680cfbdRQouvvexHscMBIhh3i38
	KPskFQg7eh5aeZIUr8PhUog2/St0PWrWXpUY0vGyt5HTNeFJZiJ42/ComIXTvcTMmaxzhgoSP+p
	kaLsWdL5VablgJKwI7ksA8DqjQ/9EqDRWZZLE7KLZz+VT0QCPO5mAyDBrGMzePDf5nXtMbx+x4A
	NngsJhni9p3bQiTS24I8q7EMGXxYZSeMzRbQA7GkZlmlk46A+ZD4ZBrsClWSGVhu2NnXSeU8u+2
	s5ppR1xSFprEDkJ5azOY/ciFbI/GduOvZVVqpyRI8WVw0qo89rLMSS84jw0AmaBu2/vnOI+k36o
	nXLRnzPW6xCFgmsm
X-Received: by 2002:a53:ec12:0:b0:65c:6220:5fcf with SMTP id 956f58d0204a3-65e228b53f5mr16089326d50.62.1779206307273;
        Tue, 19 May 2026 08:58:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0b134sm7995086d50.13.2026.05.19.08.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:58:26 -0700 (PDT)
Date: Tue, 19 May 2026 11:58:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 16/16] repack: allow `--write-midx=incremental` without
 `--geometric`
Message-ID: <8bd0ec98dc31e2ece72d01c7efe6f1508729e3fd.1779206240.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779206239.git.me@ttaylorr.com>

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
index 4f5deeb97bf..b6b1de71805 100644
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
2.54.0.175.g8bd0ec98dc3
