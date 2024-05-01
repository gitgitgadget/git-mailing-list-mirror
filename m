Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E253368
	for <git@vger.kernel.org>; Wed,  1 May 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580381; cv=none; b=AgtAR8UU/XF9oTHr8cg5WgNtknMdtl9k6D90gy+cskNcZ7WuiuWMfssvufDss1oISeCZoBEOLwh4m/v7GlMmDFJoxnRtLtKWYsllhM5SbQnslszw9J+0zTAN0l75eF0zEkyH51cykxWxx02zuaqD0GC+shfs4/p2lEUPmXc3G4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580381; c=relaxed/simple;
	bh=9bdC9XeFofWnbmiBQw2BosqjMA/ikUPHYCz4Gm+BJL0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ntJNYRd1IFl0dHkD6IzVaTqyv5I9ypzd634Hb4GNWIQwJUPdhH3fNK16YdWahpIB6KC2NZLWQEmvbt7/ONoBEImzP0szYdOW0Fc8VEDvfkYTV/5aydRuebdxZp/oLvnaVIHAY1PTG7KrDmTOeM1KgNJg5OK8tixcgrpVY+ICjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7VoKbcp; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7VoKbcp"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2dd6a7ae2dcso112839311fa.1
        for <git@vger.kernel.org>; Wed, 01 May 2024 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714580377; x=1715185177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1gs0YrDoGOkgLrhvz8I1ks7lovBc1JzZSzvY0C8ox0=;
        b=U7VoKbcpPXvFcduOwFJcNIQwrvWa04q4O8DkWYj3kcpOFMYn/f49ylvHkL2mVl+mCk
         midPmBFo9+gJUK/M4ViGiP1RNsgnVUsJJXdJdznZiF92nNREapn0oYuEfkkHNkVetzay
         SE7OuRSRVSdmXNMQmMCCLXDrLEhKRMuAQAvkFNXeZzRrig+9NtX04yePNDOHKiV4oe5H
         f6qa+OY9n+mipYFMZiKFUVhvZoHmxb9NSDj5OOwc7xoZsPcpZsXgqe/GoL/eIy1jmDH9
         sUjWtmEwSsynY6+tTcmuXhbnDQVAStpOxKH8BxxgIxwi9CcPtFmGEtTi70/4zJUTNUDi
         UmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580377; x=1715185177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1gs0YrDoGOkgLrhvz8I1ks7lovBc1JzZSzvY0C8ox0=;
        b=QrxI9z2TUKdHfW/kjeXTHvFLAiEBuvhVoxkdsGyzVVaY8JD+/g/fwPTomcdZfnoAom
         ihvQBSgjK4PDFmcVF0ZkkTUB/+aaS2+wwof2LN9DfVMSXwUqMFjQVOWP+d0pbhPTBuiH
         d9Y1zesCD4kT2YZ9LHY7VvgNoberPfIYA6Al6WbceC4T3uFFfvMPDxRWMEKys6WBG1I0
         7BRT1/Gs4f3PA7jgx3yN9qZrVkmROusYJr3uoavP9GPE6bpDbbIftN5KCRcxVfGX6bEM
         oPi43ObTwOJ5XeTiqHlCYdB3/ckfnpyFZIEjD4GBZ6pm26PZ8knBROM+KRdpBo5oP1tU
         aeSw==
X-Gm-Message-State: AOJu0Yyml5UkHG+7fAwwLAPuBtAQ4N7iHgjQa+czbqNCj1DJQXCGoaU5
	tbg+Zpy1JbccJHCFbisjgIchOMEmM/MKQvt4kxC5fquaWvUEif74ztQyQrcMw6JA3Hik/P3PR+s
	wudK183hCUj4bKPjljSVQMsY5M4yeH+Wj
X-Google-Smtp-Source: AGHT+IEXuHnb6PfsaGJro2WQj2WOYGb60pgFeJnAMz94v81WMQHZ3KP7TInRne4rGPP9C4ej67gsXlWRZE3G+9kpYlU=
X-Received: by 2002:a05:651c:b20:b0:2db:c2e0:c541 with SMTP id
 b32-20020a05651c0b2000b002dbc2e0c541mr2426050ljr.53.1714580376991; Wed, 01
 May 2024 09:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 1 May 2024 18:19:25 +0200
Message-ID: <CAP8UFD1XaF=VAX4fexPh0hJd__vC6fSoiPQErGopm4CMvFcRTQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 110
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Adam Johnson <me@adamj.eu>, Dragan Simic <dsimic@manjaro.org>, 
	Brian Lyles <brianmlyles@gmail.com>, Max Gautier <mg@max.gautier.name>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 110th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2024/04/30/edition-110/

Thanks a lot to Junio Hamano, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec, Kristoffer =
Haugsbakk,
Dragan Simic and Adam Johnson who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/709
