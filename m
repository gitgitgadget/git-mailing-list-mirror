Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59125CC6C
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763091435; cv=none; b=VCCntpzrLwdcd//Ww7p+YakEXimrrLBNEqb34Ba1vtjtJDpwPP2vrPbztNAa5egYzgummZzn1V2VjEp+plIQPWMKnoalxnUpupF6FYUrgNlI6CjNTmYu/cEiJJBKo3N6tNoeN1PLqDlzrJjZporNYbwEmh0SFT7wc9nqrc6nYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763091435; c=relaxed/simple;
	bh=Hb0SAOO3Nm8ExQZeM+KgAw0UG65pTwS1c/Mg25C7MiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hZpjx6lflDimqMl9oV+Pq73soytbUwefEPTKFBZedLNYHlp2Qi/ZbvkbhV+7UVWVjlLsNbi/UxuGvP11cL4dKrZhhx3uIUiMLSYKayZJlZHAIsnA7P+uJHF96oKcUhgC2iB9se3JIOMMucgtrFnPk5reFOyxg2lAWndLjAhnQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=1fB3k01z; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="1fB3k01z"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-343f52d15efso1073823a91.3
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 19:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1763091433; x=1763696233; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjrYlh8+2IzNQ1TPcPm0EqQpToeQXqfGj+ik8eN+cig=;
        b=1fB3k01zttel3OflI47CDj8889VG9Rv+S20Sr07wRzBqXeccVsuxHqIGYnQ/+2O6LW
         yZBXdGl+kOKIaXlIyGCGEo/TR89gqDodq1qrA6rbTkmfXvo8j8Ik0X8G0+9AZZ7nAC+N
         z2jpicTnoGd1UGLVsEk47q7PmV3P22QFTy1lEzfYeAd5Jhee2AxN/a4Ru+TReFnogX7f
         QVBzeafS9B+MH5tKtHNmZboJe4Njks5fCaBxym14RGl1YegxSP05TmpIKkmGv6xpDUEF
         /AfhRUiFyglMNZ8mpacBbSXVmCfHyCPPnNWBKZjlhy5jltoYRxbDrjAi5ysM6D4t62aR
         g4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763091433; x=1763696233;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BjrYlh8+2IzNQ1TPcPm0EqQpToeQXqfGj+ik8eN+cig=;
        b=Fr46+Bo71l5HkcHFbpwLX4b27u3o7vH2uKWYdMfzM1xc5ruJR4zyqJrR38ZXjRw6p5
         X81d2S+2/GIRFbgEJPbueok2jWNoCmrM35h8fvMXl4MHAPWvf1h2nFucLszRRYtDJnkS
         +EhefJqT3x1SDbLjPv+sRBuRavuhlYnh1IKDF/B3z1nIZg84h4NHwXebpbt1LS39AUgK
         Fle+83/JeMxQRmjU4+AyOsVFnNBiH96/zfMoHZoHy3bYunRV9D0LCdc+OWkUaAPH7gLI
         eDr0Yid6SzaOa5yEQDsS87jz0rZrYbBvI8aysp34AgyIosVhYJTmGboM4uINqwgGhPvQ
         21BA==
X-Forwarded-Encrypted: i=1; AJvYcCVzovGd1qVNSD5lZPaeZOML5fAbSQD/dl74mHqGrN2DRKatBJx9W1v9nqgE6fTQnBnxgjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRyy9zeJdd7zmPVNgfUE6pBRO8Yr7Cl2nSQxshkH2g5o/UvJcf
	sGyvtk/d+tm+oS9eyT8kfT93LeXaWnmeH4XjsP/KHLZo4TUDhP80DSfv3kIVDF0Ody5ExiT8Es4
	QX79YL6IzfOKO/M3i3isXvHi8prRa6t7erS7Ph0iBWE2uRK+qH/Bc5J9d/IFyVDGzhJeA+kyhHd
	S8HXE2hgqueQOTI3DwkxK+nvaZR/Yapv6piOO1YVUtFvqL4Y+HqZVAwop0C36D9AteKStRhZIP2
	6CrT0DKNq+9ZmV7qerchzyd9TRU9OWXz0E1ltf/pmkAAz8B2Vr1N7yC3jLZPU8sPWX0XU+tIHf5
	tXBAuoRmZFXO5tfFqBVUodB78O7z4Qg=
X-Gm-Gg: ASbGnctqRw1Y1CTNJcfk7CUBqGue8I7uqLykEV0M5ObesBookemzx+xCPqsr3t0Vq7D
	Ap4nEaVdw8yqX6mC5/o5qZxrwq68vJMcLNVXvuCoBJseoiMef5Z6LL0oTAVyzUFrPj9p4wbAAql
	dJ5R6s/GpnmL6AV/WksTuMbgfel+D2L8JeyJMQnezgg1N1Sm775Pn5vktJBSLjmzw10kkRKifil
	EZZw5LIyd0OwFvz8vaCLPk+BY0Gf/k7kby6tpEbaEnOl5SFbZvURuXJXUdhrYIA2qPaAsCQUfdo
	qWJxgO4=
X-Google-Smtp-Source: AGHT+IE/3phXNfhhraq2X87U/PGNOujz8x9t0Zydts5pYz7SVGgwtJP+yaxkBfLTlfhQT3ZrQny+yJO9vPq4SH+raUI=
X-Received: by 2002:a05:7300:a905:b0:2a4:3593:466a with SMTP id
 5a478bee46e88-2a4abaf402fmr776702eec.6.1763091432484; Thu, 13 Nov 2025
 19:37:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1998.git.1762930881599.gitgitgadget@gmail.com> <aRZqLp__WdA4hbuD@fruit.crustytoothpaste.net>
In-Reply-To: <aRZqLp__WdA4hbuD@fruit.crustytoothpaste.net>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Fri, 14 Nov 2025 12:37:00 +0900
X-Gm-Features: AWmQ_bnPUXfSdo56Xt4mlrv_gm4tCzYT4NHkSA3TXCNhAz50L_bjGCEQAShYp5A
Message-ID: <CAOTNsDx77ni29S1tGNi-3Nhb=XpT2x72gg4PesxGXfZO0Ke5qw@mail.gmail.com>
Subject: Re: [PATCH] Revert "osxkeychain: state to skip unnecessary store operations"
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Koji Nakamaru <koji.nakamaru@gree.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 8:30=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-11-12 at 07:01:21, Koji Nakamaru via GitGitGadget wrote:
> > From: Koji Nakamaru <koji.nakamaru@gree.net>
> >
> > This reverts commit e1ab45b2dab51f94db9548666dfd7af626d2aa7e.
> >
> > That commit was trying to skip to store a credential returned by
> > "git-credential-osxkeychain get" by setting
> > "state[]=3Dosxkeychain:seen=3D1". However, this state[] is kept even if=
 a
> > credential returned by "git-credential-osxkeychain get" is invalid and
> > another subsequent helper's "get" returns a valid credential. Another
> > subsequent helper (such as [1]) may expect git-credential-osxkeychain t=
o
> > store the valid credential so that "store" cannot be skipped by just
> > checking "state[]=3Dosxkeychain:seen=3D1".
>
> I believe the intended approach here is that if we do a get and the
> credential is invalid, we return the same state[] header to erase, but
> we should not send it to subsequent gets for a new credential.  However,
> we do need to send it to subsequent gets (which will not have an
> intervening erase) if this is a multistage request because otherwise
> multistage requests will not be able to keep state, which NTLM and
> Kerberos require.  Does that make sense?
>
> My guess is that the problem here is that we reuse the credential
> structure without resetting it somewhere in the HTTP code rather than a
> problem in this particular helper.  That is probably my fault, but in my
> defence I would not say that the structure of the HTTP code is very easy
> to follow.

Thanks for the explanation. I misunderstood how state[] was intended to
work. The current behavior seems rather natural now that I understand
it. It might be useful if we could optionally specify that it be
discarded under predefined conditions. Also, as you and others
previously discussed in [1], this topic is delicate and interesting.

[1]: https://lore.kernel.org/git/20240510200114.GC1954863@coredump.intra.pe=
ff.net/

--
Koji Nakamaru
