Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F121D599
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978932; cv=none; b=APs75ZHjsJpCj6IUpC2dZlZNed7VIrkuCdlpLl6mM51YFqEOHsW32vHfXasSlKri/pV5tUs13DZ4XXkFrNmK6/HrMDbVjgUt/gpIojpSHP9dGJU1aQuSEyX9+Wd2U072ai4oIFuR7lwpNh33hM3p2ihveG2Kgw1LU3ei4/tWsmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978932; c=relaxed/simple;
	bh=fw5QdFoVL9ON0lGMC8/9mxiSpi4uCjiviqssJyItRWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+D4Uzi0anMIpriX+25y7fLAJJut/xdEFA4AUgi4IUC9V7R3D5XZ71IR9gmXH95nfTagrnjZPk4Z2EZInxt7uCN+ZGkbpRYLkD1buYzOT3Xjlu5u5k6KEwAWv/Ygk60vH9ZM+qmU8pucMHNVBHpy81y6DWGSehfc4mCUq/VZSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=BOilaBF9; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="BOilaBF9"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506c00df428so57004621cf.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978930; x=1772583730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVdx9gm47TpRgT/t4SrvJRZiHt9DOioEDJ758MD+oC4=;
        b=BOilaBF9zRGOHtvFUGf/WLJaXNfDVvus8wjI+Wwyp2GZIDelnTOYkJDPiABQm49j5t
         jcL5CRVTOxruBIEpzBVUIGq9Ej+2II3HAhqWY0bOobmnlui4zUDyV6IX+yhyEdaSVnQX
         Eae6fL//0Jd0TPrNPEWHr2rUiH3e5sGQ5ggIWPWM0LUz1OXKFHAiolPQOfAUTZlStfbt
         ShUDcMDh3WK0zmyGEiDOcD+P+SH9DTxQnPx+bSNxGtUumr8hRr4wpbhQzB1AnASMblxF
         yEuqsLgpsFVTVpSIugXMTk/gR5ySxTJkau7emItelIB0pJZ3J3s/EJpy26BL6L4KoL4b
         D16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978930; x=1772583730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVdx9gm47TpRgT/t4SrvJRZiHt9DOioEDJ758MD+oC4=;
        b=VMWCnUsM4Y3g3He6G/w3DW/+08YCHeV0uyvLVvvdtka3i2krDBKXAEY2g5zImkBj/M
         7sN9yQnPuFQX1pn9xiFoQYRj7se7b4PUVn1vVDBRyZy+jVpJlyca9hckrPmHdEbJU7yV
         5LhuchkV4atRPTjjS4n1vnFgVZuZYF/UxotCc0IpZcq91RgB5+BZ+2iW8/KN5dkyTExL
         8klOJDhQ8AYuMgMsL7Cec49ft90oEoy+rM1QtlHaA6QhO7KCDG4e9DHUOUWej6viPQwD
         2ciJLiTtCw+c/ckqRIWMeWIQPECyKaQ4MDv9GxkqfZykBNns9HrtCExyc2WBH7JfcBOr
         iX8w==
X-Gm-Message-State: AOJu0YxMzhIIWVbXnCs2hCxLOO2JjGkj0R69SFr1yC596aCnuk3joG8P
	+DMmm8J2OUg40NXWiiE0rIIUXEp6fnc+6jkD8xlp3WAGwRTapyDL7W2LwX9vIT1jdSy1e6rEV7v
	GSXtqqD91zA==
X-Gm-Gg: ATEYQzwKHCAB7sjizHdv+bHi9c8oe4hIZDG3pJU59aY+NMp+6J8fJzVPmJFG2n8Vmsm
	pOTtdt8tJrsJT9IX4XQpQ62nzgePSajUY3vSnfsF11t/oK10CrhsE2x4FFHGLa27cJQt+q3rKrU
	7pXeBSK5cQCNwynzbuxBkOowwH74Jxvrp9cwj+JQpsX54yO1LRyGA5d/LF+Rn9iHJIcDxQVUD7y
	KnWumJ/QMSuvWtUTaA10iR9B+D1nSRgwzqCHOuv8R86gvD2AsbBpynPBc+lXZKmdfSISo1VinlD
	tc/WIdWbgV/b5a0q46freBrOETL3KLj1oKuEJ3J2YA6yTR4vQhj7lEh003nqadCfMAWH7MblfAj
	QXFUG3aqPUScMXNeqhmHOe6TC/I2E2nc7Bw4LvG/cbU1bAcq7kilBRDpn6UMeX5yey3qXT9/pB2
	vGln2Lu3yY8h4oKy61Rs6lSsefi31V3YONYud38J6e9atxaDZL524a0MZEzBMjP0zQs3OIWoKhA
	nVdP40xjetHwrzcVdZM8DMwrBm94Q==
X-Received: by 2002:a05:622a:11c2:b0:506:6cfc:157d with SMTP id d75a77b69052e-5070bce2c0amr162611171cf.67.1771978929667;
        Tue, 24 Feb 2026 16:22:09 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6c638dsm109669791cf.25.2026.02.24.16.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:22:09 -0800 (PST)
Date: Tue, 24 Feb 2026 19:22:07 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 14/14] repack: allow `--write-midx=incremental` without
 `--geometric`
Message-ID: <d87b360be1442663f3c05687b47d4b5a76571fd3.1771978829.git.me@ttaylorr.com>
References: <cover.1771978829.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771978829.git.me@ttaylorr.com>

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
 repack-midx.c                      | 62 ++++++++++++++++++++++++++++--
 t/t7705-repack-incremental-midx.sh | 35 ++++++++++++++---
 4 files changed, 101 insertions(+), 18 deletions(-)

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
index 5da67f854c7..3ab64937c2e 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -556,6 +556,58 @@ static int midx_compaction_step_exec(struct midx_compaction_step *step,
 	}
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
+		string_list_init_nodup(&step->u.write);
+
+		for (i = 0; i < opts->names->nr; i++) {
+			strbuf_addf(&buf, "pack-%s.idx",
+				    opts->names->items[i].string);
+			string_list_append(&step->u.write,
+					   strbuf_detach(&buf, NULL));
+		}
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
@@ -911,9 +963,13 @@ static int write_midx_incremental(struct repack_write_midx_opts *opts)
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
2.53.0.185.g29bc4dff628
