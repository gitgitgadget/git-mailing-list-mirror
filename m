Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568413D2B2
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050732; cv=none; b=iOUgs23oUrD8+jSKmU7gHJKQ0+P5rQUsjKJqFJeJPhOpuZTxr0XKnuJ/v0zSnTBtIuAGk3daSFpy7xA3w5qcP5bxLY5EnbVOsN2zGERZM3a+f2DcR/NLErRtsKg+7ykHQIgoJlrLzihdakuXnGI9lFow49P+SqxSWPf+G8k73XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050732; c=relaxed/simple;
	bh=SBJ/6g68dgfD/VLD2h2KjPnhFwD5P9ODheHIq3ixj8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FW96wE+NqOVG8R8nLw0BfKUT1PvrXylTt+y4dbn/OCh+wLFWnuSASFHgD19K+oebsu0MXSOHgy0h8ujrU4nXkaOOj8Xcc2iJSKpbaznKuo1un32pnS732fZh0Ytdiv0bj5gPRsSEcmOeHFREw3SPIaloEfbSIPmm+9yPF9ug4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6T77u2L; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6T77u2L"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5561c20e2d5so6155589e87.0
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752050728; x=1752655528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5N9WpGTPeUmE37OZqNRGJ0CEOODe5hrLtCJZnnwBRtw=;
        b=R6T77u2LsEU6jO9ozAxCTLsPDmYzaIx4yGfuUI93fI+2LlznObh1Uf5R90fNBwmmYg
         rosAZ/Vb7BDo7LXWla3GOBgRE/B4W/Hh1luvFGWDfsSw2QO7xMNi3ExMC//uRuFsdJHN
         h2TzIPrh6sjFaTL0zjxwIxDAXwLmj4GIs2PjfUCcqcm8R1660dVDe/K5PHCETsYpnCMj
         gHHNmvSB0p6dx7V8wdhatLE3YdZczC9/AQ0EAnn/kHrMJVnElaYUdoHHCseHSHhZJxZb
         czHvwyGWdhzxsYwXd8wiAFR3h0Vc/X1PXEK0n/Q7M6PWzaauILHrmppREXyX/gb3rucE
         7+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752050728; x=1752655528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5N9WpGTPeUmE37OZqNRGJ0CEOODe5hrLtCJZnnwBRtw=;
        b=pi03Krh0VhyN3Gfhu6Eu8wgPbZjbOdwjPT2EeCjsfMIXEkgF//NzITLKWAGuF+Y6EH
         LG8EP4hhP0tgBdVZ+l638eeHFuEMSXTK582X7lLM0UYQ4RCVfziqYT+qaMA1BCsVoI5n
         PjDx+G97V+Jtk1gTks34hORlkuaXdmP7aagPy0B6OPDH4824qelGdSnl7AP1Akrr+9/e
         1V4fFu/1f4rzThGXEfM88RMy32c53Qg0l6IGK1F1Anj93oqBFVO62muZJxeMif4kHPnQ
         QdcUuafAll/gTVYABJgA0oSZudq6vcCKXsDhvtBq57Xklj/KAnGXCjRN4VFiP2+xMTKs
         Y71w==
X-Gm-Message-State: AOJu0YxsC+n1vkbJl2e0vyjdzSQYF2KakdgB8L+tnNeH/XTDbzydpuTg
	UrBkMoBs11QT2oLDcHFOvoIyhAawp+XyITSkIUICNmJxCg6wrJ5d9URE1fAnXLboQvwk7BEIj0S
	tYB1mjHh69hKO2K5QjCBdISJfDDSQSFsNTg==
X-Gm-Gg: ASbGncsxW5UIYUmyXKurrgNPtPLagmJjKes/Nj/NrKij7PRny0AUgKJWpDn7GL4MDgw
	kCXGwBML1nXkjRCATVPDvYOZNpKWy97PP6CEAiX55YSho8haDIqdylRO9cyeBmQJdGYzbybR0yD
	uzmJYz0Wv477uk+YVnf6gEKr0H52I7lLoB6vYLKd5DMgz6EH7jY/p+bXM=
X-Google-Smtp-Source: AGHT+IE6Ilt2ZVDt0W9EVTpqJVzDv7HSZumxFxuXAY1Y9i2TZFHMJqhy8dCH4J8ec5DuK2fsQkfOVMRZIKzWHgh85Zw=
X-Received: by 2002:a05:6512:3986:b0:553:2e37:6945 with SMTP id
 2adb3069b0e04-558fa8fae82mr627649e87.32.1752050728095; Wed, 09 Jul 2025
 01:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEWUs4iWwrOw4sXT9PhdccZyWtcvTgQfHDbeavTk-2kOdjUMdA@mail.gmail.com>
 <CAEWUs4gEsASB3Fog2Zc5tEfACPURjHPqaS6e2XNWj0i50O-e5Q@mail.gmail.com>
In-Reply-To: <CAEWUs4gEsASB3Fog2Zc5tEfACPURjHPqaS6e2XNWj0i50O-e5Q@mail.gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Wed, 9 Jul 2025 01:45:16 -0700
X-Gm-Features: Ac12FXym5R9mec5XOx1AM00TObmMhe852rDyo9LLhgYX_o16u_ThNFK9sThayYo
Message-ID: <CAPx1Gvd+XwN1YbbTiVCM-6rSr=9o5mB+T-=c8x5gpLkUp_hZ8A@mail.gmail.com>
Subject: Re: gitk: visually indicate whether a tag exists on a remote
To: Adi Shavit <adishavit@gmail.com>
Cc: git@vger.kernel.org, paulus@samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 1:37=E2=80=AFAM Adi Shavit <adishavit@gmail.com> wro=
te:
> When browsing history in **gitk**, I often need to know whether a tag I
> see on a commit was:
>
>   * fetched from a remote (and therefore shared with collaborators), or
>   * created only in my local repository and not yet pushed.

This information is not (currently) available in Git.

> For branches this distinction is obvious because gitk lists local and
> remote-tracking branch heads separately.  Tags, however, are shown in a
> single list, so a locally added tag and one fetched from =C2=AD=E2=80=93=
=E2=80=90say=E2=80=93=E2=80=90
> `origin` look identical.

They not only look identical, they *are* identical*.

To make these show up separately, you would have to do at least one of
the following:

 * collect information from the remote in gitk itself (run `git ls-remote`)=
; or
 * collect information from the remote during `git fetch`

The latter would be possible by adding the concept of "remote tags" to
Git, but this is a pretty big change (not technically difficult but
probably controversial).

Chris
