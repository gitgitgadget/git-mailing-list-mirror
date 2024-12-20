Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA86D17BD3
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707009; cv=none; b=ut25Z39YwW+uY5MT8Fm3Gel2jI02Qfv+29vCAvpyNJUicSJNwsbjC03zY1xplrhf5e9yw/ms+Eyt+kpvY5/HoXzs4N/TTBN5sKrMoj5ACr7QZcQsXE+ghzIghklTPGVl38deFO3YH0ibyBNVgMjd1EkLfhmBd1M4yNLP0X8nJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707009; c=relaxed/simple;
	bh=JGXFXlVUWf+IykOc/Oj3VVG1zl1Z88CYASqXOnCHlrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XSPpHJuMyXyuh3CfOTFfI9w3WK9Vt39MBzxclGbTpNmGcfj1wvLrFuXTL7vLOxR/UVHNup1K3JZb1PergJmQaePGrSqWES0aZd7QkoQ8nvgomc10o8R4P0kk+5XDO141+981E3fWV5LCL0oegbz4UMToog3KIcnLQIB0Sw8p/lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B7Hl4d9j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTAj1kCD; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B7Hl4d9j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTAj1kCD"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id ACB2C11401C3;
	Fri, 20 Dec 2024 10:03:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 20 Dec 2024 10:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734707006; x=1734793406; bh=ikFcdmRJtw
	vYS+4EwhuO07grd32n5gFMklwyNjDH71M=; b=B7Hl4d9jOP3D3hpgcVXc7JzA4f
	M7L0RqrlNvJeR6CoZeXymLgqiIK3fKp+lGTnsIkF/jzgJRi5oamRG5muR7Hspe05
	0PtwW8cAppFhAUQTgl+nw9hXiN3vWgIRBmwQFizcSWwJZ+26QGv4M7TFzoniLCje
	WVyPB9cULu+sfliUaAdcIs8eYcLut1KknXrV3WQhn1KW/q87ItFhEHYKpcElOnEI
	It9hlrRzcSwFnUAJ5u/Ok7Q0RPeQrSL4C/BGUEQxmRJCGUc+3S1lHRyrvY8IsWL2
	yHTV5GXcWVd1CvgzZNen6MBsjekc4xPXpSRBtjNoSvfkd0xtKZl+GlCIR+dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734707006; x=1734793406; bh=ikFcdmRJtwvYS+4EwhuO07grd32n5gFMklw
	yNjDH71M=; b=HTAj1kCDw/xVw56c5+DWZjJ7XAM9vFlGw9OI8pMFPwIA5aTFIZj
	adsqeHJzKpSWNKx2HW5DhqcZgnPoN62eH60Zc0iH7Mxfxwggkjl3Q5kt1WWs4Uhz
	dPg+s+6ZUqpDKhVzNnuIys4BNNC9yl9ObklifpB7Z6oypBeTso65+J9cDDX35aiB
	mobfUNurnnQmtmVV+CuG4KPa3V6wZ0YDnCF0mOhxfgXWaLqW6xPvqRgJxSl5rsfQ
	zDhDGqPq4BpzsGuGrI08BAo7oUA/prew2V40tHY5ITI8yngJ+lRRJ4w0gDOnmMS0
	OhduRXVUQHEKFsWX27HjWFYOy0VNtQ3aR+g==
X-ME-Sender: <xms:PYdlZ9QMwrxtFUreCbEYDgn7PQCEudahBhPswr_CGk4cX7mbNB9tPQ>
    <xme:PYdlZ2wKjKllBo0Dr0VHC2bQAlTmcVKSlm_hiTXSDJoknZSc3hV5ugJLZMyih1F2G
    7czd5yhIg7sytENdQ>
X-ME-Received: <xmr:PYdlZy3Q7TyhWCYZJIOP7yIA_NEYWYkEP-EHW3Ei2NND3IrIa9UpmWSO3qY1EI8LFRLmIsgNVkNRAbeswihx2cy4-Tz7nzqJAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    uggrnhhivghlrdgvnhhgsggvrhhgrdhlihhsthhssehphihrvghtrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PodlZ1B9qc7JmEszEx5gu58OBA1_b6K4o75sF2dBa0egeC31lGt1hA>
    <xmx:PodlZ2j_w2aFXmmmKiyuGt8OxmsxFq86xeYO2v8KMsN03uji19XFTw>
    <xmx:PodlZ5rLsf1SJG3yAGC0dxIBBKyM2q1AC4imP87qah1aLtWOeaOocw>
    <xmx:PodlZxieNXL_aX8ezZBlRpnJeLrk1MwXJZGjxQQhS3DrKDTpnJJGGQ>
    <xmx:PodlZ-fXgxy5qd3XwLJa4b3buPPg_yZRfW73B6ytvv_6mzdRdYDgEjoD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 10:03:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Daniel Engberg <daniel.engberg.lists@pyret.net>
Subject: Re: [PATCH] meson: skip gitweb build when Perl is disabled
In-Reply-To: <20241220-b4-pks-meson-fix-gitweb-wo-perl-v1-1-41039ad8d8d4@pks.im>
	(Patrick Steinhardt's message of "Fri, 20 Dec 2024 08:26:30 +0100")
References: <20241220-b4-pks-meson-fix-gitweb-wo-perl-v1-1-41039ad8d8d4@pks.im>
Date: Fri, 20 Dec 2024 07:03:23 -0800
Message-ID: <xmqq4j2ygzwk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> It is possible to configure a Git build without Perl when disabling both
> our test suite and all Perl-based features. In Meson, this can be
> achieved with `meson setup -Dperl=disabled -Dtests=false`.
>
> It was reported by a user that this breaks the Meson build because
> gitweb gets built even if Perl was not discovered in such a build:
>
>     $ meson setup .. -Dtests=false -Dperl=disabled
>     ...
>     ../gitweb/meson.build:2:43: ERROR: Unable to get the path of a not-found external program
>
> Fix this issue by introducing a new feature-option that allows the user
> to configure whether or not to build Gitweb. The feature is set to
> 'auto' by default and will be disabled automatically in case Perl was
> not found on the system.
>
> Reported-by: Daniel Engberg <daniel.engberg.lists@pyret.net>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> I received an off-list mail from a user interested in the new Meson
> build system who has done a bit of testing of it on FreeBSD. They found
> an issue when configuring the build without Perl enabled, which can be
> achieved by both disabling tests and Perl-based features. This patch
> here fixes the issue.
>
> Thanks!

Thanks, Patrick and Daniel.

> -if get_option('tests')
> +if get_option('tests') or get_option('gitweb').enabled()
>    perl_required = true
>  endif

OK, so we use "perl_required" to keep track of the fact that
something else wants Perl to be usable.

> +# Gitweb requires Perl, so we disable the auto-feature if Perl was not found.
> +# We make sure further up that Perl is required in case the gitweb option is
> +# enabled.
> +gitweb_option = get_option('gitweb').disable_auto_if(not perl.found())

Hopefully before we reach this point, we would have figured out if
perl is avialable, to allow us do this.

There seem to be too many "perl" related variables, interaction
among which smells way too complex for their worth.  For example,

    perl = find_program('perl', ..., required: perl_required);
    perl_features_enabled = perl.found() and get_option('perl').allowed()

and only when the latter is true, we'd do further configuration to
make perl usable.  Does that mean the condition you wrote above to
automatically disable gitweb somewhat incorrect?  Even if we may
have found perl, the builder may deliberately have disallowed use of
it, in which case we just know perl is there without figuring out
what other things (like where the localedir is) that are needed to
use it correctly.

> +if gitweb_option.enabled()
> +  subdir('gitweb')
> +endif
> +
>  subdir('templates')

OK, we used to do the subdir() thing unconditionally, but now, if we
decide that we shouldn't or cannot do gitweb, we do not do
that,which sounds good.

> +option('gitweb', type: 'feature', value: 'auto',
> +  description: 'Build Git web interface. Required Perl.')

I do not know the convention in the meson world, but to me, this
would sound more natural with "Required" -> "Requires".

>  option('iconv', type: 'feature', value: 'auto',
>    description: 'Support reencoding strings with different encodings.')
>  option('pcre2', type: 'feature', value: 'enabled',
>
> ---
> base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
> change-id: 20241218-b4-pks-meson-fix-gitweb-wo-perl-93379dd0ceed
