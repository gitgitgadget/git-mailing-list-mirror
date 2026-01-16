Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5DA92E
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768545798; cv=none; b=UT49OuBUvDQnDCrAc8RzGM6IFKJvrHd3IQ7lwQ3Z2YlI/4NKR1bMWCuB+0XIYcbfFosvMTkef/r1O/kYwohD/Bofz8mAHDzcQUpFSUMY6gA9VNYVh/JmZ9Ai9GFU2kbOCuyAqNqF/CnaEDT2e7CO0pjsGK5wzPqt5QeV1rOnzjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768545798; c=relaxed/simple;
	bh=1NOgBL3TRZ6lcT9B2fd6mN9cE/n2kTHhzN1k0MhQuC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0L1BwUtn9CjY4Z9fNXcXzVTsFYmfEctscTKeoo8mPl4ARVfxgwAxIP6882mqmSHAVOJQyKdzZdD9ySmZSyFCPFU4HFjkDhdQMHWy3LAHzoFB7z4A3OpMPEmh8OfC8prsw/WHkZ/mFnhQ5VvcbotpBuRfBCDocGHF6Zj/al6/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EepfyeOo; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EepfyeOo"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7cfd48df0afso1130355a34.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 22:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768545796; x=1769150596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfL+rKVrWWnuQURxzPODP857wecAFv/x2HS6svlZagc=;
        b=EepfyeOoHAIhquPzHtTSy7Dm+QohyLmE3wX93hWj8YRKvMwrgY5My0n48Edq79O3tp
         5hAV/joKYWWvkzV6ZqtzbZ2yB3DwXC60ZpWo84FEnWAqYIxEoQ7ZGY/moPCR1f7o12NV
         wNRfFCTAwwkvI6xpyrkAISpMhWxf+ALOkxT3kOMzmBtqpyXuN5ER0gbc7rct5+nByq4r
         EoJkaenFyc9Ogh++px2FC/y2BdNEBS0blei87ZRkBuVKoFLC5Ej/kUbvG8Jmb+9/uJ1J
         YbgKM8HTYZvP5MTvas8WJu4zk5FTCw57uLqC4dy1GcgdThBXnTfPef3aIYJKyIDSQfd1
         fDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768545796; x=1769150596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mfL+rKVrWWnuQURxzPODP857wecAFv/x2HS6svlZagc=;
        b=D+D7XGSmC30Q3jjgATjP2yLxJizyMC3+792KbI/0/JNp2I3pE/foWaPrsY47E+40Qt
         ilRcO7f/JlsMKYuB110HAJ8H6ZGHAXVQQwUWPUwCLjqjGbH0sXoydwaVyR2GhyQ5e0VW
         HHiTsr/uuaE9LyJAJAWRfQTZ8rTf6ld+LbjEt9R23G99eVfDL+lfVFPHSgRkWRegg3Aa
         KG5WQ5dQfZp1x3PJR+WEAu3wm7hUxkGBzbTESZb4ErhArsY+BnGV52HaV1mrw/lnKoYZ
         M6tY4955AymHNTAh1yKikN/vvjFACVvQQ6gxmOrWyK2MpaloEA1Nf2WA2LRNDxQosHji
         dwRQ==
X-Gm-Message-State: AOJu0Yw7vgsVqwIoZQJtZu5jydqpiToXZf1MW7IwxA5/F6jOSggaSVhD
	Fu6G5CKg1fGoJQtOKM9p5AtaYf2WMPdhyyiSUEitnwQT/O5i6nWrFgcRF2/0PisKv8B+9iMM2zK
	+mMCYuF1NBHSVM844Uss7idx83ZSNa3E=
X-Gm-Gg: AY/fxX5IYSQhOG/D951BwMBOMX2UNseUeeh3FMpZ0LO1uSqjBTTxLUzCTbj5rgb7gy9
	mrzZC8YlPnLNEiBckaSDcTtpwLrf+cHuBoy0YqdfoFmTC0u+YmnaamPZ1ImCjPJohtjm9YbtO9V
	WThmKr7Hnajk2Yp32urb5U3wutFw34ionVTmZkYgpbYzRvZFwCQI9OXTmZ28+YO1EXZjufMvPpR
	zvxGOTUhEOurxOzs+1ZFiwpwuTfeS4FQTnJHpPAjnoaIqizb0AmHMCrOqifSIooTuINUmH6TOLd
	zlbd7B1Bb7qxR3pKJq8X42to4+gn
X-Received: by 2002:a05:6820:627:b0:65f:545f:5d90 with SMTP id
 006d021491bc7-66117a15f4cmr960390eaf.77.1768545796527; Thu, 15 Jan 2026
 22:43:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im> <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
In-Reply-To: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 15 Jan 2026 22:43:04 -0800
X-Gm-Features: AZwV_Qi_IFnYo6pSv89AxEaloTkR7lf0Kk2Lj9cm5K0CHfbVOV7oShc8nBpJOyI
Message-ID: <CABPp-BFbUEGqNAeUtUghLd3oKcZiD88P04AYuTtY4T01F1rzdQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] Introduce git-history(1) command for easy history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 1:54=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
[...]
> Changes in v11:
>   - Fix overly clever `BUG()` condition.
>   - Drop the `struct replay_result::merge_conflict` field.
>   - Return a positive value from `replay_revisions()` in case there was
>     a conflict.
>   - Improve a commit message.
>   - Fix check for whether `setup_revisions_from_strvec()` was
>     successful.
>   - Link to v10: https://lore.kernel.org/r/20260112-b4-pks-history-builti=
n-v10-0-e3c6aa5b4cec@pks.im

This version looks good to merge down.
