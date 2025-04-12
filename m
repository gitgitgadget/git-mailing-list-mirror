Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E5188713
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744479294; cv=none; b=oVVYAfReXYdqwpniik0r22eOVQghn2uh5AWIROQHaGcz4t4O2Qfg48MJS+9Rsi1mNg/bO6bOlPcFx5k9siScJ3mwvIucpK51ZF3xCvqMJXhpzlwup28csllpLFleFM0cEZpSuFOVoxECahNcyUMdlDxMM8rwNJEv2AH5eXoSMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744479294; c=relaxed/simple;
	bh=yl9CnP6gPl3Ymai2ZZDXWFZpzXK5fi7DNhVxjIYtoso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IK4Qgfua0uKHtQYqwlpCza6dkzIEPpAR9V8b9v6oP41Yaf5W5czGcM4DCR4kIzlZcnNOrUZo49QIvbBZjZmXNJTUsmqKEPuDOLZwSJyVjSi6+uZz5/L0iPMFXFhSHPhHzydaPLCirz5naojKrGD0AFDe97c03Qu7mD+404v1PXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWLIBsFS; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWLIBsFS"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476ae781d21so29888711cf.3
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744479292; x=1745084092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yl9CnP6gPl3Ymai2ZZDXWFZpzXK5fi7DNhVxjIYtoso=;
        b=kWLIBsFSs2aXx/HvR1MuVREki0g3P2UEJI4OD2j/jqbl7/eKeRFjU2/nHPA2XZYNyd
         i2odnkc8IEer5kuNWyJUjrTj2RW6StMCWEtMhR5NiR5gbpW5Ah5sr9KTxMh1yvGzPT2t
         GAxlxit98HeBW/jwWYMvkojgv3khVkHNYj8doSbUMzNuIGZIXpIG9gGpRjvxXIillxhM
         7c7lHZQNU5+H8vE9QRiw0lvyzgU1AXGdZEbfNf5RZg171pLXxVhi9efi27mTPwG/GWqM
         KSayZqlIU68KIT2CgI3gEqLiVo+7AyfluUSzhN281P4d07RU3WsQbpbmk5Zkqkb0/yfS
         tfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744479292; x=1745084092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yl9CnP6gPl3Ymai2ZZDXWFZpzXK5fi7DNhVxjIYtoso=;
        b=q1FmIbPbEctR2YgKodlVfjDAnZQ4nBwITlw/w/4PJDG8c3k5EH7JslHGd3fj/OyItn
         sG7qE5UyKHmFU6gxamioGaHb9aGrboJzGWX4MhFhS8fJnHHp627HVSSrYq6zl1w699RX
         M0F+a2YmnGmvZheBbAMVG0fWdjBeyCcxUccY5rwDvWLM90RR2ofuWedyhOz3u9a4DymZ
         3JlxSh7FaH62F1hBIt3kDWu2CcRWUh9NRbprOWusoQaEXs0wFcp7WFG+K2goUMzWmNvc
         LCmCvBiaPUC/1/CB+yEYa8NG6VFZuoTQgx0Ce+bPyUlkgzLLRMd5YADeIBcjm4tIQymc
         Q5pg==
X-Gm-Message-State: AOJu0YycFjV3DpitV9Bs8VMce0UBTnQUg0kJy/+WZaf0pIlNPr7GpByv
	Lcx7NWjLNyN4U8dlIioi7kxZJOWsyfRF0dVTkSQwe8ZBbz4LOmdlBKd/PLJLQQeO+la6578RSm8
	sRibgMiPyLqiZQy6GTx4HrlOsfTWoVw==
X-Gm-Gg: ASbGncsux4vAzXp9+Nd0C4z3S+GDX09tLtVXiHpz0Sycm9Q+lsaym2fdHHN5STJH6Vt
	BMEsvmM0AgLI1HUke8ePmOnJpMwg5vNZIuG385vNI/IMeMY4oIfGwE+h4zzceZuHocBfkzBnk+W
	KI9lnReL2vHvIEXOejVLL7DkzCAvDzyqZEVgm14mPO/n6QH1g3U9YtBj4=
X-Google-Smtp-Source: AGHT+IHjU8xcjmPw48fLr3rSckLHBgxYWOyGh5kzB6cDkC/EkhtKn+na+RarFNlZABKswbHfvupQB7vlzh08+X/7ApE=
X-Received: by 2002:ac8:5e4b:0:b0:476:8288:9563 with SMTP id
 d75a77b69052e-47977509462mr83572351cf.10.1744479292050; Sat, 12 Apr 2025
 10:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412094607.236382-1-jayatheerthkulkarni2005@gmail.com> <9EB38EEC-97EA-4F8D-BCC6-883771203755@gmail.com>
In-Reply-To: <9EB38EEC-97EA-4F8D-BCC6-883771203755@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 12 Apr 2025 23:04:40 +0530
X-Gm-Features: ATxdqUF0rbwIWdJHg3oJAJI531dmxGI38BADBwD8OnTPSlRNkh01QQF5JPnLx5Q
Message-ID: <CA+rGoLdDVYKUz02dhgPy50nhG-K-cjyLUySFtunGL1+f=AD7wg@mail.gmail.com>
Subject: Re: [PATCH 0/1] add: fix pathspec handling when literal filenames
 match wildcard
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 9:15=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
> Hi!

Hey Lucas!

>
> The original bug repot included some simple steps to reproduce
> the bug. Since it is a corner case that wasn't covered by our
> current test suite, it would be nice if you created a new
> test case covering that.
>
Yeah!! I was testing them with options like f** and f\*\* for specific
file additions for commits
I have framed a test frame in t-3706 which is the add and pathspec
coverage as far as I can see.

> PS: Since this is a single patch, you could sent this without
> a cover letter, putting your comments after the scissors mark
> (---).

Ahh I do that because if I receive feedback it forms like a good
summary in the beginning.
But sure, I think the *scissors mark* method sounds good too!!

Will send the patch inline to this email
I think you've worked with Tests in your microproject
Drop some feedback. Those will be very helpful!!

Thank you,
-Jayatheerth
