Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20531C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 19:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 933262063A
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 19:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HHYlmkbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgKJTRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 14:17:11 -0500
Received: from mout.gmx.net ([212.227.15.18]:59065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJTRL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 14:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605035825;
        bh=wPXlwuW2EiwqKP/0u5RdCOEJHMhcjBn/mqLY/WSguvI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HHYlmkbRwvc5EfGHIr8Mf0WCXF8S1brQowEcLEDItRP/H21k6Dkx9mFQwtDYUU96A
         g+uvp7qB6SYCxeWpuVFEv+5evyS60HiV30icWGgA6OrUxCK9ju0skSunCAoWwH+rJU
         uU48wLNL2V/NSlUZxeYir/qqV2udUy84mKQ0aZ1k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpSl-1k5jM82Rsf-00gJqh; Tue, 10
 Nov 2020 20:17:05 +0100
Date:   Tue, 10 Nov 2020 20:17:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] add-interactive.c: use correct names to load color.diff.*
 config
In-Reply-To: <20201110182833.GB1362803@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2011102015160.18437@tvgsbejvaqbjf.bet>
References: <313B8999-1E99-4695-A20D-E48840C30879@gmail.com> <20201106170345.GA174555@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2011101653330.18437@tvgsbejvaqbjf.bet> <20201110182833.GB1362803@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UIE62fb8c31M3ZIHQ53YZKERkuxKBBq5ByI002i2CPjYf/ZaWJP
 y5QcVN/x4e7CtPie2axMyxMeFmI/q+OvCmkDDfQZ8PpMg01hD37SEVjV2ya8/1t/AYoCuLE
 4VBpk1K0JiAYRcLt2JqVtb5QNO7ZGpZorF0HXID3XkVjZLz6m9llxRd1dvWY2vgh6byodNT
 bT2S2vfl16Ln+ZDxdhoig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:voOkIAnwkX0=:Zn+Woh+fvlpm62n/ieZJEY
 2r/ujusPa9vxX1dzs9z48MzTNmFee6XTyPRZr8zYbwOAyOAiYgpoIa8EtRWHed4YwNl3GL77P
 m9btoFzqZAgDWyC3SJMM05+WMGpsVd/emP+mlDuESaIg3SRzNHedTMGGSqeUBJWhQ+rMx+wHL
 PEs5TzdAtnWnODnenhLwX1oR3+4G/K2YnR/fmIP+Qdvc1fGiWL6fnuz4gGxm4dkvTupTrGG1a
 Uv4sY5F1N3lu7Rp1Ja3X8IwIpl4V3c10iMy2aOtSeQdP3SwvC6XIoktt2ADrnT4PWAGi5k7Ii
 E6hRzRf9uklZ68iIsy7wGR7t7KRWL3cr2MOMnul6lTk/0BvPUkwTpWgb/0Amr3+9ycgeoZfeQ
 /7X9IxXhAVD2l7tNwXv7djGvj6xUQCvTzZs1Klg6ZBixzfLa0Xgj6MRIKWSbmmoZ4hqnzwiAW
 p/J/wL804h9eaLwYkO2juSiHwN9TG0f4eZdhBiEwo8Jt9ON+oYJ033SR1BSzzf5yHpOhxYNRS
 6mts+qA4m76ojE1C0cryuBBwHvUFsPPVp15Fo5jhQYPG7TXRQiuaB5s10S3FZGq4X5S/HpvCO
 sEEd/1YeZTE+Fljdlq7PmWbzt+zW1bRuJ3SelEw1FBiOypx2DBj6ctMNhXRyhMVxkR4YqUppM
 IJ9mhU7YYH0RaOBysfJ4NJRXh3Jb21LisioG940SyNXA5HCg1dsj79oyQLN/VL+u9r1Z9ptyN
 K13yfWdlvOH9rvBGbJQTI9iNMJQB3A+pB5zZPE31MqUdkKlH+Ho4gNoD4Gh5/fFTlj0+EUMOz
 5oJWvcrcVvU9d+S6XE3+kfw7AG88dy2l9W40jEOl91+IKT6pz+ANDIUDWAwr8R8k+8+4ZLNwk
 K0wBQeZViWiKYIO9Aih26W0Dzj7cZ8h0Prw7XdQZU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 10 Nov 2020, Jeff King wrote:

> On Tue, Nov 10, 2020 at 05:06:59PM +0100, Johannes Schindelin wrote:
>
> > A bigger puzzle for me was: why did we not catch that earlier? I vague=
ly
> > remember that we introduced _specifically_ code to test coloring, and =
to
> > make those test work on Windows (rather than skipping them all).
> >
> > *clicketyclick* ah, we only tests the menu of `git add -i`, and we do =
not
> > even override the colors...
>
> Yeah, the test coverage could definitely be improved.

I was actually already working on a comprehensive test case.

> > Will try to set aside some time to work on fixing this,
>
> How about this?
>
> -- >8 --
> Subject: add-interactive.c: use correct names to load color.diff.* confi=
g
>
> The builtin version of add-interactive mistakenly loads diff colors from
> color.interactive.* instead of color.diff.*. It also accidentally spells
> "frag" as "fraginfo".
>
> Let's fix that, and add some test coverage:
>
>   - check that color.diff.* is respected (this passes with the perl
>     version, but without this patch fails if GIT_TEST_ADD_I_USE_BUILTIN
>     is set)
>
>   - check that color.interactive.* is respected; this passes already
>     with both versions, but confirms we didn't break anything
>
> Note that neither test is exhaustive over the set of color config, but
> this is enough to sanity check the system (and we do check frag
> explicitly because of its typo).
>
> Note also that we don't respect the historical "diff.color.*". The perl
> version never did, and those have been deprecated since 2007.
>
> Signed-off-by: Jeff King <peff@peff.net>

If you don't mind, I'd like to integrate your work into mine and make you
a co-author. Objections?

Ciao,
Dscho

> ---
> I don't love that we have to repeat the set of color config here (and I
> guess maybe somebody would complain that we don't respect all of the
> weird "moved" variants?). But I agree that it's hard to re-use the
> existing diff code without stomping all over global variables. So I'd
> consider this the minimal fix bringing us in line with the perl version,
> but we may want to later revisit the diff color-config code as a whole.
>
>  add-interactive.c          | 22 ++++++++++++----------
>  t/t3701-add-interactive.sh | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 10 deletions(-)
>
> diff --git a/add-interactive.c b/add-interactive.c
> index 555c4abf32..208a058a68 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -12,10 +12,11 @@
>  #include "prompt.h"
>
>  static void init_color(struct repository *r, struct add_i_state *s,
> +		       const char *section,
>  		       const char *slot_name, char *dst,
>  		       const char *default_color)
>  {
> -	char *key =3D xstrfmt("color.interactive.%s", slot_name);
> +	char *key =3D xstrfmt("color.%s.%s", section, slot_name);
>  	const char *value;
>
>  	if (!s->use_color)
> @@ -40,18 +41,19 @@ void init_add_i_state(struct add_i_state *s, struct =
repository *r)
>  			git_config_colorbool("color.interactive", value);
>  	s->use_color =3D want_color(s->use_color);
>
> -	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
> -	init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
> -	init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
> -	init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
> -	init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
> -	init_color(r, s, "fraginfo", s->fraginfo_color,
> +	init_color(r, s, "interactive", "header", s->header_color, GIT_COLOR_B=
OLD);
> +	init_color(r, s, "interactive", "help", s->help_color, GIT_COLOR_BOLD_=
RED);
> +	init_color(r, s, "interactive", "prompt", s->prompt_color, GIT_COLOR_B=
OLD_BLUE);
> +	init_color(r, s, "interactive", "error", s->error_color, GIT_COLOR_BOL=
D_RED);
> +
> +	init_color(r, s, "diff", "reset", s->reset_color, GIT_COLOR_RESET);
> +	init_color(r, s, "diff", "frag", s->fraginfo_color,
>  		   diff_get_color(s->use_color, DIFF_FRAGINFO));
> -	init_color(r, s, "context", s->context_color,
> +	init_color(r, s, "diff", "context", s->context_color,
>  		diff_get_color(s->use_color, DIFF_CONTEXT));
> -	init_color(r, s, "old", s->file_old_color,
> +	init_color(r, s, "diff", "old", s->file_old_color,
>  		diff_get_color(s->use_color, DIFF_FILE_OLD));
> -	init_color(r, s, "new", s->file_new_color,
> +	init_color(r, s, "diff", "new", s->file_new_color,
>  		diff_get_color(s->use_color, DIFF_FILE_NEW));
>
>  	FREE_AND_NULL(s->interactive_diff_filter);
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index ca04fac417..7c3107a04a 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -602,6 +602,27 @@ test_expect_success 'colorized diffs respect diff.w=
sErrorHighlight' '
>  	grep "old<" output
>  '
>
> +test_expect_success 'colorized diffs respect color config' '
> +	git reset --hard &&
> +
> +	echo content >test &&
> +	printf y >y &&
> +	force_color git \
> +		-c color.diff.meta=3D"bold red" \
> +		-c color.diff.frag=3D"bold blue" \
> +		-c color.diff.old=3D"green" \
> +		-c color.diff.new=3D"red" \
> +		add -p >output.raw 2>&1 <y &&
> +	test_decode_color <output.raw >output &&
> +
> +	# do not check the full output, which would make the test brittle;
> +	# just make sure the items we configured were colored correctly
> +	grep "^<BOLD;RED>diff" output &&
> +	grep "^<BOLD;BLUE>@@" output &&
> +	grep "^<GREEN>-" output &&
> +	grep "^<RED>\+" output
> +'
> +
>  test_expect_success 'diffFilter filters diff' '
>  	git reset --hard &&
>
> @@ -884,4 +905,15 @@ test_expect_success 'show help from add--helper' '
>  	test_i18ncmp expect actual
>  '
>
> +test_expect_success 'interactive colors can be configured' '
> +	git reset --hard &&
> +
> +	test_write_lines h |
> +	force_color git \
> +		-c color.interactive.help=3D"bold yellow" \
> +		add -i >actual.colored &&
> +	test_decode_color <actual.colored >actual &&
> +	test_i18ngrep "^<BOLD;YELLOW>update" actual
> +'
> +
>  test_done
> --
> 2.29.2.640.g9e24689a4c
>
>
