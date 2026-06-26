Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24473BB105
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500564; cv=none; b=chAP+ocZ8cqevwE94X6JbtXIK9+J20qWiTBJ7t6Ovf69LJcgJ24Mxt1py4jc1NJ2mGz2nFm5groknKHjB7FbbDuBIRioe5wlaG+uZyXF3CpLruqDbw5ioxaXTYqK0zGp1CN97SDQDbi7xRuyU6EfMCl7wwLND+DCsRYdDzMPxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500564; c=relaxed/simple;
	bh=yO3BBhQAVI1DEcoq/lXm/5+aBgA1NBclug3DGkJr1AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nbh5LBB5vE0CSD7QdAr8AvQSWuBE+oN85nspGDFpOdNdSB1byqIw5IS9OTImBCaWjgixt9674unT5wsley+KXMqJ13Yl/GseZ0Vcl6eS5/9Qz3IvVWR81ZucHQjt3QBdl2p9mpxlMHWS8vwh+dCWL4wIgLb7huRffY1ZWjzhuuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ix4ynBl9; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ix4ynBl9"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8000e21f014so19063477b3.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782500562; x=1783105362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+DKC2mLoCrZDdw8xvFSip8gG4Sh9w88aOtQRaEZ9hcc=;
        b=ix4ynBl992wXza4KZgHZajeN3wvrPQyFbwBUqOjb2+X+/WX+azrbb9P2IiRacm6CnG
         TZf7bmExjRqX1kzUTLz9wWrpDkDhzg4Q4N7ETXEcHy4JSjh33+n9bPmGSmUeoEQWtkHl
         HlJNzfJUzVEO2Pt+HMLqg9pcDvHVl6XA1nnALMvZ961BdnY3b8qnF+TVmVzYBteO4fyp
         2orA78OzCXru/ZE2jmgOjJvX64zmlu31HdE0B/pOe64HYNT7l5svQkUo3DFf1wCczEL5
         ms+2YZ+K+CLeEcw/wa4oye78cMqFBBFn6Rk5BKyQoUvK1C2ZMtcsMXzZwMWltZkie0Zw
         IZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782500562; x=1783105362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DKC2mLoCrZDdw8xvFSip8gG4Sh9w88aOtQRaEZ9hcc=;
        b=LW7+2If1wkMBfR1mY2Nr3LBo4KOMkzhlzkie80gSAh3PpWYlTHkJuyb2ACNFt0tPRV
         O9DYk+Aj3iEOtbyI4XtzvPzNN+f8+XfCPMf3/Q8O5TLf6UobZQYUiYVNT4Zq0he9uL4q
         YVsv5c2FZGGcXpL2CGkhqztusG1aoz7aVY1FSFLW2Kyvk/qu+huL1vc03xhYFuKgxCw3
         91+lWwMRfVsfknIkWbOtNFhg12Vxg5oHv90SrFLq5HZin1abFACjB06A6+RwTmZ1thFA
         lnDOKTyA1ENAI5cP35QB3TmXhXOGCFmUqlWAGd1lnAefgwe80C+as4+rR0bIf5cZNnVS
         Zg/g==
X-Gm-Message-State: AOJu0Yy7I7yQx+A1kW9tiMTMMeFFpEAVrcBgXd1LrWDHJIBeaRoEgQLq
	5MuWh/hHAsV9MNuv/GFLMhPH9Ea7tY//e+TIth7BiQXZnH1I3dnJZ/3ZUsdfG9aXVm/dyJqNPSs
	QCA7YOh+c0Q==
X-Gm-Gg: AfdE7clpv6x0TGk64y1RGfk7e9a0SN0MEd5TLCHZloYE8nukQBfJl56yFypllmFJGpD
	M4jFzfQYt8SCI/YohAsYhYvGdShTt8goWNXaIERlOngg8RpPEQPozxvnzuXI4393MyCjELaB/vW
	me9HuD/Td1j2AtGrIGuAzBJ8YVQN16Ihpu7taBoG7GPU44cWz1cUoJxhXxkG8uCwQ3LKwMxhnWq
	uj+Yuf2Jnhc4p4LTuUmmtKFMqJWL0wE1Crs8hU522yixaOhoeyzWx6PytSidJWLMvQP+3GKe0bk
	w19pnzoWyU3zwJ4mGxAW0J3myiSvQqkR8EGU1Uk0VAkCK78jMB2AwL6HWA6Bj67p5u/ODUFM09B
	5XVRxHfYdVcRkwFhP8C/VEY3Elad500YPCHDb8UzFxX0uNtSa1pETvcSRt4XWo9JZ1MVfUOj76P
	KdmLLlOYlrFFrJ52j1L8iN0FHxNGugaHBV0X5brZQcw5bVhxpfPltQdfYLCCcloujjwfIIRLAYn
	NJFafJPa1QJXtW99us8/wc6tQjDKD1POWCg0+0lbFXhdpIxxvZTgoYtQaUQl8atUFU0yRREb3Bh
	LWMdHw==
X-Received: by 2002:a05:690c:7303:b0:80c:4923:ced with SMTP id 00721157ae682-80c49231146mr23446947b3.41.1782500561710;
        Fri, 26 Jun 2026 12:02:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-806f10837bfsm49362517b3.45.2026.06.26.12.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:02:41 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:02:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 09/10] pack-objects: support '--refs-snapshot' with
 'follow-reachable'
Message-ID: <c9efbad60c773f0def850ecf107ddfaeb2860a16.1782500507.git.me@ttaylorr.com>
References: <cover.1782500507.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1782500507.git.me@ttaylorr.com>

The '--stdin-packs=follow-reachable' mode walks from reference tips to
determine which objects in included packs are reachable. Without a
snapshot, pack-objects discovers refs by iterating live references,
which may change between the time the repack writes the geometric pack
and the time it writes the MIDX bitmap.

If a reference is updated during that window, the set of reachable
objects seen by pack-objects may differ from the set seen by the MIDX
bitmap writer. This can cause reachable objects to end up in the cruft
pack (because pack-objects did not see the reference that makes them
reachable) rather than the geometric pack. While this does not cause
data loss, it has two undesirable consequences:

 - Reachable objects in the cruft pack cannot receive bitmap coverage
   (since the cruft pack may be excluded from the MIDX when
   'repack.midxMustContainCruft' is false).

 - Serving fetches that need those objects requires loading the cruft
   pack, which may contain many unrelated unreachable objects.

To avoid this, teach pack-objects to accept '--refs-snapshot=<path>'
when used with '--stdin-packs=follow-reachable'. The snapshot file uses
the same format as the MIDX bitmap writer: one hex OID per line, with
an optional '+' prefix for preferred bitmap commits.

'pack-objects' happily ignores the '+' prefix for indicating preferred
bitmap commits as a convenience, so that the ref-snapshot can be shared
between the MIDX generation machinery and 'pack-objects'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc |  8 +++++
 builtin/pack-objects.c              | 46 +++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index d7b2e39e76c..4ebe407cfaf 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -133,6 +133,14 @@ commits and annotated tag objects.
 Incompatible with `--revs`, or options that imply `--revs` (such as
 `--all`), with the exception of `--unpacked`, which is compatible.
 
+--refs-snapshot=<path>::
+	When used with `--stdin-packs=follow-reachable`, read reference
+	tips from `<path>` instead of iterating live references. The file
+	format is one hex object ID per line, with an optional `+` prefix
+	(for preferred bitmap commits). This ensures a consistent view of
+	references when the same snapshot is shared with other tools (e.g.,
+	the MIDX bitmap writer).
+
 --cruft::
 	Packs unreachable objects into a separate "cruft" pack, denoted
 	by the existence of a `.mtimes` file. Typically used by `git
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5d96757b645..082ff760abc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -219,6 +219,7 @@ static int incremental;
 static int ignore_packed_keep_on_disk;
 static int ignore_packed_keep_in_core;
 static int ignore_packed_keep_in_core_open;
+static const char *stdin_packs_refs_snapshot;
 static int ignore_packed_keep_in_core_has_cruft;
 static int allow_ofs_delta;
 static struct pack_idx_option pack_idx_opts;
@@ -4009,6 +4010,38 @@ static int add_ref_to_pending(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
+static void read_refs_snapshot(const char *refs_snapshot,
+			      struct rev_info *revs)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct object_id oid;
+	FILE *f = xfopen(refs_snapshot, "r");
+
+	while (strbuf_getline(&buf, f) != EOF) {
+		struct object *object;
+		const char *hex = buf.buf;
+		const char *end = NULL;
+
+		if (*hex == '+')
+			hex++;
+
+		if (parse_oid_hex_algop(hex, &oid, &end,
+					the_repository->hash_algo) < 0)
+			die(_("could not parse line: %s"), buf.buf);
+		if (*end)
+			die(_("malformed line: %s"), buf.buf);
+
+		object = parse_object(the_repository, &oid);
+		if (!object)
+			continue;
+
+		add_pending_object(revs, object, "");
+	}
+
+	fclose(f);
+	strbuf_release(&buf);
+}
+
 static void stdin_packs_add_reachable_pack_entries(struct string_list *keys,
 						   struct rev_info *revs,
 						   int rev_list_unpacked)
@@ -4065,8 +4098,11 @@ static void stdin_packs_add_reachable_pack_entries(struct string_list *keys,
 	pre_walk.keep_pack_cache_flags |= KEPT_PACK_IN_CORE;
 	pre_walk.ignore_missing_links = 1;
 
-	refs_for_each_ref(get_main_ref_store(the_repository),
-			  add_ref_to_pending, &pre_walk);
+	if (stdin_packs_refs_snapshot)
+		read_refs_snapshot(stdin_packs_refs_snapshot, &pre_walk);
+	else
+		refs_for_each_ref(get_main_ref_store(the_repository),
+				  add_ref_to_pending, &pre_walk);
 
 	if (prepare_revision_walk(&pre_walk))
 		die(_("revision walk setup failed"));
@@ -5267,6 +5303,8 @@ int cmd_pack_objects(int argc,
 		OPT_CALLBACK_F(0, "stdin-packs", &stdin_packs, N_("mode"),
 			     N_("read packs from stdin"),
 			     PARSE_OPT_OPTARG, parse_stdin_packs_mode),
+		OPT_FILENAME(0, "refs-snapshot", &stdin_packs_refs_snapshot,
+			     N_("refs snapshot for follow-reachable traversal")),
 		OPT_BOOL(0, "stdout", &pack_to_stdout,
 			 N_("output pack to stdout")),
 		OPT_BOOL(0, "include-tag", &include_tag,
@@ -5484,6 +5522,10 @@ int cmd_pack_objects(int argc,
 	if (stdin_packs && use_internal_rev_list)
 		die(_("cannot use internal rev list with --stdin-packs"));
 
+	if (stdin_packs_refs_snapshot &&
+	    stdin_packs != STDIN_PACKS_MODE_FOLLOW_REACHABLE)
+		die(_("--refs-snapshot can only be used with --stdin-packs=follow-reachable"));
+
 	if (cruft) {
 		if (use_internal_rev_list)
 			die(_("cannot use internal rev list with --cruft"));
-- 
2.55.0.rc2.10.g29e31820dce

