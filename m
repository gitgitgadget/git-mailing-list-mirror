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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2A3C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 10:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B3764E38
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 10:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhBJKmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 05:42:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:35033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231314AbhBJKkf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 05:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612953520;
        bh=mE8EVNBdur5zmCMjQi200G+vtUVzFm0IS8N6Jc0mAq8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Uos2ueGOnEmsc4tI8fU6vhOAt9gMBfYNkR7M0H64Ej79t8QAq+khAAStj661/zCJU
         //s9u6EGeoCTRCSmlCAGmTHYBpZSQC4WRC3BlEHIfKVwr5qzKON6hH9cq+FzD7fqAs
         cblSUrELimZ/Suj6HW5M6LImLEhbDQzcX07/2VSk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([213.196.212.209]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysW2-1m4LUA2X1W-00w1J0; Wed, 10
 Feb 2021 11:38:40 +0100
Date:   Wed, 10 Feb 2021 11:38:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH 05/10] grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug
 mode
In-Reply-To: <20210204210556.25242-6-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2102101135390.29765@tvgsbejvaqbjf.bet>
References: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com> <20210204210556.25242-6-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1579169088-1612953538=:29765"
X-Provags-ID: V03:K1:LJAqZrNy8g89CDwsFQyNUV3m3xmFyLNXrW72fZMYxv7rYdpNw0U
 5CkQwR3RiYi55z/Fk8Hs8FW8wVzpjSsBc5TolgVcSQaRl3QpmcXs3pYJ5Na4pgwEbTmEZ2q
 3rbp48jFAjJFEOu1+HOKZC1a66Tw6m2pP94qz+g4GTaEMF1zIxVGeVO852a5UizYk6OQPpn
 JsC+K9azJ/ssiWVDPNVnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hIjOi9YYvA8=:Kyo5qp2gXkcoNyp0rH2Mj9
 xhkiHzm7e2g80FEnBjT3/OcXYqtjCZTIaMK11ckpGeoBUjw17hZSBCrNF8kFgzwcJhNIKzrRe
 OksFoO+iWx1gdwCWrS7wZy3LN/KnNQObgfkGnXSPaQysfNar4HhXhmhPK0+54QkvpPlERDFr1
 Tqv+tBN4ft7T/CDfhKmj/fllpnu6Nq/qK89ToQgGFZSmt/xmZ6fzdy8JfsELuW7taAm5GNXG4
 pEj5xYSGFE0JdOjB1+pGL5Rw3kY77TP/m5jIfOZa6/oRkFBunXIJXXtlCrWWp+8gJ+XRKdPQo
 6mkZkrQLSUXid58ErT3aLoTpNb35fkta/mbL/qjnKwbK8SgzFBCBXX+SrWreQoZgKdtECScNH
 FKRWbGk/ortGS9J1gHKTSMWPZZ6GlRTLaIolPvTre0aOAaY2QgJqrNoGdSms4lo46MehSZc4n
 gakkPamjZ3pTv1WZuKNGm4W0pSt8NLVze0PBSHmbpDh/kLEGM07B93PDWGT4rRFEC724yvPDS
 20szhub+SKcxH6vYR1abPk18xLJljc9hALtg8uNq0Jl2+zAYOD7n0BWdL4NkkU47ty0C7wufA
 jvcoUUgud4Vob2GyQuuO3Zo661LJeIVWRoHliQX7S893Pi5zDg1ao+l5hZe55mBFb6aMbflJE
 +6DIojl7jIJNTKmX+52f/vgu223c9oUsA33tNQthbwD/24LDMhcpBvmrpikd2VxQ0UKukoHjH
 yszKpM6a3MXNxJ0I6iJR5Hvh7ghQ9p81oNepl+0pbS5py6fRO8p4E6rTc6iA1XP8lOQxKI7iB
 DL6Kc4DjSCKQT4pqbfQAdeqLQjy/Jk/3R/JS24QpnN+YBhZNirr2RVYfsCA0H4vUBBjFuspm6
 r7UQHehwYFqoA6HEsb3KTnchRE2cw8evyPnACjjdk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1579169088-1612953538=:29765
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 4 Feb 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Add optional printing of PCREv2 allocations to stderr for a developer
> who manually changes the GREP_PCRE2_DEBUG_MALLOC definition to
> "1".

Maybe clarify in the oneline that this is not an environment variable, but
a Makefile knob? I had to read all the way to the diff to understand that
aspect.

Otherwise, the patch series so far looks really fine to me.

Thanks,
Dscho

>
> This will be referenced a subsequent commit, and is generally useful
> to manually see what's going on with PCREv2 allocations while working
> on that code.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/grep.c b/grep.c
> index f96d86c929..7d262a23d8 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -42,15 +42,25 @@ static struct grep_opt grep_defaults =3D {
>
>  #ifdef USE_LIBPCRE2
>  static pcre2_general_context *pcre2_global_context;
> +#define GREP_PCRE2_DEBUG_MALLOC 0
>
>  static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_da=
ta)
>  {
>  	void *pointer =3D malloc(size);
> +#if GREP_PCRE2_DEBUG_MALLOC
> +	static int count =3D 1;
> +	fprintf(stderr, "PCRE2:%p -> #%02d: alloc(%lu)\n", pointer, count++, s=
ize);
> +#endif
>  	return pointer;
>  }
>
>  static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
>  {
> +#if GREP_PCRE2_DEBUG_MALLOC
> +	static int count =3D 1;
> +	if (pointer)
> +		fprintf(stderr, "PCRE2:%p -> #%02d: free()\n", pointer, count++);
> +#endif
>  	free(pointer);
>  }
>  #endif
> --
> 2.30.0.284.gd98b1dd5eaa7
>
>

--8323328-1579169088-1612953538=:29765--
