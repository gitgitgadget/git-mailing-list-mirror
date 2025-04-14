Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4607A1DDA2D
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661195; cv=none; b=MW3JD8/Ow9it5tLH1I9SwPvnkimFz2x6BSTVS6xRVy31+YujeJl0QvZNRbppxX8HJBlMfEOWaEvdxt0a3y64wC0814TEBPB12Wc/Or9X0mZSb9XUmrTVOKj1adRHJHKvDtfOfkLNVTbYYhbmq7IIN/t8CfHdmY8pS8wFyvarVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661195; c=relaxed/simple;
	bh=P07EtRFJXxZ64wR2XYSGHNn30k4Fp41j1SmtQ3QINog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2e9DtD1cx0VzsXpP6Cl/PcwlMboJWxLsGVKrVyRU7fcNU2k3xmNMpwNc3C/yvAUc/Si1y0fORJPkb/TKNh33Hj+brZb7It+/SOOuXO0YVGaHdNQYEDvve62dHghsht+MmuWbAA3lV7a2Ph8k955s6SsikSldoVb6q2TzR1Eo3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=efzsRqcp; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="efzsRqcp"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4774d68c670so66787371cf.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744661192; x=1745265992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JuuZkOq2oPu35UqOkIJL5MzrHEpKGzPo4RzTMsy/qdU=;
        b=efzsRqcpQcmTmP/3vuZtqf90Xs59GHDBD1GwZzSHfLualUmSMV9geywsW1bMk6nOpb
         WYBOrK6dF7gQMKANsvlhuu7ItH6xofcxa4q9/u92Sqiv6+2QpmmDjMokql9rspRSXn9f
         cg8YD4jQUNEGdjtDJvic+ZElOFKvJGINfdt/yc1MLClxJ5aoU1bmzo+0fNlrhN47GpeQ
         qpooB1/NCYOSkCGSxNihF3sDgLYaeEK8hXortzH7Hwng2UmJiaqC6NT4buWDMRNxGChY
         3HJd6hyCyOxQMqxVwQ60CZCaHtiBYCnxJBE7AZwzmXVRpGSYgrVtEiA4kEYJuX84d3aG
         qWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661192; x=1745265992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuuZkOq2oPu35UqOkIJL5MzrHEpKGzPo4RzTMsy/qdU=;
        b=o3IyrFhaKnflArMDtkd2gMjWSbHqyUhplJ8sxCtTLVQr8+VA3HjqiIzqD7QA3r8JVw
         BgX6igfJ3UuVIDboUJpwKnnwt3qR2eCvyPq9yfvrxbhH0ISLsercmRKhg4kaQvw27oHv
         MCwbmb/6Y9bkbsibEcCFxLmuHFTcbZLPEjYKvCAo/IkE3bbVXoPM4nkE3T8FWmdEG7RR
         viR8zGAwg7DVRFQWnWxLkD60cvHewUIEe5oBkU1KJWJryMq2/lZ+u7XZOf9C01wA3QvQ
         h72Zm2bAFlHDT+v8n4jFkcVNqjlX3x8F0oAGiBrsz9imyA0hao65IqReq7TISJym0L1x
         j5Cw==
X-Gm-Message-State: AOJu0YwBgU4IvTadhJtG3paidRb6xxbbrVfIRpASDPvTIGXr8PTqFRDC
	el4+Ea1Va/qJPyAF0Cqw/oCEY5QN26xaVuM0Bv1FgP0wlq7yZv/TRn1J9NF94rd7OFtrhN/UYer
	QW/k=
X-Gm-Gg: ASbGncvPcR1HKtnzkxgEWqG/V857DHq2grPVBNZTo+J+TqJvKuKrVp6nA6fUb/+imI7
	+WXIr7EAelpcI6q3bcPn4sV1iuZS8HM1UnCLYxsNhY8qewYaA25HEyJ0AApvnLDA+DHC0JarpLF
	J7Xj/XOdt1fKjnRYIGT1hYymyYrlKQ2comOZZtypEyE8OoYZRBI4hvqSWQK17gsXwZ2gseiiFsN
	VJFpqwr2jjSDaIibFY6XmRL9tSsCiQEUFPjvyvDMZXRAncL2Pd59Bq99KgON/bay3Lc73NKa7qj
	CzaBQYfmf1bS6W59nTpTcfisu2N7lqvosUVFIJKhx1fX42POdzRItEDWWswJoQsjlCrEg3dplWz
	VtNH/DDkACeKT
X-Google-Smtp-Source: AGHT+IHQsD58/j6Czu56W3ePJWHlDCXMIjBcoa/ZP8TQCKh0y68XKInXi19Sbg/jnAu+fxeK/girFg==
X-Received: by 2002:a05:6214:415:b0:6e6:6598:84c1 with SMTP id 6a1803df08f44-6f23f164206mr210380456d6.42.1744661191736;
        Mon, 14 Apr 2025 13:06:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea081fasm87462016d6.92.2025.04.14.13.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:06:31 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:06:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/8] pack-objects: introduce '--stdin-packs=follow'
Message-ID: <697a337cb147ed638884cf9b8605fef8b572e1c6.1744661167.git.me@ttaylorr.com>
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
2.49.0.229.gc267761125.dirty

