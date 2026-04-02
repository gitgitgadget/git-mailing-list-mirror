Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFA136E46D
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116068; cv=none; b=M866TwoK1d702U4rMF1pZDr+JZ6a8FqkcWAgjt3NSCH+EDWlwq/7JC+ww6BWyr4cQ+hqgXiCq+Sko6AxJCNfInA9oINlGxefc1CYYdY439Sb+LypPsLrFZFqmGnps5W9v4lOSvo84LsGy7wmrYJ1RDW7BqlNDFzD6SDa15zZrGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116068; c=relaxed/simple;
	bh=r6OQWpVF7P4uzX97m0EFb5fDtE5tCcwlZBw7vdn7lJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzwxKQUTFx/adhVVssFmba/Xg5aZhmlghQ0jtDLwmpF6Q4vSYAji737y6nlbc3GxhfrzTDXRq9N15ATkXBgl3pxheyY9+XiG3qzNrVYRm5p43f/u5JLVW9vcrOgSVkG+bccEKlKhJjSgZH68Pt2uR/fna3hGAqMaKndSB3bt+Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c/qyGCHn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CxJJjx5z; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c/qyGCHn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CxJJjx5z"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 31E4E7A03AC;
	Thu,  2 Apr 2026 03:47:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 02 Apr 2026 03:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775116063; x=1775202463; bh=4hPSdXwMYY
	L7RHUEtsbvNhBiqNaH4+vpkapPKhd72kg=; b=c/qyGCHnEWnK3+o36x9DMhKF+K
	ilTka3VpLLj9yUnJM/FuNQFiTZLGa8+TYTcTe8RFjSijbkb60gm0rHr9tzj4AC+I
	F28k3OfST9/TAhEqQrbAKafHUzoYVf17Ai0lMKQ5Z6XHnT703zmtGLcMkUuD2Me1
	9p64c7wzElmu2ZntdsFDDvcllaOMm6ySr5it5TEttDFMgjUSZ+cMjjCZkIA9XMSS
	pPhIEzXAiTpaKdreXC/0XSntzIubcqPHKlPBmdf0XENZFl+8D0DjWHl7w3sV83Xk
	hF0Vob6QfZDc3laHrZwpBA1r7S6Dd5DI7X2uROjqCfPhOXZXrQy5DqYTmHaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775116063; x=1775202463; bh=4hPSdXwMYYL7RHUEtsbvNhBiqNaH4+vpkap
	PKhd72kg=; b=CxJJjx5zhU8c45MCjzcGRlbgiWFCoXM4NIPMgLEUZBoHuyZ0X/T
	dmHx62XW4HGFyNqCqw2c3jHDVTvuMR2GRHBjS2yZpIUXKGnST5N6x04Zwy38+P9x
	dvaaRws2NOzdSiJg354P7i4U4Xw6HBlj5dFyZqm/Hm2hCufdUi3L4Fbiyff1J3NS
	PWv4BPfbHFNIJL8H0Nzua7YZtwyUKqrWNYtQIQDPjxjffMVmpg0jL26gnnIl1Zdi
	Yjc/ai0n+24stRcm2ce1XpzTD42boRfMvc6F4bf09bLK5kJWsnslnVg1wMJ7dOjr
	ynbkBgvcwITXb5A2iHW8luX8njYo4HhLQEg==
X-ME-Sender: <xms:Hx_OaYBjSeoKm6dUTf4ltDw0iTdQAwGDkTMHDkodLl7Laq01BpsxGw>
    <xme:Hx_OaeOeFWJtujGX6PthkYdqngMsSMaNcd3ekFFsw5LnoAETW5uLVYWFEwiIetgSc
    D2vMbt4v22XyfTQ54hTzyqHFK3vYBC7X6owMbtdv6fFOw6b63ih>
X-ME-Received: <xmr:Hx_OaVbz-8vnQiK6nOVw37r5bdKBqaZ9PQEie58lH87GpdQ7NHwEV6_4k4fiS9EdMh-04FEalNyDu5rl23-a07kwHMh0k2a6LenTI-PYrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepje
    evudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:Hx_OaVtPGwLgWG9Oxf2vGLSR0o9JX2J1Lxub78cYOkNKXBk8HsU1Sg>
    <xmx:Hx_OafNaRudTZ15ClWXGyW4ZbphM3y22ewsj7IeD_K7ERzFyhABzcg>
    <xmx:Hx_OaU4q389SvVPruJgNUH9MQTR_NCy5tDS7ixLLWhsiOG29RXRYsA>
    <xmx:Hx_OadSN97PTwVjRIr0G07YEbLaV5-xaMGdRRv-_wE38F1JbeP8lBg>
    <xmx:Hx_Oaa9KrQW2nM4CtWAaZWDq03SEWKIunEOeOtOHx1ujNv0TwbE6MWmg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 03:47:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4186f386 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 07:47:41 +0000 (UTC)
Date: Thu, 2 Apr 2026 09:47:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/10] Prepare for advertised remotes auto-configure via
 URL allowlist
Message-ID: <ac4fGpG9WLZqnH7f@pks.im>
References: <20260402070613.85934-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402070613.85934-1-christian.couder@gmail.com>

On Thu, Apr 02, 2026 at 09:06:03AM +0200, Christian Couder wrote:
> Recently, I sent a 16 patch long series that makes it possible for
> promisor remotes advertised through the "promisor-remote" protocol
> capability to be auto-configured on the client side via a URL
> allowlist configured using a new `promisor.acceptFromServerUrl`
> configuration variable:
> 
> https://lore.kernel.org/git/20260323080520.887550-1-christian.couder@gmail.com/
> 
> I got the suggestion to split the 16 patches series into two smaller
> series, starting with a preparatory series. So here is this
> preparatory series. It's a mix of mostly small fixes, refactorings and
> cleanups.
> 
> High level description of the patches
> =====================================
> 
>  - Patches 1-4/10 are fixes:
> 
>    - Patch 1/10 is the most significant. The others are relatively
>      small.
>      
>    - Patch 4/10 is the only new in this series (while all the others
>      were in the previous series). It prepares for Patch 5/10.
> 
>  - Patches 5-10/10 are refactorings and cleanups:
> 
>    - Patches 5-7/10 are relatively small independents cleanups or
>      refactorings.
> 
>    - Patches 8-9/10 are related refactorings simplifying the data
>      structures used in filter_promisor_remote() and
>      promisor_remote_reply().
> 
>    - Patch 10/10 is cleaning up the 'file://' URIs with absolute paths
>      in the test script.

Thanks for splitting out these changes. In case anybody else cares,
I've attached the range-diff below.

In any case, I'm happy with these changes. There's a single nit, but I
don't think it's worth rerolling over. Thanks!

Patrick

 1:  aeae4b9971 !  1:  30d0aa8a24 promisor-remote: try accepted remotes before others in get_direct()
    @@ Commit message
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    + ## Documentation/gitprotocol-v2.adoc ##
    +@@ Documentation/gitprotocol-v2.adoc: advertised, it can reply with "promisor-remote=<pr-names>" where
    + where `pr-name` is the urlencoded name of a promisor remote the server
    + advertised and the client accepts.
    + 
    ++The promisor remotes that the client accepted will be tried before the
    ++other configured promisor remotes when the client attempts to fetch
    ++missing objects.
    ++
    + Note that, everywhere in this document, the ';' and ',' characters
    + MUST be encoded if they appear in `pr-name` or `field-value`.
    + 
    +
      ## promisor-remote.c ##
     @@ promisor-remote.c: static int remove_fetched_oids(struct repository *repo,
      	return remaining_nr;
    @@ promisor-remote.c: static int remove_fetched_oids(struct repository *repo,
     +	struct promisor_remote *r = repo->promisor_remote_config->promisors;
     +
     +	for (; r; r = r->next) {
    -+		if (accepted_only && !r->accepted)
    -+			continue;
    -+		if (!accepted_only && r->accepted)
    ++		if (accepted_only != r->accepted)
     +			continue;
     +		if (fetch_objects(repo, r->name, *remaining_oids, *remaining_nr) < 0) {
     +			if (*remaining_nr == 1)
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
      
      	for (i = 0; i < remaining_nr; i++) {
      		if (is_promisor_object(repo, &remaining_oids[i]))
    +
    + ## t/t5710-promisor-remote-capability.sh ##
    +@@ t/t5710-promisor-remote-capability.sh: test_expect_success "init + fetch with promisor.advertise set to 'true'" '
    + 	check_missing_objects server 1 "$oid"
    + '
    + 
    ++test_expect_success "clone with two promisors but only one advertised" '
    ++	git -C server config promisor.advertise true &&
    ++	test_when_finished "rm -rf client unused_lop" &&
    ++
    ++	# Create a promisor that will be configured but not be used
    ++	git init --bare unused_lop &&
    ++
    ++	# Clone from server to create a client
    ++	GIT_TRACE="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
    ++		-c remote.unused_lop.promisor=true \
    ++		-c remote.unused_lop.fetch="+refs/heads/*:refs/remotes/unused_lop/*" \
    ++		-c remote.unused_lop.url="file://$(pwd)/unused_lop" \
    ++		-c remote.lop.promisor=true \
    ++		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
    ++		-c remote.lop.url="file://$(pwd)/lop" \
    ++		-c promisor.acceptfromserver=All \
    ++		--no-local --filter="blob:limit=5k" server client &&
    ++
    ++	# Check that "unused_lop" appears before "lop" in the config
    ++	printf "remote.%s.promisor true\n" "unused_lop" "lop" "origin" >expect &&
    ++	git -C client config get --all --show-names --regexp "^remote\..*\.promisor$" >actual &&
    ++	test_cmp expect actual &&
    ++
    ++	# Check that "lop" was tried
    ++	test_grep " fetch lop " trace &&
    ++	# Check that "unused_lop" was not contacted
    ++	# This means "lop", the accepted promisor, was tried first
    ++	test_grep ! " fetch unused_lop " trace &&
    ++
    ++	# Check that the largest object is still missing on the server
    ++	check_missing_objects server 1 "$oid"
    ++'
    ++
    ++test_expect_success "init + fetch two promisors but only one advertised" '
    ++	git -C server config promisor.advertise true &&
    ++	test_when_finished "rm -rf client unused_lop" &&
    ++
    ++	# Create a promisor that will be configured but not be used
    ++	git init --bare unused_lop &&
    ++
    ++	mkdir client &&
    ++	git -C client init &&
    ++	git -C client config remote.unused_lop.promisor true &&
    ++	git -C client config remote.unused_lop.fetch "+refs/heads/*:refs/remotes/unused_lop/*" &&
    ++	git -C client config remote.unused_lop.url "file://$(pwd)/unused_lop" &&
    ++	git -C client config remote.lop.promisor true &&
    ++	git -C client config remote.lop.fetch "+refs/heads/*:refs/remotes/lop/*" &&
    ++	git -C client config remote.lop.url "file://$(pwd)/lop" &&
    ++	git -C client config remote.server.url "file://$(pwd)/server" &&
    ++	git -C client config remote.server.fetch "+refs/heads/*:refs/remotes/server/*" &&
    ++	git -C client config promisor.acceptfromserver All &&
    ++
    ++	# Check that "unused_lop" appears before "lop" in the config
    ++	printf "remote.%s.promisor true\n" "unused_lop" "lop" >expect &&
    ++	git -C client config get --all --show-names --regexp "^remote\..*\.promisor$" >actual &&
    ++	test_cmp expect actual &&
    ++
    ++	GIT_TRACE="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git -C client fetch --filter="blob:limit=5k" server &&
    ++
    ++	# Check that "lop" was tried
    ++	test_grep " fetch lop " trace &&
    ++	# Check that "unused_lop" was not contacted
    ++	# This means "lop", the accepted promisor, was tried first
    ++	test_grep ! " fetch unused_lop " trace &&
    ++
    ++	# Check that the largest object is still missing on the server
    ++	check_missing_objects server 1 "$oid"
    ++'
    ++
    + test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
    + 	git -C server config promisor.advertise true &&
    + 	test_when_finished "rm -rf client" &&
 2:  853051db60 <  -:  ---------- urlmatch: change 'allow_globs' arg to bool
 3:  e17cc86c37 <  -:  ---------- urlmatch: add url_is_valid_pattern() helper
10:  ac7742f5ba !  2:  60ba726cda promisor-remote: pass config entry to all_fields_match() directly
    @@ Metadata
      ## Commit message ##
         promisor-remote: pass config entry to all_fields_match() directly
     
    -    The `in_list == 0` path of all_fields_match() re-looks up the
    -    remote in config_info by advertised->name, even though every
    +    The `in_list == 0` path of all_fields_match() looks up the remote in
    +    `config_info` by `advertised->name` repeatedly, even though every
         caller in should_accept_remote() has already performed this
    -    lookup and holds the result in 'p'.
    +    lookup and holds the result in `p`.
     
         To avoid this useless work, let's replace the `int in_list`
         parameter with a `struct promisor_info *config_entry` pointer:
    @@ Commit message
            avoiding the redundant string_list_lookup() call.
     
         This removes the hidden dependency on `advertised->name` inside
    -    all_fields_match(), which would be wrong in the following commits when
    -    auto-configured remotes will be implemented as the local config name
    -    may differ from the server's advertised name.
    +    all_fields_match(), which would be wrong if in the future
    +    auto-configured remotes are implemented, as the local config name may
    +    differ from the server's advertised name.
    +
    +    While at it, let's also add a comment before all_fields_match() and
    +    match_field_against_config() to help understand how things work and
    +    help avoid similar issues.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## promisor-remote.c ##
    +@@ promisor-remote.c: enum accept_promisor {
    + 	ACCEPT_ALL
    + };
    + 
    ++/*
    ++ * Check if a specific field and its advertised value match the local
    ++ * configuration of a given promisor remote.
    ++ *
    ++ * Returns 1 if they match, 0 otherwise.
    ++ */
    + static int match_field_against_config(const char *field, const char *value,
    + 				      struct promisor_info *config_info)
    + {
     @@ promisor-remote.c: static int match_field_against_config(const char *field, const char *value,
      	return 0;
      }
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
     -		return all_fields_match(advertised, config_info, 0);
     +		return all_fields_match(advertised, config_info, p);
      
    - 	warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
    - 		  "ignoring this remote"), remote_name, p->url, remote_url);
    + 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
    + 		remote_name, p->url, remote_url);
 4:  c2f9f3ebef !  3:  d69391fd61 promisor-remote: clarify that a remote is ignored
    @@ Metadata
      ## Commit message ##
         promisor-remote: clarify that a remote is ignored
     
    -    In should_accept_remote() when a remote is ignored, we might tell users
    -    why it is ignored in a warning, but we don't tell them that the remote
    -    is actually ignored.
    +    In should_accept_remote() and parse_one_advertised_remote(), when a
    +    remote is ignored, we tell users why it is ignored in a warning, but we
    +    don't tell them that the remote is actually ignored.
     
         Let's clarify that, so users have a better idea of what's actually
         happening.
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      	}
      
      	if (!strcmp(p->url, remote_url))
    - 		return all_fields_match(advertised, config_info, 0);
    + 		return all_fields_match(advertised, config_info, p);
      
     -	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
     -		remote_name, p->url, remote_url);
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      
      	return 0;
      }
    +@@ promisor-remote.c: static struct promisor_info *parse_one_advertised_remote(const char *remote_info
    + 	string_list_clear(&elem_list, 0);
    + 
    + 	if (!info->name || !info->url) {
    +-		warning(_("server advertised a promisor remote without a name or URL: %s"),
    +-			remote_info);
    ++		warning(_("server advertised a promisor remote without a name or URL: '%s', "
    ++			  "ignoring this remote"), remote_info);
    + 		promisor_info_free(info);
    + 		return NULL;
    + 	}
 -:  ---------- >  4:  f4815d68ea promisor-remote: reject empty name or URL in advertised remote
11:  ebc6f2dbeb !  5:  48605c4612 promisor-remote: refactor should_accept_remote() control flow
    @@ Metadata
      ## Commit message ##
         promisor-remote: refactor should_accept_remote() control flow
     
    -    In following commits, we are going to add URL-based acceptance logic
    -    into should_accept_remote().
    +    A previous commit made sure we now reject empty URLs early at parse
    +    time. This makes the existing warning() in case a remote URL is NULL
    +    or empty very unlikely to be useful.
     
    -    To prepare for the upcoming changes, let's restructure the control flow
    -    in should_accept_remote().
    +    In future work, we also plan to add URL-based acceptance logic into
    +    should_accept_remote().
    +
    +    To adapt to previous changes and prepare for upcoming changes, let's
    +    restructure the control flow in should_accept_remote().
     
         Concretely, let's:
     
    -     - Move the empty-URL check to the very top of the function, so that
    -       every acceptance mode, instead of only ACCEPT_KNOWN_URL, rejects
    -       remotes with a missing or blank URL early.
    +     - Replace the warning() in case of an empty URL with a BUG(), as a
    +       previous commit made sure empty URLs are rejected early at parse
    +       time.
    +
    +     - Move that modified empty-URL check to the very top of the function,
    +       so that every acceptance mode, instead of only ACCEPT_KNOWN_URL, is
    +       covered.
     
          - Invert the URL comparison: instead of returning on match and
            warning on mismatch, return early on mismatch and let the match
            case fall through. This opens a single exit path at the bottom of
    -       the function for following commits to extend.
    -
    -    Anyway the server shouldn't send any empty URL in the first place, so
    -    this shouldn't change any behavior in practice.
    +       the function for future commits to extend.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      	const char *remote_name = advertised->name;
      	const char *remote_url = advertised->url;
      
    -+	if (!remote_url || !*remote_url) {
    -+		warning(_("no or empty URL advertised for remote '%s', "
    -+			  "ignoring this remote"), remote_name);
    -+		return 0;
    -+	}
    ++	if (!remote_url || !*remote_url)
    ++		BUG("no or empty URL advertised for remote '%s'; "
    ++		    "this remote should have been rejected earlier",
    ++		    remote_name);
     +
      	if (accept == ACCEPT_ALL)
      		return all_fields_match(advertised, config_info, NULL);
 5:  bdd62c20a4 !  6:  632e3bfe25 promisor-remote: refactor has_control_char()
    @@ Metadata
      ## Commit message ##
         promisor-remote: refactor has_control_char()
     
    -    In a following commit we are going to check if some strings contain
    -    control character, so let's refactor the logic to do that in a new
    +    In a future commit we are going to check if some strings contain
    +    control characters, so let's refactor the logic to do that in a new
         has_control_char() helper function.
     
    +    It cleans up the code a bit anyway.
    +
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## promisor-remote.c ##
 6:  962db2ee6c !  7:  12dc262514 promisor-remote: refactor accept_from_server()
    @@ Metadata
      ## Commit message ##
         promisor-remote: refactor accept_from_server()
     
    -    In a following commit, we are going to add more logic to
    +    In future commits, we are going to add more logic to
         filter_promisor_remote() which is already doing a lot of things.
     
         Let's alleviate that by moving the logic that checks and validates the
 7:  b4d125bd36 !  8:  9d47ed27e8 promisor-remote: keep accepted promisor_info structs alive
    @@ Commit message
         protocol reply, apply advertised filters, and mark remotes as
         accepted, rather than iterating three separate structures.
     
    -    This refactoring also prepares for a following commit that will add a
    +    This refactoring also prepares for a future commit that will add a
         'local_name' member to 'struct promisor_info'. Since struct instances
         stay alive, downstream code will be able to simply read both names
         from them rather than needing yet another parallel strvec.
 8:  3252e216f1 =  9:  b6c020696d promisor-remote: remove the 'accepted' strvec
 9:  60e17ccb99 <  -:  ---------- promisor-remote: add 'local_name' to 'struct promisor_info'
12:  467ee9eff3 ! 10:  d47aa7a31a t5710: use proper file:// URIs for absolute paths
    @@ Commit message
         (`file://D:/a/repo`). Standard URI parsers misinterpret this format,
         treating `D:` as the host rather than part of the absolute path.
     
    +    This is to be expected because RFC 8089 says that the `//` prefix with
    +    an empty local host must be followed by an absolute path starting with
    +    a slash.
    +
         While this hasn't broken the existing tests (because the old
    -    `promisor.acceptFromServer` logic relies entirely on strict `strcmp`
    +    `promisor.acceptFromServer` logic relies entirely on strict `strcmp()`
         without normalizing the URLs), it will break future commits that pass
    -    these URLs through `url_normalize()`.
    +    these URLs through `url_normalize()` or similar functions.
     
         To future-proof the tests and ensure cross-platform URI compliance,
         let's introduce a $PWD_URL helper that explicitly guarantees a leading
13:  637db2b4d8 <  -:  ---------- promisor-remote: introduce promisor.acceptFromServerUrl
14:  c03c5261fb <  -:  ---------- promisor-remote: trust known remotes matching acceptFromServerUrl
15:  0d8acf10f8 <  -:  ---------- promisor-remote: auto-configure unknown remotes
16:  a27565223f <  -:  ---------- doc: promisor: improve acceptFromServer entry
