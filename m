Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F5188006
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279122; cv=none; b=RtOeOR2rCuHMxAEecY9QrX88oNfqLoDcZaFl05xXs4wgbagEgKbK0Tmeo6zXal3Tqhy6OB7k1IxHWWLSSL0aaPRlDXPpVFKnkYu0Pd7mDTrCYnhrbFBDiRjKdKxGUI3j69DBNqJU5Zs+H7d+2qSSdWnJwZStoZNZdyJmqkEgxwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279122; c=relaxed/simple;
	bh=v50NA8N+VHvPWAw7ZUp62Ucebw2FImccSeWC8lhzYDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjled0Xkz+G1EYz7ki6Azy6ewdcEe0OpRjZORAkAQ7T2u7lJ3+Wzy9m6RYkta5CICEx+S9CEujEX2lrLbLz0Qlc9ro9C09L6AWaFQyr6c9x6DT7lN0QFSG838Ck8FzLD12cku+QT0aLUMazEYxgFHslgHpwpY4W7BRM47BmyE8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cug3Ufm2; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cug3Ufm2"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-60f24b478e3so41057eaf.3
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750279120; x=1750883920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24eOboOdoMMHi/k38PDFsdmVkduGJhjNXCbQ5PxpfRw=;
        b=Cug3Ufm2O2zbsItfsRamQ7kO7lrrNrtn5555HvyuSJvDaVamN/zf1MQ5kbqOqFKzvv
         +RhK/ouEemO7Dfadx9Ky6QxXKfk4UCNzLWf5OSZ9umoJbRtillJaukVDYXV1Mo9S6ZXj
         29BgGwwmTKlnaIgFehKlQM2tXLNsJyPiE2F5RQ9NkrHX4lWaB6HZ/z+AkrZolDSueY8p
         0oQSa++FYv3GP4DL2QLrzlC2Nja4o8OeG44+x4xrGyqs0+d/3e+BaJPTJRIMHvItztSl
         dYYZQt0zubbIAE2Mga90gl3zs/VjKNAvrjpah5AAPFBX2YZolS7yj9VTaajElAqJSrn0
         PfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750279120; x=1750883920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24eOboOdoMMHi/k38PDFsdmVkduGJhjNXCbQ5PxpfRw=;
        b=t6sm+m859o6O+rBCEnLYF5Pq9CyHrBfcscdPq7vPFeyfcfTZeBsvafpYEj83YT0Kj3
         tIKnopHK9Y9xIO0uwbhlvlKwPZMgFZrz4SH/zzTrRDnwGTd8Zik9qc8H4zDELkzvNUfg
         PkqCPTIx8cg+9oTmSPoqWBjvlMqBeRCOxVKxs88GvOR/a37zeeViwZQXsqUKCQ9gZxmo
         wx51vup+5Az/kvDU7pCIu/Vu5yNBcl3fkI100OEp1fiAu7QyMQKJeoRr849+xOylXMTf
         kpPGszIyXDm+JjBkfnbGwTm2wNXZ4Pj3izV8xVXDXC/L5doffiA0xyrPrBZ8qfsRxA4X
         Is3A==
X-Forwarded-Encrypted: i=1; AJvYcCVXVJX5z/pjl5UE9cik4ZLNKN3zCqkN1kpavg0F6PzUw0VvUsalF1js9N2GDe8YSo5uwiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr1OqPnmuZSCX5KFk1l2MbW+5I+eL8yfMGRS8k97zJofHk+roq
	B5fz/1prl3N8SCeWAFo03Sx6UVbdvpVgQL8E+Z1qHwXtj+zXuFWdvBkEoG3HuiwYTLVnssy++NZ
	UZsOnGo8xxZJi6sEyJ0x8EZIW/LhhTiy6KN5V
X-Gm-Gg: ASbGnctIDLmjj6CvJf1uwhV8KNhvAY7nBmQqK3LXJXLrAD5QdSBwz7tsDoUEEbl1nOP
	l06jEuiFbRVgqTYowEoJfu//qgTXA9lQNbOvCLyOVNnRgpW/FFRQ7vX/8pqSqLU/nu8V7roFG6k
	2k7RO2Uoi9rxHKQ09ZBxI927mwqJX5/at6gyf2pd5v9JG7J3k+HsTW7Bs=
X-Google-Smtp-Source: AGHT+IG162mmDQTma0gPrsOZw++TEMX5iGJENQr5UvAaSSDOPa8DGd/dn9yHqUYVY8N43nbI+L/mjd3H+ya7UHu+E8I=
X-Received: by 2002:a05:6820:823:b0:611:2c55:3a4f with SMTP id
 006d021491bc7-6112c553b7emr5202847eaf.2.1750279119887; Wed, 18 Jun 2025
 13:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2000.git.git.1750186571037.gitgitgadget@gmail.com>
 <xmqqh60euqhc.fsf@gitster.g> <zpv3nkpsjqlg7evklw4ui5q7wonak2376rclu5ksmumdvk3tic@tfxmcpjmj3nw>
In-Reply-To: <zpv3nkpsjqlg7evklw4ui5q7wonak2376rclu5ksmumdvk3tic@tfxmcpjmj3nw>
From: James Duley <jagduley@gmail.com>
Date: Thu, 19 Jun 2025 08:38:29 +1200
X-Gm-Features: Ac12FXw-Rj9jTHTspAE9-uOMB_AZpx0P-i4nB6m6vG9H8_OpQEQm4CXiWrN3sY4
Message-ID: <CANZAkJuPUYSCd4yGHFhs6hfERovzjwWoM2gU2MyAHvY_AtjLkg@mail.gmail.com>
Subject: Re: [PATCH] Ensure restore_term works correctly with DUPLEX
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	James Duley via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Jun 2025 at 22:07, Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> On Tue, Jun 17, 2025 at 12:18:07PM -0800, Junio C Hamano wrote:
> > "James Duley via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > This is because save_term doesn't set cmode_out when not DUPLEX,
> > > so an old version of cmode_out was being used.
>
> To fully address that bug though, something like the following
> (untested) needs to be squashed on top, right?:
>
> ----
> diff --git a/compat/terminal.c b/compat/terminal.c
> index 72b184555f..8a197ffea1 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -279,7 +279,7 @@ void restore_term(void)
>
>         SetConsoleMode(hconin, cmode_in);
>         CloseHandle(hconin);
> -       if (hconout !=3D INVALID_HANDLE_VALUE) {
> +       if (cmode_out && hconout !=3D INVALID_HANDLE_VALUE) {
>                 SetConsoleMode(hconout, cmode_out);
>                 CloseHandle(hconout);
>         }
> @@ -299,11 +299,15 @@ int save_term(enum save_term_flags flags)
>                 hconout =3D CreateFileA("CONOUT$", GENERIC_READ | GENERIC=
_WRITE,
>                         FILE_SHARE_WRITE, NULL, OPEN_EXISTING,
>                         FILE_ATTRIBUTE_NORMAL, NULL);
> -               if (hconout =3D=3D INVALID_HANDLE_VALUE)
> +               if (hconout =3D=3D INVALID_HANDLE_VALUE) {
> +                       cmode_out =3D 0;
>                         goto error;
> +               }
>
>                 GetConsoleMode(hconout, &cmode_out);
>         }
> +       else
> +               cmode_out =3D 0;
>
>         GetConsoleMode(hconin, &cmode_in);
>         use_stty =3D 0;
>
> It would be nice to know, if the problem with vi that this was meant to
> address, and that needs further changes, that are only in the git for
> windows fork is stll relevant, so this could be cleaned further.
>
> Carlo

I thought about something like that, but I figured:
* restore_term is only called if save_term is successful
* hconout is always invalid before save_term is called
* 0 might be a valid cmode_out that should be restored

This is my first patch so I didn't realize git-for-windows had a
separate fork. That makes sense now because I couldn't find where
save_term was called from in this repo. To test this works I had
downloaded the artifacts from
https://github.com/git/git/actions/runs/15692373534/job/44210362705
but is that right? If I should submit this patch to the git-for-windows
fork, please let me know. Or, if someone, who knows what they're
doing, wants to pick this up, they're more than welcome.

James Duley
