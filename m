Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173315666B
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822294; cv=none; b=eTJFACKOb00Snbak0pQmojvXkT2TvzEYtgQ7ZCmTt2TUwLS+LsU6TSUnodbczPRAvCS1+0PSJ2GCYUyDvBmaZbp/M+ZxTYQyFdOZRP6gpoydvMccMbUYuYv5ZJoLmjMp/Ec14Nb9IurVSoOwORaOHl3bseONKhSlsaguHVRC7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822294; c=relaxed/simple;
	bh=qlKdxTOomqzQ4mkIt8YeSu9mghoeEBZvyVdWH1VnwVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnE2s5PAhrp0qgoZ2r6AkhjLN5lAy2PgPJK/9+UL1Ub/6zwSTA7RZ883DjV2iF2C4enwc+o1SNYYw92FponS/BKCjxrsXbeR7VxFxgHKxyfMuFOq0CpjWg6U9N+GZJ2I28JPh1klqgN8SJ3bRQYKYHxhZWQxP9I1kyMhRE82vCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gj2gKM+j; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj2gKM+j"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476b89782c3so49397701cf.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 06:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742822290; x=1743427090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XirOL+iIRIpv1TznkDejdIMYd6xa55uqV6sPCq6vYVM=;
        b=gj2gKM+jjx6tWsyV3J8+DECXj2XWd2Tj+u695JwOZq6ym7TlzOKdo6cGiyADLNnbUs
         iF5oGAHeBxcFVn9WGfVCFmb4jJa+t2FvYMBVm7dWbsJiF6mrYyvmvDZEFgjXff6sTI99
         RGlpl6jus8/hincaiO6SylwmlIrcai0VOpaY3uz2qfzqkwRHoQSVS5kFcQEjuS67Ua6X
         BLnHISOwHDhD0tv7YHUlH6NzPbkmi8o2dGw8gMgW8QSDbNToMDkkQKxJJ3IJ2zuB0VdL
         Iu9hB/h2ZPKR7HdhKsPCJSs9/s9Rdga1n0n56df3LKiXLP89itJauC8+GKot78CBcJAM
         TT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742822290; x=1743427090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XirOL+iIRIpv1TznkDejdIMYd6xa55uqV6sPCq6vYVM=;
        b=Hhansgj6ANPNUGjPd96yV9Xc1Oq7wruQL6lYRxYxNJVyYmgTFnGH7C/9POPXpwkKmm
         EVsqibktGgIe0xSK6S5lurquQ+SSJs4hrbKiBaBbUzKZbJ8tSsiIfOWMQiTkHjMuSjAu
         9DMIRjtVi9DBCy4ivYrIcfUuUpC/F+JXkJ9mtXg5tozElfMRkXWifr/D4i2Nh7R5tDRH
         59lILT0nDIh/mUth4+ZXPSI6tUOtMgBwc3dCkFkuAnGnV4A0sgtJ75PqPNJh4I7oTpS8
         iVCt6TPGSrS5DEfvh6B96esPkHPh6iCmwoXcCsbKHM1DXWLAVC8acAYR2uNEbkE9VZud
         ivKQ==
X-Gm-Message-State: AOJu0YzCF6KuOG3NskeV+7Lz0rdLe42s62BjXCKQxD7DywtnNiBVUa7t
	ZdoOfF1HtGW/ptQC61n36/RGlxnB7RnUh06+0R0Fy/PL3cCxByyIl8oNWeyCzCBBDINUNB1ByO1
	IfxDvP4614U62aliIlIAb8BYBOn339yVR
X-Gm-Gg: ASbGncstTiCuY5G30AvNesc1S+Ai20OgHRC1EUvmLUhBiX9rBeyxXvyuB6u11s++LwV
	M9ushvaNzJAx/56dpZPDM2N52MlIwJWzWHloUzGPYCtA8luCs9e473Mf2lL0q1GTxssHqNuUYp+
	cbWrIVH80kanbAzNPNO1tnNI2eV37V9dnjrch8Cpf/AKLd9eucC2eRUNhc1cg=
X-Google-Smtp-Source: AGHT+IEHJlmHwjSE9ROGiy+q3cjl4tcMf4tta47P80DMYkIhrcTeJvs0AUCGwj64pz/aBufv0bCXGhe7BbF8sul73Ww=
X-Received: by 2002:a05:622a:4cc8:b0:477:ca3:4b66 with SMTP id
 d75a77b69052e-4771dd8037amr203345941cf.12.1742822290366; Mon, 24 Mar 2025
 06:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLdvY+JdgdzgE04EJoF9KGUpd39+2S_AgpFyucP38mdFgA@mail.gmail.com>
 <Z-FIkHiyGc0jnHX1@pks.im>
In-Reply-To: <Z-FIkHiyGc0jnHX1@pks.im>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 24 Mar 2025 18:47:57 +0530
X-Gm-Features: AQ5f1JqJOJ_n41jcIXoauR2nmzGsPwZMXV-jlwamEwBn7vPiwu9EsEiphSjlvPg
Message-ID: <CA+rGoLf81GjsFfxVfwAXeTJ278wcH2nj8HgrHQJcDhZwyK9m-Q@mail.gmail.com>
Subject: Re: [GSOC] Machine-Readable Repository Information Query Tool
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Patrick,

On Mon, Mar 24, 2025 at 5:27=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi Jayatheerth,
>
> On Sun, Mar 23, 2025 at 08:20:18PM +0530, JAYATHEERTH K wrote:
> > With GSoC proposal submissions starting tomorrow, I=E2=80=99d like to
> > understand more about the procedure.
> >
> > As part of my microproject, I worked on modifying tutorials where we
> > create new Git commands[1]. I also have strong experience with C and
> > Shell Scripting and would like to contribute by developing a dedicated
> > command to fulfill what git-rev-parse was originally intended for.
> >
> > Could you provide more details on how to proceed?
> >
> > [1] - https://lore.kernel.org/git/20250321143022.5406-1-jayatheerthkulk=
arni2005@gmail.com/T/#u
>
> all requirements and steps should be listed in [1]. There are two
> mandatory steps:
>
>     - Finishing a microproject. You have already started on a
>       microproject, but as far as I can see there is still feedback from
>       Junio that hasn't been addressed.

Yes, I have a series of examinations going on making things slow from
my end, but I have addressed the feedback and will do if there are any
more further down the line.
>
>     - Writing your application. This would be the next step once the
>       microproject has been accepted.
>

Got it.

> As spelled out in the document, you can optionally also help out on the
> mailing list by reviewing other patches. This is not a strict
> requirement, but getting more involved with the community is a good way
> to increase your chances of getting accepted. You are of course also
> free to do another microproject or search for any other areas that you
> want to propose a patch for.
>

Once my microproject is finished I would love to help review other
patches and work on many other microprojects,
As I previously said I would love to remain as a part of Git even after GSO=
C.

> Thanks!
>
> Patrick
>
> [1]: https://git.github.io/General-Application-Information/

Thanks for the guidance! helps a lot

Jay
