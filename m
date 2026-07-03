Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E42C11CF
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093590; cv=pass; b=eb1PvTAMaFDVAjUn0ZYzMLs6Y1YSfzhLY5HkrLr13CX2MmA0PuCIhSI/fiD3y8u510Xf4yD0cNIv78cFarSb5+bI7lZURTHEjsLqLscYE9r0+zLc1WVZu63+DfqFIkJc7l/0YSprZewjP1fOefl5kiccYM6LhoVhDs4mMYa2/a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093590; c=relaxed/simple;
	bh=mayDCH/k3v7ERJw8moxWZJzss3/jT8plrBQNeMz9nFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYbwqvEoLj7l/8xMcjvDUsGw1k2mKbra9yiStytNLiNyZcWqakiCM2FuJMNWHRcdwZZBbW35imn+sJCR85tQIzUzexrr53YoiXBuznLCK8SalRiENQVf6s4A/LhHQEgiXX6CFK7IdF3xc1E2a+UmX7gOez8SXBPpjW7CwA/gM/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5g+0LeP; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5g+0LeP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c821a50615so5403965ad.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2026 08:46:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783093588; cv=none;
        d=google.com; s=arc-20260327;
        b=pfK4YwhflCoANRsto4brsf2r6iF/1b5rdG5xOZjRTWn37QUPPgUpAxgO+MMLFr0zMl
         pcmD82GQ/0el+6IWH/Tz65mr7ECfvUtbi4M2MH11dKCyXsoffymFJzNhAUQtzNhqe9Jg
         /mM+w8uODRSHe6scM4hrnpMNM2iOIKR9r4jQLpxYQTbaaANi4dWfF+ZE1omCG04QPKEZ
         17DJVjviXgyqVlMh284N+SZU7K0E0LmB8F/QebQxbwU+5y1HqERx8Pyiw3JpqXiWcq5S
         qn06gBhkeC860gh6teng9prwhCLzr83d5ORlndLkAq3Q1OYiRwvDrI3qR5rO4yq+pCDl
         tM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YrDuLpbWhQA00eneSXSBcr6kqvqAgy4TCjGKdN3ZQ+U=;
        fh=4W6oKShRO8EFWDrO2w78P6EW5y/SAYuLcnCRI58xFSw=;
        b=A5POooATOIROrUtpZipMS1r6bQ8wQ724fzYliZeaCZBA7yKGyq7jrrQTXzkPATmBYQ
         gg72o6d98+57k1navlLZoQyhOMkLiNM+7iZsIPj5eQt3sjcmHwwsXsDr3IM8Gg8F1S25
         9+xr42CXUtpN8alqKEtWii1ulYzfBb8BBGFELYbW4H+3L7hirHpEQ/KAb3Aze9ZXnpUj
         JnFfDCMpObfbHOjEpzfbA04ueNZDu+Sc7In+WUSKEXDH6VCzk4Iif3jlrVjilAEmNhfu
         ShC+H8jMhbB+WNIHbSl1rONd0CD5Rhnb4Xj0xBpc2akS4CFLo7C7Vd+O5uzYaf7nYjsF
         O1tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783093588; x=1783698388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YrDuLpbWhQA00eneSXSBcr6kqvqAgy4TCjGKdN3ZQ+U=;
        b=D5g+0LePRXM9KbNT/A0/Fi/6WB8T3B+w3a55muM1KUBJWvWUUxcVDLndCPJNEOfmWv
         Q9nKA40VNaHBXrLh3z6OsSQ78H3P5TuRedZlCU5KXMJnQtq/KStkPqMh+SsKWOt0UC3s
         ajBF4vkHdSUb1wtE7H9O5/tNa1K0bUgylOlyjVdz1vUCDB1zJAO4j7IT1o1PNGOt6BVk
         yBsuSbSoPrTFC9XXgDciyVSxH7RUiI7KqbpEeqwtNpDVBmhyOnuvw/UkI/7zE/d1HpTS
         CiE/K9i/wvaYGEsGNIlwDCKT8xHtDXOrCHEDqmZadeH6ye7lffz1NCTI8CPVcG5c1IdQ
         WoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093588; x=1783698388;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YrDuLpbWhQA00eneSXSBcr6kqvqAgy4TCjGKdN3ZQ+U=;
        b=QCmR44I7EeMOFVdhnLRY/3dK8tXuxLl9ZE+vgo9K80i61ugWR2RzAe3CafW4nOLXOb
         JQs5UBayu6fPU7iBlHNcLOwFdKyWnImBJOKZXPSJHnygJW6ifrtHwvrvxaYJZbHd84yz
         JxCEB3cjAxkwYafkyBMBo86T+q7fw/jf9yVeLM3thIZ9sSn9Jx4yCLcZx3h1pzA5NXlv
         2tQKK+0hIfLFEbDj2/SEFFybmEAfRoqW94oMjoMD5x67+FJ0B7U99E6XZ/dtC7+JHYAk
         uWuAkcahclMgZU8awQKewCcJaH5FRLuWb0rjqKofkKVNierCevaDenJlKJ2zLj+9ABXX
         NUHA==
X-Forwarded-Encrypted: i=1; AHgh+Ro/4qEw58f0TJ32wIqzP/D/QNm1Kzsv0JlcDci3YFMlmbSSMtQpNQ9QC3+4IlJxkiWWIs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIYbskCPfyirZjPvB5MXcF3rO0GXSufj2VwD4VtfNwjHwxqjL9
	aKL2CvAUEnXDEoKQF79zSMXMl8lCY5FGl2K4qIe+hUUG/Bcwhmr98F1B4vQnq38q78fra0etvTN
	lgnQFzZBNQKRAc4zASSdntgZjxc3jLZk=
X-Gm-Gg: AfdE7ckJywJsgbyFxypTM0e8Xr4cK17OdoiF4zqCMTuiIFgty4xxhssiotkyrWCMAgp
	IV5mmuFD/eJk2pJzZmI3X0IbJwCzDgz8zTa1xAH+6B+m1JHHvD218IBOvnZHb1dEg6ebLj//4HJ
	hORSdAnSs2ugHw5egPrer0oN938xYkew5CF6PRoPnTURbN/4ToNzzcwiuqcFozxfwSgk5hONoxU
	uIFnWAQYkKNOB+2rEYqaiuac2tukVIMl0rIdpWbBXgbdYwr7i+/XMqSCEfBGGobK4EnX/ZezyuR
	9p8gIBcDiyvAkBFp4lMvhCTBTMImSMDnDen2RrPPhpu+wglpdNl41xU3qniYpQwbG4SaytLVNfK
	Md52lqdzmOMbTQRaAauB6WVGb+w==
X-Received: by 2002:a17:903:1ac3:b0:2ca:b48f:3395 with SMTP id
 d9443c01a7336-2cab48f38fdmr67475155ad.34.1783093588375; Fri, 03 Jul 2026
 08:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
 <20260621174934.GC2206349@coredump.intra.peff.net> <ajjuoS5Qc3K0nCRl@pks.im> <20260628081806.GA3594700@coredump.intra.peff.net>
In-Reply-To: <20260628081806.GA3594700@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Fri, 3 Jul 2026 11:46:17 -0400
X-Gm-Features: AVVi8CeYMTvrV9y7sbuSvH1VznCGEJheN2H5kPLqx3eG81yQkz4L6t5QLlBFlGc
Message-ID: <CALnO6CD622_PZ44rNbryKpX1Z87X92eXCuLVo4H-4nJ2JYO_kg@mail.gmail.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FWIW=E2=80=A6

On Sun, Jun 28, 2026 at 4:18=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jun 22, 2026 at 10:13:21AM +0200, Patrick Steinhardt wrote:
>
> > > So I guess if we wanted to go further it would take some digging as t=
o
> > > how each platform behaves, and then flipping the config.make.uname kn=
ob
> > > for ones where it can be argued that the behavior is always reasonabl=
e.
> >
> > Yeah, it would be nice indeed to figure out whether these concerns stil=
l
> > apply. If they do, I would argue that it might even make sense to remov=
e
> > the build option completely. It doesn't really make sense in my opinion
> > to have a build option that nobody uses and that is subtly broken when
> > enabled.
>
> I suspect it works just fine on some platforms and some filesystems
> (i.e., those that actually store nanoseconds on disk). So probably Linux
> with ext4 is OK. That's just guessing, though.
>
> If I understand the original problem correctly, then doing this:
>
>   touch foo
>   ls --full-time foo
>   echo 3 | sudo tee /proc/sys/vm/drop_caches
>   ls --full-time foo
>
> should be instructive. If it shows the same time for both "ls" calls,
> then USE_NSEC would be fine. If it doesn't, then the system is losing
> the nanosecond information when it drops the cache and has to reload
> from disk (and thus USE_NSEC would cause spurious stat mismatches).
>
> On my ext4 system, I get the same answers. So far so good.
>
> I get the same answers with a loopback-mounted ext2 system. Which
> surprised me a bit, but even unmounting and remounting the filesystem,
> the nanosecond times are still there. So...I guess ext2 supports
> nanoseconds.

I also get 9 digits of fractional precision (nanoseconds) with the
same answers across dropped cache on my XFS system.

> I tried with a vfat mount, and it also works: we don't have nanoseconds
> either before or after. That makes sense, and implies that modern Linux
> will always be OK (because it limits the cached VFS response to what the
> underlying filesystem can handle).
>
> So...maybe this is just a non-issue these days, at least on Linux?
>
> > > But that's all outside the scope of your patch here.
> >
> > Kind of, I guess. If we figure that this mechanism is still subtly brok=
en
> > then I'd argue that it doesn't make sense to expose the option via
> > Meson.
>
> True, but AFAICT it probably is safe these days, at least one some
> platforms.
>
> -Peff
