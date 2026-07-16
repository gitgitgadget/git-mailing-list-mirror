Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ACE26ED3D
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 06:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784181804; cv=pass; b=DSE65f/ZDXhwY1HzWMez0eEkIBWlXtW3AA6G9TiDaIGVbF/BTs8hKpXVlBBbvCIe2hlBSiEZ/l7e2vFk+xWB1LqivSg18wPhNHAyrT7EvDu7NNoFFiDnnfDp8m+iEr7Mue73BwGRyCbrRv5djf0fCFWf2Mp+H4f8kU+WxM+UD7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784181804; c=relaxed/simple;
	bh=heJawvaFrCd6QUFFL4JZwx6JLZfoZcqAbu3ynYtA638=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCaYQRKHNpK8aCeJDUQ4V1g2JH0nljh9nn7OPGIMqQC59gglEUwK0fz0nj5dkz2a9EgeUEZRscMbEbXHOzIWUbuEGBd5YA5vWKBrRcrFZbVWyvgaaBvef1vNfn9jB4jyXdm02rlSVVVgwoe1w1OXtccWHv4ZxLzWkjLtjBAvswg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSBnyStV; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSBnyStV"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so4922136a12.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 23:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784181801; cv=none;
        d=google.com; s=arc-20260327;
        b=EVzrlwray7wKo0PN6xqh3jkKrVRjmcVePfXQfg9y4kGQrymRbd6pXAAUbjnkHnHNYb
         UiqXuMtOY2dgHuo+GMD0779fOb9Qf8u7C+7gO6VAlLwqhmcyStUbe+ZYe2Rranu0rEAF
         rVnqAPYdgIb/U0gAUHxTTtOPBJ9XeiwIgpUXKkPLwSiaQ5cL+UdUPgO3phk+D7vBVJM6
         1Bvf24ctTe4jEDFW3veSh8gltcZVpsCO3S/Cpu7wv7o0koJLn/+jIVcJGbGOq+JIivIU
         ZC+7pex3inPnIT9B5F3qA/gX3mkWyYbMX3G9pgLSJ0HXy28opk+w6ME1wzpc0M+o5y57
         K98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=heJawvaFrCd6QUFFL4JZwx6JLZfoZcqAbu3ynYtA638=;
        fh=JB3NtXpnd4ZklR51xT7KN6RxYoZNv+ZIes/ka0kY6qM=;
        b=EafPXakWo+mGz+PBCH7rCQgQXtGXyzknqyUpLuNrqr8AH1p4VtZ6tqbqmcC2yhbhpN
         v2E+9uQWAF0nQIKGi9eHA5i2AjLZH/A5cS1LkKmIPhudZlm+zoHeSyMkN2gr4BFMTO+M
         SQtvpkMU1sojOOuy6B7nFsWa4LQOHSKtsyqraTj4U/ZjoUEoFugPWOiw8o98f7FNC7oz
         ToiK3XQOp4V0PbsX+RhUjxz5nsDQYulgYb6CIJQsr+QZTC152sdj/6ZCqr7DazULnqQk
         oabLIMrwUc8hLy4RQwQ5/aXfF1M4C86AwnMYRzXe/ZPc5eTL4ysq7p//3PCJT3UhKDyE
         RcGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784181801; x=1784786601; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=heJawvaFrCd6QUFFL4JZwx6JLZfoZcqAbu3ynYtA638=;
        b=MSBnyStVnCfysNlTll12QjCgOcHjedGT9USxgcsWe2j5MfDbTlvY8I5g8TIn9NYBdG
         d4RGGzFJmqcs1szrxz70wPKR2oubdChHOcp0hgiqsEI36/5Kb1Oqbr/aPi7JmrHrMaVV
         NP0qcHMBfON65y2l8gOvK6WUKaeRAE3b6u/7jb3ghFYOMlJOr5GeoWjlLrtWZ852Ea/B
         QYLYUDeLbGs0Fs/PzR2nKtdw8Khon0pJ+T0qCi/WH2drcBj9nkYR6b++NTAbAUfRd+x+
         jEWMlAYRVJpXCU70pnoS37u6+4XkDB3kVt7GKfQj0gF9hX0Pqy9T6l5SqS/AjbQOnxg/
         KtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784181801; x=1784786601;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=heJawvaFrCd6QUFFL4JZwx6JLZfoZcqAbu3ynYtA638=;
        b=a8LKWdsS+uPaJVpvxaGVKtfOgFl3G3qambF+oPdUcppF2Ab+KyUmJBoU80tN4ZmffT
         B1YY0EKOn2PV8TcFUuGCOcpf0b8jk75lHtMHC7A0P4MZkcdeOOj/IVzkIJrsh0bJOWKw
         B42U5lzba23wnswTD7+hiTIyUIxVQzcpxi9HpJhcozS86mN7cnupwMl8e+vFvR0hCCIC
         X0VD3STtLiEpKaAwpkiGulj2hOhW6yKgbeOn531XsNddhiJjTDNAObAeSQfY4naDqXDw
         pHK3RlMNVDtKFfPn8zB5cDx21YOhS6jIZ15VHIIZAp2WyA/FGRFjtrxLcSzDuqLt1ejp
         BNGw==
X-Forwarded-Encrypted: i=1; AHgh+RorlcRJeXREOEep6xXNUTBPTAkTFae26eaeFjCkojtgM3iCaVjbSdn+zKyztqGNriLZ+4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDorZzNRliROyysvm1qhN9NYQ7C21rFQtHqZDJ4AtCmnlXQNPC
	5ke2ewCmHIgE6mw+3BIKxfJWqjXGjufLIdEe8gUOq2spiVePsgoxvonnpej/0E4p3tAR0JSCahj
	SvvpUQGIlRQED+kQ3rPEmDK9f9zbczo4=
X-Gm-Gg: AfdE7ck/w/kpNg/8GIBDBiYFn28x7Qd8RSiFk9fMB/n4/cYXxy4QPAUokitoHRgQbXd
	5OQ4rSZCDh9CdmFbFocyO0w8CAORIR0PzXhQwHmGwEm6/4sOK/Hx06t+p8J3ivSL+sfWdhlphb0
	cmP1wsiikoZXmYiDTV7VxNNFHbD/Rp/1MKUEoO4H8SJeL5QfgcIFKIH7brvRKhFhfEf8K7a/Gtb
	EMARYdx+ZMPy9guRykMY5BPgIALERyTkCB3HRsOsNuonaIFYhiuKDKBMi7CvA==
X-Received: by 2002:a05:6402:380b:b0:69a:b3ab:dbea with SMTP id
 4fb4d7f45d1cf-69c5f0bd2ebmr9546970a12.13.1784181801408; Wed, 15 Jul 2026
 23:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
 <89d72342-5aa1-4dcf-951b-d0c791f91738@gmail.com> <xmqqpl1q2xw5.fsf@gitster.g>
 <bd7dc183-6597-4fd0-ae64-682d46480cd4@gmail.com> <xmqqo6h9z7e6.fsf@gitster.g>
 <CAHwyqnV8je6gCTExr=CFCdYskN1dVaEDVSKDLUo5A4Ukv=qhiA@mail.gmail.com> <xmqqa4srnwfa.fsf@gitster.g>
In-Reply-To: <xmqqa4srnwfa.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 16 Jul 2026 08:02:45 +0200
X-Gm-Features: AUfX_mxe8qxvHPe-E35eWZHhKAyGw94dyK6bJdZMByueI4KxMwxQ0urhiyXgWxI
Message-ID: <CAHwyqnVy=4oHBTmtDJ6jX38Kh1aLYYXHR-_12DdiiUxpXZ5kNg@mail.gmail.com>
Subject: Re: [PATCH] rebase: mention --abort alongside --continue
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'll revive this discussion because the 'git rebase --keep-base -x'
case still bothers me.

When getting stuck in the middle of an operation, it just makes sense
to offer a way forward and a way back, why be more obtuse than we need
to?


Harald
