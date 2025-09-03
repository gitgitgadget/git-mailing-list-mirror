Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204B2D94A8
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884215; cv=none; b=SlJAeSMO0YDab6CFMrldhcF9LEb9rT40KoJzWuBXhfN9DlKlh5VaYrDxSVeJMHA+zQnFGqrU7Ae4tBcvrtmJZbTfjCRhgkXegPAq67gFNmS4HUrgUCeKzX7gHgXcOprR6xSg4//2UKdkvwqidOiUDNl8EAmwiKbC+zIE7icjLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884215; c=relaxed/simple;
	bh=BVJu6qxwQvB8Che8E23gm//bQpNx9jpEK9puDHTqYcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksVmWBgOpefFFEbzdY+XH9NKYXYR2AIdff8eC7EJeWzALc1xUwQbYBUQ5FYBYoywrrH6Rnjit9kzB2ic7VrpqDTp/Ka5dt6Wu9OQiqJ2AYdCLCgO3FTxcOyPOJLvN2KHDfvLL4w9VQCYGl6UY0MqYKV8JD6kVKbskVqM408efHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ky80ilBD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LFNA3gD6; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ky80ilBD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LFNA3gD6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 91035EC0362;
	Wed,  3 Sep 2025 03:23:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 03 Sep 2025 03:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756884212; x=1756970612; bh=Trn27IyflS
	SwhdxAYXl1uyX2zvljYTfsYO42SCMjZCM=; b=Ky80ilBDmGi2gePVPGlBWjVLdr
	bMMlgI5z5xw4v9+SoXRhomjGU8obZnvUpoYC1H9ky3rAv336jnXcwcK74rhg3FcJ
	UoHNkgWWtB1j3BTIn5pPoU5+PxjIW1x/oLa6h2SkQRwDuDJv4jI1zPyvCyocnKo8
	ihoVjwdk5fvoJfQ6FBjWkNWEACpt6o2lT0n1NshhqR6U5Ud++4VVfu9gewfI/G6k
	BV4016AtbER3ikb75c6Nu5roADjMRNc5NBde+Uy4Y2uzTUi4geCi9Rd0CjIYaPb0
	dZneQK6+xsPGW1RwuYfK/Uq+UZti0r0tvHZg20GVPnyIVs9yXrseqAnsbaFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756884212; x=1756970612; bh=Trn27IyflSSwhdxAYXl1uyX2zvljYTfsYO4
	2SCMjZCM=; b=LFNA3gD6Nt+oCS2kUyb2HVue5lkyhAbejKdZyM5yQaGf8gQYtfx
	8zyoZAGB+SGKsbnKc/JTqigORc16hnwDK8NETZ2QuQtPGHdaNBiOJG/V/8A1uiQl
	3LkU9Hi7Qz47OQ6L0AS04O5DRHDLWmhRHeLxSoaTvpzpaUMzD+udnpLMzbbhyeRa
	DWxfOjV7vNBKfM3FQUH+X9SwRBUYDa2hmXbhVE3M1HmTzRJu2wH05WCTFy4ypjpc
	Ezsly+GDgGjlH4HhR6QFWn10zuPoaarhs3/gcCL3L9cEeme5C7YvXIb2t5N1rNq2
	EzuWdCF8wMUH7351xw+Hwov0Zi3JuoI1dsg==
X-ME-Sender: <xms:9Oy3aOUdmbV3dut93UAqwDIPpWsQ0WwFdb0_634dQx6WKvMVV-Uf_g>
    <xme:9Oy3aBf0inLogeFelZLh4ztG56khCs65C-J6ZSwcDxrvhIAYa5Nfb9lKDI7TQ6CFs
    9upDZuZIey4cs823Q>
X-ME-Received: <xmr:9Oy3aPUYPJ6WFiYkjC8gVwnRxlfYGExROytTCaBp0gz0QqOwI1DKZBkRn2gWOElbcBGPjZZ7dB3tJceWbvBX5hco5cABfF6trDJyHRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ihhsrggrtghoshgtrghrsehlihhvvgdrtghomhdrrghupdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:9Oy3aCfIsUN9i3-a37hbBXtIATQvV2uzL9C0ncnK2LkFqVYcXMTisw>
    <xmx:9Oy3aDMDqEWO3O6DwiXHSgOTd5lsBk-TqwNEI1DhQ5zIUyLlANBeIA>
    <xmx:9Oy3aIg8VzYOoIlvMNqvhbG3X6jLbFUYYlDjkwG7Fh0EsguIGbLH1Q>
    <xmx:9Oy3aO0DBxrTWe3db_3eOO0pWtka04wZGcYisFyCB9FSVJ_5ZmT6gw>
    <xmx:9Oy3aIZTr058bGRejfspWQAk6czV5Rrn2SZTFSNqDtTuSSTodNVuvcC1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 03:23:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec3fe008 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 07:23:30 +0000 (UTC)
Date: Wed, 3 Sep 2025 09:23:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Isaac Oscar Gariano <isaacoscar@live.com.au>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] add-interactive: respect color.diff for diff coloring
Message-ID: <aLfs7wuFpMhg8fK_@pks.im>
References: <20250821070740.GA3356411@coredump.intra.peff.net>
 <20250821071918.GB1839835@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821071918.GB1839835@coredump.intra.peff.net>

On Thu, Aug 21, 2025 at 03:19:18AM -0400, Jeff King wrote:
> diff --git a/add-interactive.c b/add-interactive.c
> index 3e692b47ec..95ab251963 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -20,14 +20,14 @@
>  #include "prompt.h"
>  #include "tree.h"
>  
> -static void init_color(struct repository *r, struct add_i_state *s,
> +static void init_color(struct repository *r, int use_color,
>  		       const char *section_and_slot, char *dst,
>  		       const char *default_color)
>  {
>  	char *key = xstrfmt("color.%s", section_and_slot);
>  	const char *value;
>  
> -	if (!s->use_color)
> +	if (!use_color)
>  		dst[0] = '\0';
>  	else if (repo_config_get_value(r, key, &value) ||
>  		 color_parse(value, dst))

Okay. This needs to change so that we can pass in either
`use_color_diff` or `use_color_interactive`.

> @@ -36,42 +36,54 @@ static void init_color(struct repository *r, struct add_i_state *s,
>  	free(key);
>  }
>  
> -void init_add_i_state(struct add_i_state *s, struct repository *r,
> -		      struct add_p_opt *add_p_opt)
> +static int check_color_config(struct repository *r, const char *var)
>  {
>  	const char *value;
> +	int ret;
> +
> +	if (repo_config_get_value(r, var, &value))
> +		ret = -1;

Not an old issue, but should we use `GIT_COLOR_UNKNOWN` here?

> @@ -109,7 +121,8 @@ void clear_add_i_state(struct add_i_state *s)
>  	FREE_AND_NULL(s->interactive_diff_filter);
>  	FREE_AND_NULL(s->interactive_diff_algorithm);
>  	memset(s, 0, sizeof(*s));
> -	s->use_color = -1;
> +	s->use_color_interactive = -1;
> +	s->use_color_diff = -1;
>  }
>  
>  /*

Same here, should we use `GIT_COLOR_UNKNOWN` to initialize these fields?
It would be even better if the `GIT_COLOR` values were a proper enum so
that we can use the type in both `want_color_fd()` and for these struct
members.

> @@ -1188,9 +1201,9 @@ int run_add_i(struct repository *r, const struct pathspec *ps,
>  	 * When color was asked for, use the prompt color for
>  	 * highlighting, otherwise use square brackets.
>  	 */
> -	if (s.use_color) {
> +	if (s.use_color_interactive) {
>  		data.color = s.prompt_color;
> -		data.reset = s.reset_color;
> +		data.reset = s.reset_color_interactive;
>  	}
>  	print_file_item_data.color = data.color;
>  	print_file_item_data.reset = data.reset;

Makes sense. We don't want to show the diff here, but render the prompt,
which should of course honor the interactive colors.

> diff --git a/add-patch.c b/add-patch.c
> index 302e6ba7d9..b0389c5d5b 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -300,7 +300,7 @@ static void err(struct add_p_state *s, const char *fmt, ...)
>  	va_start(args, fmt);
>  	fputs(s->s.error_color, stdout);
>  	vprintf(fmt, args);
> -	puts(s->s.reset_color);
> +	puts(s->s.reset_color_interactive);
>  	va_end(args);
>  }

Yup, printing an error message should respect interactive colors.

> @@ -457,7 +457,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  	}
>  	strbuf_complete_line(plain);
>  
> -	if (want_color_fd(1, -1)) {
> +	if (want_color_fd(1, s->s.use_color_diff)) {
>  		struct child_process colored_cp = CHILD_PROCESS_INIT;
>  		const char *diff_filter = s->s.interactive_diff_filter;
>  

We're printing the diff here, and this change is the whole point of this
commit as far as I understand as we now properly respect configured diff
colors.

> @@ -714,7 +714,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
>  		if (len)
>  			strbuf_add(out, p, len);
>  		else if (colored)
> -			strbuf_addf(out, "%s\n", s->s.reset_color);
> +			strbuf_addf(out, "%s\n", s->s.reset_color_diff);
>  		else
>  			strbuf_addch(out, '\n');
>  	}
> @@ -1107,7 +1107,7 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
>  			      s->s.file_new_color :
>  			      s->s.context_color);
>  		strbuf_add(&s->colored, plain + current, eol - current);
> -		strbuf_addstr(&s->colored, s->s.reset_color);
> +		strbuf_addstr(&s->colored, s->s.reset_color_diff);
>  		if (next > eol)
>  			strbuf_add(&s->colored, plain + eol, next - eol);
>  		current = next;

Both of these print diff hunks, which should use diff colors.

> @@ -1528,8 +1528,8 @@ static int patch_update_file(struct add_p_state *s,
>  						: 1));
>  		printf(_(s->mode->prompt_mode[prompt_mode_type]),
>  		       s->buf.buf);
> -		if (*s->s.reset_color)
> -			fputs(s->s.reset_color, stdout);
> +		if (*s->s.reset_color_interactive)
> +			fputs(s->s.reset_color_interactive, stdout);
>  		fflush(stdout);
>  		if (read_single_character(s) == EOF)
>  			break;

And here we reset colors after the prompt. So all of these conversions
look good.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 04d2a19835..3f9cb9453f 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -866,6 +866,42 @@ test_expect_success 'colorized diffs respect diff.wsErrorHighlight' '
>  	test_grep "old<" output
>  '
>  
> +test_expect_success 'diff color respects color.diff' '
> +	git reset --hard &&
> +
> +	echo old >test &&
> +	git add test &&
> +	echo new >test &&
> +
> +	printf n >n &&
> +	force_color git \
> +		-c color.interactive=auto \
> +		-c color.interactive.prompt=blue \
> +		-c color.diff=false \
> +		-c color.diff.old=red \
> +		add -p >output.raw 2>&1 <n &&
> +	test_decode_color <output.raw >output &&
> +	test_grep "BLUE.*Stage this hunk" output &&
> +	test_grep ! "RED" output
> +'
> +
> +test_expect_success 're-coloring diff without color.interactive' '
> +	git reset --hard &&
> +
> +	test_write_lines 1 2 3 >test &&
> +	git add test &&
> +	test_write_lines one 2 three >test &&
> +
> +	test_write_lines s n n |
> +	force_color git \
> +		-c color.interactive=false \
> +		-c color.diff=true \
> +		-c color.diff.frag="bold magenta" \
> +		add -p >output.raw 2>&1 &&
> +	test_decode_color <output.raw >output &&
> +	test_grep "<BOLD;MAGENTA>@@" output
> +'
> +

Should we also verify that the interactive prompts aren't colored here?

Patrick
