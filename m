Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1A4C74
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661175; cv=none; b=H6hB6dsBvUezhiuqR/L4b12x4n+JIAVL2Oa8eGT01RT6HXqjAd/CGITcQg7d9chOxOiG/KjIPLeVXF5DLw43J+13qQkR8gKaVrCdAjAqU9gwTHyJAIpW37oVp2qTPXT44XRQerBEPQBTqEfJUWiKxuaC8dfO2QvLmmfuX3TAci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661175; c=relaxed/simple;
	bh=Nk/eKgf3J9fUEWGlPM9vwglGiGMzN/n51i8PUgKv0cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ43TAZwHm52YL2Av5Bh5S9CvzZbCIuJM9YAXcF30vL2rbRq24VeudBZtiTImzOgOWnX5jP/iUFooYmrzoKkSTDK7+KZHG8Lr4kPmTkTTFF1G7AW4/Pi7Lz7axndlBlED3QOq9YZR5nt0rcHTj9fVCiTDbau+49ftd4MV9ep8L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jJ1tAGSw; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jJ1tAGSw"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c56321b22cso508759285a.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744661170; x=1745265970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmYBMzSTQFm86vDKcAoN+SXb0W0f3nzFl7ct+oku9Ws=;
        b=jJ1tAGSwUBHTFodWEXScUdnGrZg5hLhE23wHbeICo9GSrbdbEPngzaB396HyII+9Oj
         z3XOP9D1XAq24bHeag5uRbIbvYzU5C8VYGC5oEw9Ti+ZPv7EYmp8v5JsU5+PeDAWSgYt
         pfiPALFk4QAfuhRI+k+ENwR9COachU/sMVbsNCNDLrJ1xnd45iyhuARtwZjBvBSedSnx
         Wgq47rwQbVHy3T3gEImYoxDjjsqKkDmAotlS/Tcn/iYFCbEtD98N/srXfzdYCUgksCDo
         VM3swT78e6+fsk3eCwIFt7KxsKnqVNST4ylc+bfpaxk2caXsWuXtnjckj/2s+snjKe0U
         vJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661170; x=1745265970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmYBMzSTQFm86vDKcAoN+SXb0W0f3nzFl7ct+oku9Ws=;
        b=a3qcFLJOfYWUD2v6JFySexF48LCISeoNm53e8xXxu6+2i8S8rPRqpckaee4cb+NjPn
         mqZTBMVMtkOXmMOHgRpvTFEWVxaQl1+FeX4RSmXe7Jyvvcx2W5QFcONoinXsEfG6mJhx
         ofJVpMxFJ0PMAB2j6le46esjT2duyXRxNcPwKNMf3zeZZc+10Y2Y5QCrF946GQUBk/rt
         ezX348+h5q7N0XCRRHdMhevngUv2LYW+YUvS9fYHcpQYVlMUnSSgDlhcDOfWl4vuNY8C
         yNULGy8RJfxQvL/87uEeE6H1loewxuEoYgwCZlPZuAO4UxZU9FTZxA6D6v5LnFftHaBc
         GDwg==
X-Gm-Message-State: AOJu0YxAz28g1OsGzVbTu+XO9NAQ3e/YXB4grfPbmMYTogeiZAAmcUyj
	DoRtn271SPwJqNsiWXgtmhAzQJY2/aAl0Q5ki5ti+3VLv8cVN/eJxGW+1G1bIMehJ3on+LirtmA
	PQHk=
X-Gm-Gg: ASbGncvCzWTQ9eB51D+mdD2FmB+IeB0T4ddn0n84qfT+z+TpeN1TEjVOUt+VQXCTZgb
	TrMjQzmkaSTAFOGQ7+76gPf+3vLwIj2ikaB/iN11HZGqS1HletomMtklLw7ZvDN1EeBd/FCoX1k
	EFCKKky+8wTKA7yqWGph5gA1i2Z8jnjpykH909EEbQh9W9dCMFWCaOBj/KI1ihXDEdNYLvyFeus
	vfuHQgXSrptZWxbUN+Ls+6TpTFnN/NmJyDYczh4Lzi02qeG9rY1X4Qpeyksu1tmNgLkKXiSBDs8
	S/KS2v3j4+I06t+qieHvgi3qs9turAFWPuDGz+3OAHy1D+4ONRhH8lRURUfN9k/6aekUONI9dOO
	szkdbuDVsEiSp
X-Google-Smtp-Source: AGHT+IHEwLPs1oIZDloa4ll+6DGYcYmSi9MLLDv76ketlIm4IboboDnBmYtGfNkVaEoJ7b+X1Iq82g==
X-Received: by 2002:a05:620a:24cd:b0:7c2:3f1f:1a15 with SMTP id af79cd13be357-7c8186f11a2mr121767985a.8.1744661170190;
        Mon, 14 Apr 2025 13:06:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a895181csm780109085a.32.2025.04.14.13.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:06:09 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:06:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/8] repack: avoid MIDX'ing cruft pack(s) where possible
Message-ID: <cover.1744661167.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744413969.git.me@ttaylorr.com>

Here is a non-RFC version of my series to explore creating MIDXs while
repacking that don't include the cruft pack.

The core idea behind this approach is to ensure that packs generated via
geometric repacking traverse through objects that appear in packs which
are neither included nor excluded. Then if some commit (for example) in
a pack reaches some once-unreachable object stored in a cruft pack, the
pack generated via geometric repacking will pick up and write a copy of
that object during its traversal.

If you repack consistently using this strategy, you can guarantee that
the union of geometrically-repacked packs are closed under reachability
without having to keep track of any cruft pack(s) in the MIDX.

This version has a couple of minor changes from the RFC:

  - Before using a designated initializer to setup a 'struct
    object_info', add a new preparatory commit to explain that such
    designated initializers rely on the default value for
    non-initialized fields to be zero'd.

  - Less cruft-pack specific reasoning for when repack can use this new
    mode (thanks to a helpful discussion with Peff while thinking
    through and talking about these changes).

  - A new 'repack.midxMustContainCruft' configuration knob to opt-in to
    this new behavior.

  - More readable (IMHO) test scripts.

I think this version is sufficiently ready for review. I'm going to
deploy a copy of this within GitHub's infrastructure and see how it
behaves on a single replica of an internal repository over a ~week and
report back.

Thanks in advance for any review in the meantime :-).

Taylor Blau (8):
  pack-objects: use standard option incompatibility functions
  object-store-ll.h: add note about designated initializers
  pack-objects: limit scope in 'add_object_entry_from_pack()'
  pack-objects: factor out handling '--stdin-packs'
  pack-objects: declare 'rev_info' for '--stdin-packs' earlier
  pack-objects: perform name-hash traversal for unpacked objects
  pack-objects: introduce '--stdin-packs=follow'
  repack: exclude cruft pack(s) from the MIDX where possible

 Documentation/config/repack.adoc    |   7 +
 Documentation/git-pack-objects.adoc |   8 +-
 builtin/pack-objects.c              | 193 +++++++++++++++++-----------
 builtin/repack.c                    | 162 ++++++++++++++++++++---
 object-store-ll.h                   |   8 ++
 t/t5331-pack-objects-stdin.sh       | 103 ++++++++++++++-
 t/t7704-repack-cruft.sh             |  90 +++++++++++++
 7 files changed, 478 insertions(+), 93 deletions(-)

Range-diff against v1:
1:  63fb4dab30 = 1:  65bc7e4630 pack-objects: use standard option incompatibility functions
-:  ---------- > 2:  920c91eb1e object-store-ll.h: add note about designated initializers
2:  6357633f6d = 3:  f8ac36b110 pack-objects: limit scope in 'add_object_entry_from_pack()'
3:  43e889b157 = 4:  5e03b482ba pack-objects: factor out handling '--stdin-packs'
4:  07a91be3ec = 5:  bccbac2ec5 pack-objects: declare 'rev_info' for '--stdin-packs' earlier
5:  241f7c87e5 = 6:  0bc2183dc3 pack-objects: perform name-hash traversal for unpacked objects
6:  a0318321ec = 7:  697a337cb1 pack-objects: introduce '--stdin-packs=follow'
7:  ef0bc38cf0 < -:  ---------- repack: keep track of existing MIDX'd packs
8:  19b69c1246 ! 8:  a2ec1b826c repack: exclude cruft pack(s) from the MIDX where possible
    @@ Commit message
         Note that you cannot guarantee that a collection of packs is closed
         under reachability if not all of them were generated with following as
         above. One tell-tale sign that not all geometrically-repacked packs in
    -    the MIDX were generated with following is to see if there is a cruft
    -    pack already in the MIDX.
    +    the MIDX were generated with following is to see if there is a pack in
    +    the existing MIDX that is not going to be somehow represented (either
    +    verbatim or as part of a geometric rollup) in the new MIDX.
     
         If there is, then starting to generate packs with following during
         geometric repacking won't work, since it's open to the same race as
    @@ Commit message
         under reachability.
     
         Detect when this is the case and avoid including cruft packs in the MIDX
    -    where possible.
    +    where possible. The existing behavior remains the default, and the new
    +    behavior is available with the config 'repack.midxMustIncludeCruft' set
    +    to 'false'.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    + ## Documentation/config/repack.adoc ##
    +@@ Documentation/config/repack.adoc: repack.cruftThreads::
    + 	a cruft pack and the respective parameters are not given over
    + 	the command line. See similarly named `pack.*` configuration
    + 	variables for defaults and meaning.
    ++
    ++repack.midxMustContainCruft::
    ++	When set to true, linkgit:git-repack[1] will unconditionally include
    ++	cruft pack(s), if any, in the multi-pack index when invoked with
    ++	`--write-midx`. When false, cruft packs are only included in the MIDX
    ++	when necessary (e.g., because they might be required to form a
    ++	reachability closure with MIDX bitmaps). Defaults to true.
    +
      ## builtin/repack.c ##
    -@@ builtin/repack.c: static void pack_mark_in_midx(struct string_list_item *item)
    - 	item->util = (void*)((uintptr_t)item->util | PACK_IN_MIDX);
    +@@ builtin/repack.c: static int write_bitmaps = -1;
    + static int use_delta_islands;
    + static int run_update_server_info = 1;
    + static char *packdir, *packtmp_name, *packtmp;
    ++static int midx_must_contain_cruft = 1;
    + 
    + static const char *const git_repack_usage[] = {
    + 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
    +@@ builtin/repack.c: static int repack_config(const char *var, const char *value,
    + 		free(cruft_po_args->threads);
    + 		return git_config_string(&cruft_po_args->threads, var, value);
    + 	}
    ++	if (!strcmp(var, "repack.midxmustcontaincruft")) {
    ++		midx_must_contain_cruft = git_config_bool(var, value);
    ++		return 0;
    ++	}
    + 	return git_default_config(var, value, ctx, cb);
    + }
    + 
    +@@ builtin/repack.c: static void free_pack_geometry(struct pack_geometry *geometry)
    + 	free(geometry->pack);
      }
      
    -+static int pack_is_in_midx(struct string_list_item *item)
    ++static int midx_has_unknown_packs(char **midx_pack_names,
    ++				  size_t midx_pack_names_nr,
    ++				  struct string_list *include,
    ++				  struct pack_geometry *geometry,
    ++				  struct existing_packs *existing)
     +{
    -+	return (uintptr_t)item->util & PACK_IN_MIDX;
    -+}
    ++	size_t i;
     +
    -+static int existing_has_cruft_in_midx(struct existing_packs *existing)
    -+{
    -+	struct string_list_item *item;
    -+	for_each_string_list_item(item, &existing->cruft_packs) {
    -+		if (pack_is_in_midx(item))
    -+			return 1;
    ++	string_list_sort(include);
    ++
    ++	for (i = 0; i < midx_pack_names_nr; i++) {
    ++		const char *pack_name = midx_pack_names[i];
    ++
    ++		/*
    ++		 * Determine whether or not each MIDX'd pack from the existing
    ++		 * MIDX (if any) is represented in the new MIDX. For each pack
    ++		 * in the MIDX, it must either be:
    ++		 *
    ++		 *  - In the "include" list of packs to be included in the new
    ++		 *    MIDX. Note this function is called before the include
    ++		 *    list is populated with any cruft pack(s).
    ++		 *
    ++		 *  - Below the geometric split line (if using pack geometry),
    ++		 *    indicating that the pack won't be included in the new
    ++		 *    MIDX, but its contents were rolled up as part of the
    ++		 *    geometric repack.
    ++		 *
    ++		 *  - In the existing non-kept packs list (if not using pack
    ++		 *    geometry), and marked as non-deleted.
    ++		 */
    ++		if (string_list_has_string(include, pack_name)) {
    ++			continue;
    ++		} else if (geometry) {
    ++			struct strbuf buf = STRBUF_INIT;
    ++			uint32_t j;
    ++
    ++			for (j = 0; j < geometry->split; j++) {
    ++				strbuf_reset(&buf);
    ++				strbuf_addstr(&buf, pack_basename(geometry->pack[j]));
    ++				strbuf_strip_suffix(&buf, ".pack");
    ++				strbuf_addstr(&buf, ".idx");
    ++
    ++				if (!strcmp(pack_name, buf.buf)) {
    ++					strbuf_release(&buf);
    ++					break;
    ++				}
    ++			}
    ++
    ++			strbuf_release(&buf);
    ++
    ++			if (j < geometry->split)
    ++				continue;
    ++		} else {
    ++			struct string_list_item *item;
    ++
    ++			item = string_list_lookup(&existing->non_kept_packs,
    ++						  pack_name);
    ++			if (item && !pack_is_marked_for_deletion(item))
    ++				continue;
    ++		}
    ++
    ++		/*
    ++		 * If we got to this point, the MIDX includes some pack that we
    ++		 * don't know about.
    ++		 */
    ++		return 1;
     +	}
    ++
     +	return 0;
     +}
     +
    - static void mark_packs_for_deletion_1(struct string_list *names,
    - 				      struct string_list *list)
    + struct midx_snapshot_ref_data {
    + 	struct tempfile *f;
    + 	struct oidset seen;
    +@@ builtin/repack.c: static void midx_snapshot_refs(struct tempfile *f)
    + 
    + static void midx_included_packs(struct string_list *include,
    + 				struct existing_packs *existing,
    ++				char **midx_pack_names,
    ++				size_t midx_pack_names_nr,
    + 				struct string_list *names,
    + 				struct pack_geometry *geometry)
      {
     @@ builtin/repack.c: static void midx_included_packs(struct string_list *include,
      		}
      	}
      
     -	for_each_string_list_item(item, &existing->cruft_packs) {
    -+	if (existing_has_cruft_in_midx(existing)) {
    ++	if (midx_must_contain_cruft ||
    ++	    midx_has_unknown_packs(midx_pack_names, midx_pack_names_nr,
    ++				   include, geometry, existing)) {
      		/*
     -		 * When doing a --geometric repack, there is no need to check
     -		 * for deleted packs, since we're by definition not doing an
     -		 * ALL_INTO_ONE repack (hence no packs will be deleted).
     -		 * Otherwise we must check for and exclude any packs which are
     -		 * enqueued for deletion.
    -+		 * If we had one or more cruft pack(s) present in the
    -+		 * MIDX before the repack, keep them as they may be
    -+		 * required to form a reachability closure if the MIDX
    -+		 * is bitmapped.
    ++		 * If there are one or more unknown pack(s) present (see
    ++		 * midx_has_unknown_packs() for what makes a pack
    ++		 * "unknown") in the MIDX before the repack, keep them
    ++		 * as they may be required to form a reachability
    ++		 * closure if the MIDX is bitmapped.
      		 *
     -		 * So we could omit the conditional below in the --geometric
     -		 * case, but doing so is unnecessary since no packs are marked
     -		 * as pending deletion (since we only call
     -		 * `mark_packs_for_deletion()` when doing an all-into-one
     -		 * repack).
    -+		 * A cruft pack can be required to form a reachability
    -+		 * closure if the MIDX is bitmapped and one or more of
    -+		 * its selected commits reaches a once-cruft object that
    -+		 * was later made reachable.
    ++		 * For example, a cruft pack can be required to form a
    ++		 * reachability closure if the MIDX is bitmapped and one
    ++		 * or more of its selected commits reaches a once-cruft
    ++		 * object that was later made reachable.
      		 */
     -		if (pack_is_marked_for_deletion(item))
     -			continue;
    @@ builtin/repack.c: static void midx_included_packs(struct string_list *include,
      	}
      
      	strbuf_release(&buf);
    +@@ builtin/repack.c: int cmd_repack(int argc,
    + 	struct tempfile *refs_snapshot = NULL;
    + 	int i, ext, ret;
    + 	int show_progress;
    ++	char **midx_pack_names = NULL;
    ++	size_t midx_pack_names_nr = 0;
    + 
    + 	/* variables to be filled by option parsing */
    + 	int delete_redundant = 0;
     @@ builtin/repack.c: int cmd_repack(int argc,
      		    !(pack_everything & PACK_CRUFT))
      			strvec_push(&cmd.args, "--pack-loose-unreachable");
      	} else if (geometry.split_factor) {
     -		strvec_push(&cmd.args, "--stdin-packs");
    -+		if (existing_has_cruft_in_midx(&existing))
    ++		if (midx_must_contain_cruft)
     +			strvec_push(&cmd.args, "--stdin-packs");
     +		else
     +			strvec_push(&cmd.args, "--stdin-packs=follow");
      		strvec_push(&cmd.args, "--unpacked");
      	} else {
      		strvec_push(&cmd.args, "--unpacked");
    +@@ builtin/repack.c: int cmd_repack(int argc,
    + 
    + 	string_list_sort(&names);
    + 
    ++	if (get_local_multi_pack_index(the_repository)) {
    ++		uint32_t i;
    ++		struct multi_pack_index *m =
    ++			get_local_multi_pack_index(the_repository);
    ++
    ++		ALLOC_ARRAY(midx_pack_names, m->num_packs);
    ++		for (i = 0; i < m->num_packs; i++)
    ++			midx_pack_names[midx_pack_names_nr++] = xstrdup(m->pack_names[i]);
    ++	}
    ++
    + 	close_object_store(the_repository->objects);
    + 
    + 	/*
    +@@ builtin/repack.c: int cmd_repack(int argc,
    + 
    + 	if (write_midx) {
    + 		struct string_list include = STRING_LIST_INIT_DUP;
    +-		midx_included_packs(&include, &existing, &names, &geometry);
    ++		midx_included_packs(&include, &existing, midx_pack_names,
    ++				    midx_pack_names_nr, &names, &geometry);
    + 
    + 		ret = write_midx_included_packs(&include, &geometry, &names,
    + 						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
    +@@ builtin/repack.c: int cmd_repack(int argc,
    + 	string_list_clear(&names, 1);
    + 	existing_packs_release(&existing);
    + 	free_pack_geometry(&geometry);
    ++	for (size_t i = 0; i < midx_pack_names_nr; i++)
    ++		free(midx_pack_names[i]);
    ++	free(midx_pack_names);
    + 	pack_objects_args_release(&po_args);
    + 	pack_objects_args_release(&cruft_po_args);
    + 
     
      ## t/t7704-repack-cruft.sh ##
     @@ t/t7704-repack-cruft.sh: test_expect_success 'cruft repack respects --quiet' '
      	)
      '
      
    -+test_expect_success 'repack --write-midx excludes cruft where possible' '
    -+	git init exclude-cruft-when-possible &&
    ++setup_cruft_exclude_tests() {
    ++	git init "$1" &&
     +	(
    -+		cd exclude-cruft-when-possible &&
    ++		cd "$1" &&
    ++
    ++		git config repack.midxMustContainCruft false &&
     +
     +		test_commit one &&
     +
    @@ t/t7704-repack-cruft.sh: test_expect_success 'cruft repack respects --quiet' '
     +		test_commit --no-tag three &&
     +		three="$(git rev-parse HEAD)" &&
     +		git reset --hard one &&
    -+
     +		git reflog expire --all --expire=all &&
     +
    -+		git repack --cruft -d &&
    -+		ls $packdir/pack-*.idx | sort >packs.before &&
    ++		GIT_TEST_MULTI_PACK_INDEX=0 git repack --cruft -d &&
     +
     +		git merge $two &&
    -+		test_commit four &&
    ++		test_commit four
    ++	)
    ++}
    ++
    ++test_expect_success 'repack --write-midx excludes cruft where possible' '
    ++	setup_cruft_exclude_tests exclude-cruft-when-possible &&
    ++	(
    ++		cd exclude-cruft-when-possible &&
    ++
    ++		GIT_TEST_MULTI_PACK_INDEX=0 \
     +		git repack -d --geometric=2 --write-midx --write-bitmap-index &&
    -+		ls $packdir/pack-*.idx | sort >packs.after &&
     +
    -+		comm -13 packs.before packs.after >packs.new &&
    -+		test_line_count = 1 packs.new &&
    ++		test-tool read-midx --show-objects $objdir >midx &&
    ++		cruft="$(ls $packdir/*.mtimes)" &&
    ++		test_grep ! "$(basename "$cruft" .mtimes).idx" midx &&
     +
    -+		git rev-list --objects --no-object-names one..four >expect.raw &&
    -+		sort expect.raw >expect &&
    ++		git rev-list --all --objects --no-object-names >reachable.raw &&
    ++		sort reachable.raw >reachable.objects &&
    ++		awk "/\.pack$/ { print \$1 }" <midx | sort >midx.objects &&
     +
    -+		git show-index <$(cat packs.new) >actual.raw &&
    -+		cut -d" " -f2 actual.raw | sort >actual &&
    ++		test_cmp reachable.objects midx.objects
    ++	)
    ++'
     +
    -+		test_cmp expect actual &&
    ++test_expect_success 'repack --write-midx includes cruft when instructed' '
    ++	setup_cruft_exclude_tests exclude-cruft-when-instructed &&
    ++	(
    ++		cd exclude-cruft-when-instructed &&
     +
    -+		test-tool read-midx --show-objects $objdir >actual.raw &&
    -+		grep "\.pack$" actual.raw | cut -d" " -f1 | sort >actual.objects &&
    -+		git rev-list --objects --no-object-names HEAD >expect.raw &&
    -+		sort expect.raw >expect.objects &&
    ++		GIT_TEST_MULTI_PACK_INDEX=0 \
    ++		git -c repack.midxMustContainCruft=true repack \
    ++			-d --geometric=2 --write-midx --write-bitmap-index &&
     +
    -+		test_cmp expect.objects actual.objects &&
    ++		test-tool read-midx --show-objects $objdir >midx &&
    ++		cruft="$(ls $packdir/*.mtimes)" &&
    ++		test_grep "$(basename "$cruft" .mtimes).idx" midx &&
     +
    -+		cruft="$(basename $(ls $packdir/*.mtimes))" &&
    -+		grep "^pack-" actual.raw >actual.packs &&
    -+		! test_grep "${cruft%.mtimes}.idx" actual.packs
    ++		git cat-file --batch-check="%(objectname)" --batch-all-objects \
    ++			>all.objects &&
    ++		awk "/\.pack$/ { print \$1 }" <midx | sort >midx.objects &&
    ++
    ++		test_cmp all.objects midx.objects
     +	)
     +'
     +
     +test_expect_success 'repack --write-midx includes cruft when necessary' '
    ++	setup_cruft_exclude_tests exclude-cruft-when-necessary &&
     +	(
    -+		cd exclude-cruft-when-possible &&
    ++		cd exclude-cruft-when-necessary &&
     +
    ++		test_path_is_file $(ls $packdir/pack-*.mtimes) &&
     +		ls $packdir/pack-*.idx | sort >packs.all &&
     +		grep -o "pack-.*\.idx$" packs.all >in &&
     +
     +		git multi-pack-index write --stdin-packs --bitmap <in &&
     +
     +		test_commit five &&
    ++		GIT_TEST_MULTI_PACK_INDEX=0 \
     +		git repack -d --geometric=2 --write-midx --write-bitmap-index &&
     +
    -+		test-tool read-midx --show-objects $objdir >actual.raw &&
    -+		grep "\.pack$" actual.raw | cut -d" " -f1 | sort >actual.objects &&
    ++		test-tool read-midx --show-objects $objdir >midx &&
    ++		awk "/\.pack$/ { print \$1 }" <midx | sort >midx.objects &&
     +		git cat-file --batch-all-objects --batch-check="%(objectname)" \
     +			>expect.objects &&
    -+		test_cmp expect.objects actual.objects &&
    ++		test_cmp expect.objects midx.objects &&
     +
    -+		grep "^pack-" actual.raw >actual.packs &&
    -+		test_line_count = "$(($(wc -l <packs.all) + 1))" actual.packs
    ++		grep "^pack-" midx >midx.packs &&
    ++		test_line_count = "$(($(wc -l <packs.all) + 1))" midx.packs
     +	)
     +'
     +

base-commit: 485f5f863615e670fd97ae40af744e14072cfe18
-- 
2.49.0.229.gc267761125.dirty
