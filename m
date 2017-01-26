Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDEAB1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 13:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbdAZNPl (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 08:15:41 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33849 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdAZNPk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 08:15:40 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so50245816wmi.1
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 05:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W7G5FDhzn/EY+UCVYBDipa6QsLXsRR+UnPSV34O3B70=;
        b=Ap3tWt4X++xxUYAV4IYBKCW/pI8eBbKUfidPhfIz63GbirEN2RhVZKqHnTwfuvMJLR
         UEDwR+iQZPqRB03uL5ihML6M/PCTTjEm5DX4FUH7nwu0W/DDKo/dpQD9MJsmVkQ0gr6z
         2+bGJfJ7cgc/Bc5SdY2qua4D9dUBOGeuC/asUwOTNltmzDLgaJgzihqbfdolj5CPTgVf
         1b5/AqG4T6QI1neBsLMYeQA1BDRj2pjyYXnW7hQvur5/Hhw7lFdW814euCNWmFdYVmhZ
         zPbGQeKIup/K0HqOknzsvICVPpqTydAx8t8WtCe4DvueCszScm1VloJbAM8NUdhzZ4qr
         VRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W7G5FDhzn/EY+UCVYBDipa6QsLXsRR+UnPSV34O3B70=;
        b=t7bZphu+oTL+CgiSvk7Oj2iVgeJpq+xkkK7cLzBDqXzwvAKtaWaAu15nR3MPlBkNoM
         5lnQuq/uq8V9BXqpR5Mlf42vrcYVUIoa59qoGyWuGC0UO5FkXML3lgtEtj6NeqYQBn+A
         6YWaFSqfHHtiYQPtmUArseHpb9cM9CTZGWxw1QXEyijJ0F0jFGUzdtkfYQctmtRaG2S+
         Ei93aRqg8Ce5D7GGqUJoVlDXVWa7Gr/gEOnSTsa06pBOdpxp2qAPmRrschwwuWBzZ5sc
         GcTlYCKUmTDA8Zcwdt/H6vZjOZCiQ+g525E24wcjniHnYVKiAGotFiDjZ9EuOxahPi4s
         eIzg==
X-Gm-Message-State: AIkVDXKW2Zqoa9KFq4Jszg9CdJZ9bvLMrUUwzQoHfPr2OM8GSYK9QZ5RK78Yq+CpVMztCh9JPRZsRIhzKu/lZw==
X-Received: by 10.223.128.3 with SMTP id 3mr2593773wrk.58.1485436538790; Thu,
 26 Jan 2017 05:15:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.249.8 with HTTP; Thu, 26 Jan 2017 05:15:38 -0800 (PST)
In-Reply-To: <20161207160923.7028-3-szeder.dev@gmail.com>
References: <20161207160923.7028-1-szeder.dev@gmail.com> <20161207160923.7028-3-szeder.dev@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 26 Jan 2017 14:15:38 +0100
Message-ID: <CAM0VKjntATMwDTdu1fSmjeLbwVe73iTo2NQizNXjZchBzqG44w@mail.gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: add function to parse atoms from a
 nul-terminated string
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 5:09 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> ref-filter's parse_ref_filter_atom() function parses an atom between
> the start and end pointers it gets as arguments.  This is fine for two
> of its callers, which process '%(atom)' format specifiers and the end
> pointer comes directly from strchr() looking for the closing ')'.
> However, it's not quite so straightforward for its other two callers,
> which process sort specifiers given as plain nul-terminated strings.
> Especially not for ref_default_sorting(), which has the default
> hard-coded as a string literal, but can't use it directly, because a
> pointer to the end of that string literal is needed as well.
> The next patch will add yet another caller using a string literal.
>
> Add a helper function around parse_ref_filter_atom() to parse an atom
> up to the terminating nul, and call this helper in those two callers.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  ref-filter.c | 8 ++------
>  ref-filter.h | 4 ++++
>  2 files changed, 6 insertions(+), 6 deletions(-)

Ping?

It looks like that this little two piece cleanup series fell on the floor.



> diff --git a/ref-filter.c b/ref-filter.c
> index dfadf577c..3c6fd4ba7 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1658,19 +1658,16 @@ void show_ref_array_item(struct ref_array_item *i=
nfo, const char *format, int qu
>  /*  If no sorting option is given, use refname to sort as default */
>  struct ref_sorting *ref_default_sorting(void)
>  {
> -       static const char cstr_name[] =3D "refname";
> -
>         struct ref_sorting *sorting =3D xcalloc(1, sizeof(*sorting));
>
>         sorting->next =3D NULL;
> -       sorting->atom =3D parse_ref_filter_atom(cstr_name, cstr_name + st=
rlen(cstr_name));
> +       sorting->atom =3D parse_ref_filter_atom_from_string("refname");
>         return sorting;
>  }
>
>  void parse_sorting_string(const char *arg, struct ref_sorting **sorting_=
tail)
>  {
>         struct ref_sorting *s;
> -       int len;
>
>         s =3D xcalloc(1, sizeof(*s));
>         s->next =3D *sorting_tail;
> @@ -1683,8 +1680,7 @@ void parse_sorting_string(const char *arg, struct r=
ef_sorting **sorting_tail)
>         if (skip_prefix(arg, "version:", &arg) ||
>             skip_prefix(arg, "v:", &arg))
>                 s->version =3D 1;
> -       len =3D strlen(arg);
> -       s->atom =3D parse_ref_filter_atom(arg, arg+len);
> +       s->atom =3D parse_ref_filter_atom_from_string(arg);
>  }
>
>  int parse_opt_ref_sorting(const struct option *opt, const char *arg, int=
 unset)
> diff --git a/ref-filter.h b/ref-filter.h
> index 49466a17d..1250537cf 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -94,6 +94,10 @@ int filter_refs(struct ref_array *array, struct ref_fi=
lter *filter, unsigned int
>  void ref_array_clear(struct ref_array *array);
>  /*  Parse format string and sort specifiers */
>  int parse_ref_filter_atom(const char *atom, const char *ep);
> +static inline int parse_ref_filter_atom_from_string(const char *atom)
> +{
> +       return parse_ref_filter_atom(atom, atom+strlen(atom));
> +}
>  /*  Used to verify if the given format is correct and to parse out the u=
sed atoms */
>  int verify_ref_format(const char *format);
>  /*  Sort the given ref_array as per the ref_sorting provided */
> --
> 2.11.0.78.g5a2d011
>
