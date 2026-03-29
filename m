Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F682FF153
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820484; cv=none; b=QGqG21fpnCbBtnvtES2/jywvu86ZO8EDKXHP8pMb276fkQQG+8dmqnbs3QZTz+PCl7opTnIqBTM42NFaSp/NJAi04RumIdU5ql7RIqK5JVmuHHAgdXVWPchNAkJRlSVo8IgaeGrrBkX+T3W79x8GHUtQolWhN92dKvWa4wf1Gjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820484; c=relaxed/simple;
	bh=NcPEqiBS1cPFHJOy9c6/13+d3+7qX57jDdD777FJ/90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfwBfKpPmWNCJbW6PeNZ/wEum8bmIcqCY9mYhDhrGlbSKpUwomwFJZNASnTQvhPdNF6bpN6mVtRuzsoJWOW7DJY6In/q77KB3XlVvDUJGpD4OhKHIooOKnVsLkuG2YQ5NB3heWACpzWTdBtx1C31uH4NdE07FcdPet/356SxVfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=jq93P61d; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="jq93P61d"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6500040ef83so2120575d50.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820482; x=1775425282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=92VVJb94p+fkNgBpn4Q8FQ3c65fMfyOrwZXW1+ewAWE=;
        b=jq93P61dDqopewDg8+nUsU+vW5CGJf6u8d0ia4HGrDkhyl0W3IL6Jo6Cj5h44mOO3O
         OnOou8xRIgl8Aqa/bn1xWd8LcOQzQv9vlyLNB1n+al9elrheCuuXQwk1j9Fd1tOQkFgE
         I4TlOwcX0BU3KanVXtNfKevNNAvc+xUFhd/+vyYppVzmD/XpbT2ulosqRQX0ILQvNYN6
         9Nb1mUShembtADgoi1JhkgVO0H63rOMu+AkEMPw77vBHaOn7SrerrpeSjkFAjJ4nozv2
         yRK2u2LGWVPpNt7F+e1fOO5yGCjYT5+T2fsFCLZNiFOrQHPvNyU8x0M5b7zWGuOiY7td
         XhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820482; x=1775425282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92VVJb94p+fkNgBpn4Q8FQ3c65fMfyOrwZXW1+ewAWE=;
        b=mdenJPnAPQxOgfXEqaXkzxs91V//BNTRpXXs8qJ4qn60/8osMR+OH2WP6pfGjNaB25
         iYTCKXj8QpMLv8E80pdujlLGii7y2Rz8FbxkMs0867PlYJYNXMtMrP6Ids8PzyaxKClT
         qspaXrV8TanWrjRQSkO8MDMglvCk0cBPc4/shxwn6RH4SuVPw/AF5PC2jsZIJAyc5pgQ
         J4NnpNpgDcPEH1ZQJ4Vlq7P8GsZGH/xlqR64Ipz/HOeiSjwv7egcogJhNfSBAZuFhow9
         NS2J+vkS9OJz7F3g/ZKRJA1eUgEm0zKS/cHYbztEdRYh+LObsZVG6U3fBqgm76MesIvX
         QkzA==
X-Gm-Message-State: AOJu0Yy1pkT3OliyjEyRT8oPyDarWJQ28ZY1D6nrKFx7fe4NC4TLNTRY
	vF9C63HCqiG0W9vRa0ldARgtPzmHhASLmwxAjOGY6iFKTscX7ydF97ITRKQyWzOEh/wP8IWD0tP
	9Sr9qiJTz4Q==
X-Gm-Gg: ATEYQzzR66pKhW9aVUKpcs97mJ/Zg2jTCQnd4EImNiDFxR4Qf66XSZiu7a5kbrhENhK
	VV2c9SmJq4JjkApIwBjLCyRbgpF09CqEO4/txhSsEzDmjsmd+r44ayAnqssb41DpE8R1gTgw5Sy
	Au/9tfgeea7ID1xH6K0BzjJ4dPzUehRKkR0vaiRRLh/5GjUpYoeAXkcE0tLRYmPRGSxbuWBUy0R
	H/+panpoZk/tbs3sHPB88bZcFJbC4je3qIcdOU6QBSzcg4QXFMXbcqVDpMhmAnx+j8G/rqS0+XP
	nEUViKB6VeZIHxNIOBzYqpBh70KdWI7V7jKTPBy9rs30aa3JX9ss1UnYO9cCu0x5oZ06stZ3DQ8
	2+jq17JZM/DG/wVpnj3ILT81By+74EeDZX/7BtC6XnGdbimZXgTfAmDlbRq0iTSnIUKMLWv2Wpk
	p+Z0Iv1Ohqr2cIvvYHTmcif08bsbBzcvxqCVXA4ONeu/z7bFjcz4BKsI/b5Je02FS8czx3GYjkN
	rpToHpJwtdDPewBD2raBOq34FfGUg==
X-Received: by 2002:a05:690c:d8e:b0:79f:855b:1cd1 with SMTP id 00721157ae682-79f855b26c6mr1763777b3.32.1774820482313;
        Sun, 29 Mar 2026 14:41:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb790bd81sm27075597b3.11.2026.03.29.14.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:41:22 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:41:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 12/16] builtin/repack.c: convert `--write-midx` to an
 `OPT_CALLBACK`
Message-ID: <56dc6d55974ffe08647d57915d0861181e1d7d41.1774820449.git.me@ttaylorr.com>
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
index 44a95b56f23..3a5042491d6 100644
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
@@ -504,7 +530,7 @@ int cmd_repack(int argc,
 	if (delete_redundant && pack_everything & ALL_INTO_ONE)
 		existing_packs_mark_for_deletion(&existing, &names);
 
-	if (write_midx) {
+	if (write_midx != REPACK_WRITE_MIDX_NONE) {
 		struct repack_write_midx_opts opts = {
 			.existing = &existing,
 			.geometry = &geometry,
@@ -513,11 +539,11 @@ int cmd_repack(int argc,
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
2.53.0.729.g817728289e1.dirty

