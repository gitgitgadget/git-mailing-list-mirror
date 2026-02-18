Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE5D2FC890
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771415150; cv=pass; b=kQMJWLkvmjlKywaSAcTxd5xzmNZ+ITVUs3P8kSc1/5TVqBAkYos5TIjI9wxkKfn/A3pghtBesyPC4V4VSNnETAfpjrcWL4bKEzx+0d9BSJC4eiSLsZqDflrcvdVr0zIkhlfpSP3F4/vtgmUp9uPccFkVgsmLRlqwm1VB2CALAic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771415150; c=relaxed/simple;
	bh=GLWRidvbFUv0c9vQi7YJeJiialGdJ+TsrvtAQPijIwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzIZURla3HuShLCQQsoN27kJXUJsUyAONPF9dmsMDEz8uRbBGCnzgtnmnpAp/8oORTUypXatgNISs0J31X89QenXSAUejPPiM1sOvb2xCEFCAOht5M99wKUvp2YbsCPETLSicax1O654jJ1RU0R8lH+3eavko1hi5M9uHcf5nOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsVbJB83; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsVbJB83"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e646a4b9eso5640354e87.3
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 03:45:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771415146; cv=none;
        d=google.com; s=arc-20240605;
        b=hxVu0ETpraJQnHwxz8Clt5c+9R3c1Cxvtg7544cRRsQn4/S9XkTB0YtJVAi56xDB2P
         mslCOAiHrNtl2lPtQb/Lv2IsB6/bEWWEitKR4iXO0LodGTL1+WVzjlz4IYiqLz2gcgP/
         Me2A3YMdpWvyMvtYk9RXk/Bz1Z9Q/wMuc3QmETRmb0zoHzJV0UWojQ7s7ZGZ4V29K/Ul
         xjU0E+eKBzTtTidXiARjFnURPpmm544RUQXy4eEIbumpYzP4wePlrro80gLNzf9YJLlX
         Ss495fiLV0OlWQqKriEB2Pmn4PVvB2NG3/fnIW0OEFQt67P7k3Y/POYoUvyta/MeZq9S
         172g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nHdJO+hBYCYEG5bP4rNZF+nKpTiftw545WaUQDNrCoU=;
        fh=jPktEwmwXA4p6QOnmqCcKFzATMKcWR56dYVENRWIhWk=;
        b=PSZ4ulmQgbf9l0MxTB/ge7gPkeQYGkg7TbdHiwGMWze75weLkJvkbDXxFstJxpuRBP
         RGBHnDOgROE3xpMC4/yBzGUza1uZeJ5FoR3HVtS0nhoN81jCcnWRJjAiz0picfQdLz7l
         uLKXnp59koOEt8RQhlrXwVLLH1zkNYGMZAr4GSWsTUK0aOkTRHikJ19dQlLQJCQk/7Eg
         qzo5CMj4tV5gw3e4Ggc18+iyZqw62be37THAHn6p5FqZ1whC+0wtjxujVqvjSG0bLeys
         o+qFwB5nDWIEExm9qYc8V4NxE79J9y1K4++8Wg+/ha7jB569IiE0nc8LGuYqPknmsK/R
         ydVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771415146; x=1772019946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHdJO+hBYCYEG5bP4rNZF+nKpTiftw545WaUQDNrCoU=;
        b=LsVbJB83Qn5t0f1vZiP405kHmgJLQ1JCa34rLyBV1IwvLcYvO3Louy0KdY0lNb+NvM
         Dp0UHzt0DmcP9Evv/huBJqNpw18JqQLGPINfJczHJ8dqhl0BbZsCNmrCkwIGgLov+OJ2
         Tt8LBFwmlLYRsiOr04BJWg+4TcUQeq/7U7wPVtlT6KaZw+D6svqiCo/4qysE7CqcKU1J
         pD9crBK8CIpsNEVc5A0wFPUDt+hzlbVlPcd4qk3H+yKrgZxFkzYZZGDFJ0Da+fnTTgL+
         IoXRHzTWxxV3jWBpY+X/B879Qdf+/Q1sjoYQ3kTYjbnMNKHbLjz4UV30+BdT4WaTsGNH
         2bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771415146; x=1772019946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nHdJO+hBYCYEG5bP4rNZF+nKpTiftw545WaUQDNrCoU=;
        b=IQWrRzFDeIaxbC2GSn6tJHSetB2wO6auzjgONsZaNcQ0S5+2S7ozZ4Az3xzmIZrFZ4
         FhspMgJXC23kQbb/nVjFxe8s0TWPSHLdRn+vIOEbTRAXAaiUgn8Z3oqQVG6FrPvf3ZYK
         ZyLQ00Jb8RE7cHVVIFgNiRyhEJc5lcI1x8zfb+ElpD5WONr3fdmUV2libz0cPaCwUsNi
         xoGHyfFgzauxiqdHt9mnOHR5oDiOreIlIjpSjO5CRKbUfdV9GqEg4C2PLdMFhSWqmp8R
         icdjTgf44Cbz7MltE3TVaz/uhWxMAmKvhh9yOlIV9CtIDlyuIVNQKqtGgEveHtKjAYOE
         auwg==
X-Forwarded-Encrypted: i=1; AJvYcCVpBK1uNHBmj0/dMRJdvBHSTbAQ5Ghvp+uaCokLsqFMALk5PJpIx3qLZKU/WD5Y0OlOVa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5vu9LjCiSpjLerRjPqSHGs9pawqTTb6jU9Dnd9QRNmO0ODA2u
	F8UC+aX49ovSWOgH3Zsw0+W1Q5zekfJHhBDthY6ahy/JRIBYSG/jOYVUgwWqAEIgaZLglEWPz61
	tP0fn80ByXUVTDDGBepvnTw77ixy8S9E=
X-Gm-Gg: AZuq6aKFZqtESrbn7Mm0/QYdPNpaXu2wTshxModb+EhNUilsQ/9sFfUu7ArGnjGwhh/
	yOyFME5RXZQfI0yAnsX31sswTGwR7v22zFkbJABXruvD1qqjH/U7PZ+iroiXYaPXW7jA1cM7RAN
	Deog7pRG9oG93buoinE+JiRa0h6JdDN3ROngi1A60qFyVxBKvGkw9xdYxGJNYvVwUKJBNSBxZ0s
	pYTNcbVNK72EEwosw1mOYXvAYlQ2fEw5G9hVlmFS6OWSgY4TbqyRVMCLNOsreE193jIKyhuLF1D
	k1C7XroFTxq27FeNZmVUCdzcaHrR84XGM9KRYw==
X-Received: by 2002:a05:6512:b86:b0:59e:5b5a:c9b3 with SMTP id
 2adb3069b0e04-59f6d353df0mr4432939e87.12.1771415146273; Wed, 18 Feb 2026
 03:45:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215112331.22-1-kumarayushjha123@gmail.com>
 <xmqqpl63b2tm.fsf@gitster.g> <CAFNBzOdqOLKFbDFCp99GvXYWs_Af3PdeXQMjE92y+s92j78GYA@mail.gmail.com>
 <CAD=f0L-nUS1N-P2cWM9AwOFv+G7dOBgGjWwEZYP3qSDMxyhGgA@mail.gmail.com>
In-Reply-To: <CAD=f0L-nUS1N-P2cWM9AwOFv+G7dOBgGjWwEZYP3qSDMxyhGgA@mail.gmail.com>
From: Ayush Jha <kumarayushjha123@gmail.com>
Date: Wed, 18 Feb 2026 17:15:33 +0530
X-Gm-Features: AaiRm51AXc6GlZcpDgL-J039dn5Mn37c32SjXC_WaQ_iOAqYcuVU3mFU6Ajviy4
Message-ID: <CAFNBzOebt6iz2_X1kCpSa+6JXG-OTh=FAqcQ84rAZ-4x4YQVCw@mail.gmail.com>
Subject: Re: [RFC GSoC PATCH] environment: move core.trustctime to repo_settings
To: Bello Olamide <belkid98@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Olamide,

Thank you for the update. Since you are already working on a more
robust pattern (repo_config_values) for this, I will drop my patch to
avoid conflicts and duplicated effort.

Best regards,
Ayush

On Wed, Feb 18, 2026 at 4:52=E2=80=AFPM Bello Olamide <belkid98@gmail.com> =
wrote:
>
> On Wed, 18 Feb 2026 at 12:04, Ayush Jha <kumarayushjha123@gmail.com> wrot=
e:
> >
> > Hi Junio,
> >
> > Thank you for the feedback. You are absolutely right that the
> > lazy-loading approach regresses the user experience by delaying
> > detection of configuration errors.
> >
> > To address this, I propose parsing core.trustctime in
> > prepare_repo_settings() in repo-settings.c. This would ensure the
> > configuration is read eagerly during repository initialization,
> > preserving the historical =E2=80=9Cfail fast=E2=80=9D behavior where in=
valid boolean
> > values cause an immediate fatal error.
> >
> > The repo_settings_get_trust_ctime() accessor would then simply return
> > the pre-parsed value from r->settings.trust_ctime.
> >
> > Does this approach sound reasonable?
> >
> > Thanks,
> > Ayush
> >
> > On Wed, Feb 18, 2026 at 12:44=E2=80=AFAM Junio C Hamano <gitster@pobox.=
com> wrote:
> > >
> > > Ayush Jha <kumarayushjha123@gmail.com> writes:
> > >
> > > > The core.trustctime configuration variable is currently stored as a=
 global in environment.c. This prevents it from being repository-specific, =
which is problematic when multiple repository instances are used within the=
 same process.
> > > >
> > > > This change continues the effort to move global configuration into =
struct repo_settings, as discussed in
> > > > <20260208062949.596-1-kumarayushjha123@gmail.com>.
> > > >
> > > > Move trust_ctime into struct repo_settings so that it is associated=
 with a repository instance.
> > > >
> > > > Add repo_settings_get_trust_ctime() to lazily read the
> > > > core.trustctime configuration value, defaulting to true.
> > > >
> > > > Update statinfo.c to use the new accessor instead of the global var=
iable.
> > > >
> > > > Signed-off-by: Ayush Jha <kumarayushjha123@gmail.com>
> > > > ---
> > > >  environment.c   | 5 -----
> > > >  environment.h   | 1 -
> > > >  repo-settings.c | 7 +++++++
> > > >  repo-settings.h | 8 ++++++++
> > > >  statinfo.c      | 4 ++--
> > > >  5 files changed, 17 insertions(+), 8 deletions(-)
> > >
> > > Doesn't this regress end-user experience when the configuration
> > > variable is misspelled, e.g. "[core] trustctime =3D bad"?  We used to
> > > run git_config_bool() from git_config(git_default_condfig) fairly
> > > early in the program, and would have died before doing anythihng to
> > > give the user a chance to fix the configuration files before going
> > > forward.
> > >
> > > Now we will run deep into codepath and would not notice the
> > > misconfigured core.trustctime until the code happens to ask to
> > > compare the filesystem stat data and in-core index stat data.
> > >
> > > I think this is a recurring theme, e.g.
> > >
> > > https://lore.kernel.org/git/32fceddc-c867-4a47-bde8-c873279edbc1@gmai=
l.com/
> > > https://lore.kernel.org/git/a881499d-e236-4f8e-a217-b6bce69e3e3c@gmai=
l.com/
> > >
> > > That other topic Olamide has been working on seems to have settled
> > > *not* to lazily load into repo_settings to avoid the problem.
> > > Instead it reads and parses at the same places in the code path as
> > > before, but into a repo_config_values structure that is associated
> > > with the repository in question (which typically is the_repository).
> > >
>
> Hello Ayush
> Thank you for your interest in this topic.
>
> As Junio pointed out in his response to you, I have submitted patches tha=
t
> settle not to lazily load into repo_settings. but instead to read and par=
se into
> the struct repo_config_values structure associated with the repository.
>
> I will continue working to move other repo specific configuration variabl=
es
> in environment.c into this struct once these patches have been accepted.
> Thanks
>
> Olamide
