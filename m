Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E5D3E4C7F
	for <git@vger.kernel.org>; Wed,  6 May 2026 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060464; cv=pass; b=CBlGz+ICr9lwFsHyQGhNerCuKSJuFmdMpwU7WVJS5F/+8uolFR9NrexbXsksh/0S02Pd1NovGMdf/thm1PVsSyHT8NhakAyW5k5LY2h6WFM2D3U5oU7WFvvpz4KzHJaiOI5p7CVCKfYxTeRRKgDyE5ZpZ9r0f/OYp7D5FOIBJ44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060464; c=relaxed/simple;
	bh=KdOStq3XKz8XrDUFw4g51sxwDYOZ7QuJWAdARkQaks0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nC2u+StWVRGoJsUP2S0mWv/i7E5y6haW+vDzN7Qv3RrShv1VzcKwBfK5GZfXWxJtU89U89sJ6Ur/LJnyQXJMNOQ2npvrwhj9ysQfAYxB/YxLWSsyi73JN54AZz6dpCh6aHJw8Fjo2w6MF1JVfovaTacnm1HjBqPJT+e5NxxLAd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LX5aFLrD; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX5aFLrD"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so7167307a12.3
        for <git@vger.kernel.org>; Wed, 06 May 2026 02:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778060461; cv=none;
        d=google.com; s=arc-20240605;
        b=jyySrtyWbEZeMPVfZHJVoJYAzXnnU4eCn/05QNypEprZB3zdFcpYm11ZmU/6HdiGOB
         bYfffxiqMuIK2kdH++lmIa0qdCmTiE/oFHrtR4bRpGYz1FhtASsQvvxERk2YCwvsM24a
         ZhIXAB5tdYVlVaY0FXP5HhTr9EiBhIufq3gvvy/zeQ10leL5bUQVTXvx22RYZVj5LRNz
         feMm+U2zNt6asBP7ZgG2gT3IZ7Rc0e4HmRL7X14nsHLlolM4vbVWKRHE7aZSEBiacS6K
         DeYaFpwX1PJB/Pl9mMRpoUt/fQ9N3UzImRw28ehl+p6obnYlxJ8AchdzvN996Bbb53Ji
         nvgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yPmIgzO2LSs9qYcawY9W47AXm3bqWRz3FzhQI9tjAw4=;
        fh=wtJ0zwTnczRfJHrS5sT8trDgJumNozAvBACfJU4z+i8=;
        b=Ci/W8g6sjP6GcaphMutv9QOkWsUwG0McerSWoojFo7t1AN86oc05e6qcmDnDg/tBeA
         LdrlktPbkpU80kQpNP6O+Icukvkai4NVgHPPT4UKT7jhzg2c9ZcQPYHCSTk3K0feGxYF
         frRcgVASc1Qm8AZ5c9YVU9r/7lDp5FE+MLY6kbKC6xEcOXTSpjqtGMUlW39sAF82h7rv
         tw4k8yzC4FxrIV6rLHeUEdKcN6Ki0GsiwGySG2fycZmZjRj6itX27e/zDwIyUc1f/nyO
         yFcm0Ffno/Yj1f85HiogdvSPUmVF/wN514rWJnZwdhVvluok2tAEDln3K7GTwP82JMFr
         kb2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778060461; x=1778665261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPmIgzO2LSs9qYcawY9W47AXm3bqWRz3FzhQI9tjAw4=;
        b=LX5aFLrDyyniingSVFYmEbVAbDPIHK0y9l3fittahyIrUjg9Wms4Z+B8F92SADnU5C
         YTnuAQ3fEQ7Ne0mDA1A8BzmAl8LRREWlTV5nLtcL0ppM5Kw40+PXiMiPb056PeeuO3/N
         m6xqihjJPaWZ0v97RTsxTMPSnodyyYxSaSZRlPMYMBl2RSg2PruI6JroQDzwgbxhRdla
         dzw5SAb6jo37usSvrA8g8c+efPoeUdhzH5n1of0IQSmR+GzAkVRMmBdHePpjUV0LZmKF
         UT8SBSPhtk6by/izAZpB/ivRbcB66NPaDVunCuREPXyAqGEBABTlAinAgkbSds+Uegov
         K6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060461; x=1778665261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yPmIgzO2LSs9qYcawY9W47AXm3bqWRz3FzhQI9tjAw4=;
        b=BXqVBkwKu7W0kIe0Ks4O+KbdbLr4YzXZCqS3cnSvxFEQKsTEyiu+NzayCRJ2D3xgHF
         JNses+D0pYsTZKmqdohWojJsBfTeW5vt3sRxWp8/8ZrsyortrJIW8sEXE+N3nizMAQ2S
         07XniK5eFCyw9NEbqSCNwPbrajO5WaVz9p28FBs52YlZB+q20DuJN0yB90IXnEGirLqj
         X5UyRY82xKoDypaJLl3SUYEhBNqx8Ocj+XUNFnoZmpi+codPXWsiHmAEWBmF6OBd/7zM
         gupdTG45mPP4QmOkpQf9FfScDqchsA9Sa56UlxKbGME4VE6HPZlPSlWyewjiWD2qjFV2
         taAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cBumj8L8jHM9joP4f0nRA/G7ItJR4LW5py4CsTAMQD+4LDMaU46A5HSUtDEHleChKuZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7l6VkdEABqUEnn6erK23QdQl3NqLWpCTfixKer8Tb3y+bvQk
	zP78mIBXE01PSggMY3q0qF+T5MtfRCfCfZljwW9JqSaRl0iuIQy806UxMOdf1ARZvPte2Ne9/Fx
	z528T/LJd5nB0fj5bJOPEnghF0V5cLm8=
X-Gm-Gg: AeBDietPLEmztE9ABGh3/8fEjfrw864ZuK+6FOXf5y8ibN4DjGey102kqHPwOOAKvBW
	ATNiZXAnjDGTGY4bsP8gwOOpnmJI9FJl94zf/kUlzuEVh8fOfG8tTNYpMx4WP4iFzmWdl7j1TOl
	lGmqdoXuiPhhkFH1arAZJ5d9+TZNW7JNcuUM6qnlK0L5A13BIuPD/yv+BwxYy7a1TsdFq0Oi7k0
	HsPAAH/M0VxJI0gRSxBN36DwDgtNVXgDs+N/UahEas3Zp3XBnMsHDvspOABCfGGDPjp8KVXvTtc
	rKM9RfgykATZagb6
X-Received: by 2002:a17:907:c06:b0:b9c:9594:e00 with SMTP id
 a640c23a62f3a-bc56aa4283emr129069066b.1.1778060461292; Wed, 06 May 2026
 02:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d3f5504-f5dd-4171-96e8-b5633b6a1f5e@app.fastmail.com>
 <CAPx1Gvf5Vts3oS2BdFQ4PpCR-UY=5cYW7fgOkRuQpi8ug2JXDg@mail.gmail.com>
 <3364c573-b7f4-4ec0-b471-312aa11028fe@web.de> <CAHYJk3Q6xjW8mBvbQkN3vsDb2e9Em6PuDinFoTFwqkTXaKK=rQ@mail.gmail.com>
In-Reply-To: <CAHYJk3Q6xjW8mBvbQkN3vsDb2e9Em6PuDinFoTFwqkTXaKK=rQ@mail.gmail.com>
From: Mikael Magnusson <mikachu@gmail.com>
Date: Wed, 6 May 2026 11:40:47 +0200
X-Gm-Features: AVHnY4KXh5TCjKOfwPYbbllqUSxBrx0i_sS6W_SvE9ZAnsvrhtm2Rg22ybs6NGU
Message-ID: <CAHYJk3SW-JwWwk2h=vfDQ4udwQoW2TrmcntiPVwjUJSGiLU2wQ@mail.gmail.com>
Subject: Re: Git trims the last character of content from remotes
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Chris Torek <chris.torek@gmail.com>, Hugo Osvaldo Barrera <hugo@whynothugo.nl>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 11:37=E2=80=AFAM Mikael Magnusson <mikachu@gmail.com=
> wrote:
>
> On Tue, May 5, 2026 at 9:46=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> w=
rote:
> >
> > On 5/5/26 2:34 AM, Chris Torek wrote:
> > > On Mon, May 4, 2026 at 10:02=E2=80=AFAM Hugo Osvaldo Barrera <hugo@wh=
ynothugo.nl> wrote:
> > > [snippage]
> > >> When the width of a whole line is the same as my terminal width ...
> > > [snippage]
> > >> ... sideband.c prints ANSI_SUFFIX =3D "\033[K", this escape
> > >> sequence being "clear the line from the current position until the e=
nd of the
> > >> line", and this is the root cause of the issue.
> >
> > > If you have a non-empty prefix
> > > string before this "clear to end of line" suffix, the solution is mor=
e
> > > obvious: print the ESC [ K as a *prefix* rather than a suffix, but
> > > that fails with the empty prefix.
> > We do have a non-empty prefix, but why would it be necessary?  What's
> > wrong with clearing the full line starting from column 1?
> >
> > Anyway, do you mean something like this?
>
> If the purpose of the clear is to reset the background color on
> wrapped lines, this will not have any effect, since you clear before
> the new line is wrapped in. (This is a bit of an obscure edge case, if
> you set the background color, and wrap the line, the entire new line
> will be scrolled in with the active background color, then you write
> perhaps 10 more characters and send the sequence to reset the
> background color, but the entire rest of the line is still brown, or
> whatever it was set to when you wrapped).
>
> Example command to reproduce locally,
> % echo -e '\e[43maaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\e[0mhihi'
> (Add more aaaaaaa if necessary so that the line breaks before they end).

Sorry for the double post, but I forgot an important thing, this only
happens if you *actually* scroll in a new line, ie if you open a new
terminal and run this, you won't see any problems until you get to the
bottom of the screen.

--=20
Mikael Magnusson
