Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A41DFD5
	for <git@vger.kernel.org>; Fri,  5 Jan 2024 02:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyo9Orff"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e7b51b0ceso147130e87.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 18:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704420747; x=1705025547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzEviuUKDNvIfeocDz7ptE8DAv8kMzjvzcg88myAcL8=;
        b=Uyo9Orffk2Pdz9PJ53dzoQdGd8S5+UNUbryZtxfcki5LnQWhwvkUES+4S4pbaM/SBu
         g6kqmesquNU1OJ1/rtcjkQx2qtW6eMOB4GWiqZWLNpuO/tdq/9YCA3J/4dIs/juufVM6
         xg+0gp2Ag4fyU2xuvFBm54INwUP07TrMXzabWOWnmWEQHsDWqtb7WFBgCXIobRrvY5EG
         dFsv0zsdlmVfJzW1ZE/A02FfhnHrshxUkI0AZfS60PqIreCprxzgj+moSHNPiku3JYVM
         ukRTMJi+QvmjmeLFMncy49HDr4TOd4fi9aQ9sO328lU1CynElmycXxbGcCWe8nV9okTL
         B8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704420747; x=1705025547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzEviuUKDNvIfeocDz7ptE8DAv8kMzjvzcg88myAcL8=;
        b=MGUPjxiloTZWMVWgCfx3XEk52P48GNZgAYkv2amuRLSQKKzGUe/vRxIZe003ZsyoJi
         PD8sbb8bLx6zgtodIs5MJsBBo7KHRwv1/PcR2laXLxtA+v8vktQeGqhBi3NiAxyarYpO
         AOKZsVJmJAtwhS4cpMSoMHLgHFkkWFPX5QLq1kCo3c6FCmK+jS11NyInrrO92lAGd4Cw
         4XDn0i6meMSZqYmvJEHhppg8lNJP0CyrO/LKhVCFLIKylM8xhuWHacHoweFHpGT5dAeQ
         nEXjrEK+qnOvoTzdN3ArPWpHq2PrmEn/8XNFXP2fhuzDmzJxYPDv341X2bnwauiKSLCI
         65ew==
X-Gm-Message-State: AOJu0Yy4BjIOxMhxcS0cKcsCl7BvNV7VqSjmEkZbKfApiXcfmziPSrPM
	yFCqwnYGIkbYx6zgkZ+yU+5bbh4jOpmxHg7zdsdhKC01PRM=
X-Google-Smtp-Source: AGHT+IFM3EaGdfcwIRB8y+sG8DeAqLGrSIuq6/N54nVbpBJBpmzty9rYkyJ5WX05xfVanqlymNw+Od/EJXr4xfxqAn8=
X-Received: by 2002:ac2:4317:0:b0:50e:3879:8222 with SMTP id
 l23-20020ac24317000000b0050e38798222mr827702lfh.21.1704420746595; Thu, 04 Jan
 2024 18:12:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85d4e83c-b6c4-4308-ac8c-a65c911c8a95@gmail.com> <CAP8UFD1wMJMY6G4SaPTPwq6b9HbeXG1kB97-RRrL-KGN1wE0rg@mail.gmail.com>
In-Reply-To: <CAP8UFD1wMJMY6G4SaPTPwq6b9HbeXG1kB97-RRrL-KGN1wE0rg@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 4 Jan 2024 18:11:00 -0800
Message-ID: <CABPp-BH+cPdfsctquE60tw_nD6_LCaWf0JwGusuZ0tvQQuWy4w@mail.gmail.com>
Subject: Re: [GSOC][RFC] Heed core.bare from template config file when no
 command line override given, as a microproject.
To: Christian Couder <christian.couder@gmail.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org, gitster@pobox.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 2:24=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Tue, Jan 2, 2024 at 11:17=E2=80=AFPM Ghanshyam Thakkar
> <shyamthakkar001@gmail.com> wrote:
> >
> > Hello,
> >
> > I'm currently an undergrad beginning my journey of contributing to the
> > Git project. I am seeking feedback on doing "Heed core.bare from
> > template config file when no command line override given" described
> > here
> > https://lore.kernel.org/git/5b39c530f2a0edf3b1492fa13a1132d622a0678e.16=
84218850.git.gitgitgadget@gmail.com/
> > by Elijah Newren, as a microproject. I would like to know from the
> > community, if the complexity and scope of the project is appropriate
> > for a microproject.
>
> Thanks for your interest in the next GSoC!
>
> My opinion is that it's too complex for a micro-project. Now maybe if
> Elijah or others are willing to help you on it, perhaps it will work
> out. I think it's safer to look at simpler micro-projects though.

An important part of solving this problem, if you were to do so, would
be adding several testcases (including some showing how it currently
fails).  Simply adding some or all of those testcases would be a good
micro-project.  (If you take this on, it'd probably be worthwhile to
include a reference to any such added tests in the TODO comment here
so that future folks noticing the TODO are aware of them).  Then, if
adding those testcases goes well and you feel ambitious, you can try
to tackle the underlying problem too.

> > e.g. in builtin/init-db.c :
> >
> > static int template_bare_config(const char *var, const char *value,
> >                      const struct config_context *ctx, void *cb)
> > {
> >        if(!strcmp(var,"core.bare")) {
>
> We like to have a space character between "if" and "(" as well as after a=
 ","
>
> >              is_bare_repository_cfg =3D git_config_bool(var, value);
> >        }
> >        return 0;
> > }
> >
> > int cmd_init_db(int argc, const char **argv, const char *prefix)
> > {
> > ...
> > ...
> >        if(is_bare_repository_cfg=3D=3D-1) {
>
> We like to have a space character both before and after "=3D=3D" as well
> as between "if" and "(".
>
> >              if(!template_dir)
> >                    git_config_get_pathname("init.templateDir",
> >                                            &template_dir);
> >
> >              if(template_dir) {
> >                    const char* template_config_path
> >                                 =3D xstrfmt("%s/config",
> >                    struct stat st;
> >
> >                    if(!stat(template_config_path, &st) &&
> >                      !S_ISDIR(st.st_mode)) {
> >                          git_config_from_file(template_bare_cfg,
> >                                         template_config_path, NULL);
> >                    }
> >              }
> > ...
> > ...
> >        return init_db(git_dir, real_git_dir, template_dir, hash_algo,
> >                       initial_branch, init_shared_repository, flags);
> > }
> >
> > I also wanted to know if the global config files should have an effect
> > in deciding if the repo is bare or not.
> >
> > Curious to know your thoughts on, if this is the right approach or
> > does it require doing refactoring to bring all the logic in setup.c.
> > Based on your feedback, I can quickly send a patch.
>
> I don't know this area of the code well, so I don't think I can help
> you much on this.

If you look back at the mailing list discussion on the series that
introduced this TODO comment you are trying to address, you'll note
that both Glen and I dug into the code and attempted to explain it to
each other, and we both got it wrong on our first try.   If I knew the
correct solution without digging, I probably would have just
implemented it and sent it in as another patch series.  My TODO was
not meant to be a definitive guide about where to make the fixes
(because I don't know yet), but just a helpful guide that the first
spot you'd expect cannot be the correct location (I already tried a
few things there) and that you need to dig further.  Anyway, I'm sure
the correct place to fix can be figured out with a bit of work, but in
this case, figuring out where the changes need to be made is probably
the majority of the effort.

You may well need to just pick an area, start modifying, go through it
in a debugger and with your testcases, etc., and learn whether
modifications in that area even can solve the problem.  You may have
to discard your first or even second attempts, but take what you
learned to guide you on future attempts.

And if you do get it all working, this is a case where it'd likely be
important to comment in the commit message not just why you are making
changes, but why you believe the area you modified is the correct one
(i.e. to mention why the more obvious places to modify don't actually
solve the problem).  And then be prepared for folks on the mailing
list to use the information you provided in the commit message to dive
in and point out some other way to fix the problem that is even better
but requires you to redo it again.  (And I'm not just saying that
because you're new; I would not be surprised if the same happened to
me.  Others are more familiar with various parts of the general setup
and config code than me, and sometimes additional expertise coupled
with a solution of some sort can make it easier to identify an even
better solution.)
