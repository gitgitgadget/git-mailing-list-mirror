Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795392667;
	b=eCNRvQC9ikFmUaU26Hu4TOm4V1kJmK+8YPfQ8OEYK09VSsYbx5XLb1DMh7qAyUs3A2s5
	 Jo/2ltW/fZdDCrV2GA1HML0Zk0HC53C07eReDvedYkdE4E6ItjsVyCBuDQPb7QmwnRC+z
	 HJATSkRROCATUAqSHwCfaxHFlszrxanUtO7QVcD0Zbf2LjBvWm7MZxIYTPthmN0930NKH
	 6MPye7VLGURwhA6Z79AHYWnmURZBGR86ifyiBwnikJK3beGo31mwU1c/+2Su5gSr3Qjfe
	 DzgdzI5S/EW5QLn33yO8m0YxQIzA5NJHYWNskEzsj5i5wgOHYt2tBdXuyU0o2EA2w3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795392667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=5I86RWqzyaU23Eu5ohO05WelFgFCrtFVPnKv6K/hbMI=;
	b=sbIM7ZlqMcJFJr/D8FBhQQNG27j/wKzCYexeHcLKUQc3v/b92/WQoXHsuR2SlpaK0g6y
	 xs7Bzp2FwKKhNYCYo6KCbkDENic7ZFZQL37BzcPltaz79T02qz8xv2tw7Jo4+h4ocs34I
	 9/buxsFZuIabUE+NMBpkJLqCCKdlhlbm85zv63FXQ2PObcm0JhRJ71HxTGLa8n4dvNha/
	 IrT6XY1nqTzvPER7y3QM6/kk9Ze5Ei+3ZbpuOEoXW3pNdZ7420LcCqqZ7aqYX36i+rGeZ
	 52/Ygzl8eTpDxXaI3IomrkT2qXNynTpxtNIpY3xUgsVPDJ9pvaF5WMfKr0hXFGBj9rQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zALYqXVs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C1606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 00:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 332C1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zALYqXVs
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f04244c3d0so22765485ad.3
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 16:11:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795392666; cv=none;
        d=google.com; s=arc-20260327;
        b=kb3un6epC7nQ8qGJb6fXCv5iCQDO3U5mBvLJvUoaUn0GAEQX6aIJd38YylkQIB7o7O
         i6NuCZuUxf3GZHk7qf4oRqEWz4XyRcI2Ok981GBqtXML13v7RIArVCyG98rP3vw4WrBs
         99nZzluNPjYcFm2nwGNj1YQyAcpTjXR0Azfn7H11z22g6pulHk4wEeCgmCEjHd4FyaSV
         CVet7E/bz5BOkwAuUZxBDNMIs6I/KuqBcAiQOoVuSrmIHVNDo5UQMuOwFFDl9zAywy2v
         DY3SLDH5q8WsJzv/37JSSTAQ0Gmezw53DG7oz8+8dxk2/bQUNLw91ZJy/FaVdc0dlRak
         wkyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5I86RWqzyaU23Eu5ohO05WelFgFCrtFVPnKv6K/hbMI=;
        fh=ZNVw09LxdYWp6YILAmhoBnQZ9hRV/qH8VP6pJ0O4vb0=;
        b=YHoiPpyKa9C1irGLdOt9S/UvTCH4HOsAmJYJWIvpDVUSCyeybvm61U//pYmYOplZ11
         1NHFJbrRr5ZVZHcB1xC96Fw88MNlWS7VlHVdOblpOEN11xhDQZI+11d3QqfCzM2VQv0+
         k0tEt08qscf6MnUpQy8GkznsnxV+U+TSofCEfQVyJpQSi6dGSSZJxR/BqF7uL7bM8qU7
         M7mHZQPT1SiqMD/JOI5cmrFVV/xQ3Oi9TykPx2+KIZ1NlfkvXho0pPtnqoXsWw7bztbm
         4CS0rp6h1c/bzsgW8X6yfbUgZdAwH58EVINl+Adgc48lG+WVWwOAFGPLnWqcYzfnJIIF
         MEvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795392666; x=1795997466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5I86RWqzyaU23Eu5ohO05WelFgFCrtFVPnKv6K/hbMI=;
        b=zALYqXVsTf4RIBPpLZbkdSm1oBGgfTqh6fu6XwNuNCsmXqs+02Y3Czm7MgkJxMk9Z/
         3Y+M2gjFNUV5+wO/Oy2pP0ZFX0/N2ryNwPzU3H2H0RDg2/cMpdIOIVXVuq/hGPj/2cMT
         TvQEv2wU2d8aDzn6zufeDMBvH/hQ5Nvvg0kmicqqPXRbkFFs43lg3RvJf1AUDgiH4HOb
         wG4AReXo6K6jbG7JW64452XmwoCMNpNRATqYIJMF3j4GjrrHqs6c6zg901+0EMrcD3iX
         qJb1xOBjYQ3IKO59y2Y519WY9majCENjE5Q5dkOT7sarlmczWAQraGhPSB4NapR6L/gp
         /LIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795392666; x=1795997466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5I86RWqzyaU23Eu5ohO05WelFgFCrtFVPnKv6K/hbMI=;
        b=HFGOIlC147ZkXUs0tB9QDg7EZFtM611bEGRp0X2FO/qhPuJCRDtAXsq1zybeUCcTsX
         RMFsPSBR8v1hem6tDj7wgQ3gwpXoM1Cur/dhI0V0EkBISTcn5fgN8/7CNiu7QRP5HOIJ
         uOqgCLMFFOPL2yAqMFe6PfbB6jFdU7RBcLjNWT8LI9rzgrKWr1iUyCKfGY8TeLU8siV0
         +VxWoQ40T6GvnZqPXG7/6Ls0GDoqlZwAQ0xrZ+gb+oWaGekzOtpxjYXCmsnapdHpR6GZ
         2teD63nM9vUO1yLI9BMvap3m6US41PiHz8vLOj5WuhL83EhCd7p26RBdYKpHH+KmAEDf
         po0w==
X-Gm-Message-State: APuU4Z8y4Cb3nFZbqh3IL+gsDsZPKx+Q7xMxejzjRJSM5oSCX7Ppn2UC
	cj5Sv96tjpVgA7X1p2B5Bq+/SqEUWtJV+5yo1xTvUbHPO/rPeGIhuGKAa2gGPcOQEnCdxxX1TS9
	yWNA2XaV6dd3Imk73ZN9BQkhDU8fUw80=
X-Gm-Gg: AZFdTZdzvUQiXdbJ+gwfooSU9D1Gs7aywyKYVZghCfsqUt9RIFzmIqJmATwHuMxXts2
	/UeGcN5thObRuogCGoaAuE+36gOf5fyDMbT6vJiwGcZZ2ZK5vnlnYembikew0UShhDt7xL5VIvx
	YlbI+XZmQu0ISfKAU1kZOiWCTCiAwq+coa51/fBPMStdJOplcgWnqWjfD6yOkQmglLqyb7tbZi5
	P3hBRhLWUoM1WkGg3WhX8fKK6QESwp5uJnGQiKH9c3AWD/SPRyvX0M5ufUJOghjxGnk4nZ5Jx7y
	kg12asYA10wloeL7V+1d6bqHnqEXeSi7R+146McgffYmWLfZ97l09aqlA8ybUUDYepHuzYL6jg7
	nfmsck9GupKKmtzE9Zy3snhPkpIROW4SK0/x4Wnb5j1HN5Tdn59M/BJh0zDHzsoxCOeKKQsurhX
	Nr5h0cXN/PTMrOT/Q64SoY9Z2XaeEbMme5HZFBL/f1+SEoDDBkyk7pX687Dcwh8lXUQNp2bxwzv
	6dQztY6kEEkU5A=
X-Received: by 2002:a17:90a:d444:b0:3b4:15e3:3a53 with SMTP id
 98e67ed59e1d1-3b41cb53acbmr8913367a91.66.1795392666237; Sun, 22 Nov 2026
 16:11:06 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260929185122.3127574-1-lightofmysoul@gmail.com>
In-Reply-To: <20260929185122.3127574-1-lightofmysoul@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 22 Nov 2026 19:10:54 -0500
X-Gm-Features: Aa3M54ooqLvkO3bTfEJ7fgaZslP1eicd03CGljRtroPWJyUxJiAhbXhWq-BKvbw
Message-ID: <CALnO6CDZeEG938Wm7CuBYuP1i8hVSz=MqCRMCxp1UMa_i1uPcw@mail.gmail.com>
Subject: Re: [RFC PATCH] submodule: make '^/' work like '../' but with an
 absolute path
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Adrian Ratiu <adrian.ratiu@collabora.com>, Jacob Keller <jacob.keller@gmail.com>, 
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I use submodules quite a bit, and I've had enough trouble deciding how
.gitmodules should record the URL that I might give this a proper
attempt in the wild once it's released. So let's see if I can
contribute anything useful?

On Tue, Sep 29, 2026 at 2:54=E2=80=AFPM Stanislav Aleksandrov
<lightofmysoul@gmail.com> wrote:
>
> A submodule URL like "../../org/lib.git" breaks when the superproject
> is forked to a different depth, e.g. into a GitLab subgroup. An
> absolute URL doesn't break, but it forces one protocol on everyone.

Not being familiar with GitLab subgroups, I don't totally follow this
description. I've read the test cases, though, and it sounds like the
issue is one where

- /org/repo.git has a submodule ../../org/lib.git
- it is forked to (say) /elsewhere/org/repo.git or
/org/elsewhere/repo.git: now the submodule resolves against
/elsewhere/org/lib.git (resp. /org/elsewhere/lib.git), which may not
be what you wanted.

I can see uses in both cases (and for absolute URLs), but not
requiring a "mirror fork" in such cases to use these URLs is
reasonable.

> Resolve a URL starting with "^/" against the superproject's remote,
> like "../", but from the root of the server. Protocol, user, host and
> port stay the same. For "^/org/lib.git":
>
>     https://host/me/super.git      ->  https://host/org/lib.git
>     git@host:group/sub/super.git   ->  git@host:org/lib.git
>
> Unlike "../", "^/" fails in a superproject cloned from a local path or
> without a remote, since there is no server. It also fails for
> "<transport>::<address>" remotes, whose address only the helper can
> parse.

So this privileges a few transports over others, but perhaps that's
reasonable. It might be nice to support local paths, but I don't see a
compelling need to off the top of my head (why anyone would replicate
the above scenario on a single machine, I'm just not sure)---if we
figured out how to support it later, does the current implementation
back us into a corner and prevent that, or would we just be lifting
the restriction and slotting in the new code?

> The syntax comes from svn:externals, where "^/" is the repository root.

Always good to see prior art.

> ---
> RFC: the syntax is new, and it changes the meaning of local paths
> that start with "^/".
>
> - Why not "/path" or "//host/path"? "/path" is already a local
>   absolute path, "//host" is a network path on Windows, and neither
>   can express "git@host:path" or SSH host aliases.
> - Why not url.<base>.insteadOf? It has to be set up on every clone;
>   .gitmodules cannot carry it.
> - Compatibility: a local "^/..." path needs a "^" directory in the
>   superproject and protocol.file.allow=3Dalways, and "git submodule
>   add" refuses it.
> - Known costs: "^" is special in cmd.exe, Git Bash rewrites "^/..."
>   arguments, and libgit2, JGit and forges would need to learn it.
>
> GitLab has an open request for the same thing:
> https://gitlab.com/gitlab-org/gitlab/-/issues/393295

As we move towards graduating this topic, I wonder if any of this
information ought to be present in the log message, or leaving folks
to discover it via the amlog notes -> mailing list is sufficient?

> diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodu=
le.adoc
> index 722d827908..f512625eb8 100644
> --- a/Documentation/git-submodule.adoc
> +++ b/Documentation/git-submodule.adoc
> @@ -40,8 +40,9 @@ subcommands are available to perform operations on the =
submodules.
>         project: the current project is termed the "superproject".
>  +
>  _<repository>_ is the URL of the new submodule's `origin` repository.
> -This may be either an absolute URL, or (if it begins with `./`
> -or `../`), the location relative to the superproject's default remote
> +This may be an absolute URL, (if it begins with `^/`) an absolute path
> +on the server of the superproject's default remote, or (if it begins wit=
h
> +`./` or `../`), the location relative to the superproject's default remo=
te
>  repository (Please note that to specify a repository `foo.git`
>  which is located right next to a superproject `bar.git`, you'll
>  have to use `../foo.git` instead of `./foo.git` - as one might expect

In this hunk I think we are working too hard to minimize changes.
Presenting the conditional on "^/" *before* the explanation of what it
means is particularly awkward to me in this paragraph. Perhaps
(ignoring my unfamiliarity with AsciiDoc, ahem):

    The URL may take the following forms:
    * an absolute URL, using URI syntax;
    * an absolute path on the server of the superproject's default
remote, using the syntax `^/<path>`;
    * a location relative to the superproject's default remote, using
a path syntax starting with `./` or `../`.

? Perhaps there is yet a better way ;)


> diff --git a/Documentation/gitmodules.adoc b/Documentation/gitmodules.ado=
c
> index fd96639806..9f6cc9a4ef 100644
> --- a/Documentation/gitmodules.adoc
> +++ b/Documentation/gitmodules.adoc
> @@ -31,9 +31,10 @@ submodule.<name>.path::
>
>  submodule.<name>.url::
>         Defines a URL from which the submodule repository can be cloned.
> -       This may be either an absolute URL ready to be passed to
> -       linkgit:git-clone[1] or (if it begins with `./` or `../`) a locat=
ion
> -       relative to the superproject's origin repository.
> +       This may be an absolute URL ready to be passed to
> +       linkgit:git-clone[1], (if it begins with `./` or `../`) a locatio=
n
> +       relative to the superproject's origin repository, or (if it begin=
s
> +       with `^/`) an absolute path on the server of that repository.

And here, perhaps to avoid repeating ourselves, we should point back
at the other document?

    Defines a URL (in the sense of linkgit:git-submodule[1]) from
which the submodule repository can be cloned.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 5d3bcda334..16884ca6b6 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -50,7 +50,8 @@ static char *get_default_remote(void)
>         return xstrdup(repo_default_remote(the_repository));
>  }
>
> -static char *resolve_relative_url(const char *rel_url, const char *up_pa=
th, int quiet)
> +static char *resolve_relative_url_gently(const char *rel_url,
> +                                        const char *up_path, int quiet)
>  {
>         char *remoteurl, *resolved_url;
>         char *remote =3D get_default_remote();
> @@ -58,14 +59,17 @@ static char *resolve_relative_url(const char *rel_url=
, const char *up_path, int
>
>         strbuf_addf(&remotesb, "remote.%s.url", remote);
>         if (repo_config_get_string(the_repository, remotesb.buf, &remoteu=
rl)) {
> -               if (!quiet)
> +               if (!quiet && !starts_with(rel_url, "^/"))
>                         warning(_("could not look up configuration '%s'. =
"
>                                   "Assuming this repository is its own "
>                                   "authoritative upstream."),
>                                 remotesb.buf);
>                 remoteurl =3D xgetcwd();

I'm somewhat confused why we suppress this warning: the `^/` syntax
doesn't make sense if remoteurl=3D$PWD, right?

>         }
> -       resolved_url =3D relative_url(remoteurl, rel_url, up_path);
> +       if (starts_with(rel_url, "^/"))
> +               resolved_url =3D root_relative_url(remoteurl, rel_url);
> +       else
> +               resolved_url =3D relative_url(remoteurl, rel_url, up_path=
);
>
>         free(remote);
>         free(remoteurl);
> @@ -74,6 +78,16 @@ static char *resolve_relative_url(const char *rel_url,=
 const char *up_path, int
>         return resolved_url;
>  }

> diff --git a/remote.c b/remote.c
> index fe62068463..05ef35e3ab 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -3095,6 +3095,67 @@ char *relative_url(const char *remote_url, const c=
har *url,
>         return strbuf_detach(&sb, NULL);
>  }
>
> +static const char *skip_bracketed_host(const char *host)
> +{
> +       const char *start =3D strstr(host, "@[");
> +       const char *end;
> +
> +       start =3D start ? start + 1 : host;
> +       if (*start !=3D '[')
> +               return host;
> +       end =3D strchr(start + 1, ']');
> +       return end ? end : host;
> +}
> +
> +static int has_host(const char *start, const char *end)
> +{
> +       const char *p;
> +
> +       for (p =3D start; p < end; p++)
> +               if (*p =3D=3D '@')
> +                       start =3D p + 1;
> +       return start < end && *start !=3D ':' && !starts_with(start, "[]"=
);
> +}
> +
> +char *root_relative_url(const char *remote_url, const char *url)
> +{
> +       struct strbuf sb =3D STRBUF_INIT;
> +       const char *path, *host, *end;
> +       int scp;
> +
> +       if (!skip_prefix(url, "^/", &path))
> +               BUG("not a root-relative url: '%s'", url);
> +       if (*path =3D=3D '/' || *path =3D=3D ':')
> +               die(_("root-relative url '%s' must not start with '^//' o=
r '^/:'"),
> +                   url);
> +
> +       for (end =3D remote_url; is_urlschemechar(end =3D=3D remote_url, =
*end); end++)
> +               ;
> +       if (starts_with(end, "::") || starts_with(remote_url, "file://") =
||
> +           url_is_local_not_ssh(remote_url))
> +               return NULL;
> +
> +       scp =3D !is_url(remote_url);
> +       if (scp) {
> +               host =3D remote_url;
> +               end =3D strchr(skip_bracketed_host(remote_url), ':');
> +       } else {
> +               host =3D strstr(remote_url, "://") + 3;
> +               end =3D strchrnul(host, '/');
> +       }
> +       if (!end || !has_host(host, end))
> +               return NULL;
> +
> +       strbuf_add(&sb, remote_url, end - remote_url);
> +       strbuf_addch(&sb, scp ? ':' : '/');
> +       if (scp && end[1] =3D=3D '/')
> +               strbuf_addch(&sb, '/');
> +       strbuf_addstr(&sb, path);
> +       if (ends_with(path, "/"))
> +               strbuf_setlen(&sb, sb.len - 1);
> +       return strbuf_detach(&sb, NULL);
> +}

This is quite a bit more string-munging code to parse(?) a URL than
I'm comfortable reviewing. I wonder if we have something available in
one of our dependencies we can use to make this work without doing it
ourselves? Or if there's some way to make it easy to see which input
forms we handle (so that we can also think about those we don't)? I
saw the header comment (kept below), and it left me wondering if there
are URL formats *not* covered.

> --- a/remote.h
> +++ b/remote.h
> @@ -478,6 +478,21 @@ void apply_push_cas(struct push_cas_option *, struct=
 remote *, struct ref *);
>  char *relative_url(const char *remote_url, const char *url,
>                    const char *up_path);
>
> +/*
> + * The `url` argument starts with "^/" and names a repository relative t=
o
> + * the root of the server that `remote_url` points to: the path of
> + * `remote_url` is replaced with the rest of `url`, keeping its scheme, =
user,
> + * host and port. Returns NULL if `remote_url` has no host, and dies if
> + * `url` continues with '/' or ':', which could change the kind of URL.
> + *
> + * remote_url                 url            outcome
> + * https://a.com/b/c          ^/d/e          https://a.com/d/e
> + * ssh://u@a.com:22/b/c       ^/d/e          ssh://u@a.com:22/d/e
> + * u@a.com:b/c                ^/d/e          u@a.com:d/e
> + * u@a.com:/b/c               ^/d/e          u@a.com:/d/e
> + */
> +char *root_relative_url(const char *remote_url, const char *url);

> diff --git a/submodule-config.c b/submodule-config.c
> index 37c3be377b..dfa819112c 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -237,9 +237,10 @@ int check_submodule_name(const char *name)
>         return 0;
>  }
>
> -static int submodule_url_is_relative(const char *url)
> +int submodule_url_is_relative(const char *url)
>  {
> -       return starts_with_dot_slash(url) || starts_with_dot_dot_slash(ur=
l);
> +       return starts_with_dot_slash(url) || starts_with_dot_dot_slash(ur=
l) ||
> +              starts_with(url, "^/");
>  }

Making this useful across more of the codebase could be a step [1/2],
if we were so inclined.

> @@ -342,6 +343,9 @@ int check_submodule_url(const char *url)
>                 if (count_leading_dotdots(url, &next) > 0 &&
>                     (*next =3D=3D ':' || *next =3D=3D '/'))
>                         return -1;
> +               if (skip_prefix(url, "^/", &next) &&
> +                   (*next =3D=3D ':' || *next =3D=3D '/'))
> +                       return -1;

Are such "^/" URLs susceptible in the same way as the comment
describes the previous check? We probably don't want to *make* them
so=E2=80=A6

What caught my eye was the repetition, wondering if we could collapse the 2=
 with

    (count_leading_dotdots() || skip_prefix()) && =E2=80=A6

, but now I'm also wondering if "^/" goes through the same resolver
(or a resolver with the same problems) as described in c44088ecc4
(credential: treat URL without scheme as invalid, 2020-04-18), and I'm
genuinely not sure.

> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 56faf5fe73..c8618e8a30 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -7,6 +7,11 @@ test_description=3D'Test various path utilities'

> +test_expect_success 'root-relative submodule url cannot change the kind =
of url' '
> +       for url in "^//evil.example.com/x.git" "^/:evil"

Ah, hm. Na=C3=AFvely, I'd expect these to resolve to
"host/evil.example.com/x.git" and "host/:evil". I'm not sure how URL
parsing generally handles the latter, but the former doesn't seem like
it is actually an issue? Unless that's *not* how we resolve those.

> +       do
> +               test_must_fail test-tool submodule resolve-relative-url \
> +                       "(null)" host:/srv/super.git "$url" 2>err &&
> +               test_grep "must not start with" err || return 1
> +       done
> +'

> diff --git a/t/t7427-submodule-root-relative-url.sh b/t/t7427-submodule-r=
oot-relative-url.sh
> new file mode 100755
> index 0000000000..526dfec8d2
> --- /dev/null
> +++ b/t/t7427-submodule-root-relative-url.sh
> @@ -0,0 +1,190 @@

> +test_expect_success 'clone of the upstream in a subgroup' '

As I said earlier, I'm not sure about "subgroup"---that seems
potentially GitLab-specific. Is there a different and more clear way
to explain this test case?

> +       git clone --recurse-submodules https://example.com/org/team/super=
.git upstream &&
> +       test_cmp_config -C upstream https://example.com/org/lib.git submo=
dule.lib.url &&
> +       test_path_is_file upstream/lib/lib.t &&
> +       test_path_is_file upstream/lib/dep/dep.t
> +'

[I suppose you all can decide if I succeeded; I didn't see much review
of the code prior to this, and I've omitted bits.]

--=20
D. Ben Knoble
