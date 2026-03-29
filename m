Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF752F6931
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820490; cv=none; b=XeZ6h8eIPl7pUMYY9PQepp9PmlXMe43/ZgFiOwt8NOlQ3g5wI+81IXP7N6pSiJ6VehgZHaeVs7aNSABUJ/S3lPtL4UfdIQqPlAtRwRvOXqjtb4JyvokpKmKFGJDcmoJj/OYLO8f1Awwt2EqHpe1PmYr/+sd7+YLvR1pHxKZrOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820490; c=relaxed/simple;
	bh=UYDqA7uNoshDcmtoUPT/Anx6enCN4G2LltL6dt5rm9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4ea7aojJgo3Jhi2x55rDQdMfHHfaymVNjofsadkd/RE4ugiXj4l3R+5akw1a3W6iGie5SQsySBH9iAT8veC1MsBH2YlK549K/EJJQDAnKpkbABP+uxnqXP4sCKETmDeNSnOV0GctnktRhj/8k5KCNTkhmjMdTXMJdyduNajFRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=kGSyFS4Z; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="kGSyFS4Z"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-6500040ef83so2120608d50.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820487; x=1775425287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJzMqda1IBXqG4mmZSf9uuXJ6vkuGJzvt14rt/YpAdI=;
        b=kGSyFS4ZR6SOkizfAurL5E2UnMI1QOozwQDzQBL9huwSY8P4CUxkg6+v41OfYneHwN
         c4iOmGzMVLJi7PnXcuuA5c0xcEMmKSOqK1QCN5l5VoeNJkujJfdYzdJdQ7UvbZb05Y1c
         ABZd3WIbrgE+BWC80rDdoflLYtPKLAAdGgTw+CXOVHuDrMayADdJHLBdqb98t9j1SUNE
         IqeCZt82rimhI8NDzSzwIsiM35RevQsohUNivXlg5AR3+HDF3bNDvDa+0XMnzarZrc4X
         yTdRoMwD6fC2fTrpJXVT9VM8q43a1xiB+8wlKYXUiXS6CP/5Wrb1Qck+Py++xkN5qvDW
         heMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820487; x=1775425287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJzMqda1IBXqG4mmZSf9uuXJ6vkuGJzvt14rt/YpAdI=;
        b=sQdObljHlkByBApZAU47XOvAN0cED+e2npw6PJ7pj1UvsoPI7/euwZ7LLMAiIKaacu
         Lb4S9JVo+ekqwDbgrqvlblWi8g+L1HFB7pxXg5AtdYY0jELpLUGpGQuXdPQet9rk3Raj
         FacipSGIR1h73SOnsXtLRFOm+tSHlWCU2oJWv+LiGaUMjFAUffTfL72JuczxOZuSsplL
         yEkzdCWmGcfCcDm+SqXpqAz/05cuodkVb1Ozl8BmAm6yVwHDIcgddzYqyIAl3Cunh/ZP
         Sq3s/qEA41P1NzsjV9/9SJbuyycAF/CI7L4jTBHB9m9oS+Um+6wB53Znj8vNq9Rci8J9
         4z1A==
X-Gm-Message-State: AOJu0YyMtofw2Nuo3kWrzyHG7rVqYFYRdCy4n5Ae53+0byndm1Cut9ZX
	plDYZPsaV/DBaPL0BJxVQ9z2OMolhzfyVYD1Qzkn7XGN6wWaVKAXKRcVSycgyEN/CtutW4FVv00
	pQeVzgEbjIRVU
X-Gm-Gg: ATEYQzz7Ve7v7nBjSZ8Nk6OB0yRV5PhljaIRZJJtyT2gx4XnhajZ0RxvxaO772FwHtg
	YVvhNKIH9KYqW8s/a/vc4kxvX+x7MdKsspaDj4xzcbkYizuNqz7rFKRp8Yii11Vz8xW20yWHoH6
	+Agmz9LgE/Z+ZAprH30Vo8G92HSgI/3s9PhseiqZfn+6aBRqEDkRHrM+f9Ak85wq8wBOLggi3NK
	6u1R0Hq1+0gfKLnPYOG12KyMYHBBSwl3uJAqXAc90pyautCtydcCCdLsS3K9b023us7mm0nn11x
	rAX+Ahha98WWv/UOUiE4PXiBmlZZm0+oVGoXZsEuZt59wIeIfJ4UEv9eq5lEW/iLgVrueVk042F
	4baQ60KzTB70/84+T/EcZMZIQWN8Ohe3X1uYrMN7sTQiNfv9nv8R5kjMcs/vtyTVjN1BSPIXTWP
	Hu4PXiKu3DIyrO7eNvlyCyaNOgl0T+RT+laRwQYkLWTLPVvnMypITiRX9VOwYgKpVFi6FSYePZR
	gUtnZr/x+nBKTXekv7xBwinxpMZwQX6WW//ALbI
X-Received: by 2002:a0d:e746:0:b0:79a:cdf0:e267 with SMTP id 00721157ae682-79bddd79e54mr78404117b3.5.1774820487374;
        Sun, 29 Mar 2026 14:41:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb7c05b88sm26604967b3.20.2026.03.29.14.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:41:27 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:41:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 14/16] repack: implement incremental MIDX repacking
Message-ID: <8d5aa3d6fa70d408fc02561f2203ae1a48186c91.1774820449.git.me@ttaylorr.com>
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

Implement the `write_midx_incremental()` function, which builds and
maintains an incremental MIDX chain as part of the geometric repacking
process.

Unlike the default mode which writes a single flat MIDX, the incremental
mode constructs a compaction plan that determines which MIDX layers to
write, compact, or copy, and then executes each step using `git
multi-pack-index` subcommands with the --checksum-only flag.

The repacking strategy works as follows:

 * Acquire the lock guarding the multi-pack-index-chain.

 * A new MIDX layer is always written containing the newly created
   pack(s). If the tip MIDX layer was rewritten during geometric
   repacking, any surviving packs from that layer are also included.

 * Starting from the new layer, adjacent MIDX layers are merged together
   as long as the accumulated object count exceeds half the object count
   of the next deeper layer (controlled by 'repack.midxSplitFactor').

 * Remaining layers in the chain are evaluated pairwise and either
   compacted or copied as-is, following the same merging condition.

 * Write the contents of the new multi-pack-index chain, atomically move
   it into place, and then release the lock.

 * Delete any now-unused MIDX layers.

After writing the new layer, the strategy is evaluated among the
existing MIDX layers in order from oldest to newest. Each step that
writes a new MIDX layer uses "--checksum-only" to avoid updating the
multi-pack-index-chain file. After all steps are complete, the new chain
file is written and then atomically moved into place.

At present, this functionality is exposed behind a new enum value,
`REPACK_WRITE_MIDX_INCREMENTAL`, but has no external callers. A
subsequent commit will expose this mode via `git repack
--write-midx=incremental`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-midx.c | 578 +++++++++++++++++++++++++++++++++++++++++++++++++-
 repack.h      |   3 +
 2 files changed, 579 insertions(+), 2 deletions(-)

diff --git a/repack-midx.c b/repack-midx.c
index 4a568a2a9b8..a159b879775 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -2,12 +2,16 @@
 #include "repack.h"
 #include "hash.h"
 #include "hex.h"
+#include "lockfile.h"
+#include "midx.h"
 #include "odb.h"
 #include "oidset.h"
 #include "pack-bitmap.h"
+#include "path.h"
 #include "refs.h"
 #include "run-command.h"
 #include "tempfile.h"
+#include "trace2.h"
 
 struct midx_snapshot_ref_data {
 	struct repository *repo;
@@ -293,13 +297,16 @@ static void repack_prepare_midx_command(struct child_process *cmd,
 }
 
 static int repack_fill_midx_stdin_packs(struct child_process *cmd,
-					struct string_list *include)
+					struct string_list *include,
+					struct string_list *out)
 {
 	struct string_list_item *item;
 	FILE *in;
 	int ret;
 
 	cmd->in = -1;
+	if (out)
+		cmd->out = -1;
 
 	strvec_push(&cmd->args, "--stdin-packs");
 
@@ -312,6 +319,17 @@ static int repack_fill_midx_stdin_packs(struct child_process *cmd,
 		fprintf(in, "%s\n", item->string);
 	fclose(in);
 
+	if (out) {
+		struct strbuf buf = STRBUF_INIT;
+		FILE *outf = xfdopen(cmd->out, "r");
+
+		while (strbuf_getline(&buf, outf) != EOF)
+			string_list_append(out, buf.buf);
+		strbuf_release(&buf);
+
+		fclose(outf);
+	}
+
 	return finish_command(cmd);
 }
 
@@ -369,7 +387,7 @@ static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 		strvec_pushf(&cmd.args, "--refs-snapshot=%s",
 			     opts->refs_snapshot);
 
-	ret = repack_fill_midx_stdin_packs(&cmd, &include);
+	ret = repack_fill_midx_stdin_packs(&cmd, &include, NULL);
 done:
 	if (!ret && opts->write_bitmaps)
 		remove_redundant_bitmaps(&include, opts->packdir);
@@ -379,6 +397,560 @@ static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 	return ret;
 }
 
+struct midx_compaction_step {
+	union {
+		struct multi_pack_index *copy;
+		struct string_list write;
+		struct {
+			struct multi_pack_index *from;
+			struct multi_pack_index *to;
+		} compact;
+	} u;
+
+	uint32_t objects_nr;
+	char *csum;
+
+	enum {
+		MIDX_COMPACTION_STEP_UNKNOWN,
+		MIDX_COMPACTION_STEP_COPY,
+		MIDX_COMPACTION_STEP_WRITE,
+		MIDX_COMPACTION_STEP_COMPACT,
+	} type;
+};
+
+static const char *midx_compaction_step_base(const struct midx_compaction_step *step)
+{
+	switch (step->type) {
+	case MIDX_COMPACTION_STEP_UNKNOWN:
+		BUG("cannot use UNKNOWN step as a base");
+	case MIDX_COMPACTION_STEP_COPY:
+		return midx_get_checksum_hex(step->u.copy);
+	case MIDX_COMPACTION_STEP_WRITE:
+		BUG("cannot use WRITE step as a base");
+	case MIDX_COMPACTION_STEP_COMPACT:
+		return midx_get_checksum_hex(step->u.compact.to);
+	default:
+		BUG("unhandled midx compaction step type %d", step->type);
+	}
+}
+
+static int midx_compaction_step_exec_copy(struct midx_compaction_step *step)
+{
+	step->csum = xstrdup(midx_get_checksum_hex(step->u.copy));
+	return 0;
+}
+
+static int midx_compaction_step_exec_write(struct midx_compaction_step *step,
+					   struct repack_write_midx_opts *opts,
+					   const char *base)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct string_list hash = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	const char *preferred_pack = NULL;
+	int ret = 0;
+
+	if (!step->u.write.nr) {
+		ret = error(_("no packs to write MIDX during compaction"));
+		goto out;
+	}
+
+	for_each_string_list_item(item, &step->u.write) {
+		if (item->util)
+			preferred_pack = item->string;
+	}
+
+	repack_prepare_midx_command(&cmd, opts, "write");
+	strvec_pushl(&cmd.args, "--incremental", "--checksum-only", NULL);
+	strvec_pushf(&cmd.args, "--base=%s", base ? base : "none");
+
+	if (preferred_pack) {
+		struct strbuf buf = STRBUF_INIT;
+
+		strbuf_addstr(&buf, preferred_pack);
+		strbuf_strip_suffix(&buf, ".idx");
+		strbuf_addstr(&buf, ".pack");
+
+		strvec_pushf(&cmd.args, "--preferred-pack=%s", buf.buf);
+
+		strbuf_release(&buf);
+	}
+
+	ret = repack_fill_midx_stdin_packs(&cmd, &step->u.write, &hash);
+	if (hash.nr != 1) {
+		ret = error(_("expected exactly one line during MIDX write, "
+			      "got: %"PRIuMAX),
+			    (uintmax_t)hash.nr);
+		goto out;
+	}
+
+	step->csum = xstrdup(hash.items[0].string);
+
+out:
+	string_list_clear(&hash, 0);
+
+	return ret;
+}
+
+static int midx_compaction_step_exec_compact(struct midx_compaction_step *step,
+					     struct repack_write_midx_opts *opts)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	FILE *out = NULL;
+	int ret;
+
+	repack_prepare_midx_command(&cmd, opts, "compact");
+	strvec_pushl(&cmd.args, "--incremental", "--checksum-only",
+		     midx_get_checksum_hex(step->u.compact.from),
+		     midx_get_checksum_hex(step->u.compact.to), NULL);
+
+	cmd.out = -1;
+
+	ret = start_command(&cmd);
+	if (ret)
+		goto out;
+
+	out = xfdopen(cmd.out, "r");
+	while (strbuf_getline_lf(&buf, out) != EOF) {
+		if (step->csum) {
+			ret = error(_("unexpected MIDX output: '%s'"), buf.buf);
+			goto out;
+		}
+		step->csum = strbuf_detach(&buf, NULL);
+	}
+
+	ret = finish_command(&cmd);
+
+out:
+	if (out)
+		fclose(out);
+	strbuf_release(&buf);
+
+	return ret;
+}
+
+static int midx_compaction_step_exec(struct midx_compaction_step *step,
+				     struct repack_write_midx_opts *opts,
+				     const char *base)
+{
+	switch (step->type) {
+	case MIDX_COMPACTION_STEP_UNKNOWN:
+		BUG("cannot execute UNKNOWN midx compaction step");
+	case MIDX_COMPACTION_STEP_COPY:
+		return midx_compaction_step_exec_copy(step);
+	case MIDX_COMPACTION_STEP_WRITE:
+		return midx_compaction_step_exec_write(step, opts, base);
+	case MIDX_COMPACTION_STEP_COMPACT:
+		return midx_compaction_step_exec_compact(step, opts);
+	default:
+		BUG("unhandled midx compaction step type %d", step->type);
+	}
+}
+
+static void midx_compaction_step_release(struct midx_compaction_step *step)
+{
+	if (step->type == MIDX_COMPACTION_STEP_WRITE)
+		string_list_clear(&step->u.write, 0);
+	free(step->csum);
+}
+
+static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
+					    struct midx_compaction_step **steps_p,
+					    size_t *steps_nr_p)
+{
+	struct multi_pack_index *m;
+	struct midx_compaction_step *steps = NULL;
+	struct midx_compaction_step step = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+	size_t steps_nr = 0, steps_alloc = 0;
+	uint32_t i;
+	int ret = 0;
+
+	trace2_region_enter("repack", "make_midx_compaction_plan",
+			    opts->existing->repo);
+
+	odb_reprepare(opts->existing->repo->objects);
+	m = get_multi_pack_index(opts->existing->source);
+
+	for (i = 0; m && i < m->num_packs + m->num_packs_in_base; i++) {
+		if (prepare_midx_pack(m, i)) {
+			ret = error(_("could not load pack %"PRIu32" from MIDX"),
+				    i);
+			goto out;
+		}
+	}
+
+	trace2_region_enter("repack", "steps:write", opts->existing->repo);
+
+	/*
+	 * The first MIDX in the resulting chain is always going to be
+	 * new.
+	 *
+	 * At a minimum, it will include all of the newly written packs.
+	 * If there is an existing MIDX whose tip layer contains packs
+	 * that were repacked, it will also include any of its packs
+	 * which were *not* rolled up as part of the geometric repack
+	 * (if any), and the previous tip will be replaced.
+	 *
+	 * It may grow to include the packs from zero or more MIDXs from
+	 * the old chain, beginning either at the old tip (if the MIDX
+	 * was *not* rewritten) or the old tip's base MIDX layer
+	 * (otherwise).
+	 */
+	step.type = MIDX_COMPACTION_STEP_WRITE;
+	string_list_init_dup(&step.u.write);
+
+	for (i = 0; i < opts->names->nr; i++) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "pack-%s.idx", opts->names->items[i].string);
+		string_list_append(&step.u.write, buf.buf);
+
+		trace2_data_string("repack", opts->existing->repo,
+				   "include:fresh",
+				   step.u.write.items[step.u.write.nr - 1].string);
+	}
+	for (i = 0; i < opts->geometry->split; i++) {
+		struct packed_git *p = opts->geometry->pack[i];
+		if (unsigned_add_overflows(step.objects_nr, p->num_objects)) {
+			ret = error(_("too many objects in MIDX compaction step"));
+			goto out;
+		}
+
+		step.objects_nr += p->num_objects;
+	}
+	trace2_data_intmax("repack", opts->existing->repo,
+			   "include:fresh:objects_nr",
+			   (uintmax_t)step.objects_nr);
+
+	/*
+	 * Now handle any existing packs which were *not* rewritten.
+	 *
+	 * The list of packs in opts->geometry only contains MIDX'd
+	 * packs from the newest layer when that layer has more than
+	 * 'repack.midxNewLayerThreshold' number of packs.
+	 *
+	 * If the MIDX tip was rewritten (that is, one or more of those
+	 * packs appear below the split line), then add all packs above
+	 * the split line to the new layer, as the old one is no longer
+	 * usable.
+	 *
+	 * If the MIDX tip was not rewritten (that is, all MIDX'd packs
+	 * from the youngest layer appear below the split line, or were
+	 * not included in the geometric repack at all because there
+	 * were too few of them), ignore them since we'll retain the
+	 * existing layer as-is.
+	 */
+	for (i = opts->geometry->split; i < opts->geometry->pack_nr; i++) {
+		struct packed_git *p = opts->geometry->pack[i];
+		struct string_list_item *item;
+
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, pack_basename(p));
+		strbuf_strip_suffix(&buf, ".pack");
+		strbuf_addstr(&buf, ".idx");
+
+		if (p->multi_pack_index &&
+		    !opts->geometry->midx_tip_rewritten) {
+			trace2_data_string("repack", opts->existing->repo,
+					   "exclude:unmodified", buf.buf);
+			continue;
+		}
+
+		trace2_data_string("repack", opts->existing->repo,
+				   "include:unmodified", buf.buf);
+		trace2_data_string("repack", opts->existing->repo,
+				   "include:unmodified:midx",
+				   p->multi_pack_index ? "true" : "false");
+
+		item = string_list_append(&step.u.write, buf.buf);
+		if (p->multi_pack_index || i == opts->geometry->pack_nr - 1)
+			item->util = (void *)1; /* mark as preferred */
+
+		if (unsigned_add_overflows(step.objects_nr, p->num_objects)) {
+			ret = error(_("too many objects in MIDX compaction step"));
+			goto out;
+		}
+
+		step.objects_nr += p->num_objects;
+	}
+	trace2_data_intmax("repack", opts->existing->repo,
+			   "include:unmodified:objects_nr",
+			   (uintmax_t)step.objects_nr);
+
+	/*
+	 * If the MIDX tip was rewritten, then we no longer consider it
+	 * a candidate for compaction, since it will not exist in the
+	 * MIDX chain being built.
+	 */
+	if (opts->geometry->midx_tip_rewritten)
+		m = m->base_midx;
+
+	trace2_data_string("repack", opts->existing->repo, "midx:rewrote-tip",
+			   opts->geometry->midx_tip_rewritten ? "true" : "false");
+
+	trace2_region_enter("repack", "compact", opts->existing->repo);
+
+	/*
+	 * Compact additional MIDX layers into this proposed one until
+	 * the merging condition is violated.
+	 */
+	while (m) {
+		uint32_t preferred_pack_idx;
+
+		trace2_data_string("repack", opts->existing->repo,
+				   "candidate", midx_get_checksum_hex(m));
+
+		if (step.objects_nr < m->num_objects / opts->midx_split_factor) {
+			/*
+			 * Stop compacting MIDX layer as soon as the
+			 * merged size is less than half the size of the
+			 * next layer in the chain.
+			 */
+			trace2_data_string("repack", opts->existing->repo,
+					   "compact", "violated");
+			trace2_data_intmax("repack", opts->existing->repo,
+					   "objects_nr",
+					   (uintmax_t)step.objects_nr);
+			trace2_data_intmax("repack", opts->existing->repo,
+					   "next_objects_nr",
+					   (uintmax_t)m->num_objects);
+			trace2_data_intmax("repack", opts->existing->repo,
+					   "split_factor",
+					   (uintmax_t)opts->midx_split_factor);
+
+			break;
+		}
+
+		if (midx_preferred_pack(m, &preferred_pack_idx) < 0) {
+			ret = error(_("could not find preferred pack for MIDX "
+				      "%s"), midx_get_checksum_hex(m));
+			goto out;
+		}
+
+		for (i = 0; i < m->num_packs; i++) {
+			struct string_list_item *item;
+			uint32_t pack_int_id = i + m->num_packs_in_base;
+			struct packed_git *p = nth_midxed_pack(m, pack_int_id);
+
+			strbuf_reset(&buf);
+			strbuf_addstr(&buf, pack_basename(p));
+			strbuf_strip_suffix(&buf, ".pack");
+			strbuf_addstr(&buf, ".idx");
+
+			trace2_data_string("repack", opts->existing->repo,
+					   "midx:pack", buf.buf);
+
+			item = string_list_append(&step.u.write, buf.buf);
+			if (pack_int_id == preferred_pack_idx)
+				item->util = (void *)1; /* mark as preferred */
+		}
+
+		if (unsigned_add_overflows(step.objects_nr, m->num_objects)) {
+			ret = error(_("too many objects in MIDX compaction step"));
+			goto out;
+		}
+		step.objects_nr += m->num_objects;
+
+		m = m->base_midx;
+	}
+
+	if (step.u.write.nr > 0) {
+		/*
+		 * As long as there is at least one new pack to write
+		 * (and thus the MIDX is non-empty), add it to the plan.
+		 */
+		ALLOC_GROW(steps, steps_nr + 1, steps_alloc);
+		steps[steps_nr++] = step;
+	}
+
+	trace2_data_intmax("repack", opts->existing->repo,
+			   "step:objects_nr", (uintmax_t)step.objects_nr);
+	trace2_data_intmax("repack", opts->existing->repo,
+			   "step:packs_nr", (uintmax_t)step.u.write.nr);
+
+	trace2_region_leave("repack", "compact", opts->existing->repo);
+	trace2_region_leave("repack", "steps:write", opts->existing->repo);
+
+	trace2_region_enter("repack", "steps:rest", opts->existing->repo);
+
+	/*
+	 * Then start over, repeat, and either compact or keep as-is
+	 * each MIDX layer until we have exhausted the chain.
+	 *
+	 * Finally, evaluate the remainder of the chain (if any) and
+	 * either compact a sequence of adjacent layers, or keep
+	 * individual layers as-is according to the same merging
+	 * condition as above.
+	 */
+	while (m) {
+		struct multi_pack_index *next = m;
+
+		ALLOC_GROW(steps, steps_nr + 1, steps_alloc);
+
+		memset(&step, 0, sizeof(step));
+		step.type = MIDX_COMPACTION_STEP_UNKNOWN;
+
+		trace2_region_enter("repack", "step", opts->existing->repo);
+
+		trace2_data_string("repack", opts->existing->repo,
+				   "from", midx_get_checksum_hex(m));
+
+		while (next) {
+			uint32_t proposed_objects_nr;
+			if (unsigned_add_overflows(step.objects_nr, next->num_objects)) {
+				ret = error(_("too many objects in MIDX compaction step"));
+				trace2_region_leave("repack", "step", opts->existing->repo);
+				goto out;
+			}
+
+			proposed_objects_nr = step.objects_nr + next->num_objects;
+
+			trace2_data_string("repack", opts->existing->repo,
+					   "proposed",
+					   midx_get_checksum_hex(next));
+			trace2_data_intmax("repack", opts->existing->repo,
+					   "proposed:objects_nr",
+					   (uintmax_t)next->num_objects);
+
+			if (!next->base_midx) {
+				/*
+				 * If we are at the end of the MIDX
+				 * chain, there is nothing to compact,
+				 * so mark it and stop.
+				 */
+				step.objects_nr = proposed_objects_nr;
+				break;
+			}
+
+			if (proposed_objects_nr < next->base_midx->num_objects / opts->midx_split_factor) {
+				/*
+				 * If there is a MIDX following this
+				 * one, but our accumulated size is less
+				 * than half of its size, compacting
+				 * them would violate the merging
+				 * condition, so stop here.
+				 */
+
+				trace2_data_string("repack", opts->existing->repo,
+						   "compact:violated:at",
+						   midx_get_checksum_hex(next->base_midx));
+				trace2_data_intmax("repack", opts->existing->repo,
+						   "compact:violated:at:objects_nr",
+						   (uintmax_t)next->base_midx->num_objects);
+				break;
+			}
+
+			/*
+			 * Otherwise, it is OK to compact the next layer
+			 * into this one. Do so, and then continue
+			 * through the remainder of the chain.
+			 */
+			step.objects_nr = proposed_objects_nr;
+			trace2_data_intmax("repack", opts->existing->repo,
+					   "step:objects_nr",
+					   (uintmax_t)step.objects_nr);
+			next = next->base_midx;
+		}
+
+		if (m == next) {
+			step.type = MIDX_COMPACTION_STEP_COPY;
+			step.u.copy = m;
+
+			trace2_data_string("repack", opts->existing->repo,
+					   "type", "copy");
+		} else {
+			step.type = MIDX_COMPACTION_STEP_COMPACT;
+			step.u.compact.from = next;
+			step.u.compact.to = m;
+
+			trace2_data_string("repack", opts->existing->repo,
+					   "to", midx_get_checksum_hex(m));
+			trace2_data_string("repack", opts->existing->repo,
+					   "type", "compact");
+		}
+
+		m = next->base_midx;
+		steps[steps_nr++] = step;
+		trace2_region_leave("repack", "step", opts->existing->repo);
+	}
+
+	trace2_region_leave("repack", "steps:rest", opts->existing->repo);
+
+out:
+	*steps_p = steps;
+	*steps_nr_p = steps_nr;
+
+	strbuf_release(&buf);
+
+	trace2_region_leave("repack", "make_midx_compaction_plan",
+			    opts->existing->repo);
+
+	return ret;
+}
+
+static int write_midx_incremental(struct repack_write_midx_opts *opts)
+{
+	struct midx_compaction_step *steps = NULL;
+	struct strbuf lock_name = STRBUF_INIT;
+	struct lock_file lf;
+	size_t steps_nr = 0;
+	size_t i;
+	int ret = 0;
+
+	get_midx_chain_filename(opts->existing->source, &lock_name);
+	if (safe_create_leading_directories(opts->existing->repo,
+					    lock_name.buf))
+		die_errno(_("unable to create leading directories of %s"),
+			  lock_name.buf);
+	hold_lock_file_for_update(&lf, lock_name.buf, LOCK_DIE_ON_ERROR);
+
+	if (!fdopen_lock_file(&lf, "w")) {
+		ret = error_errno(_("unable to open multi-pack-index chain file"));
+		goto done;
+	}
+
+	if (repack_make_midx_compaction_plan(opts, &steps, &steps_nr) < 0) {
+		ret = error(_("unable to generate compaction plan"));
+		goto done;
+	}
+
+	for (i = 0; i < steps_nr; i++) {
+		struct midx_compaction_step *step = &steps[i];
+		char *base = NULL;
+
+		if (i + 1 < steps_nr)
+			base = xstrdup(midx_compaction_step_base(&steps[i + 1]));
+
+		if (midx_compaction_step_exec(step, opts, base) < 0) {
+			ret = error(_("unable to execute compaction step %"PRIuMAX),
+				    (uintmax_t)i);
+			free(base);
+			goto done;
+		}
+
+		free(base);
+	}
+
+	i = steps_nr;
+	while (i--) {
+		struct midx_compaction_step *step = &steps[i];
+		if (!step->csum)
+			BUG("missing result for compaction step %"PRIuMAX,
+			    (uintmax_t)i);
+		fprintf(get_lock_file_fp(&lf), "%s\n", step->csum);
+	}
+
+	commit_lock_file(&lf);
+
+done:
+	strbuf_release(&lock_name);
+	for (i = 0; i < steps_nr; i++)
+		midx_compaction_step_release(&steps[i]);
+	free(steps);
+	return ret;
+}
+
 int repack_write_midx(struct repack_write_midx_opts *opts)
 {
 	switch (opts->mode) {
@@ -386,6 +958,8 @@ int repack_write_midx(struct repack_write_midx_opts *opts)
 		BUG("write_midx mode is NONE?");
 	case REPACK_WRITE_MIDX_DEFAULT:
 		return write_midx_included_packs(opts);
+	case REPACK_WRITE_MIDX_INCREMENTAL:
+		return write_midx_incremental(opts);
 	default:
 		BUG("unhandled write_midx mode: %d", opts->mode);
 	}
diff --git a/repack.h b/repack.h
index 81907fcce7f..831ccfb1c6c 100644
--- a/repack.h
+++ b/repack.h
@@ -137,6 +137,7 @@ struct tempfile;
 enum repack_write_midx_mode {
 	REPACK_WRITE_MIDX_NONE,
 	REPACK_WRITE_MIDX_DEFAULT,
+	REPACK_WRITE_MIDX_INCREMENTAL,
 };
 
 struct repack_write_midx_opts {
@@ -148,6 +149,8 @@ struct repack_write_midx_opts {
 	int show_progress;
 	int write_bitmaps;
 	int midx_must_contain_cruft;
+	int midx_split_factor;
+	int midx_new_layer_threshold;
 	enum repack_write_midx_mode mode;
 };
 
-- 
2.53.0.729.g817728289e1.dirty

