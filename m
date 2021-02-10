Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3496EC433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 12:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BDF64E05
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 12:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhBJMoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 07:44:21 -0500
Received: from mout.gmx.net ([212.227.15.15]:57361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231860AbhBJMmV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 07:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612960842;
        bh=6CggOUaydezoRdDKzEOVEkswoA5PEbKZpmQpWLA/heY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Jq+pR1DJjd9LGy6q7T+w0NfQdynt1qWWQhKzcbc44SmQ3mWG2Ok9WWjKZeaK3k9cc
         40u5S4g36m8ZuCYRwmT1g8bW6b1ha+uA2hwXsPS1UFlojlDcHJweRgW0YWSGXEl67j
         10pcY7JpEATPXcRb+L8gWEd3NuDNYxZhLa5VXBwY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([213.196.212.209]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHMZ-1lc3510rmr-00kjsL; Wed, 10
 Feb 2021 13:40:42 +0100
Date:   Wed, 10 Feb 2021 13:40:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH 10/10] grep/pcre2: move definitions of
 pcre2_{malloc,free}
In-Reply-To: <20210204210556.25242-11-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2102101339560.29765@tvgsbejvaqbjf.bet>
References: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com> <20210204210556.25242-11-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-766125519-1612960859=:29765"
X-Provags-ID: V03:K1:qhqr+p8jbY6X8CyKGgOAfC5b0S8WX0ESErhApYBchKll3mzLe18
 mqVYnUzd5iem2ed1c5OxA7a/EzKQZSb0hJ3l8V/fPmJRxvh+EoYesSsomes1JJducTo6kWj
 r+NFKjlSiVD4YeHtWxuls9E10DwxNQCKBesgkT+i0ANSbmiEZF47BWEj4/nSnCslPJNg2m8
 DoCVsMGqEp9EA4LeGAiOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JBN/wn1xnvY=:hn00NKepHfybz6muFLnbl8
 e81vpgVBv9I7eBDEAdTTqS3KftBWd1bXyD0K8QSgWmrL+fEjhtzEZaV10UGMMuc4RcG8Wnii0
 X/rShs72lbwoeyvddRAy9kPUOd6bVVfrWDOZwbfYtPePuCkT2QLnR/ImB0EbWZuJrQWvYl4uA
 rxeg7Usp/tHWUU+tNwfsYHAR5y9n3fLgy1N+gDKV93BaqMSin3ss87x1oM8kJnUL647kQppd1
 MNq9P9fzyv9VET/dLup6h/4acFScfUhyp2PsnHAoCYAZUTlGwymMz7mtFrg0/GRH1V9fBZkcH
 ADgdXP9gPZVJad4ZIkf95jymz+zkCrmQyalOKrsmAHoiobywc3bB2P8LTAqR1wdR6iwJUVOkB
 dEm0R1Z8uIb1dlP2wLidQae2kndsyrHMB1RoYz4kUMyVE6ETIif+jk3UTDqnTdKOubOCMGNfi
 DUlJu+L3VQWgez5IQihX2wwKscIUecbixIaMBsOcOAaaGT/v9vuTr5c0zGJZ09qApqgeL6shw
 neXsnGw4gm2OBRlPJoDSrouz4Z8LUWJxxBg+v/Rj3BrnatJ/ufwKOukOVHAnCPpJRHeG3ZOyz
 BFbRjySJWhAxhSvHCXcucBw11wJ0J4cfH6f80JeEpyYt10jcPSmqHlWQQJ7Qe59JRgr1D3+4h
 ocS45zPoI+F06vBgeb9QRez1PVN60RhdjbwVF+Rx71RUs0cogZkF+foQYyvatL9sAAC04mi47
 3JdpLQVZET/Ot30l6L3lV5XAuAnXTCxe2eQo0X8+cz68r3PTwyL0sxkDScq6XYsnic3NwSJRg
 Dtilt0ZRcOPUjQJM3fvrHb8AsyejoQJrB9ZaF3ju/JEGTtGIweTOVbJyjpWu7hfzdBHYlRu6a
 KxHr6esbzKKCA1Up6Ju50kRGIeeon035p+B8nZSwk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-766125519-1612960859=:29765
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 4 Feb 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Move the definitions of the pcre2_{malloc,free} functions above the
> compile_pcre2_pattern() function they're used it. Before the preceding

s/it/in/

Thank you for this entire patch series. I like its intention and its
execution.

Ciao,
Dscho

> commit they used to be needed earlier, but now we can move them to be
> adjacent to the other PCREv2 functions.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 46 ++++++++++++++++++++++------------------------
>  1 file changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 2599f329cd..636ac48bf0 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -40,30 +40,6 @@ static struct grep_opt grep_defaults =3D {
>  	.output =3D std_output,
>  };
>
> -#ifdef USE_LIBPCRE2
> -#define GREP_PCRE2_DEBUG_MALLOC 0
> -
> -static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_da=
ta)
> -{
> -	void *pointer =3D malloc(size);
> -#if GREP_PCRE2_DEBUG_MALLOC
> -	static int count =3D 1;
> -	fprintf(stderr, "PCRE2:%p -> #%02d: alloc(%lu)\n", pointer, count++, s=
ize);
> -#endif
> -	return pointer;
> -}
> -
> -static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
> -{
> -#if GREP_PCRE2_DEBUG_MALLOC
> -	static int count =3D 1;
> -	if (pointer)
> -		fprintf(stderr, "PCRE2:%p -> #%02d: free()\n", pointer, count++);
> -#endif
> -	free(pointer);
> -}
> -#endif
> -
>  static const char *color_grep_slots[] =3D {
>  	[GREP_COLOR_CONTEXT]	    =3D "context",
>  	[GREP_COLOR_FILENAME]	    =3D "filename",
> @@ -355,6 +331,28 @@ static int is_fixed(const char *s, size_t len)
>  }
>
>  #ifdef USE_LIBPCRE2
> +#define GREP_PCRE2_DEBUG_MALLOC 0
> +
> +static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_da=
ta)
> +{
> +	void *pointer =3D malloc(size);
> +#if GREP_PCRE2_DEBUG_MALLOC
> +	static int count =3D 1;
> +	fprintf(stderr, "PCRE2:%p -> #%02d: alloc(%lu)\n", pointer, count++, s=
ize);
> +#endif
> +	return pointer;
> +}
> +
> +static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
> +{
> +#if GREP_PCRE2_DEBUG_MALLOC
> +	static int count =3D 1;
> +	if (pointer)
> +		fprintf(stderr, "PCRE2:%p -> #%02d: free()\n", pointer, count++);
> +#endif
> +	free(pointer);
> +}
> +
>  static void compile_pcre2_pattern(struct grep_pat *p, const struct grep=
_opt *opt)
>  {
>  	int error;
> --
> 2.30.0.284.gd98b1dd5eaa7
>
>

--8323328-766125519-1612960859=:29765--
