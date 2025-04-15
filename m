Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19662BF3CB
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757237; cv=none; b=GZXVUHnSOGZzZIkp6UKId4PRE/bQHhVlFjfDwPiHkr2fh9ej/+Ka+eWCiizF8efSl2GqT34Q1D/BSp6rzNfL49N8PNwiu7jMiSOUT/aTO2EBAkdMYGE/Riuw9XYMhArv7c/0/E/VF0lVKytiWouupDSTIz4EUcW1ygNMc/gjIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757237; c=relaxed/simple;
	bh=KggbUgs3x5kddYLqvSSiLhf1O2bGTc8JTjZq7UmOJ6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpg8JVhuw6+EY3xGkz8Ksufp5lzxt+iSlDNSu+zIbCK5oECUxhm4OkyOZ8yxAb8sExeHcdCxmJEsX2T6fyW5fryZfdLmDVF2xvFQwVKdY9XETVB74OflbvVO1TpPVk1hRrGHh/hV9VpPNDSHaPZzYX7tDCpLndPtvjxLkE5YUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=C1lO43NO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="C1lO43NO"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4775ccf3e56so1592961cf.0
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744757233; x=1745362033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dj0O55QR9L2Dg5EFiN37xW7Ns7WfgqrPzKVJ+G+GPHo=;
        b=C1lO43NOt9lVA6m2GAYRnuIoYYj0kZ/KgGbW/CBVRbEXxyD8IWCokL4Stvm8IjlWrl
         Q+mwSuPiEwDLpw817BIgAjfs+OIRa7hRIHzZDxjHCn9H+01Pt+qVaDWZeLVy4KfeAmZ7
         DidJ6I4/4ZvA/xlf+nr/5T+/aVCvlDxkRdcHm30Oblk+rs8uCcljlLBnUiDdA3+7qtT5
         upn9TK8K92Icomeb8OjY3jWlDK5ZfXLCro1uRrQahe9LSFG4cXG3v0icrsPGhEL50X9b
         1EtszbFBYnSDRPJURiufh1vz4hKX0b4xdmzlcfteBXmlG3QhGArkmKj8q+I2DCmLnOJS
         Gttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757233; x=1745362033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj0O55QR9L2Dg5EFiN37xW7Ns7WfgqrPzKVJ+G+GPHo=;
        b=iekY2BN0+T8EAv2C05HogSLR4DReJEBQwQfvR1khqkllJhMFPQbjbYcCmbg0nfz6K5
         R84Jh9UPoTg6G8ZGDuta/tSmXRendTWlbdNq2iuT0LuInGYE5nc307Wd4a5JDEa6Wj/5
         jYSUSkOkltaGQbva7zQpyxIiD6n+LxoXAJ4ZFAtJ6/mRjj+FHFFDXzjjOw5chMzOrobw
         +VvDfzFgW4wkrOZbRck7DfOQEEVsKDbp4eUhO13XD8yVU1QaZhooj1dkm1qUV/1guOhO
         9IsWDircfonNzH4Yz8gimGARaq9csF/GcGdY1DTqKNbOqgrHjU+b16AgS4bp96gX86db
         J6Eg==
X-Gm-Message-State: AOJu0YxOH/DLJ5LbjIcG/23cv0DS2sAgV9AtVpa33MpkNurA81w2lEmP
	3Oc1cEsVsbaARuON1XK5AJtIsKYxF2xcA1tHi9AnQvybosOoxQzlIuAv0nwtfBv+5SaQMrhzR1y
	aUCk=
X-Gm-Gg: ASbGnctUbs71xf/apis6hh4j+evl+1NMTXzZdw2tDbp0aqSocipgKkjtV2/fpwjNshe
	EnUT9o+6A/ddDXRH1zHdrnEMCZLTF/N4F6KlS0RZz6g63jvOYAePl1F+wx7B8+eleaN786x9QKc
	dFskL66alwBl62S4opWMFartyP5te/4hNOjMuEYUwWfH6ZnzVu7GQuv+rfnUeh3+zoj2MvQeP5Z
	DUmBv57GNrsfx/LBsSJzKZr/LAgMvjoUeIuNoJ2SEZi3SFMLKa2nkKM+2TcqjW2Xckax18Ee4t4
	ZdC/OLyiqJn+6FsDqZpE7dI895mPlMO0Ppo8lOznBYOIXtu+mAd2y7gLDPY1QA2gjm5MQzvWhUd
	ZYCnbsSJXqgZu
X-Google-Smtp-Source: AGHT+IG+n6iE+2ka1r/C+SOYWNl1ULDk8SCG8aNSLuQDXwsCHn3Col4GWowEnqfVqOmaZyoltCGpPg==
X-Received: by 2002:ac8:588f:0:b0:471:f482:bba7 with SMTP id d75a77b69052e-47a0780c6femr79817221cf.22.1744757233386;
        Tue, 15 Apr 2025 15:47:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8951562sm964588685a.35.2025.04.15.15.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:47:13 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:47:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 8/9] pack-objects: introduce '--stdin-packs=follow'
Message-ID: <0ff699f05636ec3373bbcd16cd082a402cda4c25.1744757204.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744757204.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744757204.git.me@ttaylorr.com>

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
index f4009cd391..67a22b2dc4 100644
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
2.49.0.230.ga662d77f78

