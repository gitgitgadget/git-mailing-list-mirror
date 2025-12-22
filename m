Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46049299A8F
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 21:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766440316; cv=none; b=BcQYo9rqs97Pf/cjB7hHSQJflcJIRG7VJVZxPp6+r+YDjPGkHrGZD5tiHPIfSfTVOTKcgO/3NIubJyf6i4Ma6ot4O4XH54PRX3VIRt/Re5pwd7rpN39S8KQ9MsF0PuPdEcEu/6LjeVRfz5CwkkbPYAZ0PdNOramaJZVKyH3h82U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766440316; c=relaxed/simple;
	bh=fWrVhEgkR4qM/m4ZM8TOhOwv/+TGSQkSQDLWROXQ2Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgpbV7Uolwi5cNWzK3jrTdPYH7h2c09wE7FfJtnwzITHeo5VeYss4lfKE63sP63YqyVmakweRr/Gu1I0RULqvxnrv7EEULqqciDjdlggpM0NlDE+yKG+fiA684KnN198EyPZTgBUvVrcis1r7VuOxTkgWc4Z9NGHHDUcOEpW2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLkUSbAP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLkUSbAP"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso4749404a91.2
        for <git@vger.kernel.org>; Mon, 22 Dec 2025 13:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766440314; x=1767045114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xVQuD0y9BHZ2GBtjb6QvI2d5ABaj2ZzvqnrHtytKC0=;
        b=DLkUSbAPeYgX2Nqiliek8ez8l/RZwT2YIfqj/LaO3uPL0a2UzYcF2IvvPzbp9oyOGw
         5y9k4hhBpA7jmixbRywIdlxUX237BxMZBl0qG3Cp7723nhhkxazdXkM7O2B445wybswo
         xlveUmyZkVvLOC1gLaV518JIzr6hmn7ozUN9cWMhYuDIvZDe5294W94WmbNcb5nK7zFQ
         UANtFk1HNjjUYIJKOb9y+8bx4kZlwbE4AdI+95RPQtwXpAuxOTAG0kqeUkJeI4vhEkQ1
         9kOEw6j2W2EwLAbYLHo95qzKBD6zLwlj4n8Tk4/TmLB8zGmn9WvXohgIHiDhd283BR1f
         wy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766440314; x=1767045114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5xVQuD0y9BHZ2GBtjb6QvI2d5ABaj2ZzvqnrHtytKC0=;
        b=Xo0tiXOccqOQoKnzVtib5LFkZA5ZSKEG3BM5X+TmadWh02KQvhxuR9T6IW5siP1RX9
         sh/dq8G8vM/0e/PbO04wmK4RNDjFQCS1sk77H5HM1MVHXDmBtubW0Xpml+nf7AHI6odd
         QRgpCjXSoXQOLmwKB3xjL/NXVbCgtEFc+wC7n9qX7OZ2B/gwMVt1qNZyjtg33kI1cjoV
         fDdJzi4qcUIlc6gp81ScFBIpQCCy10AA7vmjVqKesJ6LQgK6HM+N9dpvhtGLtCFmGqnu
         bpnVVLUmSenvrQf+xiK1r81lHmmlJL8yNmPOjm9aw6ULMdOV04wGyr565YGDb8zlQ/4n
         vcyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHSbHCe7hg2ccSwV6OuqsvHKdy+99H5SqpALhe413pwMDzmVlbxSVd7JtdIh4F9Se1M4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8AtmwmJDRMX1uwK0US7O6/6jTUN5a7bDeHBrwJD9veniQRhmd
	BWvYh3x+KeqNRwvEFGbbmgujCvETFcJH5fkUoALi9fXKUDLqVsKtAcxgZa1LTNIOIR5neLcdFZq
	kJ6REDtnrtXLp8UyTp7DxvB6gAwmmSo+Bj3udso4=
X-Gm-Gg: AY/fxX6P6OJcnJGj/JY7ZPjcPGK9hvn81OW1HHulh+ZW1ZkGu02BpD9ItUy0nf45FVz
	XKMmybi5b/6eNNOl1mHdiN7kPRUAL0wn+3Vjv63OgHVu9M+CbkscxtYAvmVFrwaLeEt9ECUtttQ
	ri8ZyKv+b+KBOkpr/mVgAyCP71GoeRPLVIqnG6SnE+NysMgycDiQm/lnotHgT63Ptj8PKk2OdvT
	dQP+5En4yT3mErm/2u1JIWg/rr/EY4k8ktSOdD87euXQWe4tHxgk7JUvwrvxIF7RBIEs4vV2aGX
	Qoim0aRHINFYeeIfdLxPWExQfJZM
X-Google-Smtp-Source: AGHT+IGbIJvJJNgS6ukPROAq/MqsLL8TSGrQS5TieC+4rbHsus2OmyQZdXQnV5yhLK84238oHBeEXY2vIw7JI4teVv0=
X-Received: by 2002:a17:90b:3d89:b0:340:d569:d295 with SMTP id
 98e67ed59e1d1-34e921b092emr10900792a91.24.1766440314592; Mon, 22 Dec 2025
 13:51:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218184751.31209-1-matthewhughes934@gmail.com>
 <20251218184751.31209-2-matthewhughes934@gmail.com> <xmqqike2x4ei.fsf@gitster.g>
 <fmj4be365s6jczb6p2ccb6a6vh64bltgfl5neshu6g7hrabzeb@twzrzmprhotf>
In-Reply-To: <fmj4be365s6jczb6p2ccb6a6vh64bltgfl5neshu6g7hrabzeb@twzrzmprhotf>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 22 Dec 2025 16:51:43 -0500
X-Gm-Features: AQt7F2qGUQbIvkrdf0yvJUJfeI4wgtXWdmyP1DDHSAUQiPwKyeF6PdORQ2RlpSc
Message-ID: <CALnO6CD7Q1-vBKkeB81G04=MT5kSH4-Hm72cSP4hBuU+fDDR6g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] maintenance: add config option for config-file
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 3:55=E2=80=AFAM Matthew Hughes
<matthewhughes934@gmail.com> wrote:
>
> > I am not sure if singling out "maintenance" is the right approach to
> > solve that issue.  If we had a mechanism to have two per-user
> > configuration file, where one is read-only (as far as Git is
> > concerned) which is covered/overlayed with a separate read-write
> > file, not just "maintenance register/unregister" but all other
> > things that writes into "git config" would use that overlayed file
> > without touching the base configuration that is read-only.  Wouldn't
> > that be closer to what you want?
>
> Indeed a read-only config as you described would be a more general soluti=
on,
> and a better one than focusing on single commands like this change does. =
I'm
> now curious if a similar idea has been discussed in the past? I'll go hav=
e a
> look in the history of this mailing list.
>
> That leads me to think my proposed change is too narrow in scope, and ris=
ks
> dividing functionality: where some commands are taught to consider the se=
parate
> types of configuration, while others are not.
>
> For background: I singled out "maintenance" only because it's the first g=
it
> command that I can remember seeing that was writing to my global config
> (outside of "config" itself).

FWIW, I also include my gitconfig in version control, and the way I
manage this is with

    [include]
            path =3D ~/.gitconfig.local

If I run "git maintenance register", I then move the added
configuration lines to ~/.gitconfig.local. It's a bit of a hassle, but
not much (I don't frequently add new repos to the set).

--=20
D. Ben Knoble
