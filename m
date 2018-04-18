Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C390A1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 17:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeDRRet (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 13:34:49 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:36010 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeDRRes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 13:34:48 -0400
Received: by mail-yb0-f172.google.com with SMTP id v140-v6so884759ybe.3
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dhfm4pxDMfE3GEOfHcJ8xrc5YI9A6CmBx8BQe8fhjqQ=;
        b=mjJI8yyVk1H7MCvHePFtsAVNGXE5j53XY9DUTrBmyiRCrvz1pk9c2olM6cp1Png+G+
         2iV1BwWbAX2UdeUXzidpdlRHsIA84as6tDysJWJzovuPGiL2G0867J+tDq8I1+a33JHl
         Nqb2+4fGO920iI7qn9wfDwvuzbR+0ehNmmFCGfqIUPc+BFlwg0NkC2ttjUeFzSE1/PaV
         BaCgbJCPfjxfDKGUUXABCeA8pLKhjapmeqXh4qB1u1REpyKVE+VjAGaOXgVZVQs7Gec7
         5fhafCD+nk7jWt0fwJs9r2vmVDYPcnRV4e+SiHMsLJW6LSAWjWC2XWariquPYiw63hio
         3BCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dhfm4pxDMfE3GEOfHcJ8xrc5YI9A6CmBx8BQe8fhjqQ=;
        b=KKBzsK99zamjWzQI2XZPtKJIh0rIHS7pK2ICssQ3zS4Od/lYuPYklYoNT8ysCXRc3o
         Izt5HPsH3ArF9dab7mwmpuskaM9z6YD7Y+PXttOkmgmfdH2sDn5xV8tPpdmAZTkNnWrW
         iLTxjlD5I9UzogZuiv/flYPaoHIHcixfG6syKkabwji1HjWLRfhOv4uYRy1RyjD75B4e
         Z8AkXm8gnW97oKjecNivmsA8H/cv0/lhW92ICq0UPAJEBW3bw+D6ggq8kouUIbTK5ej3
         2ExUve0gflcTzu/kPP7fmN60PwYw6dks11Iq4fGZP2HTv7ihTqbn56cApRJiVoBZud8j
         yXXg==
X-Gm-Message-State: ALQs6tCYpySL7ZHofv4Rc+Q+xjO3Spo1E7Bsn4Y5C3+P/httrm89X2XZ
        57OhoQV35vXP1F/FgJ0PO3glpS7d59+F2qBIhAl9cw==
X-Google-Smtp-Source: AIpwx48lB9zwlz4GeQ+FaH+Q4e4/As6YZpCel6bLJKqfOEZndT6z5ggBqTz0LPIm+iGkQ7QgrdU9OCFx576fESuTn4o=
X-Received: by 2002:a25:fc16:: with SMTP id v22-v6mr1912568ybd.247.1524072887333;
 Wed, 18 Apr 2018 10:34:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 18 Apr 2018 10:34:46
 -0700 (PDT)
In-Reply-To: <20180418145337.7591-1-pclouds@gmail.com>
References: <20180418145337.7591-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Apr 2018 10:34:46 -0700
Message-ID: <CAGZ79ka=z82u_wByO++Ds4uLWi1TB2=Etzbhb3vev8qpYzBMeg@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: don't print null in 'submodule status'
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nguy=E1=BB=85n,

On Wed, Apr 18, 2018 at 7:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> The function compute_rev_name() can return NULL sometimes (e.g. right
> after 'submodule init'). The current code makes 'submodule status'
> print this:
>
>  19d97bf5af05312267c2e874ee6bcf584d9e9681 sha1collisiondetection ((null))
>
> This ugly 'null' adds no value to the user using this command. More
> importantly printf() on some platform can't handle NULL as a string
> and will crash instead of printing '(null)'.
>
> Check for this and skip printing this part (the alternative is
> printing '(n/a)' or something but I think that is just noise).

This patch restores the behavior from before a9f8a37584 (submodule:
port submodule subcommand 'status' from shell to C, 2017-10-06),
so this is the right way to go instead of the alternatives you considered.

Thanks!

Reviewed-by: Stefan Beller <sbeller@google.com>

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/submodule--helper.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a404df3ea4..4dc7d7d29f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -596,8 +596,12 @@ static void print_status(unsigned int flags, char st=
ate, const char *path,
>
>         printf("%c%s %s", state, oid_to_hex(oid), displaypath);
>
> -       if (state =3D=3D ' ' || state =3D=3D '+')
> -               printf(" (%s)", compute_rev_name(path, oid_to_hex(oid)));
> +       if (state =3D=3D ' ' || state =3D=3D '+') {
> +               const char *name =3D compute_rev_name(path, oid_to_hex(oi=
d));
> +
> +               if (name)
> +                       printf(" (%s)", name);
> +       }
>
>         printf("\n");
>  }
> --
> 2.17.0.367.g5dd2e386c3
>
