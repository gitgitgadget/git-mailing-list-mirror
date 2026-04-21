Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7CB3446C7
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803872; cv=none; b=QpGsNCi1e6FcgEgH21n8NW6Hba2u8art4w8y5OAt1oyTtnad/a7kw9hFAjrX8k45D2Rr2Oh3yhYlBJ8P5+YDTM9AjZmB5t8J8TD0X7JFxePaKb4r2zPL6H4mQBytO79fywQMZulEupcTx7cuIlwZVaMnwamz3Xki7QMCsJ/UsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803872; c=relaxed/simple;
	bh=OHBlV7ucCYjGVDDYy31+/lDtuZsmrMdJX7GnwxK3ggA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdr+73zC91Wh2EYp8IAoz+EVYoQwxmma9M38XIcxR9MNrOayo00MezEiJZ8Xt62qIe8HNyH5VZyg/fizThQE0ZCvEiiHqsJx4oFrOCEHPaYvHqzKSBpHzqoc7liAdtMrcbSqkY6/0r1g/SV1rBIE8llfWQ9CaXjKVMDZ6+zGGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=BwP5NJzf; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="BwP5NJzf"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dbb89ab229so4396849a34.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776803870; x=1777408670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AbviEV89enaVTTPPgtRprLRXYhDKkuMLxvVaV1g8+iw=;
        b=BwP5NJzfLDKKJqQSTD5hBZTDtlWFUPYlVKSWEgsxkYq3wpbwL4yxzCNkXMD7J8ewGU
         1KWoo5N2YcfG2i738y7H3Jf3uMcG0s2PTp1xklEF/0VkIXH61v1NxJwV+LjL5vnoo7rI
         H9n6KGxfmIDL+J6IqukDTqDiC2LdouVWZSAsQ6a1gyx/2WERf7Vsx5FZx5IC6VrPlMvD
         byn2EBJkt5tiAgOt0JWm+F6OuOeMpBw2o4ujj8P9EiBpXuPb2ENnePr4XYqpCsB8Cwri
         1Dx3GH9oGVfMgoNIJo7Kf85qrDYo8X2dbSHbsNolCK/+Y99g1ghFzo/peTKktXCUrpFE
         KgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803870; x=1777408670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbviEV89enaVTTPPgtRprLRXYhDKkuMLxvVaV1g8+iw=;
        b=rG4L/yxaZt1Mqr6kU8EVB5HNb0x85Sy1rOMCwUZv3f1RqFNEAGjSrtxMhOVUTh73Zi
         TxntakpX+BEmxSorwPVf7KRr0PN6m3bUHbGqNEuVGrcGnBHGw9eFI/XvgHnX3JDydpGp
         g0Zz7jiHCkUljpVHljhiuzwPTpALi13GcwY+mLGk/C9nwqwOyq7BimF0iCkgGXwDwmEQ
         qGBEV3ljuC8ykU4KSP26Uk39Wrqq8sm4I8R3M/69rSH+ieCMDkRlB0pAG4uXWVpzUUHF
         gfMGjDezT+9x3YghmmdLkMJG9vB2QiFWqLFqSGQw4y7IvCnAT+CB91Ma+dFlZK8j3UJ5
         PO+w==
X-Gm-Message-State: AOJu0YyQzWqaA77mNb9z0PepEWAvsBp03LT9s+GniYxqBCXgfme/jIpp
	Q9Cb0wlryp5cqlPdtd13JL8HFYEX1rR/ajgL/NtmJ44aiptrP8BMqmUhor9yMT3MQCr6E2azGpt
	ZXucKruI=
X-Gm-Gg: AeBDievJjDb8Z1TU5W44b2UyKOd7mhocvN9iCYavJ04J27hXSPb9/0SSlgo+to2FWEe
	zVs1dpw1zGwT6wh0iTdF6X81++hGA8qKrW6wiNtCM8FxSmCprTV260tnIxXoc5IWvE6E2w5xOol
	XQNDhJRJ9vs9j10QcXk7q17rm/e4yDdBMf2Ly66/E0c5bDyhe7h3ZRnouQxtxKcY2IaUJtLafch
	+jLQgvSxqV+uOgIL/dz1E0mxTRVMgo8psnmyK3oTjuk3QMZ7ak5h8EfSwiM6yEuW3ASp3NAp9k5
	d3D68ZH8hPAEEclQF1LSUKf1IYn9DILRdUjk1MwHIPpzKWb7OHtjQw7LTf7GrebMdfRCf71TxHL
	g9jbENakJPoHQSgUhtvk/6gtesCHfvVOywd2lA91guK4/3KQl1VK8nK4ck2oeWqeVQtUbB3KiS0
	Ef2ZhIWtS5FdPEnnpwsFvrOz8b2X91y847VOesT3mJ7gF5HHQhx7kNNzq/iE5l6Hgy9Dvp0LnNV
	nVXrSYjnqUIeE6U0SOa2v7vXiYWjlaRw2/ro3u01Yf+vuGnYoS7j0q/bsk4EKmCnv0fCfy9ekuP
	bUvVo2tfMbWJK9pc5TWFe3dobwk=
X-Received: by 2002:a05:6830:6583:b0:7dc:dd58:50b1 with SMTP id 46e09a7af769-7dcdd587dd0mr1671693a34.25.1776803869887;
        Tue, 21 Apr 2026 13:37:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcce5feb25sm4317951a34.26.2026.04.21.13.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:37:49 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:37:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 12/16] builtin/repack.c: convert `--write-midx` to an
 `OPT_CALLBACK`
Message-ID: <9fdcb253a9631adb467593fc1d59c594c1a350b9.1776803827.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776803827.git.me@ttaylorr.com>

Change the --write-midx (-m) flag from an OPT_BOOL to an OPT_CALLBACK
that accepts an optional mode argument. Introduce an enum with
REPACK_WRITE_MIDX_NONE and REPACK_WRITE_MIDX_DEFAULT to distinguish
between the two states, and update all existing boolean checks
accordingly.

For now, passing no argument (or just `-m`) selects the default mode,
preserving existing behavior. A subsequent commit will add a new mode
for writing incremental MIDXs.

Extract repack_write_midx() as a dispatcher that selects the
appropriate MIDX-writing implementation based on the mode.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 50 ++++++++++++++++++++++++++++++++++++------------
 repack-midx.c    | 14 +++++++++++++-
 repack.h         |  8 +++++++-
 3 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 24be147d39a..5d366340c34 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -97,6 +97,24 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
+static int option_parse_write_midx(const struct option *opt, const char *arg,
+				   int unset)
+{
+	enum repack_write_midx_mode *cfg = opt->value;
+
+	if (unset) {
+		*cfg = REPACK_WRITE_MIDX_NONE;
+		return 0;
+	}
+
+	if (!arg || !*arg)
+		*cfg = REPACK_WRITE_MIDX_DEFAULT;
+	else
+		return error(_("unknown value for %s: %s"), opt->long_name, arg);
+
+	return 0;
+}
+
 int cmd_repack(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -119,7 +137,7 @@ int cmd_repack(int argc,
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct pack_objects_args po_args = PACK_OBJECTS_ARGS_INIT;
 	struct pack_objects_args cruft_po_args = PACK_OBJECTS_ARGS_INIT;
-	int write_midx = 0;
+	enum repack_write_midx_mode write_midx = REPACK_WRITE_MIDX_NONE;
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
 	const char *filter_to = NULL;
@@ -185,8 +203,14 @@ int cmd_repack(int argc,
 				N_("do not repack this pack")),
 		OPT_INTEGER('g', "geometric", &geometry.split_factor,
 			    N_("find a geometric progression with factor <N>")),
-		OPT_BOOL('m', "write-midx", &write_midx,
-			   N_("write a multi-pack index of the resulting packs")),
+		OPT_CALLBACK_F(0, "write-midx", &write_midx,
+			   N_("mode"),
+			   N_("write a multi-pack index of the resulting packs"),
+			   PARSE_OPT_OPTARG, option_parse_write_midx),
+		OPT_SET_INT_F('m', NULL, &write_midx,
+			   N_("write a multi-pack index of the resulting packs"),
+			   REPACK_WRITE_MIDX_DEFAULT,
+			   PARSE_OPT_HIDDEN),
 		OPT_STRING(0, "expire-to", &expire_to, N_("dir"),
 			   N_("pack prefix to store a pack containing pruned objects")),
 		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
@@ -221,14 +245,16 @@ int cmd_repack(int argc,
 		pack_everything |= ALL_INTO_ONE;
 
 	if (write_bitmaps < 0) {
-		if (!write_midx &&
+		if (write_midx == REPACK_WRITE_MIDX_NONE &&
 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
 			write_bitmaps = 0;
 	}
 	if (po_args.pack_kept_objects < 0)
-		po_args.pack_kept_objects = write_bitmaps > 0 && !write_midx;
+		po_args.pack_kept_objects = write_bitmaps > 0 &&
+			write_midx == REPACK_WRITE_MIDX_NONE;
 
-	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
+	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) &&
+	    write_midx == REPACK_WRITE_MIDX_NONE)
 		die(_(incremental_bitmap_conflict_error));
 
 	if (write_bitmaps && po_args.local &&
@@ -244,7 +270,7 @@ int cmd_repack(int argc,
 		write_bitmaps = 0;
 	}
 
-	if (write_midx && write_bitmaps) {
+	if (write_midx != REPACK_WRITE_MIDX_NONE && write_bitmaps) {
 		struct strbuf path = STRBUF_INIT;
 
 		strbuf_addf(&path, "%s/%s_XXXXXX",
@@ -297,7 +323,7 @@ int cmd_repack(int argc,
 	}
 	if (repo_has_promisor_remote(repo))
 		strvec_push(&cmd.args, "--exclude-promisor-objects");
-	if (!write_midx) {
+	if (write_midx == REPACK_WRITE_MIDX_NONE) {
 		if (write_bitmaps > 0)
 			strvec_push(&cmd.args, "--write-bitmap-index");
 		else if (write_bitmaps < 0)
@@ -519,7 +545,7 @@ int cmd_repack(int argc,
 	if (delete_redundant && pack_everything & ALL_INTO_ONE)
 		existing_packs_mark_for_deletion(&existing, &names);
 
-	if (write_midx) {
+	if (write_midx != REPACK_WRITE_MIDX_NONE) {
 		struct repack_write_midx_opts opts = {
 			.existing = &existing,
 			.geometry = &geometry,
@@ -528,11 +554,11 @@ int cmd_repack(int argc,
 			.packdir = packdir,
 			.show_progress = show_progress,
 			.write_bitmaps = write_bitmaps > 0,
-			.midx_must_contain_cruft = midx_must_contain_cruft
+			.midx_must_contain_cruft = midx_must_contain_cruft,
+			.mode = write_midx,
 		};
 
-		ret = write_midx_included_packs(&opts);
-
+		ret = repack_write_midx(&opts);
 		if (ret)
 			goto cleanup;
 	}
diff --git a/repack-midx.c b/repack-midx.c
index 78f069c2151..4a568a2a9b8 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -315,7 +315,7 @@ static int repack_fill_midx_stdin_packs(struct child_process *cmd,
 	return finish_command(cmd);
 }
 
-int write_midx_included_packs(struct repack_write_midx_opts *opts)
+static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list include = STRING_LIST_INIT_DUP;
@@ -378,3 +378,15 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
 
 	return ret;
 }
+
+int repack_write_midx(struct repack_write_midx_opts *opts)
+{
+	switch (opts->mode) {
+	case REPACK_WRITE_MIDX_NONE:
+		BUG("write_midx mode is NONE?");
+	case REPACK_WRITE_MIDX_DEFAULT:
+		return write_midx_included_packs(opts);
+	default:
+		BUG("unhandled write_midx mode: %d", opts->mode);
+	}
+}
diff --git a/repack.h b/repack.h
index 77d24ee45fb..81907fcce7f 100644
--- a/repack.h
+++ b/repack.h
@@ -134,6 +134,11 @@ void pack_geometry_release(struct pack_geometry *geometry);
 
 struct tempfile;
 
+enum repack_write_midx_mode {
+	REPACK_WRITE_MIDX_NONE,
+	REPACK_WRITE_MIDX_DEFAULT,
+};
+
 struct repack_write_midx_opts {
 	struct existing_packs *existing;
 	struct pack_geometry *geometry;
@@ -143,10 +148,11 @@ struct repack_write_midx_opts {
 	int show_progress;
 	int write_bitmaps;
 	int midx_must_contain_cruft;
+	enum repack_write_midx_mode mode;
 };
 
 void midx_snapshot_refs(struct repository *repo, struct tempfile *f);
-int write_midx_included_packs(struct repack_write_midx_opts *opts);
+int repack_write_midx(struct repack_write_midx_opts *opts);
 
 int write_filtered_pack(const struct write_pack_opts *opts,
 			struct existing_packs *existing,
-- 
2.54.0.9.gb905fd5d0ae

