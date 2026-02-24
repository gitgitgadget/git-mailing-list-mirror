Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77571F92E
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896885; cv=pass; b=s1hICF6vScwP0jCosodI4aCVu+AC/RnXdPZriMOGZwvEY99jy0+GyjzuhW9UtiE0GQTXe44LurTG+dHLtRgXv2wEsQJKUjr/TxpZ5bVUR1/atr+Kzvq+puU6DcNyWlXpazN/wAhJvxeWZhIP+V5PoaHww7S+cfcQWB6uF+I1oHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896885; c=relaxed/simple;
	bh=htJa3ONwKX7UmCj/ToV1w6+cif9XfYmUe626BgTbDqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dd7oeWf+ZYuaNBJiIWogDohI9mOwzNb5ph/ytq7ODp2jKAi0sqv6LvqtN9L2eeZE3TIGh/REdUmlu/j+Ks3KMqiV1gIgURW71hNl8DxUrSGeT7xHMWB9bR6oUNFi0PmmcmyruxkBo2LTGnQbeaNxXQOzne0mf2m4os3Z6nMfu0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=paultarjan-com.20230601.gappssmtp.com header.i=@paultarjan-com.20230601.gappssmtp.com header.b=Ksf5MycK; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paultarjan-com.20230601.gappssmtp.com header.i=@paultarjan-com.20230601.gappssmtp.com header.b="Ksf5MycK"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7984d30f2a9so13193177b3.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:34:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771896883; cv=none;
        d=google.com; s=arc-20240605;
        b=gkjEKbZrmdZV0pJKYoyhH91iBDAZrEsh7oVapO53UGpwIfQG1u5rrgufBUft7sqqgL
         76pv55Ko02IlORGczyG+HQ9ljxZ1MvBz+HnZBbSFvJpkpexDyPrOu2oOU42il4r2cgQB
         8+JWRtFj5YTHNcGYkueGsqbCjBxBugNUxuH5lT7dOKrX6xoEbwqbHcOcQUnQe6cpkbMS
         dYEhLWxafgUzTBpRa6ZlA/97okz/U4IOXO1jqd94wfjF5Z9ZHXr2be+l11O5lFITavEt
         V4d0V29eYePmffUI32qJDkQGa2SiwpXr3W6wLRVpDmM3HxN1JFGPQC79WPTYKaG6Vb4k
         4sDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mp5iFZ4HHPtX0KdhL1P8h2/HwlJMtJOzuS1lqN2c4+I=;
        fh=bS4OIDjPMF8co3qmmkpRFinSgkAM3il30GhEmbeR6RM=;
        b=a1i3X/kFCMl/e+VO3Raz4mOLOVuLRtYvNRheMtK/urXg6Tbgh68cNfJoKsUb1wsfTw
         xZvgM49P+aX3k0aTRWsHy9cTLelyNbLIJJQiq73N74PYBYtNK0+hulmkYwIynqOcuNsU
         /qiQnJ4mR/ZwsWrCbKr/yknozB67cjSANRgd7DrKmxdgGfZfu5u104xJHipDhhacaYMD
         O3B7QeJcItTR62S9L4COZACTF4mABg2obJz4qEdolv5aqdHwPTGwwRjOL4Jvc+HnozJJ
         syWYcpoRPwHt+r180MoFVsMKp9+olRXOWWbaNKb1ErKpPns14eGLr0WqvVS+/E/TXx68
         zGyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paultarjan-com.20230601.gappssmtp.com; s=20230601; t=1771896883; x=1772501683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mp5iFZ4HHPtX0KdhL1P8h2/HwlJMtJOzuS1lqN2c4+I=;
        b=Ksf5MycK8wyO9SnJralszm88ABFEidakKkSS5WzUXAtqerLumUyQ1hgQvp7HK3Yj7h
         /zY1NzwCTIdVBY3amXO9AFLhRIC7/mOBybx4t7XZ5+0Fx6wOZCh+JkJstCxAPs0oa8ae
         qXFv4rDJoawUT2pExu4ysOc5yog9sD9rMeV4IbC1ECLqwiBmWUBEuw1PatdUJiWNIolW
         yz5HfGpocBiQPFnU4wx8qsmRmS09F+AEUfcRxk42qT8a/8LZ6N85f29JFrPzBNVIl42u
         a7R6+wMgMwpoiN67NLjFbewfLLpCzCPGtnnTSheim9x/WVzn6XZUo1FP+snovZCW0Ohf
         OoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771896883; x=1772501683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mp5iFZ4HHPtX0KdhL1P8h2/HwlJMtJOzuS1lqN2c4+I=;
        b=MMPlqK7NAi2IUxcAeZdKkWtKaaTKJZpCGdHpZoXA4nb1GrERNGG0HcBN5CuEVvsvsU
         RplnuIjaDsA2exKLeLGSh/sKAzeGEKwD5V6rWI2d653VWLfZzldHlxGGM4uhowi/cp3R
         Gb71JO8GCjG/l5bB4hOj7CBbLjCmAseLeC05TxOZ354cOaoJO4mZ/DuaEmxcNL6kbeNt
         XxHU5y/7rf7Xz630B/RHGUix8FOHZd2zrbkMhbqZ1ux+qA41XC2L6+bxBbqqSqfbL1kb
         8iAZTqXo4mTZVhk9dvU4ulGNXzpv91xQ4FLjHI41KmwNFcDQlpBHSyPvF2G5ZN4oLiS2
         UYiw==
X-Forwarded-Encrypted: i=1; AJvYcCVQW4K1oLRLNZUiKExoNCpPiuOCcvL4ZEPfh5jhsmPMCH8HWSLPtDDjlAV+HlrVyUcxFro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZEeK9nOOVRB9J4Syy7NjVrQyKKSojowzMo25SumAJ2kq/Du+V
	S/3/4e1ki8R4bC2rvWT3BE/K5b8eIsuujeBuo9W8txH+6+iqW+idiAP+EoKHrM2ZN7L6xXOvtEK
	5cqgoK4TS62YnjCohaxODTneBIc2nLeg=
X-Gm-Gg: ATEYQzwtLbUhpnf+PhgcMLVS4eV5LLGLg/hO9M1aBdR42qPEWaEC+IOyuSblg2oECDn
	UmDieklPtW1tIfDU4q26kGzFnKi/u/00eD9Xl/t9j3JJykW67S7QLneJ3zIr8Na8sB98rnXUjQ+
	LbTxMVFIKdc6CYgBlFl1KnyPvYVbZ8VE4uTCcKEBe+ENF3rakOkAmb8XA0TGgWgoKw7yEeEM85l
	CA50Wd6WFDYL+A4M2g0xYohIi1tLjw8fQaBFuOmMtnvEoGhNau/nT2ApUo5OsRDRR6jLcJSZwPi
	qPw1Ops=
X-Received: by 2002:a05:690c:9d:b0:796:6c4b:294c with SMTP id
 00721157ae682-7982916355fmr84562817b3.56.1771896882728; Mon, 23 Feb 2026
 17:34:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2147.v3.git.git.1767099302592.gitgitgadget@gmail.com>
 <pull.2147.v4.git.git.1767202894884.gitgitgadget@gmail.com>
 <aVuplzNaoCHlZG3S@pks.im> <xmqqikbrvz2l.fsf@gitster.g> <CALvWuB70kwPAnQ+v4ch1TKMDxbUQgi5NP8NX7tbCZRqivJ=vig@mail.gmail.com>
 <xmqq1piet47r.fsf@gitster.g> <aZv02KjfheyFlMfb@pks.im> <xmqq342rpiuh.fsf@gitster.g>
 <aZx2WFMtQUB0jIfM@pks.im>
In-Reply-To: <aZx2WFMtQUB0jIfM@pks.im>
From: Paul Tarjan <paul@paultarjan.com>
Date: Mon, 23 Feb 2026 18:34:31 -0700
X-Gm-Features: AaiRm52WluMZs_apPs8Of_pO1EbgAf3dgrnx4ReHXp2rpA-L3wVzi2h6mc6pTos
Message-ID: <CALvWuB5BnCmcoZgdnqdZiczG+DMQTUByHzJPkNH+H7hBEGma_w@mail.gmail.com>
Subject: Re: [PATCH v4] fsmonitor: implement filesystem change listener for Linux
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Paul Tarjan <github@paulisageek.com>, 
	Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 5:01=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Feb 23, 2026 at 07:42:14AM -0800, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > On Sat, Feb 21, 2026 at 09:07:52AM -0800, Junio C Hamano wrote:
> > >> Paul Tarjan <paul@paultarjan.com> writes:
> > >>
> > >> > I'd prefer to take you up on the offer to send the meson support a=
s a
> > >> > separate patch.
> > >>
> > >> This part of your message is one thing we needed from you to unblock
> > >> ourselves, I guess.
> > >>
> > >> Patrick, do you think you can help making this into two-patch
> > >> series, the original one being the [PATCH 1/2] and update for
> > >> meson-build in [PATCH 2/2]?
> > >
> > > The changes I sent should be sufficient, so I'd propose to just roll
> > > it into the v5 patch.
> > > ...
> > > By the way, I haven't yet done a full review of this patch, I only
> > > chimed in to help out with Meson. But I can have a deeper look once v=
5
> > > was sent out.
> >
> > OK, so it is not quite clear to me who is doing the v5.  Is the
> > "offer to send the meson support as a separate patch" still valid,
> > or we expect Paul to squash in the earlier patch from you to prepare
> > the v5?
>
> I'd think the latter, Paul squashes my patch into his commit. I don't
> think it needs to be a separate patch.

Done. CI still failed in a different way this time:
https://github.com/git/git/actions/runs/22311198802/job/64543526340?pr=3D21=
47
