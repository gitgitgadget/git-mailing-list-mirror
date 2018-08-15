Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307761F404
	for <e@80x24.org>; Wed, 15 Aug 2018 18:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeHOVuQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 17:50:16 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33747 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeHOVuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 17:50:16 -0400
Received: by mail-yw1-f66.google.com with SMTP id c135-v6so1608088ywa.0
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=begS7BMIX0Xd7DT7iZ7EVBH09yMSV/gqXvIs73kXbdM=;
        b=Ym99Vk1Z60G49o4jDu/xJx5FKs1TX9fOnGtEd+D49w9+9QudZa3E07OIBXtWFZSAZq
         oEKwDitSrEpdOUIFMp639Urr5PKmTPWcMPF8TAghZkpMW+PtGnDYCF/QyS3lR58zf4ju
         521MyE2ZOsuZiiDKciBVMClpwLhr9Ufvbdmp6xPxGHpPxu8FFJ+SQk2Zd8i8GMQScPCt
         cAUwvSt4XXOLNG1yGVcmi+3fCWIBBwXzUbu25Cyrkmav3wJeYTyKmYo1Cob3dYcAeE8R
         KhlYPuc+hHMCQfv2B8MQI9blQS1BjV/2uKg8dcCiM0t9OuqBEM9rff2gyHs01CU1+Edp
         5tPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=begS7BMIX0Xd7DT7iZ7EVBH09yMSV/gqXvIs73kXbdM=;
        b=VRB7vHHXvHRVczXQL5TUPF3DQdnJgbtk4jE3qb/OnWyaYKrNDvtcyIBPYmh0iB4Eq/
         a+lcfPlTfulQVEzvKV6154oWMypq9+eteKEnjwaEGSwUBOxZQD4N3t/3Y0dv9i2HyGcT
         tsK3x//ZyU3WZLJ1SMJPip582jy3I6VS/40253XT5J1I9mu6J/NisR6aIU/gR+A+kv+U
         uoRRNEWg8G1hC6jNH3/FbeaaaSvAzG7ytqVMnPUH4zjvxa4rhNgh2R4F58cNsQhI87Ll
         iw+WY/OKgarw3EXrS6iwpx18dc2qmZ6wuMXPgFtedePFG9mgaTICGkSAapHQQsMcJCVS
         gWXg==
X-Gm-Message-State: AOUpUlGnug0lKTxTddX9mKWzIz+OFKdV5qlJRyD/zRvWpJwqUfotQkTF
        shPwu4kjEsrytJuRPI6HJM2a4SCubAH0xk44yqMvzQ==
X-Google-Smtp-Source: AA+uWPzn8qpwNXJbLysrrwD3AvJb0iK9XMs9ELPsMvQQxANe0seZ6Dr4KNBJek7PK0qaEzk9Ef4uRT2CdGQYMXvT1rk=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr14407846ywh.238.1534359414131;
 Wed, 15 Aug 2018 11:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180813161441.16824-1-pclouds@gmail.com> <20180813161441.16824-8-pclouds@gmail.com>
In-Reply-To: <20180813161441.16824-8-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Aug 2018 11:56:43 -0700
Message-ID: <CAGZ79kZTqcCzRLVTWVzjttU7dd98H2vm3WA9AceXypE-XwM4LA@mail.gmail.com>
Subject: Re: [PATCH 07/24] ls-files: correct index argument to get_convert_attr_ascii()
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 9:15 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> write_eolinfo() does take an istate as function argument and it should
> be used instead of the_index.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/ls-files.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 7233b92794..7f9919a362 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -63,7 +63,7 @@ static void write_eolinfo(const struct index_state *ist=
ate,
>                 struct stat st;
>                 const char *i_txt =3D "";
>                 const char *w_txt =3D "";
> -               const char *a_txt =3D get_convert_attr_ascii(&the_index, =
path);
> +               const char *a_txt =3D get_convert_attr_ascii(istate, path=
);

Going by the commit message this patch should end here?

> -static void show_dir_entry(const char *tag, struct dir_entry *ent)
> +static void show_dir_entry(const struct index_state *istate,
> +                          const char *tag, struct dir_entry *ent)
[...]
> -       if (!dir_path_match(&the_index, ent, &pathspec, len, ps_matched))
> +       if (!dir_path_match(istate, ent, &pathspec, len, ps_matched))
[...]
> -       write_eolinfo(NULL, NULL, ent->name);
> +       write_eolinfo(istate, NULL, ent->name);

but here we need to pass through the istate, which is why we adjust the
dir_path_match while we're here

> -               show_dir_entry(tag_other, ent);
> +               show_dir_entry(istate, tag_other, ent);
[...]
> -                       show_dir_entry(tag_killed, dir->entries[i]);
> +                       show_dir_entry(istate, tag_killed, dir->entries[i=
]);

and having to adjust more callers here

> @@ -228,7 +229,7 @@ static void show_ce(struct repository *repo, struct d=
ir_struct *dir,

> -       } else if (match_pathspec(&the_index, &pathspec, fullname, strlen=
(fullname),
> +       } else if (match_pathspec(repo->index, &pathspec, fullname, strle=
n(fullname),

> @@ -264,7 +265,7 @@ static void show_ru_info(const struct index_state *is=
tate)

> -               if (!match_pathspec(&the_index, &pathspec, path, len,
> +               if (!match_pathspec(istate, &pathspec, path, len,

These seem more or less unrelated to the commit message
or the code changes above. Maybe mention these as a
"while at it" or separate them out in their own commit?

thanks,
Stefan
