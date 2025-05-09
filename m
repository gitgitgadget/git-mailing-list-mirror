Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6591623BF9C
	for <git@vger.kernel.org>; Fri,  9 May 2025 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809616; cv=none; b=hbmLPRjafMqSegHF3dRWZrWA6TQfGrDmXY0ktVhMNX5154El9KfyHBn9JW0dVuIyKk7KkPwrtwaDJvoPNo/h1NrqpJp7fx+G6ZH8Q+jM7QADSNoGxdMnVhlTSv3QDZvAVukflSbYW3mYUsHXsf3VD57O+44Jwb2Dbhffwf1eaSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809616; c=relaxed/simple;
	bh=SJbsKKX/0Cdr7w73SBurYRO1CoBPhaW9kVijcXaNlNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UI4LyI63P007AcPOIAMpGvLWmTh7Cz2aUdy8GBwF1pZdGo1xOu9mufQKlkOsVWsCADr4lfo4E+x4wdk3gU1/eh8lfGoXmHnbimNEDvVJt5hFAelV2YLZgdMg+QNtBHcSeEaPtTsMMp6wPZkEumYQ0h1EFp9MKIyR7YfW4r5H0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn31e74R; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn31e74R"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad1f6aa2f84so501329366b.0
        for <git@vger.kernel.org>; Fri, 09 May 2025 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746809610; x=1747414410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux7pbIHokPJ0q/H/OXJEwJaveLJTRWX+mWQGirO605Y=;
        b=Yn31e74RnpBQWo3jLCC1bVfU24Niby/aq3qypEO7G2U7W4ZbvJVJbfaZ9MB9bKoJlZ
         zAyvQBZ7bh3BIeiCVaU+MeoTvy7s5kOYlEfXZigsu8SzC0KugaoCjdn1lj125gIrLOf7
         kJk+AYm5chDdB+tKhY+g2+SgXi42kzDI5nvem3JWhN7ZbuB4rm0/ZLTjhT3Dzl4wEtO7
         QvJbYvbjum00FOuAzQq6YrUlrC2CRk8PVrfC6aueSVuAeZXeHRPWkFKJqyoaBnkFvNvf
         OWDlAiHD7kL0urEj+tGCcalmjQ2/nXpqtWq0uregGBRPfK/RSdv+nSiQbIKMB9IA8xCR
         M7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746809610; x=1747414410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ux7pbIHokPJ0q/H/OXJEwJaveLJTRWX+mWQGirO605Y=;
        b=CeDnkMh4uCTcUCV1dU1kjnBH/EZ8E/NDF65qrNqos7R8h+n/tGXRji1YyVwdvu1FR3
         oID0JmbGf7EKfzpdvRClH+Q78eSYOM+Nu2yf++nXYRT2y6mCKLyOJZqk3+u7O+MTcmED
         nWLkSOwvNaq0TBRyDBFeubQo1e5RgpyurmuB56YHd2CoIdl5mCq3dNjtWe2P5sFRk2Yw
         s56dXZ+/LvTQ27FfL7h+vw4Vl1MTWEOB3AJdb9W5zLtGC5kLiuA9NRui6YTJ98OeINYe
         md1Q/rbsYli7n/hhn5sXl42jVPOJbtq6tSOnMhtfupPc6JRz7PBIi7IAuQPw5r6wEIwm
         LOZg==
X-Gm-Message-State: AOJu0YxHcKxuTrM7JdKGi6PrjBPw9tLS+fdyeLZT7URCI9Ahh18APno/
	LSnquW+At+SybKGsDhBtndpFPyPChHK3fu0HZ3FY5gybSOp1mEI9JGNZwJtuhumE+PJHceZq7dx
	o8oIYboY+VZKuw25gTXQ4RorlGZ6gafx4YLw=
X-Gm-Gg: ASbGncu7PVFlD7EQNCxRrY5CFqCEddN8JRg0KhYOO4rTsGQqettp+6wEDI7GScNgAd4
	cmVEZZF3d7C3Md0fDYFCzj6chBUZVdMUsZwQSLIJA5OAdQdcWFnIL0nWQCv0YcgSFaND9Yq0tob
	/9FmOnxEOw7O69xHGzuYxK/vIBzTEHYa6OHyhJAzZWzefqZzealRNxK9E=
X-Google-Smtp-Source: AGHT+IExslQfRfTKqNtK6XLtpar45wvrYguWMmL0tcHIXnNfsDy/uwhsSgspiEvcxa/FJQSZduK/Apyybt6GXoTmdJI=
X-Received: by 2002:a17:906:c155:b0:acf:1646:6021 with SMTP id
 a640c23a62f3a-ad21b4d210cmr345725366b.25.1746809609813; Fri, 09 May 2025
 09:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
In-Reply-To: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 9 May 2025 12:53:17 -0400
X-Gm-Features: AX0GCFuJBfEm6v5bP5ovRbJJlp8JNzr9J7C7Um5T9J0WJfHjHcsUI9UbFV2zCQE
Message-ID: <CALnO6CDDrd=XpkkTFYfAoiNcoG5q83Z8c+Ey4jKTBriA=M7TwQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Importing and exporting stashes to refs
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 7:47=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Stashes are currently stored using the reflog in a given repository.
> This is an interesting and novel way to handle them, but there is no way
> to easily move a stash across machines.  For example, stashes cannot be
> bundled, pushed, or fetched.

I'm probably missing something here after having skimmed the original
cover letter at
<20220310173236.4165310-1-sandals@crustytoothpaste.net>, but:

- Can't we "git push <remote> stash[@{n}]:<branch>" to share a stash somewh=
ere?
- And then, doesn't "git stash apply [--index] <arbitrary sha>" work?
(At which point you could presumably create a new stash, though I'll
admit that's cumbersome relative to dedicated export/import.)

I can see how that doesn't help you quickly export a whole _chain_ of
stashes, so I'm not saying "this series seems like the wrong tack"
(far be it from me, who doesn't understand your use case, to say
that!). Rather, I'm confused about the inability to move a (single)
stash across machines.

Unrelated question: Can we import arbitrary refs into stashes? That
is, what happens if the commit structure doesn't look right? (Maybe I
should go read the tests and see.)

--=20
D. Ben Knoble
