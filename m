Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58444369982
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942390; cv=pass; b=hHJzPc6ymyBLPXjN5JRs5YYHdNwxhgMkxa4VOCUiP3Tcfn+ktxkM+ogpelC7tYxfHqtubX7XR9RGofdArlaLzalPHVbfvLmHLgydFEoVi0DivgVFMLoosYiLNK4PT8SA99zeICX5pHADqeir6Onfwo50wZb3WKce0H2UkcM4k3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942390; c=relaxed/simple;
	bh=lcPivFteeDmb4CK5bTJD03nTMnHTh+oxFRHL02go+6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpQMC+RfiOc9p0r5m6aCVNfvuTOPQ8sX699+trJKeeYAh3Ay3pv5pesTmsCBgW/z563D4pUrNy7h7WU6tlmbUS2m8TCZMWKufJt58/lmdR1dswR/oJm2mvRDKV2tDJBTE3O3EYSdlSAqru+RlCzQrkCT/B+R/dVRT4wxEbo4aKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sm5a1wAL; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm5a1wAL"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35640ad94d3so4339799a91.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 06:13:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771942389; cv=none;
        d=google.com; s=arc-20240605;
        b=loxTTVS8dX9gUHHTanX5dYa7PGFe5JZRImCJgW6QgqgsuwItsfW4MSqxpDDP8ES3uF
         OWKcSynNIbSdU6NkoVKmkA5jjcW1isNheaUfzrKLF6cpSPka2aiGGJHDyv10rr7T3GiT
         p0BNcxr4hgIp5t/rHp/CVq8ZjzsM1EYX1ou4Oh1WL+MQJpC0OkXRNE+ALjSGakoUkWuj
         jRMODV0O+4zI9qKuwF1b5b9O2aamoy8mjZz0DEfRRECa8qznbXS2bOnU88LOKIQ+y4mP
         BCkhNie9oUInNoziZt5AAhpccLXlxBEI0ws5es7n+Irm77nDgUV7Z/EUNnqNhE5k6KNa
         G7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZeuaQDk9MpOHi+5fF6jx1L/cqylFkRxiw63qrzhy51o=;
        fh=h6XiemxEM3satBaN9yqQR47BiaspIFmeP/T9OCfV+10=;
        b=kZBauS5DRcV4clvRSQ2kyMB0sxXHkYqi1pL8TjvG3/Ak71Nq5QQSTvPeZAR4caNMgv
         4+7QXkPIdQsyvrSP27V5tAnC4M0ogAxSBa5/26khZFvrJlixuOIBQCC8DFvjb/qU4aYS
         fUw/gJ5qXthcQnx0mr5lKR5v5Ei90giCPIKwXUIuSXVcWSiMqxHrOEK92in3BktP4qU/
         1c4Wi/q1K1BXlTeasMFnCIpUEEpDb0snJUT39ZJ7HJW6Tny3+EpAkk0IfhO9aZQYYp1O
         2qNf08GUc9i4skm+Hd8SXqMU5hbXANGbkHwpcR8qIqWJkoWfNhupRiLcc9o3NNdagwuk
         s+iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771942388; x=1772547188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeuaQDk9MpOHi+5fF6jx1L/cqylFkRxiw63qrzhy51o=;
        b=Sm5a1wALryd4VOFgiOZzq1JKp3/2chRm6iYoIUQn37SM7z08UrHXWmPlgqn7mSEXvY
         FdByZcnqXssum2EAWpb2aCE/jsyxsE9ernTc4JRAgHl6BHKf5SHCNElTpErLuY6PuUuB
         OOzPi9UKKX3B3wAkqCjQBj1y6OfQQBlVG52zMQy+Z/CB/WP9/xQzqosYc+eNHCdtIFQz
         a0TEKY2U2SSeVv8HVpJ/HHQYD3P/fWAmu8/JW2WaFMVYvNTUrHlqf6JbPPq0WOaFSUFR
         isi/31TbxZknlhaATn7f0R9AhdNDI5tRFAt1+vbhyotXjFMvKrOCoQ0upJPfmJ+n+Oq5
         XdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771942388; x=1772547188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZeuaQDk9MpOHi+5fF6jx1L/cqylFkRxiw63qrzhy51o=;
        b=UuogAGlrWaaUOIaodEr9rSqqqvXjA27EYaghMfyb+Q1PVXsaJCzm38I0J2Qha+5Cp7
         Ek2Pp0IwyeltJ9iJ/U9C9SriAnXvdtPhlkGXotRddbcqKHG9b7kCXOV8xvP2jmHIYVjd
         xrLYsSAeCNlZRyfgs1ixqZu+xp37bp/3mfAHi8H+drT3Dt3c0NLcOmBz79H5wQx0wjHR
         nicDmFZtfV+Y3KmGelziMF7SkRsNuIJfQrmXq9ztdgoJ5TI+VqOZoUmdE8OYCKliPs7W
         7dP3SbIP3Z79JSo+x28HnwmAWwDIr2H6L1UKVXAmHmpZtDwo5xRECTK3bD0R0TJ7u4eL
         zVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWokUwlJfxS6yTkvr33cz1yhiz96c3lf4yYC2qwzXsHr/rYi8Gok6TQwGttWkMwTLYO/3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVOJvkFbpsUrKtomKK+Xlaiw3K8rUCKq7+aMqRgm+NnX7zbSfq
	E1/KngukjvTlmMMTT5ckYC585lNfdLsx0K5XYebJHHHwPrxGiFIE9B+kf1FlpD6FiYj2eXXU82g
	DKpoqqPaPm92iKpfljumVJmA3ObVJu2Y=
X-Gm-Gg: ATEYQzyaGYM2gTlbv6PCMvZd/1LmSx9XkPDdqHk5TyC9ec6ylCsCLdQ9KJJ2Y8Qq9t1
	yuMjZ2nEgOdGeZVWpojdvGhPx1m4r70c98uATeWcVuSwnA4z55TrqEQucQs44qOAhwJGPHGBH8G
	mtbq6W503adUVQFa8KWVJvyGnffWmF5jNhyksiQqxEwl6f/bw/Cx7sFB7gkdSi1M8iM+6ksLlgp
	GoGwN38Jnvrn9rmgdQoKG4CJUPDuh+QTPJG66yuA/PT0wPoty6VV6sWHJGKa1Rnl+7m57pNJ3C8
	a49PWkvUo0LFfIXInJhBLQLxcXSnRxWVDd9K5RYqTO7ChLO+fRCOpBec3kuPa7Oha5LEw8Bng1C
	JKnhl
X-Received: by 2002:a17:90b:5252:b0:34e:5aa2:cf61 with SMTP id
 98e67ed59e1d1-358ae8d2529mr10347313a91.28.1771942388490; Tue, 24 Feb 2026
 06:13:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZv54vN9DdGsvre/@szeder.dev> <8AB2DD1B-FAFA-4510-82FA-BBD76B442676@gmail.com>
 <aZ12Lk85bSajirCY@pks.im> <39acbf7e-86f4-4dbe-8b58-3c04fccd7984@gmail.com>
In-Reply-To: <39acbf7e-86f4-4dbe-8b58-3c04fccd7984@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 24 Feb 2026 09:12:57 -0500
X-Gm-Features: AaiRm50gWt95Q-vvcAekGfdtA6Q012i2HahUPV1A2FUTffZRHwzlV_jqVJuP-OI
Message-ID: <CALnO6CBsj_2+pZG+bqbrE3tQH=6_kqdtCnNPm8MfJ2XZOA9e3Q@mail.gmail.com>
Subject: Re: [PATCH v6] build: regenerate config-list.h when Documentation changes
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>, 
	Evan Martin <evan.martin@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 6:00=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
>
>
> On 24/02/2026 09:58, Patrick Steinhardt wrote:
> > On Mon, Feb 23, 2026 at 04:41:48PM -0500, Ben Knoble wrote:
> >>> Le 23 f=C3=A9vr. 2026 =C3=A0 01:55, SZEDER G=C3=A1bor <szeder.dev@gma=
il.com> a =C3=A9crit :
> >>> =EF=BB=BFOn Sat, Feb 21, 2026 at 09:07:17AM -0500, D. Ben Knoble wrot=
e:
> >>>> diff --git a/Makefile b/Makefile
> >>>> index 7f37ad8f58..6f926ffb1f 100644
> >>>> --- a/Makefile
> >>>> +++ b/Makefile
> >>>> @@ -2688,9 +2688,10 @@ $(BUILT_INS): git$X
> >>>>     cp $< $@
> >>>>
> >>>> config-list.h: generate-configlist.sh
> >>>> +    @mkdir -p .depend
> >>>> +    $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@ .depend=
/config-list.h.d
> >>>>
> >>>> -config-list.h: Documentation/*config.adoc Documentation/config/*.ad=
oc
> >>>> -    $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
> >>>> +-include .depend/config-list.h.d
> >>>
> >>> This breaks the build when something disappears from
> >>> Documentation/config/:
> >>>
> >>>   $ git checkout origin/seen
> >>>   HEAD is now at 57edfa3ce8 Merge branch 'ty/setup-error-tightening' =
into seen
> >>>   $ ls -l Documentation/config/hook.adoc
> >>>   -rw-rw-r-- 1 szeder szeder 3828 Feb 23 07:50 Documentation/config/h=
ook.adoc
> >>>   $ git grep hook.adoc
> >>>   Documentation/git-hook.adoc:include::config/hook.adoc[]
> >>>   Documentation/howto/meson.build:  'rebuild-from-update-hook.adoc',
> >>>   Documentation/meson.build:  'git-hook.adoc' : 1,
> >>>   $ make V=3D1 config-list.h
> >>>   /bin/sh ./generate-configlist.sh . config-list.h .depend/config-lis=
t.h.d
> >>>   $ git checkout 0aabf70f60
> >>>   Previous HEAD position was 57edfa3ce8 Merge branch 'ty/setup-error-=
tightening' into seen
> >>>   HEAD is now at 0aabf70f60 build: regenerate config-list.h when Docu=
mentation changes
> >>>   $ ls -l Documentation/config/hook.adoc
> >>>   ls: cannot access 'Documentation/config/hook.adoc': No such file or=
 directory
> >>>   $ git grep hook.adoc
> >>>   Documentation/howto/meson.build:  'rebuild-from-update-hook.adoc',
> >>>   Documentation/meson.build:  'git-hook.adoc' : 1,
> >>>   $ make V=3D1 config-list.h
> >>>   GIT_VERSION=3D2.53.0.119.g0aabf70f60
> >>>   make: *** No rule to make target 'Documentation/config/hook.adoc', =
needed by 'config-list.h'.  Stop.
> >>>   $ grep hook.adoc .depend/config-list.h.d
> >>>   config-list.h: ./Documentation/config/hook.adoc
> >>
> >> Indeed. This might arise while bisecting, which was my original
> >> motivation. Thoughts on a path forward? At least this issue (to me) is
> >> clearer than a spurious test failure :)
> >
> > For Meson this case works alright. So maybe we just drop the changes to
> > the Makefile and call it a day?
> >
> > An alternative would be to have the following patch on top:
> >
> > diff --git a/generate-configlist.sh b/generate-configlist.sh
> > index 39ac8845ab..e28054f9e0 100755
> > --- a/generate-configlist.sh
> > +++ b/generate-configlist.sh
> > @@ -41,7 +41,12 @@ EOF
> >   if test -n "$DEPFILE"
> >   then
> >       QUOTED_OUTPUT=3D"$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')=
"
> > -     printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
> > -             "$SOURCE_DIR"/Documentation/config/*.adoc |
> > -             sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFI=
LE"
> > +     {
> > +             printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
> > +                     "$SOURCE_DIR"/Documentation/config/*.adoc |
> > +                     sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /"
> > +             printf '%s:\n' "$SOURCE_DIR"/Documentation/*config.adoc \
> > +                     "$SOURCE_DIR"/Documentation/config/*.adoc |
> > +                     sed -e 's/[# ]/\\&/g'
> > +     } >"$DEPFILE"
> >   fi
> >
> > What it does is to also create an empty target for all of the
> > dependencies. Which is in fact what GCC/Clang also do when you pass -MP=
:
>
> Oh, I was wondering how they got around the problem we're seeing here.
> While it seems ninja is happy it ignore missing dependencies in
> depfiles, are we sure the build systems meson uses on other platforms
> are as well? If not it might be worth adding this, rather than just
> dropping the Makefile changes.
>
> Thanks
>
> Phillip
>
> >
> >      $ cat main.c
> >      #include "foo.h"
> >      int main()
> >      {
> >          puts("foobar");
> >          return 0;
> >      }
> >
> >      $ clang -MMD -MP main.c
> >      $ cat main.d
> >      main.o: main.c foo.h
> >      foo.h:
> >
> > Patrick

Yep, I agree with Phillip: I have a feeling Meson intends folks to
produce output like GCC/Clang do, so let's honor that (even if it's
not well-documented IMO). Will add.

--=20
D. Ben Knoble
