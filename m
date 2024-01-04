Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699E820DC7
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msiQZfQr"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a27e323fdd3so34346866b.2
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 02:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704363854; x=1704968654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mCwDxgJKtXBa7K8QlQy28q8wgnTH6nV6XmIZflx4Ag=;
        b=msiQZfQrzL5TKaDwY/frDu3iq6+PyJXgIgQu+OtmxmD2EOhpOSpTiXJN8iORH5iQlr
         s2pGiQ+jVNIXlWaMJHU6dLx+mNYtALvj/cmQZCoP722fKgbzAsgL674jtiTsoajZUl+K
         7c8QXiJutcLtHPgT8XMjLQBLdmPBhFAv8ZP8sKhLW18v5xUEgV4nht709lPadbENus9D
         9grPmdkEBmhVdLi5MTUPvQsdniEaoVZ3N1L8Oly7JgWqIEWNIPAlcLvuFd763+7VLc3Q
         O9Q1I5NDPkIuALhypsG2JK150ajdoVXPlB3KwLS6Z+kwaHDaUP47hRNNKsb3V3HYxgnL
         8Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704363854; x=1704968654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mCwDxgJKtXBa7K8QlQy28q8wgnTH6nV6XmIZflx4Ag=;
        b=dk7RPS4o+c4cOtPH/TUMKkyGGOZwG0PXPSdIlbrYRe9zEldl61VSS8/g9XUh5pmTjH
         3THTv6ldYkomhBG9dHwI5LVr18SiqYZo6HYU4dYr7gmCttz40te/kQ4RaoTsm62PEU4R
         J6nqP0tVNw+GOknT1btB0nCYm10LRIJsloeDraML+P6TsIqDMt3XUx0iXJiPFujen7iE
         NpqObmQRbk5Ww38yx6IavJR8Kjk27dWFYN5+bZoeGNQZQZ/dW5ePvCjDMVGnT6z5eXfx
         kYfy5htwenf/zgQxeLS5LeAa8oA10VWJHCxAZDcSRpWE4VnFBLrs97l2D5TD5cx6VxGs
         v1gQ==
X-Gm-Message-State: AOJu0YykSe8ysXDupNvuPW4hulV+q3xXfstyelktwgTAHvv+es9DyGFQ
	Tfg0UN79/6FzmUevvSG4PIX3dq9dZBDK7z2+knQ=
X-Google-Smtp-Source: AGHT+IGuSwZ3Hxt8H/fuzKJjnENrvASZ+MImzAOcKOlbyoV25D8LTh5YE2gdeJLgMy1hSf6Uq5hZwNsM1nsJvEvKqEU=
X-Received: by 2002:a17:906:264c:b0:a28:bf47:27a3 with SMTP id
 i12-20020a170906264c00b00a28bf4727a3mr212459ejc.138.1704363853310; Thu, 04
 Jan 2024 02:24:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85d4e83c-b6c4-4308-ac8c-a65c911c8a95@gmail.com>
In-Reply-To: <85d4e83c-b6c4-4308-ac8c-a65c911c8a95@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 4 Jan 2024 11:24:01 +0100
Message-ID: <CAP8UFD1wMJMY6G4SaPTPwq6b9HbeXG1kB97-RRrL-KGN1wE0rg@mail.gmail.com>
Subject: Re: [GSOC][RFC] Heed core.bare from template config file when no
 command line override given, as a microproject.
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, newren@gmail.com, gitster@pobox.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:17=E2=80=AFPM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> Hello,
>
> I'm currently an undergrad beginning my journey of contributing to the
> Git project. I am seeking feedback on doing "Heed core.bare from
> template config file when no command line override given" described
> here
> https://lore.kernel.org/git/5b39c530f2a0edf3b1492fa13a1132d622a0678e.1684=
218850.git.gitgitgadget@gmail.com/
> by Elijah Newren, as a microproject. I would like to know from the
> community, if the complexity and scope of the project is appropriate
> for a microproject.

Thanks for your interest in the next GSoC!

My opinion is that it's too complex for a micro-project. Now maybe if
Elijah or others are willing to help you on it, perhaps it will work
out. I think it's safer to look at simpler micro-projects though.

> e.g. in builtin/init-db.c :
>
> static int template_bare_config(const char *var, const char *value,
>                      const struct config_context *ctx, void *cb)
> {
>        if(!strcmp(var,"core.bare")) {

We like to have a space character between "if" and "(" as well as after a "=
,"

>              is_bare_repository_cfg =3D git_config_bool(var, value);
>        }
>        return 0;
> }
>
> int cmd_init_db(int argc, const char **argv, const char *prefix)
> {
> ...
> ...
>        if(is_bare_repository_cfg=3D=3D-1) {

We like to have a space character both before and after "=3D=3D" as well
as between "if" and "(".

>              if(!template_dir)
>                    git_config_get_pathname("init.templateDir",
>                                            &template_dir);
>
>              if(template_dir) {
>                    const char* template_config_path
>                                 =3D xstrfmt("%s/config",
>                    struct stat st;
>
>                    if(!stat(template_config_path, &st) &&
>                      !S_ISDIR(st.st_mode)) {
>                          git_config_from_file(template_bare_cfg,
>                                         template_config_path, NULL);
>                    }
>              }
> ...
> ...
>        return init_db(git_dir, real_git_dir, template_dir, hash_algo,
>                       initial_branch, init_shared_repository, flags);
> }
>
> I also wanted to know if the global config files should have an effect
> in deciding if the repo is bare or not.
>
> Curious to know your thoughts on, if this is the right approach or
> does it require doing refactoring to bring all the logic in setup.c.
> Based on your feedback, I can quickly send a patch.

I don't know this area of the code well, so I don't think I can help
you much on this.

Best,
Christian.
