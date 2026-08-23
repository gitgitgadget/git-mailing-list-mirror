Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F23D4125
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787488604; cv=pass; b=DxVQz2aTuy4qZMJHh4MiK9S0zX5GbXlC3e70E5uozmzuMs0Wpuw22diOZYFh5/nFh6C7fmpgu1CufkznhkhyJ9npFfdQVbCEKJdMTlqh80YBgWltVH5hsNBu/0GXnlKEoWkHmmSYNQCRPaMfSG5RuZnKYckPFynOoSeEyFIdfkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787488604; c=relaxed/simple;
	bh=70gop4SRI/ZsWv7J3Ugz/phglNvPHVvs5/L+FIBVVck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNcM9lk0ZECmnBVyRJP5zj7KFwHxBJT3iDDOMFiev84tW1Etw7zCI8DfZK0fQFkPhdBXHr3qRtFJSCOEUKyV7oKUwT41GwyYM79Fz9Zv/pISmeZbaey4xJ4jhzV9cdoUhdh9lpGn50HepnCa4rfwHzS+wTMRnZg0QR7VYTpyJSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePoza+Fc; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePoza+Fc"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b0f19bea2fso2588606e87.1
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 05:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787488600; cv=none;
        d=google.com; s=arc-20260327;
        b=owgW+nkM7PoeoyVPU+NeFBDhJR++cbQb0KP1vBJjumFoy9KOK1mDTC2fl1cpB6XyCy
         W26GruUj1kSY5R/dp51dieKX2B3Fv5wLpXa6b591b/BfeJSJqAKUnR6dE1Hs70SglzNK
         CJCXAVqZwTqxyDqnMqUpgtpqAarmB14iIc7fMGMQvls1nz869LS9CfKCW4FpjmRyJRJI
         mjEXKlSz+Adzv9lfmnztkVfkbm1WCxTMo6qquRBQUFX4RN7pOEqn7dnF3281/bC88zv1
         MkJF7m8M5v9kGKxXxIvEEkqKLr1nhwXd3ZIqdBygW565rcVozOBd2d5sk3svIBDtVtB4
         Kpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7xbWQtUxbCDdDkWv4hw0zoJwyg5WN7pEwU4x6zhiQXA=;
        fh=O+FEpE1U3kFUh6EeomcpE0oaJNp2swRsy0IOv34HRfA=;
        b=K7Zgmfdhbec3JVDK3aJq7RDD9d/e7q9lmchLg1J+oIJj88oLDqHjE7r/XtvuzCmHjl
         ybnwvlmHePj7lMJZsU0i2QeRC+xeqm7TBFeMqk0rT1/u9xZp769YFa4ElnZMR2dCYV4L
         uV3OpBvV1NOnNqGxrjPMVRr/KC2/skulpVpMY9TsM9X5bqhv64jKyrbZGbPdYc2vMnmX
         lQhvr0IZIKiIsjh/GYQGreFluktWb2HFWB4ekz/yexVmqYoNtsGY7dDPnlH3DJb/nexV
         VXhMSA+6Alx2RX21wykwOzmjw4e4JGThY6NfcMy8DaUrOzKNtFrIuPJaN16jbSAXwwau
         lShQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787488600; x=1788093400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7xbWQtUxbCDdDkWv4hw0zoJwyg5WN7pEwU4x6zhiQXA=;
        b=ePoza+Fc9WcyBFqa6ve8lJyakG/KxLeQjmAX63wQdr5c7Wv9A9KToIVoa+yR9gpsTi
         wqmSXJsrXf32cwrNQxqLw8zbdmkkcTWjb62CKj3KjEu6Go7shAp+L8iY3saqu7mprhtz
         SFA0hxpKn/mpLqUpI4inBl6rppON0dHJwkCao6rufN0azsm6Eb0JqFF1q0acqqDcvLKC
         URIHICkUNMpyjghGWvASvlizhWPppeZ3TA6k0sdCPH7ALw4HZhnagZE+qWVayST8BxMv
         h3ab+oJEkR4Q2ED+S0IXF0u9gm7cJ2oSEEiLEGeHRuBf2UP7mP9O5MKXTcx0oDIKmb1k
         hw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787488600; x=1788093400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xbWQtUxbCDdDkWv4hw0zoJwyg5WN7pEwU4x6zhiQXA=;
        b=a9zCdcJYIprEC7YLiTj6u1RcNwKpqj/hU1ZpOxOUv9yLskLY2Ycjbor1Yb1EIqJ1Aq
         kevN0U/eiBAJ8rxzjqtIxdTAyOnFHdVZTMXqIlCAw4gy1k6X8iHXnTVnA7BukS4sgUAh
         1ydrvywG6e4VQL+NCdx5XORn0DE7YeWO/safwyHgRg+s3cEKYx3l+B+b9M0nXwzmN9N/
         e1JqchrQuyu2sTnw5N8PdtpR8vB2dbbGrDiOH1yHA1kjx7Szb+T9cF65NppIYeZ43cPi
         mEpBk655CD75m8wRGq+rzSAc/9+Qh0klcn6y2pTR1lbuJkWxrLgyIL9kzeAEQ2smO5lg
         JcOg==
X-Gm-Message-State: AFuF++nz79X9WwBdac4np8rY78n45KCHbqV/nXVwz+rb/y/ypGlSBOvL
	+TICzPE60HwCgQ/Wicc0r5z/OR4wiplPeNrHUT/mv+B09iSNNPLYV6wodlWDhroSfRw5jn0p4Yo
	oDZk0LlCEHbbvkw1QcBZ+P1grl/l6x2Q=
X-Gm-Gg: AR+sD12MDE8KunL9wQaSk2EIj+ID0zNLuEyLXTOsXolC8bO0jHvdZXjMBq2Ec966k2F
	0JVxAtVQX3v/+9I5BPitPAn0h2JWFaRaI7YzNJs+IfjxBWy1Gs6bW3EdRFGhzV4DYuNeAtFtSVO
	EhIJtTe/aetRZ9HdJUzTW0AiYoMw6AogVLe7tkobbaYS2QKbDayGz9eIQ187gPebYH+P6AQB1BZ
	C11Oq4DTOJUNwB5SAE0HQbQck2cux4EpSvWHYFGGPjCfOQ/CqIOQ4qimO+JGtQWn1FIKndq9xDc
	c8OY16tA2EtA6LkOrb3deqOiM0KDMPk2+VxilNF8tPUJLg==
X-Received: by 2002:ac2:5559:0:b0:5b4:51b5:6081 with SMTP id
 2adb3069b0e04-5b4842268eemr4642589e87.18.1787488600373; Sun, 23 Aug 2026
 05:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com> <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
In-Reply-To: <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Sun, 23 Aug 2026 05:36:28 -0700
X-Gm-Features: AcwNN1UhevJ-gz7a0EHy5chiYYxcFAIkLcA4AVrWmgWpqmk4SDzuUu_kJYDU1i0
Message-ID: <CAPx1GvcDNx4BUPQkVjbKxYLxTJ=StvLC43R0S_2=T0R8NKbZ7w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] config: read both home and xdg files for --global
To: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Cc: git@vger.kernel.org, Nils Fahldieck <nils@fahldieck.de>, Patrick Steinhardt <ps@pks.im>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Delilah Ashley Wu <delilahwu@microsoft.com>, Derrick Stolee <stolee@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Jade Lovelace <lists@jade.fyi>, Glen Choo <glencbz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 3:31=E2=80=AFAM Delilah Ashley Wu
<delilahwu@linux.microsoft.com> wrote:
>
> Hi all, thanks for your patience. Here's my reroll.
>
> As reported in [1], `$HOME/.gitconfig` and `$XDG_CONFIG_HOME/git/config`
> are both valid global configuration locations. However, when both files
> exist, `git config list --global` only reads from the former location
> whereas `git config list` (without `--global`) reads from both. The same
> issue was reported for `git config get` in [2]. This inconsistency has
> no good justification and contradicts the documented behaviour.
>
> Suppose that `$HOME/.gitconfig` contains:
>     [home]
>         config =3D true
>
> and `$XDG_CONFIG_HOME/git/config` contains:
>     [xdg]
>         config =3D true
>
> Then, listing with `--global` shows only the home config:
>     $ git config list --global --show-scope --show-origin
>     global  file:/Users/delilah/.gitconfig    home.config=3Dtrue
>
> and getting the XDG configuration entry with `--global` will fail:
>     $ git config get --global xdg.config; echo $?
>     1
>
> Git still reads the XDG config as part of its effective configuration,
> as shown by listing the configuration without `--global`:
>     $ git config list --show-scope --show-origin
>     global  file:/Users/delilah/.config/git/config    xdg.config=3Dtrue
>     global  file:/Users/delilah/.gitconfig            home.config=3Dtrue
>
> The documentation, quoted in [1] and [2], states that `--global` should
> read from both files ...

I have a related question: which of the global file(s) does

    git config --global --edit

edit? Which one(s) should it edit?

Chris
