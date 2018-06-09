Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF68C1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 17:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932212AbeFIR5h (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 13:57:37 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:46369 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbeFIR5g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 13:57:36 -0400
Received: by mail-ua0-f194.google.com with SMTP id e8-v6so10963632uam.13
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lLF+pAlA4xIvD9r/D16k7vnIhBCFTi94fEZ0ofhMpps=;
        b=Y4WH6hkHgbymBjDxsSnJU6ftgg9Y72cwPCQ41Zv7KxQYGkS3gt0vsdV1reZzXJdPh0
         tdid/idmmpY97N/5iFbiQ6kJT2Sr+M2+XvTLisfshiws8e4sNFTvZMxUbWxpb/OjZxqi
         /xa0lGh2jTnK2e2bLPoUSGEQjdjgHRfKZQM9v2uQZ6Xpoar7IwRkSpkl36ssTUViI9i5
         fqbND1soAwamI+P2yGl/mnqR4zv+Zo8ZJMRW6/zIKjzrcu8PL28Sr1x5ZbfalsJ2Mghu
         tHGM7GsmemusJy4YCsx/lxVuxhoQ61r+aR+b6ucp4KbZut9bF2HiZpVRVEGB3io0GxCU
         IFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lLF+pAlA4xIvD9r/D16k7vnIhBCFTi94fEZ0ofhMpps=;
        b=I6Iz2qy4Ht8ArF/8LCCDxygia8HE7XrCpoGOnwb2ubxHKh3BQ7xZAjdyQ3oGhG8pj4
         3+8L0qBXhi87K6qc+9fzJ+Ip1Ll0qtJR7lKOmqUxgpWbOHZB0MlBkEweNLNSpamKTGX/
         1D+ypOUcw8iSG4sKmbYOM6s2z7xA7vPP7CGEEeYvfD1zkB8w989FomrzGJdDAcuOeDqH
         x/STNN421uFgCn0IqLrmZZofXm8wfPfXR0cNbyuQ1jVClq3Rad+5KwSRrE+I3rpcwMxX
         k6GrxOgGgTKB9k6PREKmVaqgG+vArEMgJOjWRsqixYYhe613xwrhEgfGFdLfJUC0UEMC
         /4hw==
X-Gm-Message-State: APt69E1qu4X9xwIe241zDhuejrITlIqPgSqFPgAfoyeI0bbbompZablI
        sbeeLlaQsq9Qdgeczk7qNa1INDStOoCSukAqJj4=
X-Google-Smtp-Source: ADUXVKKwLqBntsgsAKtu3y5gdNpFN2TiuJg5ZK01NL12VkH1tHdyecpp0LUgIvxJ7Wv+eIUWnBiFIrBXrwsBsVtBHz4=
X-Received: by 2002:ab0:4c82:: with SMTP id y2-v6mr7774097uaf.94.1528567055681;
 Sat, 09 Jun 2018 10:57:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 10:57:35 -0700 (PDT)
In-Reply-To: <20180606170243.4169-10-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com> <20180606170243.4169-1-pclouds@gmail.com>
 <20180606170243.4169-10-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Jun 2018 10:57:35 -0700
Message-ID: <CABPp-BGuXuyKstVY-sid5tFiVykpkYLGnjuYZU2nv2Sg3zZSSw@mail.gmail.com>
Subject: Re: [PATCH v4 15/23] attr: remove index from git_attr_set_direction()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 10:02 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Since attr checking API now take the index, there's no need to set an
> index in advance with this call. Most call sites are straightforward
> because they either pass the_index or NULL (which defaults back to
> the_index previously). There's only one suspicious call site in
> unpack-trees.c where it sets a different index.
>
> This code in unpack-trees is about to checking out entries from the

minor nit: s/checking/check/ ?

...

> diff --git a/attr.c b/attr.c
> index 863fad3bd1..98e4953f6e 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -708,10 +708,8 @@ static struct attr_stack *read_attr_from_array(const=
 char **list)
>   * another thread could potentially be calling into the attribute system=
.
>   */
>  static enum git_attr_direction direction;
> -static const struct index_state *use_index;
>
> -void git_attr_set_direction(enum git_attr_direction new_direction,
> -                           const struct index_state *istate)
> +void git_attr_set_direction(enum git_attr_direction new_direction)
>  {
>         if (is_bare_repository() && new_direction !=3D GIT_ATTR_INDEX)
>                 BUG("non-INDEX attr direction in a bare repo");
> @@ -720,7 +718,6 @@ void git_attr_set_direction(enum git_attr_direction n=
ew_direction,
>                 drop_all_attr_stacks();
>
>         direction =3D new_direction;
> -       use_index =3D istate;
>  }
>
>  static struct attr_stack *read_attr_from_file(const char *path, int macr=
o_ok)
> @@ -750,17 +747,11 @@ static struct attr_stack *read_attr_from_index(cons=
t struct index_state *istate,
>         struct attr_stack *res;
>         char *buf, *sp;
>         int lineno =3D 0;
> -       const struct index_state *to_read_from;
>
> -       /*
> -        * Temporary workaround for c24f3abace (apply: file commited
> -        * with CRLF should roundtrip diff and apply - 2017-08-19)
> -        */
> -       to_read_from =3D use_index ? use_index : istate;
> -       if (!to_read_from)
> +       if (!istate)
>                 return NULL;
>
> -       buf =3D read_blob_data_from_index(to_read_from, path, NULL);
> +       buf =3D read_blob_data_from_index(istate, path, NULL);

This code is much clearer and easier to reason about than stashing off
use_index.  I had to dig for a bit through history to try to
understand the old code and why it was written that way, but the new
code just makes sense.
