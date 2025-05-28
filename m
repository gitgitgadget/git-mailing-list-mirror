Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AF82222DB
	for <git@vger.kernel.org>; Wed, 28 May 2025 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474436; cv=none; b=eCXPR0r6ZnLPYiDtaAMTbKRWlkH0H6XdVtenZ5LtqbljsFFrpd8GAarb/9Bx7HKNRivacg8ubKe2c1sEO1rtluEG/4Sq3Hv/kM2IvbGUXrt91bLrPKJp2ZXynO0L6MxVk978F3qyClQKBCMEl6GthJt9s2sAaRwDN/eFzWmuCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474436; c=relaxed/simple;
	bh=SnRUJuYbe1tHuI6xru6OyKWB24uuv0LDD8411p6u/Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBxJHgkSdAylGZQKQVBWWOsgyzL9kXyUBGgm1Yt5kv9+Jmga8G4ZkrE/uxYM9In6ksf++ximFiBp0UL1X4zynQ5KFuCox85mefWQ1g9z5R++O3imypjW4074gUHbcLOlTRONM3Rhf3Qk03lC9RuMaRA5/Q+hFyhYJOnFkEFVqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bNoPZlmr; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bNoPZlmr"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70ccb7effb0so3309267b3.0
        for <git@vger.kernel.org>; Wed, 28 May 2025 16:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748474433; x=1749079233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PaEpSuBR6F+nr0JelS17rLNiHDecWUSrF5+aGwp8hp8=;
        b=bNoPZlmr+rKRobuAvHgJkr/t2Vg9vl28JSa0g0B1OaIyQq9IH26pY/eWzCBgJRGBEj
         YjthhuAF5+abGZ6IqpCJEIXCQu0zDWl8khkd17mpRoykQdTBKLJaHfqQHr5pHGGL5Cc7
         b32vOxpKVsWIFlaXwGBDXuLuLN7ocVf3hIJGp35p975KayKUwflqYLVL2c9LZEFtCgad
         MplAqkEiKacAOvJbXIXkCGU2CS2gcWw313uYgGU9TmE+T8MMjVDRLHHcxzRW4PiV1kk2
         Fw3ou/t2m2Fie/WANHqs7N4+617JuaOb4hkowSVFDPIdvEDY7W1OsduTtd3VUlKP7cDM
         5+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748474433; x=1749079233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaEpSuBR6F+nr0JelS17rLNiHDecWUSrF5+aGwp8hp8=;
        b=mRn93aDz3tB6R1+c1pYz7noAubPErbVJ8BWmgwL6tmvFRlg25qSrfRR98Vtn5Djihu
         K37NFemnP445XiWFKQAZ1CM1VVatp/dz4BzwJHpWrMo1YR/4UFE1kZCUQezGR/x2m1uf
         2DzOhtBljS0wRCNgq7nRWt1kw9ECAisuXYVhu8RM8P3rpXdS9PEj5gPOaxCGKoXqDAtY
         aMliaLOXe3C5pKTSPRuOTsBNRBz9h2/FUBOGaTpF+EpSl6Czw6KB25crDkAfqQFSmujY
         vXE47XjXAczoXlaaV6hEzOPn4gtlMFE8ULxkyRd2KrMx2vj4l/hzh14ZE04+On4MrCBY
         VzJA==
X-Gm-Message-State: AOJu0YzSWmXPy5QRtpdFmLEDhTDbfsL57LeBGdB/quIOrndYcko7ahTO
	CRNavLLNKb2iSV936XPtPEW3ScM7n2buG4uBROwyk6WTLukx/l2wbtG2vnP9Jhtso5X4Wrut6XE
	Mn2/u
X-Gm-Gg: ASbGncs4Q4bFEMHCnm1Y1r8naT2lVbCJTRtBi9vxEhEnyt6ifihj/T3WWgOfq3oIb7V
	i+IcMHaA+ckOh2TTSSn5zcIyvR+cjqXN6R55/EGuQsJ928AHANWJnn8UzeF/744z9lWvq8elZHF
	8b6pOR0xkLMD3YdT3bDE9GphTcOIArwzlSkp/Ux+Jh1xp8J3hZtWGUimBX4wtbXUDH3x7LNAP66
	aINiRz8wNZEQce1di/CxdOqPvaJvnv0K9XQwFVwSNOUNoGcOrCxQCOW6yCv11gRUD+53rQ1kv26
	cnj9tut4OZbDxm6ZHHWhDWtlbGNbz2waXB+ay1qucVSHQLTVhp2Aub7CWH8O8icrV5grFuKilPr
	XSDAim31kddxfSX20amjNcVc=
X-Google-Smtp-Source: AGHT+IGR9gqKTB213wEHomq9/ImT6sM3cpZFap0UQ7uR5tmNpYwBI1vbbk/gy4c+dZd0j2YHR2oqlA==
X-Received: by 2002:a05:690c:3685:b0:70e:2246:1999 with SMTP id 00721157ae682-70e2da0eba5mr247440607b3.21.1748474433238;
        Wed, 28 May 2025 16:20:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8acfd4b0sm351317b3.97.2025.05.28.16.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:20:32 -0700 (PDT)
Date: Wed, 28 May 2025 19:20:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 8/9] pack-objects: introduce '--stdin-packs=follow'
Message-ID: <3e3d929bd023a6909efef0cde47d873e4ef5c7dc.1748473890.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1748473889.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748473889.git.me@ttaylorr.com>

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
 Documentation/git-pack-objects.adoc | 10 +++-
 builtin/pack-objects.c              | 83 +++++++++++++++++++++--------
 t/t5331-pack-objects-stdin.sh       | 82 ++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 7f69ae4855..8f0cecaec9 100644
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
index d3dfe983c3..c6ec346369 100644
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
@@ -3514,31 +3520,44 @@ static int add_object_entry_from_pack(const struct object_id *oid,
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
@@ -3646,7 +3665,7 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 
 static void add_unreachable_loose_objects(struct rev_info *revs);
 
-static void read_stdin_packs(int rev_list_unpacked)
+static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 {
 	struct rev_info revs;
 
@@ -3678,7 +3697,7 @@ static void read_stdin_packs(int rev_list_unpacked)
 	traverse_commit_list(&revs,
 			     show_commit_pack_hint,
 			     show_object_pack_hint,
-			     NULL);
+			     &mode);
 
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_found",
 			   stdin_packs_found_nr);
@@ -4469,6 +4488,23 @@ static int is_not_in_promisor_pack(struct commit *commit, void *data) {
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
@@ -4480,7 +4516,7 @@ int cmd_pack_objects(int argc,
 	struct strvec rp = STRVEC_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	int rev_list_index = 0;
-	int stdin_packs = 0;
+	enum stdin_packs_mode stdin_packs = STDIN_PACKS_MODE_NONE;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
@@ -4535,6 +4571,9 @@ int cmd_pack_objects(int argc,
 		OPT_SET_INT_F(0, "indexed-objects", &rev_list_index,
 			      N_("include objects referred to by the index"),
 			      1, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "stdin-packs", &stdin_packs, N_("mode"),
+			     N_("read packs from stdin"),
+			     PARSE_OPT_OPTARG, parse_stdin_packs_mode),
 		OPT_BOOL(0, "stdin-packs", &stdin_packs,
 			 N_("read packs from stdin")),
 		OPT_BOOL(0, "stdout", &pack_to_stdout,
@@ -4791,7 +4830,7 @@ int cmd_pack_objects(int argc,
 		progress_state = start_progress(the_repository,
 						_("Enumerating objects"), 0);
 	if (stdin_packs) {
-		read_stdin_packs(rev_list_unpacked);
+		read_stdin_packs(stdin_packs, rev_list_unpacked);
 	} else if (cruft) {
 		read_cruft_objects();
 	} else if (!use_internal_rev_list) {
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index 8fd07deb8d..60a2b4bc07 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -236,4 +236,86 @@ test_expect_success 'pack-objects --stdin with packfiles from main and alternate
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
 test_done
-- 
2.49.0.640.ga4de40e6a8

