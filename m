Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9211FAC2B
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520692; cv=none; b=UqDoyNgsfNDaPgosyY3YtCRtal2ej4qycCiq1F1ePy3LXR63AAGDclnooQa62UBUU1Sbdv/YZPBBoi3NCuV/qLI2sXkjWz1qTj7B8QmOlPM5za4pqT5zTJZ1/CvNxrf7zBG6CA5/Qg8esLhRanSMJIwR8AsabnQ71E2YV3pMY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520692; c=relaxed/simple;
	bh=N1sUq1IuwHKR9skZ7qotfI1jzMdnC848PKBXQXFe3+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nq6USSB9/6j55BUGa+G07d7hbwiCJmBLItFggnzAQjijZ4x4oaCKvw6YbHESN43HtvWiRMiujWGUUVrT3K/bNTAOtFAL/J2rzEjSB2i1/SX6w+eE2Dg6DIvQbP02ldZKxbnMj847lC4aYUZPO9zBZ3U8w5QNdp7ZbTo3edYG1BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRt5sviL; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRt5sviL"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e5f9712991so2183204b6e.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729520690; x=1730125490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szp1k3PIe6sA2xzWBlSWkHLNx09btJyNn7fRD//74/4=;
        b=gRt5sviL9+Yd/rhFtAKmtd5VcCbgV9zTe8KlVhgBflqFtSnQqCQE/0B2o1LpNgEPi2
         KHVy7Kc59R+YEZoMU1DbC97KiGflNu+jLGkYt29j9XbZIIKo9w9q51i8H9xHEYspKcBX
         I9oVdZviZLMmf+uV0dg0KQe4Wb0QJGwzD6oANVJM+dxhmkH5cpMLUckWV2MvxLXxvB7+
         lsbd0LK71RyvNfe0tgQqkX7ydy8A9on9Ds1RonDmskvwpkIDbZoWkQsVMmIWjb4JfWMT
         8kCCql1Nh/ZLIO1F9dFJezelufasD9xCw4LbXzQekolQXOPx67C7GNMeawNhyvzhWDs8
         INaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729520690; x=1730125490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Szp1k3PIe6sA2xzWBlSWkHLNx09btJyNn7fRD//74/4=;
        b=WVMjJSFfrzkEpLW5J8vTBVTLA98s7CfV9gb/WR0q6biM8cT5pz8i22fp4jsxarDJQH
         Y7jTQlgRO6hHk1fMKfP0ApoaGr19RL8/f/J2aVVwGjokonmb/kcM3qJig3yYzMYVJQ7o
         UwxYHYiBV2tM2p9p4mmJcnT+RjOG31qpOU+XW+r1JfvShyApWQ3DHhe3RDR0kD+f9Mw6
         ItejAqYA7808JnZfo4jixQFqPppKgFm0dk1Xi5xXEQ7fLW5UP4vFAm2D/u7lZZF93v4S
         uMmp0OYdALPISSsA0KKqIJAX9rKfLZdZjHdXTOZpw0z7zicgxU7O6Wp8DIkwQkpo3mRV
         ctNA==
X-Forwarded-Encrypted: i=1; AJvYcCWXQ3eO0ehtrc718SdOCaqEOW4myTjRD3/2HdYdfenKBYcexSASjabbhK80AI0OoHBAFQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLA09aDsaHhvgAXxiCmnXFS36KyNb00sdH9GJuRYfSV/05KXG5
	4/b48SIGTnqv0nsW/hFMbV93YSSOt+dkJUSeB0BwIkdVxlrxgg0piJdXKZT5zATDq2TcOZaiPH5
	1IhZPw+SMQ5D1ywRvoGc6tC8flyY=
X-Google-Smtp-Source: AGHT+IE9JUgt1uxzBo/bC1rGR8pNCdxmi5k5dMdPW9cdXzvBtI6BhLdDn1c0dw7ppc8zsX5dv2FwFovvdPdbQcHHD9s=
X-Received: by 2002:a05:6808:138f:b0:3e5:de79:2d51 with SMTP id
 5614622812f47-3e602df5018mr8107796b6e.47.1729520689681; Mon, 21 Oct 2024
 07:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com> <5d58c150efbed1a10e90dba10e18f8641d11a70f.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHH-oHE7g09xIR@pks.im>
In-Reply-To: <ZxZHH-oHE7g09xIR@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 21 Oct 2024 14:24:38 +0000
Message-ID: <CAPSxiM_BCz2n-uOOSRk3AsVp-Y7R+1XNfVRt6dH6=fWVBZ6cBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] merge: replace atoi() with strtol_i() for marker
 size validation
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 2:01=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Oct 18, 2024 at 01:52:59PM +0000, Usman Akinyemi via GitGitGadget=
 wrote:
> > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >
> > Replaced atoi() with strtol_i() for parsing conflict-marker-size to
> > improve error handling. Invalid values, such as those containing letter=
s
> > now trigger a clear error message.
> > Updated the test to verify invalid input handling.
>
> When starting a new paragraph we typically have an empty line between
> the paragraphs. We also tend to write commit messages as if instructing
> the code to change. So instead of "Replaced atoi() with..." you'd say
> "Replace atoi() with", and instead of "Updated the test...", you'd say
> "Update the test ...".
>
> The same applies to your other commits, as well.
>
> >
> > diff --git a/merge-ll.c b/merge-ll.c
> > index 8e63071922b..52870226816 100644
> > --- a/merge-ll.c
> > +++ b/merge-ll.c
> > @@ -427,7 +427,8 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_bu=
f,
> >       git_check_attr(istate, path, check);
> >       ll_driver_name =3D check->items[0].value;
> >       if (check->items[1].value) {
> > -             marker_size =3D atoi(check->items[1].value);
> > +             if (strtol_i(check->items[1].value, 10, &marker_size))
> > +                     die("invalid marker-size '%s', expecting an integ=
er", check->items[1].value);
> >               if (marker_size <=3D 0)
> >                       marker_size =3D DEFAULT_CONFLICT_MARKER_SIZE;
> >       }
> > @@ -454,7 +455,8 @@ int ll_merge_marker_size(struct index_state *istate=
, const char *path)
> >               check =3D attr_check_initl("conflict-marker-size", NULL);
> >       git_check_attr(istate, path, check);
> >       if (check->items[0].value) {
> > -             marker_size =3D atoi(check->items[0].value);
> > +             if (strtol_i(check->items[0].value, 10, &marker_size))
> > +                     die("invalid marker-size '%s', expecting an integ=
er", check->items[0].value);
> >               if (marker_size <=3D 0)
> >                       marker_size =3D DEFAULT_CONFLICT_MARKER_SIZE;
> >       }
>
> These are a bit curious. As your test demonstrates, we retrieve the
> values from the "gitattributes" file. And given that the file tends to be
> checked into the repository, you can now basically break somebody elses
> commands by having an invalid value in there.
>
> That makes me think that we likely shouldn't die here. We may print a
> warning, but other than that we should likely continue and use the
> DEFAULT_CONFLICT_MARKER_SIZE.
>
Ohh, I understand. Philip suggested this. For the warning, will I just
use printf statement or what function to print the statement ?
Also, how do I test the print warning statement ?

Thank you.
Usman Akinyemi.
> Patrick
