Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7441DF27F
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334903; cv=pass; b=f1p8Rxt/vd0aoKqz5VO7AfDUX3MVB0nIELEzf4MTt0fY+P2EWfLQtwTefkCCKCOOBjPn80P6yMs4gjnCVSaEG/n0Vpai8RBr6CnvRt0oM70Y/N5odSnzHTozSVU7bXVTE70/flgHbTir62VjA3q2bxa5gJXF5rRmqQbDl9Dk2XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334903; c=relaxed/simple;
	bh=BTYvMCxbb+jXA3wWCqqHHV4zhx78/GPx3iu39BAG7fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAqsaT1fTZUTsWJFbtsIg5fi7dkpgD9ww5oADQ4NfgOyej1Hbf7Ht9/EhzDmwL44Mb6Bvj3lLB8aUJpsxHBf5c81KxfPMLsxYagHGaCcBQIwqXnkHSOn2HnuERkYv2gXlCs6Yf6ULy5uR88njYB+8fDhu8RB6Eu9En+ej9x6Z2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVuqwhlx; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVuqwhlx"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c5513f598c0so1609023a12.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 05:28:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771334902; cv=none;
        d=google.com; s=arc-20240605;
        b=ZrsY1C/35wjTuPxuOU+m6kcrv5rmyrH9/SWJqn+lSBzT7gYNIM2ihoYbpuwTVM6jZy
         7Fwp9cq+QJlSxEQjxP9Hf3trFbCOWsxtIePdBuNsEbm8So45F8pf0zeoL3bP3W83DUS8
         jcMexFzFcIUi9HeMm1TYbqiyRLaEqPhWUNBq/q4PyLctCkjl/ei3rFAOzOCQwYFPdMAE
         YwXbTZif4XgD43xK4b9u6XKWceseB9QvoeyJcX84T1PwGC0974vKNsgFaOjm1axkMMmd
         APxD7KcGdZtNih2k5lXhAB/Rp7vAe8Odch93/sz6k/wMXy/DdnexQ2Qr2AkHglF/rujp
         YkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fo+j14qE9aOuMtCRnwRHV+essYLZ0BERzvTY3luc36U=;
        fh=rtP/cyUBDrqqIjHuC/uoYPSjBxuiNXh+0zsNiRm0/YA=;
        b=OxZqNL9yW4d00SURcs1xMMYdQQ4FxmcI1q9Gs3TzFueIlbWFqDSoycKdLx8QOc5f4u
         z0KDjL0yqRwhYiu3BqisuJWEJUcx78r9mHyST6bAUI52tunMBGaMUTWcpcz8tNW14C6F
         diJTHHeQWwntRJoIQ4tIqmTxYuoBfYI8TGQ2zscOaLdFZwemPQNkAqfo+xZre/sdlokd
         E8k4yHSakG80Tsnb+pVPDpDSkhyy+3J1dgA9cb6kLHVHawNoiSRv2EAaUqxLThhr+gyc
         b2QlbUNh2KMBiYVkfm8gfYS1jEG73rqY+BmfwW7ZbpgScemxaP1PUir5cyN0fEBCK9Sn
         d07A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771334902; x=1771939702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo+j14qE9aOuMtCRnwRHV+essYLZ0BERzvTY3luc36U=;
        b=iVuqwhlxqpNaii+M5nwvvIHbAbBIUyesC81TlNw+vEdUaOTydjVcQKZy/0k8PkVysH
         JfSb/FVQgKWj+rwbUIrjTDQWAGmostmoqwNq+4LiCGxBALkYoEXJqL1jG8ag33zgJW/D
         8+dr8PY4z+JAnXn/crk23JrFqYxec6Ue8nKfVCq2zHfDP/NWzqPIVOaLctiRhU6m5O3j
         jKgexAGPdzF9Nb05xL+GG9pBBfiJl+3njcpzyFAAinMZxJjCMEy0iay/og64nB8LuAzx
         n2bkKU24Lju5Kvak9wyuHuq+NzQ4dKL7anR5KSZXUv3uo0eXQNyTP6zZVnZ6kyYR7/ZA
         UDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771334902; x=1771939702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fo+j14qE9aOuMtCRnwRHV+essYLZ0BERzvTY3luc36U=;
        b=iabNNbB8uIP9SrIO0yOa0jdaCrLv1ZohyDIs3VnTYbS3iEWWF6HDdccV6DkYDN6++r
         5zdzJuGm2HwccYB4SAgadA8IlQy1wXe3LwODi+sty6RVZjOVZuEy4xgCl8E3yFfQjLTy
         6mKWXbL1MUKHdaK97tqa4P66rnlkPKdOEO7Zyf8JuiD111rymn6ZncS651cE7weImTS9
         xfbVa1hGlx4pyj1Ui4ma3MlYWZqxh1sHMxehw5arRPwGX2vG2tzq8V8ncC8qg16TPH46
         3dGbxORpcrb/zEFZOb1t5Rwv6fjz61WB8QE/R8YfhqABx7AbC1yL9U155pCr6dznQscP
         eCjw==
X-Gm-Message-State: AOJu0YwadYRIer4529+5mqJ5WQa0g2aC7mIYoJeGbXH7y5ngMVMWRalf
	LrJoNi/EMaaZrj3FY3hzH9mPUhiF/KbWHJZqVL4N+72bkSyFRyOfrhM6XVwr3BJ6s0ATiIbuzwa
	/UJE2Qpdk3476ihOd9+NsaXTK0INqh/Y=
X-Gm-Gg: AZuq6aJD/8cWbX0iN+JQgEkkETZpIvDzLliPu7W0WJPpieMlVKG/JsAzE1/hR9gn0Rg
	06ChsHwZyACfqDnlH5bjwtMFu19yESdsWVnTiZSnZ9ch6bRbsJgJLel+29Vfm+UK+zDSEN/RkRK
	lndJ0vucYpiPiT7FiWLSROCjXJ+3iZelk0WfmVpop1o6VzD7KNE483D/9+cmTOag0D/4s6os5CR
	BBri2ylvZ9waBir7fT7WXv6PTV6MAjFEi2jPXZFri0mn5injafQVi2RDcUMr3m9lnxsuLfswln9
	kiilhbk6HiSP4ewQDqQVRwCNr5mx2uwkWfNiDyWP9qxcHu6LmdjfKjXJbusS1G2ICfSqpywOPY0
	KOc3X7/WCRzIhCunEiix0SXRbFg==
X-Received: by 2002:a17:90b:55c5:b0:340:bde5:c9e3 with SMTP id
 98e67ed59e1d1-356aad3d56amr12376753a91.23.1771334901811; Tue, 17 Feb 2026
 05:28:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
 <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
 <aZQSf9yaNa693IFF@pks.im>
In-Reply-To: <aZQSf9yaNa693IFF@pks.im>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 17 Feb 2026 08:28:10 -0500
X-Gm-Features: AaiRm51rxWkjzEUYSCX6lUZaqEEoJHudKHdut7bSNu6vt6ScPllsI8ivaVpPetk
Message-ID: <CALnO6CAGfd2orSzjvxfAYx=xBnB=QdOwT-f5g0pQrcxO_19BGQ@mail.gmail.com>
Subject: Re: [PATCH v4] meson: regenerate config-list.h when Documentation changes
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Evan Martin <evan.martin@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 2:02=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Feb 16, 2026 at 05:28:57PM -0500, D. Ben Knoble wrote:
> > The Meson-based build doesn't know when to rebuild config-list.h, so th=
e
> > header is sometimes stale.
> >
> > For example, an old build directory might have config-list.h from befor=
e
> > 4173df5187 (submodule: introduce extensions.submodulePathConfig,
> > 2026-01-12), which added submodule.<name>.gitdir to the list. Without
> > it, t9902-completion.sh fails. Regenerating the config-list.h artifact
> > from sources fixes the artifact and the test.
> >
> > Teach the meson build to depend on the Documentation files that
> > generate-configlist.sh reads by having it an additional output as a lis=
t
> > of dependency files, since Meson does not have (or want) builtin suppor=
t
> > for globbing like Make. We assume that if a user adds a new file under
> > Documentation/config then they will also edit one of the existing files
> > to include that new file, and that will trigger a rebuild.
> >
> > Also mark the generator script as a dependency.
> >
> > Combining the following commands helps debug dependencies:
> >
> >     ninja -C <builddir> -t deps config-list.h
> >     ninja -C <builddir> -t browse config-list.h
> >
> > The former lists all the dependencies discovered from our output ".d"
> > file (the config documentation) and the latter shows the dependency on
> > the script itself, among other useful edges in the dependency graph.
>
> Good hint, thanks for putting it here.
>
> > diff --git a/generate-configlist.sh b/generate-configlist.sh
> > index 75c39ade209..63a2e8b6938 100755
> > --- a/generate-configlist.sh
> > +++ b/generate-configlist.sh
> > @@ -36,3 +37,12 @@ print_config_list ()
> >       echo
> >       print_config_list
> >  } >"$OUTPUT"
> > +
> > +if test -n "$DEPFILE"
> > +then
> > +     for doc in "$SOURCE_DIR"/Documentation/*config.adoc \
> > +             "$SOURCE_DIR"/Documentation/config/*.adoc
> > +     do
> > +             printf "$OUTPUT: %s\n" "$(printf '%s\n' "$doc" | sed 's/[=
# ]/\\&/g')"
>
> Tiny nit: can't we simplify this to "$(echo "$doc" | sed ...)"?

Given how unportable echo is [1], I'd prefer to keep printf.

[1]: https://github.com/benknoble/echocho, for one. If the doc started
with "-e" for example the results might be unreliable.


> > diff --git a/meson.build b/meson.build
> > index 3a1d12caa4b..e4b8f1e33d2 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -720,11 +720,14 @@ endif
> >
> >  builtin_sources +=3D custom_target(
> >    output: 'config-list.h',
> > +  depfile: 'config-list.h.d',
> > +  depend_files: [ 'generate-configlist.sh' ],
> >    command: [
> >      shell,
> > -    meson.current_source_dir() + '/generate-configlist.sh',
> > +    meson.current_source_dir() / 'generate-configlist.sh',
> >      meson.current_source_dir(),
> >      '@OUTPUT@',
> > +    '@DEPFILE@',
> >    ],
> >    env: script_environment,
> >  )
>
> And this looks as expected now, too. I also verified locally that this
> correctly rebuilds things when either the script or any of the files
> change.
>
> I wonder whether we also want to have a second patch on top to adjust
> our Makefile? E.g. something like this:
>
> diff --git a/Makefile b/Makefile
> index 47ed9fa7fd..ed82775ec2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2688,8 +2688,10 @@ $(BUILT_INS): git$X
>
>  config-list.h: generate-configlist.sh
>
> -config-list.h: Documentation/*config.adoc Documentation/config/*.adoc
> -       $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
> +config-list.h: generate-configlist.sh
> +       $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@ .depend/c=
onfig-list.h.d
> +
> +-include .depend/config-list.h.d
>
>  command-list.h: generate-cmdlist.sh command-list.txt
>
>
> Please feel free to skip this part though.
>
> Thanks!
>
> Patrick

That seems reasonable. I'll add to the next version.
