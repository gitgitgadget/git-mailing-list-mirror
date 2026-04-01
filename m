Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CDC314A65
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 05:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775022110; cv=pass; b=f6rBXGS2ktq4I8KHEScRVexTV+uChxC0XJ3PghP7H8xKZM6MFKKzf+uxjVtnkuOknp/HNvPD/2OxTHXckX40ZCcd6yGoQo0G6ll0RCZZYi+lXpvScofBlVm6KFTOGjlDY5yu1XfSROd+6wkTZlsQOYBeGk9tXX5hIZQldrZwFs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775022110; c=relaxed/simple;
	bh=AhiDUwsER7YIvmAzmo8pmdhR8Mr0Yax2uVAzlzRhNPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9Ra9dHz6jBm9QY9SHYdm+y2HelAHd6hlOGeUE0DYIxGMIn++N12U9Bhy1rhJ6CWa3qsx1U/T2/lpTCb4CQgbYRLDV+VgudA58sP++nyh+hf6VsAD+TYYWZi/5W2g6zzGLNmp/mc5ZRNhJe3lGXjYBzxE2L8IDKuqQ5+eoZZ8aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUi8YKyL; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUi8YKyL"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12a74039dc6so5242235c88.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 22:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775022108; cv=none;
        d=google.com; s=arc-20240605;
        b=VtcvvBXaHJNrLqgQxN9F7oIbIBMtHlYzVdYgO5hB9YQ9AkW2KGbEbJQr9BXd7eELfO
         lhc3isn6xJPYR2SJX6lfdIzlwTI9AM8JG9kUJMzEhnu2JDyZOu292G52nTuPmiUmAdKJ
         6UcjCMLAiTgRLe/AdSWyriku752jGc7EjrMJpHuI+PM1j/u//3KpckwuhBQ3sNs1vT/O
         HAlijwu5r5OfCKteAPbOOh6jrUR9Cpz+0J3tRc2/4xj6WNY4uJR6c10bkccYWEvGNWdp
         dMwcgS+n79rWwN0pJvdnE/xNyyA+cwvAJZcw2GfM0y8VsDOPbLszUX+3Yu7TNGWKos+F
         c60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VCzDrzeeyBDKp6ZZoylNyJEItgBnYMBpzJKBj2TnJZo=;
        fh=9YIIsTdqbn/IOwcwD19p2Nqg09YwnvZKB8q0RTDKXEQ=;
        b=UwEksTuoeXzUTYJCuXz/n7OB1C6k1dZnHcvG9/+gu9BVhFHXSKZqUsLaau+VHI5slw
         oDNVbGpS0TJ5SH2hvK8EfMrgZLPGcA/l5ig6RuIP8/F9rTDw3q9bSag3XfJrnYRTMKKc
         01WUSwEQe3LeEa7QylBVrcMwYBIhCzjegVyN6mStI0cGikIDCy/R/IPtPyHbwiJ2rPwR
         YB1wJMi5Qxyb6wmva1mIW4OPFDL2kaZqUdWsr1eQ3CRDZs5PlAjz5SCjVJCtAuDIHJli
         MNpnaLGbs1TqxXwx6gn+ivXNWYHjb1SfzE3uD6DDV8mB14zZiFTQ17xCj1c5KdY6ceZP
         n3ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775022108; x=1775626908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCzDrzeeyBDKp6ZZoylNyJEItgBnYMBpzJKBj2TnJZo=;
        b=HUi8YKyLECXo9s6X53lCqnKc+Z5Q0VOjb4TuH8sDn1gqUHL2spXzhlfOvzjxTzIM5n
         Ltcbd3HbEUVnmK098y04gJj8C1I/o7yESq8hSeu9CHbqLgzYvfZQU4WZ5JIA9ntKUIRB
         umMR+Zv6tqjPst4gzVLthNkrg0NFWeLn8dKNmqABjTONbU92TcsQt1MOW+qVL0FQl+De
         co5z/EcThGWQLHrxoVu0X+Iky2oG5/8fFutDVgC3Lxp57KpXzbtjNfapxDTTxwD22JYF
         OVEGRCswoCaJIZCbQb0WY4C0UAaK31d//8bH2c0OMcOtlUDMYrIbx9x8HYI9i/24a2nm
         hKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775022108; x=1775626908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VCzDrzeeyBDKp6ZZoylNyJEItgBnYMBpzJKBj2TnJZo=;
        b=aHQKYa9uPVw5kuMmDbqyHSTMoUA9sR3BWoQlQZ+BFTsuAcQmxLWB9rnew4LnnvHKCp
         8QRFp9VibKtUAu+Gyx2SnPN/1ObibXX88Wt6ivOG5FStXLovSdIzWOySKk/Fsod0wEno
         1/RNx0QUec6IGKCxkfLmSwhAG20Z2LCmQVqxT/4SVT8Ct+CsGq/tlvOJylAsjKq8yIKN
         G2XL1uv5zjPYTGrDwWRlwgyaHIMHVZwReq7o7XB2M+TzgPWoJxazdspDBZHEPs2e9JgM
         Ou988gTjhjMKosCglF0tZFG+WeQLUyLCo81U1I3PwtnOahH45Kxstxj8dgCWQikWtNhf
         wapg==
X-Gm-Message-State: AOJu0YwMNW2olv2OGoEDCFA6OKgVRxDooBxjcsHIgYxYOCrfGGA2oBim
	rXntErWspCg7lb8XUAZ/rCOzOeBhAkLpvQEWO31o0Ojl0sSnTGSKXAVn5gHgfy4GEI12qdeMNey
	SCZrnzSTx2NAxsqsDPWAVNZrdXKNRGlpZNuAl
X-Gm-Gg: ATEYQzzQ1xDSsLhmR0PDg1A3fK/wrRXabg3OCPVWOR3JzLTY6PUOMYffzZilvT74CIQ
	reaw7YO0fn28S1YZNVIg4mh7vljJZlwymOxztfuLhoxBpalkTVjOPFBR5fAxCqNAKspdVW+Xzm6
	aDsEBk6MjM3bZV4dLF/mwK8+yPihL9aU+E+PKKggzg27HHjdxD/wFUtVBVIOmTpDcPSnDz+SFxj
	FRDLZnK45mDt2Q5yRPeXDV3rnpOph9qvf5iNs80OsjRlwB08BKZ7r+nAqbeJ3tjqxQqTkozDfK9
	kNUsWux5PeOCGX+YIgpQgNFvUFbqLDZc01o8BLiDbnxi2YYcyDNssCeIAu2juuONgrxS
X-Received: by 2002:a05:7022:1e10:b0:129:fe5:117e with SMTP id
 a92af1059eb24-12be657ba22mr1257603c88.26.1775022108123; Tue, 31 Mar 2026
 22:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-15-christian.couder@gmail.com> <xmqqzf3y4bsg.fsf@gitster.g>
 <CAP8UFD2vAK_khTkJMP4QBfhYA5iYVW5sfB3i-vnzhf71BvwQ=w@mail.gmail.com> <xmqq341fy7v4.fsf@gitster.g>
In-Reply-To: <xmqq341fy7v4.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 1 Apr 2026 07:41:36 +0200
X-Gm-Features: AQROBzAI3pPC3scpk_j2B6fXMhMsLyLMO1zJZeVgf35AgIPGvOx4-cOFxtXuODA
Message-ID: <CAP8UFD2HsfNGX6LrthBX0SqXUpgwiGyT3R2X1zwHN9SribAqgw@mail.gmail.com>
Subject: Re: [PATCH 14/16] promisor-remote: trust known remotes matching acceptFromServerUrl
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 12:03=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> >> Between the first sentence and the second one, I think there needs
> >> to be an explanation on what "trusted" means in this context.  Is it
> >> trusted so that the URL can feed random configuration variable=3Dvalue
> >> pairs for the client to blindly apply?  Or is it trusted to do very
> >> limited things that other remotes can do, and if so what are these
> >> limited things?  Without knowing that, the end-users cannot assess
> >> the security implications of setting this option.
> >
> > Yeah, in the current version, the following is used, which is more expl=
icit:
> > ...
>
> Do you mean by "the current version", the one you are preparing as
> an updated iteration?

Yes, but I am going to split the series as Patrick suggested into:

1) a preparatory series which adds fixes, refactorings and cleanups,
2) a series which adds the new features related to the new
`acceptFromServerUrl` config variable.

I will send 1) soon, and 2) later when it looks like 1) has graduated
or will graduate soon.

> If so, let me mark the topic to be expecting a reroll.  From the
> reviews by Patrick, I am not sure if I should also add the usual
> "(hopefully small and final)" in this case, not just yet, though.

You can also just drop it or mark it as superseded by 1) when I have sent i=
t.

Thanks.
