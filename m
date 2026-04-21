Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680BD371CE6
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803834; cv=none; b=fEOOxiFLIZCjAjHg1bBswbBwh36bpPGGgzQ6wCeTdLdfVd728nwQbL1Wlv3Jcu3hOfCznnmmrIe62suaox/GBzu9F4TqiX264vaWrJx8ZgYaxvcAeXIyBJJOTmqP50/boaKWsu8yWtavapdwlPlKWWlIeDY1KXeXtiUE9fbg518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803834; c=relaxed/simple;
	bh=a4MHLxUQLwwZ26VGy9eQP9SZPCxFCvXpor4sQyPdAvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyeoPZipQx0yJrq/2YjSu9l3648X3h72GCregjiNTA11G4D+Y22pEmeYih4vuq2EalP2FbQODBUrqbzgcKLg6NcA+XzHSvVf+nWxu/50GIZhSOjO3Vi4iORaLtfy3i8oYgM8/4bdrfy+WthAd+CuBfri3nuxbv5KL7rKj9fHsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=IEI/yGsT; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="IEI/yGsT"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40974bf7781so4439916fac.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776803830; x=1777408630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RvG7dQLegg0RfNtZujmF+0GzR0rPs0VNGLGlQqQCmow=;
        b=IEI/yGsTbqq9Wv99uYaFqQCp3EyuZlzAdActhq4rkJX5Izw1EAkqakCvmJ7bWUBeU6
         hdckBAF/Qyo0ZdPy+u5hK7fJ0lL8BWHGOcJauSpKo/yYVaMw1S7y/bFH/kXEXxrDk7E4
         KHp2Qu3kg5Amyh4+LrWMx62s73UIJqOdjiZ68WP94+tCKSDc9x0xrvvJm4ksyvaTqfeF
         P8dPs89Z7rkvHXAAaNDol4p8LbzG8dDf768tJa8WFgtfs3nF5MZYIdx05MWL5/doe6Bi
         vJqvxlJ+WNts8YCVvhkk5Dsi+uVcVBn8o1O0QusO1YSTL36TjjqlWPqSZLNuylVxP1C5
         FW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803830; x=1777408630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvG7dQLegg0RfNtZujmF+0GzR0rPs0VNGLGlQqQCmow=;
        b=IylOM8KhkWa/AHQYdQn7LPbBJjSCXbjI8Phha3KBpt/JYNvB3vWEsBnQKQMXHACWQU
         qPur7M4ZlMbsk77wdWn+AoX1pX/BHNyMvEjgMYuOJYz9WpM06DRr43GdtUP3WupKb7C3
         7lzvKH/PEs74Plih+4DWLg4HN8j2wE1oFds8ZgykSw4Y2c1UfGkx+TCSsp2DYKymIxxx
         ZZnrEz5F59eYgg/fMN9mK19v7LPkPhw1awCeTnbr5JJq8l6D/oGdc2+PnoW5W51ZLkvw
         OXgEpStt5DDf8RJIyZivgXpIyKlsGPUqBV3pTg4LkoekbyjKEoBKnRHaJKdtrLF7nVWp
         4bcw==
X-Gm-Message-State: AOJu0Yz/bprAAY5nqRWIR7QGQcp1vkzFIp6GaCuPremSl7s2V2t+vsmf
	fB1CJLAzazu/vcG5uMcuYgYScrSGNPPjsmbFHlPSmxoblYZyevyW22z1dK8WFR70fkYeg5ErNaK
	/r1SAqcI=
X-Gm-Gg: AeBDievTBtN/unzEa0mZR/ZfmvBi9T6DC7VPbnQd9bTTDEic5/bXTCCNt0PNWc/Auj2
	KxiWmKBPM0CnByA1SVUh7xHx8BW4X6SpjqSeRW91Iv4vjdUHXMYF8ZlN1VUGv4+j2tpDJQknmGQ
	46a/QQILSRipl6JBaPlHNGVCSMd9wA33uSxSnzJ2UnoDEjehXi863OVP8p6YHG9/MtIhTx3Wylz
	mPjMfnDJWKyJ3XGSkyTIlh6ysIDyXuS3tu8PGEM0lmfQLTb6gd3+ERvZ8upJ/xFHjfgzQ31fxzH
	PGBnOivcsGWl9skcGwhEhgz8Uc7FjrnBBGILuwOQlAJr7Knx4GYndzH1iYZsFAXfEX/4vDS8FDl
	KGqM57IzGqj5mJIJYNwAwstPGdhW6VfCelCx9GW4vBe7dnc1axIVMGVg0TphBt0o4+XM+8ZwtYi
	6C/Xt/Ty4LFN0CwxSU/xTYs1eQjThA0WfEqC8Rm8ghtslyMDoCoil/h9ILqR+CssLg6Y3dt8c5h
	SIMDIUWqOHVED8mY84zQfhjDlP/7IpYeqiEUOg8Lx+ni24if2ZXpb47vheBu2HBBLuzyKTmSyHa
	NlsF8XizhvWAaXZvhQvpuKH5+Pg=
X-Received: by 2002:a05:6870:1422:b0:417:455a:2c01 with SMTP id 586e51a60fabf-42a997e0428mr10194866fac.1.1776803829604;
        Tue, 21 Apr 2026 13:37:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42c05ca16e2sm5326361fac.15.2026.04.21.13.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:37:08 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:37:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/16] repack: incremental MIDX/bitmap-based repacking
Message-ID: <cover.1776803827.git.me@ttaylorr.com>
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

[Note to the maintainer, this is rebased onto current 'master', which is
94f057755b7 (Git 2.54, 2026-04-19) at the time of writing.]

This a modest-sized reroll of my series to implement the last remaining
component of the incremental MIDX/bitmap-based repacking strategy that I
have been working on.

The main changes since last time are described in [1], which I sent to
the list last week just before the 2.54 release was tagged. For
convenience, a copy of the main changes are below:

 - Use a strset instead of a string_list for keeping track of the MIDX
   layers to retain when calling `either clear_midx_files_ext()` or
   `clear_incremental_midx_files_ext()`.

 - A new patch to rewrite the logic for determining which MIDX layers
   comprise the new chain via keep_hashes to build the array in order.
   The subsequent patch converts that into a strvec, which no longer
   requires direct manipulation.

 - The new "--checksum-only" option has been renamed to
   "--no-write-chain-file", and various small implementation tweaks
   (e.g., relying on `is_lock_file_locked()` to determine whether we
   should update the chain file as opposed to reading the flags).

As usual, a range-diff is included below as well for convenience. Thanks
in advance for reviewing!

[1]: https://lore.kernel.org/git/ad7B7cxKP7tNCXUf@nand.local

Taylor Blau (16):
  midx-write: handle noop writes when converting incremental chains
  midx: use `strset` for retained MIDX files
  midx: build `keep_hashes` array in order
  midx: use `strvec` for `keep_hashes`
  midx: introduce `--no-write-chain-file` for incremental MIDX writes
  midx: support custom `--base` for incremental MIDX writes
  repack: track the ODB source via existing_packs
  midx: expose `midx_layer_contains_pack()`
  repack-midx: factor out `repack_prepare_midx_command()`
  repack-midx: extract `repack_fill_midx_stdin_packs()`
  repack-geometry: prepare for incremental MIDX repacking
  builtin/repack.c: convert `--write-midx` to an `OPT_CALLBACK`
  packfile: ensure `close_pack_revindex()` frees in-memory revindex
  repack: implement incremental MIDX repacking
  repack: introduce `--write-midx=incremental`
  repack: allow `--write-midx=incremental` without `--geometric`

 Documentation/config/repack.adoc        |  18 +
 Documentation/git-multi-pack-index.adoc |  32 +-
 Documentation/git-repack.adoc           |  44 +-
 builtin/multi-pack-index.c              |  48 +-
 builtin/repack.c                        | 102 +++-
 midx-write.c                            | 206 ++++---
 midx.c                                  | 104 ++--
 midx.h                                  |  11 +-
 packfile.c                              |   2 +
 repack-geometry.c                       |  48 +-
 repack-midx.c                           | 717 +++++++++++++++++++++++-
 repack.c                                |  58 +-
 repack.h                                |  26 +-
 t/meson.build                           |   1 +
 t/t5334-incremental-multi-pack-index.sh |  63 +++
 t/t5335-compact-multi-pack-index.sh     | 113 ++++
 t/t7705-repack-incremental-midx.sh      | 525 +++++++++++++++++
 17 files changed, 1918 insertions(+), 200 deletions(-)
 create mode 100755 t/t7705-repack-incremental-midx.sh

Range-diff against v1:
 1:  0c7a68ca5a7 =  1:  d6c27317c25 midx-write: handle noop writes when converting incremental chains
 2:  1391552dfc6 !  2:  629c8d23116 midx: use `string_list` for retained MIDX files
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    midx: use `string_list` for retained MIDX files
    +    midx: use `strset` for retained MIDX files
     
         Both `clear_midx_files_ext()` and `clear_incremental_midx_files_ext()`
         build a list of filenames to keep while pruning stale MIDX files. Today
    -    they hand-roll an array instead of using a `string_list`, thus requiring
    -    us to pass an additional length parameter, and makes lookups linear.
    +    they hand-roll an array instead of using a `strset`, thus requiring us
    +    to pass an additional length parameter, and makes lookups linear.
     
    -    Replace the bare array with a `string_list` which can be passed around
    -    as a single parameter. Though it improves lookup performance, the
    -    difference is likely immeasurable given how small the keep_hashes array
    -    typically is.
    +    Replace the bare array with a `strset` which can be passed around as a
    +    single parameter. Though it improves lookup performance, the difference
    +    is likely immeasurable given how small the keep_hashes array typically
    +    is.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ midx.c: int midx_checksum_valid(struct multi_pack_index *m)
      struct clear_midx_data {
     -	char **keep;
     -	uint32_t keep_nr;
    -+	struct string_list keep;
    ++	struct strset keep;
      	const char *ext;
      };
      
    @@ midx.c: static void clear_midx_file_ext(const char *full_path, size_t full_path_
     -		if (!strcmp(data->keep[i], file_name))
     -			return;
     -	}
    -+	if (string_list_has_string(&data->keep, file_name))
    ++	if (strset_contains(&data->keep, file_name))
     +		return;
      	if (unlink(full_path))
      		die_errno(_("failed to remove %s"), full_path);
    @@ midx.c: static void clear_midx_file_ext(const char *full_path, size_t full_path_
     -	struct clear_midx_data data;
     -	memset(&data, 0, sizeof(struct clear_midx_data));
     +	struct clear_midx_data data = {
    -+		.keep = STRING_LIST_INIT_DUP,
    ++		.keep = STRSET_INIT,
     +		.ext = ext,
     +	};
      
    @@ midx.c: static void clear_midx_file_ext(const char *full_path, size_t full_path_
      
     -		data.keep[0] = xstrfmt("multi-pack-index-%s.%s", keep_hash, ext);
     -		data.keep_nr = 1;
    -+		string_list_insert(&data.keep, buf.buf);
    ++		strset_add(&data.keep, buf.buf);
     +
     +		strbuf_release(&buf);
      	}
    @@ midx.c: static void clear_midx_file_ext(const char *full_path, size_t full_path_
     -	if (keep_hash)
     -		free(data.keep[0]);
     -	free(data.keep);
    -+	string_list_clear(&data.keep, 0);
    ++	strset_clear(&data.keep);
      }
      
      void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
    @@ midx.c: static void clear_midx_file_ext(const char *full_path, size_t full_path_
      {
     -	struct clear_midx_data data;
     +	struct clear_midx_data data = {
    -+		.keep = STRING_LIST_INIT_NODUP,
    ++		.keep = STRSET_INIT,
     +		.ext = ext,
     +	};
    ++	struct strbuf buf = STRBUF_INIT;
      	uint32_t i;
      
     -	memset(&data, 0, sizeof(struct clear_midx_data));
    --
    ++	for (i = 0; i < hashes_nr; i++) {
    ++		strbuf_reset(&buf);
    ++		strbuf_addf(&buf, "multi-pack-index-%s.%s", keep_hashes[i],
    ++			    ext);
    + 
     -	ALLOC_ARRAY(data.keep, hashes_nr);
    - 	for (i = 0; i < hashes_nr; i++)
    +-	for (i = 0; i < hashes_nr; i++)
     -		data.keep[i] = xstrfmt("multi-pack-index-%s.%s", keep_hashes[i],
     -				       ext);
     -	data.keep_nr = hashes_nr;
     -	data.ext = ext;
    -+		string_list_append(&data.keep,
    -+				   xstrfmt("multi-pack-index-%s.%s",
    -+					   keep_hashes[i], ext));
    -+	string_list_sort(&data.keep);
    ++		strset_add(&data.keep, buf.buf);
    ++	}
      
      	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
      				     clear_midx_file_ext, &data);
    @@ midx.c: static void clear_midx_file_ext(const char *full_path, size_t full_path_
     -	for (i = 0; i < hashes_nr; i++)
     -		free(data.keep[i]);
     -	free(data.keep);
    -+	string_list_clear(&data.keep, 0);
    ++	strbuf_release(&buf);
    ++	strset_clear(&data.keep);
      }
      
      void clear_midx_file(struct repository *r)
 3:  aea6aad6953 !  3:  e303bf6a4ac strvec: introduce `strvec_init_alloc()`
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    strvec: introduce `strvec_init_alloc()`
    +    midx: build `keep_hashes` array in order
     
    -    When the caller knows upfront how many elements will be pushed onto a
    -    `strvec`, it is useful to pre-allocate enough space in the array to fit
    -    that many elements (and one additional slot to store NULL, indicating
    -    the end of the list.)
    +    Instead of filling the keep_hashes array using reverse indexing (e.g.,
    +    `keep_hashes[count - i - 1]`) while traversing linked lists forward,
    +    collect linked list nodes into a temporary `layers` array and then
    +    iterate it backwards to fill `keep_hashes` sequentially.
     
    -    Introduce `strvec_init_alloc()`, which allocates the backing array large
    -    enough to hold `alloc` elements and the termination marker without
    -    further reallocation. Reimplement `strvec_init()` as a special case of
    -    `strvec_init_alloc()`, namely when `alloc` is zero.
    +    This makes the filling logic easier to follow, since each segment of the
    +    array is filled with a simple forward-marching index. Moreover, this
    +    change prepares us for a subsequent commit that will switch to using a
    +    `strvec`.
     
    -    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    - ## strvec.c ##
    -@@ strvec.c: const char *empty_strvec[] = { NULL };
    + ## midx-write.c ##
    +@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    + 		FILE *chainf = fdopen_lock_file(&lk, "w");
    + 		struct strbuf final_midx_name = STRBUF_INIT;
    + 		struct multi_pack_index *m = ctx.base_midx;
    ++		struct multi_pack_index **layers = NULL;
    ++		size_t layers_nr = 0, layers_alloc = 0;
    ++		size_t j = 0;
      
    - void strvec_init(struct strvec *array)
    - {
    --	struct strvec blank = STRVEC_INIT;
    --	memcpy(array, &blank, sizeof(*array));
    -+	strvec_init_alloc(array, 0);
    -+}
    -+
    -+void strvec_init_alloc(struct strvec *array, size_t alloc)
    -+{
    -+	if (!alloc) {
    -+		struct strvec blank = STRVEC_INIT;
    -+		memcpy(array, &blank, sizeof(*array));
    -+	} else {
    -+		CALLOC_ARRAY(array->v, st_add(alloc, 1));
    -+		array->nr = 0;
    -+		array->alloc = alloc + 1;
    -+	}
    - }
    + 		if (!chainf) {
    + 			error_errno(_("unable to open multi-pack-index chain file"));
    +@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    + 		strbuf_release(&final_midx_name);
    + 
    + 		if (ctx.compact) {
    +-			struct multi_pack_index *m;
    +-			uint32_t num_layers_before_from = 0;
    +-			uint32_t i;
    ++			struct multi_pack_index *mp;
    + 
    +-			for (m = ctx.base_midx; m; m = m->base_midx)
    +-				num_layers_before_from++;
    +-
    +-			m = ctx.base_midx;
    +-			for (i = 0; i < num_layers_before_from; i++) {
    +-				uint32_t j = num_layers_before_from - i - 1;
    +-
    +-				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
    +-				m = m->base_midx;
    ++			for (mp = ctx.base_midx; mp; mp = mp->base_midx) {
    ++				ALLOC_GROW(layers, layers_nr + 1, layers_alloc);
    ++				layers[layers_nr++] = mp;
    + 			}
    ++			while (layers_nr)
    ++				keep_hashes[j++] =
    ++					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
      
    - void strvec_push_nodup(struct strvec *array, char *value)
    -
    - ## strvec.h ##
    -@@ strvec.h: struct strvec {
    -  */
    - void strvec_init(struct strvec *);
    +-			keep_hashes[i] = xstrdup(hash_to_hex_algop(midx_hash,
    +-								   r->hash_algo));
    ++			keep_hashes[j++] =
    ++				xstrdup(hash_to_hex_algop(midx_hash,
    ++							  r->hash_algo));
      
    -+/*
    -+ * Initializes an array large enough to store `alloc` elements.
    -+ */
    -+void strvec_init_alloc(struct strvec *, size_t alloc);
    +-			i = 0;
    +-			for (m = ctx.m;
    +-			     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
    +-			     m = m->base_midx) {
    +-				keep_hashes[keep_hashes_nr - i - 1] =
    +-					xstrdup(midx_get_checksum_hex(m));
    +-				i++;
    ++			for (mp = ctx.m;
    ++			     mp && midx_hashcmp(mp, ctx.compact_to,
    ++						r->hash_algo);
    ++			     mp = mp->base_midx) {
    ++				ALLOC_GROW(layers, layers_nr + 1, layers_alloc);
    ++				layers[layers_nr++] = mp;
    + 			}
    ++			while (layers_nr)
    ++				keep_hashes[j++] =
    ++					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
    + 		} else {
    +-			keep_hashes[ctx.num_multi_pack_indexes_before] =
    ++			for (; m; m = m->base_midx) {
    ++				ALLOC_GROW(layers, layers_nr + 1, layers_alloc);
    ++				layers[layers_nr++] = m;
    ++			}
    ++			while (layers_nr)
    ++				keep_hashes[j++] =
    ++					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
     +
    - /* Push a copy of a string onto the end of the array. */
    - const char *strvec_push(struct strvec *, const char *);
    ++			keep_hashes[j++] =
    + 				xstrdup(hash_to_hex_algop(midx_hash,
    + 							  r->hash_algo));
    +-
    +-			for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
    +-				uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
    +-
    +-				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
    +-				m = m->base_midx;
    +-			}
    + 		}
      
    +-		for (uint32_t i = 0; i < keep_hashes_nr; i++)
    ++		ASSERT(j == keep_hashes_nr);
    ++
    ++		free(layers);
    ++
    ++		for (uint32_t i = 0; i < j; i++)
    + 			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
    + 	} else {
    + 		keep_hashes[ctx.num_multi_pack_indexes_before] =
 4:  5fc72d5049a !  4:  42d76c70060 midx: use `strvec` for `keep_hashes`
    @@ Commit message
         value is used to determine the contents of the resulting
         `multi-pack-index-chain` file when writing with "--incremental".
     
    +    Since the previous commit already builds the array in forward order, the
    +    conversion is straightforward: replace indexed assignments with
    +    `strvec_push()`, drop the pre-counting and `CALLOC_ARRAY()`, and
    +    simplify cleanup via `strvec_clear()`.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## midx-write.c ##
    @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
      	int dropped_packs = 0;
      	int result = -1;
     -	const char **keep_hashes = NULL;
    +-	size_t keep_hashes_nr = 0;
     +	struct strvec keep_hashes = STRVEC_INIT;
    - 	size_t keep_hashes_nr = 0;
      	struct chunkfile *cf;
      
    + 	trace2_region_enter("midx", "write_midx_internal", r);
     @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    - 	} else {
    - 		keep_hashes_nr = ctx.num_multi_pack_indexes_before + 1;
    - 	}
    + 	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
    + 		die(_("too many multi-pack-indexes"));
    + 
    +-	if (ctx.compact) {
    +-		struct multi_pack_index *m;
    +-
    +-		/*
    +-		 * Keep all MIDX layers excluding those in the range [from, to].
    +-		 */
    +-		for (m = ctx.base_midx; m; m = m->base_midx)
    +-			keep_hashes_nr++;
    +-		for (m = ctx.m;
    +-		     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
    +-		     m = m->base_midx)
    +-			keep_hashes_nr++;
    +-
    +-		keep_hashes_nr++; /* include the compacted layer */
    +-	} else {
    +-		keep_hashes_nr = ctx.num_multi_pack_indexes_before + 1;
    +-	}
     -	CALLOC_ARRAY(keep_hashes, keep_hashes_nr);
    -+	strvec_init_alloc(&keep_hashes, keep_hashes_nr);
    - 
    +-
      	if (ctx.incremental) {
      		FILE *chainf = fdopen_lock_file(&lk, "w");
    -@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    - 			for (i = 0; i < num_layers_before_from; i++) {
    - 				uint32_t j = num_layers_before_from - i - 1;
    + 		struct strbuf final_midx_name = STRBUF_INIT;
    + 		struct multi_pack_index *m = ctx.base_midx;
    + 		struct multi_pack_index **layers = NULL;
    + 		size_t layers_nr = 0, layers_alloc = 0;
    +-		size_t j = 0;
      
    --				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
    -+				keep_hashes.v[j] = xstrdup(midx_get_checksum_hex(m));
    -+				keep_hashes.nr++;
    - 				m = m->base_midx;
    + 		if (!chainf) {
    + 			error_errno(_("unable to open multi-pack-index chain file"));
    +@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    + 				layers[layers_nr++] = mp;
      			}
    + 			while (layers_nr)
    +-				keep_hashes[j++] =
    +-					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
    ++				strvec_push(&keep_hashes,
    ++					    midx_get_checksum_hex(layers[--layers_nr]));
      
    --			keep_hashes[i] = xstrdup(hash_to_hex_algop(midx_hash,
    -+			keep_hashes.v[i] = xstrdup(hash_to_hex_algop(midx_hash,
    - 								   r->hash_algo));
    -+			keep_hashes.nr++;
    +-			keep_hashes[j++] =
    +-				xstrdup(hash_to_hex_algop(midx_hash,
    +-							  r->hash_algo));
    ++			strvec_push(&keep_hashes,
    ++				    hash_to_hex_algop(midx_hash,
    ++						     r->hash_algo));
      
    - 			i = 0;
    - 			for (m = ctx.m;
    - 			     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
    - 			     m = m->base_midx) {
    --				keep_hashes[keep_hashes_nr - i - 1] =
    -+				keep_hashes.v[keep_hashes_nr - i - 1] =
    - 					xstrdup(midx_get_checksum_hex(m));
    -+				keep_hashes.nr++;
    - 				i++;
    + 			for (mp = ctx.m;
    + 			     mp && midx_hashcmp(mp, ctx.compact_to,
    +@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    + 				layers[layers_nr++] = mp;
      			}
    + 			while (layers_nr)
    +-				keep_hashes[j++] =
    +-					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
    ++				strvec_push(&keep_hashes,
    ++					    midx_get_checksum_hex(layers[--layers_nr]));
      		} else {
    --			keep_hashes[ctx.num_multi_pack_indexes_before] =
    -+			keep_hashes.v[ctx.num_multi_pack_indexes_before] =
    - 				xstrdup(hash_to_hex_algop(midx_hash,
    - 							  r->hash_algo));
    -+			keep_hashes.nr++;
    - 
    - 			for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
    - 				uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
    - 
    --				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
    -+				keep_hashes.v[j] = xstrdup(midx_get_checksum_hex(m));
    -+				keep_hashes.nr++;
    - 				m = m->base_midx;
    + 			for (; m; m = m->base_midx) {
    + 				ALLOC_GROW(layers, layers_nr + 1, layers_alloc);
    + 				layers[layers_nr++] = m;
      			}
    + 			while (layers_nr)
    +-				keep_hashes[j++] =
    +-					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
    ++				strvec_push(&keep_hashes,
    ++					    midx_get_checksum_hex(layers[--layers_nr]));
    + 
    +-			keep_hashes[j++] =
    +-				xstrdup(hash_to_hex_algop(midx_hash,
    +-							  r->hash_algo));
    ++			strvec_push(&keep_hashes,
    ++				    hash_to_hex_algop(midx_hash,
    ++						     r->hash_algo));
      		}
      
    - 		for (uint32_t i = 0; i < keep_hashes_nr; i++)
    +-		ASSERT(j == keep_hashes_nr);
    +-
    + 		free(layers);
    + 
    +-		for (uint32_t i = 0; i < j; i++)
     -			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
    ++		for (size_t i = 0; i < keep_hashes.nr; i++)
     +			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes.v[i]);
      	} else {
     -		keep_hashes[ctx.num_multi_pack_indexes_before] =
    -+		keep_hashes.v[ctx.num_multi_pack_indexes_before] =
    - 			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
    -+		keep_hashes.nr++;
    +-			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
    ++		strvec_push(&keep_hashes,
    ++			    hash_to_hex_algop(midx_hash, r->hash_algo));
      	}
      
      	if (ctx.m || ctx.base_midx)
    @@ midx.c: void clear_midx_files_ext(struct odb_source *source, const char *ext,
     +				      const struct strvec *keep_hashes)
      {
      	struct clear_midx_data data = {
    --		.keep = STRING_LIST_INIT_NODUP,
    -+		.keep = STRING_LIST_INIT_DUP,
    + 		.keep = STRSET_INIT,
      		.ext = ext,
      	};
    + 	struct strbuf buf = STRBUF_INIT;
     -	uint32_t i;
      
    --	for (i = 0; i < hashes_nr; i++)
    --		string_list_append(&data.keep,
    --				   xstrfmt("multi-pack-index-%s.%s",
    --					   keep_hashes[i], ext));
    --	string_list_sort(&data.keep);
    +-	for (i = 0; i < hashes_nr; i++) {
    +-		strbuf_reset(&buf);
    +-		strbuf_addf(&buf, "multi-pack-index-%s.%s", keep_hashes[i],
    +-			    ext);
     +	if (keep_hashes) {
    -+		struct strbuf buf = STRBUF_INIT;
     +		for (size_t i = 0; i < keep_hashes->nr; i++) {
     +			strbuf_reset(&buf);
    -+
     +			strbuf_addf(&buf, "multi-pack-index-%s.%s",
     +				    keep_hashes->v[i], ext);
    -+			string_list_append(&data.keep, buf.buf);
    + 
    +-		strset_add(&data.keep, buf.buf);
    ++			strset_add(&data.keep, buf.buf);
     +		}
    -+
    -+		string_list_sort(&data.keep);
    -+		strbuf_release(&buf);
    -+	}
    + 	}
      
      	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
    - 				     clear_midx_file_ext, &data);
 5:  41cb5471bb9 !  5:  2c80aa34fac midx: introduce `--checksum-only` for incremental MIDX writes
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    midx: introduce `--checksum-only` for incremental MIDX writes
    +    midx: introduce `--no-write-chain-file` for incremental MIDX writes
     
         When writing an incremental MIDX layer, the MIDX machinery writes the
         new layer into the multi-pack-index.d directory and then updates the
    @@ Commit message
         assemble the new MIDX chain itself before writing a new chain file and
         atomically linking it into place).
     
    -    Introduce a `--checksum-only` flag that:
    +    Introduce a `--no-write-chain-file` flag that:
     
          * writes the new MIDX layer into the multi-pack-index.d directory
     
    @@ Documentation/git-multi-pack-index.adoc: SYNOPSIS
      'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
      		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
     -		         [--refs-snapshot=<path>]
    -+		         [--refs-snapshot=<path>] [--[no-]checksum-only]
    ++		         [--refs-snapshot=<path>] [--[no-]write-chain-file]
      'git multi-pack-index' [<options>] compact [--[no-]incremental]
     -		         [--[no-]bitmap] <from> <to>
    -+		         [--[no-]bitmap] [--[no-]checksum-only] <from> <to>
    ++		         [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>
      'git multi-pack-index' [<options>] verify
      'git multi-pack-index' [<options>] expire
      'git multi-pack-index' [<options>] repack [--batch-size=<size>]
    +@@ Documentation/git-multi-pack-index.adoc: marker).
    + 		and packs not present in an existing MIDX layer.
    + 		Migrates non-incremental MIDXs to incremental ones when
    + 		necessary.
    ++
    ++	--[no-]write-chain-file::
    ++		When used with `--incremental`, write a new MIDX layer
    ++		but do not update the multi-pack-index-chain file.
    ++		The checksum of the new layer is printed to standard
    ++		output, allowing the caller to assemble and write the
    ++		chain itself. Requires `--incremental`.
    + --
    + 
    + compact::
    +@@ Documentation/git-multi-pack-index.adoc: compact::
    + 
    + 	--[no-]bitmap::
    + 		Control whether or not a multi-pack bitmap is written.
    ++
    ++	--[no-]write-chain-file::
    ++		When used with `--incremental`, write a new compacted
    ++		MIDX layer but do not update the multi-pack-index-chain
    ++		file. The checksum of the new layer is printed to
    ++		standard output. Requires `--incremental`.
    + --
    + +
    + Note that the compact command requires writing a version-2 midx that
     
      ## builtin/multi-pack-index.c ##
     @@
    @@ builtin/multi-pack-index.c
      	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
      	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
     -	   "  [--refs-snapshot=<path>]")
    -+	   "  [--refs-snapshot=<path>] [--[no-]checksum-only]")
    ++	   "  [--refs-snapshot=<path>] [--[no-]write-chain-file]")
      
      #define BUILTIN_MIDX_COMPACT_USAGE \
      	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
     -	   "  [--[no-]bitmap] <from> <to>")
    -+	   "  [--[no-]bitmap] [--[no-]checksum-only] <from> <to>")
    ++	   "  [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>")
      
      #define BUILTIN_MIDX_VERIFY_USAGE \
      	N_("git multi-pack-index [<options>] verify")
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, cons
      			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
      		OPT_BIT(0, "incremental", &opts.flags,
      			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
    -+		OPT_BIT(0, "checksum-only", &opts.flags,
    -+			N_("write a MIDX layer without updating the MIDX chain"),
    -+			MIDX_WRITE_CHECKSUM_ONLY),
    ++		OPT_NEGBIT(0, "write-chain-file", &opts.flags,
    ++			N_("write the multi-pack-index chain file"),
    ++			MIDX_WRITE_NO_CHAIN),
      		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
      			 N_("write multi-pack index containing only given indexes")),
      		OPT_FILENAME(0, "refs-snapshot", &opts.refs_snapshot,
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, cons
      		usage_with_options(builtin_multi_pack_index_write_usage,
      				   options);
     +
    -+	if (opts.flags & MIDX_WRITE_CHECKSUM_ONLY &&
    ++	if (opts.flags & MIDX_WRITE_NO_CHAIN &&
     +	    !(opts.flags & MIDX_WRITE_INCREMENTAL)) {
     +		error(_("cannot use %s without %s"),
    -+		      "--checksum-only", "--incremental");
    ++		      "--no-write-chain-file", "--incremental");
     +		usage_with_options(builtin_multi_pack_index_write_usage,
     +				   options);
     +	}
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_compact(int argc, co
      			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
      		OPT_BIT(0, "incremental", &opts.flags,
      			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
    -+		OPT_BIT(0, "checksum-only", &opts.flags,
    -+			N_("write a MIDX layer without updating the MIDX chain"),
    -+			MIDX_WRITE_CHECKSUM_ONLY),
    ++		OPT_NEGBIT(0, "write-chain-file", &opts.flags,
    ++			N_("write the multi-pack-index chain file"),
    ++			MIDX_WRITE_NO_CHAIN),
      		OPT_END(),
      	};
      
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_compact(int argc, co
      		usage_with_options(builtin_multi_pack_index_compact_usage,
      				   options);
     +
    -+	if (opts.flags & MIDX_WRITE_CHECKSUM_ONLY &&
    ++	if (opts.flags & MIDX_WRITE_NO_CHAIN &&
     +	    !(opts.flags & MIDX_WRITE_INCREMENTAL)) {
     +		error(_("cannot use %s without %s"),
    -+		      "--checksum-only", "--incremental");
    ++		      "--no-write-chain-file", "--incremental");
     +		usage_with_options(builtin_multi_pack_index_compact_usage,
     +				   options);
     +	}
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_compact(int argc, co
      	FREE_AND_NULL(options);
     
      ## midx-write.c ##
    +@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    + 	unsigned char midx_hash[GIT_MAX_RAWSZ];
    + 	uint32_t start_pack;
    + 	struct hashfile *f = NULL;
    +-	struct lock_file lk;
    ++	struct lock_file lk = LOCK_INIT;
    + 	struct tempfile *incr;
    + 	struct write_midx_context ctx = {
    + 		.preferred_pack_idx = NO_PREFERRED_PACK,
     @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
      	}
      
      	if (ctx.incremental) {
     -		struct strbuf lock_name = STRBUF_INIT;
    -+		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
    ++		if (!(opts->flags & MIDX_WRITE_NO_CHAIN)) {
     +			struct strbuf lock_name = STRBUF_INIT;
      
     -		get_midx_chain_filename(opts->source, &lock_name);
    @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
      		incr = mks_tempfile_m(midx_name.buf, 0444);
      		if (!incr) {
     @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    - 	}
    - 	strvec_init_alloc(&keep_hashes, keep_hashes_nr);
    + 	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
    + 		die(_("too many multi-pack-indexes"));
      
    -+	if (opts->flags & MIDX_WRITE_CHECKSUM_ONLY)
    ++	if (!is_lock_file_locked(&lk))
     +		printf("%s\n", hash_to_hex_algop(midx_hash, r->hash_algo));
    ++	else if (opts->flags & MIDX_WRITE_NO_CHAIN)
    ++		BUG("lockfile held with MIDX_WRITE_NO_CHAIN set?");
     +
      	if (ctx.incremental) {
     -		FILE *chainf = fdopen_lock_file(&lk, "w");
      		struct strbuf final_midx_name = STRBUF_INIT;
      		struct multi_pack_index *m = ctx.base_midx;
    + 		struct multi_pack_index **layers = NULL;
    + 		size_t layers_nr = 0, layers_alloc = 0;
      
     -		if (!chainf) {
     -			error_errno(_("unable to open multi-pack-index chain file"));
     -			goto cleanup;
    -+		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
    ++		if (is_lock_file_locked(&lk)){
     +			FILE *chainf = fdopen_lock_file(&lk, "w");
     +			if (!chainf) {
     +				error_errno(_("unable to open multi-pack-index chain file"));
    @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
      
      		if (link_midx_to_chain(ctx.base_midx) < 0)
     @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    - 			}
    - 		}
      
    --		for (uint32_t i = 0; i < keep_hashes_nr; i++)
    + 		free(layers);
    + 
    +-		for (size_t i = 0; i < keep_hashes.nr; i++)
     -			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes.v[i]);
    -+		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY))
    -+			for (uint32_t i = 0; i < keep_hashes_nr; i++)
    ++		if (is_lock_file_locked(&lk))
    ++			for (size_t i = 0; i < keep_hashes.nr; i++)
     +				fprintf(get_lock_file_fp(&lk), "%s\n",
     +					keep_hashes.v[i]);
      	} else {
    - 		keep_hashes.v[ctx.num_multi_pack_indexes_before] =
    - 			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
    + 		strvec_push(&keep_hashes,
    + 			    hash_to_hex_algop(midx_hash, r->hash_algo));
     @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
      	if (ctx.m || ctx.base_midx)
      		odb_close(ctx.repo->objects);
      
     -	if (commit_lock_file(&lk) < 0)
     -		die_errno(_("could not write multi-pack-index"));
    -+	if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
    ++	if (is_lock_file_locked(&lk)) {
     +		if (commit_lock_file(&lk) < 0)
     +			die_errno(_("could not write multi-pack-index"));
      
    @@ midx.h: struct multi_pack_index {
      #define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
      #define MIDX_WRITE_INCREMENTAL (1 << 5)
      #define MIDX_WRITE_COMPACT (1 << 6)
    -+#define MIDX_WRITE_CHECKSUM_ONLY (1 << 7)
    ++#define MIDX_WRITE_NO_CHAIN (1 << 7)
      
      #define MIDX_EXT_REV "rev"
      #define MIDX_EXT_BITMAP "bitmap"
    @@ t/t5334-incremental-multi-pack-index.sh: test_expect_success 'show object from s
      	git cat-file -p 2.2
      '
      
    -+test_expect_success 'write MIDX layer with --checksum-only' '
    -+	test_commit checksum-only &&
    ++test_expect_success 'write MIDX layer with --no-write-chain-file' '
    ++	test_commit no-write-chain-file &&
     +	git repack -d &&
     +
     +	cp "$midx_chain" "$midx_chain.bak" &&
     +	layer="$(git multi-pack-index write --bitmap --incremental \
    -+		--checksum-only)" &&
    ++		--no-write-chain-file)" &&
     +
     +	test_cmp "$midx_chain.bak" "$midx_chain" &&
     +	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
     +'
     +
    -+test_expect_success 'write non-incremental MIDX layer with --checksum-only' '
    -+	test_must_fail git multi-pack-index write --bitmap --checksum-only 2>err &&
    -+	test_grep "cannot use --checksum-only without --incremental" err
    ++test_expect_success 'write non-incremental MIDX layer with --no-write-chain-file' '
    ++	test_must_fail git multi-pack-index write --bitmap --no-write-chain-file 2>err &&
    ++	test_grep "cannot use --no-write-chain-file without --incremental" err
     +'
     +
      for reuse in false single multi
    @@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with b
      	)
      '
      
    -+test_expect_success 'MIDX compaction with --checksum-only' '
    -+	git init midx-compact-with--checksum-only &&
    ++test_expect_success 'MIDX compaction with --no-write-chain-file' '
    ++	git init midx-compact-with--no-write-chain-file &&
     +	(
    -+		cd midx-compact-with--checksum-only &&
    ++		cd midx-compact-with--no-write-chain-file &&
     +
     +		git config maintenance.auto false &&
     +
    @@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with b
     +		cp "$midx_chain" "$midx_chain".bak &&
     +
     +		layer="$(git multi-pack-index compact --incremental \
    -+			--checksum-only \
    ++			--no-write-chain-file \
     +			"$(nth_line 2 "$midx_chain")" \
     +			"$(nth_line 3 "$midx_chain")")" &&
     +
    @@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with b
     +		# After writing the new layer, insert it into the chain
     +		# manually. This is done in order to make $layer visible
     +		# to the read-midx test helper below, and matches what
    -+		# the MIDX command would do without --checksum-only.
    ++		# the MIDX command would do without --no-write-chain-file.
     +		{
     +			nth_line 1 "$midx_chain.bak" &&
     +			echo $layer &&
 6:  6b42d284b79 !  6:  2a05f4b86f3 midx: support custom `--base` for incremental MIDX writes
    @@ Commit message
         If no `--base` is given, behavior is unchanged: `compact` uses "from's"
         immediate parent in the chain, and `write` appends to the existing tip.
     
    -    For the `write` subcommand, `--base` requires `--checksum-only`. A plain
    +    For the `write` subcommand, `--base` requires `--no-write-chain-file`. A plain
         `write --incremental` appends a new layer to the live chain tip with no
         mechanism to atomically replace it; overriding the base would produce a
         layer that does not extend the tip, breaking chain invariants. With
    -    `--checksum-only` the chain is left unmodified and the caller is
    +    `--no-write-chain-file` the chain is left unmodified and the caller is
         responsible for assembling a valid chain.
     
         For `compact`, no such restriction applies. The compaction operation
    @@ Documentation/git-multi-pack-index.adoc
     @@ Documentation/git-multi-pack-index.adoc: SYNOPSIS
      'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
      		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
    - 		         [--refs-snapshot=<path>] [--[no-]checksum-only]
    + 		         [--refs-snapshot=<path>] [--[no-]write-chain-file]
     +			 [--base=<checksum>]
      'git multi-pack-index' [<options>] compact [--[no-]incremental]
    --		         [--[no-]bitmap] [--[no-]checksum-only] <from> <to>
    -+		         [--[no-]bitmap] [--base=<checksum>] [--[no-]checksum-only]
    +-		         [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>
    ++		         [--[no-]bitmap] [--base=<checksum>] [--[no-]write-chain-file]
     +			 <from> <to>
      'git multi-pack-index' [<options>] verify
      'git multi-pack-index' [<options>] expire
      'git multi-pack-index' [<options>] repack [--batch-size=<size>]
     @@ Documentation/git-multi-pack-index.adoc: marker).
    - 		and packs not present in an existing MIDX layer.
    - 		Migrates non-incremental MIDXs to incremental ones when
    - 		necessary.
    + 		The checksum of the new layer is printed to standard
    + 		output, allowing the caller to assemble and write the
    + 		chain itself. Requires `--incremental`.
     +
     +	--base=<checksum>::
     +		Specify the checksum of an existing MIDX layer to use
     +		as the base when writing a new incremental layer.
     +		The special value `none` indicates that the new layer
     +		should have no base (i.e., it becomes a root layer).
    -+		Requires `--checksum-only`.
    ++		Requires `--no-write-chain-file`.
      --
      
      compact::
     @@ Documentation/git-multi-pack-index.adoc: compact::
    - 
    - 	--[no-]bitmap::
    - 		Control whether or not a multi-pack bitmap is written.
    + 		MIDX layer but do not update the multi-pack-index-chain
    + 		file. The checksum of the new layer is printed to
    + 		standard output. Requires `--incremental`.
     +
     +	--base=<checksum>::
     +		Specify the checksum of an existing MIDX layer to use
    @@ Documentation/git-multi-pack-index.adoc: compact::
     +		the immediate parent of `<from>`. The special value
     +		`none` indicates that the result should have no base.
      --
    - 
    - verify::
    + +
    + Note that the compact command requires writing a version-2 midx that
     
      ## builtin/multi-pack-index.c ##
     @@
      #define BUILTIN_MIDX_WRITE_USAGE \
      	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
      	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
    --	   "  [--refs-snapshot=<path>] [--[no-]checksum-only]")
    -+	   "  [--refs-snapshot=<path>] [--[no-]checksum-only]\n" \
    +-	   "  [--refs-snapshot=<path>] [--[no-]write-chain-file]")
    ++	   "  [--refs-snapshot=<path>] [--[no-]write-chain-file]\n" \
     +	   "  [--base=<checksum>]")
      
      #define BUILTIN_MIDX_COMPACT_USAGE \
      	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
    --	   "  [--[no-]bitmap] [--[no-]checksum-only] <from> <to>")
    -+	   "  [--[no-]bitmap] [--base=<checksum>] [--[no-]checksum-only]\n" \
    +-	   "  [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>")
    ++	   "  [--[no-]bitmap] [--base=<checksum>] [--[no-]write-chain-file]\n" \
     +	   "  <from> <to>")
      
      #define BUILTIN_MIDX_VERIFY_USAGE \
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, cons
     +			   N_("base MIDX for incremental writes")),
      		OPT_BIT(0, "incremental", &opts.flags,
      			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
    - 		OPT_BIT(0, "checksum-only", &opts.flags,
    + 		OPT_NEGBIT(0, "write-chain-file", &opts.flags,
     @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, const char **argv,
      				   options);
      	}
      
     +	if (opts.incremental_base &&
    -+	    !(opts.flags & MIDX_WRITE_CHECKSUM_ONLY)) {
    -+		error(_("cannot use --base without --checksum-only"));
    ++	    !(opts.flags & MIDX_WRITE_NO_CHAIN)) {
    ++		error(_("cannot use --base without --no-write-chain-file"));
     +		usage_with_options(builtin_multi_pack_index_write_usage,
     +				   options);
     +	}
    @@ midx.h: int write_midx_file(struct odb_source *source,
      int verify_midx_file(struct odb_source *source, unsigned flags);
     
      ## t/t5334-incremental-multi-pack-index.sh ##
    -@@ t/t5334-incremental-multi-pack-index.sh: test_expect_success 'write non-incremental MIDX layer with --checksum-only' '
    - 	test_grep "cannot use --checksum-only without --incremental" err
    +@@ t/t5334-incremental-multi-pack-index.sh: test_expect_success 'write non-incremental MIDX layer with --no-write-chain-file
    + 	test_grep "cannot use --no-write-chain-file without --incremental" err
      '
      
    -+test_expect_success 'write MIDX layer with --base without --checksum-only' '
    ++test_expect_success 'write MIDX layer with --base without --no-write-chain-file' '
     +	test_must_fail git multi-pack-index write --bitmap --incremental \
     +		--base=none 2>err &&
    -+	test_grep "cannot use --base without --checksum-only" err
    ++	test_grep "cannot use --base without --no-write-chain-file" err
     +'
     +
    -+test_expect_success 'write MIDX layer with --base=none and --checksum-only' '
    ++test_expect_success 'write MIDX layer with --base=none and --no-write-chain-file' '
     +	test_commit base-none &&
     +	git repack -d &&
     +
     +	cp "$midx_chain" "$midx_chain.bak" &&
     +	layer="$(git multi-pack-index write --bitmap --incremental \
    -+		--checksum-only --base=none)" &&
    ++		--no-write-chain-file --base=none)" &&
     +
     +	test_cmp "$midx_chain.bak" "$midx_chain" &&
     +	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
     +'
     +
    -+test_expect_success 'write MIDX layer with --base=<hash> and --checksum-only' '
    ++test_expect_success 'write MIDX layer with --base=<hash> and --no-write-chain-file' '
     +	test_commit base-hash &&
     +	git repack -d &&
     +
     +	cp "$midx_chain" "$midx_chain.bak" &&
     +	layer="$(git multi-pack-index write --bitmap --incremental \
    -+		--checksum-only --base="$(nth_line 1 "$midx_chain")")" &&
    ++		--no-write-chain-file --base="$(nth_line 1 "$midx_chain")")" &&
     +
     +	test_cmp "$midx_chain.bak" "$midx_chain" &&
     +	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
    @@ t/t5334-incremental-multi-pack-index.sh: test_expect_success 'write non-incremen
      	test_expect_success "full clone (pack.allowPackReuse=$reuse)" '
     
      ## t/t5335-compact-multi-pack-index.sh ##
    -@@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with --checksum-only' '
    +@@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with --no-write-chain-file' '
      
      		layer="$(git multi-pack-index compact --incremental \
    - 			--checksum-only \
    + 			--no-write-chain-file \
     +			--base="$(nth_line 1 "$midx_chain")" \
      			"$(nth_line 2 "$midx_chain")" \
      			"$(nth_line 3 "$midx_chain")")" &&
      
    -@@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with --checksum-only' '
    +@@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with --no-write-chain-file' '
      	)
      '
      
 7:  2d377f53407 =  7:  92aba3d366f repack: track the ODB source via existing_packs
 8:  6af23849f1d =  8:  d3ac65c1f11 midx: expose `midx_layer_contains_pack()`
 9:  5c9fea0fc78 =  9:  1bd2f194c6f repack-midx: factor out `repack_prepare_midx_command()`
10:  cd5eba0f665 = 10:  44f522ea04d repack-midx: extract `repack_fill_midx_stdin_packs()`
11:  d2c667e8413 ! 11:  f5642a46bbd repack-geometry: prepare for incremental MIDX repacking
    @@ repack-geometry.c: void pack_geometry_init(struct pack_geometry *geometry,
     +			 * repacking. In either of those cases we want
     +			 * to ignore the pack.
     +			 */
    -+			if (m->num_packs > geometry->midx_layer_threshold &&
    -+			    midx_layer_contains_pack(m, pack_basename(p)))
    -+				;
    -+			else
    ++			if (m->num_packs < geometry->midx_layer_threshold ||
    ++			    !midx_layer_contains_pack(m, pack_basename(p)))
     +				continue;
     +		}
     +
    @@ repack-geometry.c: void pack_geometry_split(struct pack_geometry *geometry)
     +		/*
     +		 * During incremental MIDX/bitmap repacking, any packs
     +		 * included in the rollup are either (a) not MIDX'd, or
    -+		 * (b) contained in the tip layer iff it has more than
    ++		 * (b) contained in the tip layer iff it has at least
     +		 * the threshold number of packs.
     +		 *
     +		 * In the latter case, we can safely conclude that the
12:  56dc6d55974 = 12:  9fdcb253a96 builtin/repack.c: convert `--write-midx` to an `OPT_CALLBACK`
13:  e304e316ac4 = 13:  1e1b957bf12 packfile: ensure `close_pack_revindex()` frees in-memory revindex
14:  8d5aa3d6fa7 ! 14:  93e152fb6aa repack: implement incremental MIDX repacking
    @@ Commit message
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    + ## builtin/repack.c ##
    +@@ builtin/repack.c: static const char incremental_bitmap_conflict_error[] = N_(
    + "--no-write-bitmap-index or disable the pack.writeBitmaps configuration."
    + );
    + 
    ++#define DEFAULT_MIDX_SPLIT_FACTOR 2
    ++#define DEFAULT_MIDX_NEW_LAYER_THRESHOLD 8
    ++
    + struct repack_config_ctx {
    + 	struct pack_objects_args *po_args;
    + 	struct pack_objects_args *cruft_po_args;
    +@@ builtin/repack.c: int cmd_repack(int argc,
    + 			.show_progress = show_progress,
    + 			.write_bitmaps = write_bitmaps > 0,
    + 			.midx_must_contain_cruft = midx_must_contain_cruft,
    ++			.midx_split_factor = DEFAULT_MIDX_SPLIT_FACTOR,
    ++			.midx_new_layer_threshold = DEFAULT_MIDX_NEW_LAYER_THRESHOLD,
    + 			.mode = write_midx,
    + 		};
    + 
    +
      ## repack-midx.c ##
     @@
      #include "repack.h"
    @@ repack-midx.c: static int write_midx_included_packs(struct repack_write_midx_opt
     +	}
     +
     +	repack_prepare_midx_command(&cmd, opts, "write");
    -+	strvec_pushl(&cmd.args, "--incremental", "--checksum-only", NULL);
    ++	strvec_pushl(&cmd.args, "--incremental", "--no-write-chain-file", NULL);
     +	strvec_pushf(&cmd.args, "--base=%s", base ? base : "none");
     +
     +	if (preferred_pack) {
    @@ repack-midx.c: static int write_midx_included_packs(struct repack_write_midx_opt
     +	int ret;
     +
     +	repack_prepare_midx_command(&cmd, opts, "compact");
    -+	strvec_pushl(&cmd.args, "--incremental", "--checksum-only",
    ++	strvec_pushl(&cmd.args, "--incremental", "--no-write-chain-file",
     +		     midx_get_checksum_hex(step->u.compact.from),
     +		     midx_get_checksum_hex(step->u.compact.to), NULL);
     +
15:  e8e22d7958d ! 15:  6119f15d3e8 repack: introduce `--write-midx=incremental`
    @@ Documentation/config/repack.adoc: repack.midxMustContainCruft::
     ++
     +Adjacent layers are merged when the accumulated object count of the
     +newer layer exceeds `1/<N>` of the object count of the next deeper
    -+layer. Defaults to 2.
    ++layer. Must be at least 2. Defaults to 2.
     +
     +repack.midxNewLayerThreshold::
     +	The minimum number of packs in the tip MIDX layer before those
    @@ Documentation/config/repack.adoc: repack.midxMustContainCruft::
     ++
     +When the tip layer has fewer packs than this threshold, those packs are
     +excluded from the geometric repack entirely, and are thus left
    -+unmodified. Defaults to 8.
    ++unmodified. Must be at least 1. Defaults to 8.
     
      ## Documentation/git-repack.adoc ##
     @@ Documentation/git-repack.adoc: SYNOPSIS
    @@ builtin/repack.c: static int midx_must_contain_cruft = 1;
      };
      
     @@ builtin/repack.c: static const char incremental_bitmap_conflict_error[] = N_(
    - "--no-write-bitmap-index or disable the pack.writeBitmaps configuration."
    - );
    - 
    -+#define DEFAULT_MIDX_SPLIT_FACTOR 2
    -+#define DEFAULT_MIDX_NEW_LAYER_THRESHOLD 8
    -+
      struct repack_config_ctx {
      	struct pack_objects_args *po_args;
      	struct pack_objects_args *cruft_po_args;
    @@ builtin/repack.c: int cmd_repack(int argc,
      	if (write_bitmaps < 0) {
      		if (write_midx == REPACK_WRITE_MIDX_NONE &&
      		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
    +@@ builtin/repack.c: int cmd_repack(int argc,
    + 		write_bitmaps = 0;
    + 	}
    + 
    ++	if (config_ctx.midx_split_factor < 2)
    ++		die(_("invalid value for %s: %d"), "--midx-split-factor",
    ++		    config_ctx.midx_split_factor);
    ++	if (config_ctx.midx_new_layer_threshold < 1)
    ++		die(_("invalid value for %s: %d"), "--midx-new-layer-threshold",
    ++		    config_ctx.midx_new_layer_threshold);
    ++
    + 	if (write_midx != REPACK_WRITE_MIDX_NONE && write_bitmaps) {
    + 		struct strbuf path = STRBUF_INIT;
    + 
     @@ builtin/repack.c: int cmd_repack(int argc,
      	if (geometry.split_factor) {
      		if (pack_everything)
    @@ builtin/repack.c: int cmd_repack(int argc,
      		pack_geometry_init(&geometry, &existing, &po_args);
      		pack_geometry_split(&geometry);
      	}
    +@@ builtin/repack.c: int cmd_repack(int argc,
    + 				       packtmp);
    + 	/* End of pack replacement. */
    + 
    +-	if (delete_redundant && pack_everything & ALL_INTO_ONE)
    ++	if (delete_redundant && pack_everything & ALL_INTO_ONE) {
    ++		if (write_midx == REPACK_WRITE_MIDX_INCREMENTAL)
    ++			existing_packs_retain_midx_packs(&existing);
    + 		existing_packs_mark_for_deletion(&existing, &names);
    ++	}
    + 
    + 	if (write_midx != REPACK_WRITE_MIDX_NONE) {
    + 		struct repack_write_midx_opts opts = {
     @@ builtin/repack.c: int cmd_repack(int argc,
      			.show_progress = show_progress,
      			.write_bitmaps = write_bitmaps > 0,
      			.midx_must_contain_cruft = midx_must_contain_cruft,
    +-			.midx_split_factor = DEFAULT_MIDX_SPLIT_FACTOR,
    +-			.midx_new_layer_threshold = DEFAULT_MIDX_NEW_LAYER_THRESHOLD,
     +			.midx_split_factor = config_ctx.midx_split_factor,
     +			.midx_new_layer_threshold = config_ctx.midx_new_layer_threshold,
      			.mode = write_midx,
    @@ repack.c: void pack_objects_args_release(struct pack_objects_args *args)
      	unlink_pack_path(buf.buf, 1);
      	strbuf_release(&buf);
     @@ repack.c: void existing_packs_mark_for_deletion(struct existing_packs *existing,
    + 					   &existing->cruft_packs);
    + }
      
    ++/*
    ++ * Mark every pack that is referenced by the existing MIDX chain as
    ++ * retained, so that a subsequent call to
    ++ * existing_packs_mark_for_deletion() will not mark them for deletion.
    ++ *
    ++ * This is used when writing an incremental MIDX layer on top of an
    ++ * existing chain: retained layers continue to reference the same
    ++ * packs on disk, so those packs must not be unlinked even if the
    ++ * freshly-written pack supersedes them.
    ++ */
    ++void existing_packs_retain_midx_packs(struct existing_packs *existing)
    ++{
    ++	struct string_list_item *item;
    ++	struct strbuf buf = STRBUF_INIT;
    ++
    ++	for_each_string_list_item(item, &existing->midx_packs) {
    ++		struct string_list_item *found;
    ++
    ++		strbuf_reset(&buf);
    ++		strbuf_addstr(&buf, item->string);
    ++		strbuf_strip_suffix(&buf, ".pack");
    ++		strbuf_strip_suffix(&buf, ".idx");
    ++
    ++		found = string_list_lookup(&existing->non_kept_packs, buf.buf);
    ++		if (found)
    ++			existing_packs_mark_retained(found);
    ++
    ++		found = string_list_lookup(&existing->cruft_packs, buf.buf);
    ++		if (found)
    ++			existing_packs_mark_retained(found);
    ++	}
    ++
    ++	strbuf_release(&buf);
    ++}
    ++
      static void remove_redundant_packs_1(struct repository *repo,
      				     struct string_list *packs,
     -				     const char *packdir)
    @@ repack.h: void prepare_pack_objects(struct child_process *cmd,
      struct write_pack_opts {
      	struct pack_objects_args *po_args;
     @@ repack.h: void existing_packs_retain_cruft(struct existing_packs *existing,
    + 				 struct packed_git *cruft);
      void existing_packs_mark_for_deletion(struct existing_packs *existing,
      				      struct string_list *names);
    ++void existing_packs_retain_midx_packs(struct existing_packs *existing);
      void existing_packs_remove_redundant(struct existing_packs *existing,
     -				     const char *packdir);
     +				     const char *packdir,
    @@ t/t7705-repack-incremental-midx.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'repack -ad --write-midx=incremental is safe' '
    ++	git init ad-incremental-midx &&
    ++	(
    ++		cd ad-incremental-midx &&
    ++
    ++		git config maintenance.auto false &&
    ++
    ++		# Build a MIDX chain with multiple layers referencing
    ++		# distinct packs.
    ++		test_commit first &&
    ++		git repack -d &&
    ++
    ++		test_commit second &&
    ++		git repack -d --write-midx=incremental &&
    ++
    ++		git multi-pack-index verify &&
    ++		test_line_count = 1 $midx_chain &&
    ++
    ++		# Now do a full -ad repack. The new pack contains all
    ++		# objects, but any retained MIDX layers still reference
    ++		# the now-deleted packs.
    ++		test_commit third &&
    ++		git repack -ad --write-midx=incremental &&
    ++
    ++		git multi-pack-index verify &&
    ++		git fsck &&
    ++		git rev-list --all --objects >/dev/null
    ++	)
    ++'
    ++
    ++test_expect_success 'repack rejects invalid midxSplitFactor' '
    ++	test_when_finished "rm -fr bad-split-factor" &&
    ++	git init bad-split-factor &&
    ++	(
    ++		cd bad-split-factor &&
    ++		test_commit base &&
    ++
    ++		for v in 0 1 -1
    ++		do
    ++			test_must_fail git -c repack.midxSplitFactor=$v \
    ++				repack -d --geometric=2 --write-midx=incremental 2>err &&
    ++			test_grep "invalid value for --midx-split-factor" err ||
    ++			return 1
    ++		done
    ++	)
    ++'
    ++
    ++test_expect_success 'repack rejects invalid midxNewLayerThreshold' '
    ++	test_when_finished "rm -fr bad-layer-threshold" &&
    ++	git init bad-layer-threshold &&
    ++	(
    ++		cd bad-layer-threshold &&
    ++		test_commit base &&
    ++
    ++		for v in 0 -1
    ++		do
    ++			test_must_fail git -c repack.midxNewLayerThreshold=$v \
    ++				repack -d --geometric=2 --write-midx=incremental 2>err &&
    ++			test_grep "invalid value for --midx-new-layer-threshold" err ||
    ++			return 1
    ++		done
    ++	)
    ++'
    ++
     +test_done
16:  79d5a12a390 = 16:  d9acef1334a repack: allow `--write-midx=incremental` without `--geometric`

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
2.54.0.9.gb905fd5d0ae
