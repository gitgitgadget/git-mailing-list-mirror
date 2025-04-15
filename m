Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806C4C83
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757210; cv=none; b=mE/SEW2aNRbuWPlbwyxSpHgAeMoBl78aFBQu8q0Te4EpfRzgTmBRApbDvyTYZWa6E2011n5mTFr/OI43Yi+oDsDRFNCQ6Kb3qhBf97WlmQPyn+76O5qVggGeRXIMJO/R7mqZzh386A3X6Fbnwe+R2XTQ3DLo9IVJUNTOYgow7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757210; c=relaxed/simple;
	bh=WQe88aVHlGgWZeieIthcYO57I66sgWpjehb4feRIvk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9xhlOMs67TJw1YVMtIOwTFUQRoUVJmsD3tQphS1+UOu+NJMYFkCiCN4yHlgTPZ2ifQLbHwgz6mvexIW9GLQQrW5lNmvJh/ldrsD7HbvMiFZf480gNr4xeTXHbOSmikBsBxt51tI8dXeoXLHYlNzUpI6QFAyC6SmDGmVAg7clac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iFODVa1p; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iFODVa1p"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be49f6b331so658879485a.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744757207; x=1745362007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twgeS4E6xqu+KMSVJITgz2DA2MjOZS5A7pfcvC9ylrs=;
        b=iFODVa1pYHR2fjhGfKRz+7uB3GrlX9xtueUrQX0QKoEeazBYEz81cURVMfMxF7Kxnw
         ViIT276zjQPYFHa2jYStjOIoGx9WnG7CxjeTM5B9EhhrqShY0bROY8nMnypAzjCWWDck
         vSzcuS1RtQew9tA4t22DcxaxoYMwZbLVedR9/XRQgYeWLpc2TisIhW7RqrugY588VRES
         6NEyR3SP3lzv/GT1Vo7arOm18lYShV8ZFYmBPovGeA27V004ptu1QIFPPdfG1pMuIFBG
         jSc3onqaku9NPqBMFe80W19yrXYR5KITgww3RVW4FWOtrZgVYHHZc9h3YOPhz97Xu3/u
         lAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757207; x=1745362007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twgeS4E6xqu+KMSVJITgz2DA2MjOZS5A7pfcvC9ylrs=;
        b=HUTvJSzgOALUIWB1n5BJlDCXPJ6j/5NePyIQaDYMCf5FaudgSr61gbexJ5KsMotxU2
         a/1xhQy6xqF0PZRMYhA7ikguGXFI26KG286RcCnEOSJ8nm0Y7p6lspYM6IerKVm2uaQI
         BfxHfVZxTz+UcnF3pIHAXzQNunjnYjaHi5kiRgFuy8zT9apeaUQtwcbO/X7JAB2bXCvt
         +HcNpyqFab+LfphuECk72Yi7dIM+T8+hITbYTouQH1YoH7Y/pZssDvNu4XK0KTQ0k6Co
         N69Tber0bFPh7eDQJWtTmU3vpVdBqpik4bcWGKc72Nrbp7Ri+sBcR+mz1PAPCBbxXAun
         vw3Q==
X-Gm-Message-State: AOJu0YxddcqWvkgnLkOa4qPEXM7tLYyzNbhNxib1kuoiZx/Cvvf1a5RT
	dX/fxG2kBbuUbvwgu/lwetELwJh+frvn3RE9SaW0inwnPA65S86GdCJa3O3AyElnRSrIiLa3WoP
	/IbY=
X-Gm-Gg: ASbGncsqh1E6lG//q7WMhzt7/9kif41WaRad5jRZNsr0+8RFOdtg99v0qF3VxmwZ6oY
	qB6BE4amOwYqlD9uiTVXV+qOb0NYJlC0DehmzlMFgD8lOkRb0HD2AvmAYFZCYvmj5BtK6CxQOEe
	LQQgkyEoun2vRdCpHEA22o/uyb7HD7HR4V5JyWcsWvmOWXi3PEYoq4HeXCblANNsZkhGI2oYyhU
	gqOfbyc8Xn7FVJshp5jf2c7ID+uIz0ZeqLYLDDspiznKRaDCpq3Cgg9v4H5pGf+manm95SPGSsj
	0gP3eAcyQp0hMLqz4D30ozTvHt011sm5fXdiT5pjDytxQO3VIfZMWOuZm1ebuL2em3wfYLKVIfM
	SGkw96A8Bvcrk
X-Google-Smtp-Source: AGHT+IE0cPxcCXIItIQDzWoBzkBUC/6VKC/y5lKmDBptZcXljQjXWnJxZxY1uKB2VIM9F0c90e6NAg==
X-Received: by 2002:a05:620a:4093:b0:7c5:65fb:fe0e with SMTP id af79cd13be357-7c91419db4cmr215051385a.6.1744757206811;
        Tue, 15 Apr 2025 15:46:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8969e26sm964970785a.64.2025.04.15.15.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:46:46 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:46:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/9] repack: avoid MIDX'ing cruft pack(s) where possible
Message-ID: <cover.1744757204.git.me@ttaylorr.com>
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

Here is a small-ish reroll of my series to explore creating MIDXs while
repacking that don't include the cruft pack.

The bulk of the series is unchanged, save for a few minor points that
I'll call out here (as usual, a complete range-diff is below for
convenience):

  * Dropped the patch adding a warning about using designated
    initializers. I think that we should resurrect this patch soon and
    update the CodingGuidelines, but I'd rather disentangle that from
    this series.

  * Dropped the designated initializer component of the "limit scope"
    patch.

  * Swapped ordering on one of the die_for_incompatible_opt2() checks.

  * Various wording tweaks.

  * Split out some code movement changes into their own patches to make
    substantive patches easier to read/review.

  * Test updates and cleanup.

These changes are all thanks to helpful review from Junio and Elijah.
Thanks, both!

Otherwise the series is unchanged. I still need to deploy it to GitHub's
infrastructure and try it out on some internal repos, but I should be
able to do that tomorrow and report back on my findings a few days after
that.

Thanks in advance for any review :-).

Taylor Blau (9):
  pack-objects: use standard option incompatibility functions
  pack-objects: limit scope in 'add_object_entry_from_pack()'
  pack-objects: factor out handling '--stdin-packs'
  pack-objects: declare 'rev_info' for '--stdin-packs' earlier
  pack-objects: perform name-hash traversal for unpacked objects
  pack-objects: fix typo in 'show_object_pack_hint()'
  pack-objects: swap 'show_{object,commit}_pack_hint'
  pack-objects: introduce '--stdin-packs=follow'
  repack: exclude cruft pack(s) from the MIDX where possible

 Documentation/config/repack.adoc    |   7 +
 Documentation/git-pack-objects.adoc |  10 +-
 builtin/pack-objects.c              | 192 ++++++++++++++++++----------
 builtin/repack.c                    | 163 ++++++++++++++++++++---
 t/t5331-pack-objects-stdin.sh       |  84 +++++++++++-
 t/t7704-repack-cruft.sh             |  90 +++++++++++++
 6 files changed, 456 insertions(+), 90 deletions(-)

Range-diff against v2:
 1:  65bc7e4630 !  1:  f8b31c6a8d pack-objects: use standard option incompatibility functions
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
      
     -	if (stdin_packs && filter_options.choice)
     -		die(_("cannot use --filter with --stdin-packs"));
    -+	die_for_incompatible_opt2(filter_options.choice, "--filter",
    -+				  stdin_packs, "--stdin-packs");
    ++	die_for_incompatible_opt2(stdin_packs, "--stdin-packs",
    ++				  filter_options.choice, "--filter");
    ++
      
      	if (stdin_packs && use_internal_rev_list)
      		die(_("cannot use internal rev list with --stdin-packs"));
    @@ t/t5331-pack-objects-stdin.sh: test_expect_success '--stdin-packs is incompatibl
      		test_must_fail git pack-objects --stdin-packs --stdout \
      			--filter=blob:none </dev/null 2>err &&
     -		test_grep "cannot use --filter with --stdin-packs" err
    -+		test_grep "options .--filter. and .--stdin-packs. cannot be used together" err
    ++		test_grep "options .--stdin-packs. and .--filter. cannot be used together" err
      	)
      '
      
 2:  920c91eb1e <  -:  ---------- object-store-ll.h: add note about designated initializers
 3:  f8ac36b110 !  2:  986bef29b5 pack-objects: limit scope in 'add_object_entry_from_pack()'
    @@ Metadata
      ## Commit message ##
         pack-objects: limit scope in 'add_object_entry_from_pack()'
     
    -    add_object_entry_from_pack() handles objects from identified packs by
    -    checking their type, before adding commit objects as pending in the
    -    subsequent traversal used by `--stdin-packs`.
    -
    -    There are a couple of quality-of-life refactorings that I noticed while
    -    working in this area:
    -
    -      - We declare 'revs' (given to us through the miscellaneous context
    -        argument) earlier in the "if (p)" conditional than is necessary.
    -
    -      - The 'struct object_info' can use a designated initializer to fill in
    -        the structures type pointer, since that is the only field that we
    -        care about.
    +    In add_object_entry_from_pack() we declare 'revs' (given to us through
    +    the miscellaneous context argument) earlier in the "if (p)" conditional
    +    than is necessary.  Move it down as far as it can go to reduce its
    +    scope.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct objec
      
      	if (p) {
     -		struct rev_info *revs = _data;
    --		struct object_info oi = OBJECT_INFO_INIT;
    + 		struct object_info oi = OBJECT_INFO_INIT;
     -
    --		oi.typep = &type;
    -+		struct object_info oi = { .typep = &type };
    + 		oi.typep = &type;
    ++
      		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
      			die(_("could not get type of object %s in pack %s"),
      			    oid_to_hex(oid), p->pack_name);
 4:  5e03b482ba =  3:  6f8fe8a4e1 pack-objects: factor out handling '--stdin-packs'
 5:  bccbac2ec5 =  4:  2a235461a6 pack-objects: declare 'rev_info' for '--stdin-packs' earlier
 6:  0bc2183dc3 !  5:  240e90b68d pack-objects: perform name-hash traversal for unpacked objects
    @@ Commit message
         pack (`add_unreachable_loose_objects()`) did not have access to the
         'rev_info' struct found in `read_packs_list_from_stdin()`.
     
    -    Excluding unpacked objects from that traversal doesn't effect the
    +    Excluding unpacked objects from that traversal doesn't affect the
         correctness of the resulting pack, but it does make it harder to
         discover good deltas for loose objects.
     
 -:  ---------- >  6:  9a18fa2e52 pack-objects: fix typo in 'show_object_pack_hint()'
 -:  ---------- >  7:  6c997853f1 pack-objects: swap 'show_{object,commit}_pack_hint'
 7:  697a337cb1 !  8:  0ff699f056 pack-objects: introduce '--stdin-packs=follow'
    @@ Documentation/git-pack-objects.adoc: base-name::
      	included packs (those not beginning with `^`), excluding any
      	objects listed in the excluded packs (beginning with `^`).
      +
    -+When `mode` is "follow", pack objects which are reachable from objects
    -+in the included packs, but appear in packs that are not listed.
    -+Reachable objects which appear in excluded packs are not packed. Useful
    -+for resurrecting once-cruft objects to generate packs which are closed
    -+under reachability up to the excluded packs.
    ++When `mode` is "follow", objects from packs not listed on stdin receive
    ++special treatment. Objects within unlisted packs will be included if
    ++those objects are (1) reachable from the included packs, and (2) not
    ++found in any excluded packs. This mode is useful, for example, to
    ++resurrect once-unreachable objects found in cruft packs to generate
    ++packs which are closed under reachability up to the boundary set by the
    ++excluded packs.
     ++
      Incompatible with `--revs`, or options that imply `--revs` (such as
      `--all`), with the exception of `--unpacked`, which is compatible.
    @@ builtin/pack-objects.c: static struct oidmap configured_exclusions;
       * Check whether the name_hash_version chosen by user input is appropriate,
       * and also validate whether it is compatible with other features.
     @@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct object_id *oid,
    - 	return 0;
      }
      
    --static void show_commit_pack_hint(struct commit *commit UNUSED,
    --				  void *data UNUSED)
    --{
    --	/* nothing to do; commits don't have a namehash */
    --}
    --
      static void show_object_pack_hint(struct object *object, const char *name,
     -				  void *data UNUSED)
     +				  void *data)
      {
     -	struct object_entry *oe = packlist_find(&to_pack, &object->oid);
     -	if (!oe)
    +-		return;
     +	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
     +	if (mode == STDIN_PACKS_MODE_FOLLOW) {
     +		add_object_entry(&object->oid, object->type, name, 0);
    @@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct objec
     +		struct object_entry *oe = packlist_find(&to_pack, &object->oid);
     +		if (!oe)
     +			return;
    -+
    -+		/*
    -+		 * Our 'to_pack' list was constructed by iterating all
    -+		 * objects packed in included packs, and so doesn't
    -+		 * have a non-zero hash field that you would typically
    -+		 * pick up during a reachability traversal.
    -+		 *
    -+		 * Make a best-effort attempt to fill in the ->hash
    -+		 * and ->no_try_delta here using a now in order to
    -+		 * perhaps improve the delta selection process.
    -+		 */
    -+		oe->hash = pack_name_hash_fn(name);
    -+		oe->no_try_delta = name && no_try_delta(name);
    -+
    -+		stdin_packs_hints_nr++;
    -+	}
    -+}
    -+
    -+static void show_commit_pack_hint(struct commit *commit, void *data)
    -+{
    -+	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
    -+	if (mode == STDIN_PACKS_MODE_FOLLOW) {
    -+		show_object_pack_hint((struct object *)commit, "", data);
    - 		return;
    -+	}
    -+	/* nothing to do; commits don't have a namehash */
      
     -	/*
     -	 * Our 'to_pack' list was constructed by iterating all objects packed in
    @@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct objec
     -	 * would typically pick up during a reachability traversal.
     -	 *
     -	 * Make a best-effort attempt to fill in the ->hash and ->no_try_delta
    --	 * here using a now in order to perhaps improve the delta selection
    +-	 * fields here in order to perhaps improve the delta selection
     -	 * process.
     -	 */
     -	oe->hash = pack_name_hash_fn(name);
     -	oe->no_try_delta = name && no_try_delta(name);
    --
    ++		/*
    ++		 * Our 'to_pack' list was constructed by iterating all
    ++		 * objects packed in included packs, and so doesn't have
    ++		 * a non-zero hash field that you would typically pick
    ++		 * up during a reachability traversal.
    ++		 *
    ++		 * Make a best-effort attempt to fill in the ->hash and
    ++		 * ->no_try_delta fields here in order to perhaps
    ++		 * improve the delta selection process.
    ++		 */
    ++		oe->hash = pack_name_hash_fn(name);
    ++		oe->no_try_delta = name && no_try_delta(name);
    + 
     -	stdin_packs_hints_nr++;
    ++		stdin_packs_hints_nr++;
    ++	}
    + }
    + 
    +-static void show_commit_pack_hint(struct commit *commit UNUSED,
    +-				  void *data UNUSED)
    ++static void show_commit_pack_hint(struct commit *commit, void *data)
    + {
    ++	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
    ++
    ++	if (mode == STDIN_PACKS_MODE_FOLLOW) {
    ++		show_object_pack_hint((struct object *)commit, "", data);
    ++		return;
    ++	}
    ++
    + 	/* nothing to do; commits don't have a namehash */
    ++
      }
      
      static int pack_mtime_cmp(const void *_a, const void *_b)
    @@ t/t5331-pack-objects-stdin.sh: test_expect_success 'pack-objects --stdin with pa
     +	rm -f objects.raw
     +}
     +
    -+test_expect_success 'setup for --stdin-packs=follow' '
    -+	git init stdin-packs--follow &&
    -+	(
    -+		cd stdin-packs--follow &&
    -+
    -+		for c in A B C D
    -+		do
    -+			test_commit "$c" || return 1
    -+		done &&
    -+
    -+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
    -+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
    -+		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
    -+		D="$(echo C..D | git pack-objects --revs $packdir/pack)" &&
    -+
    -+		git prune-packed
    -+	)
    -+'
    -+
     +test_expect_success '--stdin-packs=follow walks into unknown packs' '
     +	test_when_finished "rm -fr repo" &&
     +
    @@ t/t5331-pack-objects-stdin.sh: test_expect_success 'pack-objects --stdin with pa
     +		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
     +		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
     +		D="$(echo C..D | git pack-objects --revs $packdir/pack)" &&
    ++		test_commit E &&
     +
     +		git prune-packed &&
     +
    @@ t/t5331-pack-objects-stdin.sh: test_expect_success 'pack-objects --stdin with pa
     +		objects_in_packs $P >actual &&
     +		test_cmp expect actual &&
     +
    -+		test_commit E &&
     +		# And with --unpacked, we will pick up objects from unknown
     +		# packs that are reachable from loose objects. Loose object E
     +		# reaches objects in pack A, but there are three excluded packs
 8:  a2ec1b826c !  9:  58891101f3 repack: exclude cruft pack(s) from the MIDX where possible
    @@ Commit message
         MIDX with '--write-midx' to ensure that the resulting MIDX was always
         closed under reachability in order to generate reachability bitmaps.
     
    -    Suppose you have a once-unreachable object packed in a cruft pack, which
    -    later on becomes reachable from one or more objects in a geometrically
    -    repacked pack. That once-unreachable object *won't* appear in the new
    -    pack, since the cruft pack was specified as neither included nor
    -    excluded to 'pack-objects --stdin-packs'. If the bitmap selection
    -    process picks one or more commits which reach the once-unreachable
    -    objects, commit ddee3703b3 ensures that the MIDX will be closed under
    -    reachability. Without it, we would fail to generate a MIDX bitmap.
    +    Suppose (prior to this patch) you have a once-unreachable object packed
    +    in a cruft pack, which later on becomes reachable from one or more
    +    objects in a geometrically repacked pack. That once-unreachable object
    +    *won't* appear in the new pack, since the cruft pack was specified as
    +    neither included nor excluded to 'pack-objects --stdin-packs'. If the
    +    new pack is included in a MIDX without the cruft pack, then trying to
    +    generate bitmaps for that MIDX may fail. This happens when the bitmap
    +    selection process picks one or more commits which reach the
    +    once-unreachable objects, commit ddee3703b3 ensures that the MIDX will
    +    be closed under reachability. Without it, we would fail to generate a
    +    MIDX bitmap.
     
         ddee3703b3 alludes to the fact that this is sub-optimal by saying
     
    @@ Commit message
         and slows down object lookup.
     
         This is doubly unfortunate because the vast majority of objects in cruft
    -    pack(s) are unlikely to be read, but object reads that go through the
    -    MIDX have to search through them anyway.
    +    pack(s) are unlikely to be read. But any object lookups that go through
    +    the MIDX must binary search over them anyway, slowing down object
    +    lookups using the MIDX.
     
         This patch causes geometrically-repacked packs to contain a copy of any
         once-unreachable object(s) with 'git pack-objects --stdin-packs=follow',
    @@ Commit message
         be closed under reachability.
     
         Note that you cannot guarantee that a collection of packs is closed
    -    under reachability if not all of them were generated with following as
    +    under reachability if not all of them were generated with "following" as
         above. One tell-tale sign that not all geometrically-repacked packs in
    -    the MIDX were generated with following is to see if there is a pack in
    +    the MIDX were generated with "following" is to see if there is a pack in
         the existing MIDX that is not going to be somehow represented (either
         verbatim or as part of a geometric rollup) in the new MIDX.
     
    -    If there is, then starting to generate packs with following during
    +    If there is, then starting to generate packs with "following" during
         geometric repacking won't work, since it's open to the same race as
         described above.
     
    @@ builtin/repack.c: static void midx_included_packs(struct string_list *include,
     -		 * repack).
     +		 * For example, a cruft pack can be required to form a
     +		 * reachability closure if the MIDX is bitmapped and one
    -+		 * or more of its selected commits reaches a once-cruft
    -+		 * object that was later made reachable.
    ++		 * or more of the bitmap's selected commits reaches a
    ++		 * once-cruft object that was later made reachable.
      		 */
     -		if (pack_is_marked_for_deletion(item))
     -			continue;
    @@ builtin/repack.c: static void midx_included_packs(struct string_list *include,
     +		}
     +	} else {
     +		/*
    -+		 * Modern versions of Git will write new copies of
    ++		 * Modern versions of Git (with the appropriate
    ++		 * configuration setting) will write new copies of
     +		 * once-cruft objects when doing a --geometric repack.
     +		 *
     +		 * If the MIDX has no cruft pack, new packs written

base-commit: 485f5f863615e670fd97ae40af744e14072cfe18
-- 
2.49.0.230.ga662d77f78
