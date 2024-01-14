Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677B11CA0
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUnBSrvC"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-429d7896d35so10279841cf.3
        for <git@vger.kernel.org>; Sun, 14 Jan 2024 11:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705261191; x=1705865991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTRxtoOwYxLCHv+kGsozGrqy+Qy+CiwkjTX4mc36AQw=;
        b=HUnBSrvCRTV3EMSok57CVsyJBbCbrJK6CMT1Rm7EJEugOneERbu9GNzKHJm/PUTmud
         qKzm3I5N4V+117UWmXldC1GZ5tIad95ompVhxgc+R5d/3GoU6GljLsVwhz/oUddXgBsv
         gjcdPZXedEEIU4zKDiI0jO447xN7yOuLuKFRv+zwMpvL6AghVqv7gJDr4RAtT1r31gBQ
         EHdB+0Y1HMjVbZGg/lf5jyAQtm5Vxy4iFZMKCI6BPsUsFxdDoxP6avA7QCsKSqsQtUmK
         pLlOI+soJiUhkBXIjqHVW6ICMH/eyWOQeNgYyZ6pT+fZqjIcKZr6Pzxr9iTK0N3mGjRF
         HvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705261191; x=1705865991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTRxtoOwYxLCHv+kGsozGrqy+Qy+CiwkjTX4mc36AQw=;
        b=gsh6Qd3hSCFNCirfRglO7UjcIQNf/AL9mN+Ec/9nbv6TYScFtWaybetlx67WN1F9D3
         Dp2hchp1VWwmbgglEMwDVt9Q3EH0OGgVax8UxPK/vxnF0rDcdO46Ay/y6SBWWKjjiCA6
         7eRBSS0dlymCmNuIGbvKwantwDtBgTc9B6p7UDA2NWNPmrBPU/gaj2gToE6OkKqYlytT
         CKhhdhvJgxD2HsgYj3xMoBnE225yNVyj/wjQElXYCSTOsCEHwcuwu2BaGayF25m1VHFo
         7/OhTg63sww4dB++C8noKDSxnm9fbj+ml9bBI/UY/XfSKv2vnWXEFy8vtSA3h+MBGkoJ
         va0A==
X-Gm-Message-State: AOJu0Ywr5xJgj8z64pC+UDw2UJY/IBGJNOlRG1A9Il9XE89/2wrqWTvG
	qOMDVMrKQnSScXsBZS0FifLTSM1M9Z3+LZDPFQE=
X-Google-Smtp-Source: AGHT+IHsXu0NEe6B6diz9m9TihJ6vlnaMNkCnfl5otFvTOl1wExJUr5YR0QxebAH0rF6ElCRdG4u+0xgRH1gzWe2r4k=
X-Received: by 2002:ac8:598e:0:b0:429:d29c:1376 with SMTP id
 e14-20020ac8598e000000b00429d29c1376mr6068533qte.49.1705261191040; Sun, 14
 Jan 2024 11:39:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1644.git.git.1705231010118.gitgitgadget@gmail.com> <24b82309-34e9-49a0-983b-7e94dad3d06b@gmail.com>
In-Reply-To: <24b82309-34e9-49a0-983b-7e94dad3d06b@gmail.com>
From: Nikolay Edigaryev <edigaryev@gmail.com>
Date: Sun, 14 Jan 2024 23:39:40 +0400
Message-ID: <CAFX5hXTCPt-rDrWZ-RN8S84o_FooY3Ck2H1kMYdHQGzuetPBSw@mail.gmail.com>
Subject: Re: [PATCH] clone: support cloning of filtered bundles
To: phillip.wood@dunelm.org.uk
Cc: Nikolay Edigaryev via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Phillip,

> As I understand it if you're cloning from a bundle file then then there
> is no remote so how can we set a remote-specific config?

There is a remote, for more details see df61c88979 (clone: also
configure url for bare clones, 2010-03-29), which has the following
code:

strbuf_addf(&key, "remote.%s.url", remote_name);
git_config_set(key.buf, repo);
strbuf_reset(&key);

You can verify this by creating a bundle on Git 2.43.0 with "git create
bundle bundle.bundle --all" and then cloning it with "git clone
--bare /path/to/bundle.bundle", in my case the following repo-wide
configuration file was created:

[core]
repositoryformatversion =3D 0
filemode =3D true
bare =3D true
ignorecase =3D true
precomposeunicode =3D true
[remote "origin"]
url =3D /Users/edi/src/cirrus-cli/cli.bundle

> I'm surprised that the proposed change does not require the user to pass
> "--filter" to "git clone" as I expected that we'd want to check that the
> filter on the command line was compatible with the filter used to create
> the bundle. Allowing "git clone" to create a partial clone without the
> user asking for it by passing the "--filter" option feels like is going
> to end up confusing users.

Note that currently, when you clone a normal non-filtered bundle with a
'--filter' argument specified, no filtering will take place and no error
will be thrown. "promisor =3D true" and "partialclonefilter =3D ..." option=
s
will be set in the repo config, but no .promisor file will be created.
This is even more confusing IMO, but that's how it currently on
Git 2.43.0.

You have a good point, but I feel like completely preventing cloning of
filtered bundles and requiring a '--filter' argument is very taxing. If
you've already specified a '--filter' when creating a bundle (and thus
your intent to use partially cloned data), why do it multiple times?

What I propose as an alternative here is to act based on the user's
intent when cloning:

* when the user specifies no '--filter' argument, do nothing special,
   allow cloning both types of bundles: normal and filtered (with the
   logic from this patch)

* when the user does specify a '--filter' argument, either:
  * throw an error explaining that filtering of filtered bundles is not
    supported
  * or compare the user's filter specification and the one that is
    in the bundle and only throw an error if they mismatch

Let me know what you think about this (and perhaps you have a more
concrete example in mind where this will have negative consequences)
and I'll be happy to do a next iteration.


On Sun, Jan 14, 2024 at 10:00=E2=80=AFPM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Nikolay
>
> On 14/01/2024 11:16, Nikolay Edigaryev via GitGitGadget wrote:
> > From: Nikolay Edigaryev <edigaryev@gmail.com>
> >
> > f18b512bbb (bundle: create filtered bundles, 2022-03-09) introduced an
> > incredibly useful ability to create filtered bundles, which advances
> > the partial clone/promisor support in Git and allows for archiving
> > large repositories to object storages like S3 in bundles that are:
> >
> > * easy to manage
> >    * bundle is just a single file, it's easier to guarantee atomic
> >      replacements in object storages like S3 and they are faster to
> >      fetch than a bare repository since there's only a single GET
> >      request involved
> > * incredibly tiny
> >    * no indexes (which may be more than 10 MB for some repositories)
> >      and other fluff, compared to cloning a bare repository
> >    * bundle can be filtered to only contain the tips of refs neccessary
> >      for e.g. code-analysis purposes
> >
> > However, in 86fdd94d72 (clone: fail gracefully when cloning filtered
> > bundle, 2022-03-09) the cloning of such bundles was disabled, with a
> > note that this behavior is not desired, and it the long-term this
> > should be possible.
> >
> > The commit above states that it's not possible to have this at the
> > moment due to lack of remote and a repository-global config that
> > specifies an object filter, yet it's unclear why a remote-specific
> > config can't be used instead, which is what this change does.
>
> As I understand it if you're cloning from a bundle file then then there
> is no remote so how can we set a remote-specific config?
>
> I'm surprised that the proposed change does not require the user to pass
> "--filter" to "git clone" as I expected that we'd want to check that the
> filter on the command line was compatible with the filter used to create
> the bundle. Allowing "git clone" to create a partial clone without the
> user asking for it by passing the "--filter" option feels like is going
> to end up confusing users.
>
> > +test_expect_success 'cloning from filtered bundle works' '
> > +     git bundle create partial.bdl --all --filter=3Dblob:none &&
> > +     git clone --bare partial.bdl partial 2>err
>
> The redirection hides any error message which will make debugging test
> failures harder. It would be nice to see this test check any config set
> when cloning and that git commands can run successfully in the repository=
.
>
> Best Wishes
>
> Phillip
