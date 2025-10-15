Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71030F527
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567377; cv=none; b=hnhtNqhHW4Mwr5RVSZWKQdTIybc5iHw1MK0Bzu+E2n8xkX4D/LY2sialRdbjg/rDkXs1rjl6IdI1COkLkQMY3yhlvWUnPpSWpZncz1XaZlPM0tgGMQfwnKt3vWQhyN0cQAyyQWfpp5mcr+p8Yshk9EgYqs9RXje7TL6xqZ8x7t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567377; c=relaxed/simple;
	bh=b8t/sNpJmgKfnZFbj3dUX9pwHlMTcesjOt59T0XDCsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgKiUfG0oHouGkAJAnsVmEzn8hm+KeKvud6bSIBDSnvQH71KkUJIhn5aM+p+DTMmoHImBnr1ydZ48zpluC35ab4f/3Pu41/WHApl4z1NKr8Rzh3cCmY4xSWfI2xRAUbReRU6QGIwpfr1arPO74ZkJg3gGsR/xgRGAC3VqX13hek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=k8qAEQK9; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="k8qAEQK9"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7826060df96so573737b3.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567374; x=1761172174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vqwBknQ8VqZo95kl5l8zhvubZMmUfm8m3dqZWVRrqIU=;
        b=k8qAEQK9I3R5j6nqvHO6y6s+j0PfbP2FLGShdBwSLoP6/OcqyQb3oylMrECDKkh2ri
         8NxOFRLO0QP6V9bN7QTaM80vc5vrr/mosnhjnxqADe7R5Dzp7B/F8FqK5mhKHlZuCWAn
         eCi7N01o4qcmEfFWETsNAWlNKt3UWWG5k8NLVFH5uZY7QjiUh68JEZ2ThUGSEa7y00HF
         jEDuwHzRZhNcP67bFECkF4af6kraX3G2CGD0azryrJcAu5YFhsgDF62+xHTPi+SFl5tM
         5HUgX+lLIwQ9sz1vUxeiQNc2t1sn1DxKUCXXgIwXnToBpgA6cKtgVSkGOVGbi8uEpJ2c
         D7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567374; x=1761172174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqwBknQ8VqZo95kl5l8zhvubZMmUfm8m3dqZWVRrqIU=;
        b=WQLbsw9zzwGEBAQ0gTGuCMMzQHWevGOk3NqP7FPwp7W3ZKzbrMuBNSzMCkuraq72Vq
         ELbHDrcKhc9dJGzF5UGQPRmMFe+wQMk9KLrGXnZ4T7seRLjlmCidvqNQjJa0/A3q92Ff
         UMvzKN0AqS2wA6TqJAFr0zaGdOKLPjbgcpj9Pqkp2vCErBsNUieCrQ6546xx3mNGtB/T
         Nzvohb0CqoUVUK6k1O5OHX/uWMP3GFfBQWxU0TTq97GWMGMe47j8ttzNzz/V9F9mnl96
         m15sGnIZrGq5t2ZzIaV6frD4wf+Qu5TwBCNxQv73eIeQAQZXdKYNfYGOSNbXyYeooQ1g
         OS4g==
X-Gm-Message-State: AOJu0YwNCwjO5Yg3WVWRaXiEQ1a9/rUK37sj72kGREpkFDplCyYWDp4J
	gpcToSNpNYGVrUHPsnfKu6Th2QfW7fKk+iE6WZdWGHRvdlB7WdjQDAimbuwTQhZugTk5AqoXHIR
	pn1n1TiF7FYh1
X-Gm-Gg: ASbGncviHhtnISpRD/rRMPl/EhSCObmByMpubQm0crFWPB4zT311Pp2wxje2IvZfsQI
	p5vkHnRpVWQoHL+kfpUzAhcQmneJeJBtPkXhDmvcg1ORdjI8ejqueABzhB3VJvGpKW3ASvLf/8l
	7dQ1DCrN97foUJi6ZyQ4btRpEX3+q4NM4AVudflLNGldHmpR9/Sk9Gh9cTzqadN88oOVrHF5Gn7
	h024b9vqPN7VkxDXw/kCwv/BvYIJGMO3qVuzkDyFxt0xl/7rMtq2PfQjKUq4WymK+WkD06BMIfy
	HtINHuoiDucQktu33S05O0wKHPH5G1u2ebLNl7nrgMB/b4beVHzEK67tJddFwXozinwPH8Oa5x1
	MoLvs4OcW3rxY0S8RQzXncOmeaae4dND9sPkTEjQkhqzCghvtTQ4tAvVBajVuJ0wasCdExkDXFs
	CgJrODWMmCWob8Wi9lsfa0XGfZf07CZbf7+4SPRZfixNkYTVxxu0aeonCpiFoJrAAoyS6KVj3BY
	E2Cm/A=
X-Google-Smtp-Source: AGHT+IEvEz3697mp+Wlq37X9Ca0Hb1w2nzDZseJb4gwMW7dCBQgcOxCUEVe9iy5WWKNkNV+kPrKrIQ==
X-Received: by 2002:a05:690c:b05:b0:717:c1cd:3443 with SMTP id 00721157ae682-780e17a2e79mr258179617b3.38.1760567374232;
        Wed, 15 Oct 2025 15:29:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828d7bcf42sm2749487b3.29.2025.10.15.15.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:34 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 46/49] repack: move `pack_kept_objects` to `struct
 pack_objects_args`
Message-ID: <dbc317af27c58484dd462b433653a7a65b7b4e64.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

The "pack_kept_objects" variable is defined as static to the repack
builtin, but is inherently related to the pack-objects arguments that
the builtin uses when generating new packs.

Move that field into the "struct pack_objects_args", and shuffle around
where we append the corresponding command-line option when preparing a
pack-objects process. Specifically:

 - `write_cruft_pack()` always wants to pass "--honor-pack-keep", so
   explicitly set the `pack_kept_objects` field to "0" when initializing
   the `write_pack_opts` struct before calling `write_cruft_pack()`.

 - `write_filtered_pack()` no longer needs to handle writing the
   command-line option "--honor-pack-keep" when preparing a pack-objects
   process, since its call to `prepare_pack_objects()` will have already
   taken care of that.

   `write_filtered_pack()` also reads the `pack_kept_objects` field to
   determine whether to write the existing kept packs with a leading "^"
   character, so update that to read through the `po_args` pointer
   instead.

 - `cmd_repack()` also no longer has to write the "--honor-pack-keep"
   flag explicitly, since this is also handled via its call to
   `prepare_pack_objects()`.

Since there is a default value for "pack_kept_objects" that relies on
whether or not we are writing a bitmap (and not writing a MIDX), extract
a default initializer for `struct pack_objects_args` that keeps this
conditional default behavior.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c  | 20 +++++++-------------
 repack-geometry.c |  5 ++---
 repack.c          |  2 ++
 repack.h          |  9 ++++++---
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 71abcfa0b7..3c6d7e91fd 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -33,7 +33,6 @@
 #define RETAIN_PACK 2
 
 static int pack_everything;
-static int pack_kept_objects = -1;
 static int write_bitmaps = -1;
 static int use_delta_islands;
 static int run_update_server_info = 1;
@@ -68,7 +67,7 @@ static int repack_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "repack.packkeptobjects")) {
-		pack_kept_objects = git_config_bool(var, value);
+		po_args->pack_kept_objects = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "repack.writebitmaps") ||
@@ -122,8 +121,6 @@ static int write_filtered_pack(const struct write_pack_opts *opts,
 
 	strvec_push(&cmd.args, "--stdin-packs");
 
-	if (!pack_kept_objects)
-		strvec_push(&cmd.args, "--honor-pack-keep");
 	for_each_string_list_item(item, &existing->kept_packs)
 		strvec_pushf(&cmd.args, "--keep-pack=%s", item->string);
 
@@ -146,7 +143,7 @@ static int write_filtered_pack(const struct write_pack_opts *opts,
 		fprintf(in, "%s.pack\n", item->string);
 	for_each_string_list_item(item, &existing->cruft_packs)
 		fprintf(in, "%s.pack\n", item->string);
-	caret = pack_kept_objects ? "" : "^";
+	caret = opts->po_args->pack_kept_objects ? "" : "^";
 	for_each_string_list_item(item, &existing->kept_packs)
 		fprintf(in, "%s%s.pack\n", caret, item->string);
 	fclose(in);
@@ -208,7 +205,6 @@ static int write_cruft_pack(const struct write_pack_opts *opts,
 		strvec_pushf(&cmd.args, "--cruft-expiration=%s",
 			     cruft_expiration);
 
-	strvec_push(&cmd.args, "--honor-pack-keep");
 	strvec_push(&cmd.args, "--non-empty");
 
 	cmd.in = -1;
@@ -332,7 +328,7 @@ int cmd_repack(int argc,
 		OPT_UNSIGNED(0, "max-pack-size", &po_args.max_pack_size,
 			     N_("maximum size of each packfile")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&po_args.filter_options),
-		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
+		OPT_BOOL(0, "pack-kept-objects", &po_args.pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("do not repack this pack")),
@@ -378,8 +374,8 @@ int cmd_repack(int argc,
 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
 			write_bitmaps = 0;
 	}
-	if (pack_kept_objects < 0)
-		pack_kept_objects = write_bitmaps > 0 && !write_midx;
+	if (po_args.pack_kept_objects < 0)
+		po_args.pack_kept_objects = write_bitmaps > 0 && !write_midx;
 
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
 		die(_(incremental_bitmap_conflict_error));
@@ -420,8 +416,7 @@ int cmd_repack(int argc,
 	if (geometry.split_factor) {
 		if (pack_everything)
 			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
-		pack_geometry_init(&geometry, &existing, &po_args,
-				   pack_kept_objects);
+		pack_geometry_init(&geometry, &existing, &po_args);
 		pack_geometry_split(&geometry);
 	}
 
@@ -430,8 +425,6 @@ int cmd_repack(int argc,
 	show_progress = !po_args.quiet && isatty(2);
 
 	strvec_push(&cmd.args, "--keep-true-parents");
-	if (!pack_kept_objects)
-		strvec_push(&cmd.args, "--honor-pack-keep");
 	for (i = 0; i < keep_pack_list.nr; i++)
 		strvec_pushf(&cmd.args, "--keep-pack=%s",
 			     keep_pack_list.items[i].string);
@@ -581,6 +574,7 @@ int cmd_repack(int argc,
 		cruft_po_args.local = po_args.local;
 		cruft_po_args.quiet = po_args.quiet;
 		cruft_po_args.delta_base_offset = po_args.delta_base_offset;
+		cruft_po_args.pack_kept_objects = 0;
 
 		ret = write_cruft_pack(&opts, cruft_expiration,
 				       combine_cruft_below_size, &names,
diff --git a/repack-geometry.c b/repack-geometry.c
index f58f1fc7f0..e2f9794d7d 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -27,8 +27,7 @@ static int pack_geometry_cmp(const void *va, const void *vb)
 
 void pack_geometry_init(struct pack_geometry *geometry,
 			struct existing_packs *existing,
-			const struct pack_objects_args *args,
-			int pack_kept_objects)
+			const struct pack_objects_args *args)
 {
 	struct packfile_store *packs = existing->repo->objects->packfiles;
 	struct packed_git *p;
@@ -43,7 +42,7 @@ void pack_geometry_init(struct pack_geometry *geometry,
 			 */
 			continue;
 
-		if (!pack_kept_objects) {
+		if (!args->pack_kept_objects) {
 			/*
 			 * Any pack that has its pack_keep bit set will
 			 * appear in existing->kept_packs below, but
diff --git a/repack.c b/repack.c
index 2c478970f3..2ab33c665a 100644
--- a/repack.c
+++ b/repack.c
@@ -38,6 +38,8 @@ void prepare_pack_objects(struct child_process *cmd,
 		strvec_push(&cmd->args,  "--quiet");
 	if (args->delta_base_offset)
 		strvec_push(&cmd->args,  "--delta-base-offset");
+	if (!args->pack_kept_objects)
+		strvec_push(&cmd->args,  "--honor-pack-keep");
 	strvec_push(&cmd->args, out);
 	cmd->git_cmd = 1;
 	cmd->out = -1;
diff --git a/repack.h b/repack.h
index 3244f601e2..0432379815 100644
--- a/repack.h
+++ b/repack.h
@@ -17,10 +17,14 @@ struct pack_objects_args {
 	int name_hash_version;
 	int path_walk;
 	int delta_base_offset;
+	int pack_kept_objects;
 	struct list_objects_filter_options filter_options;
 };
 
-#define PACK_OBJECTS_ARGS_INIT { .delta_base_offset = 1 }
+#define PACK_OBJECTS_ARGS_INIT { \
+	.delta_base_offset = 1, \
+	.pack_kept_objects = -1, \
+}
 
 struct child_process;
 
@@ -104,8 +108,7 @@ struct pack_geometry {
 
 void pack_geometry_init(struct pack_geometry *geometry,
 			struct existing_packs *existing,
-			const struct pack_objects_args *args,
-			int pack_kept_objects);
+			const struct pack_objects_args *args);
 void pack_geometry_split(struct pack_geometry *geometry);
 struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry);
 void pack_geometry_remove_redundant(struct pack_geometry *geometry,
-- 
2.51.0.540.ga7423965ad8

