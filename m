Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BDE3E4C94
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088352; cv=pass; b=ad9VXBTaABNCkp4ALjSE+uWl+xTLAJcAZuYnuGLZaRq68brMkhuyKJshUydD0j/ViXvcgSHwgNqFkyyRCPwgfrBZ/pkgZoG5H0Ti4o2vu17+gADJa7Qo/j1eNZuYHpeGyewHFgM6fr6okYqSpIFbvINTRxdJpBoE7sW6Y24qxp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088352; c=relaxed/simple;
	bh=z/S1K10Txd1OudBU8G49N9pStkLzFJ5Yqtt+1kP+3so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYf9CHFParYXSVuwUIINxhiMhfCSglPwU0t6C98VtwO+4seLy1Xs6cb30nGCb6usisVB/DxatkNPIRonNuWH+PIZ+uNO+9rSLO+oI4RYNPp8Wc+usocG44aMJJwnTf6ibIbgnjfripFpdHf8ljinjWI4NfddDiq/P74sL0YWx70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAkEKRoC; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAkEKRoC"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38759bcd877so3256390a91.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 00:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786088350; cv=none;
        d=google.com; s=arc-20260327;
        b=WWA5h8XPn5Hc9DRa26LxSKPlEXWIOmET7/OUXXo6LCmmx0u61hymcDdF1QmzG+UI/l
         dhJSM01TRhoqKxDtEt3lIXDiSM3TU/8CpfQtKzW+ChWWmioYdq1HLRqth4tuLy1SS4ZU
         3yx3EtMi8Cw1PWV1t/G66SpEoyiJyMUw7l3dqNMeL1HMBcXURz/kw3Nvia6Y8gVzTj35
         A+Rby8L/sYk6YIZMO2sFGuBd5K6927tzvZys2fddSW8ENtB42tpQaBYsEBKPMLCsraG7
         IRIC3QyOONx5Uwsg1ujXniAK3Z0MGPOeGPy+751smu6UGZkjvqnLCrvB0CTzFU/yPWGp
         BAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2TUKW+E/XjEtZxCJyZGk+IjyLc7xvEwQmPt/C1xSt8M=;
        fh=jMsHqQQH38l9hZ5LmZiiTQ5KFo0wM+ejHUCTa3FXjXk=;
        b=EslnMWAj7LUhzI3OtRrcWlodVX6erd4rwPCoqtwdRKWIpZAgbiw+6x7IjlO7o5pj5j
         DuxAFIWVWOSkjBkIi9EWtBb+Zm+QxtHu7TnESUXxDon7VsQjZ9B7ZPI0IIOZDyhGfYCk
         z2z4JK4TnMy0tDs2hGDOhGXDiQo8DyF9DAXu1hrgaYx1QCMbX/BSTxE9bvy4KPpl923B
         YrObqosAkIabJZtg/blgxAGXyoxxkaQ69IUYFaIHlcsMcfPnt+wXRBjPh/defWwjYoKZ
         961oEI0htKW7GqZQy/NiJxFQhqMueoPTBX8YSozsNLx2tvoQsxZ2ocdg61ViDu+hE5UU
         119A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786088350; x=1786693150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2TUKW+E/XjEtZxCJyZGk+IjyLc7xvEwQmPt/C1xSt8M=;
        b=SAkEKRoCoXgfHGj3meV7OJ7v8A6dVUhNLXL6MpyT00ymAVaD1VwuR0OKGIUb9nYMXY
         3mGSp/1AtwuRnJj8kyU+SVJyIs0OPpJotS4qAL66wG7vmLrYT51L3Xwn9BgsPtzL77q6
         daJNZfvTyESRCYR0OMGQndfotTLNP2jagG3XdE/H2d5I2uQuXYbkehg4BmHGLgFnv/1A
         zJCeSQlTknfOMZ3ifFS+b+pW+ZoFuqGVXvDybnbwS6EyCpIIEUL1oPltEp3dpUURu6Vf
         oE4hV9g27qLghtBxY0AVRuyJVgvZYPjoMAyzdk94BY3VhIbl0VnXJyG6syQok+7DPZNZ
         DPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786088350; x=1786693150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2TUKW+E/XjEtZxCJyZGk+IjyLc7xvEwQmPt/C1xSt8M=;
        b=pE49UiFl0Iws7t1BCmktZBcLK63rmSrYfZ2kaSOVrQ/7XvPM1aRAf+VkRXdWhH7Q03
         s69CwZ5OHZ1xwPRb8Uff+aK/HB/eJUZ3o2xv9SFNwodZSHHs/ZVlDnA2F6/2JNGWUntA
         Q3F0aYxGn+nxaCAlI+fW/msQx2Wqd+88tD6Pod3P25PBTV+ZdovRdG7qwUrmBQ3o85cJ
         OsIpNkeO7gZWa8mcHoLmgi1HH0cm26P6/qqn3jnD0/WO35GCkNHjJP+9qklU7ge1+cDr
         zLFDhBrPtCCSoCulL9Qxj1XN0s53/Im4GlflY5tuHLKkpUXa9P6pl8Z/I2zwZYn0x+CZ
         SMAg==
X-Gm-Message-State: AOJu0YwdPi2yuAgjhsYIhAjpTJJ8W/a6d2R5gKHGw+89iUTNDVcSnVqW
	9TRumXfsm/oNWRo6ao8W2Lo00xZR19hKaX99xNAh6lheS8EDbn3adKhThtvBaaZdMLu6QDlnJVr
	LJL4wC5s+7UHb6f1Hv1GdPlroAwIKVaY=
X-Gm-Gg: AR+sD11dbIwOAEVLbQuO2jIuVHRp+k6H0+t1jClW/ssvUE4sNrNQqowFKsu+fy4NfyI
	KYJpg+VsZU8zRSh2luQxOQm39CMJPTmiaZaHf/gsFMHi+Rp1To9uZkGKdKxsAFOzbmfv9QoV1Td
	nRHBe2N1XWngp1lDEtzRv+vUGGjDtg2Sd5F0WjnIn3sfOsVGzXNEtSFl3+8GfM2MkNLKyZZeKAy
	LcwhCafDBrkxV/EJjyRKNZH0a+g5OJTGa6LTBNaIxURaV+/nTsu1tqD6/YG9JoF+7klTE1SZGdC
	WWqUWSVZUKphn5Hx+VvJ5PG1Lqh0YHu1T3xgb7vk1NH3ZM0xm2/AjTBY5+j6EEgYysCuZ4hi/n8
	GGs23QSly+QGktyh9XIJxG9stxkt5EQ==
X-Received: by 2002:a17:90b:5683:b0:381:26f:8f05 with SMTP id
 98e67ed59e1d1-3903c5380f7mr20655046a91.3.1786088350238; Fri, 07 Aug 2026
 00:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq8q6ih924.fsf@gitster.g>
In-Reply-To: <xmqq8q6ih924.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 7 Aug 2026 09:38:58 +0200
X-Gm-Features: AUfX_my0Bp3B8k-d3eJ_AjahD6VdnsNUxOcmJ3kAHMk75rT_J3gvP0c_Hpppqls
Message-ID: <CAP8UFD0i3fr8sNu6wa8iqfdy3t=j0aVHVpjsvks43WVKogSdXg@mail.gmail.com>
Subject: Re: Can we do better than "git checkout/add -p"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 6:02=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> I am doing more "git checkout -p" (selective revert of local changes
> out of the working tree files) these days, as well as "git add -p"
> (selective adding of local changes to the index), and what I often
> wish is to have _both_ as possible options in a single session.
> That is, the local changes in my working tree often fall into three
> categories.  (1) One that is clearly good, (2) one that is good but
> not yet ready, and (3) one that is bogus and should be discarded.

What if there is a hunk you want to squash to a previous commit like
HEAD~2 or to a new commit in a separate branch?

I think that if we add a new way to handle hunks, we should consider
more cases than just reverting, keeping or indexing. We could perhaps
take advantage of recent developments in `git history` to implement
the additional cases.

On the other hand, it seems to me that GitButler's `but rub` command
could do a lot of things like that, but it looks like they recently
replaced and split that command into more explicit, intent-based
commands (see https://github.com/gitbutlerapp/gitbutler/releases).

So I guess the main issue in designing such a feature is to make it do
many things, but not too many.
