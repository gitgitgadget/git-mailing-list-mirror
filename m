Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265FD3B71DF
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785606123; cv=none; b=p5ZCNgnthGdOw5GWf/UQITN+Iy58YLadpGeS3K+p1ejazQmfFekovKPrUlF3AgGTLixA6ijvGBubE7ooA0ZdfPAGyGJg1UnJhmPo8y5LSGDbiZ7AE5xGXk3u8/1eScUf7uf/bC/soKBsf+A6wDu9NzqqBZ4nNwVbdxqJeh1FMXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785606123; c=relaxed/simple;
	bh=xpoeQtg7HUZlEB2O7bRtTmck1D+VmXtrIRZhobaQDEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHqUYsu2YffOgXPWhKsIOTZnSpIla9a+cswRmxSAT4yxv/ipehRIJVxMfos2XsT8BkXA0E+wMpNIxi3CTc5N7liyimhfcl2G3EgN+OFEJxHEDBVEH6KIatBSEkpC8cs17s2bZM6ly2e+jL+BGG2ngeTz/YHWxqoheJYRYTaQc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBylCb0x; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBylCb0x"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1926168a91.0
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785606120; x=1786210920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FQ80F0XisSEXIcAJ2R4mU+qGpc9hqFRUX1e8iP+TQuA=;
        b=NBylCb0x1SicbEIrp62EdjKMsE7fl5eDrwUg82lMY1Y9jt/ZeEHCkgB0XUOc8Q/6zP
         YZagvBM9wRskrzdZURnKgBs2BSK44oFnaOHUgmr2d6Tp6xoqeuMoGj9lVFa6FYl0xkWr
         NPpfAqKFmoZhQkdOnSRyz5k1jXfLGG2Dx9JIrDMSxlK3BvNmVJnxKkEsUlWg5XyDAvUY
         4+z+ozOZGIJ3+VV41L3zxVhw4Un7duzp+mhucxvIjm+GczqG6O2lYSm5n++8nT2fg6Bs
         p/Xo0Af39D6mPpo1PLfYdWBJOuX16A79MF4UDSKp5mf09cejk77nPUslQ8mDDbvcdexl
         H57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785606120; x=1786210920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FQ80F0XisSEXIcAJ2R4mU+qGpc9hqFRUX1e8iP+TQuA=;
        b=Blq37fe+eJEtjiC7QpI8R/xCMId8u3xG7J73qqBdvBMihiSds86g+JA8GrqiaqCZ7f
         w0gidZpJDlVRUD27P6Z8eI3qBUF3SJQ9D+bj1y7McFmaJXbVs/0UO00iCVKnSf50kg+i
         lSAARHkPMpb+laoLRpGWwVMv3ddTcSbj1QronnuP6dbLadt3tK55CBa5xKJxRag/NTwp
         rgLqxMQ4FqGycEfJkPWqmhvx6hufbENmngLSibbJzUlHTBDdhG/C0U/aDapycQ60RDnY
         TBgzJH33DqtUuximhZYG/ay4lH+yHxPNm1+RFM3zyNihrPCzFlMRgcG9fgTQBN7DA21X
         hFfg==
X-Gm-Message-State: AOJu0YximVbHNZKAHrx8cGkw3XE/UPbSDuMmvY6SZJAjLum80EoLJhst
	c9UM/v58fjDF6AY3EJ9gyQ3j4Af0rR5UmtnDtJqFbNo9ck/9uoAZRmCrX16JxA==
X-Gm-Gg: AR+sD12sxAQf+SB170uInAdJYvOCm6Qy187WlSu+hEqEHYkfn5QrXuF0Lm2vZc5J/dH
	ok3Qp3fw4aEOUVk4/PEOOEK3pSqK4WRvWr99pKr66nbpOXdIGbL7qWsuJjCVw0/jgihCJB6jMrY
	vEI9/W8TbRrvBKSFB21lJWx29uMWVtSmjvh9gy41pu4PXHsZ/CPZR44Sak9c/ew8wJaUkZEPdwq
	8jaTAIkSbCA1rQ1ltqCEXDnwaWs3E/sBvlF2Y1Ixm1AqqvyWs3hIZ5yos41kz4M3vn2Eh2WvmOr
	dTfJBfDiiSb5dN88ja3bZfR1gG6FSHU6IDsI8Y4PCRHAoswacKxO+HSL3GC2iV3LbYqqS9g1fWv
	MN1XzxEswpnjza7MEuyzNnHt0W16aPofDGY2TY/SMX4fmTlnBSsXZBcH1VWsr9jAlSYRK369fkj
	IxVcGUn4mbhJNbRpTIGBzf0O7gw75srhtI6WHe0blWYz9J1e9ygYVsx0SYKQDBv9rc7CeaJ6qPJ
	beVWGT2V9XmYUDABPR6rEzM0KZdxgAhkWZ7BbG4P7pt0Dvwk5ykjE3QZIlfgibHC7P4vm9GLAzX
	bsQBgr8poiUquCQMwwdYaGbo/Xk5TIouyT7bQZzcwcwo5g==
X-Received: by 2002:a05:6a21:e0a7:b0:3c8:ead5:bf7b with SMTP id adf61e73a8af0-3c92a5a154cmr4458268637.4.1785606120188;
        Sat, 01 Aug 2026 10:42:00 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4f197sm19869502eec.6.2026.08.01.10.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:41:59 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC PATCH v7 02/10] diff: introduce a hunk provider interface
Date: Sat,  1 Aug 2026 10:41:45 -0700
Message-ID: <20260801174156.2998808-3-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260801174156.2998808-1-mmontalbo@gmail.com>
References: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
 <20260801174156.2998808-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To learn which line ranges changed between two blobs, every consumer in
the diff machinery loads both blobs and runs xdiff.  There is no other
way to supply that answer, even when it is known elsewhere: a cache may
hold the ranges from the last time the pair was diffed, and a
format-aware process may have its own idea of which lines changed.
Either could answer from the blob object ids alone, but the loading and
computing are hard-wired into each consumer, so such an answer has no
place to enter.

Introduce the hunk provider interface, diff-provider.h, between asking
the question and computing the answer.  A provider answers a request
made of the pair's identity, its blob object ids and the parameters
that determine the diff.  A provider is either authoritative, so its
answer may deliberately differ from the builtin diff, or not, so its
answer must reproduce the builtin result exactly.  Every answer served
from identity passes diff_provider_check_hunk() before a consumer sees
it: coordinates fit int32, hunks are ordered and non-overlapping, and
the unchanged runs between them match on both sides.  A failing answer
is discarded and the pair falls through as unanswered.

Providers are repository-lifecycle objects.  Each repository owns a
chain of them, built on first consultation and released from
repo_clear(), so a submodule gets its own providers and no provider
state outlives the repository it serves.  The chain has a fixed
composition, and each provider gates itself per request, passing when
it does not apply.  Chain order is the authority: the first answer
wins.  A provider may instead refuse a pair whose request is shaped by
parameters its recording key cannot express.  After a refusal, no later
provider answers the pair from identity, and the consumer must not
record what it computes for it.  The last provider is the builtin
computation, the only one that computes rather than answering from
identity, so a walk given a fill callback always ends in an answer,
refusal or not.

The walk in diff-provider.c maps a provider's four dispositions
(answer, pass, fail, refuse) onto the consumer-facing outcomes, and
checks with BUG() that only the computing provider fails and that it
passes on a walk with no fill callback.  The implementor contract, the
provider struct, its dispositions, and the shared check, lives in
diff-provider-internal.h, as refs/refs-internal.h is to refs.h;
consumers see only diff-provider.h.

The consumer surface is two types.  struct diff_provider_request names
what is diffed and under which parameters; each later commit that
consults on more state adds the field it keys on (the object ids and
diff options, then the path).  enum diff_provider_outcome flattens two
dependent axes into four points: the response state (answered,
unanswered, failed) and, only when unanswered, whether the caller may
record what it computes.  The record rule rides in the outcome, not a
separate flag, so -Wswitch forces every consumer to place the no-record
arm.  A provider added later maps onto these values inside the walk, so
consumer code is written once.

diff_provider_emit_hunks() is the consumer entry: the caller states the
request, a hunk callback, and a content-loading callback that reaches
the terminal provider only when the ranges are computed.  Blame's
pass_blame_to_parent() is the first consumer, since it knows both blob
ids before reading either blob; its loads move into the fill callback.
With only the terminal provider registered, every request still
computes, so behavior is unchanged.  (Blame's -C/-M split detection
diffs partial buffers with no blob identity and stays on xdi_diff().)

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Makefile                 |   1 +
 blame.c                  |  36 +++++++--
 diff-provider-internal.h | 122 +++++++++++++++++++++++++++++++
 diff-provider.c          | 154 +++++++++++++++++++++++++++++++++++++++
 diff-provider.h          | 130 +++++++++++++++++++++++++++++++++
 meson.build              |   1 +
 repository.c             |   3 +
 repository.h             |   8 ++
 8 files changed, 447 insertions(+), 8 deletions(-)
 create mode 100644 diff-provider-internal.h
 create mode 100644 diff-provider.c
 create mode 100644 diff-provider.h

diff --git a/Makefile b/Makefile
index 98e995e4be..50c96807d6 100644
--- a/Makefile
+++ b/Makefile
@@ -1151,6 +1151,7 @@ LIB_OBJS += diff-delta.o
 LIB_OBJS += diff-merges.o
 LIB_OBJS += diff-lib.o
 LIB_OBJS += diff-no-index.o
+LIB_OBJS += diff-provider.o
 LIB_OBJS += diff.o
 LIB_OBJS += diffcore-break.o
 LIB_OBJS += diffcore-delta.o
diff --git a/blame.c b/blame.c
index 126e232416..c3ef9c17f7 100644
--- a/blame.c
+++ b/blame.c
@@ -23,6 +23,7 @@
 #include "commit-slab.h"
 #include "bloom.h"
 #include "commit-graph.h"
+#include "diff-provider.h"
 
 define_commit_slab(blame_suspects, struct blame_origin *);
 static struct blame_suspects blame_suspects;
@@ -1936,6 +1937,28 @@ static int blame_chunk_cb(long start_a, long count_a,
 	return 0;
 }
 
+struct blame_diff_fill_data {
+	struct blame_scoreboard *sb;
+	struct blame_origin *parent, *target;
+	int ignore_diffs;
+};
+
+/*
+ * Content load for diff_provider_emit_hunks(): runs when the diff is
+ * computed.
+ */
+static int blame_diff_fill(void *data, mmfile_t *old_file, mmfile_t *new_file)
+{
+	struct blame_diff_fill_data *f = data;
+
+	fill_origin_blob(&f->sb->revs->diffopt, f->parent, old_file,
+			 &f->sb->num_read_blob, f->ignore_diffs);
+	fill_origin_blob(&f->sb->revs->diffopt, f->target, new_file,
+			 &f->sb->num_read_blob, f->ignore_diffs);
+	f->sb->num_get_patch++;
+	return 0;
+}
+
 /*
  * We are looking at the origin 'target' and aiming to pass blame
  * for the lines it is suspected to its parent.  Run diff to find
@@ -1945,9 +1968,11 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 				 struct blame_origin *target,
 				 struct blame_origin *parent, int ignore_diffs)
 {
-	mmfile_t file_p, file_o;
 	struct blame_chunk_cb_data d;
 	struct blame_entry *newdest = NULL;
+	struct blame_diff_fill_data fill_data = { sb, parent, target, ignore_diffs };
+	xpparam_t xpp = { .flags = sb->xdl_opts };
+	struct diff_provider_request req = { .repo = sb->repo, .xpp = &xpp };
 
 	if (!target->suspects)
 		return; /* nothing remains for this target */
@@ -1958,13 +1983,8 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 	d.ignore_diffs = ignore_diffs;
 	d.dstq = &newdest; d.srcq = &target->suspects;
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p,
-			 &sb->num_read_blob, ignore_diffs);
-	fill_origin_blob(&sb->revs->diffopt, target, &file_o,
-			 &sb->num_read_blob, ignore_diffs);
-	sb->num_get_patch++;
-
-	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
+	if (diff_provider_emit_hunks(&req, blame_diff_fill, &fill_data,
+				     blame_chunk_cb, &d) == DIFF_PROVIDER_ERROR)
 		die("unable to generate diff (%s -> %s)",
 		    oid_to_hex(&parent->commit->object.oid),
 		    oid_to_hex(&target->commit->object.oid));
diff --git a/diff-provider-internal.h b/diff-provider-internal.h
new file mode 100644
index 0000000000..8dd8e4b0dc
--- /dev/null
+++ b/diff-provider-internal.h
@@ -0,0 +1,122 @@
+#ifndef DIFF_PROVIDER_INTERNAL_H
+#define DIFF_PROVIDER_INTERNAL_H
+
+#include "diff-provider.h"
+
+/*
+ * The implementor-facing half of the hunk provider interface: the
+ * provider chain a repository owns, and the rules a provider applies
+ * to its own answer before any consumer sees it.  Provider
+ * implementations include this header; consumers of the interface
+ * use only diff-provider.h.
+ */
+
+/*
+ * A provider's verdict on one request.  Only the chain walk
+ * (diff-provider.c) sees these; it maps the dispositions of a whole
+ * walk onto the public outcome set.
+ */
+enum diff_provider_disposition {
+	/*
+	 * The provider failed to produce the answer it owns.  Only
+	 * the computing provider returns this: its compute leg is
+	 * the one part of a consultation that can fail, and the walk
+	 * ends with the public error outcome.
+	 */
+	DIFF_PROVIDER_DISP_ERROR = -1,
+
+	/*
+	 * Answered: every hunk of the pair has been emitted through
+	 * the consumer's callback.
+	 */
+	DIFF_PROVIDER_DISP_ANSWERED = 0,
+
+	/* Not this provider's request: the walk consults the next one. */
+	DIFF_PROVIDER_DISP_PASS,
+
+	/*
+	 * The pair must not be answered from identity nor recorded:
+	 * the request is shaped by parameters the provider's
+	 * recording key cannot express, so a recorded answer would
+	 * not match this request, and this request's result must not
+	 * be recorded under that key.  The walk goes on, but consults
+	 * only the computing provider, and its fall-through outcome
+	 * tells the consumer not to record.
+	 */
+	DIFF_PROVIDER_DISP_STOP_NO_RECORD,
+};
+
+/*
+ * One provider in a repository's chain (repository.h).  The chain is
+ * assembled in diff-provider.c with a fixed composition; whether a
+ * provider applies to a request is decided by nobody but the
+ * provider, whose consult gates itself and passes.  Chain position
+ * carries the authority resolution: an earlier provider's answer or
+ * refusal outranks every provider after it.
+ */
+struct diff_provider {
+	/*
+	 * Consult this provider for one request.  fill is NULL on a
+	 * consult-only walk; only the computing provider reads it,
+	 * and it must pass when fill is NULL.
+	 */
+	enum diff_provider_disposition
+		(*consult)(struct diff_provider *provider,
+			   const struct diff_provider_request *req,
+			   diff_provider_fill_fn fill, void *fill_data,
+			   xdl_emit_hunk_consume_func_t hunk_cb,
+			   void *cb_data);
+
+	/*
+	 * Tear down the provider's state, or NULL when it owns none.
+	 * Runs when the owning repository is cleared; the chain frees
+	 * the provider itself afterwards.
+	 */
+	void (*release)(struct diff_provider *provider);
+
+	void *state;
+
+	/*
+	 * Set on the provider that loads content and computes rather
+	 * than answering from the request's identity.  It alone is
+	 * still consulted after a stop-no-record: an identity answer
+	 * may no longer be served, but the computation must still
+	 * run.
+	 */
+	unsigned computes:1;
+
+	struct diff_provider *next;
+};
+
+/*
+ * Incremental well-formedness check for a provider-supplied hunk
+ * sequence, shared by every provider.  Each coordinate, and each
+ * hunk's end (its start plus count), must fit int32 (a consumer may
+ * truncate to int, and a provider may serialize as such); hunks must
+ * be in order and must not overlap; and the unchanged run between
+ * hunks must be the same length on both sides, or a consumer that
+ * walks the two files in lockstep desynchronizes.  Every rule
+ * constrains differences between coordinates, so the check applies
+ * to 0-based and 1-based sequences alike.
+ *
+ * Feed the hunks in order to a zero-initialized struct; the first
+ * nonzero return names the violated rule, and the whole sequence must
+ * then be discarded unemitted.
+ */
+struct diff_provider_hunks_check {
+	int64_t prev_old_end, prev_new_end;
+};
+
+enum diff_provider_hunks_error {
+	DIFF_PROVIDER_HUNKS_OK = 0,
+	DIFF_PROVIDER_HUNKS_RANGE,      /* negative or beyond int32 */
+	DIFF_PROVIDER_HUNKS_OVERLAP,    /* out of order or overlapping */
+	DIFF_PROVIDER_HUNKS_MISALIGNED, /* unchanged runs differ in length */
+};
+
+enum diff_provider_hunks_error
+diff_provider_check_hunk(struct diff_provider_hunks_check *c,
+			  long old_start, long old_count,
+			  long new_start, long new_count);
+
+#endif /* DIFF_PROVIDER_INTERNAL_H */
diff --git a/diff-provider.c b/diff-provider.c
new file mode 100644
index 0000000000..b69854fb63
--- /dev/null
+++ b/diff-provider.c
@@ -0,0 +1,154 @@
+#include "git-compat-util.h"
+#include "diff-provider-internal.h"
+#include "repository.h"
+
+/*
+ * The terminal provider: the builtin computation.  A request that
+ * carries a fill callback is answered by loading the pair's content
+ * and running xdiff, so a walk that reaches it never falls through
+ * to the consumer.  On a consult-only walk it passes, and the walk's
+ * fall-through outcome tells the consumer to compute.
+ */
+static enum diff_provider_disposition
+builtin_consult(struct diff_provider *provider UNUSED,
+		const struct diff_provider_request *req,
+		diff_provider_fill_fn fill, void *fill_data,
+		xdl_emit_hunk_consume_func_t hunk_cb, void *cb_data)
+{
+	xdemitconf_t xecfg = { .hunk_func = hunk_cb };
+	xdemitcb_t ecb = { .priv = cb_data };
+	mmfile_t old_file, new_file;
+
+	if (!fill)
+		return DIFF_PROVIDER_DISP_PASS;
+	if (fill(fill_data, &old_file, &new_file) < 0)
+		return DIFF_PROVIDER_DISP_ERROR;
+	if (xdi_diff(&old_file, &new_file, req->xpp, &xecfg, &ecb) < 0)
+		return DIFF_PROVIDER_DISP_ERROR;
+	return DIFF_PROVIDER_DISP_ANSWERED;
+}
+
+static struct diff_provider *builtin_provider_new(void)
+{
+	struct diff_provider *p = xcalloc(1, sizeof(*p));
+
+	p->consult = builtin_consult;
+	p->computes = 1;
+	return p;
+}
+
+/*
+ * The repository's chain, assembled on first walk.  The composition
+ * is fixed; the builtin computation is the terminal provider, so the
+ * chain always ends in an implementor that can answer.  Nothing is
+ * decided per repository here; each provider gates itself per
+ * request.
+ */
+static struct diff_provider *provider_chain(struct repository *r)
+{
+	struct diff_provider **tail = &r->diff_providers;
+
+	if (*tail)
+		return *tail;
+	*tail = builtin_provider_new();
+	return r->diff_providers;
+}
+
+void diff_providers_clear(struct repository *r)
+{
+	struct diff_provider *p = r->diff_providers;
+
+	while (p) {
+		struct diff_provider *next = p->next;
+
+		if (p->release)
+			p->release(p);
+		free(p);
+		p = next;
+	}
+	r->diff_providers = NULL;
+}
+
+/*
+ * The walk behind diff_provider_emit_hunks(): consult the chain in
+ * order and map its dispositions onto the outcome set.  The first
+ * answer ends the walk.  A stop-no-record disposition
+ * (diff-provider-internal.h) is a refusal, not a pass: the provider
+ * does not answer, but rules the pair out of identity service and
+ * out of recording, so from then on the walk consults only the
+ * computing provider, and a walk that ends unanswered carries the
+ * no-record verdict.  With a fill callback the terminal provider
+ * computes instead of passing, so an emit walk returns only
+ * answered or error.
+ */
+static enum diff_provider_outcome
+walk_providers(const struct diff_provider_request *req,
+	       diff_provider_fill_fn fill, void *fill_data,
+	       xdl_emit_hunk_consume_func_t hunk_cb, void *cb_data)
+{
+	struct diff_provider *p;
+	int no_record = 0;
+
+	for (p = provider_chain(req->repo); p; p = p->next) {
+		enum diff_provider_disposition disp;
+
+		if (no_record && !p->computes)
+			continue;
+		disp = p->consult(p, req, fill, fill_data,
+				  hunk_cb, cb_data);
+		if (disp == DIFF_PROVIDER_DISP_ERROR && !p->computes)
+			BUG("only the computing provider may return the "
+			    "error disposition");
+		if (p->computes && !fill && disp != DIFF_PROVIDER_DISP_PASS)
+			BUG("the computing provider must pass on a "
+			    "fill-less walk");
+		switch (disp) {
+		case DIFF_PROVIDER_DISP_ANSWERED:
+			return DIFF_PROVIDER_ANSWERED;
+		case DIFF_PROVIDER_DISP_PASS:
+			continue;
+		case DIFF_PROVIDER_DISP_STOP_NO_RECORD:
+			no_record = 1;
+			continue;
+		case DIFF_PROVIDER_DISP_ERROR:
+			return DIFF_PROVIDER_ERROR;
+		}
+	}
+	return no_record ? DIFF_PROVIDER_UNANSWERED_NO_RECORD :
+		DIFF_PROVIDER_UNANSWERED;
+}
+
+enum diff_provider_hunks_error
+diff_provider_check_hunk(struct diff_provider_hunks_check *c,
+			  long old_start, long old_count,
+			  long new_start, long new_count)
+{
+	if (old_start < 0 || old_count < 0 ||
+	    new_start < 0 || new_count < 0 ||
+	    old_start > INT32_MAX || old_count > INT32_MAX ||
+	    new_start > INT32_MAX || new_count > INT32_MAX ||
+	    (int64_t)old_start + old_count > INT32_MAX ||
+	    (int64_t)new_start + new_count > INT32_MAX)
+		return DIFF_PROVIDER_HUNKS_RANGE;
+	if (old_start < c->prev_old_end || new_start < c->prev_new_end)
+		return DIFF_PROVIDER_HUNKS_OVERLAP;
+	if (old_start - c->prev_old_end != new_start - c->prev_new_end)
+		return DIFF_PROVIDER_HUNKS_MISALIGNED;
+	/*
+	 * With each field bounded to int32 above, the int64 sums cannot
+	 * overflow even where long is 32-bit, and the range rule has
+	 * already capped them at INT32_MAX.
+	 */
+	c->prev_old_end = (int64_t)old_start + old_count;
+	c->prev_new_end = (int64_t)new_start + new_count;
+	return DIFF_PROVIDER_HUNKS_OK;
+}
+
+enum diff_provider_outcome
+diff_provider_emit_hunks(const struct diff_provider_request *req,
+			 diff_provider_fill_fn fill, void *fill_data,
+			 xdl_emit_hunk_consume_func_t hunk_cb,
+			 void *cb_data)
+{
+	return walk_providers(req, fill, fill_data, hunk_cb, cb_data);
+}
diff --git a/diff-provider.h b/diff-provider.h
new file mode 100644
index 0000000000..1a7e4e299c
--- /dev/null
+++ b/diff-provider.h
@@ -0,0 +1,130 @@
+#ifndef DIFF_PROVIDER_H
+#define DIFF_PROVIDER_H
+
+#include "xdiff-interface.h"
+
+/*
+ * The hunk provider interface sits between naming a pair of file
+ * versions to diff and computing their changed line ranges.
+ * Consumers that operate on hunk coordinates route their diff
+ * through here, so that a provider can answer for the pair before
+ * its content is loaded.
+ *
+ * A hunk provider answers a consumer's request from the pair's
+ * identity (its blob object ids) and the parameters that determine
+ * the diff; a request no provider answers falls through to the
+ * consumer's own computation.  A provider is either authoritative for
+ * its requests, meaning its answer may deliberately differ from the
+ * builtin diff, or not, meaning its answer must reproduce the builtin
+ * result exactly.  The interface resolves that authority through a
+ * provider chain owned by the repository, built on first consultation
+ * and released by repo_clear(): chain order is the resolution, and
+ * the builtin computation itself is the chain's terminal provider.  A
+ * consumer never names a provider; it reads the outcome below.
+ * Every answer a provider serves from identity passes the shared
+ * coordinate check (diff-provider-internal.h) before any consumer
+ * sees it.
+ */
+
+struct repository;
+
+/*
+ * The result of a consultation: two dependent axes flattened into
+ * their four valid points.  The first axis is the state of the
+ * response: the pair was answered, no provider answered, or (from
+ * diff_provider_emit_hunks() alone) the attempt failed.  The second
+ * axis exists only in the unanswered state: whether what the caller
+ * computes for this request may be recorded, the one rule the
+ * interface imposes on an otherwise free caller.  The rule travels
+ * in the outcome because the knowledge is a provider's while the
+ * recording is the caller's, and it shares the enum with the state,
+ * rather than riding a separate flag, so that no meaningless
+ * combination is representable and -Wswitch forces every consumer
+ * that switches to place the no-record arm.
+ *
+ * These values describe consultations, not providers: the set does
+ * not grow when a provider is added; a new provider maps onto these
+ * values inside the interface, so consumer code is written once.
+ * Each entry point returns a subrange of the set (stated at its
+ * declaration); a switch over this enum should list every value and
+ * omit "default:" so -Wswitch keeps it exhaustive, and a caller for
+ * whom only one value is actionable may compare against that value
+ * alone.
+ */
+enum diff_provider_outcome {
+	/*
+	 * Loading or diffing the pair failed.  Returned only by
+	 * diff_provider_emit_hunks(), whose compute leg is the only
+	 * part of a consultation that can fail.
+	 */
+	DIFF_PROVIDER_ERROR = -1,
+
+	/*
+	 * The request is answered: every hunk of the pair has been
+	 * emitted through the callback.  An authoritative provider
+	 * that finds the pair equivalent answers with no hunks at
+	 * all, so a callback that never fired is an answer, not an
+	 * accident.
+	 */
+	DIFF_PROVIDER_ANSWERED = 0,
+
+	/*
+	 * No provider answered.  What happens next is the caller's
+	 * business, typically computing the diff itself; a result it
+	 * computes for this request may be recorded.
+	 */
+	DIFF_PROVIDER_UNANSWERED,
+
+	/*
+	 * No provider answered, and what the caller computes for
+	 * this request must not be recorded: either an authoritative
+	 * provider owns the pair and declined this request, or the
+	 * request is shaped by parameters outside the recording key,
+	 * the key a recorded result is later served by.
+	 */
+	DIFF_PROVIDER_UNANSWERED_NO_RECORD,
+};
+
+/*
+ * A consultation request.  The interface consults providers from
+ * these fields alone; no content is loaded before an answer.
+ *
+ * repo owns the provider chain the request walks.  xpp carries the
+ * parameters the diff runs with.  Each provider gates itself on the
+ * fields that concern it.
+ */
+struct diff_provider_request {
+	struct repository *repo;
+	const xpparam_t *xpp;
+};
+
+/*
+ * Load the pair's content.  Called at most once per request, only
+ * when the ranges are computed rather than provided.  The buffers
+ * borrow storage owned by the callback's owner.
+ */
+typedef int (*diff_provider_fill_fn)(void *data, mmfile_t *old_file,
+				     mmfile_t *new_file);
+
+/*
+ * Consult the providers and, when no identity answer serves the
+ * request, load the pair's content through fill and compute its
+ * exact changed ranges (context 0).  Emits to hunk_cb either way and
+ * returns DIFF_PROVIDER_ANSWERED, or DIFF_PROVIDER_ERROR when fill
+ * or the diff fails.  The unanswered outcomes are never returned: a
+ * pair no provider answers is computed here instead of in the caller.
+ */
+enum diff_provider_outcome
+diff_provider_emit_hunks(const struct diff_provider_request *req,
+			 diff_provider_fill_fn fill, void *fill_data,
+			 xdl_emit_hunk_consume_func_t hunk_cb,
+			 void *cb_data);
+
+/*
+ * Release the repository's provider chain: stop any provider-owned
+ * processes and free the providers.  Called by repo_clear(); the
+ * chain builds again on the next consultation.
+ */
+void diff_providers_clear(struct repository *r);
+
+#endif /* DIFF_PROVIDER_H */
diff --git a/meson.build b/meson.build
index f7c40ea079..539a50f90e 100644
--- a/meson.build
+++ b/meson.build
@@ -356,6 +356,7 @@ libgit_sources = [
   'diff-merges.c',
   'diff-lib.c',
   'diff-no-index.c',
+  'diff-provider.c',
   'diff.c',
   'diffcore-break.c',
   'diffcore-delta.c',
diff --git a/repository.c b/repository.c
index 2ef0778846..c9418f0ae1 100644
--- a/repository.c
+++ b/repository.c
@@ -5,6 +5,7 @@
 #include "odb.h"
 #include "odb/source.h"
 #include "config.h"
+#include "diff-provider.h"
 #include "gettext.h"
 #include "object.h"
 #include "lockfile.h"
@@ -383,6 +384,8 @@ void repo_clear(struct repository *repo)
 	FREE_AND_NULL(repo->submodule_prefix);
 	FREE_AND_NULL(repo->ref_storage_payload);
 
+	diff_providers_clear(repo);
+
 	odb_free(repo->objects);
 	repo->objects = NULL;
 
diff --git a/repository.h b/repository.h
index b767307911..8b4747fb2c 100644
--- a/repository.h
+++ b/repository.h
@@ -7,6 +7,7 @@
 #include "environment.h"
 
 struct config_set;
+struct diff_provider;
 struct git_hash_algo;
 struct index_state;
 struct lock_file;
@@ -161,6 +162,13 @@ struct repository {
 	/* Repository's remotes and associated structures. */
 	struct remote_state *remote_state;
 
+	/*
+	 * The repository's diff hunk provider chain, NULL until the
+	 * first consultation builds it (diff-provider.c); repo_clear()
+	 * releases it.
+	 */
+	struct diff_provider *diff_providers;
+
 	/* Repository's current hash algorithm, as serialized on disk. */
 	const struct git_hash_algo *hash_algo;
 
-- 
2.54.0

