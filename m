Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A133033EB
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771412690; cv=pass; b=h+DByhSJ58/ddElhmrkYIAyDGH4A6wpYizm4oonJymiwuV+YGM5r5kZpApBjwhCAOnB2Jc3yq2i4XV585vh6rJpacHGwkFn4ILlriN8nWS2XciaSIzce5I4FHr6RKNDRDtNpK81ZwnnKb49PLMrnzAc3lMB3lEZ88fR0zJadV6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771412690; c=relaxed/simple;
	bh=iZjGm5srEqZcus94yquo4FwZYahDkSbv10OrDrmGfwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaaLete94F7Q4Wwv+93M5FRqL6zvowpPPb9IuXl+jn/QMdJOmAw+CzqHWz5oMDHOsIyMZd406k0QEjiawyECK3HnzaWuFcoXn8br+8Hf3u164F17/pBT2VsUULMCs6B7hw/kDr3smz7dmICFnLboi9KVnLKi1Au77oglsH8SbOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDTgphSt; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDTgphSt"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59e60b3ccdfso7337517e87.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 03:04:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771412687; cv=none;
        d=google.com; s=arc-20240605;
        b=Hkfv5s75C+UHXsecG9DkDD/5JHQRug+c3ogEGYmIg6jxCzQEfyGqM0yZyz27Q5iSsc
         /HqbjGko/5HkXUdBhU/QbGnmEaZivHOIzxwvmO4K/yLiMq5A5+lK0U2g/gthOt2nIpsD
         b4xjpKCCH4t74msYdzgwdgPkoQoomsHvaSpDlBNlzT5O/INkqqAeeRyKdqY1uU2jELdy
         feGkl4I1Tt6U/RT5GfkwmdMkoZTTnkLoAyyeTDo0m7I+xJxGayhy7t2eR9GDVjTixCPV
         yBlnWueMCoXi1XilIjBO2PN70eOQt6CQyYrSmJVLDu0EVok8z3NOQq7JTYwPklLVR8CT
         xFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D8clY9t0gPG4NabvLOKk8i//HDvBthqlg7nsXhviuC0=;
        fh=7uvuE6xsmSclN/4Ko1+xG4bNyJHmTeVrsQmntIIA8U0=;
        b=DiuXGFIO960qMfiCwZDyA/nv8FBX2WnAm0K5PRW9MMNv1saG9MLHMuzctbCB1Ht7NK
         VCrQJ/qQcwTbuCDp+sevTQfyZlcG3OQTW15a1RETNBdsTvwl0xXQbMhOfztsoySqPqMG
         u9JDN/JZCvHnMhGyRFPqJ6KbsnXhWTQnHuH5HWOxLXByL7oMT2PqzkAfHGklsteTxkGZ
         UBt0fcm7zZMNvQJ6q+j/EejiKrvZdkSYrvmmd/rcymtg2FzLve1wqKRUr7quvQ0LI7jr
         ZBCDC+5TlcrmIpAZj3PbCiN8vx4/lOD2vxS2sxEnxwT6CSzDt4YaID0GvPiqOBjFFa8C
         tBRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771412687; x=1772017487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8clY9t0gPG4NabvLOKk8i//HDvBthqlg7nsXhviuC0=;
        b=CDTgphSteMZ/CVPp66PqlRKZFKbwQYBMrW/huuJCAdox55LRTOfLSOB7jI3XOcru/a
         yM2nuUqLb7wHjGlTy9qKAcra65hmzKS7jKRutF2taV2IL6ZQ50ynxeKzZsUrrLJrFfbm
         UHAarO1Mie216S2zAw51I30SmnAZCaOn9ogsFxpU5yJM0036+sQEPcojSayG9SXA953K
         f+I4ndkJ7N4bfADL8uMEu+iTIojwbtl+A/jHFImCwIfy0auKDOCB05ZL6CC/NuauiynF
         SrOlBbYhSaV7/NEmC9XTPf/8Ix4ZFTcPt4pUSwsd/i6hH/ePwfQgz2ArNKpVv4xKA/iG
         nP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771412687; x=1772017487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D8clY9t0gPG4NabvLOKk8i//HDvBthqlg7nsXhviuC0=;
        b=ml90pCboyp6MO7kmjO1AF6DtiH1a/Edou5sHmtCpTl+EYd5FFxZAYPMxXYYKIupUsk
         Eq/XsVqZLakbly35SXvMxfMwci1TI5XFibH3qICSvLEK+g3KAzwSasz9P3tFWDo7GxjJ
         Eo0LTDAEkknF5RiUhQvWw6vxq1QX6h9XqSZEHKZW9SeFZjMp+XrpQqjn2lQ1TAW+NTLR
         tLPbhXjPvv2Aw1MrEqctH5gTSoADA3kkOebzpiz7nV4Zj168U+rlWLXcDSe/EP8LUIhs
         LW2CaL8mmi40gwuyAgjyU2JPO+Zqs3Tf39aljiBroujS/9cZL1Rv9LiI9/rhWQXlJebc
         6n+Q==
X-Gm-Message-State: AOJu0YwWtt4U/Cz0nvIhKlXTRoVzYb8PwykAhDcd9MTmSpzNxDDxyf+W
	6oGM2kE2yXSPaimaauB80nwC8P3E35iTe47pGmOJYbzp/cjN9stZol6J1Sy1BlCscXamGjEQEPv
	BKZlQsd1yQAfUXsLJ95YZY79hwO8GRiY=
X-Gm-Gg: AZuq6aIPx71ZNyPVpLAohxWLRbOwqFxcmY5qQS74RoXpO7EDVMi6/PNV2CgKcj1z10m
	fXipxY/T9cfyoJzzKgoAR28sSuM0z1+gseOgdiH0wU+zvFTTHsBqQqEzIiw3ECpGTUxzWk6Iqzy
	XAuMSaVWlyuYxQphUGjLM4N6jat21jbic8gJdtAKbUehhK7pgJlt+SlSCY36pmYF8tn9nC1UO7/
	TBS6gLQh+XbGJevGQuh+e9js1GMBrNTPdrReehtdxNwOGToDacIygOJkE19jHc2+L90F2OCKGP9
	Ljruzpu5DmEoRAjAv1HBjk0oEd8nsJ3n36kv0g==
X-Received: by 2002:a05:6512:2386:b0:59f:6c3f:bcb3 with SMTP id
 2adb3069b0e04-59f6d378694mr4723756e87.32.1771412686877; Wed, 18 Feb 2026
 03:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215112331.22-1-kumarayushjha123@gmail.com> <xmqqpl63b2tm.fsf@gitster.g>
In-Reply-To: <xmqqpl63b2tm.fsf@gitster.g>
From: Ayush Jha <kumarayushjha123@gmail.com>
Date: Wed, 18 Feb 2026 16:34:34 +0530
X-Gm-Features: AaiRm50IHxVEWGUIpMXD8HvwJ7BtYOE8YM7N7IEmD55-3nmPMkdjXdIEk1kaY48
Message-ID: <CAFNBzOdqOLKFbDFCp99GvXYWs_Af3PdeXQMjE92y+s92j78GYA@mail.gmail.com>
Subject: Re: [RFC GSoC PATCH] environment: move core.trustctime to repo_settings
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Olamide Caleb Bello <belkid98@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Thank you for the feedback. You are absolutely right that the
lazy-loading approach regresses the user experience by delaying
detection of configuration errors.

To address this, I propose parsing core.trustctime in
prepare_repo_settings() in repo-settings.c. This would ensure the
configuration is read eagerly during repository initialization,
preserving the historical =E2=80=9Cfail fast=E2=80=9D behavior where invali=
d boolean
values cause an immediate fatal error.

The repo_settings_get_trust_ctime() accessor would then simply return
the pre-parsed value from r->settings.trust_ctime.

Does this approach sound reasonable?

Thanks,
Ayush

On Wed, Feb 18, 2026 at 12:44=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Ayush Jha <kumarayushjha123@gmail.com> writes:
>
> > The core.trustctime configuration variable is currently stored as a glo=
bal in environment.c. This prevents it from being repository-specific, whic=
h is problematic when multiple repository instances are used within the sam=
e process.
> >
> > This change continues the effort to move global configuration into stru=
ct repo_settings, as discussed in
> > <20260208062949.596-1-kumarayushjha123@gmail.com>.
> >
> > Move trust_ctime into struct repo_settings so that it is associated wit=
h a repository instance.
> >
> > Add repo_settings_get_trust_ctime() to lazily read the
> > core.trustctime configuration value, defaulting to true.
> >
> > Update statinfo.c to use the new accessor instead of the global variabl=
e.
> >
> > Signed-off-by: Ayush Jha <kumarayushjha123@gmail.com>
> > ---
> >  environment.c   | 5 -----
> >  environment.h   | 1 -
> >  repo-settings.c | 7 +++++++
> >  repo-settings.h | 8 ++++++++
> >  statinfo.c      | 4 ++--
> >  5 files changed, 17 insertions(+), 8 deletions(-)
>
> Doesn't this regress end-user experience when the configuration
> variable is misspelled, e.g. "[core] trustctime =3D bad"?  We used to
> run git_config_bool() from git_config(git_default_condfig) fairly
> early in the program, and would have died before doing anythihng to
> give the user a chance to fix the configuration files before going
> forward.
>
> Now we will run deep into codepath and would not notice the
> misconfigured core.trustctime until the code happens to ask to
> compare the filesystem stat data and in-core index stat data.
>
> I think this is a recurring theme, e.g.
>
> https://lore.kernel.org/git/32fceddc-c867-4a47-bde8-c873279edbc1@gmail.co=
m/
> https://lore.kernel.org/git/a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.co=
m/
>
> That other topic Olamide has been working on seems to have settled
> *not* to lazily load into repo_settings to avoid the problem.
> Instead it reads and parses at the same places in the code path as
> before, but into a repo_config_values structure that is associated
> with the repository in question (which typically is the_repository).
>
