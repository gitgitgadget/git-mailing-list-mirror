Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D39D5C613
	for <git@vger.kernel.org>; Tue,  5 May 2026 00:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777941986; cv=pass; b=pemf9aq0L7EggC1v9CiClUmsUBGzTcfWvVA+LqkgIN24YNZXzfEdE6t4wJ2Z/r1dQ2oaAu1njz1JZIucSPuDNNOimcPXcBtjofZv7bRR2fp6EUWh24rVCGlR4l+gcH4TmwhyBYbqzkTa3YOYKIfly3wXPpOHJ0+KTez8QN2c9EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777941986; c=relaxed/simple;
	bh=ur5jsjxXdybXKg/wx2x3vq007n1L9KHuScd250zpdIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jo9yrQ5DjRZdFK/m5cbjyVa2lJgjRcvmpxBedx1+CtNsMpWdB8fcRcO3OK+D4E48p4Po5LYmTaKqUDPNY6H625jEjv+Uil9msKwF+pRFbcDwrHv1R62inVCHJ2L16V9ACQd690TsY7eF8hGq95ssXayskNVpWyY+qln0csq2b1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BD4Sv6EV; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD4Sv6EV"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a8704dc3a8so1776013e87.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 17:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777941983; cv=none;
        d=google.com; s=arc-20240605;
        b=Xt9lq5qBQoiJu6jbEatT6K9k7sDJPv+PmCgSp6VvEAzfQowa2ifPM3eU96e5v4eDtL
         /ZHnnLrJlpsONukhIbRJBhw12dhj09ySZ9btK/QX+v3gaKVDYbtheNj/rpD6iw6+MiBk
         siyIrn5noJVRw76ql+RYrz2UXqvtw5gBXdkUkiRMPNusw/utjUCYTjA1FI3YcWjdyCgj
         2mpqD56DholoZ4VPtXY0T2cOjEUauzGYUgIEpZFwz1PeedjHaIZ0RiR9pggP0EA0L5TA
         w7D3XmCQpomksVJPyk7n0s7N7jnyk1pWwLAxOUiy8er6cXY49a9ci0G2P4G3oN1qWjDp
         C3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mMvC9Y3+sEr2So3iy4ck8kswZIiAi4Z8QXal81U9R7U=;
        fh=+Ny7eKrYon1DnuFk2cWIDJAFRuXr5fNPEke6kvgaLdk=;
        b=fiiPIszjCu22OgKIftS7DuL9W2MSTZ9qfjpVdzBPK9N3oU//VlFyT2A2gdqEZOBsUz
         Ha+nxOh5ajCAP1Ivx+IGltrFxSlTfNCwgGgQi6OS4KvlcTqKuPd06NaytCM7rI2AWUrG
         oWEn6+je8DSmc3w8EbkkU710Yalr3fuDVKAgwcqU3b4eY2ozCjNknpCp9BNqrZ3Bxhz6
         NoTgb4i9UjmYdb3aqe6tUV6IEXtny6MHU+ilFgkdHhpuqegSVX0HuH/OZYPYhybCCr0R
         ytfQBAWtqqU3uPZmX/drxgrxhRrJk0JMh+Giihau9B4tyJ0oiwnsYY5KLW3x4vbHYlz/
         GO7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777941983; x=1778546783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMvC9Y3+sEr2So3iy4ck8kswZIiAi4Z8QXal81U9R7U=;
        b=BD4Sv6EVYUpIeWrxbHH8eLAnKGX+3bgg0DLrSU8yYjitzmVHkZxeHieHnDaTZMTNaW
         VRryyNqTFtgN/MgTwJjTNy1tWd5jEGimdAjmC2oosCThWtDbMaayqRJBKe7nlIfkKgbw
         VlXgz6WSo/JDaCGXOMS1nRHxfTpvxi/0hwd2hZrse/1ssXuhtXfh/1dGqawt8CFzkwfS
         qiagh0Yc72gxmWzVr9evP1SAVeIcLwyyXC1i/sZpdKmHrhi919JIklDo1JJXtedUHXT7
         JAPjU3aJjmOoEA4+dJJJ1OdhmwFt9Cc9odRXrJ00aeohMrF5S707Jv+GgnMeOVFTMzFW
         t1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777941983; x=1778546783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mMvC9Y3+sEr2So3iy4ck8kswZIiAi4Z8QXal81U9R7U=;
        b=U6n/MqqT3cgTjnAjJ6VhHux9VY0XLpFXVpTcq6oveh8ghNIwAo1tvMRZ3/M0slUREr
         /bKViP0R0xVsdmNLpWQv1PSBtobrGJSwZI3G65KjStXe0ZQQfAaJiu70sL7vTap2WBJq
         QIhmzYk92V9KbyZfUE9VTIdAb2EEWOpVwVBp/wLwRN2NO5pi0xCGwN+pj+wKP9ciqMC7
         ii2ZMJdGM73U0MMAbPtreG8YyX348lVjdbVksqSr3+p27spHf3AumU/Vpc+VdcwsQXZ5
         wTitV13VyGP8/yAG7hb0PoxfxAitvPpTK8w7gi/gRVpHwhqssrLLVxh8QiskRAllNjNL
         f4ww==
X-Forwarded-Encrypted: i=1; AFNElJ8FhE0V8hHPgX6PQVnl0WzrsVdjVOkZmAoL1SRU4cgajDtuaiWOIaXRbsoLU/VIeWfPR3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy06gdmr6CZ6488X1Sk0oqwjgC6bHA2RHJIcBz0OdXqcY5eHepN
	cOjXuAYVEwH3HFdY0zIDNWZ0l6DycWo134h9onT5vrL954PzQaMmiDruSfMKvyhVkeVRne6yCZs
	6YuR5LK7UhW1WoFB84De3M3vhgzBHW50=
X-Gm-Gg: AeBDievK3w9AdLL7iH5UcY90k/HIBEy6qSqRYqTyt97PxNBM9zPgvJ1aU8iop8vTnFC
	O0X3JqJPeGWab9WAFOFhrV/dlGvJK4RmXMz/rSigfAfgCOD3gj2vKUV73pXkztwPecLDs5tSB/E
	urEUtWXWmaXtUuJs6JfwBIaI1xG0HW4i96fSuh9j96ZIgLxYhfBETxXE+POawNIpZYu/SKRmRkk
	qE0VF2DLWuFkCmXPmiO62rqYJ9zwoCnpqxi57PuAU3hcozLFCDUq/T1ERibSvVMbPi6DlT/PuQx
	0ydZ4Qo+Wxr4O4vzl3k=
X-Received: by 2002:a05:6512:33d0:b0:5a2:a13e:9082 with SMTP id
 2adb3069b0e04-5a87f1f876bmr439182e87.35.1777941982845; Mon, 04 May 2026
 17:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OsOzcjEwvHCQSghLE8LD_wHb_jDlil9I88OUuhpiRONnVd1o9p3gStbK1mx4q7OwY3ePtbZO-BBgTNOCeJ2DMyvBsdlMhRmDrTP894KP5xo=@proton.me>
 <CAPx1Gvd_VEWHrBWtUjNeWZ+wfmsAOTamKmL6fhBSQi=MbmXRcw@mail.gmail.com> <xmqqecjqpvhw.fsf@gitster.g>
In-Reply-To: <xmqqecjqpvhw.fsf@gitster.g>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 4 May 2026 17:46:10 -0700
X-Gm-Features: AVHnY4JcnSa7tc8BILTQydL5YhIZJBYXmtKAWBUjaceok7No7qTxERf7D5T4C0g
Message-ID: <CAPx1GveSn30Ua6fD3ZhiRHiN+-DpcN=9FbUcY3GstiXz9UYZ_Q@mail.gmail.com>
Subject: Re: git rename/moved status unreliable in ruby
To: Junio C Hamano <gitster@pobox.com>
Cc: "sebastien.stettler" <sebastien.stettler@proton.me>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 5:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> Chris Torek <chris.torek@gmail.com> writes:
>
> > This is why -- and when -- making two separate commits ... helps
>
> "helps" -> "somtimes helps".  Only when comparison is done step-wise
> (e.g., "git log -M/--follow" and "git rebase"), it may help,

That's why I said "and when". :-)

 > > ... Some degree of ignoring white-space
> > changes would probably help multiple cases, though.
>
> You could tie it with the attributes system to allow logic
> specialized for the nature of the contents.  The beauty of the
> design decision to store "snapshots" is that these heuristics can be
> improved without having to change anything in the history that are
> cast in stone.

Indeed. Something like Peff's suggestion might work, although I
see some danger in ignoring white space completely. It would
probably be better to compress "all leading but non-empty white
space" to either nothing or a single space, eliminate all trailing
white space, and compress other white space to a single blank.

(Though at the same time, when we're dealing with slugs extracted
from very long single lines, this is probably wrong, so perhaps this
should only be done for "intact single line" slugs. Then again it
might not matter at this point.)

Doing this on binary files and programs written in Whitespace[1]
would be wrong, of course. ;-)

Chris

[1]: https://en.wikipedia.org/wiki/Whitespace_(programming_language)
