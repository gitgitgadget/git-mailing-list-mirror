Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127DE54BD3
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006197; cv=none; b=l5IKZJD56XsPO9fYewi3OyZ8M/aZIHRQm4PILpx387vFQ1DtGqS40H3bS9sq8abOBuJiDRYhgHnxH2uQmgTgrAlsLQUsgWqIt1JGXLMPKAFp5RZ5d0SycJYUDMsD7Cqwd5NM2iNQQ5k20oR44LF39pREzCoaSSspYmpCrAYnHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006197; c=relaxed/simple;
	bh=MZ56qfVPyqZpH6LZoxQfHMv5VybdLjUe8YUPcCNd1rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKZj+/d5vELY75igQAXDGCt1JojyuSjHO/dvi4gdLpJ5CTwEu+0oyVICSzaGo0tTosRNSUNSMzbB8Zvmi5hbzbZWYWx3XDEuSIB0vHuingp2efpqhJ46TMVXjWr0Olxb1P5LXi7SFbcs+I2cKvO4ZUSSJCyDoNF99k4RAcKDYtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Z938kK75; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Z938kK75"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42f52226f9bso16468911cf.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 14:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712006193; x=1712610993; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xqmy6PNsYc70GtTpIYDje/hTgYsUptfdwf5xy123wrs=;
        b=Z938kK75RKjWwv+Yl5hlMVc5ndY3NntC9whP0cEJp4yPPMoDqf4RLMYL1FfucAxUb+
         DaWSYp2br+HOsNd29HNmmFT6Uy3PsRBJEoBsfvi6ybCZ1NcCjv0fBX+EpJdsyFZpXFQD
         or2MehEVV/Eg4ZCVM1ZLEThWzx4OYoRPbaNuLqacWyW5M8IsDAUiP8ujCNrsJY0ULfIu
         5WrgHoJrOwjCRJC8qOygN3P0MsNU2/EWZ16yasj0XaMHKCJUgJktTIu52ShjX+O+lPGm
         OsW02GAzVqM9BCXy8G6J7RWowBXuO0AEVwYtnxCiLicIRm0ajhN6sMCab9H+EsU8Om5Z
         7EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712006193; x=1712610993;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xqmy6PNsYc70GtTpIYDje/hTgYsUptfdwf5xy123wrs=;
        b=MkTFPwkr5SqrKsUk04aCc0MaFchTjpqPi26g2oiAGq0CVE4qWFBzbd2CSVOSsYz0S1
         poM/RyNw81DF/krCwXCu0CtDeEC+uk7HJCyU7HS8XZ9wRm1fvKUUOEG7hcMXa3ZZY8qS
         OtB+0aEf6StTk6gsPA1rRhbctbbNUHhzDdRgDQDhoTEPEkKw6OyKUNdhiRk/FkQFF7CF
         SislbCNk7lo51tGTuAAlpqM5AiYn5S2Td85YDJxRmX3k72yFcVasBZvS1tYjhwD6DTgo
         b2u0x/pxh/NwHxeL4gZC3jGisV3mON5SPQgv5zgmS4mTVL+UZWjbmKw4EnDPiQ16EVFs
         kHPQ==
X-Gm-Message-State: AOJu0YzaD0w+ysV/9svDezGpFO437h8cVsyWQGVapUYaZwYhE9zrZNtr
	SktKmrjisCprflrloOgiIsaZunoQDqIUOaeQ3mZJGiGAU+Y8gkmIkPsipnzSnzFz1qYbq8ogk+/
	DDM8=
X-Google-Smtp-Source: AGHT+IHo3IVvC8abae/kks5VkxFCSOL8yarstVq8Fz2eBAsq0AnGq6lfnVnbwAEj0RwxmD0se2zf3A==
X-Received: by 2002:a05:622a:178b:b0:430:a037:db36 with SMTP id s11-20020a05622a178b00b00430a037db36mr12267957qtk.32.1712006193330;
        Mon, 01 Apr 2024 14:16:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i2-20020ac84882000000b00432feda5986sm572445qtq.35.2024.04.01.14.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:16:32 -0700 (PDT)
Date: Mon, 1 Apr 2024 17:16:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 0/4] midx: split MIDX writing routines into midx-write.c,
 cleanup
Message-ID: <cover.1712006190.git.me@ttaylorr.com>
References: <cover.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1711387439.git.me@ttaylorr.com>

Here is a reroll of my series 'tb/midx-write', now based on
'rs/midx-use-strvec-pushf', and reworked to incorporate feedback.

The series is mostly unchanged since last time, and the goal remains to
split out the writing-related functions from midx.c into a separate
compilation unit, midx-write.c.

Notable changes since last time include:

  - Rebasing on top of 'rs/midx-use-strvec-pushf', and dropping my patch
    which does the same thing as René's.

  - Combining the piece-meal migration patches from midx.c ->
    midx-write.c into a single patch.

Thanks in advance for your review!

Taylor Blau (4):
  midx-write: move writing-related functions from midx.c
  midx-write.c: factor out common want_included_pack() routine
  midx-write.c: check count of packs to repack after grouping
  midx-write.c: use `--stdin-packs` when repacking

 Makefile     |    1 +
 midx-write.c | 1525 +++++++++++++++++++++++++++++++++++++++++++++++++
 midx.c       | 1553 +-------------------------------------------------
 midx.h       |   19 +
 4 files changed, 1559 insertions(+), 1539 deletions(-)
 create mode 100644 midx-write.c

Range-diff against v1:
 1:  ffa8ba18de <  -:  ---------- midx-write: initial commit
 2:  b776fd528d <  -:  ---------- midx: extern a pair of shared functions
 3:  487a0ccda8 <  -:  ---------- midx: move `midx_repack` (and related functions) to midx-write.c
 4:  e2b6459aa8 <  -:  ---------- midx: move `expire_midx_packs` to midx-write.c
 5:  31d2e074fb <  -:  ---------- midx: move `write_midx_file_only` to midx-write.c
 6:  73977036d7 <  -:  ---------- midx: move `write_midx_file` to midx-write.c
 7:  e83ef66cf5 !  1:  8637ee3d0e midx: move `write_midx_internal` (and related functions) to midx-write.c
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    midx: move `write_midx_internal` (and related functions) to midx-write.c
    +    midx-write: move writing-related functions from midx.c
     
    -    Move the last writing-related function from midx.c to midx-write.c. This
    -    patch moves `write_midx_internal()`, along with all of the functions
    -    used to implement it into midx-write.c.
    +    Introduce a new midx-write.c source file, which holds all of the
    +    functionality from the MIDX sub-system related to writing new MIDX files.
     
    -    Like previous patch, this patch too does not introduce any functional
    -    changes, and is best moved with `--color-moved`.
    +    Similar to the relationship between "pack-bitmap.c" and
    +    "pack-bitmap-write.c", this source file will hold code that is specific
    +    to writing MIDX files as opposed to reading them (the latter will remain
    +    in midx.c).
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    - ## midx-write.c ##
    + ## Makefile ##
    +@@ Makefile: LIB_OBJS += merge-ort-wrappers.o
    + LIB_OBJS += merge-recursive.o
    + LIB_OBJS += merge.o
    + LIB_OBJS += midx.o
    ++LIB_OBJS += midx-write.o
    + LIB_OBJS += name-hash.o
    + LIB_OBJS += negotiator/default.o
    + LIB_OBJS += negotiator/noop.o
    +
    + ## midx-write.c (new) ##
     @@
    - #include "git-compat-util.h"
    ++#include "git-compat-util.h"
     +#include "abspath.h"
    - #include "config.h"
    - #include "hex.h"
    ++#include "config.h"
    ++#include "hex.h"
     +#include "lockfile.h"
    - #include "packfile.h"
    ++#include "packfile.h"
     +#include "object-file.h"
     +#include "hash-lookup.h"
    - #include "midx.h"
    - #include "progress.h"
    ++#include "midx.h"
    ++#include "progress.h"
     +#include "trace2.h"
    - #include "run-command.h"
    ++#include "run-command.h"
     +#include "chunk-format.h"
    - #include "pack-bitmap.h"
    ++#include "pack-bitmap.h"
     +#include "refs.h"
    - #include "revision.h"
    ++#include "revision.h"
     +#include "list-objects.h"
    - 
    --extern int write_midx_internal(const char *object_dir,
    ++
     +#define PACK_EXPIRED UINT_MAX
     +#define BITMAP_POS_UNKNOWN (~((uint32_t)0))
     +#define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
    @@ midx-write.c
     +}
     +
     +static int write_midx_internal(const char *object_dir,
    - 			       struct string_list *packs_to_include,
    - 			       struct string_list *packs_to_drop,
    - 			       const char *preferred_pack_name,
    - 			       const char *refs_snapshot,
    --			       unsigned flags);
    ++			       struct string_list *packs_to_include,
    ++			       struct string_list *packs_to_drop,
    ++			       const char *preferred_pack_name,
    ++			       const char *refs_snapshot,
     +			       unsigned flags)
     +{
     +	struct strbuf midx_name = STRBUF_INIT;
    @@ midx-write.c
     +	int dropped_packs = 0;
     +	int result = 0;
     +	struct chunkfile *cf;
    - 
    --extern struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
    --							const char *object_dir);
    ++
     +	trace2_region_enter("midx", "write_midx_internal", the_repository);
     +
     +	get_midx_filename(&midx_name, object_dir);
    @@ midx-write.c
     +
     +	return result;
     +}
    - 
    - int write_midx_file(const char *object_dir,
    - 		    const char *preferred_pack_name,
    ++
    ++int write_midx_file(const char *object_dir,
    ++		    const char *preferred_pack_name,
    ++		    const char *refs_snapshot,
    ++		    unsigned flags)
    ++{
    ++	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
    ++				   refs_snapshot, flags);
    ++}
    ++
    ++int write_midx_file_only(const char *object_dir,
    ++			 struct string_list *packs_to_include,
    ++			 const char *preferred_pack_name,
    ++			 const char *refs_snapshot,
    ++			 unsigned flags)
    ++{
    ++	return write_midx_internal(object_dir, packs_to_include, NULL,
    ++				   preferred_pack_name, refs_snapshot, flags);
    ++}
    ++
    ++int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
    ++{
    ++	uint32_t i, *count, result = 0;
    ++	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
    ++	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
    ++	struct progress *progress = NULL;
    ++
    ++	if (!m)
    ++		return 0;
    ++
    ++	CALLOC_ARRAY(count, m->num_packs);
    ++
    ++	if (flags & MIDX_PROGRESS)
    ++		progress = start_delayed_progress(_("Counting referenced objects"),
    ++					  m->num_objects);
    ++	for (i = 0; i < m->num_objects; i++) {
    ++		int pack_int_id = nth_midxed_pack_int_id(m, i);
    ++		count[pack_int_id]++;
    ++		display_progress(progress, i + 1);
    ++	}
    ++	stop_progress(&progress);
    ++
    ++	if (flags & MIDX_PROGRESS)
    ++		progress = start_delayed_progress(_("Finding and deleting unreferenced packfiles"),
    ++					  m->num_packs);
    ++	for (i = 0; i < m->num_packs; i++) {
    ++		char *pack_name;
    ++		display_progress(progress, i + 1);
    ++
    ++		if (count[i])
    ++			continue;
    ++
    ++		if (prepare_midx_pack(r, m, i))
    ++			continue;
    ++
    ++		if (m->packs[i]->pack_keep || m->packs[i]->is_cruft)
    ++			continue;
    ++
    ++		pack_name = xstrdup(m->packs[i]->pack_name);
    ++		close_pack(m->packs[i]);
    ++
    ++		string_list_insert(&packs_to_drop, m->pack_names[i]);
    ++		unlink_pack_path(pack_name, 0);
    ++		free(pack_name);
    ++	}
    ++	stop_progress(&progress);
    ++
    ++	free(count);
    ++
    ++	if (packs_to_drop.nr)
    ++		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, NULL, flags);
    ++
    ++	string_list_clear(&packs_to_drop, 0);
    ++
    ++	return result;
    ++}
    ++
    ++struct repack_info {
    ++	timestamp_t mtime;
    ++	uint32_t referenced_objects;
    ++	uint32_t pack_int_id;
    ++};
    ++
    ++static int compare_by_mtime(const void *a_, const void *b_)
    ++{
    ++	const struct repack_info *a, *b;
    ++
    ++	a = (const struct repack_info *)a_;
    ++	b = (const struct repack_info *)b_;
    ++
    ++	if (a->mtime < b->mtime)
    ++		return -1;
    ++	if (a->mtime > b->mtime)
    ++		return 1;
    ++	return 0;
    ++}
    ++
    ++static int fill_included_packs_all(struct repository *r,
    ++				   struct multi_pack_index *m,
    ++				   unsigned char *include_pack)
    ++{
    ++	uint32_t i, count = 0;
    ++	int pack_kept_objects = 0;
    ++
    ++	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
    ++
    ++	for (i = 0; i < m->num_packs; i++) {
    ++		if (prepare_midx_pack(r, m, i))
    ++			continue;
    ++		if (!pack_kept_objects && m->packs[i]->pack_keep)
    ++			continue;
    ++		if (m->packs[i]->is_cruft)
    ++			continue;
    ++
    ++		include_pack[i] = 1;
    ++		count++;
    ++	}
    ++
    ++	return count < 2;
    ++}
    ++
    ++static int fill_included_packs_batch(struct repository *r,
    ++				     struct multi_pack_index *m,
    ++				     unsigned char *include_pack,
    ++				     size_t batch_size)
    ++{
    ++	uint32_t i, packs_to_repack;
    ++	size_t total_size;
    ++	struct repack_info *pack_info;
    ++	int pack_kept_objects = 0;
    ++
    ++	CALLOC_ARRAY(pack_info, m->num_packs);
    ++
    ++	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
    ++
    ++	for (i = 0; i < m->num_packs; i++) {
    ++		pack_info[i].pack_int_id = i;
    ++
    ++		if (prepare_midx_pack(r, m, i))
    ++			continue;
    ++
    ++		pack_info[i].mtime = m->packs[i]->mtime;
    ++	}
    ++
    ++	for (i = 0; i < m->num_objects; i++) {
    ++		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
    ++		pack_info[pack_int_id].referenced_objects++;
    ++	}
    ++
    ++	QSORT(pack_info, m->num_packs, compare_by_mtime);
    ++
    ++	total_size = 0;
    ++	packs_to_repack = 0;
    ++	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
    ++		int pack_int_id = pack_info[i].pack_int_id;
    ++		struct packed_git *p = m->packs[pack_int_id];
    ++		size_t expected_size;
    ++
    ++		if (!p)
    ++			continue;
    ++		if (!pack_kept_objects && p->pack_keep)
    ++			continue;
    ++		if (p->is_cruft)
    ++			continue;
    ++		if (open_pack_index(p) || !p->num_objects)
    ++			continue;
    ++
    ++		expected_size = st_mult(p->pack_size,
    ++					pack_info[i].referenced_objects);
    ++		expected_size /= p->num_objects;
    ++
    ++		if (expected_size >= batch_size)
    ++			continue;
    ++
    ++		packs_to_repack++;
    ++		total_size += expected_size;
    ++		include_pack[pack_int_id] = 1;
    ++	}
    ++
    ++	free(pack_info);
    ++
    ++	if (packs_to_repack < 2)
    ++		return 1;
    ++
    ++	return 0;
    ++}
    ++
    ++int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags)
    ++{
    ++	int result = 0;
    ++	uint32_t i;
    ++	unsigned char *include_pack;
    ++	struct child_process cmd = CHILD_PROCESS_INIT;
    ++	FILE *cmd_in;
    ++	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
    ++
    ++	/*
    ++	 * When updating the default for these configuration
    ++	 * variables in builtin/repack.c, these must be adjusted
    ++	 * to match.
    ++	 */
    ++	int delta_base_offset = 1;
    ++	int use_delta_islands = 0;
    ++
    ++	if (!m)
    ++		return 0;
    ++
    ++	CALLOC_ARRAY(include_pack, m->num_packs);
    ++
    ++	if (batch_size) {
    ++		if (fill_included_packs_batch(r, m, include_pack, batch_size))
    ++			goto cleanup;
    ++	} else if (fill_included_packs_all(r, m, include_pack))
    ++		goto cleanup;
    ++
    ++	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
    ++	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);
    ++
    ++	strvec_push(&cmd.args, "pack-objects");
    ++
    ++	strvec_pushf(&cmd.args, "%s/pack/pack", object_dir);
    ++
    ++	if (delta_base_offset)
    ++		strvec_push(&cmd.args, "--delta-base-offset");
    ++	if (use_delta_islands)
    ++		strvec_push(&cmd.args, "--delta-islands");
    ++
    ++	if (flags & MIDX_PROGRESS)
    ++		strvec_push(&cmd.args, "--progress");
    ++	else
    ++		strvec_push(&cmd.args, "-q");
    ++
    ++	cmd.git_cmd = 1;
    ++	cmd.in = cmd.out = -1;
    ++
    ++	if (start_command(&cmd)) {
    ++		error(_("could not start pack-objects"));
    ++		result = 1;
    ++		goto cleanup;
    ++	}
    ++
    ++	cmd_in = xfdopen(cmd.in, "w");
    ++
    ++	for (i = 0; i < m->num_objects; i++) {
    ++		struct object_id oid;
    ++		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
    ++
    ++		if (!include_pack[pack_int_id])
    ++			continue;
    ++
    ++		nth_midxed_object_oid(&oid, m, i);
    ++		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
    ++	}
    ++	fclose(cmd_in);
    ++
    ++	if (finish_command(&cmd)) {
    ++		error(_("could not finish pack-objects"));
    ++		result = 1;
    ++		goto cleanup;
    ++	}
    ++
    ++	result = write_midx_internal(object_dir, NULL, NULL, NULL, NULL, flags);
    ++
    ++cleanup:
    ++	free(include_pack);
    ++	return result;
    ++}
     
      ## midx.c ##
     @@
    @@ midx.c
     -#include "list-objects.h"
      #include "pack-revindex.h"
      
    --struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
    --							const char *object_dir);
    --
    --int write_midx_internal(const char *object_dir,
    --			       struct string_list *packs_to_include,
    --			       struct string_list *packs_to_drop,
    --			       const char *preferred_pack_name,
    --			       const char *refs_snapshot,
    --			       unsigned flags);
    --
     -#define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
     -#define MIDX_VERSION 1
     -#define MIDX_BYTE_FILE_VERSION 4
    @@ midx.c: int prepare_multi_pack_index_one(struct repository *r, const char *objec
     -	return ret;
     -}
     -
    --struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
    +-static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
     -							const char *object_dir)
     -{
     -	struct multi_pack_index *result = NULL;
    @@ midx.c: int prepare_multi_pack_index_one(struct repository *r, const char *objec
     -	return result;
     -}
     -
    --int write_midx_internal(const char *object_dir,
    --			struct string_list *packs_to_include,
    --			struct string_list *packs_to_drop,
    --			const char *preferred_pack_name,
    --			const char *refs_snapshot,
    --			unsigned flags)
    +-static int write_midx_internal(const char *object_dir,
    +-			       struct string_list *packs_to_include,
    +-			       struct string_list *packs_to_drop,
    +-			       const char *preferred_pack_name,
    +-			       const char *refs_snapshot,
    +-			       unsigned flags)
     -{
     -	struct strbuf midx_name = STRBUF_INIT;
     -	unsigned char midx_hash[GIT_MAX_RAWSZ];
    @@ midx.c: int prepare_multi_pack_index_one(struct repository *r, const char *objec
     -
     -	return result;
     -}
    +-
    +-int write_midx_file(const char *object_dir,
    +-		    const char *preferred_pack_name,
    +-		    const char *refs_snapshot,
    +-		    unsigned flags)
    +-{
    +-	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
    +-				   refs_snapshot, flags);
    +-}
    +-
    +-int write_midx_file_only(const char *object_dir,
    +-			 struct string_list *packs_to_include,
    +-			 const char *preferred_pack_name,
    +-			 const char *refs_snapshot,
    +-			 unsigned flags)
    +-{
    +-	return write_midx_internal(object_dir, packs_to_include, NULL,
    +-				   preferred_pack_name, refs_snapshot, flags);
    +-}
     -
      struct clear_midx_data {
      	char *keep;
    @@ midx.c: static void clear_midx_file_ext(const char *full_path, size_t full_path_
      {
      	struct clear_midx_data data;
      	memset(&data, 0, sizeof(struct clear_midx_data));
    +@@ midx.c: int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
    + 
    + 	return verify_midx_error;
    + }
    +-
    +-int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
    +-{
    +-	uint32_t i, *count, result = 0;
    +-	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
    +-	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
    +-	struct progress *progress = NULL;
    +-
    +-	if (!m)
    +-		return 0;
    +-
    +-	CALLOC_ARRAY(count, m->num_packs);
    +-
    +-	if (flags & MIDX_PROGRESS)
    +-		progress = start_delayed_progress(_("Counting referenced objects"),
    +-					  m->num_objects);
    +-	for (i = 0; i < m->num_objects; i++) {
    +-		int pack_int_id = nth_midxed_pack_int_id(m, i);
    +-		count[pack_int_id]++;
    +-		display_progress(progress, i + 1);
    +-	}
    +-	stop_progress(&progress);
    +-
    +-	if (flags & MIDX_PROGRESS)
    +-		progress = start_delayed_progress(_("Finding and deleting unreferenced packfiles"),
    +-					  m->num_packs);
    +-	for (i = 0; i < m->num_packs; i++) {
    +-		char *pack_name;
    +-		display_progress(progress, i + 1);
    +-
    +-		if (count[i])
    +-			continue;
    +-
    +-		if (prepare_midx_pack(r, m, i))
    +-			continue;
    +-
    +-		if (m->packs[i]->pack_keep || m->packs[i]->is_cruft)
    +-			continue;
    +-
    +-		pack_name = xstrdup(m->packs[i]->pack_name);
    +-		close_pack(m->packs[i]);
    +-
    +-		string_list_insert(&packs_to_drop, m->pack_names[i]);
    +-		unlink_pack_path(pack_name, 0);
    +-		free(pack_name);
    +-	}
    +-	stop_progress(&progress);
    +-
    +-	free(count);
    +-
    +-	if (packs_to_drop.nr)
    +-		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, NULL, flags);
    +-
    +-	string_list_clear(&packs_to_drop, 0);
    +-
    +-	return result;
    +-}
    +-
    +-struct repack_info {
    +-	timestamp_t mtime;
    +-	uint32_t referenced_objects;
    +-	uint32_t pack_int_id;
    +-};
    +-
    +-static int compare_by_mtime(const void *a_, const void *b_)
    +-{
    +-	const struct repack_info *a, *b;
    +-
    +-	a = (const struct repack_info *)a_;
    +-	b = (const struct repack_info *)b_;
    +-
    +-	if (a->mtime < b->mtime)
    +-		return -1;
    +-	if (a->mtime > b->mtime)
    +-		return 1;
    +-	return 0;
    +-}
    +-
    +-static int fill_included_packs_all(struct repository *r,
    +-				   struct multi_pack_index *m,
    +-				   unsigned char *include_pack)
    +-{
    +-	uint32_t i, count = 0;
    +-	int pack_kept_objects = 0;
    +-
    +-	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
    +-
    +-	for (i = 0; i < m->num_packs; i++) {
    +-		if (prepare_midx_pack(r, m, i))
    +-			continue;
    +-		if (!pack_kept_objects && m->packs[i]->pack_keep)
    +-			continue;
    +-		if (m->packs[i]->is_cruft)
    +-			continue;
    +-
    +-		include_pack[i] = 1;
    +-		count++;
    +-	}
    +-
    +-	return count < 2;
    +-}
    +-
    +-static int fill_included_packs_batch(struct repository *r,
    +-				     struct multi_pack_index *m,
    +-				     unsigned char *include_pack,
    +-				     size_t batch_size)
    +-{
    +-	uint32_t i, packs_to_repack;
    +-	size_t total_size;
    +-	struct repack_info *pack_info;
    +-	int pack_kept_objects = 0;
    +-
    +-	CALLOC_ARRAY(pack_info, m->num_packs);
    +-
    +-	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
    +-
    +-	for (i = 0; i < m->num_packs; i++) {
    +-		pack_info[i].pack_int_id = i;
    +-
    +-		if (prepare_midx_pack(r, m, i))
    +-			continue;
    +-
    +-		pack_info[i].mtime = m->packs[i]->mtime;
    +-	}
    +-
    +-	for (i = 0; i < m->num_objects; i++) {
    +-		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
    +-		pack_info[pack_int_id].referenced_objects++;
    +-	}
    +-
    +-	QSORT(pack_info, m->num_packs, compare_by_mtime);
    +-
    +-	total_size = 0;
    +-	packs_to_repack = 0;
    +-	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
    +-		int pack_int_id = pack_info[i].pack_int_id;
    +-		struct packed_git *p = m->packs[pack_int_id];
    +-		size_t expected_size;
    +-
    +-		if (!p)
    +-			continue;
    +-		if (!pack_kept_objects && p->pack_keep)
    +-			continue;
    +-		if (p->is_cruft)
    +-			continue;
    +-		if (open_pack_index(p) || !p->num_objects)
    +-			continue;
    +-
    +-		expected_size = st_mult(p->pack_size,
    +-					pack_info[i].referenced_objects);
    +-		expected_size /= p->num_objects;
    +-
    +-		if (expected_size >= batch_size)
    +-			continue;
    +-
    +-		packs_to_repack++;
    +-		total_size += expected_size;
    +-		include_pack[pack_int_id] = 1;
    +-	}
    +-
    +-	free(pack_info);
    +-
    +-	if (packs_to_repack < 2)
    +-		return 1;
    +-
    +-	return 0;
    +-}
    +-
    +-int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags)
    +-{
    +-	int result = 0;
    +-	uint32_t i;
    +-	unsigned char *include_pack;
    +-	struct child_process cmd = CHILD_PROCESS_INIT;
    +-	FILE *cmd_in;
    +-	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
    +-
    +-	/*
    +-	 * When updating the default for these configuration
    +-	 * variables in builtin/repack.c, these must be adjusted
    +-	 * to match.
    +-	 */
    +-	int delta_base_offset = 1;
    +-	int use_delta_islands = 0;
    +-
    +-	if (!m)
    +-		return 0;
    +-
    +-	CALLOC_ARRAY(include_pack, m->num_packs);
    +-
    +-	if (batch_size) {
    +-		if (fill_included_packs_batch(r, m, include_pack, batch_size))
    +-			goto cleanup;
    +-	} else if (fill_included_packs_all(r, m, include_pack))
    +-		goto cleanup;
    +-
    +-	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
    +-	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);
    +-
    +-	strvec_push(&cmd.args, "pack-objects");
    +-
    +-	strvec_pushf(&cmd.args, "%s/pack/pack", object_dir);
    +-
    +-	if (delta_base_offset)
    +-		strvec_push(&cmd.args, "--delta-base-offset");
    +-	if (use_delta_islands)
    +-		strvec_push(&cmd.args, "--delta-islands");
    +-
    +-	if (flags & MIDX_PROGRESS)
    +-		strvec_push(&cmd.args, "--progress");
    +-	else
    +-		strvec_push(&cmd.args, "-q");
    +-
    +-	cmd.git_cmd = 1;
    +-	cmd.in = cmd.out = -1;
    +-
    +-	if (start_command(&cmd)) {
    +-		error(_("could not start pack-objects"));
    +-		result = 1;
    +-		goto cleanup;
    +-	}
    +-
    +-	cmd_in = xfdopen(cmd.in, "w");
    +-
    +-	for (i = 0; i < m->num_objects; i++) {
    +-		struct object_id oid;
    +-		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
    +-
    +-		if (!include_pack[pack_int_id])
    +-			continue;
    +-
    +-		nth_midxed_object_oid(&oid, m, i);
    +-		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
    +-	}
    +-	fclose(cmd_in);
    +-
    +-	if (finish_command(&cmd)) {
    +-		error(_("could not finish pack-objects"));
    +-		result = 1;
    +-		goto cleanup;
    +-	}
    +-
    +-	result = write_midx_internal(object_dir, NULL, NULL, NULL, NULL, flags);
    +-
    +-cleanup:
    +-	free(include_pack);
    +-	return result;
    +-}
     
      ## midx.h ##
     @@ midx.h: struct pack_entry;
 8:  8e32755c49 <  -:  ---------- midx-write.c: avoid directly managed temporary strbuf
 9:  5475b09a7a =  2:  0064e363c0 midx-write.c: factor out common want_included_pack() routine
10:  f77e3167aa =  3:  b121f05a32 midx-write.c: check count of packs to repack after grouping
11:  736be63234 !  4:  b5d6ba5802 midx-write.c: use `--stdin-packs` when repacking
    @@ midx-write.c: int midx_repack(struct repository *r, const char *object_dir, size
     +	strvec_pushl(&cmd.args, "pack-objects", "--stdin-packs", "--non-empty",
     +		     NULL);
      
    - 	if (delta_base_offset)
    - 		strvec_push(&cmd.args, "--delta-base-offset");
    + 	strvec_pushf(&cmd.args, "%s/pack/pack", object_dir);
    + 
     @@ midx-write.c: int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
      	}
      

base-commit: 11c821f2f2a31e70fb5cc449f9a29401c333aad2
prerequisite-patch-id: 3f7553c1b52071c935dd9ad3f94f7e675247498b
-- 
2.44.0.330.g158d2a670b4
