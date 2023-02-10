Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FCCC05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 22:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjBJWDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 17:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjBJWDm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 17:03:42 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4B15ACF0
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 14:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676066613; bh=ldMk8hjZJsYTWGGjuEtPakbrdGUY8kqNrrkrB/KpBsQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UW+ea65haMqPi7fsTU+yWpRBMIbwi1sEaswT6MAM7Nk9a1bv7DpEF2d2uqy1KQDKA
         92wJblHj+QJ5RTlwXbwNxM7WLWy1iT8rZ6FZckFCPBMZE4lgJ/4BnAXuUKthX8bLnb
         L8t11m01ACdtKpCo2eKn7cAtSQ45XM4iZEXRPfFHbEk2A0lI6pUr8ZH/r96nhGIXrw
         cXVrSvrxfSwjwG34op5nPUU6m5kEpkP7yqZu5ngW8Sz+aF/9PjZ+pBzIA6jH4Sh4ny
         bXFGGfo1vmz9CIaC5oGkvAURn3WnLZEn90Jsn5RbMPkNe67zlVu3OxIu89C+94ztrQ
         /QkYmJRzudFkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsrdM-1obvkT1wWe-00tFoQ; Fri, 10
 Feb 2023 23:03:33 +0100
Message-ID: <654092a2-6d3e-7ab4-a747-1ce36daad03d@web.de>
Date:   Fri, 10 Feb 2023 23:03:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH 1/5] git-compat-util: add isblank() and isgraph()
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>, git@vger.kernel.org
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20230210075939.44949-1-masahiroy@kernel.org>
 <20230210075939.44949-2-masahiroy@kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230210075939.44949-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2J1/7uXCJMBOUUtfwE1OCkh07+9cnmKtYgsvlxXlKOhAokXQ3uU
 qegOEGXlXM4WgVyAtklfH+o5tLFAAYEXr3geKbONmEOF6v6pS5wtj67WWaeFjFmzYa85rO8
 ElBks/85fUmp3fJsWCdFzno+jZoLhH2XT3MiAezp5wfU0gff2Xgj7na3DfPDQsa2MTAaFka
 uRSfvbg/wxNe166SdwqVw==
UI-OutboundReport: notjunk:1;M01:P0:7pFfnmLJ60Q=;HtDEqM2J6gDGXus0PTlmMD+lXfO
 0tYwGhtDX49A6VVBw6E77WpNxoWVSy2wZOwX3zUGsHgdU4zaKSQHhCrTR8v4lwcNoAwcuLzG5
 ztRByqQU6EZHKERFoVfESd+Rt1wtsZyELetl6LOqJjVCgZeMwIH+Xnr/zufWJ4YbKLrly+eqi
 kisB3V/xEFi/MqW23+a4JbMFhOdeIP1DPZVGY1qRhM9JVsdvZi0mqD5jqZ0h91ygde3d4AFcw
 J/vXd9go3zZCJJsWfRGpDryk5g8v76asYzaYUZL409NHjHq6O+F8VcKHT7+lHbKmWNXPWktA1
 WQlErPMLyq47ucLWnSWMYPHwCB8FOt6dWwOP9DAgLFfYVv7VBqz/RkJSy30FmQ/viqXPV0qbh
 fbVEn8x028I5K2BAs7ZP2lPkC5RBbZUUKYv8AMLywBAwi8AuWTZXaQcjnUcTILXnRnzQTp910
 Mk2aAGqF2jfjo0ve95S0f/2rFILF3HN2cif13bC2qNY+/KRw7HXzF0wAb90jz4VLes9UXN9Iq
 vxxm5teZcaA+dzN2ZEXIovyRMRu3j/YRayfcc6ucuJxGMnVM0BGpa7KLrJBrAlgb9AqLot/5s
 aoUhczlbNAsoeBMdmFkRbPbGmKASQX0O5laN2QRe14+2+BFrvpBZ8cOPfzckcW6NAv6NZDDcc
 819HcFW4HA+ri2dm41i5v1Y3dvAXlDz67LD/55pYIfkFcTqmYbUtE3tLaUsb3LwxnAZUwYICY
 atD03oH6cr7uW3qlYeRTUv6ZwH2DenBb9IkRKg1RQShT4HwKdffVkPbqbXUyNUCTUPKygvRZH
 xBvTSc1giUHDTqmMb9yeAjP4jUNhZWq8p6sMslt5fU+uPjRonwBwcyVAICA1JZFwaLo1t8PTQ
 eYvpCWUfWly3ZHzS9wDDXRIXYn/6k6K0sPiSLfbLmNmjQl0RYIUY0Ww2HhrkA6R8mutgTZS10
 t/ewwQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.02.23 um 08:59 schrieb Masahiro Yamada:
> git-compat-util.h implements most of is*() macros.
>
> Add isblank() and isgraph(), which are useful to clean up wildmatch.c
> in a consistent way (in this and later commits).
>
> Use them with care because they are not robust against the pointer
> increment, like isblank(*s++).
>
> The same issue already exists for isspace().
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  git-compat-util.h |  4 ++++
>  wildmatch.c       | 14 ++------------
>  2 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 4f0028ce60..90b43b2bc9 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1212,10 +1212,12 @@ extern const unsigned char tolower_trans_tbl[256=
];
>  /* Sane ctype - no locale, and works with signed chars */
>  #undef isascii
>  #undef isspace
> +#undef isblank
>  #undef isdigit
>  #undef isalpha
>  #undef isalnum
>  #undef isprint
> +#undef isgraph
>  #undef islower
>  #undef isupper
>  #undef tolower
> @@ -1236,10 +1238,12 @@ extern const unsigned char sane_ctype[256];
>  #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) =
!=3D 0)
>  #define isascii(x) (((x) & ~0x7f) =3D=3D 0)
>  #define isspace(x) sane_istest(x,GIT_SPACE)
> +#define isblank(x) (isspace(x) || (x) =3D=3D '\t')

Our isspace() matches \t, \n, \r and space.  A standard implementation
would also match \v (vertical tab) and \f (form feed).  Anyway, your
isblank() here is the same as isspace() because the check for \t is
redundant...

>  #define isdigit(x) sane_istest(x,GIT_DIGIT)
>  #define isalpha(x) sane_istest(x,GIT_ALPHA)
>  #define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
>  #define isprint(x) ((x) >=3D 0x20 && (x) <=3D 0x7e)
> +#define isgraph(x) (isprint(x) && !isspace(x))
>  #define islower(x) sane_iscase(x, 1)
>  #define isupper(x) sane_iscase(x, 0)
>  #define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
> diff --git a/wildmatch.c b/wildmatch.c
> index 7e5a7ea1ea..85c4c7f8a7 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -28,18 +28,8 @@ typedef unsigned char uchar;
>  # define ISASCII(c) isascii(c)
>  #endif
>
> -#ifdef isblank
> -# define ISBLANK(c) (ISASCII(c) && isblank(c))
> -#else
> -# define ISBLANK(c) ((c) =3D=3D ' ' || (c) =3D=3D '\t')

... and that's not the case for the original code, which only
matches \t and space.

We already use eight bits for the lookup table values in sane_ctype.
Perhaps it's time to move GIT_GLOB_SPECIAL, GIT_REGEX_SPECIAL,
GIT_PATHSPEC_MAGIC and GIT_PUNCT to their own table to make room for
flags for isprint(), isgraph() and isblank().

> -#endif
> -
> -#ifdef isgraph
> -# define ISGRAPH(c) (ISASCII(c) && isgraph(c))
> -#else
> -# define ISGRAPH(c) (ISASCII(c) && isprint(c) && !isspace(c))
> -#endif
> -
> +#define ISBLANK(c) (ISASCII(c) && isblank(c))
> +#define ISGRAPH(c) (ISASCII(c) && isgraph(c))
>  #define ISPRINT(c) (ISASCII(c) && isprint(c))
>  #define ISDIGIT(c) (ISASCII(c) && isdigit(c))
>  #define ISALNUM(c) (ISASCII(c) && isalnum(c))

