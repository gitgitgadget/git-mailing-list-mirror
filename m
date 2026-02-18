Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316272F3C37
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771413771; cv=pass; b=SU4Xr+wz0qvoc3EuAXwJqhxvMuRd99yuxcpmB9b1jj9/EWmzANjB2/FcP5uZjjVlYCOKNmyVvminRjoKL34NbpxrTac7l+tMC+shdhGdEdmWo4dDjDs6aBvgrFUVXDag1CYsNRHRTQJVg+8yEyNuQD6TJKv35H6GJ3NlzWSZQ9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771413771; c=relaxed/simple;
	bh=OGXPasttwJ4yVdGODygXaXuS+hw17bOy8FT2J2tK5Ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPr7YuAJdtAQBBb7nunanXSKD4fyPbwcNr59X0bHMZ7s1ZLMIvShMw7GsRYUqJWSXqa/tExTMiBeL68HWfabckWEf//EhAYo3Zh94fdEKdzJYCp+8u2reD8+nX0ELo7bl+vyf5Y+an7K4GdqcBtzmfW+5bsQ20Jqtfyes8jRZXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUx9N1qm; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUx9N1qm"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1270adc5121so7007735c88.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 03:22:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771413769; cv=none;
        d=google.com; s=arc-20240605;
        b=W5V0zvKRBzojTCT1ctJQniz9vO8cd4Z1Ma1797ZFyammQ2Bf5zlCamkf2YCKT/rIlq
         Gf7aTDIKev7CyUmH62L4vGJSa/EH1OYHtYF0QcJlclbE6iYZEAjHTkV9RpfdBOLLQEX6
         Alanxq5OJ0taUMdKSvd+YTQqlZyc1fL1aVFz1aRD49O8Bc4Wug+mxtL+L+cfBAjGvJIh
         gN1heAktNkVPGsX7r2R1qq6JrO8jgVONLmprKsf8fMsi22IMglEG+V9kznHEyCi+R8D6
         dLt2zq73fZQFAM5PdVcplK9zZPVwfxMB1oy1m5UucmQs9yXTorUyTGSNwAn0EUu04dti
         aE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=98LicJbl+l8HKJH5yNcHQjCetiV1Ks8JQr222j1x7yw=;
        fh=3kDaN1RzHVHXX1/4YCNikCm05ppKjk69f2Ezz9v8v9U=;
        b=huekQ3HawSll6wpciJ40vqphzTEgnG+pZyeXdDkA9DUhqPkhTaJmVehlpE1L5gHZco
         3fNqdRf736nFY/MKxuwjB470YAUL13ExlMcxhNM32lyZnMj6TiUlRk+ln8rW0halUsF0
         qkArdsjhWo7EbGYy6rFdoKMQ+8LzMjybIKocPXQBPPQx3qx6N6CvQL3/hiiWgq6Ol7Gn
         QKclSXJQ+BOWVtUAoQGSQ4EhoVtx4HwRmlq7egNEzSCfJrrJxTzF0WC6CvwqPlYLhkQH
         DPiklr/B9qFOxPE5kOPSl5c4CCeT8524/UgxItpHakGzHg3ZydfEyMt+QsqfCiCosned
         uLfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771413769; x=1772018569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98LicJbl+l8HKJH5yNcHQjCetiV1Ks8JQr222j1x7yw=;
        b=DUx9N1qmo20650MgPeXc3xym75TRBFS4vW6Nbwu3ZXing7/ORplgbZ1nietqJK4MMS
         eBszX2dkV2BNT7Asu6xqP8kaQyqwrSpF/oRWpvS9vztgAlgQnrxf5lsSzLHJrbBTXqCQ
         IhGg+4xNbhPCV7K7kmQOzwIM1eBTJXhbPjjo1+Obd1WbpKLmBy9Tb5txXK0+AyKhHPZy
         8JHSJi2yZCjIzIHG33YMFIxs3GPF+pkfE4Dmk5A5IBC38kkCRS64NHpUMFxEanNEG52v
         HOBN1r9kXBK700nDo6dNoagNwGcNLVFewIJFwTTCy/thn6uVa9ZxhyPKWok3hAzrXo05
         SZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771413769; x=1772018569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=98LicJbl+l8HKJH5yNcHQjCetiV1Ks8JQr222j1x7yw=;
        b=ed/0roTABb+yLKUG+dtWp5BCdHUP++3ZIkzQp2YyGI9iby4a8tf3ooLwl8OOIz+WYq
         kCViPcwFiaphHJoGsL3oQvEI6BJZ/h4DynbxKYhT3VlXgJYC3R4nelA6zyRcxY1CeOzD
         rHIBqy0GWk8QeBHHRsM9cd60ERuK5VuRKr3iJdlSQeLBO7aCV1P9LT2AiF+ysYsq0Hhk
         CixmgqQp6YQQRD5AsqFGv26d3GG2IiIyrXXFQ5C6APzCP29kxLmS9UCaKoAGZiuebNev
         w5sZg/W/xFBfg73PxXXRw2IpK9mJkpeDXmjnnvX9u3ycEgnAC90RH0MjeV91w5btAW+Z
         MPbA==
X-Forwarded-Encrypted: i=1; AJvYcCUMe3DB6r29v/qb3czSxChfvGsjUs+heHaJ3MRnkCV2enwIwnhp42Vi78bMOOFcjRLv0dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySKTtLLlzLU73EExbN0xLCABQLnYgVgh3tod0+aF7S1EmSwotJ
	U8uxZKM9VjWUcdB9F9OJhAGq+xKtzLsKOezx1IusXj7Szk5+qODCB7E1IdCviA5lStRJBgWcfhp
	myCm2x6nGKBDCgJJodUyajv9u4Gdax/A=
X-Gm-Gg: AZuq6aI63NXu3e3yLIrqQJ0WDNROOENFhJOcpYsSJmsIPk609j+nqmzkVGQW43sQUzD
	zqvCSDbcrsAO3lVGR0SHjNW9ngnD5vDL8RgQNfp1rMHAt2DSzhVogf6ncZMXAofvTKW3L2mUnsU
	nEB83F8ImpNB2uo6EYtgofYqrBSRavRYzC2E8+ZM2Yo6r3Na7ZtODxlylfI207q3DqIrvkOkFbO
	8oIb6BKnDyABd6O8UZcj76BvQJu5xSTID6U/iByqf+Np6o4GNaqoCdwq2bAx7ffe4FVOaoRb2jw
	ZTVN2q48mEHLMhP16rydyA==
X-Received: by 2002:a05:701a:c94e:b0:119:e56b:98be with SMTP id
 a92af1059eb24-12759a6a559mr552278c88.37.1771413769101; Wed, 18 Feb 2026
 03:22:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215112331.22-1-kumarayushjha123@gmail.com>
 <xmqqpl63b2tm.fsf@gitster.g> <CAFNBzOdqOLKFbDFCp99GvXYWs_Af3PdeXQMjE92y+s92j78GYA@mail.gmail.com>
In-Reply-To: <CAFNBzOdqOLKFbDFCp99GvXYWs_Af3PdeXQMjE92y+s92j78GYA@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 18 Feb 2026 12:22:50 +0100
X-Gm-Features: AaiRm51zKAz97l7ogzgZjTgRUcPUq1LBmnuTI3vM3G1B_vNSAgJXFtlOcs-Zy8Q
Message-ID: <CAD=f0L-nUS1N-P2cWM9AwOFv+G7dOBgGjWwEZYP3qSDMxyhGgA@mail.gmail.com>
Subject: Re: [RFC GSoC PATCH] environment: move core.trustctime to repo_settings
To: Ayush Jha <kumarayushjha123@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Feb 2026 at 12:04, Ayush Jha <kumarayushjha123@gmail.com> wrote:
>
> Hi Junio,
>
> Thank you for the feedback. You are absolutely right that the
> lazy-loading approach regresses the user experience by delaying
> detection of configuration errors.
>
> To address this, I propose parsing core.trustctime in
> prepare_repo_settings() in repo-settings.c. This would ensure the
> configuration is read eagerly during repository initialization,
> preserving the historical =E2=80=9Cfail fast=E2=80=9D behavior where inva=
lid boolean
> values cause an immediate fatal error.
>
> The repo_settings_get_trust_ctime() accessor would then simply return
> the pre-parsed value from r->settings.trust_ctime.
>
> Does this approach sound reasonable?
>
> Thanks,
> Ayush
>
> On Wed, Feb 18, 2026 at 12:44=E2=80=AFAM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >
> > Ayush Jha <kumarayushjha123@gmail.com> writes:
> >
> > > The core.trustctime configuration variable is currently stored as a g=
lobal in environment.c. This prevents it from being repository-specific, wh=
ich is problematic when multiple repository instances are used within the s=
ame process.
> > >
> > > This change continues the effort to move global configuration into st=
ruct repo_settings, as discussed in
> > > <20260208062949.596-1-kumarayushjha123@gmail.com>.
> > >
> > > Move trust_ctime into struct repo_settings so that it is associated w=
ith a repository instance.
> > >
> > > Add repo_settings_get_trust_ctime() to lazily read the
> > > core.trustctime configuration value, defaulting to true.
> > >
> > > Update statinfo.c to use the new accessor instead of the global varia=
ble.
> > >
> > > Signed-off-by: Ayush Jha <kumarayushjha123@gmail.com>
> > > ---
> > >  environment.c   | 5 -----
> > >  environment.h   | 1 -
> > >  repo-settings.c | 7 +++++++
> > >  repo-settings.h | 8 ++++++++
> > >  statinfo.c      | 4 ++--
> > >  5 files changed, 17 insertions(+), 8 deletions(-)
> >
> > Doesn't this regress end-user experience when the configuration
> > variable is misspelled, e.g. "[core] trustctime =3D bad"?  We used to
> > run git_config_bool() from git_config(git_default_condfig) fairly
> > early in the program, and would have died before doing anythihng to
> > give the user a chance to fix the configuration files before going
> > forward.
> >
> > Now we will run deep into codepath and would not notice the
> > misconfigured core.trustctime until the code happens to ask to
> > compare the filesystem stat data and in-core index stat data.
> >
> > I think this is a recurring theme, e.g.
> >
> > https://lore.kernel.org/git/32fceddc-c867-4a47-bde8-c873279edbc1@gmail.=
com/
> > https://lore.kernel.org/git/a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.=
com/
> >
> > That other topic Olamide has been working on seems to have settled
> > *not* to lazily load into repo_settings to avoid the problem.
> > Instead it reads and parses at the same places in the code path as
> > before, but into a repo_config_values structure that is associated
> > with the repository in question (which typically is the_repository).
> >

Hello Ayush
Thank you for your interest in this topic.

As Junio pointed out in his response to you, I have submitted patches that
settle not to lazily load into repo_settings. but instead to read and parse=
 into
the struct repo_config_values structure associated with the repository.

I will continue working to move other repo specific configuration variables
in environment.c into this struct once these patches have been accepted.
Thanks

Olamide
