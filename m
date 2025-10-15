Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6472D23B8
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567223; cv=none; b=Tv0cgeMdTor3jfj73mcoZ7alZv5x17A5xCT3c7anaA9VphTjhTHVJ/UFvs0miEgrnnUz4Ouf9FORy3tK8NvhJkBfy5CkrW7ir05CZCPZpImsqEI1YUpBm+v1/IdVXZkpLRrH9deRga77AR9k1Z5c1IZlU0Rcl5GAXpLEdaVwGfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567223; c=relaxed/simple;
	bh=iSBZ8SK4zzMxcHQ/tmew2FXBpx8yZBhYMNMgPd9G4wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz3o75rU4SCqS4dvj66GkdScdMzXSlP1yxwbgTu9/NK8+uuFgvCzRmhr+B8hz0xT18eIVbOhrZgmZ5WmuBtpoZvkPr0YqDS9/wNwd140OAtiMQhcee+4efklHA7xq2TWtyfJNKq2Jb1pDO1qtFbsOaNArvbGKCxXpCxnCAggm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=fTSWx4e1; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="fTSWx4e1"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-71d71bcab69so867757b3.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567219; x=1761172019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ps0mhbVR2ZNOuydKs7f96cObhaUVk0E1YWSZ8tu284k=;
        b=fTSWx4e1jWwX6TBui4zzaHUxjjgU2Be7EGhBrxVRiWHEAtN5BJoXxdJUhJa/7Yn/7L
         Ih2dKE+7U8aiOTVnk45IvkL2J9o48RnuYCb+O997BwY2WOO/ElV8teiy5sPU5Zifj7nx
         4kBncDJ3mb6Ei9N781g43fvnoRhMtq6eSdtvix+X9FnmPAIBa9+iJk2luOWI2JWrUub6
         snNHn8AKrK4hvue/hzAmf9EUpC9eVni9LOx2GeBo16rZcYydN2XoZYPLcY8R8Te0zATg
         h2kreMnenKvveOiLTaJvq0ZgXALpTVO9l57iN0D5wbj13Z76ggZ1vap2r4qOwJdPnODi
         j1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567219; x=1761172019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ps0mhbVR2ZNOuydKs7f96cObhaUVk0E1YWSZ8tu284k=;
        b=nVx8OX8+dBOlZu+aQhqDVM10CjR/sXKvGp1RYIs274R8KNeJ3wtkMppamMRAWEIIoi
         xWA7iM13lI7BgAWF0eonDw2kQxrYIe6fQrn2x4l8xFc2ueSxO1B32QouUOmFraMnppGQ
         jXPQNDBlsi7rLQ5/QO/hGzu6W6Kgrl6L5Emrou5r9VaX4239AfNQbC0L9e2b1qqFPE6B
         OP8Ox9sFDQg+d3FLQAU4odbfCejHLUYoBnp9n1CHMOtc4casOjdRaqGq9BiVGN6OGnyw
         pKPf33F/tHFel7/krSZDG9OZbGxUgiGJ9jwPjC5QBvrDUvPoRAj/ShWHIuWAnZvRQDxK
         dRVA==
X-Gm-Message-State: AOJu0YzhLwCaMAvbsoMYiHXALo4Ok/gLVqkXOesGIcFJYNWpdWaiYzZz
	qpz77Ftytm5QbuBejc8SHNgaGxfoUh/+qho45akm95Yi2y/xQNjI3BCKpfHk2IpX6NoG0BKuqNw
	S638Ax8bcDizt
X-Gm-Gg: ASbGncvaZaQtH92S1JM+GZo/ETMvUPV07DLgd9D7TZIuoj3Kkc9oCulcv2vrC1pV4nr
	yJs0tubo0NXFj+Llz0pdyZsL5M0SenqQBkQzfbqZh47pfdSKXNXOQ9ll9nKXDCkxon7k0sEPdPN
	ksA9z1JIuRcqnlnNql8JizV2p6dwusshaWwqrhkmgkrajqkBhq70ft12eVivZ0zywvKP8PtstCh
	gDNVta08S0XglufplwN526OlNpua0rtX6pPZ5Fs9oAt6gOm+nGiCadPTDH01RoIF7qrImh3olbI
	5cLGapXuXDiwwuIcT9Y1ddPJNurAKq9Vl6vt9lsmRFE4x1oGYtRDYOhOgosXQfEe77iX9992A/D
	UUbkJAYZxQoXlPm+7Uq230NeYmXeD6gtnSEHBfRCoZGODQwew7hdodsJkm++TzIm2zUSEYqnfxu
	7PfMFAN+MA+cij1PPI3Hfsdh4pcWnu+Igda3NFOVrh4O1vc8AOOHALPD74WRen1wnbGtoMxfhIy
	T2epfEw/q+sTC26ig==
X-Google-Smtp-Source: AGHT+IHQFrww8OVWffsnvF3TzFyoUJdIQzs4zlA7cqdA6tmxJBZI5QfXvdPA1+AvAzww82rKffLVTA==
X-Received: by 2002:a05:690c:e1a:b0:762:a002:51 with SMTP id 00721157ae682-780e1478c59mr325378907b3.22.1760567219366;
        Wed, 15 Oct 2025 15:26:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78290c61527sm2640887b3.7.2025.10.15.15.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:26:59 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:26:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 00/49] repack: prepare for incremental MIDX-based repacking
Message-ID: <cover.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Note to the maintainer:

 * This series has been rebased on to 'master' (which is 4b71b29477
   (The seventeenth batch, 2025-10-10) at the time of writing) to
   avoid semantic conflicts now that ps/packfile-store has been
   merged.

This is a relatively small reroll of my series to clean up the repack
builtin by introducing a repack.h API, which is the first of ~three
series that will implement incremental MIDX/bitmap-based repacking.

A range-diff is included below for convenience, but the changes since
v1 are generally limited to the following:

 * Wording tweaks and a couple of minor typo fixes.

 * Dropping explicit casts out of 'void *'.

 * Clarification in commit "builtin/repack.c: introduce `struct
   write_pack_opts`" that additional cleanup follows in the upcoming
   patches.

 * Marking parts of the new API as const where possible.

 * Using 'bool' as the return type and simplifying the implementation
   of `write_pack_opts_is_local()`.

 * Avoid shadowing "struct write_pack_opts opts" in `cmd_repack()`.

Outside of that, the series is unchanged, and I am hopeful that this
round looks good to reviewers so that we can move on to the more
interesting parts of incremental MIDX/bitmap repacking ;-).

Thanks in advance for your (re-)review!

Taylor Blau (49):
  builtin/repack.c: avoid "the_repository" in `cmd_repack()`
  builtin/repack.c: avoid "the_repository" in existing packs API
  builtin/repack.c: avoid "the_repository" when taking a ref snapshot
  builtin/repack.c: avoid "the_repository" when removing packs
  builtin/repack.c: avoid "the_repository" when repacking promisor
    objects
  builtin/repack.c: avoid "the_hash_algo" when deleting packs
  builtin/repack.c: avoid "the_hash_algo" in `write_oid()`
  builtin/repack: avoid "the_hash_algo" in `repack_promisor_objects()`
  builtin/repack.c: avoid "the_hash_algo" in `finish_pack_objects_cmd()`
  builtin/repack.c: avoid using `hash_to_hex()` in pack geometry
  repack: introduce new compilation unit
  builtin/repack.c: pass both pack_objects args to repack_config
  repack: move 'delta_base_offset' to 'struct pack_objects_args'
  repack: remove 'prepare_pack_objects' from the builtin
  builtin/repack.c: rename many 'struct existing_packs' functions
  repack: remove 'remove_redundant_pack' from the builtin
  builtin/repack.c: pass "packdir" when removing packs
  builtin/repack.c: avoid unnecessary numeric casts in existing_packs
  repack: remove 'existing_packs' API from the builtin
  builtin/repack.c: rename "struct generated_pack_data"
  builtin/repack.c: factor out "generated_pack_install"
  builtin/repack.c: pass "packtmp" to `generated_pack_populate()`
  builtin/repack.c: provide pack locations to `generated_pack_install()`
  repack: remove 'generated_pack' API from the builtin
  builtin/repack.c: pass "packtmp" to `repack_promisor_objects()`
  builtin/repack.c: remove "repack_promisor_objects()" from the builtin
  builtin/repack.c: rename various pack_geometry functions
  builtin/repack.c: pass 'pack_kept_objects' to `pack_geometry_init()`
  builtin/repack.c: pass 'packdir' to `pack_geometry_remove_redundant()`
  repack: remove pack_geometry API from the builtin
  builtin/repack.c: remove ref snapshotting from builtin
  builtin/repack.c: extract opts struct for
    'write_midx_included_packs()'
  builtin/repack.c: use a string_list for 'midx_pack_names'
  repack: keep track of MIDX pack names using existing_packs
  builtin/repack.c: reorder `remove_redundant_bitmaps()`
  builtin/repack.c: inline `remove_redundant_bitmaps()`
  builtin/repack.c: pass `repack_write_midx_opts` to
    `midx_included_packs`
  builtin/repack.c: inline packs within `write_midx_included_packs()`
  repack: 'write_midx_included_packs' API from the builtin
  builtin/repack.c: introduce `struct write_pack_opts`
  builtin/repack.c: use `write_pack_opts` within `write_cruft_pack()`
  repack: move `find_pack_prefix()` out of the builtin
  repack: extract `write_pack_opts_is_local()`
  builtin/repack.c: pass `write_pack_opts` to
    `finish_pack_objects_cmd()`
  repack: move `finish_pack_objects_cmd()` out of the builtin
  repack: move `pack_kept_objects` to `struct pack_objects_args`
  repack: move `write_filtered_pack()` out of the builtin
  repack: move `write_cruft_pack()` out of the builtin
  builtin/repack.c: clean up unused `#include`s

 Makefile          |    6 +
 builtin/repack.c  | 1356 +++------------------------------------------
 meson.build       |    6 +
 repack-cruft.c    |   99 ++++
 repack-filtered.c |   51 ++
 repack-geometry.c |  233 ++++++++
 repack-midx.c     |  372 +++++++++++++
 repack-promisor.c |  102 ++++
 repack.c          |  360 ++++++++++++
 repack.h          |  146 +++++
 10 files changed, 1467 insertions(+), 1264 deletions(-)
 create mode 100644 repack-cruft.c
 create mode 100644 repack-filtered.c
 create mode 100644 repack-geometry.c
 create mode 100644 repack-midx.c
 create mode 100644 repack-promisor.c
 create mode 100644 repack.c
 create mode 100644 repack.h

Range-diff against v1:
 1:  aa03aea8ed =  1:  fc2b686c49 builtin/repack.c: avoid "the_repository" in `cmd_repack()`
 2:  664a67c936 =  2:  14a65d7c6d builtin/repack.c: avoid "the_repository" in existing packs API
 3:  866e43b0cd =  3:  ff72cd499b builtin/repack.c: avoid "the_repository" when taking a ref snapshot
 4:  f404dfa34f =  4:  75f23ba211 builtin/repack.c: avoid "the_repository" when removing packs
 5:  6190eeb066 =  5:  0914ca113f builtin/repack.c: avoid "the_repository" when repacking promisor objects
 6:  2f97882ace =  6:  238f3d87a0 builtin/repack.c: avoid "the_hash_algo" when deleting packs
 7:  37a7dea848 =  7:  ca3c8a782a builtin/repack.c: avoid "the_hash_algo" in `write_oid()`
 8:  f5a87f2a65 =  8:  34b503618a builtin/repack: avoid "the_hash_algo" in `repack_promisor_objects()`
 9:  f16dfbf0c7 =  9:  cd43a60620 builtin/repack.c: avoid "the_hash_algo" in `finish_pack_objects_cmd()`
10:  de4886466c = 10:  c6787c865d builtin/repack.c: avoid using `hash_to_hex()` in pack geometry
11:  fe3328eb3d = 11:  87f2903e75 repack: introduce new compilation unit
12:  75386eed60 = 12:  a812bd3dcb builtin/repack.c: pass both pack_objects args to repack_config
13:  06347b6ab2 = 13:  f2d1fa51e3 repack: move 'delta_base_offset' to 'struct pack_objects_args'
14:  2d9022385d = 14:  0c32c3c9b6 repack: remove 'prepare_pack_objects' from the builtin
15:  02e26f78ac = 15:  a9767dc42d builtin/repack.c: rename many 'struct existing_packs' functions
16:  d0a40e8e57 = 16:  4edbcb5893 repack: remove 'remove_redundant_pack' from the builtin
17:  df75c3130b = 17:  4e2a152ebb builtin/repack.c: pass "packdir" when removing packs
18:  f413f958eb = 18:  46aa154b76 builtin/repack.c: avoid unnecessary numeric casts in existing_packs
19:  ae267fcc82 ! 19:  0c6dea2800 repack: remove 'existing_packs' API from the builtin
    @@ Commit message
         end of a repack operation.
     
         Now that the prerequisite refactoring is complete, this API is isolated
    -    enough that it can be moved out to repack.ch and removed from the
    +    enough that it can be moved out to repack.[ch] and removed from the
         builtin entirely.
     
         As a result, some of its functions become static within repack.c,
20:  ee3e1233f5 = 20:  53d5b1053f builtin/repack.c: rename "struct generated_pack_data"
21:  96d27261e7 ! 21:  196b92d052 builtin/repack.c: factor our "generated_pack_install"
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    builtin/repack.c: factor our "generated_pack_install"
    +    builtin/repack.c: factor out "generated_pack_install"
     
         Once all new packs are known to exist, 'repack' installs their contents
         from their temporary location into their permanent one. This is a
    @@ builtin/repack.c: int cmd_repack(int argc,
     -		}
     -	}
     +	for_each_string_list_item(item, &names)
    -+		generated_pack_install((struct generated_pack *)item->util,
    -+				       item->string);
    ++		generated_pack_install(item->util, item->string);
      	/* End of pack replacement. */
      
      	if (delete_redundant && pack_everything & ALL_INTO_ONE)
22:  ab0dc66683 = 22:  acd9a83ed0 builtin/repack.c: pass "packtmp" to `generated_pack_populate()`
23:  e9d525d83a ! 23:  2b81a26a84 builtin/repack.c: provide pack locations to `generated_pack_install()`
    @@ builtin/repack.c: static int generated_pack_has_ext(const struct generated_pack
      	int ext;
      	for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
     @@ builtin/repack.c: int cmd_repack(int argc,
    + 	 * Ok we have prepared all new packfiles.
      	 */
      	for_each_string_list_item(item, &names)
    - 		generated_pack_install((struct generated_pack *)item->util,
    --				       item->string);
    -+				       item->string, packdir, packtmp);
    +-		generated_pack_install(item->util, item->string);
    ++		generated_pack_install(item->util, item->string, packdir,
    ++				       packtmp);
      	/* End of pack replacement. */
      
      	if (delete_redundant && pack_everything & ALL_INTO_ONE)
24:  9979b77979 = 24:  69003f4561 repack: remove 'generated_pack' API from the builtin
25:  67effcb4ea = 25:  ca030322cf builtin/repack.c: pass "packtmp" to `repack_promisor_objects()`
26:  3ba6e86f61 ! 26:  1050b856a5 builtin/repack.c: remove "repack_promisor_objects()" from the builtin
    @@ repack-promisor.c (new)
     @@
     +#include "git-compat-util.h"
     +#include "repack.h"
    -+#include "run-command.h"
     +#include "hex.h"
    -+#include "repository.h"
    ++#include "pack.h"
     +#include "packfile.h"
     +#include "path.h"
    -+#include "pack.h"
    ++#include "repository.h"
    ++#include "run-command.h"
     +
     +struct write_oid_context {
     +	struct child_process *cmd;
27:  dd67366476 ! 27:  0b2fa0cf62 builtin/repack.c: rename various pack_geometry functions
    @@ Commit message
         builtin/repack.c: rename various pack_geometry functions
     
         Rename functions which work with 'struct pack_geometry' to begin with
    -    "pack_geometry_".
    +    "pack_geometry_". While we're at it, change `free_pack_geometry()` to
    +    instead be named `pack_geometry_release()` to match our conventions, and
    +    make clear that that function frees the contents of the struct, not the
    +    memory allocated to hold the struct itself.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
28:  8408fd8474 = 28:  a3d99c4852 builtin/repack.c: pass 'pack_kept_objects' to `pack_geometry_init()`
29:  76be98b386 = 29:  0a2a72ea22 builtin/repack.c: pass 'packdir' to `pack_geometry_remove_redundant()`
30:  54a2feaea9 ! 30:  9172e9a515 repack: remove pack_geometry API from the builtin
    @@ repack-geometry.c (new)
     +
     +#include "git-compat-util.h"
     +#include "repack.h"
    ++#include "repository.h"
     +#include "hex.h"
     +#include "packfile.h"
     +
31:  06ca4ab5b7 = 31:  5b15d83e65 builtin/repack.c: remove ref snapshotting from builtin
32:  3b7e204a40 = 32:  077f06c935 builtin/repack.c: extract opts struct for 'write_midx_included_packs()'
33:  8844529759 = 33:  40ce496de2 builtin/repack.c: use a string_list for 'midx_pack_names'
34:  ccf2c6a517 = 34:  ec3a8a7dd2 repack: keep track of MIDX pack names using existing_packs
35:  85d229fff5 = 35:  8042860b26 builtin/repack.c: reorder `remove_redundant_bitmaps()`
36:  2bf732009a = 36:  af06f60e63 builtin/repack.c: inline `remove_redundant_bitmaps()`
37:  60659a7549 = 37:  668f4edc9e builtin/repack.c: pass `repack_write_midx_opts` to `midx_included_packs`
38:  c2c7ca9f9e ! 38:  5bd43e96f2 builtin/repack.c: inline packs within `write_midx_included_packs()`
    @@ Commit message
                 write_midx_included_packs(&included_packs, ...);
             }
     
    -    in the future, let's have each function which writes a MIDX be
    +    in the future, let's have each function that writes a MIDX be
         responsible for itself computing the list of included packs. Inline the
         declaration and initialization of `included_packs` into the
         `write_midx_included_packs()` function itself, and repeat that pattern
39:  c28891443b = 39:  794122266d repack: 'write_midx_included_packs' API from the builtin
40:  1091096186 ! 40:  0cb6e78856 builtin/repack.c: introduce `struct write_pack_opts`
    @@ Commit message
         of the same type, and provide a unified interface for the two functions
         mentioned earlier.
     
    +    (Note that "pack_prefix" can be derived on the fly as a function of
    +    "packdir" and "packtmp", making it unnecessary to store "pack_prefix"
    +    explicitly. This commit ignores that potential cleanup in the name of
    +    doing as few things as possible, but a later commit will make that
    +    change.)
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## builtin/repack.c ##
    @@ builtin/repack.c: static int finish_pack_objects_cmd(const struct git_hash_algo
     -static int write_filtered_pack(const struct pack_objects_args *args,
     -			       const char *destination,
     -			       const char *pack_prefix,
    -+static int write_filtered_pack(struct write_pack_opts *opts,
    ++static int write_filtered_pack(const struct write_pack_opts *opts,
      			       struct existing_packs *existing,
      			       struct string_list *names)
      {
41:  7826afc173 ! 41:  1a9b578fdd builtin/repack.c: use `write_pack_opts` within `write_cruft_pack()`
    @@ builtin/repack.c: static void combine_small_cruft_packs(FILE *in, size_t combine
     -static int write_cruft_pack(const struct pack_objects_args *args,
     -			    const char *destination,
     -			    const char *pack_prefix,
    -+static int write_cruft_pack(struct write_pack_opts *opts,
    ++static int write_cruft_pack(const struct write_pack_opts *opts,
      			    const char *cruft_expiration,
      			    unsigned long combine_cruft_below_size,
      			    struct string_list *names,
42:  c50ffce078 ! 42:  43116b8942 repack: move `find_pack_prefix()` out of the builtin
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## builtin/repack.c ##
    -@@ builtin/repack.c: static int write_filtered_pack(struct write_pack_opts *opts,
    +@@ builtin/repack.c: static int write_filtered_pack(const struct write_pack_opts *opts,
      	const char *caret;
      	const char *scratch;
      	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
    @@ builtin/repack.c: static int write_filtered_pack(struct write_pack_opts *opts,
      
      	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
      
    -@@ builtin/repack.c: static int write_filtered_pack(struct write_pack_opts *opts,
    +@@ builtin/repack.c: static int write_filtered_pack(const struct write_pack_opts *opts,
      	 */
      	in = xfdopen(cmd.in, "w");
      	for_each_string_list_item(item, names)
    @@ builtin/repack.c: static int write_filtered_pack(struct write_pack_opts *opts,
      	for_each_string_list_item(item, &existing->non_kept_packs)
      		fprintf(in, "%s.pack\n", item->string);
      	for_each_string_list_item(item, &existing->cruft_packs)
    -@@ builtin/repack.c: static int write_cruft_pack(struct write_pack_opts *opts,
    +@@ builtin/repack.c: static int write_cruft_pack(const struct write_pack_opts *opts,
      	int ret;
      	const char *scratch;
      	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
    @@ builtin/repack.c: static int write_cruft_pack(struct write_pack_opts *opts,
      
      	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
      
    -@@ builtin/repack.c: static int write_cruft_pack(struct write_pack_opts *opts,
    +@@ builtin/repack.c: static int write_cruft_pack(const struct write_pack_opts *opts,
      	 */
      	in = xfdopen(cmd.in, "w");
      	for_each_string_list_item(item, names)
    @@ builtin/repack.c: static int write_cruft_pack(struct write_pack_opts *opts,
      	if (combine_cruft_below_size && !cruft_expiration) {
      		combine_small_cruft_packs(in, combine_cruft_below_size,
      					  existing);
    -@@ builtin/repack.c: static int write_cruft_pack(struct write_pack_opts *opts,
    +@@ builtin/repack.c: static int write_cruft_pack(const struct write_pack_opts *opts,
      				       local);
      }
      
    @@ repack.c: void repack_remove_redundant_pack(struct repository *repo, const char
      	strbuf_release(&buf);
      }
      
    -+const char *write_pack_opts_pack_prefix(struct write_pack_opts *opts)
    ++const char *write_pack_opts_pack_prefix(const struct write_pack_opts *opts)
     +{
     +	const char *pack_prefix;
     +	if (!skip_prefix(opts->packtmp, opts->packdir, &pack_prefix))
    @@ repack.h: void repack_remove_redundant_pack(struct repository *repo, const char
      	const char *packtmp;
      };
      
    -+const char *write_pack_opts_pack_prefix(struct write_pack_opts *opts);
    ++const char *write_pack_opts_pack_prefix(const struct write_pack_opts *opts);
     +
      struct repository;
      struct packed_git;
43:  1fbe3d0d7f ! 43:  5e3b615993 repack: extract `write_pack_opts_is_local()`
    @@ Commit message
     
         Extract that function and make it visible within the repack.h API, and
         use it within both `write_cruft_pack()` and `write_filtered_pack()`.
    +    While we're at it, match our modern conventions by returning a "bool"
    +    instead of "int", and use `starts_with()` instead of `skip_prefix()` to
    +    avoid storing the dummy "scratch" variable.
     
         The remaining duplication (that is, that both `write_cruft_pack()` and
         `write_filtered_pack()` still both call `write_pack_opts_is_local()`)
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## builtin/repack.c ##
    -@@ builtin/repack.c: static int write_filtered_pack(struct write_pack_opts *opts,
    +@@ builtin/repack.c: static int write_filtered_pack(const struct write_pack_opts *opts,
      	FILE *in;
      	int ret;
      	const char *caret;
     -	const char *scratch;
     -	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
    -+	int local = write_pack_opts_is_local(opts);
    ++	bool local = write_pack_opts_is_local(opts);
      	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
      
      	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
    -@@ builtin/repack.c: static int write_cruft_pack(struct write_pack_opts *opts,
    +@@ builtin/repack.c: static int write_cruft_pack(const struct write_pack_opts *opts,
      	struct string_list_item *item;
      	FILE *in;
      	int ret;
     -	const char *scratch;
     -	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
    -+	int local = write_pack_opts_is_local(opts);
    ++	bool local = write_pack_opts_is_local(opts);
      	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
      
      	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
     
      ## repack.c ##
    -@@ repack.c: const char *write_pack_opts_pack_prefix(struct write_pack_opts *opts)
    +@@ repack.c: const char *write_pack_opts_pack_prefix(const struct write_pack_opts *opts)
      	return pack_prefix;
      }
      
    -+int write_pack_opts_is_local(struct write_pack_opts *opts)
    ++bool write_pack_opts_is_local(const struct write_pack_opts *opts)
     +{
    -+	const char *scratch;
    -+	return skip_prefix(opts->destination, opts->packdir, &scratch);
    ++	return starts_with(opts->destination, opts->packdir);
     +}
     +
      #define DELETE_PACK 1
    @@ repack.h
     @@ repack.h: struct write_pack_opts {
      };
      
    - const char *write_pack_opts_pack_prefix(struct write_pack_opts *opts);
    -+int write_pack_opts_is_local(struct write_pack_opts *opts);
    + const char *write_pack_opts_pack_prefix(const struct write_pack_opts *opts);
    ++bool write_pack_opts_is_local(const struct write_pack_opts *opts);
      
      struct repository;
      struct packed_git;
44:  11f78993f1 ! 44:  fcbe44d8bb builtin/repack.c: pass `write_pack_opts` to `finish_pack_objects_cmd()`
    @@ builtin/repack.c: static int repack_config(const char *var, const char *value,
      }
      
      static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
    -+				   struct write_pack_opts *opts,
    ++				   const struct write_pack_opts *opts,
      				   struct child_process *cmd,
     -				   struct string_list *names,
     -				   int local)
     +				   struct string_list *names)
      {
      	FILE *out;
    -+	int local = write_pack_opts_is_local(opts);
    ++	bool local = write_pack_opts_is_local(opts);
      	struct strbuf line = STRBUF_INIT;
      
      	out = xfdopen(cmd->out, "r");
    @@ builtin/repack.c: static int finish_pack_objects_cmd(const struct git_hash_algo
      		}
      	}
      	fclose(out);
    -@@ builtin/repack.c: static int write_filtered_pack(struct write_pack_opts *opts,
    +@@ builtin/repack.c: static int write_filtered_pack(const struct write_pack_opts *opts,
      	FILE *in;
      	int ret;
      	const char *caret;
    --	int local = write_pack_opts_is_local(opts);
    +-	bool local = write_pack_opts_is_local(opts);
      	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
      
      	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
    -@@ builtin/repack.c: static int write_filtered_pack(struct write_pack_opts *opts,
    +@@ builtin/repack.c: static int write_filtered_pack(const struct write_pack_opts *opts,
      		fprintf(in, "%s%s.pack\n", caret, item->string);
      	fclose(in);
      
    @@ builtin/repack.c: static int write_filtered_pack(struct write_pack_opts *opts,
      }
      
      static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
    -@@ builtin/repack.c: static int write_cruft_pack(struct write_pack_opts *opts,
    +@@ builtin/repack.c: static int write_cruft_pack(const struct write_pack_opts *opts,
      	struct string_list_item *item;
      	FILE *in;
      	int ret;
    --	int local = write_pack_opts_is_local(opts);
    +-	bool local = write_pack_opts_is_local(opts);
      	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
      
      	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
    -@@ builtin/repack.c: static int write_cruft_pack(struct write_pack_opts *opts,
    +@@ builtin/repack.c: static int write_cruft_pack(const struct write_pack_opts *opts,
      		fprintf(in, "%s.pack\n", item->string);
      	fclose(in);
      
    @@ builtin/repack.c: static int write_cruft_pack(struct write_pack_opts *opts,
      }
      
      int cmd_repack(int argc,
    -@@ builtin/repack.c: int cmd_repack(int argc,
    - 	struct existing_packs existing = EXISTING_PACKS_INIT;
    - 	struct pack_geometry geometry = { 0 };
    - 	struct tempfile *refs_snapshot = NULL;
    -+	struct write_pack_opts opts = { 0 };
    - 	int i, ret;
    - 	int show_progress;
    - 
     @@ builtin/repack.c: int cmd_repack(int argc,
      		fclose(in);
      	}
      
     -	ret = finish_pack_objects_cmd(repo->hash_algo, &cmd, &names, 1);
    -+	opts.packdir = packdir;
    -+	opts.destination = packdir;
    -+	opts.packtmp = packtmp;
    -+	ret = finish_pack_objects_cmd(repo->hash_algo, &opts, &cmd, &names);
    - 	if (ret)
    - 		goto cleanup;
    +-	if (ret)
    +-		goto cleanup;
    ++	{
    ++		struct write_pack_opts opts = {
    ++			.packdir = packdir,
    ++			.destination = packdir,
    ++			.packtmp = packtmp,
    ++		};
    ++		ret = finish_pack_objects_cmd(repo->hash_algo, &opts, &cmd,
    ++					      &names);
    ++		if (ret)
    ++			goto cleanup;
    ++	}
      
    + 	if (!names.nr) {
    + 		if (!po_args.quiet)
45:  a38d14e411 ! 45:  244260c6ab repack: move `finish_pack_objects_cmd()` out of the builtin
    @@ builtin/repack.c: static int repack_config(const char *var, const char *value,
      }
      
     -static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
    --				   struct write_pack_opts *opts,
    +-				   const struct write_pack_opts *opts,
     -				   struct child_process *cmd,
     -				   struct string_list *names)
     -{
     -	FILE *out;
    --	int local = write_pack_opts_is_local(opts);
    +-	bool local = write_pack_opts_is_local(opts);
     -	struct strbuf line = STRBUF_INIT;
     -
     -	out = xfdopen(cmd->out, "r");
    @@ builtin/repack.c: static int repack_config(const char *var, const char *value,
     -	return finish_command(cmd);
     -}
     -
    - static int write_filtered_pack(struct write_pack_opts *opts,
    + static int write_filtered_pack(const struct write_pack_opts *opts,
      			       struct existing_packs *existing,
      			       struct string_list *names)
     
      ## repack.c ##
    -@@ repack.c: int write_pack_opts_is_local(struct write_pack_opts *opts)
    - 	return skip_prefix(opts->destination, opts->packdir, &scratch);
    +@@ repack.c: bool write_pack_opts_is_local(const struct write_pack_opts *opts)
    + 	return starts_with(opts->destination, opts->packdir);
      }
      
     +int finish_pack_objects_cmd(const struct git_hash_algo *algop,
    -+			    struct write_pack_opts *opts,
    ++			    const struct write_pack_opts *opts,
     +			    struct child_process *cmd,
     +			    struct string_list *names)
     +{
     +	FILE *out;
    -+	int local = write_pack_opts_is_local(opts);
    ++	bool local = write_pack_opts_is_local(opts);
     +	struct strbuf line = STRBUF_INIT;
     +
     +	out = xfdopen(cmd->out, "r");
    @@ repack.c: int write_pack_opts_is_local(struct write_pack_opts *opts)
     
      ## repack.h ##
     @@ repack.h: struct write_pack_opts {
    - const char *write_pack_opts_pack_prefix(struct write_pack_opts *opts);
    - int write_pack_opts_is_local(struct write_pack_opts *opts);
    + const char *write_pack_opts_pack_prefix(const struct write_pack_opts *opts);
    + bool write_pack_opts_is_local(const struct write_pack_opts *opts);
      
     +int finish_pack_objects_cmd(const struct git_hash_algo *algop,
    -+			    struct write_pack_opts *opts,
    ++			    const struct write_pack_opts *opts,
     +			    struct child_process *cmd,
     +			    struct string_list *names);
     +
46:  2d9a879bb0 ! 46:  dbc317af27 repack: move `pack_kept_objects` to `struct pack_objects_args`
    @@ builtin/repack.c: static int repack_config(const char *var, const char *value,
      		return 0;
      	}
      	if (!strcmp(var, "repack.writebitmaps") ||
    -@@ builtin/repack.c: static int write_filtered_pack(struct write_pack_opts *opts,
    +@@ builtin/repack.c: static int write_filtered_pack(const struct write_pack_opts *opts,
      
      	strvec_push(&cmd.args, "--stdin-packs");
      
    @@ builtin/repack.c: static int write_filtered_pack(struct write_pack_opts *opts,
      	for_each_string_list_item(item, &existing->kept_packs)
      		strvec_pushf(&cmd.args, "--keep-pack=%s", item->string);
      
    -@@ builtin/repack.c: static int write_filtered_pack(struct write_pack_opts *opts,
    +@@ builtin/repack.c: static int write_filtered_pack(const struct write_pack_opts *opts,
      		fprintf(in, "%s.pack\n", item->string);
      	for_each_string_list_item(item, &existing->cruft_packs)
      		fprintf(in, "%s.pack\n", item->string);
    @@ builtin/repack.c: static int write_filtered_pack(struct write_pack_opts *opts,
      	for_each_string_list_item(item, &existing->kept_packs)
      		fprintf(in, "%s%s.pack\n", caret, item->string);
      	fclose(in);
    -@@ builtin/repack.c: static int write_cruft_pack(struct write_pack_opts *opts,
    +@@ builtin/repack.c: static int write_cruft_pack(const struct write_pack_opts *opts,
      		strvec_pushf(&cmd.args, "--cruft-expiration=%s",
      			     cruft_expiration);
      
47:  d0df139717 ! 47:  7523345056 repack: move `write_filtered_pack()` out of the builtin
    @@ builtin/repack.c: static int repack_config(const char *var, const char *value,
      	return git_default_config(var, value, ctx, cb);
      }
      
    --static int write_filtered_pack(struct write_pack_opts *opts,
    +-static int write_filtered_pack(const struct write_pack_opts *opts,
     -			       struct existing_packs *existing,
     -			       struct string_list *names)
     -{
    @@ repack-filtered.c (new)
     +#include "run-command.h"
     +#include "string-list.h"
     +
    -+int write_filtered_pack(struct write_pack_opts *opts,
    ++int write_filtered_pack(const struct write_pack_opts *opts,
     +			struct existing_packs *existing,
     +			struct string_list *names)
     +{
    @@ repack.h: struct repack_write_midx_opts {
      void midx_snapshot_refs(struct repository *repo, struct tempfile *f);
      int write_midx_included_packs(struct repack_write_midx_opts *opts);
      
    -+int write_filtered_pack(struct write_pack_opts *opts,
    ++int write_filtered_pack(const struct write_pack_opts *opts,
     +			struct existing_packs *existing,
     +			struct string_list *names);
     +
48:  4c6ec504e3 ! 48:  567ccd3d3e repack: move `write_cruft_pack()` out of the builtin
    @@ builtin/repack.c: static int repack_config(const char *var, const char *value,
     -	strbuf_release(&buf);
     -}
     -
    --static int write_cruft_pack(struct write_pack_opts *opts,
    +-static int write_cruft_pack(const struct write_pack_opts *opts,
     -			    const char *cruft_expiration,
     -			    unsigned long combine_cruft_below_size,
     -			    struct string_list *names,
    @@ repack-cruft.c (new)
     +	strbuf_release(&buf);
     +}
     +
    -+int write_cruft_pack(struct write_pack_opts *opts,
    ++int write_cruft_pack(const struct write_pack_opts *opts,
     +		     const char *cruft_expiration,
     +		     unsigned long combine_cruft_below_size,
     +		     struct string_list *names,
    @@ repack-cruft.c (new)
     +}
     
      ## repack.h ##
    -@@ repack.h: int write_filtered_pack(struct write_pack_opts *opts,
    +@@ repack.h: int write_filtered_pack(const struct write_pack_opts *opts,
      			struct existing_packs *existing,
      			struct string_list *names);
      
    -+int write_cruft_pack(struct write_pack_opts *opts,
    ++int write_cruft_pack(const struct write_pack_opts *opts,
     +		     const char *cruft_expiration,
     +		     unsigned long combine_cruft_below_size,
     +		     struct string_list *names,
49:  16eca91f2c = 49:  b7178565ac builtin/repack.c: clean up unused `#include`s

base-commit: 4b71b294773cc4f7fe48ec3a70079aa8783f373d
-- 
2.51.0.540.ga7423965ad8
