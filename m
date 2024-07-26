Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F1E57E
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721974573; cv=none; b=B9I8xq+76LO8xA8+e4adOIrSI0AATSmpkDdtVuXoi94BA9rWzG6/v376cPWirVEeAvJgoehp+VmeNMMVsMUgTOgPBPydZPZwiyJ4me7SO+YJHW7gBMo49cdoB932oWUmPfznXfdGgpIK3Ss3Eh8F01qDaSbKYyssFNTwumBHePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721974573; c=relaxed/simple;
	bh=3AjmxYPmwutpLOQp2oaoOe8OX6yxZA0Ppr9CUKxG3ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeWreb3DfVaix36lAySZIMP9SjPfEfIj76+eRlvxRQRHI5wZEbOLmuYUBB4Mn6nkjigeaXYoASv14VuV9ZornhiZ9aDSXSzLcE1OvbDdWFEAYGVmLxJIvXaXLa5jvxLGj92iD/LvYAi0ZUhMw0qKsa/3cQioeIg6Ha/oiTn1gUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b795574f9dso1953236d6.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 23:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721974570; x=1722579370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjKK0UfrAFutDdN3k2b7K4dIxJQ0gb2jyjWAj6zp9GY=;
        b=J8cPYlxVUZ0Ki09/kscaL3alhsijmbeUSR83E9Yu03pQPwmbtcrm7q8MFeeT9Kwj0c
         VRosv3Sj4JEVHPraT/uwMVWVLhn+L+YfodJ5arGHhFwnTsnlPshMez+o3qoFD+B9QN5W
         ax/ia+6oUSQH5M3vuihBOiIShHlBFnUtmm9H4iYL2QwTUaFDm2j6e4jPprVlJlo2amie
         ut4TuXDawZ6pksHJ3QI/3x5v0xFmZoX3NtuzYj24hda0Qa8Mzz6hQkDj47dSYIgApogN
         ASdeZOWPuBqVZwuGwjlHonQSRdPLUdPrCW9QLg4LMRaEKn78D6kZxpsnbM95SVUKX7+W
         ETqg==
X-Forwarded-Encrypted: i=1; AJvYcCXRZJYxH9uwZ3tgvGSgqWcKtfFrQu1+bCEyI7I/T1D2v3eLa4qY9gKxCUI9MMXSUU6RTT0J0lJtd5cjFcxX/tEDwQLC
X-Gm-Message-State: AOJu0YxT+HneiqIDgkv3fhaPyYQHj1yAtgtgDcH14WcSRMg8jfkAAW0u
	DbPP/XKJsItPsMgPGzA+mQw11SqGdZt5Ofdgik0YdK6gdvN52/wKX8RBG3FIV7wUKSQrDL3/3RT
	C596LCXtiGAirDJ5KB8zU41u0TFo=
X-Google-Smtp-Source: AGHT+IG+bjAyNYiGENrD0+XJe4FjgfS1WxDrEu1iAz1Z3TTNuuHH0TuDEh63ImgU4p7msDApEqgAn58lg1/pY0pgW+A=
X-Received: by 2002:a05:6214:20c3:b0:6b7:4459:7dde with SMTP id
 6a1803df08f44-6bb406eef65mr59746796d6.13.1721974570563; Thu, 25 Jul 2024
 23:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240722065915.80760-2-ericsunshine@charter.net> <c586f7dc-636b-45a3-acb2-faedfe1068e6@gmail.com>
In-Reply-To: <c586f7dc-636b-45a3-acb2-faedfe1068e6@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 26 Jul 2024 02:15:59 -0400
Message-ID: <CAPig+cQNfZp8Sh4s8ukF0Vto-+RqyHeTM0jJK4mOJhkmxz2s1Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] t3430: modernize one-shot "VAR=val shell-func" invocation
To: phillip.wood@dunelm.org.uk
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 11:10=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> On 22/07/2024 07:59, Eric Sunshine wrote:
> > Unlike "VAR=3Dval cmd" one-shot environment variable assignments which
> > exist only for the invocation of 'cmd', those assigned by "VAR=3Dval
> > shell-func" exist within the running shell and continue to do so until
> > the process exits (or are explicitly unset).
>
> I'm not sure I follow. If I run
>
> sh -c 'f() {
>      echo "f: HELLO=3D$HELLO"
>      env | grep HELLO
> }
> HELLO=3Dx f; echo "HELLO=3D$HELLO"'
>
> Then I see
>
> f: HELLO=3Dx
> HELLO=3Dx
> HELLO=3D
>
> which seems to contradict the commit message as $HELLO is unset when the
> function returns. I see the same result if I replace "sh" (which is bash
> on my system) with an explicit "bash", "dash" or "zsh".

I believe downstream discussion[1][2] established that the behavior is
inconsistent between various shells and versions of shells, and is
considered undefined by POSIX.

[1]: https://lore.kernel.org/git/xmqq34o1cn6b.fsf@gitster.g/
[2]: https://lore.kernel.org/git/xmqqbk2p9lwi.fsf_-_@gitster.g/

> I'm also confused as to why this caused a problem for Rub=C3=A9n's test a=
s
> $HELLO is set in the environment so I'm don't understand why git wasn't
> picking up the right pager.

Junio summarized the problem and explanation[3].

[3]: https://lore.kernel.org/git/xmqq7cdd9l0m.fsf@gitster.g/

> > A common way to work around the problem is to wrap a subshell around th=
e
> > variable assignments and function call, thus ensuring that the
> > assignments are short-lived. However, these days, a more ergonomic
> > approach is to employ test_env() which is tailor-made for this specific
> > use-case.
>
> Oh, that sounds useful, I didn't know it existed.

I didn't know about it either, and only discovered it upon my initial
attempt at making check-non-portable-shell.pl recognize the case Rub=C3=A9n
identified, at which point it started showing false-positives on
`test_env` invocations. Actually, considering that I was involved[4]
in the conversation which led to the introduction[5] of `test_env` by
Peff, it may be that I did know about it but forgot.

[4]: https://lore.kernel.org/git/CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVC=
i29tR1P5w@mail.gmail.com/
[5]: https://lore.kernel.org/git/20160601070425.GA13648@sigill.intra.peff.n=
et/
