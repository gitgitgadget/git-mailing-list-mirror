Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCEE1E260C
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 02:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972046; cv=pass; b=ivQRxoqbZliBmGPEmzaX6Twz3xyGhfTbgUGFmAkQUB9OILAgMZBFROPIyWPtD7zyOcQJ9IYHkY/8lOgj/PqVP22t9MqY5dk/u3nPWixCASAbx43I6etbhshVhwxusQaRRlhSNo9/S+A5a5hfrd+EqGgx1LFvG4UNLTNc1s8VN3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972046; c=relaxed/simple;
	bh=BsN7a+WSEnAgWOT30SHeEsf4yACK1IEi8OGpCw3tlEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6G686vKgBzigctnzmM/reuXvKYbnAB+cXkHCY9SANe8cvK+A+IEyJtPS0nqID4X18S+uCIcNj6uiuJosG4tlRR53YaryNCZZ6i06dziOr7pqHo5XRHhtnCNF+o+DSnGyKyoOtU04iUEW/4ZAa2oUbdygBDyAtCE7QP/bIciItE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOVOYHly; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOVOYHly"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa7bf3d512so4482246e87.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 19:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780972043; cv=none;
        d=google.com; s=arc-20240605;
        b=QpJ4Z2QF52e7vgIwzD4L4qdwwaN45MW4WzT43GVA8u9ztUXnhOyoKJc1WBOwQR1uUb
         G/ONTBQnsUyXVO4xiX5xBHUF4Gd6g3xiDLzUvY9dxAPM0JR0G43DyGcJcezSJ4rjxP1e
         ufaUXTvQ8SOdKXRWFkpfhUEeBncLoxgcoE793gCKM14Nzl+W3qdn2kdQpqtqHdPwKS2+
         qi1ulxHdxu/aw8fuVImnDZ9jctthjh5q7n1zsdptHRRVrsh4Wd8gUArHn3nCo4Abr1ew
         UK16NugZ6wG2UlzZpNCIVFTgnG1rfPovfi1LUufAdGxpRsAalPoSovOGWo1lg+FL9zR1
         nPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kBf7WrEfD3aR4DcoaGNBIkFs9ofVyUlHvANHV/ew3G8=;
        fh=nz1v7f3nJwgAFOk+UWjmlYmUVZeCh1i9wviIM5lbzd8=;
        b=JiIZcDdtyxR3MIks3regcYFBnMvCdAKGXmBr0jgk27ii80X91jyF3vm9E4GMDP4xUT
         di51Kw8hJTwH/uATccNikjZlFdrZjUT9ZP1wCn+/lTxotahpLxwpCTc1Bm8o1NAcDT6Y
         91ROuPQEvSvJYZF+C/iqHkSIFGqa73ws0/rzf1vHy8/TsO2/jR7+lUx6HLuORZ52+LGZ
         zIo0h5nj/u7WBSFlSH3u1dRVZR7K/7GOK47NFG5/uZJ8u7Hy5HWqIPYxFj51aVe/fL2h
         IrGhIZFvXmr+AykXsCIbPEIXHxo5Fpr2MUDd3S0LWajN28aI1yForXICjxoABwUtuDMP
         Itrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780972043; x=1781576843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBf7WrEfD3aR4DcoaGNBIkFs9ofVyUlHvANHV/ew3G8=;
        b=ZOVOYHlyjp2YIPKkjnBe0V1sd3CcDNu11MnbVam4i7IW73C4BM2CDiHWFILjV3QeIT
         cIPtJx6x/Uch2LRP5DgQ9+gC/LJCV3yhMt4M/V7ABOm1BZy6p7zVYiyuxvi0kFXTL1b3
         BXvEQl+w5g/m8yKUirrvr3z1cez8z0wE3Jgc0ptV6mfCGUTIadh6GxJbezHPncPya22T
         OrQnvGUPHfsg7D5gOfYtr+9eCwnRXqAmAVJ0NlEYwqZlNoCoS/fM94asSU7M0VPUhc6g
         MaXriY4jOJDMrcTczi/9ZrcnMpPRhUp7UCvqohbwI5/M9rZWvEFj2FF806vmg8H2HrM/
         kXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780972043; x=1781576843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kBf7WrEfD3aR4DcoaGNBIkFs9ofVyUlHvANHV/ew3G8=;
        b=Rx6vC25HwRBglVAfCor+7rSgSYkbY/KUO0yIO2baVvDU776NcDa8rsbNGzOP5IpbiI
         TmiTk7IME88jQbiCxgWTYoVddEYuP0VBTVOKu7GnZlsVR+tDaWM53VgFlBQYM8me9nxi
         4cLl4iNEZi12B/Y/8UMI19oyX9ewB7aSyj/zyzuspRzcPubwof0RsXHn9UA25+aDrGED
         ODFkfpU13lUzctjbwZloGSYccqLv46e3Ad1nPqj4gVFGxXCoLzX9gvclUm3N2SqcC5fI
         iQNOn1hayJRvcRxgOr6cNUTMW+uy7KbMuC5QFzNBvBekQGm6jVcagmXyGvH5qjniglia
         AVPA==
X-Gm-Message-State: AOJu0YxJB3w+VycUgAJtOxvYyGTK6ccI1D8g4bO90pebEPquG+K3FBiX
	AdmD5W26tiUSj/a4kd0jwFD8K6oOFozy4CyNNap6rpkFdITkgA1oF6tK32yAJN5YJINCH4LMdnF
	/cFkMiWiqGPLcswkDtEn5zCpU+bB03tQ=
X-Gm-Gg: Acq92OHeADrhuts9kTvCKG2S6SJ4ohkR5sk/v63m5zL2N3UBqxFk/1O4n/uV28gu5lw
	IEK3gv/Mel0WyB4Bb7xGyj+UNGl5oCAWTE3BDy8d0FGle2jVKuuzEC5NsYXnKwIT8vANDydMBHC
	0FgMxHNhP7TTWMAWKM/ue5gDs5U1O8fTMVcxGMbgij6olR13iiVQs8XgXRu2sjbLTP75hzGEwNz
	lRcUVkAj8z+uC1zdNT4UkA+FVb/RhwlCGkjTx+jMpUmg4fZi9aA7ZyrQICIikRr4aKAw7G7R//s
	udd8uqDHb+iZofx+9VUyuRs0OEOrgOud2JJHSIDnpqjy+7md54scLcsZkUupTx0y9/tKBd7yWk5
	BEQkds4iZiGJNaAG5NDcuOh+HDb0i+wJ4S8gw
X-Received: by 2002:ac2:550c:0:b0:5aa:6833:f6be with SMTP id
 2adb3069b0e04-5aa87be4071mr3825140e87.12.1780972042649; Mon, 08 Jun 2026
 19:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-2-jayatheerthkulkarni2005@gmail.com> <bd9bc9aa-60b6-4e5d-9ce1-bf38b6032309@app.fastmail.com>
In-Reply-To: <bd9bc9aa-60b6-4e5d-9ce1-bf38b6032309@app.fastmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 9 Jun 2026 07:57:10 +0530
X-Gm-Features: AVVi8Cevo-jXf3fFg88VK3BawyfxtjaG-unicxUPitQE50ATnT0H90GGiHszwY4
Message-ID: <CA+rGoLckSpPq5iHUsgUQpXGopS4-9LCh4=pxRt0rkRpdNNoemQ@mail.gmail.com>
Subject: Re: [GSoC PATCH v2 1/4] path: introduce format_path() for centralized
 path formatting
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, a3205153416@gmail.com, 
	Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, kumarayushjha123@gmail.com, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > the localized fallback mechanics specific to `rev-parse`.
>
> This looks very well explained to my naive eyes.

Thank you!


> Nitpick. You are supposed to add your `Signed-off-by` at the end. You
> are saying with that line that you are signing off on the changes and
> the commit message, including the trailers (mentors) you=E2=80=99ve decid=
ed to
> add. Imagine if the maintainer applies this patch and fixes a typo and
> the commit becomes:
>
>     Mentored-by: Justin Tobler <jltobler@gmail.com>
>     Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
>     Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
>     [jc: typo fix]
>     Signed-off-by: Junio ...
>
> The chain of custody is then very clear.
>
> > ---
> >[snip]

Ok, I understand
thanks for taking time to explain that

Will change it in the next patch series.
