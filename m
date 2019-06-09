Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2948E1F462
	for <e@80x24.org>; Sun,  9 Jun 2019 08:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfFIIR2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 04:17:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:59159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbfFIIR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 04:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560068230;
        bh=xYdhjydemfNkcSuh6OOoxtDAuI7lXvqptMO4/d5mj4E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=U2+dGW2eU+tFy/o6bqXQWMSUQvwUMkntxSAibMMfNplAfSdaT4RKSbxZpGhTQv2Mv
         OLndQc7DzG4RHFdKOnfsbNCrT2DpzMIZxLb0ysA2uUlFEgADht0xak6N/PhFgog5GY
         C72Lw8DCnLQ2S5P8FoUrDSl3lDovFLP7L4L7Ok6w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from DESKTOP-QUA364F ([46.183.103.8]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOjMY-1hUxbE1Cf0-0068DI; Sun, 09
 Jun 2019 10:17:10 +0200
Date:   Sun, 9 Jun 2019 10:17:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@DESKTOP-QUA364F.localdomain
To:     Matthew DeVore <matvore@google.com>
cc:     git@vger.kernel.org, avarab@gmail.com, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        gitster@pobox.com, karthik.188@gmail.com, pclouds@gmail.com,
        sunshine@sunshineco.com, emilyshaffer@google.com, jrn@google.com
Subject: Re: [RFC PATCH] ref-filter: sort detached HEAD lines firstlyxy
In-Reply-To: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
Message-ID: <nycvar.QRO.7.76.6.1906090954510.789@QRFXGBC-DHN364S.ybpnyqbznva>
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Wm1czJ3jtGkuqT7vfjPUrStU5nGYpjtK/ETvMnT7V+9KszdWavd
 Bv8nPBEmO22V+Kkn9greqjKHpqHhZVuQ3NLAKTz2alqJBYsKm5/0VdVdaqnClpLHyJjajKp
 xPjp+Ylkngmd6nd69Z+cZH+7d0PyxxIzA2uA6vkDVUep0wT3Qx59xe6WFZmFmFYifepZvE1
 Zv7jCuXee8Z+JRgS425wA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ujvlgv6RPHk=:XevRmgagHiQImK9P2spgpt
 bzHk6asHURGLZEf7yEizHzI4GVc77ES91oHMCywAZBogynUjcU/qo9DNDVeLem1khSlBsxB/a
 rtgAmorcUrbkmK83is0PBeZ8/zVg+mftLX/aJ5LHHxEYI4bibayhmCaqcaQAfxXmdq/MXhorH
 uBZ9+k+UYzgMdrCkxjMmQTRVPQ1/vltXJdSnR6/XP0CpolEIfMnijuLHPT1XtIU1s84qXONco
 8U23eCJyx8gLdpDjGec4qHv4kbKL2XNRXZ4TlWv3mc75HQewLSZDyWrQdKCtjCVveYjSbG3w6
 juBq4KQbt8ZwU6NyKNikk+tB92PLU9oVdgcV/FU8uQbxSwCEy7Z/yT5Ve/k4ddDkBNerQTwuY
 Uq5PANud2gbfAPECahIWdSYtNG8SPPmeDBvUcn1awE/FUtG/3CoUUs/1iBeoasFysu1lnptQ/
 ah0BG47+jJA2XRwHTwxbrcUUWozY9kwLtIsWQMkIZpHvqcEQTtV6lGxzg5cm/RoJXcGKJWaEG
 HITAKXWua/0sSqmh0+Baafe7f9CGPbl2PhMYIe8RsYkrGLc26BMCVnnk5jk3nilnBpi18Kg0N
 Yn641tW1BV9a+4rSf0rY4JKqVp+RESgt6kGISXzVdRtZ3E0FRDZhbo0DBBswdCL9EyDGSbi+V
 lBZnwKV9OoDJ9dvTaxqFEe6qU8SUio+5DUosTn8zSS31Ak+dsNG1LUkAegaq0zRvbngTABd7k
 uKXfDRC/h1qiE4AhhtJkMCO9/rx/vs7UDwjYo6Wou5VH/1hb3iE7h9OIvjKaohVeMbc0gx5xz
 mgj3+mCS1w9rktQgRV8v84dwt5eL/HeJ4Ds19/bjuIRo7rGwSbb5yfJbJc8v++h2Fqf7N0UY8
 tVdNs8MvqjnfDiJhxFhjxJ3bFAy8yhb+Bt7wlrdVgqoDg+YpMlqrgc9+6vVY74IF/yexUPOnt
 jpyyo14NtOhoxvUr1flQ98425bEAVqwISMxdcrMgY9BKgd3Ey4C6zMfnIH170kExhfekzfHkF
 uQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthew,

On Thu, 6 Jun 2019, Matthew DeVore wrote:

> Before this patch, "git branch" would put "(HEAD detached...)" and "(no
> branch, rebasing...)" lines before all the other branches *in most
> cases* and only because of the fact that "(" is a low codepoint. This
> would not hold in the Chinese locale, which uses a full-width "(" symbol
> (codepoint FF08). This meant that the detached HEAD line would appear
> after all local refs and even after the remote refs if there were any.
>
> Deliberately sort the detached HEAD refs before other refs when sorting
> by refname rather than rely on codepoint subtleties.

This description is pretty convincing!

> diff --git a/ref-filter.c b/ref-filter.c
> index 8500671bc6..cbfae790f9 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2157,25 +2157,29 @@ static int cmp_ref_sorting(struct ref_sorting *s=
, struct ref_array_item *a, stru
>  	cmp_type cmp_type =3D used_atom[s->atom].type;
>  	int (*cmp_fn)(const char *, const char *);
>  	struct strbuf err =3D STRBUF_INIT;
>
>  	if (get_ref_atom_value(a, s->atom, &va, &err))
>  		die("%s", err.buf);
>  	if (get_ref_atom_value(b, s->atom, &vb, &err))
>  		die("%s", err.buf);
>  	strbuf_release(&err);
>  	cmp_fn =3D s->ignore_case ? strcasecmp : strcmp;
> -	if (s->version)
> +	if (s->version) {
>  		cmp =3D versioncmp(va->s, vb->s);
> -	else if (cmp_type =3D=3D FIELD_STR)
> +	} else if (cmp_type =3D=3D FIELD_STR) {

I find that it makes sense in general to suppress one's urges regarding
introducing `{ ... }` around one-liners when the patch does not actually
require it.

For example, I found this patch harder than necessary to read because of
it.

> +		if ((a->kind & FILTER_REFS_DETACHED_HEAD) !=3D
> +				(b->kind & FILTER_REFS_DETACHED_HEAD)) {

So in case that both are detached...

> +			return (a->kind & FILTER_REFS_DETACHED_HEAD) ? -1 : 1;
> +		}
>  		cmp =3D cmp_fn(va->s, vb->s);

... we compare their commit hashes, is that right? Might be worth a code
comment.

> -	else {
> +	} else {

FWIW it would have been a much more obvious patch if it had done

 	if (s->version)
		[...]
+	else if (cmp_type =3D=3D FIELD_STR &&
+		 (a->kind & FILTER_REFS_DETACHED_HEAD ||
+		  b->kind & FILTER_REFS_DETACHED_HEAD))
+		return (a->kind & FILTER_REFS_DETACHED_HEAD) ? -1 : 1;
 	else if (cmp_type =3D=3D FIELD_STR)
		[...]

Maybe still worth doing.

FWIW I was *so* tempted to write

	((a->kind ^ b->kind) & FILTER_REFS_DETACHED_HEAD)

to make this code DRYer, but then, readers not intimately familiar with
Boolean arithmetic might not even know about the `^` operator, making the
code harder to read than necessary, too.

> diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
> index 2139b427ca..de08d109dc 100644
> --- a/t/lib-gettext.sh
> +++ b/t/lib-gettext.sh
> @@ -25,23 +25,29 @@ then
>  		p
>  		q
>  	}')
>  	# is_IS.ISO8859-1 on Solaris and FreeBSD, is_IS.iso88591 on Debian
>  	is_IS_iso_locale=3D$(locale -a 2>/dev/null |
>  		sed -n '/^is_IS\.[iI][sS][oO]8859-*1$/{
>  		p
>  		q
>  	}')
>
> -	# Export them as an environment variable so the t0202/test.pl Perl
> -	# test can use it too
> -	export is_IS_locale is_IS_iso_locale
> +	zh_CN_locale=3D$(locale -a 2>/dev/null |
> +		sed -n '/^zh_CN\.[uU][tT][fF]-*8$/{
> +		p
> +		q
> +	}')
> +
> +	# Export them as environment variables so other tests can use them
> +	# too
> +	export is_IS_locale is_IS_iso_locale zh_CN_locale
>
>  	if test -n "$is_IS_locale" &&
>  		test $GIT_INTERNAL_GETTEXT_SH_SCHEME !=3D "fallthrough"
>  	then
>  		# Some of the tests need the reference Icelandic locale
>  		test_set_prereq GETTEXT_LOCALE
>
>  		# Exporting for t0202/test.pl
>  		GETTEXT_LOCALE=3D1
>  		export GETTEXT_LOCALE
> @@ -53,11 +59,15 @@ then
>  	if test -n "$is_IS_iso_locale" &&
>  		test $GIT_INTERNAL_GETTEXT_SH_SCHEME !=3D "fallthrough"
>  	then
>  		# Some of the tests need the reference Icelandic locale
>  		test_set_prereq GETTEXT_ISO_LOCALE
>
>  		say "# lib-gettext: Found '$is_IS_iso_locale' as an is_IS ISO-8859-1 =
locale"
>  	else
>  		say "# lib-gettext: No is_IS ISO-8859-1 locale available"
>  	fi
> +
> +	if test -z "$zh_CN_locale"; then
> +		say "# lib-gettext: No zh_CN UTF-8 locale available"
> +	fi

I wonder why this hunk, unlike the previous one, does not imitate the
is_IS handling closely.

> diff --git a/t/t3207-branch-intl.sh b/t/t3207-branch-intl.sh
> new file mode 100755
> index 0000000000..9f6fcc7481
> --- /dev/null
> +++ b/t/t3207-branch-intl.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +
> +test_description=3D'git branch internationalization tests'
> +
> +. ./lib-gettext.sh
> +
> +test_expect_success 'init repo' '
> +	git init r1 &&

Why?

> +	touch r1/foo &&
> +	git -C r1 add foo &&
> +	git -C r1 commit -m foo
> +'

Why not simply `test_commit foo`?

> +test_expect_success 'detached head sorts before other branches' '
> +	# Ref sorting logic should put detached heads before the other
> +	# branches, but this is not automatic when a branch name sorts
> +	# lexically before "(" or the full-width "(" (Unicode codepoint FF08).
> +	# The latter case is nearly guaranteed for the Chinese locale.
> +
> +	git -C r1 checkout HEAD^{} -- &&
> +	git -C r1 branch !should_be_after_detached HEAD &&

I am not sure that `!` is a wise choice, as it might not be a legal file
name character everywhere. A `.` or `-` might make more sense.

> +	LC_ALL=3D$zh_CN_locale LC_MESSAGES=3D$zh_CN_locale \
> +		git -C r1 branch >actual &&
> +	git -C r1 checkout - &&

Why call `checkout` after `branch`? That's unnecessary, we do not verify
anything after that call.

> +	awk "
> +	# We need full-width or half-width parens on the first line.
> +	NR =3D=3D 1 && (/[(].*[)]/ || /\xef\xbc\x88.*\xef\xbc\x89/) {
> +		found_head =3D 1;
> +	}
> +	/!should_be_after_detached/ {
> +		found_control_branch =3D 1;
> +	}
> +	END { exit !found_head || !found_control_branch }
> +	" actual

This might look beautiful for a fan of `awk`. For the vast majority of us,
this is not a good idea.

Remember, you do *not* write those tests for your own pleasure, you do
*not* write those tests in order to help you catch problems while you
develop your patches, you do *not* develop these tests in order to just
catch future breakages.

You *do* write those tests for *other* developers who you try to help in
preventing introducing regressions.

As such, you *want* the tests to be

- easy to understand for as wide a range of developers as you can make,

- quick,

- covering regressions, and *only* regressions,

- helping diagnose *and* fix regressions.

In the ideal case you won't even hear when developers found your test
helpful, and you will never, ever learn about regressions that have been
prevented.

You most frequently will hear about your tests when they did not do their
job well.

In this instance, I would have expected something like

	test_expect_lines =3D 3 actual &&

	head -n 1 <actual >first &&
	test_i18ngrep "detached HEAD" first &&

	tail -n 1 <actual >last &&
	grep should_be_after last

instead of the "awk-ward" code above.

Ciao,
Johannes

> +'
> +
> +test_done
> --
> 2.21.0
>
>
