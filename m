Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 178F11F428
	for <e@80x24.org>; Mon, 10 Sep 2018 18:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeIJXaz (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 19:30:55 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45458 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeIJXaz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 19:30:55 -0400
Received: by mail-yb1-f194.google.com with SMTP id h22-v6so8326836ybg.12
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JTftMTv7T/3AzzGqH1M15fSLN7sUOelZTlWgK4bUzes=;
        b=Kpa0E71CAS+9nZX7P4Kyn2jqcH8MfKAl7U+tYTZxbAa0y/Y3n3kOUYq9nqpMTrEl6C
         CV17lDVKItOM6zWXFisIOAkQKnIojofWr/8H0EgSN2RYwqL6OxTO/8IJ2LAb1wwnO4x3
         4aQ9oqJ4PUdqUTLg0+b3YmSe8cB9VkEu4t/KV2TvxSAYP/93DU8lTS9SIqxPY9wrsgab
         O6XaO1T+0kBAXwNHVMB+iI0rrEHOCwe4aQmDhPYQ4lvoZa7VJDbt9BzVdPVh+0wEdgl1
         JRHOC9J9yFMKyuuFeGKiJmSlhj/Mwf452NFYkt4bVtb70pAUi1FrHIxsGmNDmT4PCyXv
         5iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JTftMTv7T/3AzzGqH1M15fSLN7sUOelZTlWgK4bUzes=;
        b=tT1P+PSxyX9kYRRWthJM44DfQlVH8FiRnahSRpSNfpRNL0dzZO/OIL2PRIfu1xxgyI
         vZBVel5GI5ICA/qmu2UoPVjBrK5E+NORe6vgLOaCz0Aw0rQZw040ODfE8lAhcv7YGUJg
         DuT7eZRIx6gW9+6d+/fkQMjGX+CWLOKTmNaJpFvcd2zjqHaDomzdzoQVgC2NxNp4YdPN
         lEY91lypyMOeRxwfCO4gGV04H1znhi/etF2oA0SxgAXo9FnO1kmRdlN1j35vi5xcv5RL
         q2zncyzq2U730IWmor0//thevf3Z+RTlMgkdvd4p2OVfinf+2R7zJWDtwwSkiqMFBwas
         jFCw==
X-Gm-Message-State: APzg51D/94DqBNbl2zmcg5csb6woF4GwqcmShfp5IwTA+8pN1v3Q4e5G
        Pf1K1tgzRzheUf/Jv2zPEoEI6NzsvCPAS7+ppgiDTQ==
X-Google-Smtp-Source: ANB0VdaW5ZuGJ8NQMloj28q3lQSvDopN0kmeBgTXsMBYZslsICuayGEZGmOYYfSNHbFvc1g6IxwvxLuj1D5zMc91EqY=
X-Received: by 2002:a25:41c3:: with SMTP id o186-v6mr10460425yba.493.1536604530935;
 Mon, 10 Sep 2018 11:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180903180932.32260-1-pclouds@gmail.com> <20180909085418.31531-1-pclouds@gmail.com>
In-Reply-To: <20180909085418.31531-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Sep 2018 11:35:19 -0700
Message-ID: <CAGZ79kYiD5kRP5WaqYpxFBnXdP=c4bK3cumH=OBC6_ud0o1OnA@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] Kill the_index part 4
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 9, 2018 at 1:54 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <p=
clouds@gmail.com> wrote:
>
> The last patch 24/24 has been merged into individual patches to add
> repo_ prefix and avoid breaking in-flight topics. "repo" argument is
> also moved up in rerere(), diff_setup() and init_revisions().

yay!
So eventually we'd want to rename back to short names or
we just postpone that decision if we want that in the future?

> diff --git a/Documentation/technical/api-revision-walking.txt b/Documenta=
tion/technical/api-revision-walking.txt
> index 55b878ade8..83e62533a0 100644
> --- a/Documentation/technical/api-revision-walking.txt
> +++ b/Documentation/technical/api-revision-walking.txt
> @@ -15,7 +15,7 @@ revision list.
>  Functions
>  ---------
>
> -`init_revisions`::
> +`repo_init_revisions`::
>
>         Initialize a rev_info structure with default values. The second
>         parameter may be NULL or can be prefix path, and then the `.prefi=
x`
> diff --git a/bisect.c b/bisect.c
> index 560493acd2..6ae5e5b49e 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -632,7 +632,7 @@ static void bisect_rev_setup(struct rev_info *revs, c=
onst char *prefix,
>         struct argv_array rev_argv =3D ARGV_ARRAY_INIT;
>         int i;
>
> -       repo_init_revisions(revs, the_repository, prefix);
> +       repo_init_revisions(the_repository, revs, prefix);

Apparently I did not communicate clearly enough on the last round,
Please note that the documentation is wrong with these
patches applied:

    `repo_init_revisions`::

         [...] The second
         parameter may be NULL or can be prefix path, and then the `.prefix=
`

but the prefix parameter is the _third_ parameter in either order.
