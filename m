Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD91DF248
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771747174; cv=pass; b=P0K/cwSG4WyfSpwMmkg74WLQeIktoasRuUrWQaZpWk6nADVmCxEl3Xv+dkgkxsApL+CVh1Rqf8JZVBrusopXbWHHVpWmIFDel4DvayO8NKI4pzznpTcakXaXtFn/Bd7UqDKfxmmWNuUHAHPoH1HYmB5N05XmeDRc1GVpvhfxua8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771747174; c=relaxed/simple;
	bh=WRsYmHFNnIdl4jxCkv+vxhUqKNOlTm6ecbE9MTeCnsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClPRevgIDw/+6dBzCHzhSyGFsLskVmfuf9IRfcQ2otXLHkQiBYvY2WvkkoQUItMBpnM4VYgnTlNeOQH1CbWjqWK8S78AnGtJnSGaYagvX2aUg9228/7lTOsCijFkP2ecQpnfLkIANCS/9RgdsR9i0oRatDDaRXpvWNW0SrzX9VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbL02yNr; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbL02yNr"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506362ac5f7so32202831cf.1
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 23:59:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771747172; cv=none;
        d=google.com; s=arc-20240605;
        b=F1QbLp3T6wycIFf+EtbU3P2QV/gB4DGcmj4XXLBSYuXBQQzsZH1Qq8WV8VKZvQ45oi
         HxjjIgjdr6E9ys2iwfVLJJhNNeXFM/U0yw9lEC6C50Tyhnr1UQiRCKZP+mwPgXBgdFWz
         nbgGZ8KrChPjTkkFN56Iq8yphYUIULhavsBTFk7H5odCobOjZv+cBhgoHs7KNjknsT9l
         jSGe1s6PqbD8meTbDqiWHv3PBi/vU6KLjN4+UehZD0IUb9jiYeainC9t4Ak5wrll6atK
         13CJVxs1EgLkkm+ID9T0w8CtBTWFgDCPbuPI1VOPxJ2T71iYGhAFoS6hYO0oBKcPjTvC
         ndhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K2/AdaMGyUD/9ldINNrNYvE5Zqt24YKgnxDWFEFpsZA=;
        fh=vz33kSUMLEbtIucqTkURGRL8oiBSV8AqTo0Pka5NLvc=;
        b=jddly9U4EgTNMmYtJGkShJklBBLCRld9dzPqNGL8PEzdw07WZAk75Hruq6QAlBi/Rv
         aKdpDnVSb+rghOTmuGydmY0lGTo031MdEQFerOgkTydOvnIdPckBC/24XfOEqxolq8zo
         cBBdaTvKjVS2OU/zvui4ihG9tgUT6PvGjt3HGGxyxg/xXBkoCWaFcOLhslqXtc496HJ8
         GD5lfS2a4ECaWekfWEbsmH+4u+hF0r1dWhIkx6jGhBdq36y9QDpU5vz7ybfFnL84yUvJ
         rhMJYIOQgn3YqsPl5ZuY4cd9RxFpbHdd7sFPy3CIqQWk6rtB0YnJHkaPcZ110DBdNQIU
         9TaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771747172; x=1772351972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2/AdaMGyUD/9ldINNrNYvE5Zqt24YKgnxDWFEFpsZA=;
        b=kbL02yNr7D+I4PCeXpgHDhgPUBYw+bNAgKmXb1MI8w5sz6+JTw4rp7rdsabz0lA2A+
         GUXCfL0L/Bl4zHVQap5zQz4aj9QzicvhXkEG0kTOaWojE6ht7EAS5VctmPMRxIetG1rD
         aGzFPucn3GGviv8gnQaT+CUarbWYWF7Bl95J3ohZYH+DM5V8qBdZHA8j1SmUqJee2m0u
         aypfiueFXTCarI/MvJpbQoED0crDoqiuoAa+XASGCifVOqtRTO3CFPj8X9m24tF5x2nx
         wFd8DRG36tfFEv4IhLKfZiPGBZdEHHVLffiZmhx97wRIsjhuuKv4ZJXrFZx/WSdzWYTj
         z32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771747172; x=1772351972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2/AdaMGyUD/9ldINNrNYvE5Zqt24YKgnxDWFEFpsZA=;
        b=giR4UYFEvgGVBV9vlUJXH7bSVOE9sV7Z92zTp+HJghJG9YqOKP8/bhLDW5BPx/xPnu
         qGBuYG6CrQNZSHRtkhZC6w/HHWa5Z0zsNryJ+/RZP2KYGGZHqlggu1VXs0BT9CRutbv8
         suJlb7RAPabNaU4fR3mEfYIMr0rQweqo5divHW3LrjRlponE1pJv7UEieOpw3y/I6H1h
         eqMQjjVFmFh/azE0CfLH4m+TlGMi1aawf/hdi1gIjSFbPay4xFVQmpiPHV2uB5NC++4u
         950ilxN0vfqqpA0n2KScvnZlAJiOZBaLzBZDU6QqW2p7Q4PGhWhsXk3rZ0hwDKqY3YrF
         uHTw==
X-Gm-Message-State: AOJu0Yz4WtJnNne3VAnIG1o+7VfAE3CfNBSzD9oBoM1+gXNUBWuuD2Ox
	pc5NnSONbe4hGZqux9lsI1KBVd2CThzK9OBfmSNPgp8qM0apb91V9kVcinVWVpHDsDVGHitkgfv
	Aek6hLcFe0ezL/XyuH84rfd0ir92lbe0=
X-Gm-Gg: AZuq6aIiXJ2xDPtpyC3I+qR3n5fO37TsROUnEH/3JjAwg0n8m/MbXdsN9t0w19jWX4V
	OYlz7o7SVtAGU7e6u5MJHEufq6BLOv1RxQZLxMYHnc+A9cOD0dxkWyOo2zR2JKCf71eqR80MYkR
	1KgAG2CAmHFoj+ZLbrp3mMlrhzP00aoxCQ558u8vzzqtlOjaFHwG2hKcvOUiN77itxazPtOxXdn
	QIQ0zXgfbQnN5Y4OVYJYmp/sshF/K9wufRDgJNlV+fJHyH8xXsiJ115+MCjdWIgpeQEEtemjGsj
	8R8NuKsygdvYm16Se+ZJeYpTOG4ROpuHkCPV7ldeQ0KdEhgIyQQ=
X-Received: by 2002:a05:622a:1903:b0:506:6ed8:3791 with SMTP id
 d75a77b69052e-5070bbdb98emr66845181cf.28.1771747172195; Sat, 21 Feb 2026
 23:59:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222004036.47744-1-jayatheerthkulkarni2005@gmail.com> <aZqPXRHOHU3EjfvH@denethor>
In-Reply-To: <aZqPXRHOHU3EjfvH@denethor>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 22 Feb 2026 13:29:21 +0530
X-Gm-Features: AaiRm51V85VfY-M1-F6eEA73I5mk8zZ-WolfgdPt6v6T9vu3KOJCfHNokv8Y4Mo
Message-ID: <CA+rGoLdmQ6wS5_PN=SEwOntXKKAfTyZkhSY=L3Lh1xfRnLVPgA@mail.gmail.com>
Subject: Re: [GSoC] repo: remove unused header
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, ayu.chandekar@gmail.com, 
	siddharthasthana31@gmail.com, lucasseikioshiro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 10:43=E2=80=AFAM Justin Tobler <jltobler@gmail.com>=
 wrote:
>
> On 26/02/22 06:10AM, K Jayatheerth wrote:
> > The "hex.h" header is included in "builtin/repo.c", but none of the
> > functions or macros it provides are used in this file.
> >
> > Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> > ---
> >
> > As instructed in the Getting Started section of SoC 2026 Ideas page in =
repo project
> > This comes as a micro patch.
> >
> >  builtin/repo.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/builtin/repo.c b/builtin/repo.c
> > index 0ea045abc1..63d21df4c2 100644
> > --- a/builtin/repo.c
> > +++ b/builtin/repo.c
> > @@ -2,7 +2,6 @@
> >
> >  #include "builtin.h"
> >  #include "environment.h"
> > -#include "hex.h"
>
> This include is indeed unused. I am currently working on a series [1]
> that will use this header again. I can of course just re-add it in that
> series as well though.
>

Understood Justin
Thanks for the info

Regards
- Jayatheerth
