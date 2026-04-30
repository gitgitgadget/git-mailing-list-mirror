Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2454502A
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508025; cv=none; b=jxVWvPTbtbFWxuVNrXazYgwu670gpLBenojND6mx5msHVFVImgQ16Pa30oqXfIQ26SrFDoZBJxugPsa+3IFB3MvkKon44ztowrTUYkUXwVx4UD4YYKW/D1Huf8zEgYW+V55/BT+0xF0qf/LZYHmfCIpIr0MYLt+EGzHExGXfNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508025; c=relaxed/simple;
	bh=Jw5+Vrf38nencXW2Wn7xKjbN8AdYsW+WfwxbvgMmQnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caYTVfPyq8E/QqD+adzuH7NThc3/GLRYG5/c5HfhsCF+IzElui3Z/b2JpEIdRwGdjUjM2K02nnz5nuqxDf2ydRhX/sOq/ndBK1bF0Q/lUzBoBX8nYR51xhR+NelnH/akGss3idY8RWpz4BU0gvNT4O4V36EK6WcGxqNP467XYXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=fv+y7eQH; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="fv+y7eQH"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7baee75f874so4601697b3.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777508022; x=1778112822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YA3aWaxm0bdyHskd1wq4N84hUnZLx1rFG45GYwyc0Hw=;
        b=fv+y7eQHbkViSOrCjvzIm/SKLs4TK792SRv10ExOeBe242p3Wyl0IwjnPj3LbSnx3X
         RxuVh83ci/DUtEBMQJ4tQGckw3k59NbumveC+C6p002iXIeWfia8qTNESc7I1JEQM63d
         G0boz72QJC8iEVX7JFXl5u81uaYPujMPQ4kdJaJ/0NtW7R98nYb/kuKIr7fg/46sm67I
         YoN0qzKwm1Roof/OC8k66uSkq779upPhM3I8Psr2zTmCSvQLtDMbd1T35tksApQvZpDs
         Gn1ZUM8yJEjmT3NHkZuIvJjtPlBDaQM24atrGZ3dvkF+JWp8rtzIi4iVsFaK/Mk0OoXB
         UOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777508022; x=1778112822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YA3aWaxm0bdyHskd1wq4N84hUnZLx1rFG45GYwyc0Hw=;
        b=cRV5MORmMXwnS095ru0xNRcDNIhNEtGdI/sZUnuNM7oFE7ki2NYjfrCsWEBdiu86Rr
         kwVD2deYzUGFiP47hz8qXdEgeG9JapzFXjy1+LvpyszwvlOSqFZ7m2IwmlYfFQNelsHU
         C6h1ZIcUBrnCGs2APaU8p48a5Htw9rHot5etAwF1/vaxe/+QHx2Nxq2FLIdU09app12y
         a66XNNqEQd16ti9opfkhXIttHFB7VB+di1AljRwUDB2FLUwc6KDRr5FCXYk4DMxsyN7g
         ls6CrLRtr6XGTigYUKx/8QE1PRX8t++9gE7PlDPVxjRMOB6P3ANO+tsbzFcC0asFRH2G
         xK8Q==
X-Gm-Message-State: AOJu0YxjGsRP56IcWAyChh5xvlRGDaAzfjBPgVXY50HhV9Wq82t8IB4b
	S65TD4B6nhNWF1U6A08INqUdQt7jlNcrbIl2BXqK0W9BFqVQPrTO+jARIOUMHwsDSsuezRshLzC
	xjRIYYoHHqQ==
X-Gm-Gg: AeBDiesXZ6YKtNo+wN+jzCH9E8F0/wZJh3XGjNlmLq1wDaj6uKkwuqFnFJG7Keq8R7K
	FFBrsdCYowshN1j/idySJmp5+rxIawYBcmG8ulENZS0wBFl9huFjATg32o8LQ5tkM+UWPUyEXJL
	g4xtoAl3UdiXDf0ZIh3jGF7N3Es1Ik2nKUoURSXgXpDF3HxF6vTq3AHvm+ClFj1HVXk3kD5KwyO
	7u6m7Pk+8ijqZtXaDgOUVXvjVG7pYrapZ8gO5NMe3ePgUsnIosoNLV/BRrhVU+DG76wP7JHwQrH
	K9J52417HmC6vth16/ZRmmbnl5XW6e8RQSLTNFE8QkD9J63p7zhtu/kIaOhb32U1ytR1rKrok9q
	pEKSLXffpdKmltJn/AcriqcNARGREhLMFxNdnNIvCcVVaZ9zCmsQ1KNXjNzBeaO7u/NyIjtiI0w
	L8tTP5dBy4p4B0dO28M2wPysyYeI3VFovGlaSbJjzSX/VDFCLJHHd8PXtYw8eGRv83AedXj3EOC
	IiB6hkEX/sfXGigYJ3NIwhZeLWuFtRiz/ck6h8Jo1JlUFQKyZIkIhPeA/DBKyXe9VQO+tyHTysv
	EOBtBmi4Bltz3YaezfOErCRrcAI=
X-Received: by 2002:a05:690c:d8b:b0:7a0:4146:6eaf with SMTP id 00721157ae682-7bd5286ec05mr11076617b3.16.1777508021601;
        Wed, 29 Apr 2026 17:13:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd548a00f3sm2046107b3.0.2026.04.29.17.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 17:13:41 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:13:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 12/16] builtin/repack.c: convert `--write-midx` to an
 `OPT_CALLBACK`
Message-ID: <1f7a5479bb8a4bdb8ff00afd2cd2f05dc6a629e4.1777507303.git.me@ttaylorr.com>
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
2.54.0.16.g1c05dfce579

