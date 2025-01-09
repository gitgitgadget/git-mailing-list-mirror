Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D22153FE
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736421292; cv=none; b=giOQRf7YvW01pCLhhJt4Hyskx7ZEG5bWTrzLvleapBukecDFv0cnaw7/pNQ2Pd61GBhUxSi4T54hDFxw3f78jKsVS6EVDwY7l9qlzOr5cB9HNpBBfVD6fBrd35hgByOSJUn4zMwl2bA2yTR9JggYKkZs8SF1TJA/2zEMSLs3xXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736421292; c=relaxed/simple;
	bh=GxrN+nb3aVh3KpjOh91hY2+ORaWu7+Ir03kW4TCpSwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mysrunUBmKqJi4PaWkBI7yG3H+VgmmjDyAb8wcdV0XNDNJsDEeAsXzkkDj+gLdkMbWOjWzunnLlN78sby0DiJGEMzLSH4UimPY88zCvR4SZWqqkelug7d3Y07aoq1mQ6bpXHTc6iVl7RxXpmIDmAVOmG6a7wLbe+qotsa61BkG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XF+8h+XE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x6c43wXY; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XF+8h+XE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x6c43wXY"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 68A0A1140137;
	Thu,  9 Jan 2025 06:14:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 09 Jan 2025 06:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736421289; x=1736507689; bh=YuAwl0uQ39
	yTVy2F9zji+vYiTDXGnK2tl2/30aGcI6E=; b=XF+8h+XEhBtRJp7x8O7VRwCGVI
	SaFW4KLcSvgo4KmFNb9XclgQDuh4Xexe26T1VlRmAFGUTBbqDPC/GGFFJAK3cVI0
	r8SnQfGx1E3npdxQke2jmlAUWguo97PGW++FHyOvVJHzJB2cgA4TTLLhDYF8aViG
	mZ9vM5TzwxxdlFc3547TgIMr248T80U8lF+fcGEYZAXIpzwkXL5DtOvgfBbdA+vB
	A8UsxLoR0bcHtilB9NhfmSIsXmupU2Scjk5vQSiCShh3ZWIDxRdMlTbEJk36UZ94
	hrnDeI/GU61G2Mblt4YPMQylWsCJLYpIxpVm1FpJPgcgPrCmuOzz1OrVyOIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736421289; x=1736507689; bh=YuAwl0uQ39yTVy2F9zji+vYiTDXGnK2tl2/
	30aGcI6E=; b=x6c43wXYiPm48NRIueMv3MRgbmmaJNOJBsbyNBuKMlzUoThgY4U
	a5an49fiCuC/V7jV/jiohKG6+FtlwC4w3/hlFmSb2/DckowlDaTuir2VdxfSjfps
	MkvU+ypWqrjE2IqfrakOc+BAmXeAANOlcvJm3uGXAYZFCxvCjOaEHW35Q07tLaim
	CY0jtTpFh2pYcMtvL+zvjiQ3yYZLllExbycfl0Sgapz4CTrCJsJopa9jMYqwE7IA
	RTGqaI0g3+yRGREO6gFv50UuXewZArYFnkgqUqsYScqEIleGk6alu7nhGyF0xOcW
	I5SzziH5nj4grylEj1n1fON9LOI4JzkdWSQ==
X-ME-Sender: <xms:qa9_Z1m3MuzXeagkqUyUJGxZ1Qa3ogIzUj6yOGUknBRkcjWYEoscJg>
    <xme:qa9_Zw0jVJ7fZO0R57qRlnsdkXgGQywgKxEe2gEqCh3FvDB9-Va7LZUBwpMInGFjM
    TU1XdvK61-un5IHNw>
X-ME-Received: <xmr:qa9_Z7ryrI6CFrEcomwCNNfg6407SWUZFYlzw3cTz4jLrMoCt7hm6G1moOGmmUpQYPHd8IHxUYK3uZ7zGS5KENiNvrSxftrmPmKXrTKRYKs_sCm7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepueegvedvjeetueekteellefhveefkefftdekvddugeeh
    ieefheefhefgvdetffevnecuffhomhgrihhnpehhhihruhhmshhlrgifrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgv
    shdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:qa9_Z1nhEXbRU19htNz8cpX5jazowk8GWeHVlwU3BTZD5vbY6XqQOA>
    <xmx:qa9_Zz2tYn7rL6uW_uNZ3ageG79zSc5vGSEG2z6bmM7CnE3mq75bzA>
    <xmx:qa9_Z0sty5IyZXs7qd61gy8yRJXUDWjoYEdhxOXYynl0t5jsCwk3XQ>
    <xmx:qa9_Z3U89UjTh8MZS8nwMZTeNVwNoHDdTncoVOFzeeEOH8hoQvubfA>
    <xmx:qa9_ZxBF7T0LUx5ab4rtDxFprpHUlmCxFRPeBk1RDa28jnBNcEC09jR9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 06:14:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 48e834dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jan 2025 11:14:45 +0000 (UTC)
Date: Thu, 9 Jan 2025 12:14:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/blame: fix out-of-bounds read with excessive
 `--abbrev`
Message-ID: <Z3-vpLHvxoQCTjY1@pks.im>
References: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im>
 <c439fcaf-11af-7862-9c3c-18dc0842b57d@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c439fcaf-11af-7862-9c3c-18dc0842b57d@gmx.de>

On Thu, Jan 09, 2025 at 11:49:43AM +0100, Johannes Schindelin wrote:
> > diff --git a/builtin/blame.c b/builtin/blame.c
> > index 867032e4c16878ffd56df8a73162b89ca4bd2694..ad91fe9e97f90625dd2708fbd44bf2dd24a337a6 100644
> > --- a/builtin/blame.c
> > +++ b/builtin/blame.c
> > @@ -475,6 +475,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
> >  		char ch;
> >  		size_t length = (opt & OUTPUT_LONG_OBJECT_NAME) ?
> >  			the_hash_algo->hexsz : (size_t) abbrev;
> > +		if (length > GIT_MAX_HEXSZ)
> > +			length = GIT_MAX_HEXSZ;
> 
> This causes a subtle change of behavior because there are a couple of
> conditional code blocks between this change and the `printf()` call
> decrease `length`, i.e. specifying values larger than the maximal hex size
> causes potentially-desirable, different behavior (and think about
> https://www.hyrumslaw.com/).

Alternatively we can move this until after we have done the
subtractions. Then we don't have to do weird gymnastics.

> >
> >  		if (opt & OUTPUT_COLOR_LINE) {
> >  			if (cnt > 0) {
> > @@ -505,7 +507,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
> >  			length--;
> >  			putchar('?');
> >  		}
> > -		fwrite(hex, 1, length, stdout);
> > +		printf("%.*s", (int)length, hex);
> >  		if (opt & OUTPUT_ANNOTATE_COMPAT) {
> >  			const char *name;
> >  			if (opt & OUTPUT_SHOW_EMAIL)
> > diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> > index 0147de304b4d104cc7f05ea1f8d68f1a07ceb80d..fcaba8c11f7ede084e069eefd292f337e8396cb4 100755
> > --- a/t/t8002-blame.sh
> > +++ b/t/t8002-blame.sh
> > @@ -126,6 +126,10 @@ test_expect_success '--no-abbrev works like --abbrev with full length' '
> >  	check_abbrev $hexsz --no-abbrev
> >  '
> >
> > +test_expect_success 'blame --abbrev gets truncated' '
> > +	check_abbrev 9000 --abbrev=$hexsz HEAD
> 
> This is actually incorrect: it passes `--abbrev=$hexsz` instead of a value
> that needs to be truncated.

Oh dear. The test did manage to catch the bug, but thinking more about
it that was only because my initial fix was broken.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index ad91fe9e97f9..5b4976835066 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -475,8 +475,13 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
>  		char ch;
>  		size_t length = (opt & OUTPUT_LONG_OBJECT_NAME) ?
>  			the_hash_algo->hexsz : (size_t) abbrev;
> -		if (length > GIT_MAX_HEXSZ)
> -			length = GIT_MAX_HEXSZ;
> +
> +		/*
> +		 * Leave enough space for ^, * and ? indicators (boundary,
> +		 * unblamable, ignored).
> +		 */
> +		if (length > GIT_MAX_HEXSZ + 3)
> +			length = GIT_MAX_HEXSZ + 3;
> 
>  		if (opt & OUTPUT_COLOR_LINE) {
>  			if (cnt > 0) {

How about this instead?

    diff --git a/builtin/blame.c b/builtin/blame.c
    index ad91fe9e97..f92e487bed 100644
    --- a/builtin/blame.c
    +++ b/builtin/blame.c
    @@ -475,8 +475,6 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
            char ch;
            size_t length = (opt & OUTPUT_LONG_OBJECT_NAME) ?
                the_hash_algo->hexsz : (size_t) abbrev;
    -		if (length > GIT_MAX_HEXSZ)
    -			length = GIT_MAX_HEXSZ;
     
            if (opt & OUTPUT_COLOR_LINE) {
                if (cnt > 0) {
    @@ -507,6 +505,9 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
                length--;
                putchar('?');
            }
    +
    +		if (length > GIT_MAX_HEXSZ)
    +			length = GIT_MAX_HEXSZ;
            printf("%.*s", (int)length, hex);
            if (opt & OUTPUT_ANNOTATE_COMPAT) {
                const char *name;

In that case there's no need to juggle with the magic indicators, which
makes it a bit easier to reason about.

> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> index fcaba8c11f7e..71fa70a64679 100755
> --- a/t/t8002-blame.sh
> +++ b/t/t8002-blame.sh
> @@ -127,7 +127,7 @@ test_expect_success '--no-abbrev works like --abbrev with full length' '
>  '
> 
>  test_expect_success 'blame --abbrev gets truncated' '
> -	check_abbrev 9000 --abbrev=$hexsz HEAD
> +	check_abbrev 9000 --abbrev=9000 HEAD..
>  '

This should be `check_abbrev $hexsz --abbrev=9000`, shouldn't it?

Patrick
