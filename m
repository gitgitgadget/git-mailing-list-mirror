Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE09028DF39
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375839; cv=none; b=LOl5KvUqrVB7jXZp01TAMc0yVLl4q1vkfu4KaQzQ2fNxzeRSb4BDpTfUGGgbkSaMtqDRhMxpMMY2FRJ3lQH0ZvPupzFkEMw0Pds+1L26S8BBqemykQjYnyqwftRjyFnrdnqigEA+/kSFotXK2zWru7Va0jcAduxVfWy/G3TpgoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375839; c=relaxed/simple;
	bh=KpaJF8kYfuTbSrAW/GfjpvVz9aba2eTMZM6inclwJYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs2KDclTnGB4LAXCN3IZAud54O5wyCr8+eIJn8eje9aLNvjThUznwGyJNPM/jIPSBltLIQvUssPIRRvGIYFwTlB6meJAW/VVLZfLTZ8n0IDHpH4d06D9BAbcl/YoloYEU6Ddk1CqSC5NPOrwctsV8IU6DGOAntu/+P+g1hK5Aus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=S4OQOpUf; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="S4OQOpUf"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e81f311a86fso1267991276.3
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750375835; x=1750980635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ExRLS6cXUoZ5RSfkWnCGMZ1Pl6F0nZpUdMFbXLA/SGE=;
        b=S4OQOpUfyFXaHpv/X6z00z4bvyquRqUI72lZgmC5d7SxgyFkL7XOd1m5SLeg77y2JV
         A7ms4uJkka2W5bRLP4iHDL2+06tZXU0D9uPQXLe4Mr0yO0iVGFGRwa7g+z4r5jMnP3aK
         +D6l+PEkAb1wbnkSjyJmVB+qb8EhqavPUkejFV4+3XGYkb4Cw+8RidT84S4rWLrtF7vY
         OiI9qUDjF6IxJ/KusMDAbA+xnjAmkbrM2Vdul70FpkZNqlroR9PiExirl0ZFbPcKvKlK
         xecfIww2cd6pjTiSeX1K6dwjbWMq/ywBayCgZNuCXcNQl78fftuwgkU7VUoSz2n3Cmj7
         1kMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750375835; x=1750980635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExRLS6cXUoZ5RSfkWnCGMZ1Pl6F0nZpUdMFbXLA/SGE=;
        b=chOTW5Ifv8Me+RAxj5gz+N5oyUYVA1UlljB5cgRTkW1gg8qGSSmxmJ1lzZ6HhPQz3T
         S2HZDaaImeDfLQNXX4/B0xp50N00ttEKUh5ki1UFma+gJCaIrbyAT98wF47zVHK5aksP
         ODWkh1utgr27HvbLIKXU5+QOx3/Yy54dwk2FCWFXszt4BkkesmfRLqOjXkiWvS1L+ML0
         iicZIjQ+dJTQSTENfepLj6qOn0tdO358El5C1Aa/n+yFz8nLv2DFUvqy9Ja8SG6Yu17L
         FYotJwUlrYScQQChYgR72JlHJSzF4fHZYi7H2ZI3YjeQ1ZNBTOkTvIUrDN3GnZ2dnDfs
         iNoQ==
X-Gm-Message-State: AOJu0Ywi+/hhU6R0bteSX/Qsbu/ttQvNDblQNQIcWR0UdqfUqT8bUQSD
	xrIr93mDhlWGTBy8XBVgcZ255aU78+W4CE61DcXD9r3p72e2VVweAMjQJDXC57cLsZp6awZQrbx
	eJqUZ
X-Gm-Gg: ASbGncsApR2UC8MKuVcXmpzr6Jp56WZKXHdCU/O1xrkWnFn+WVT+j/caBdHEb+jZW5p
	CIIot8s7EzGwZ6uuxsjEFEl9/rQ6AE0Oq/a6OnLuVOSeX0Sp0kfB2rDAkQxv2gTS477tJ2EujNT
	MDNNp+KD8f1ygUrmoN05GOawoCdIFF5KTiEscwfiQOHwbhV9o8fyTQ6TcJkC7Yiz3urn1jG25QR
	oZ62CDAKmRtXQGl/E9+7UJPzeogl2vbRBjWI0J11Iz+RBGh+k11zXBDLfF2a8k2HS/uE0ffI8nF
	wtEw0inF4Ua5o5ZMy2yeiBMX6Ds8P6HDUzBTVgYDXYfoybRbJvEH04qAFc5JrgCbJ6tzJoztB0N
	By94budRtNA32A2P7eI/Sd8PitDi9hMEkzw==
X-Google-Smtp-Source: AGHT+IE09ShfmDtb4hnyDhBqcqkCKnU688jhnVsXvG3dqUtA3xrXC1y6Z3TIudlPdF8yw0pH64zHOA==
X-Received: by 2002:a05:6902:c11:b0:e84:2729:81a with SMTP id 3f1490d57ef6-e842bd1445bmr1309419276.38.1750375834853;
        Thu, 19 Jun 2025 16:30:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e842ac5bd3fsm294638276.34.2025.06.19.16.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 16:30:34 -0700 (PDT)
Date: Thu, 19 Jun 2025 19:30:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 9/9] repack: exclude cruft pack(s) from the MIDX where
 possible
Message-ID: <6487001f64653d1434890df39b4c4937ea4d0b2c.1750375803.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750375803.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1750375803.git.me@ttaylorr.com>

In ddee3703b3 (builtin/repack.c: add cruft packs to MIDX during
geometric repack, 2022-05-20), repack began adding cruft pack(s) to the
MIDX with '--write-midx' to ensure that the resulting MIDX was always
closed under reachability in order to generate reachability bitmaps.

While the previous patch added the '--stdin-packs=follow' option to
pack-objects, it is not yet on by default. Given that, suppose you have
a once-unreachable object packed in a cruft pack, which later becomes
reachable from one or more objects in a geometrically repacked pack.
That once-unreachable object *won't* appear in the new pack, since the
cruft pack was not specified as included or excluded when the
geometrically repacked pack was created with 'pack-objects
--stdin-packs' (*not* '--stdin-packs=follow', which is not on). If that
new pack is included in a MIDX without the cruft pack, then trying to
generate bitmaps for that MIDX may fail. This happens when the bitmap
selection process picks one or more commits which reach the
once-unreachable objects.

To mitigate this failure mode, commit ddee3703b3 ensures that the MIDX
will be closed under reachability by including cruft pack(s). If cruft
pack(s) were not included, we would fail to generate a MIDX bitmap. But
ddee3703b3 alludes to the fact that this is sub-optimal by saying

    [...] it's desirable to avoid including cruft packs in the MIDX
    because it causes the MIDX to store a bunch of objects which are
    likely to get thrown away.

, which is true, but hides an even larger problem. If repositories
rarely prune their unreachable objects and/or have many of them, the
MIDX must keep track of a large number of objects which bloats the MIDX
and slows down object lookup.

This is doubly unfortunate because the vast majority of objects in cruft
pack(s) are unlikely to be read. But any object lookups that go through
the MIDX must binary search over them anyway, slowing down object
lookups using the MIDX.

This patch causes geometrically-repacked packs to contain a copy of any
once-unreachable object(s) with 'git pack-objects --stdin-packs=follow',
allowing us to avoid including any cruft packs in the MIDX. This is
because a sequence of geometrically-repacked packs that were all
generated with '--stdin-packs=follow' are guaranteed to have their union
be closed under reachability.

Note that you cannot guarantee that a collection of packs is closed
under reachability if not all of them were generated with "following" as
above. One tell-tale sign that not all geometrically-repacked packs in
the MIDX were generated with "following" is to see if there is a pack in
the existing MIDX that is not going to be somehow represented (either
verbatim or as part of a geometric rollup) in the new MIDX.

If there is, then starting to generate packs with "following" during
geometric repacking won't work, since it's open to the same race as
described above.

But if you're starting from scratch (e.g., building the first MIDX after
an all-into-one '--cruft' repack), then you can guarantee that the union
of subsequently generated packs from geometric repacking *is* closed
under reachability.

(One exception here is when "starting from scratch" results in a noop
repack, e.g., because the non-cruft pack(s) in a repository already form
a geometric progression. Since we can't tell whether or not those were
generated with '--stdin-packs=follow', they may depend on
once-unreachable objects, so we have to include the cruft pack in the
MIDX in this case.)

Detect when this is the case and avoid including cruft packs in the MIDX
where possible. The existing behavior remains the default, and the new
behavior is available with the config 'repack.midxMustIncludeCruft' set
to 'false'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/repack.adoc |   7 ++
 builtin/repack.c                 | 184 +++++++++++++++++++++++++++----
 t/t7704-repack-cruft.sh          | 145 ++++++++++++++++++++++++
 3 files changed, 316 insertions(+), 20 deletions(-)

diff --git a/Documentation/config/repack.adoc b/Documentation/config/repack.adoc
index c79af6d7b8..e9e78dcb19 100644
--- a/Documentation/config/repack.adoc
+++ b/Documentation/config/repack.adoc
@@ -39,3 +39,10 @@ repack.cruftThreads::
 	a cruft pack and the respective parameters are not given over
 	the command line. See similarly named `pack.*` configuration
 	variables for defaults and meaning.
+
+repack.midxMustContainCruft::
+	When set to true, linkgit:git-repack[1] will unconditionally include
+	cruft pack(s), if any, in the multi-pack index when invoked with
+	`--write-midx`. When false, cruft packs are only included in the MIDX
+	when necessary (e.g., because they might be required to form a
+	reachability closure with MIDX bitmaps). Defaults to true.
diff --git a/builtin/repack.c b/builtin/repack.c
index 5ddc6e7f95..346d44fbcd 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -39,6 +39,7 @@ static int write_bitmaps = -1;
 static int use_delta_islands;
 static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
+static int midx_must_contain_cruft = 1;
 
 static const char *const git_repack_usage[] = {
 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
@@ -108,6 +109,10 @@ static int repack_config(const char *var, const char *value,
 		free(cruft_po_args->threads);
 		return git_config_string(&cruft_po_args->threads, var, value);
 	}
+	if (!strcmp(var, "repack.midxmustcontaincruft")) {
+		midx_must_contain_cruft = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, ctx, cb);
 }
 
@@ -690,6 +695,77 @@ static void free_pack_geometry(struct pack_geometry *geometry)
 	free(geometry->pack);
 }
 
+static int midx_has_unknown_packs(char **midx_pack_names,
+				  size_t midx_pack_names_nr,
+				  struct string_list *include,
+				  struct pack_geometry *geometry,
+				  struct existing_packs *existing)
+{
+	size_t i;
+
+	string_list_sort(include);
+
+	for (i = 0; i < midx_pack_names_nr; i++) {
+		const char *pack_name = midx_pack_names[i];
+
+		/*
+		 * Determine whether or not each MIDX'd pack from the existing
+		 * MIDX (if any) is represented in the new MIDX. For each pack
+		 * in the MIDX, it must either be:
+		 *
+		 *  - In the "include" list of packs to be included in the new
+		 *    MIDX. Note this function is called before the include
+		 *    list is populated with any cruft pack(s).
+		 *
+		 *  - Below the geometric split line (if using pack geometry),
+		 *    indicating that the pack won't be included in the new
+		 *    MIDX, but its contents were rolled up as part of the
+		 *    geometric repack.
+		 *
+		 *  - In the existing non-kept packs list (if not using pack
+		 *    geometry), and marked as non-deleted.
+		 */
+		if (string_list_has_string(include, pack_name)) {
+			continue;
+		} else if (geometry) {
+			struct strbuf buf = STRBUF_INIT;
+			uint32_t j;
+
+			for (j = 0; j < geometry->split; j++) {
+				strbuf_reset(&buf);
+				strbuf_addstr(&buf, pack_basename(geometry->pack[j]));
+				strbuf_strip_suffix(&buf, ".pack");
+				strbuf_addstr(&buf, ".idx");
+
+				if (!strcmp(pack_name, buf.buf)) {
+					strbuf_release(&buf);
+					break;
+				}
+			}
+
+			strbuf_release(&buf);
+
+			if (j < geometry->split)
+				continue;
+		} else {
+			struct string_list_item *item;
+
+			item = string_list_lookup(&existing->non_kept_packs,
+						  pack_name);
+			if (item && !pack_is_marked_for_deletion(item))
+				continue;
+		}
+
+		/*
+		 * If we got to this point, the MIDX includes some pack that we
+		 * don't know about.
+		 */
+		return 1;
+	}
+
+	return 0;
+}
+
 struct midx_snapshot_ref_data {
 	struct tempfile *f;
 	struct oidset seen;
@@ -758,6 +834,8 @@ static void midx_snapshot_refs(struct tempfile *f)
 
 static void midx_included_packs(struct string_list *include,
 				struct existing_packs *existing,
+				char **midx_pack_names,
+				size_t midx_pack_names_nr,
 				struct string_list *names,
 				struct pack_geometry *geometry)
 {
@@ -811,26 +889,56 @@ static void midx_included_packs(struct string_list *include,
 		}
 	}
 
-	for_each_string_list_item(item, &existing->cruft_packs) {
+	if (midx_must_contain_cruft ||
+	    midx_has_unknown_packs(midx_pack_names, midx_pack_names_nr,
+				   include, geometry, existing)) {
 		/*
-		 * When doing a --geometric repack, there is no need to check
-		 * for deleted packs, since we're by definition not doing an
-		 * ALL_INTO_ONE repack (hence no packs will be deleted).
-		 * Otherwise we must check for and exclude any packs which are
-		 * enqueued for deletion.
+		 * If there are one or more unknown pack(s) present (see
+		 * midx_has_unknown_packs() for what makes a pack
+		 * "unknown") in the MIDX before the repack, keep them
+		 * as they may be required to form a reachability
+		 * closure if the MIDX is bitmapped.
 		 *
-		 * So we could omit the conditional below in the --geometric
-		 * case, but doing so is unnecessary since no packs are marked
-		 * as pending deletion (since we only call
-		 * `mark_packs_for_deletion()` when doing an all-into-one
-		 * repack).
+		 * For example, a cruft pack can be required to form a
+		 * reachability closure if the MIDX is bitmapped and one
+		 * or more of the bitmap's selected commits reaches a
+		 * once-cruft object that was later made reachable.
 		 */
-		if (pack_is_marked_for_deletion(item))
-			continue;
+		for_each_string_list_item(item, &existing->cruft_packs) {
+			/*
+			 * When doing a --geometric repack, there is no
+			 * need to check for deleted packs, since we're
+			 * by definition not doing an ALL_INTO_ONE
+			 * repack (hence no packs will be deleted).
+			 * Otherwise we must check for and exclude any
+			 * packs which are enqueued for deletion.
+			 *
+			 * So we could omit the conditional below in the
+			 * --geometric case, but doing so is unnecessary
+			 *  since no packs are marked as pending
+			 *  deletion (since we only call
+			 *  `mark_packs_for_deletion()` when doing an
+			 *  all-into-one repack).
+			 */
+			if (pack_is_marked_for_deletion(item))
+				continue;
 
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s.idx", item->string);
-		string_list_insert(include, buf.buf);
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s.idx", item->string);
+			string_list_insert(include, buf.buf);
+		}
+	} else {
+		/*
+		 * Modern versions of Git (with the appropriate
+		 * configuration setting) will write new copies of
+		 * once-cruft objects when doing a --geometric repack.
+		 *
+		 * If the MIDX has no cruft pack, new packs written
+		 * during a --geometric repack will not rely on the
+		 * cruft pack to form a reachability closure, so we can
+		 * avoid including them in the MIDX in that case.
+		 */
+		;
 	}
 
 	strbuf_release(&buf);
@@ -1145,6 +1253,8 @@ int cmd_repack(int argc,
 	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
 	int show_progress;
+	char **midx_pack_names = NULL;
+	size_t midx_pack_names_nr = 0;
 
 	/* variables to be filled by option parsing */
 	int delete_redundant = 0;
@@ -1361,7 +1471,10 @@ int cmd_repack(int argc,
 		    !(pack_everything & PACK_CRUFT))
 			strvec_push(&cmd.args, "--pack-loose-unreachable");
 	} else if (geometry.split_factor) {
-		strvec_push(&cmd.args, "--stdin-packs");
+		if (midx_must_contain_cruft)
+			strvec_push(&cmd.args, "--stdin-packs");
+		else
+			strvec_push(&cmd.args, "--stdin-packs=follow");
 		strvec_push(&cmd.args, "--unpacked");
 	} else {
 		strvec_push(&cmd.args, "--unpacked");
@@ -1401,8 +1514,25 @@ int cmd_repack(int argc,
 	if (ret)
 		goto cleanup;
 
-	if (!names.nr && !po_args.quiet)
-		printf_ln(_("Nothing new to pack."));
+	if (!names.nr) {
+		if (!po_args.quiet)
+			printf_ln(_("Nothing new to pack."));
+		/*
+		 * If we didn't write any new packs, the non-cruft packs
+		 * may refer to once-unreachable objects in the cruft
+		 * pack(s).
+		 *
+		 * If there isn't already a MIDX, the one we write
+		 * must include the cruft pack(s), in case the
+		 * non-cruft pack(s) refer to once-cruft objects.
+		 *
+		 * If there is already a MIDX, we can punt here, since
+		 * midx_has_unknown_packs() will make the decision for
+		 * us.
+		 */
+		if (!get_local_multi_pack_index(the_repository))
+			midx_must_contain_cruft = 1;
+	}
 
 	if (pack_everything & PACK_CRUFT) {
 		const char *pack_prefix = find_pack_prefix(packdir, packtmp);
@@ -1483,6 +1613,16 @@ int cmd_repack(int argc,
 
 	string_list_sort(&names);
 
+	if (get_local_multi_pack_index(the_repository)) {
+		uint32_t i;
+		struct multi_pack_index *m =
+			get_local_multi_pack_index(the_repository);
+
+		ALLOC_ARRAY(midx_pack_names, m->num_packs);
+		for (i = 0; i < m->num_packs; i++)
+			midx_pack_names[midx_pack_names_nr++] = xstrdup(m->pack_names[i]);
+	}
+
 	close_object_store(the_repository->objects);
 
 	/*
@@ -1524,7 +1664,8 @@ int cmd_repack(int argc,
 
 	if (write_midx) {
 		struct string_list include = STRING_LIST_INIT_DUP;
-		midx_included_packs(&include, &existing, &names, &geometry);
+		midx_included_packs(&include, &existing, midx_pack_names,
+				    midx_pack_names_nr, &names, &geometry);
 
 		ret = write_midx_included_packs(&include, &geometry, &names,
 						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
@@ -1575,6 +1716,9 @@ int cmd_repack(int argc,
 	string_list_clear(&names, 1);
 	existing_packs_release(&existing);
 	free_pack_geometry(&geometry);
+	for (size_t i = 0; i < midx_pack_names_nr; i++)
+		free(midx_pack_names[i]);
+	free(midx_pack_names);
 	pack_objects_args_release(&po_args);
 	pack_objects_args_release(&cruft_po_args);
 
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 8aebfb45f5..aa2e2e6ad8 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -724,4 +724,149 @@ test_expect_success 'cruft repack respects --quiet' '
 	)
 '
 
+setup_cruft_exclude_tests() {
+	git init "$1" &&
+	(
+		cd "$1" &&
+
+		git config repack.midxMustContainCruft false &&
+
+		test_commit one &&
+
+		test_commit --no-tag two &&
+		two="$(git rev-parse HEAD)" &&
+		test_commit --no-tag three &&
+		three="$(git rev-parse HEAD)" &&
+		git reset --hard one &&
+		git reflog expire --all --expire=all &&
+
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack --cruft -d &&
+
+		git merge $two &&
+		test_commit four
+	)
+}
+
+test_expect_success 'repack --write-midx excludes cruft where possible' '
+	setup_cruft_exclude_tests exclude-cruft-when-possible &&
+	(
+		cd exclude-cruft-when-possible &&
+
+		GIT_TEST_MULTI_PACK_INDEX=0 \
+		git repack -d --geometric=2 --write-midx --write-bitmap-index &&
+
+		test-tool read-midx --show-objects $objdir >midx &&
+		cruft="$(ls $packdir/*.mtimes)" &&
+		test_grep ! "$(basename "$cruft" .mtimes).idx" midx &&
+
+		git rev-list --all --objects --no-object-names >reachable.raw &&
+		sort reachable.raw >reachable.objects &&
+		awk "/\.pack$/ { print \$1 }" <midx | sort >midx.objects &&
+
+		test_cmp reachable.objects midx.objects
+	)
+'
+
+test_expect_success 'repack --write-midx includes cruft when instructed' '
+	setup_cruft_exclude_tests exclude-cruft-when-instructed &&
+	(
+		cd exclude-cruft-when-instructed &&
+
+		GIT_TEST_MULTI_PACK_INDEX=0 \
+		git -c repack.midxMustContainCruft=true repack \
+			-d --geometric=2 --write-midx --write-bitmap-index &&
+
+		test-tool read-midx --show-objects $objdir >midx &&
+		cruft="$(ls $packdir/*.mtimes)" &&
+		test_grep "$(basename "$cruft" .mtimes).idx" midx &&
+
+		git cat-file --batch-check="%(objectname)" --batch-all-objects \
+			>all.objects &&
+		awk "/\.pack$/ { print \$1 }" <midx | sort >midx.objects &&
+
+		test_cmp all.objects midx.objects
+	)
+'
+
+test_expect_success 'repack --write-midx includes cruft when necessary' '
+	setup_cruft_exclude_tests exclude-cruft-when-necessary &&
+	(
+		cd exclude-cruft-when-necessary &&
+
+		test_path_is_file $(ls $packdir/pack-*.mtimes) &&
+		( cd $packdir && ls pack-*.idx ) | sort >packs.all &&
+		git multi-pack-index write --stdin-packs --bitmap <packs.all &&
+
+		test_commit five &&
+		GIT_TEST_MULTI_PACK_INDEX=0 \
+		git repack -d --geometric=2 --write-midx --write-bitmap-index &&
+
+		test-tool read-midx --show-objects $objdir >midx &&
+		awk "/\.pack$/ { print \$1 }" <midx | sort >midx.objects &&
+		git cat-file --batch-all-objects --batch-check="%(objectname)" \
+			>expect.objects &&
+		test_cmp expect.objects midx.objects &&
+
+		grep "^pack-" midx >midx.packs &&
+		test_line_count = "$(($(wc -l <packs.all) + 1))" midx.packs
+	)
+'
+
+test_expect_success 'repack --write-midx includes cruft when already geometric' '
+	git init repack--write-midx-geometric-noop &&
+	(
+		cd repack--write-midx-geometric-noop &&
+
+		git branch -M main &&
+		test_commit A &&
+		test_commit B &&
+
+		git checkout -B side &&
+		test_commit --no-tag C &&
+		C="$(git rev-parse HEAD)" &&
+
+		git checkout main &&
+		git branch -D side &&
+		git reflog expire --all --expire=all &&
+
+		# At this point we have two packs: one containing the
+		# objects belonging to commits A and B, and another
+		# (cruft) pack containing the objects belonging to
+		# commit C.
+		git repack --cruft -d &&
+
+		# Create a third pack which contains a merge commit
+		# making commit C reachable again.
+		#
+		# --no-ff is important here, as it ensures that we
+		# actually write a new object and subsequently a new
+		# pack to contain it.
+		git merge --no-ff $C &&
+		git repack -d &&
+
+		ls $packdir/pack-*.idx | sort >packs.all &&
+		cruft="$(ls $packdir/pack-*.mtimes)" &&
+		cruft="${cruft%.mtimes}.idx" &&
+
+		for idx in $(grep -v $cruft <packs.all)
+		do
+			git show-index <$idx >out &&
+			wc -l <out || return 1
+		done >sizes.raw &&
+
+		# Make sure that there are two non-cruft packs, and
+		# that one of them contains at least twice as many
+		# objects as the other, ensuring that they are already
+		# in a geometric progression.
+		sort -n sizes.raw >sizes &&
+		test_line_count = 2 sizes &&
+		s1=$(head -n 1 sizes) &&
+		s2=$(tail -n 1 sizes) &&
+		test "$s2" -gt "$((2 * $s1))" &&
+
+		git -c repack.midxMustContainCruft=false repack --geometric=2 \
+			--write-midx --write-bitmap-index
+	)
+'
+
 test_done
-- 
2.50.0.61.gf819b10624.dirty
