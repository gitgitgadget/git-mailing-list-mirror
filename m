Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188F2248AA
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375839; cv=none; b=H4fgtYrPdKmRAv7dIv5iXGTFqXWY6jxsAdQj3Jv5HGN6BZyIr5JYrUDP5gTkTxt77azBJggxUPpNSz31BC3eRe9t6tnuxc1PgLeF5HP3Vjvn0IAIUmob6vhJCPxA94bPOoA2vuSKb5IZlCckMRVQ544Cia4ymZ5mrjhf2mibGqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375839; c=relaxed/simple;
	bh=LteCYK5s7eQqYdEkhRcPjXFETANU2JTCV2VKVmjTlu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpIOuxesAHPP/GEoRtNsJEiiMa6pD43CrqB2LtJWZuVR2Rn4mTPZhJ7zFVDOOgQI3z3dBUG70dhXs+ThPrb8ZHj3ygLocwUUchQx8TMuRCUmlpFg5gv5xke2B7xRiU7LhT8bGkJ0tSx6fFkfIakKqkZxvMc3hwXzkZXA4Ytcv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=obB6ES3I; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="obB6ES3I"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e64b430daso14354367b3.3
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 16:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750375832; x=1750980632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZAwlFNWP3LG6JBgrf1MksIOFQW99182px7LS5lMD14=;
        b=obB6ES3IgsD5mUEku0sLH8LY2h/nBaYAKBln6ucAi+X7TkFMNVT0OqNH7FFgT7RUpr
         F4LFjwto3i3ZDA+WQb2+VPFtavKetSfXhgvVqD2rXFIkcVBczTkv1pRgBKGvBtNVpKXO
         LQb5Sz73z8IfcG/UjdHnr1UqQzY4v0ILr/nM7YmYVX2ooCIoKqRpswKE1ueyJWNIFBAX
         uTVMZtlriw41F9iK5jFeYnKN4g3xEqXK5kPMaNlNhlKRAUVzL1dEXh2GfMojIY/vjxVu
         EyDyydlqBvw6mYmFItVgJ4SZKlCULHJOdCCVkqYGJ/1sw1T/ViSDk/BW8F3t3ahsnxQI
         QFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750375832; x=1750980632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZAwlFNWP3LG6JBgrf1MksIOFQW99182px7LS5lMD14=;
        b=E78ipwF41V/UrKlDqw4s01JlFUi1brsNCocDu8Qs9g/VV3Hbjkv3Wt/K7BcdTVGgpL
         4em0Ys94QFu+fKGQ/joFQaCJ9tlupENSl6HiX0yFPBPbzVKiPv68FCT5STX6vpQ1NcTC
         QoZ8UaH3PBRFux42EiYG7yFrGwIcKjoe+KM3xBqWEHsFxvwHv/zLOPnIfGWsWw/yjJzX
         KSAFDt5eMcaWVWkEhsegBf0quv9MV96LZXL8IYj+ZA1kW+E5eMNSD+oLoynLUMzsobMi
         jsh8wtfLK2yGL9KFBH6caTYsZ4M8Ro+spWYboLimi+0Po0UUdm9lHWWDoxz8/5ZOOWl9
         ugqg==
X-Gm-Message-State: AOJu0YyGD8XJ3JUtO6ykVmlWoZlWEzbx/+72MNWRAkzHDR1wx8AbjeNX
	Ms3dLis22lISz+YE5dBM4ypLTm9Hms8vGikgn4/4pDvSYwGmeIBCmhvZ8bGVf43s1N/hgSfRorW
	1eNI1
X-Gm-Gg: ASbGnct26Xe5pSX0ShuxTERxyGkjY2gfOb2AY9fHdeixlyB5ODA6HiSiLV7AHTqbHYH
	f95UfCnoWWs6/JppK2ClHef6uKRkVclFlZNrN0BXKsqQbE1BEWVctd3cdN0qlsk+dFPKjTDCvtQ
	BXT71SrJGOO9e2HpmAigxrMfd9kLB4gB1baO84Xk1u9YzZ54bv7YCN41Awo4DeKkFd3B6XGqqUj
	GNxd/fvNavOsFlMfRakXI/QuajdrgVZoSCtAc7QTaNRgs/d8ZNJlkuEOgWShiZ5RTjqf8/a6R4d
	4y8VD2s5VPAb+AMVtqJTD0O3gEqNGMyzUeIMwVqgWlL2TK/AhntyIk/hhLUYBtC1sVG2+x4waa0
	79cM/17m9jYHoaiUv9uEF4Xuix8zm37EHgQ==
X-Google-Smtp-Source: AGHT+IG328H/m5pXPLSTaqGE32ECwawNAakyEjavYnNCUe9xqbbAfHxY9d5vFU/GzODbc07lzZON6g==
X-Received: by 2002:a05:690c:690d:b0:70d:ed5d:b4cd with SMTP id 00721157ae682-712c649aa32mr14368557b3.17.1750375831896;
        Thu, 19 Jun 2025 16:30:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4be3757sm2029657b3.92.2025.06.19.16.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 16:30:31 -0700 (PDT)
Date: Thu, 19 Jun 2025 19:30:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 8/9] pack-objects: introduce '--stdin-packs=follow'
Message-ID: <b81b6213e8f98968a98bd147c068090cfadb5f92.1750375803.git.me@ttaylorr.com>
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

When invoked with '--stdin-packs', pack-objects will generate a pack
which contains the objects found in the "included" packs, less any
objects from "excluded" packs.

Packs that exist in the repository but weren't specified as either
included or excluded are in practice treated like the latter, at least
in the sense that pack-objects won't include objects from those packs.
This behavior forces us to include any cruft pack(s) in a repository's
multi-pack index for the reasons described in ddee3703b3
(builtin/repack.c: add cruft packs to MIDX during geometric repack,
2022-05-20).

The full details are in ddee3703b3, but the gist is if you
have a once-unreachable object in a cruft pack which later becomes
reachable via one or more commits in a pack generated with
'--stdin-packs', you *have* to include that object in the MIDX via the
copy in the cruft pack, otherwise we cannot generate reachability
bitmaps for any commits which reach that object.

Note that the traversal here is best-effort, similar to the existing
traversal which provides name-hash hints. This means that the object
traversal may hand us back a blob that does not actually exist. We
*won't* see missing trees/commits with 'ignore_missing_links' because:

 - missing commit parents are discarded at the commit traversal stage by
   revision.c::process_parents()

 - missing tag objects are discarded by revision.c::handle_commit()

 - missing tree objects are discarded by the list-objects code in
   list-objects.c::process_tree()

But we have to handle potentially-missing blobs specially by making a
separate check to ensure they exist in the repository. Failing to do so
would mean that we'd add an object to the packing list which doesn't
actually exist, rendering us unable to write out the pack.

This prepares us for new repacking behavior which will "resurrect"
objects found in cruft or otherwise unspecified packs when generating
new packs. In the context of geometric repacking, this may be used to
maintain a sequence of geometrically-repacked packs, the union of which
is closed under reachability, even in the case described earlier.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc |  10 ++-
 builtin/pack-objects.c              |  86 +++++++++++++++-----
 t/t5331-pack-objects-stdin.sh       | 120 ++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index b1c5aa27da..eba014c406 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -87,13 +87,21 @@ base-name::
 	reference was included in the resulting packfile.  This
 	can be useful to send new tags to native Git clients.
 
---stdin-packs::
+--stdin-packs[=<mode>]::
 	Read the basenames of packfiles (e.g., `pack-1234abcd.pack`)
 	from the standard input, instead of object names or revision
 	arguments. The resulting pack contains all objects listed in the
 	included packs (those not beginning with `^`), excluding any
 	objects listed in the excluded packs (beginning with `^`).
 +
+When `mode` is "follow", objects from packs not listed on stdin receive
+special treatment. Objects within unlisted packs will be included if
+those objects are (1) reachable from the included packs, and (2) not
+found in any excluded packs. This mode is useful, for example, to
+resurrect once-unreachable objects found in cruft packs to generate
+packs which are closed under reachability up to the boundary set by the
+excluded packs.
++
 Incompatible with `--revs`, or options that imply `--revs` (such as
 `--all`), with the exception of `--unpacked`, which is compatible.
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f44447a3f9..d51fe9c820 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -284,6 +284,12 @@ static struct oidmap configured_exclusions;
 static struct oidset excluded_by_config;
 static int name_hash_version = -1;
 
+enum stdin_packs_mode {
+	STDIN_PACKS_MODE_NONE,
+	STDIN_PACKS_MODE_STANDARD,
+	STDIN_PACKS_MODE_FOLLOW,
+};
+
 /**
  * Check whether the name_hash_version chosen by user input is appropriate,
  * and also validate whether it is compatible with other features.
@@ -3749,31 +3755,47 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 }
 
 static void show_object_pack_hint(struct object *object, const char *name,
-				  void *data UNUSED)
+				  void *data)
 {
-	struct object_entry *oe = packlist_find(&to_pack, &object->oid);
-	if (!oe)
-		return;
+	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
+	if (mode == STDIN_PACKS_MODE_FOLLOW) {
+		if (object->type == OBJ_BLOB && !has_object(the_repository,
+							    &object->oid, 0))
+			return;
+		add_object_entry(&object->oid, object->type, name, 0);
+	} else {
+		struct object_entry *oe = packlist_find(&to_pack, &object->oid);
+		if (!oe)
+			return;
 
-	/*
-	 * Our 'to_pack' list was constructed by iterating all objects packed in
-	 * included packs, and so doesn't have a non-zero hash field that you
-	 * would typically pick up during a reachability traversal.
-	 *
-	 * Make a best-effort attempt to fill in the ->hash and ->no_try_delta
-	 * fields here in order to perhaps improve the delta selection
-	 * process.
-	 */
-	oe->hash = pack_name_hash_fn(name);
-	oe->no_try_delta = name && no_try_delta(name);
+		/*
+		 * Our 'to_pack' list was constructed by iterating all
+		 * objects packed in included packs, and so doesn't have
+		 * a non-zero hash field that you would typically pick
+		 * up during a reachability traversal.
+		 *
+		 * Make a best-effort attempt to fill in the ->hash and
+		 * ->no_try_delta fields here in order to perhaps
+		 * improve the delta selection process.
+		 */
+		oe->hash = pack_name_hash_fn(name);
+		oe->no_try_delta = name && no_try_delta(name);
 
-	stdin_packs_hints_nr++;
+		stdin_packs_hints_nr++;
+	}
 }
 
-static void show_commit_pack_hint(struct commit *commit UNUSED,
-				  void *data UNUSED)
+static void show_commit_pack_hint(struct commit *commit, void *data)
 {
+	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
+
+	if (mode == STDIN_PACKS_MODE_FOLLOW) {
+		show_object_pack_hint((struct object *)commit, "", data);
+		return;
+	}
+
 	/* nothing to do; commits don't have a namehash */
+
 }
 
 static int pack_mtime_cmp(const void *_a, const void *_b)
@@ -3881,7 +3903,7 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 
 static void add_unreachable_loose_objects(struct rev_info *revs);
 
-static void read_stdin_packs(int rev_list_unpacked)
+static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 {
 	struct rev_info revs;
 
@@ -3913,7 +3935,7 @@ static void read_stdin_packs(int rev_list_unpacked)
 	traverse_commit_list(&revs,
 			     show_commit_pack_hint,
 			     show_object_pack_hint,
-			     NULL);
+			     &mode);
 
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_found",
 			   stdin_packs_found_nr);
@@ -4795,6 +4817,23 @@ static int is_not_in_promisor_pack(struct commit *commit, void *data) {
 	return is_not_in_promisor_pack_obj((struct object *) commit, data);
 }
 
+static int parse_stdin_packs_mode(const struct option *opt, const char *arg,
+				  int unset)
+{
+	enum stdin_packs_mode *mode = opt->value;
+
+	if (unset)
+		*mode = STDIN_PACKS_MODE_NONE;
+	else if (!arg || !*arg)
+		*mode = STDIN_PACKS_MODE_STANDARD;
+	else if (!strcmp(arg, "follow"))
+		*mode = STDIN_PACKS_MODE_FOLLOW;
+	else
+		die(_("invalid value for '%s': '%s'"), opt->long_name, arg);
+
+	return 0;
+}
+
 int cmd_pack_objects(int argc,
 		     const char **argv,
 		     const char *prefix,
@@ -4805,7 +4844,7 @@ int cmd_pack_objects(int argc,
 	struct strvec rp = STRVEC_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	int rev_list_index = 0;
-	int stdin_packs = 0;
+	enum stdin_packs_mode stdin_packs = STDIN_PACKS_MODE_NONE;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
@@ -4860,6 +4899,9 @@ int cmd_pack_objects(int argc,
 		OPT_SET_INT_F(0, "indexed-objects", &rev_list_index,
 			      N_("include objects referred to by the index"),
 			      1, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "stdin-packs", &stdin_packs, N_("mode"),
+			     N_("read packs from stdin"),
+			     PARSE_OPT_OPTARG, parse_stdin_packs_mode),
 		OPT_BOOL(0, "stdin-packs", &stdin_packs,
 			 N_("read packs from stdin")),
 		OPT_BOOL(0, "stdout", &pack_to_stdout,
@@ -5150,7 +5192,7 @@ int cmd_pack_objects(int argc,
 		progress_state = start_progress(the_repository,
 						_("Enumerating objects"), 0);
 	if (stdin_packs) {
-		read_stdin_packs(rev_list_unpacked);
+		read_stdin_packs(stdin_packs, rev_list_unpacked);
 	} else if (cruft) {
 		read_cruft_objects();
 	} else if (!use_internal_rev_list) {
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index 8fd07deb8d..4a8df5a389 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -236,4 +236,124 @@ test_expect_success 'pack-objects --stdin with packfiles from main and alternate
 	test_cmp expected-objects actual-objects
 '
 
+objdir=.git/objects
+packdir=$objdir/pack
+
+objects_in_packs () {
+	for p in "$@"
+	do
+		git show-index <"$packdir/pack-$p.idx" || return 1
+	done >objects.raw &&
+
+	cut -d' ' -f2 objects.raw | sort &&
+	rm -f objects.raw
+}
+
+test_expect_success '--stdin-packs=follow walks into unknown packs' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+
+		for c in A B C D
+		do
+			test_commit "$c" || return 1
+		done &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
+		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
+		D="$(echo C..D | git pack-objects --revs $packdir/pack)" &&
+		test_commit E &&
+
+		git prune-packed &&
+
+		cat >in <<-EOF &&
+		pack-$B.pack
+		^pack-$C.pack
+		pack-$D.pack
+		EOF
+
+		# With just --stdin-packs, pack "A" is unknown to us, so
+		# only objects from packs "B" and "D" are included in
+		# the output pack.
+		P=$(git pack-objects --stdin-packs $packdir/pack <in) &&
+		objects_in_packs $B $D >expect &&
+		objects_in_packs $P >actual &&
+		test_cmp expect actual &&
+
+		# But with --stdin-packs=follow, objects from both
+		# included packs reach objects from the unknown pack, so
+		# objects from pack "A" is included in the output pack
+		# in addition to the above.
+		P=$(git pack-objects --stdin-packs=follow $packdir/pack <in) &&
+		objects_in_packs $A $B $D >expect &&
+		objects_in_packs $P >actual &&
+		test_cmp expect actual &&
+
+		# And with --unpacked, we will pick up objects from unknown
+		# packs that are reachable from loose objects. Loose object E
+		# reaches objects in pack A, but there are three excluded packs
+		# in between.
+		#
+		# The resulting pack should include objects reachable from E
+		# that are not present in packs B, C, or D, along with those
+		# present in pack A.
+		cat >in <<-EOF &&
+		^pack-$B.pack
+		^pack-$C.pack
+		^pack-$D.pack
+		EOF
+
+		P=$(git pack-objects --stdin-packs=follow --unpacked \
+			$packdir/pack <in) &&
+
+		{
+			objects_in_packs $A &&
+			git rev-list --objects --no-object-names D..E
+		}>expect.raw &&
+		sort expect.raw >expect &&
+		objects_in_packs $P >actual &&
+		test_cmp expect actual
+	)
+'
+
+stdin_packs__follow_with_only () {
+	rm -fr stdin_packs__follow_with_only &&
+	git init stdin_packs__follow_with_only &&
+	(
+		cd stdin_packs__follow_with_only &&
+
+		test_commit A &&
+		test_commit B &&
+
+		git rev-parse "$@" >B.objects &&
+
+		echo A | git pack-objects --revs $packdir/pack &&
+		B="$(git pack-objects $packdir/pack <B.objects)" &&
+
+		git cat-file --batch-check="%(objectname)" --batch-all-objects >objs &&
+		for obj in $(cat objs)
+		do
+			rm -f $objdir/$(test_oid_to_path $obj) || return 1
+		done &&
+
+		( cd $packdir && ls pack-*.pack ) >in &&
+		git pack-objects --stdin-packs=follow --stdout >/dev/null <in
+	)
+}
+
+test_expect_success '--stdin-packs=follow tolerates missing blobs' '
+	stdin_packs__follow_with_only HEAD HEAD^{tree}
+'
+
+test_expect_success '--stdin-packs=follow tolerates missing trees' '
+	stdin_packs__follow_with_only HEAD HEAD:B.t
+'
+
+test_expect_success '--stdin-packs=follow tolerates missing commits' '
+	stdin_packs__follow_with_only HEAD HEAD^{tree}
+'
+
 test_done
-- 
2.50.0.61.gf819b10624.dirty

