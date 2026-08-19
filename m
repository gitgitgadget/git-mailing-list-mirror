Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39E2327BF8
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144014; cv=pass; b=f5GTpIGpbNwPb/VxWLF5yk3NnyqNePRonFHRK3TY0Uwrwvf335okTsmoksJtulLcqM6UkX2lWYomz7j65FL6h0zJCxg374RUl07repto+PYw0WqJkyiLHN30Veo0+6UxlwnEd+5A83IrVv6/aqNGppMI8Ysfy8uJ6zqr2fSzkCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144014; c=relaxed/simple;
	bh=zdK8sXOGRGuFbj3norBYlWygUppW4IB7GZWkKMZdw48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIum6hLdQzmf0qOfszNgbmwi6Qcie4QhBEBBiQZHKvlfxZFU/iTOr880sywOfIxPUQjHpGb/D16Iz2AAU9X9O2IodUOoOw2vN1E0smdYf5TJ07nIxRJSW7C+9ARAJQj1Z2e7gw8xvsphh4vjv+37tE7pa7BOPycq8xkP+Vx6etg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdohyRkC; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdohyRkC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d58efc7356so10277235ad.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 05:53:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787144010; cv=none;
        d=google.com; s=arc-20260327;
        b=ErWzFsx4x2gOYLK091/Ibvv+P/eTPiwkouRyxKyJhtDq1PqJ3MrLZR39q6/hc5RYOf
         pFYWm6mFLhvnOLYMjVWLU5PgWuN2RcicwBRseSnSmIjmJwGzfC8h9G7rUCNsfl+whx3G
         wYxBHs5c5MVoERTGEhzvZNbJXS+ir7F9+mOd2U+JSAK3e2zRdzQza+Q9X2fSxhsx4Uzl
         O7PoeuMT4xDqVjbRgm1eACqxyb0bS3swmaFlPxJe4lJrmMyUsQHLe3V8hnv/69LLXSAP
         Y+iD2r7Rythy2erXftFn2zuqnO14cZglPyK4cq55NQ1gAR+ZeohrYf9HRq6jxt0tIZbu
         5J8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mQqw3V6enY8DQxc3NaPo/GddAjlYIN0UjZ7qKZA6nto=;
        fh=pzx5T17qgYbkf60iW/L/YnJ+sAqy82Vuo8WZ4mAjcBw=;
        b=pjn8vce99UFn/MpbJbasFw4YK4Z5/nk3XUWzzpDssH8GbMest27FjdMSET52KOjEV8
         T3VCzcoeMWJv7KJcNul64ruWqzGGQwGYg34wYLfwTCDol8AsByhrXHXSgM2KccwQ0hAV
         Km4TyoifMEp5kFhrklhoaXGdVxcdlUfyukyqcxW8BRNnkLtompvPwhK9okgp56aJIpNU
         URkNS3bVj5//b5R3AAUTWH7mAPST3WxtKYAm5pHDJ8WOZFZgT+NGWieFXZkMDdv/f8FF
         3fcM1pVerUpeLj55j21G7vtPPqI6176d5UKnvR4mcQLCEErceDkdGUSWthcLeulTVCy0
         40ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787144010; x=1787748810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mQqw3V6enY8DQxc3NaPo/GddAjlYIN0UjZ7qKZA6nto=;
        b=cdohyRkCM6vrEuPkjZcwf7uruZDI2BaO/yTEMLLpr8I7n20gsqnwq+dwh2uC5DGO1N
         cS0FGeAlQxoXYQ6CWEmMnG96yhQ0UrxscuyCE/jWOhSQNUkGAs+ltZC+hvRyRJWoNDGR
         GkMlp/b4wZSsC0KTMd8jIFRgfIf5cQmEj1Hwa5qSsT7wdV+VuvVI3AMSv67GLUwnXSJ0
         9HXBxyGDLqx2d4sCX4F115wVvlG+2lWZEK9fhnGsrV03x1bWz3PJV0Y0jxMAvFErBwTI
         ZTKyT/3rWHXd1L+W8unCqWEafK0E23Zd6poM8pft1Ebcpqom9mVzqADFvCBHBVyesIyi
         mL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144010; x=1787748810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mQqw3V6enY8DQxc3NaPo/GddAjlYIN0UjZ7qKZA6nto=;
        b=s0tWJs0xUGdnmnllClj1i3b7PIQkuYdSd/53TzO90WbGq4mCHy968w3U39h+4KNzrj
         MGWuFGrTP6xBhT79W9DyLU2XeADAp9lIXHiXmjOo2V0P24Hk33fa96xX3C1fyftx2Wnd
         9kmeleMAoYMBn6+gAl8PNs8L/PGkcWM9EsWf7serk0aFYm8roNwPsqVliIxGrHOdi6Ol
         FcBEhRj04dkfe9sD2R1gHyLb6s14UzRJ1UJb7wXANVoLMoChuf8knlQDNbjd5O2Uf+zI
         2009sAg18lhkFsUIy8/h3kJxaXlznTZJ+e5osAtVpcD75O+w2SyIGoqcXB98B4/Cifn5
         gkNA==
X-Gm-Message-State: AFuF++m115Tfyy1GYdfL9UK1FXRjesdHOJoPPYUGFqmk7h2dtvBOHUec
	2RtyTzoQhtIJ9atTwlrhsi10GIwTvqwbNQ0Rs34svnBUNnq5NZL6hQ7Y7GDuHu4pq5vDXRcpkYZ
	BRpmRq1I3EObg+9D6h5NAhyu6RATVpx0=
X-Gm-Gg: AR+sD105BI7GSOvw+5Y8zsIvyh2jupre8gSV62wy9afhOyzi3S7zlGecEUHDwONJQrX
	nK8ccGRdc1lE+nnXzcOAkhl7ma16KB8eU5R2iSwikjEl33KOA0KBmxBYzGMDn07JYBoDpgvQaF+
	hfhrXW7w62CCnE5PVNXQ3uf1ThmctfS/6BVI8ZhDpJfOxI2rSL0yYlAoCgTHw50RsvICKKm4c1Y
	07qm1TYY+zoZZOshWglmI2XfA7e2z7C9JIMEr0xdw4L/bGTXE+U+CsilMkDFmC7iqa3tv2aBD5c
	DRhrsYOEzKgxGZIHdoLobUO4x5EWeNYPVGYumhcZRFqXBhcBOQb7aq4qWAQdP6DjnWnbwrxqtu1
	Gr9UFvVRBUbMi+oigZHKe711ltUGoSiB+o7fQwYfbg4NEclbGmk9Uc32AEpctYJpuLq03sUXOlQ
	Zwb1TvUJcSoKVwrbKRG1TsKkeE8nQ3Ew==
X-Received: by 2002:a17:902:d48a:b0:2c9:aae1:a61a with SMTP id
 d9443c01a7336-2d5fd6fbe8bmr61261365ad.14.1787144009913; Wed, 19 Aug 2026
 05:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786103607.git.ben.knoble@gmail.com> <cover.1787065125.git.ben.knoble@gmail.com>
 <48fceb4b575ca39346cf2f59f621584a19049008.1787065125.git.ben.knoble@gmail.com>
 <xmqqh5krxnwd.fsf@gitster.g>
In-Reply-To: <xmqqh5krxnwd.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 19 Aug 2026 08:53:18 -0400
X-Gm-Features: AcwNN1W9VadYNP4MtLz2mXT5W1uboIgjOGoMtxmn-w1yndQnmLiry3B_cVAkbfE
Message-ID: <CALnO6CAZ-_k=+xTZwi-+s2aeKwgkoY5Z_iJjF6_sBDreKEsTaw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>, Tian Yuchen <cat@malon.dev>, 
	Patrick Steinhardt <ps@pks.im>, Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Patrick, the below probably helps answer some of your questions as well.]

On Tue, Aug 18, 2026 at 2:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > diff --git a/environment.c b/environment.c
> > index 6676e6f5ae..c7f6b801f4 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -571,6 +571,13 @@ int git_default_core_config(const char *var, const=
 char *value,
> >               return 0;
> >       }
> >
> > +#ifndef NO_NSEC
> > +     if (!strcmp(var, "core.usenanosec")) {
> > +             cfg->use_nanosec =3D git_config_bool(var, value);
> > +             return 0;
> > +     }
> > +#endif
>
> What this hunk tells us: At build time, you could choose to ignore
> core.usenanosec configuration variable, preventing cfg->use_nanosec
> from getting flipped to true by the configured value.
>
> > @@ -769,6 +776,9 @@ void repo_config_values_init(struct repo_config_val=
ues *cfg)
> >       cfg->ignore_case =3D 0;
> >       cfg->trust_executable_bit =3D 1;
> >       cfg->has_symlinks =3D platform_has_symlinks();
> > +#ifndef NO_NSEC
> > +     cfg->use_nanosec =3D 0;
> > +#endif
>
> I think we want to unconditionally initialize it to 0, unless the
> definition of the .use_nanosec member itself in the structure is
> conditional on NO_NSEC.  And ...
>
> >
> >       /* section "sparse" config values */
> >       cfg->sparse_expect_files_outside_of_patterns =3D 0;
> > diff --git a/environment.h b/environment.h
> > index e7ec5b0437..a35534afe5 100644
> > --- a/environment.h
> > +++ b/environment.h
> > @@ -139,6 +139,7 @@ struct repo_config_values {
> >       int ignore_case;
> >       int trust_executable_bit;
> >       int has_symlinks;
> > +     int use_nanosec;
>
> ... that is not the case.

Doh! I actually intended to send this version with a compiled-out
member when NO_NSEC, since that was the only path I had come up with.
No point in running around with code that's been asked to be ignored,
eh? However=E2=80=A6

> Which means that git_default_core_config() does keep the initial
> value of the member without getting affected by the configuration,
> but it does not necessarily be keeping "false".  It may be keeping
> the uninitialized state instead ;-).

[ugly #ifdef trimmed]

> Ugly.  How about getting rid of the latter #ifndef/#else/#endif and
> instead keeping the "if use_nsec, pay attention to nsec, otherwise
> only the seconds part" ternary?  As to the early part, as you can
> arrange cfg's '.use_nanosec' to always hold a sensible value, the
> function can become
>
>         return (istate->timestamp.sec &&
>                 (repo_config_values(istate->repo)->use_nanosec
>                  ? (istate->timestamp.sec < sd->sd_mtime.sec ||
>                    (istate->timestamp.sec =3D=3D sd->sd_mtime.sec &&
>                     istate->timestamp.nsec <=3D sd->sd_mtime.nsec))
>                  : istate->timestamp.sec <=3D sd->sd_mtime.sec));
>
> I think.
>
> The code you presented here for is_racy_stat() sprinkled with
> #ifndef/#else/#endif would be sensible if repo_config_values struct
> defined the '.use_nanosec' member conditionally.  But that is not
> what is happening here.

=E2=80=A6I now see a world where we could avoid quite a bit of headache:

- use #if[n]def NO_NSEC to ignore the config variable, but otherwise
- unconditionally compile the cfg->use_nanosec checks

That is, future readers/writers won't have to remember that they can
only use the use_nanosec member under compiler conditionals; it will
always be initialized to a safe value (either always false or from
config). If we're lucky, the compiler will optimize the checks away in
NO_NSEC builds ;)

I think this is what you are suggesting Junio, so let me see what I
can come up with.

--=20
D. Ben Knoble
