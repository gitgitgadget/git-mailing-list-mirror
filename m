Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651443636E
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990134; cv=none; b=KBk/Kz00n2Ji0V6sCJWJtqGvvdKMh2A54LwebF+R/wGAFlFXGN4gdHUPSzRDqZjvSCuR6YgPFe1TROO+7LPfbw1Id9OMJ2FqE8KvrQKz+N//64BCp5x42j68LsCyDWwfRXPFBUbGhDzFQ7Du0lFIa1Wl59zM/IDzPo7tyJD5/Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990134; c=relaxed/simple;
	bh=RiGLSvXBuvM8XTu0Set2u8D1eAuSup1UpN3C18lue1A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lTEI89GPbwF4VWcy72x4/3K0LWTXKk1I2HDeenQrOqFIUdEBHwsQ0uSWD1pMLGVod4uzBcqK1EXM32D0HxwluUmeovob3w6H6X9HCMNkXjRnIN7O+0QNVDudAbnF3x2VkR6qwZ3ABdKn4ZcZ17Lv2KgC2RnQmJV4rjdeO4L0XVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=hloJRmdM; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="hloJRmdM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768990126; x=1769594926;
	i=johannes.schindelin@gmx.de;
	bh=ow13fX4XMzBRM/dMtTXBCbUIRkp5X8B/n+NGmIVTGkw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hloJRmdMzdRi91UDNhsnEXXd5wNPYOzzJyyE9t24/GP/iMdKTKQepR8i0jc9Cn2m
	 s2C7AaI6RejzgowDP6abvgsp4/XS1ySO5NS4nZNLtmw/AHMngpDy9gGFG2lXlaD7S
	 TYS2BqYfPy9Pe82l8NGx/S5S394y6r5wmApqObOb28sFP4/9MUo++ww1K+2C/WZjH
	 Jv1NfsqznySyGSF3fjx5gID3v9DDIaOsJweKzHWxdEeU2oiTwoQyXph1dZcFVQNfn
	 +rVrBG7gFrpVQKCx5ljBgHML3NQZKUTlWnNXSFBBOCVwPCUMdyFIOqP73K/KrHLNW
	 yJWHdQkUNZ2l7LLViw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.108]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfYw-1vbsMI2YuW-009mDD; Wed, 21
 Jan 2026 11:08:46 +0100
Date: Wed, 21 Jan 2026 11:08:45 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #06)
In-Reply-To: <xmqqa4y832ok.fsf@gitster.g>
Message-ID: <97d8645b-bae8-7f5c-8e59-0f4f0efd92f5@gmx.de>
References: <xmqqa4y832ok.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:txFVku4BzV3kGwEvnGzL78cfg1f0YRQwqxVINFwLLRCKGifz+qu
 4lHVUdKlJShdFdZkdHDnss0wR0Z4iuw4Mv0x6NLSTBZpM8sT+HyjbYtITjnu8ukQ4I//zvQ
 Uj6kcTt8Rxdo9i0L90BxJSd+KBh8ne3M56OVqdMyhHSeN90fDigHFiZXAZ0IsZlxnJ1AtDR
 n+Dr1rBT8lYeDPjSj7U8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v1PSRXvrGDY=;Xapr1E+BPfbTLZuBMf1uyQpNTy0
 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
 AJcusJhM=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 20 Jan 2026, Junio C Hamano wrote:

> * js/symlink-windows (2026-01-09) 19 commits
>  - mingw: special-case index entries for symlinks with buggy size
>  - mingw: emulate `stat()` a little more faithfully
>  - mingw: try to create symlinks without elevated permissions
>  - mingw: add support for symlinks to directories
>  - mingw: implement basic `symlink()` functionality (file symlinks only)
>  - mingw: implement `readlink()`
>  - mingw: allow `mingw_chdir()` to change to symlink-resolved directorie=
s
>  - mingw: support renaming symlinks
>  - mingw: handle symlinks to directories in `mingw_unlink()`
>  - mingw: add symlink-specific error codes
>  - mingw: change default of `core.symlinks` to false
>  - mingw: factor out the retry logic
>  - mingw: compute the correct size for symlinks in `mingw_lstat()`
>  - mingw: teach dirent about symlinks
>  - mingw: let `mingw_lstat()` error early upon problems with reparse poi=
nts
>  - mingw: drop the separate `do_lstat()` function
>  - mingw: implement `stat()` with symlink support
>  - mingw: don't call `GetFileAttributes()` twice in `mingw_lstat()`
>  - Merge branch 'js/prep-symlink-windows' into js/symlink-windows
>  (this branch uses js/prep-symlink-windows.)
>=20
>  Upstream symbolic link support on Windows from Git-for-Windows.
>=20
>  Expecting a reroll.
>  cf. <5fe64b77-d10b-b66e-8622-14bec1e96f4a@gmx.de>
>  cf. <14388349-d1b5-fc8f-b6c7-4a7b43e64494@gmx.de>
>  cf. <704e952d-7924-00ce-b8b0-ad355e659335@gmx.de>
>  source: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>

I do not quite understand.

v2 was sent out on Jan 9. The three replies you are referring to as
blockers were all sent out on the same day, as replies to the respective
reviewer comments in v1. Naturally, whan I did sent out those replies
acknowleding problems whose fixes I promised, I did not then go on and
omit the fixes from v2!

In https://lore.kernel.org/git/xmqqjyxli89m.fsf@gitster.g/ on Jan 13, i.e.
days later, you said about this patch series:

 Will merge to 'next'?
  source: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>

However, in https://lore.kernel.org/git/xmqqldhybtqs.fsf@gitster.g/ on Jan
15, you started saying:

> Expecting a reroll.
> cf. <5fe64b77-d10b-b66e-8622-14bec1e96f4a@gmx.de>
> cf. <14388349-d1b5-fc8f-b6c7-4a7b43e64494@gmx.de>
> cf. <704e952d-7924-00ce-b8b0-ad355e659335@gmx.de>
> source: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>

And the same comment was made yesterday.

What exactly are the still-unaddressed issues you want to see fixed? I
cannot retroactively fix v1, and v2 does not have those issues of those 3
cf. references.

Ciao,
Johannes
