Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF52E3019A3
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763668360; cv=none; b=rJkaCxHzGjMiB3dNgEhYf1HwVwgLCVbBfUjQUw0XVB8UlXQRHUCBSXGFWPLE17Ij36tb/b2ZkHxhD75O0OQMKKBQQqP0jmSSd+j9YgxoPCflOoMGdO3DlSKJnpmc/i4moZK2xMg3B/vpnYxHwW31WslbwtagxftN4viHYsP9n40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763668360; c=relaxed/simple;
	bh=N9Pc8szqIYS1MtfXjtG6BFgUei+V1E7hsPW51O7QhqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=d6F3AGF9CIr4rfcBDusPYb0Is/X8D37NbMJ7rAaY5WdRGh3Wt8EXRlkAaW1KP3pPMNlQvR2NXuM/yL6ugQtufQu+jWKqMSaxbGgkhYBfOSJmC5iinP2I5UE9WlI6kfVmJpdR4ETM3sLdmT11xts0SxIMK3ZH5q1E1ddxftHeyT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHoFcs14; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHoFcs14"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37a2dced861so21438641fa.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 11:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763668356; x=1764273156; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8y3uHONVnG8Mz1Tt+STk0k4SiN94aEWuhpAKdolyY0=;
        b=MHoFcs144Z8tGLuK/HjQY1kRjQ4+P4RcECp+qjb9IqfMJWw53jZcYZKu4+0lFmyPw5
         prqecxLCTpHP9TM3kyQBmVltDbOR4Y8yLkGh0YU7AM44nkeKN4mwn8e4xhRTA3lRdH0O
         atrKzdCnF+OfCZJ8uL4MwITWvB75wfi5ljVSK7Br1t4qe8u9guwwbcCvPx7sbTmag/Oo
         DlpenKFI7V8Ge3EgmusvDmzVRT2jbnKk8cL3IzXte+khnS0LYz3zx8b94vRZuKF3pNiI
         uv7x1Xlo3i6Ua9qamqtjXYDMTFgosR4e3dBZl1thDCNGLtrKw9bqS7PwaCeNyJrx5b2L
         WI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763668356; x=1764273156;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b8y3uHONVnG8Mz1Tt+STk0k4SiN94aEWuhpAKdolyY0=;
        b=v7myxNqo8QRQr9y3gjkkBn7GLFxrF+fZgnRvX54q7f3bqcvw5/DxIXQAFQYm5tgInm
         JOygVP7NzADaSt5APm7PUij28pniDJ7sr0eoWISbmY7UyDNrIOm5vOFxcsfxuN4TtBKR
         7Rj2eTd+PdKXSX5tR9FsbgnWjoqo+R1vCD80cVSI4SjAO6S0JrEyu6pdiYiDQq7FGSZN
         LMBomwnB2Ntj2+m/i2UTjcGYABe/kHH5ogTogS4t45+NVaERgYniGtNJzRhX11NGumtU
         bg82Kf8dHtaphTInFe7n3J3WyP87c1dPH03DLNnkYRkCgBufu5wuClaY0a62Jjd73nSE
         IFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1KBa7k4HJuQ2wFgb8iwp3e+lPwEah7DUE/LOGy+DlqSnRqPpR6ytmV6OGfftu36ynoKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMaex0lrVvAK23V4G6jTTMcj6CUwQbNdtjqvzH0KHvxQc4jztf
	NCE5ZF1yESFnie2JPTDQFTh1qCin8oCtPhE3Ae0V018iGqwsZ2Uv/cuARW/YOsDDczii0iTL2x7
	YVi7cyYlHn4IRFq2BBTjzu1C+GIVkj8o=
X-Gm-Gg: ASbGncv7llMHMUnwK4eDCTu2WnrtngTq61kI0yWsjWqdYTOm1bP5kpIs7aJk757dH6k
	DhY2Ra/9YzWF3LVsBAPEfMi4AJHpg9w/wVm/ggc552i5/r/hfYgZ8d9HHBt+M9mNneokJp3o5pQ
	kIESNoWc2czf0MABl9CgE3cLmZW7pV7MIQdigg1bTklyCFjiO5D/hkJ9gidNpogUTUsUbfK7Bnk
	2BiPXASgwbTlj5yTSespUQ+vlErTHyUkF0ZkVQGukKMOTUnpYyXSNGMjThRjVl9aGmNtnWo
X-Google-Smtp-Source: AGHT+IGcxNE/9sc8taxqyWg+7y8IgGarwKfkbtbrJZmBe6Y4cqJbZXrq7GfOObaTPzoBhUwrfzn0jkQN1AEB3fmrfoM=
X-Received: by 2002:a05:651c:b1e:b0:37b:a4f1:e4d1 with SMTP id
 38308e7fff4ca-37cc82c0799mr10110571fa.9.1763668355556; Thu, 20 Nov 2025
 11:52:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <xmqq7bvsjzlx.fsf@gitster.g> <xmqqpl9h9mgo.fsf@gitster.g> <aRudLpkRdRtCAoi3@fruit.crustytoothpaste.net>
 <xmqq4iqsgpu3.fsf@gitster.g> <aR5M65HDuGlTsR77@fruit.crustytoothpaste.net> <CAH=ZcbAmAqWMYXhYT3bX_Q8cEkV0ZcjEtM65YS7DXPJbs-L3Wg@mail.gmail.com>
In-Reply-To: <CAH=ZcbAmAqWMYXhYT3bX_Q8cEkV0ZcjEtM65YS7DXPJbs-L3Wg@mail.gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 20 Nov 2025 12:52:23 -0700
X-Gm-Features: AWmQ_bnv4n4gyCTtChzCEeQAjgifFnkSlXxB_Olrrok6iFC9AnsUoV3EC5dsWFk
Message-ID: <CAH=ZcbDER4OysywLZpCc=-GQ+rweSfVAQ-xj0gNd1rF4-=cPWg@mail.gmail.com>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 4:37=E2=80=AFPM Ezekiel Newren <ezekielnewren@gmail=
.com> wrote:
>
> On Wed, Nov 19, 2025 at 4:04=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > On 2025-11-18 at 00:13:40, Junio C Hamano wrote:
> > > Thanks.
> > >
> > >     $ git log --oneline --first-parent -4 seen
> > >     3f252ac9fe Merge branch 'ar/run-command-hook' into seen
> > >     672cb7c62e ### CI
> > >     3af201233b Merge branch 'bc/sha1-256-interop-02' into seen
> > >     950efaac03 Merge branch 'cc/fast-import-strip-if-invalid' into se=
en
> > >
> > > It seems that 672cb7c62e (which is an empty commit on top of the
> > > merge of v2 of this series) fails win+Meson
> > >
> > >   https://github.com/git/git/actions/runs/19447841443/job/55646336507=
#step:6:689
> > >
> > > but 950efaac03 (which is the merge before v2 of this series is
> > > merged to 'seen') is happy with it.
> > >
> > >   https://github.com/git/git/actions/runs/19448271167/job/55647611566
> > >
> > > These two runs roughly corresponds to the with=3Dbad/without=3Dgood p=
air
> > > in the message you are reponding to, but with the v1 of this series.
> >
> > Yes, I think we'll need someone familiar with Windows to take a look at
> > that.  The message doesn't indicate anything obvious and I don't have
> > any Windows systems available to investigate.
> >
> > My guess is that it's something to do with the build.rs file, but I'm
> > not certain.
>
> This was a known issue, that I pointed out, before Patrick's
> "Introduce Rust" series was merged in [1].
>
> [1] https://lore.kernel.org/git/CAH=3DZcbBjL09Mk3AXBSgmZGvmFtU3Roc2P5rbQs=
Z-U5DBHYSs7w@mail.gmail.com/


Checkout my retrospective review [1]. Basically if windows + msvc ->
<crate>.lib else lib<crate>.a, but it was coded as just if windows ->
...

In the github ci these are the only windows combos that are tested.
"win build" is windows + gnu + Makefile
"win+Meson build" windows + msvc + Meson

[1] ci windows problems
https://lore.kernel.org/git/CAH=3DZcbB8cRgCTp-Q_CxJ4VFNY1+w+C20zgx9bMre4-hN=
mPrD7g@mail.gmail.com/
