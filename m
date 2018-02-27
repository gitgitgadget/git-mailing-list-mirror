Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1BA1F576
	for <e@80x24.org>; Tue, 27 Feb 2018 10:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeB0KKK (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 05:10:10 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33770 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbeB0KKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 05:10:09 -0500
Received: by mail-qk0-f195.google.com with SMTP id f25so22792259qkm.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 02:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=lL5khgaCrgJJcADQWgMT+m904K2TOFHWfNV/DaPaUDA=;
        b=NOBS8FnDEcYhY1JjbV5QMJSV1OWiSzlujjrMOmX1+JmF5JMmwoL5XLCJ/UGKlWXVUd
         Mdf6JX8McGUnS3UL0h6ogUDc06/vKsp8Hpd73Euc6v4nixUvzzgzvWhndCeXJ/ctQg0Q
         m9EghUGV4PAuzkkLl2F0ZJvNJ7NJzHFw15yJtb9rssekk7PwjET/eZuUUdRaCp3laEHZ
         IaDw36OWoyHlSM5NZg/dXkQ44SA4H9tC0Yw/AFWmjsCg735w05d9Gj/El8JmtUn/qi0D
         qyXekhYOTbV3tODqemIHauSoLajXe6tvAwsEMtoyZ8uMyvHiKhVnVtcWuP1QYbpp12YY
         q3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=lL5khgaCrgJJcADQWgMT+m904K2TOFHWfNV/DaPaUDA=;
        b=FokMpfuzsOFIY/XHMtNYZ14GptFuK3XUS8AqkJ7JtaiTp3SOHPhg5vv+7PK5SudJM9
         tbrzO4d1isPUu5hQY7Q70JiIMfpMYM847YI3ElU70AFruSQI3FccQXQmL+YG9/Sk9iyl
         Woh9eIkhpT3xaxXXm1IelGpXrSB0BVgYo3OKsR9J9c8x/XFVn1YagvLE37HcT3J/uP/2
         jJep7Lzdvyq2uinfXC8fAVGlvZs+GWCm0s8eT2Ol0Y+KiSwFLyUP8lBQvj1UJ0gp9heP
         vUC+EC+1vuVcdwT15DnXKS5vFx6/j+/kGFxWoKdaWeVpV4VWjOCkAmE1gMrcipXe1jnJ
         GA0A==
X-Gm-Message-State: APf1xPBtQ59wUKaKweFr/hLdYfoZfjboc1LO+A+1SI8x0QNYKylvJ2XE
        EHr3P8x/jcsW4Xu6q1q0nXSEM71NiuS3XlBRXqA=
X-Google-Smtp-Source: AG47ELtuisaO5Ie18NYn6psPLxeAXphEdgcGbY58J3gx06v8v6rU3WfIlNImySAU63PajMH78pxBz94AfQW+vjPaYLI=
X-Received: by 10.55.13.206 with SMTP id 197mr22347866qkn.115.1519726208813;
 Tue, 27 Feb 2018 02:10:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Tue, 27 Feb 2018 02:10:08 -0800 (PST)
In-Reply-To: <20180227095846.9238-1-pclouds@gmail.com>
References: <20180226103030.26900-1-pclouds@gmail.com> <20180227095846.9238-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 27 Feb 2018 05:10:08 -0500
X-Google-Sender-Auth: 7tFGCWN7RikiI0pmNaZzQ4KnYwo
Message-ID: <CAPig+cQPz+fr4fCUvLk55xZeEqHr+Y_wST2y9CtyXZohxNV+cA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Delete ignore_env member in struct repository
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 4:58 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> v2 fixes the incorrect use of consecutive getenv() and adds a comment
> to clarify the role of old_gitdir
>
> diff --git a/environment.c b/environment.c
> @@ -148,18 +149,34 @@ static char *expand_namespace(const char *raw_names=
pace)
> +/* Wrapper of getenv() that returns a strdup value. This value is kept
> + * in argv to be freed later.
> + */

    /*
     * Comment style.
     */

> +static const char *getenv_safe(struct argv_array *argv, const char *name=
)
> +{
> +       const char *value =3D getenv(name);
> +
> +       if (!value)
> +               return NULL;
> +
> +       argv_array_push(argv, value);
> +       return argv->argv[argv->argc - 1];
> +}
> +
>  void setup_git_env(const char *git_dir)
>  {
>         const char *shallow_file;
>         const char *replace_ref_base;
>         struct set_gitdir_args args =3D { NULL };
> +       struct argv_array to_free =3D ARGV_ARRAY_INIT;

Cute. Another example[1] showing that renaming argv_array to something
else might be a good idea.

[1]: https://public-inbox.org/git/20180227062128.GG65699@aiede.svl.corp.goo=
gle.com/

> -       args.shared_root =3D getenv(GIT_COMMON_DIR_ENVIRONMENT);
> -       args.object_dir =3D getenv(DB_ENVIRONMENT);
> -       args.graft_file =3D getenv(GRAFT_ENVIRONMENT);
> -       args.index_file =3D getenv(INDEX_ENVIRONMENT);
> -       args.alternate_db =3D getenv(ALTERNATE_DB_ENVIRONMENT);
> +       args.shared_root =3D getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRON=
MENT);
> +       args.object_dir =3D getenv_safe(&to_free, DB_ENVIRONMENT);
> +       args.graft_file =3D getenv_safe(&to_free, GRAFT_ENVIRONMENT);
> +       args.index_file =3D getenv_safe(&to_free, INDEX_ENVIRONMENT);
> +       args.alternate_db =3D getenv_safe(&to_free, ALTERNATE_DB_ENVIRONM=
ENT);
>         repo_set_gitdir(the_repository, git_dir, &args);
> +       argv_array_clear(&to_free);
> diff --git a/repository.c b/repository.c
> @@ -48,6 +48,11 @@ void repo_set_gitdir(struct repository *repo,
>         const char *gitfile =3D read_gitfile(root);
> +       /*
> +        * repo->gitdir is saved because the caller could pass "root"
> +        * that also points to repo->gitdir. We want to keep it alive
> +        * until after xstrdup(root). Then we can free it.
> +        */
>         char *old_gitdir =3D repo->gitdir;

Good. This comment makes the reasoning clear.

>         repo->gitdir =3D xstrdup(gitfile ? gitfile : root);
