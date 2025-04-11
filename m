Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8B2BE7A2
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744414000; cv=none; b=YGQNdppCEjb1WbfustiU3paseqrNIQLqJpA1R67wGcFCOm8lwz/i2YeT4ggudd4FyZJM1A+KUw2QrhjiAT4DmhgPkUjtF4k9Ts3TYYv3NYfPz+Kzy1fh+4sl/zLwKWAomtqgWtUBdWqEoyLCgXjV8WulvXdO1ZXk4AyaYPo1QHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744414000; c=relaxed/simple;
	bh=+cLEM0zpvYjVGGrsBnpqme76sCTexVUMzbqfcsYAgWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQzCc7GU628xZRio799nYtfgfBiT31zwnn//RCSZhTrZQRF9nGNV3Y/VUYegHmX0dUJuAP4AmovSMsRYNNqqRwXYvBPTrkISqN3bZ99oN6HVPDmt3bP+HDaipFBiOE1rG3Jm+O6izMrrelqkkAvCzdg/DPhZAj/wY+PaTCq+Oa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wP6v1lwD; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wP6v1lwD"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ecf99dd567so29576686d6.0
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 16:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744413997; x=1745018797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xBgJmMJ+G2Cje2oi/p2jzhsYwCCHJR0OCUAsfpMku6w=;
        b=wP6v1lwDm/YBCd/nWmVo+o6OaSUKGCtux4x6UsqdqAViDgbgJpIWFgZgt3AHLPcq/w
         fqTdtP0XizhvQ5UC4/kdrlDt0VYhzqgvT5rkHww+9q3xObb/Pxn2/EY303YTNUp6kUhW
         xAUVi+IXvAd1QxZUOUQWb1FmdMPfRHe10uWh73brNl8cZV6UKrVMnNM3cYGNmB4IiA23
         d26f1sOBycrJ/GBnbX9q0FZzsQPtuJBmtNOtv16BcXd4fjLM5VShE4T1bUUhWLoTwUuG
         p024fvwB+MWELtAVm2/ua3cmz5UwnHMy8MGxceyPeNAnGBifaUbqylcfoO7T7HezNHtC
         7lvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744413997; x=1745018797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBgJmMJ+G2Cje2oi/p2jzhsYwCCHJR0OCUAsfpMku6w=;
        b=GCReZYwTP8uLQcozPrjUYYqfp66y/D0wfJnSNfjUGVI6TAdriF7Twiwk03IfG8Vnxt
         E8ymoFYUCiK0QdyJd9w07mFqzxnNkKI8ltzAxtqnUSOzIq02L1g2dcaPs+2CJs0E1OvU
         0QBDe9cAA8ziz3pglX7WVyaTG7teuSLLQdHlm+Zz1DAj0/ofijoaesrULU7lqe82V9Xz
         7kAD5E32PVurT4ykPzy7z84kiU4+5V2gCj0veYM8nnLLSXP+SWymwamBgagGNjWruAHI
         AYz1EbOAsAOJv/zgyXb7HQ7qV8KSADAZZKA6PFT7BAiT55Vd4qAfREBrslMwLlTUKDN3
         4VUA==
X-Gm-Message-State: AOJu0Yzik62hyiAc2+3lhFYm4vt/FlfUZRQXKDvlSdCgv0CIhRCWv+2Y
	qZWZQtspeG3PNYDAaBgWR1tGm/XmMWXjac6SYSy/c2yhclr0PN+BFI7PVK4WuBZWU49ctV91G2D
	gDj0=
X-Gm-Gg: ASbGnctUs8wSj1hI6PGs6Xc/ub8E4jeqz9DarRcQ5tlOekfVJcR/xesi/mT3EPfvK8o
	psOdVmUWI/NHcxUEozofIurHHZPcf3fFjoYU8dlTwRSm3WCAmU9h78//0CppmqVUAp8muxYEfHR
	p5YIXVNDKm0pDp8NnB9sdWX0PJtsJvRDSTzuq0Y8GR11o/O/YROlXU6joBuvjT9yHRrcNEVSW/A
	qgOGs8ukAb8PNSv069qrCM7xUFUwYiDH3kfZ8OYupn+bD6c+Ff6+vJwJO0RgnG95c9u6ajrMGrg
	LrILGJtNLCLiIY174wAxXOT6N0r2oMsbGJ8nwRUjf3bTZec21cVMnRo4eOKxeLpmbGQbXuWqIld
	FbGE01IhTC2JOqh6JuY8Rx0o=
X-Google-Smtp-Source: AGHT+IEt3kOa11bg+vYyhhBDITTnCmcYLK08DC0WvNKTXt82qM+DCS2/nLz3aNwN719R+6t2MHqXVg==
X-Received: by 2002:ad4:5bc9:0:b0:6e8:fee2:aadb with SMTP id 6a1803df08f44-6f230dc06ffmr75618506d6.27.1744413996678;
        Fri, 11 Apr 2025 16:26:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de95fd90sm42752916d6.11.2025.04.11.16.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 16:26:36 -0700 (PDT)
Date: Fri, 11 Apr 2025 19:26:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 6/8] pack-objects: introduce '--stdin-packs=follow'
Message-ID: <a0318321ece4c7f7bcffe85c1e4d5cc85a673bdd.1744413969.git.me@ttaylorr.com>
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

This prepares us for new repacking behavior which will "resurrect"
objects found in cruft or otherwise unspecified packs when generating
new packs. In the context of geometric repacking, this may be used to
maintain a sequence of geometrically-repacked packs, the union of which
is closed under reachability, even in the case described earlier.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc |   8 ++-
 builtin/pack-objects.c              |  89 +++++++++++++++++-------
 t/t5331-pack-objects-stdin.sh       | 101 ++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 7f69ae4855..c894582799 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -87,13 +87,19 @@ base-name::
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
+When `mode` is "follow", pack objects which are reachable from objects
+in the included packs, but appear in packs that are not listed.
+Reachable objects which appear in excluded packs are not packed. Useful
+for resurrecting once-cruft objects to generate packs which are closed
+under reachability up to the excluded packs.
++
 Incompatible with `--revs`, or options that imply `--revs` (such as
 `--all`), with the exception of `--unpacked`, which is compatible.
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2aa12da4af..6406f4a5b1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -272,6 +272,12 @@ static struct oidmap configured_exclusions;
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
@@ -3511,32 +3517,43 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 	return 0;
 }
 
-static void show_commit_pack_hint(struct commit *commit UNUSED,
-				  void *data UNUSED)
-{
-	/* nothing to do; commits don't have a namehash */
-}
-
 static void show_object_pack_hint(struct object *object, const char *name,
-				  void *data UNUSED)
+				  void *data)
 {
-	struct object_entry *oe = packlist_find(&to_pack, &object->oid);
-	if (!oe)
+	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
+	if (mode == STDIN_PACKS_MODE_FOLLOW) {
+		add_object_entry(&object->oid, object->type, name, 0);
+	} else {
+		struct object_entry *oe = packlist_find(&to_pack, &object->oid);
+		if (!oe)
+			return;
+
+		/*
+		 * Our 'to_pack' list was constructed by iterating all
+		 * objects packed in included packs, and so doesn't
+		 * have a non-zero hash field that you would typically
+		 * pick up during a reachability traversal.
+		 *
+		 * Make a best-effort attempt to fill in the ->hash
+		 * and ->no_try_delta here using a now in order to
+		 * perhaps improve the delta selection process.
+		 */
+		oe->hash = pack_name_hash_fn(name);
+		oe->no_try_delta = name && no_try_delta(name);
+
+		stdin_packs_hints_nr++;
+	}
+}
+
+static void show_commit_pack_hint(struct commit *commit, void *data)
+{
+	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
+	if (mode == STDIN_PACKS_MODE_FOLLOW) {
+		show_object_pack_hint((struct object *)commit, "", data);
 		return;
+	}
+	/* nothing to do; commits don't have a namehash */
 
-	/*
-	 * Our 'to_pack' list was constructed by iterating all objects packed in
-	 * included packs, and so doesn't have a non-zero hash field that you
-	 * would typically pick up during a reachability traversal.
-	 *
-	 * Make a best-effort attempt to fill in the ->hash and ->no_try_delta
-	 * here using a now in order to perhaps improve the delta selection
-	 * process.
-	 */
-	oe->hash = pack_name_hash_fn(name);
-	oe->no_try_delta = name && no_try_delta(name);
-
-	stdin_packs_hints_nr++;
 }
 
 static int pack_mtime_cmp(const void *_a, const void *_b)
@@ -3644,7 +3661,7 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 
 static void add_unreachable_loose_objects(struct rev_info *revs);
 
-static void read_stdin_packs(int rev_list_unpacked)
+static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 {
 	struct rev_info revs;
 
@@ -3676,7 +3693,7 @@ static void read_stdin_packs(int rev_list_unpacked)
 	traverse_commit_list(&revs,
 			     show_commit_pack_hint,
 			     show_object_pack_hint,
-			     NULL);
+			     &mode);
 
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_found",
 			   stdin_packs_found_nr);
@@ -4467,6 +4484,23 @@ static int is_not_in_promisor_pack(struct commit *commit, void *data) {
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
@@ -4478,7 +4512,7 @@ int cmd_pack_objects(int argc,
 	struct strvec rp = STRVEC_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	int rev_list_index = 0;
-	int stdin_packs = 0;
+	enum stdin_packs_mode stdin_packs = STDIN_PACKS_MODE_NONE;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
@@ -4533,6 +4567,9 @@ int cmd_pack_objects(int argc,
 		OPT_SET_INT_F(0, "indexed-objects", &rev_list_index,
 			      N_("include objects referred to by the index"),
 			      1, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "stdin-packs", &stdin_packs, N_("mode"),
+			     N_("read packs from stdin"),
+			     PARSE_OPT_OPTARG, parse_stdin_packs_mode),
 		OPT_BOOL(0, "stdin-packs", &stdin_packs,
 			 N_("read packs from stdin")),
 		OPT_BOOL(0, "stdout", &pack_to_stdout,
@@ -4788,7 +4825,7 @@ int cmd_pack_objects(int argc,
 		progress_state = start_progress(the_repository,
 						_("Enumerating objects"), 0);
 	if (stdin_packs) {
-		read_stdin_packs(rev_list_unpacked);
+		read_stdin_packs(stdin_packs, rev_list_unpacked);
 	} else if (cruft) {
 		read_cruft_objects();
 	} else if (!use_internal_rev_list) {
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index 4f5e2733a2..f97d2d1b71 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -236,4 +236,105 @@ test_expect_success 'pack-objects --stdin with packfiles from main and alternate
 	test_cmp expected-objects actual-objects
 '
 
+packdir=.git/objects/pack
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
+test_expect_success 'setup for --stdin-packs=follow' '
+	git init stdin-packs--follow &&
+	(
+		cd stdin-packs--follow &&
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
+
+		git prune-packed
+	)
+'
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
+		test_commit E &&
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
 test_done
-- 
2.49.0.229.g19b69c1246

