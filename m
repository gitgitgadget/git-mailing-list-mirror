Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CC41DDC2C
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661198; cv=none; b=d9NtlU42zogOm/ABkHsIFggaoE/a3ufar2GZ8vxU3AH5Byqbbjc8otdDpyNykmyxiLKbLEqPXehykv9rXzMd8/gYW4t3pCh9iW8/cXi7k/4aVgrnA4Dn+OVN9q4YKowOnM5V387+QtjdyLjRBV0XwLRnFg8tbmUmRteA6FYqloY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661198; c=relaxed/simple;
	bh=bwmxMU2LbGMGTdwxI5siWWfd6jSQc0tsDuK2QMk8534=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iinDYB568n2JYQnWx8r5JaFrlwTpHi0EsxBSzEUEAdHmtfdo05U+bs3g9nuA7egHw7blaQX1rEP5hKM753M1rpYAeEivIfULPShOfZUAwmUq5a0udyGvn1Sat0oHSIBlz4HXWKX9cyfZm8t4FYfGNhNiKFoGuLUEyquNKgK5uLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bdJMGkXw; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bdJMGkXw"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47691d82bfbso3323721cf.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744661195; x=1745265995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=91Itc++glp1HtTgN0bSuWzYydM6lyEzU2yoaRKvHFzs=;
        b=bdJMGkXwheScTbUpJZJD+VjgQbpQJkzif9p+bDJN6Xsz2m48wMZOjvO71QQO+P95P4
         Xq8F5wO4ga3PCY8MlH2pA1eZlD3Pwh0pUQs0x7pcNDGWfLMf3QMEc0mUqfNf1Rjminpb
         /aLDUcK5X9eZTG7JjqNyXfuWHwsrbRc+ihDJxUupwBV3GTgCT4HHkJuYtw8ckZx+LaSo
         EDbicAmL9x5YLeB/kzr72cikho3VA5vFvcWX5YxQgDsEyEirm7Me4atCQeWGQtPBOF8w
         p/d+RQgJ10njD+o2gVTqWK2xq18ql6m4imKD7IWNb5Kqc12hYLVoiwck46mNuOwzhsUE
         sSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661195; x=1745265995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91Itc++glp1HtTgN0bSuWzYydM6lyEzU2yoaRKvHFzs=;
        b=nVmQuD1gAXinkQYGwyuxXS+2jh0B2hkzSQp1rMXWB1EGWygGN0vIFvlLup171LHy9F
         vsGTq4qZl5Y2A5TUj/CHphd6W8F3kVbzByjqiaZ96tw9vO7sMzFPU5zYdr+K89IJV29C
         c2ESKL90ZNRwCHY/5i2iy1nUSeLlpMaWqivkX1S9thKfMSZoId/uKhpTb3B6tSgIiVDJ
         n4m3Nac4qmHyms3QuJ0MIbMsy2McsAt/oARcsKvltXybh/2HDvBDzjAsktxt/HmjRlk4
         xuRbiOMpsPIr2GClWTjkVh0qZlxpIq+320YEqTr/ozWDvvLnarpTIdlvyfqvBmTBE/XR
         Yysw==
X-Gm-Message-State: AOJu0Yzy6r5sp0U0dwBD/ttT+6hdnAucEnq3+EbXTGtOIbgDqRLAX9gZ
	HTX1D1OieDhiKqE37Puxgecma4MLlWn0SdOdEeXpHre6mVci9Otgf5UQyxsD0Y24pYmOgXeoz3H
	8vG8=
X-Gm-Gg: ASbGncv5X35qSn9lNJjL+9eGsKZXXPVPcZBDUtpXudK1RmxEtAkxAyGGteQw7c2LjF2
	COpjfPxes3AAnhLiyZADWMGOqhUQ66oWpYK/v/c4ejozRoLnMFcKJXlUcNXfVWlf/F4S2JdovV/
	QxB0W5X/Iax/aiYKaeOX+6n5q7PhibD3R7RYucWCaEA8JV2i6N+9C9phkN8RP7a3206t1ulZcaW
	X+nCfY3AceDLKuNDVjeZYjRpTm20tm20T5wCt9hMUCFHwOVrhNN0kRlbM/Dgoemg8ro8vI4IKgB
	ZE2oM4GF6qhdfUkkkgJk55eEfX8htWlG2QHMmTPibx9bXlU+cjOVIP3DvsJTRKUJnJNND+c/Mb6
	DYLZWLoDMUzeQ
X-Google-Smtp-Source: AGHT+IHzrObUqYC/etFAuPV7JjxpPAlgrLqjNEsm0sySB8qEAiiTMq45jMtQwWESAN5436c8Kf2RSw==
X-Received: by 2002:ad4:4ea5:0:b0:6ea:face:e33f with SMTP id 6a1803df08f44-6f230cb9748mr209955316d6.3.1744661194649;
        Mon, 14 Apr 2025 13:06:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a89f986csm781699385a.80.2025.04.14.13.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:06:34 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:06:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/8] repack: exclude cruft pack(s) from the MIDX where
 possible
Message-ID: <a2ec1b826ceb88c33e2b91c6beef49c21ce36632.1744661167.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744661167.git.me@ttaylorr.com>

In ddee3703b3 (builtin/repack.c: add cruft packs to MIDX during
geometric repack, 2022-05-20), repack began adding cruft pack(s) to the
MIDX with '--write-midx' to ensure that the resulting MIDX was always
closed under reachability in order to generate reachability bitmaps.

Suppose you have a once-unreachable object packed in a cruft pack, which
later on becomes reachable from one or more objects in a geometrically
repacked pack. That once-unreachable object *won't* appear in the new
pack, since the cruft pack was specified as neither included nor
excluded to 'pack-objects --stdin-packs'. If the bitmap selection
process picks one or more commits which reach the once-unreachable
objects, commit ddee3703b3 ensures that the MIDX will be closed under
reachability. Without it, we would fail to generate a MIDX bitmap.

ddee3703b3 alludes to the fact that this is sub-optimal by saying

    [...] it's desirable to avoid including cruft packs in the MIDX
    because it causes the MIDX to store a bunch of objects which are
    likely to get thrown away.

, which is true, but hides an even larger problem. If repositories
rarely prune their unreachable objects and/or have many of them, the
MIDX must keep track of a large number of objects which bloats the MIDX
and slows down object lookup.

This is doubly unfortunate because the vast majority of objects in cruft
pack(s) are unlikely to be read, but object reads that go through the
MIDX have to search through them anyway.

This patch causes geometrically-repacked packs to contain a copy of any
once-unreachable object(s) with 'git pack-objects --stdin-packs=follow',
allowing us to avoid including any cruft packs in the MIDX. This is
because a sequence of geometrically-repacked packs that were all
generated with '--stdin-packs=follow' are guaranteed to have their union
be closed under reachability.

Note that you cannot guarantee that a collection of packs is closed
under reachability if not all of them were generated with following as
above. One tell-tale sign that not all geometrically-repacked packs in
the MIDX were generated with following is to see if there is a pack in
the existing MIDX that is not going to be somehow represented (either
verbatim or as part of a geometric rollup) in the new MIDX.

If there is, then starting to generate packs with following during
geometric repacking won't work, since it's open to the same race as
described above.

But if you're starting from scratch (e.g., building the first MIDX after
an all-into-one '--cruft' repack), then you can guarantee that the union
of subsequently generated packs from geometric repacking *is* closed
under reachability.

Detect when this is the case and avoid including cruft packs in the MIDX
where possible. The existing behavior remains the default, and the new
behavior is available with the config 'repack.midxMustIncludeCruft' set
to 'false'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/repack.adoc |   7 ++
 builtin/repack.c                 | 162 +++++++++++++++++++++++++++----
 t/t7704-repack-cruft.sh          |  90 +++++++++++++++++
 3 files changed, 241 insertions(+), 18 deletions(-)

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
index f3330ade7b..ee43a4f4c1 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -39,6 +39,7 @@ static int write_bitmaps = -1;
 static int use_delta_islands;
 static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
+static int midx_must_contain_cruft = 1;
 
 static const char *const git_repack_usage[] = {
 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
@@ -107,6 +108,10 @@ static int repack_config(const char *var, const char *value,
 		free(cruft_po_args->threads);
 		return git_config_string(&cruft_po_args->threads, var, value);
 	}
+	if (!strcmp(var, "repack.midxmustcontaincruft")) {
+		midx_must_contain_cruft = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, ctx, cb);
 }
 
@@ -687,6 +692,77 @@ static void free_pack_geometry(struct pack_geometry *geometry)
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
@@ -755,6 +831,8 @@ static void midx_snapshot_refs(struct tempfile *f)
 
 static void midx_included_packs(struct string_list *include,
 				struct existing_packs *existing,
+				char **midx_pack_names,
+				size_t midx_pack_names_nr,
 				struct string_list *names,
 				struct pack_geometry *geometry)
 {
@@ -808,26 +886,55 @@ static void midx_included_packs(struct string_list *include,
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
+		 * or more of its selected commits reaches a once-cruft
+		 * object that was later made reachable.
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
+		 * Modern versions of Git will write new copies of
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
@@ -1142,6 +1249,8 @@ int cmd_repack(int argc,
 	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
 	int show_progress;
+	char **midx_pack_names = NULL;
+	size_t midx_pack_names_nr = 0;
 
 	/* variables to be filled by option parsing */
 	int delete_redundant = 0;
@@ -1356,7 +1465,10 @@ int cmd_repack(int argc,
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
@@ -1478,6 +1590,16 @@ int cmd_repack(int argc,
 
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
@@ -1519,7 +1641,8 @@ int cmd_repack(int argc,
 
 	if (write_midx) {
 		struct string_list include = STRING_LIST_INIT_DUP;
-		midx_included_packs(&include, &existing, &names, &geometry);
+		midx_included_packs(&include, &existing, midx_pack_names,
+				    midx_pack_names_nr, &names, &geometry);
 
 		ret = write_midx_included_packs(&include, &geometry, &names,
 						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
@@ -1570,6 +1693,9 @@ int cmd_repack(int argc,
 	string_list_clear(&names, 1);
 	existing_packs_release(&existing);
 	free_pack_geometry(&geometry);
+	for (size_t i = 0; i < midx_pack_names_nr; i++)
+		free(midx_pack_names[i]);
+	free(midx_pack_names);
 	pack_objects_args_release(&po_args);
 	pack_objects_args_release(&cruft_po_args);
 
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 8aebfb45f5..2b0a55f8fd 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -724,4 +724,94 @@ test_expect_success 'cruft repack respects --quiet' '
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
+		ls $packdir/pack-*.idx | sort >packs.all &&
+		grep -o "pack-.*\.idx$" packs.all >in &&
+
+		git multi-pack-index write --stdin-packs --bitmap <in &&
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
 test_done
-- 
2.49.0.229.gc267761125.dirty
