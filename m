Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CC79D1
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEr6fow7"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbd029beef4so7085540276.0
        for <git@vger.kernel.org>; Sun, 14 Jan 2024 13:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705267624; x=1705872424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpgtyts/MJXE8Ll349aPE8E5sj6NTD+GhVAR9kV9ZcQ=;
        b=JEr6fow7ZtJPRRxRLD/fMB7+KvMBmy09gvCY7jOXALAj2YOHQ+sk6VujA0GBzM1OlW
         4Jspu2yZX4UL1VsMLhuZmGvnTfgFFQM3x4crSd54reeIwlRi9yag3udcyVDOYXEPBYu6
         WOh/O8DsHe35sf8ttjunBzoTcKmESmVFYCPIXoIY7k8Hy7W20x16L9XgtJUTWyfEAzDB
         yIZ/ueHOc71xcTTzPS4aAz9VjkfdG65Ckjxtfp5WgevUYT3vr+tKcKi+3KuHfgQuVZcS
         7kq3F8OzvqfhnZnQecm8DGFlIbGLDtxLlVTIeE4RN2ou3A75TfBQwYt5nwyBKmhzMopr
         HI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705267624; x=1705872424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpgtyts/MJXE8Ll349aPE8E5sj6NTD+GhVAR9kV9ZcQ=;
        b=j2RYrwkFAvbL7cPVcxw4PgPo3eqAERk8gr23NOR7ShctDWzV7flq3caEGB5pcIx93q
         GAb3K8BWTKUD7hrahHeLfHRpDCqlvPn01gyk3QTX51u9mSmPcLtdBkwN67VhfLdOcOWq
         j+oVECsz3YFW+AG4cu1qs6noD98B2ET3Q04beumdGODqiuAjlS/Fg3RNxrhVJIo1NQ7U
         vJtZFqLZkT8LeGlTNJQZJjeF+xvgJ28IyWQ9A6L/88+0aGWzizYwi0ZkucFbdSLMbp8H
         zmJi71jaNz089u8syKBA/iTgVWiweaVQ2CwZ24iebZQq8kfIhBQXP+zKii8ivOQVncKT
         6Pfg==
X-Gm-Message-State: AOJu0YyeIU3S9tSYjDE5sEi4000y/JKkA+swmTxdGoRpeVmrKJANcC06
	IAZsHhvvDiSF5mtSW4FiC8SN1HxJrq9+pzQ2l/w=
X-Google-Smtp-Source: AGHT+IHXG1VjwrW8FXOisLH8kh2mCiVvXDdJv39P/I+Dy2InvWCYiF2BfPMlH1E1YnLp8DfO+etqNx2P/l+PlvlW2bc=
X-Received: by 2002:a25:ab63:0:b0:dbf:2213:5bf8 with SMTP id
 u90-20020a25ab63000000b00dbf22135bf8mr2606632ybi.18.1705267624596; Sun, 14
 Jan 2024 13:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1644.git.git.1705231010118.gitgitgadget@gmail.com>
 <24b82309-34e9-49a0-983b-7e94dad3d06b@gmail.com> <CAFX5hXTCPt-rDrWZ-RN8S84o_FooY3Ck2H1kMYdHQGzuetPBSw@mail.gmail.com>
In-Reply-To: <CAFX5hXTCPt-rDrWZ-RN8S84o_FooY3Ck2H1kMYdHQGzuetPBSw@mail.gmail.com>
From: Nikolay Edigaryev <edigaryev@gmail.com>
Date: Mon, 15 Jan 2024 01:26:53 +0400
Message-ID: <CAFX5hXQ291gR4831dtRTdvtffWefCNCFp13ADvOkU7s3SVPczQ@mail.gmail.com>
Subject: Re: [PATCH] clone: support cloning of filtered bundles
To: phillip.wood@dunelm.org.uk
Cc: Nikolay Edigaryev via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Note that currently, when you clone a normal non-filtered bundle with a
> '--filter' argument specified, no filtering will take place and no error
> will be thrown. "promisor =3D true" and "partialclonefilter =3D ..." opti=
ons
> will be set in the repo config, but no .promisor file will be created.
> This is even more confusing IMO, but that's how it currently on
> Git 2.43.0.

I was wrong about this one: the .promisor pack file actually gets created.

And the filtering is not being done because the "uploadpack.allowFilter"
global option is not enabled by default.

Unfortunately the only way to figure this out is to run Git with
GIT_TRACE=3D2, which shows:

warning: filtering not recognized by server, ignoring

So please feel free to skip this part from the consideration.


On Sun, Jan 14, 2024 at 11:39=E2=80=AFPM Nikolay Edigaryev <edigaryev@gmail=
.com> wrote:
>
> Hello Phillip,
>
> > As I understand it if you're cloning from a bundle file then then there
> > is no remote so how can we set a remote-specific config?
>
> There is a remote, for more details see df61c88979 (clone: also
> configure url for bare clones, 2010-03-29), which has the following
> code:
>
> strbuf_addf(&key, "remote.%s.url", remote_name);
> git_config_set(key.buf, repo);
> strbuf_reset(&key);
>
> You can verify this by creating a bundle on Git 2.43.0 with "git create
> bundle bundle.bundle --all" and then cloning it with "git clone
> --bare /path/to/bundle.bundle", in my case the following repo-wide
> configuration file was created:
>
> [core]
> repositoryformatversion =3D 0
> filemode =3D true
> bare =3D true
> ignorecase =3D true
> precomposeunicode =3D true
> [remote "origin"]
> url =3D /Users/edi/src/cirrus-cli/cli.bundle
>
> > I'm surprised that the proposed change does not require the user to pas=
s
> > "--filter" to "git clone" as I expected that we'd want to check that th=
e
> > filter on the command line was compatible with the filter used to creat=
e
> > the bundle. Allowing "git clone" to create a partial clone without the
> > user asking for it by passing the "--filter" option feels like is going
> > to end up confusing users.
>
> Note that currently, when you clone a normal non-filtered bundle with a
> '--filter' argument specified, no filtering will take place and no error
> will be thrown. "promisor =3D true" and "partialclonefilter =3D ..." opti=
ons
> will be set in the repo config, but no .promisor file will be created.
> This is even more confusing IMO, but that's how it currently on
> Git 2.43.0.
>
> You have a good point, but I feel like completely preventing cloning of
> filtered bundles and requiring a '--filter' argument is very taxing. If
> you've already specified a '--filter' when creating a bundle (and thus
> your intent to use partially cloned data), why do it multiple times?
>
> What I propose as an alternative here is to act based on the user's
> intent when cloning:
>
> * when the user specifies no '--filter' argument, do nothing special,
>    allow cloning both types of bundles: normal and filtered (with the
>    logic from this patch)
>
> * when the user does specify a '--filter' argument, either:
>   * throw an error explaining that filtering of filtered bundles is not
>     supported
>   * or compare the user's filter specification and the one that is
>     in the bundle and only throw an error if they mismatch
>
> Let me know what you think about this (and perhaps you have a more
> concrete example in mind where this will have negative consequences)
> and I'll be happy to do a next iteration.
>
>
> On Sun, Jan 14, 2024 at 10:00=E2=80=AFPM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
> >
> > Hi Nikolay
> >
> > On 14/01/2024 11:16, Nikolay Edigaryev via GitGitGadget wrote:
> > > From: Nikolay Edigaryev <edigaryev@gmail.com>
> > >
> > > f18b512bbb (bundle: create filtered bundles, 2022-03-09) introduced a=
n
> > > incredibly useful ability to create filtered bundles, which advances
> > > the partial clone/promisor support in Git and allows for archiving
> > > large repositories to object storages like S3 in bundles that are:
> > >
> > > * easy to manage
> > >    * bundle is just a single file, it's easier to guarantee atomic
> > >      replacements in object storages like S3 and they are faster to
> > >      fetch than a bare repository since there's only a single GET
> > >      request involved
> > > * incredibly tiny
> > >    * no indexes (which may be more than 10 MB for some repositories)
> > >      and other fluff, compared to cloning a bare repository
> > >    * bundle can be filtered to only contain the tips of refs neccessa=
ry
> > >      for e.g. code-analysis purposes
> > >
> > > However, in 86fdd94d72 (clone: fail gracefully when cloning filtered
> > > bundle, 2022-03-09) the cloning of such bundles was disabled, with a
> > > note that this behavior is not desired, and it the long-term this
> > > should be possible.
> > >
> > > The commit above states that it's not possible to have this at the
> > > moment due to lack of remote and a repository-global config that
> > > specifies an object filter, yet it's unclear why a remote-specific
> > > config can't be used instead, which is what this change does.
> >
> > As I understand it if you're cloning from a bundle file then then there
> > is no remote so how can we set a remote-specific config?
> >
> > I'm surprised that the proposed change does not require the user to pas=
s
> > "--filter" to "git clone" as I expected that we'd want to check that th=
e
> > filter on the command line was compatible with the filter used to creat=
e
> > the bundle. Allowing "git clone" to create a partial clone without the
> > user asking for it by passing the "--filter" option feels like is going
> > to end up confusing users.
> >
> > > +test_expect_success 'cloning from filtered bundle works' '
> > > +     git bundle create partial.bdl --all --filter=3Dblob:none &&
> > > +     git clone --bare partial.bdl partial 2>err
> >
> > The redirection hides any error message which will make debugging test
> > failures harder. It would be nice to see this test check any config set
> > when cloning and that git commands can run successfully in the reposito=
ry.
> >
> > Best Wishes
> >
> > Phillip
