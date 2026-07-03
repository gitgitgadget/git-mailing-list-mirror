Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B32233939
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093595; cv=pass; b=TvInmMSX3JyTV8Qbo6e0+Ki3eLtINyqKyPXpv+JKZersx4PeEMBpUNAcAJv+Z54l6ytd5Jdok9nltKJLcMXkBE8guy+8qIOGzT8Jt1c/r18iVsLOpCXzhD3NtaKO0OONSkohtnhm0bpduXiTO7bQeu9cUt+RBehI6G04C7Nhi5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093595; c=relaxed/simple;
	bh=kAk+GlVDAB0QuIOjmOtwyIDJXz6B1ylrq8HK6IeZyFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDbCc4TI6aexAVtFNf2HOY96gKmZ4xGnGdOPsjVTiuO5CYzEzGDs5mzEBZBjHDpLOSTp6lq+Li4YObDhiW+6Dn+UD6j/xG7aMjjF85j7+TqgrM8TnRp//xiRW4Ab9G3vwNgyCkdx0zA9Ssm2w5nsvJ9z5BXQwpvasX229MfXT0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQFBYbk7; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQFBYbk7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so6575145ad.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2026 08:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783093592; cv=none;
        d=google.com; s=arc-20260327;
        b=MjhPKjlGpyDGEbhZqmbirQ01qZydUnrIqESAE71vffSpeE5KnPhHF8THxMaHUSBnXc
         TbjOfTLYvsjPHhMxrg6ioJFUhnVBaW5pVNVqPW6NY6mAnlNDHmCV9wA/lYDVgVnerLPQ
         SzcRXawtCXwoKggpYajzTdUyHwHJlsXbKvixsW5kd9852iKc3riOuVI7Ax01IPWvbRGc
         jCkzV7AooSVBIX9BqSTmzMz1ZeisLhJBQQoIKmrKOr93RonxkW84paD+Z9ZBcX5wWmdi
         OxAISvvgOhn+sJe6oChjE1E1II1SP84TlNgbBRUDh+WZHliw+MJoyLIc1wflLl5bey76
         CabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bJHECYDNF5NeVDC+HqecIYaRPbkrWNq7coP92fmKC/8=;
        fh=uPbrWNz5Z30yjIuwxHohTyR6rfOugkpt5SSO9eJ35dQ=;
        b=lQKdUnDKFCmQW6LN6kqmaMK67uCl6BZhP7sROOc60g7WxY07QRhsD/rjvVYHP/SEZ6
         wrSotcZi3tEi72BIVVjaCgn6YtnlafwkVMale0okOt80Y4ofBzjbFMljqCbDP1N2l08W
         ZgCUp+bCoMXwIwAJn3Aed6OE+pO9CWawHzz/Z4RdTzqUTu5KgA0bR2rnuX+SQQSYC9/p
         3WysDm+EmhY1fBjgTBQKB/I/R2ZXamEeElxebc2ORy+7wvvWy0oowtXYQE/M5AWSJ7pQ
         2BA5DLbJyiyPHdGS4azHmNWhPGL6EonSEv4D2q8rnmIwxhU0Lz7R6+KIWGMqfhufh/Mf
         NWlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783093592; x=1783698392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJHECYDNF5NeVDC+HqecIYaRPbkrWNq7coP92fmKC/8=;
        b=NQFBYbk7taRThhs0epCVhKyifuRzqZvSzf93B4ePxSoiuZYak3w5GEekY1MHBCBFfo
         aH1FBXZCEdbpYphYJeR916GvtcbbC/JaMAkzr2KOqFwoDAq8eWmrjZtCCpE0MdGiEJ2r
         9FQ9yIh8yAdEvt6ahJOBAUi3ODlUBEue2gd4FcXcop9NouwfusUQKH4uE/gdCvDQaesf
         GAk9st8oiMqCbX4D7gVHcYI20nrkF+f6BX9MAMnUA9UdUyvPEz1wVr9qQ/nQ6k5Yl/j+
         R7KQE76jdrkBnqvKa6KGK4q9UemxH9DNLsYy6DfZgfsmCwYyGbceLQ63a9wJmTcAte52
         QdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093592; x=1783698392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bJHECYDNF5NeVDC+HqecIYaRPbkrWNq7coP92fmKC/8=;
        b=XE9B/EtkYSk4j+75ll49ONOz9eM5nClDUwUIijJqjtaeoKXFukGCQhtF4F4V1Z6YND
         /Q3Ekm5dX/Elezt+XOFS7rOMUtxt08LOvk77XSQ2HqJBQMWQLgP/kVTX4RTJqK/LcZxH
         ZfWp3hPxTU1KRbMY7AtCyaxZCFHFTcxxCW6afnwNaY3bbygdzW3AfUfxrMWtV11R6B0E
         xN9kYusZt2EoeHXCF/TxDVBOZngUHqvPuvq5rx/elXj8A0A+MxwCAw/kgLAbKwrz2KJ9
         hvG7PrTsZNc5mp58Hr1x7DiyuMNe6sZCPiCYwz0hKXBxObbyxiyg0uEHBs6jp1BT/GGb
         ckuQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLehwWEnmFFzcg/U6Hc4NuznKTwRXTFN8QI2DC5P5Zct6Zl3wQDwQeDEMDNFPs43YNwkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMP0US5js7i2trSo3FOm2b1LRt9qAnhNYHx6d2q0FmAiuW3cgK
	TRdgYQ+aIyY1V4TL8L/P1OczWeLek00+L8hFqc5v+HwuJH25DbGbgzVWy0+fZzgR1uUa3SnfAQ1
	3UMPndtl2OOoRS8NZDpawiUWvKM/3ACI=
X-Gm-Gg: AfdE7clqoLdMZ57YkjT7T4ZzNWvJuOEe8F88/UO1k5zQHO8coZiQbcycGJkSqby7l2a
	aBJt41pyouNKdtvkTOiirw2WQdst0BV1n80aII9qFt/rEE8qqYWeAr8BaolxZd31l0vzsaDd1N2
	Q6TjE9HkJoh7JyWLd040NevLhLZ2fUHIgPxbW5vRuikPwmS68SHKZuPgEgUuI+SbHoeVzj4WPYs
	74BGlL/yAdZW5X0GFw2uoLmeciPEIS+cRLBNxPZbM1E4f1M5NVjNS3ABDDF5/jppEhKi5sDKc5O
	Gug2/93cj/3LIC9K2Xsg2bdBBBK28QogzqtxKLub+fRE0w2ByGO5/ikEvJGKitv6HuEPDE5lrhT
	E8XK/u3fMK8udeTlKNBC+ESbaWQ==
X-Received: by 2002:a17:903:3c05:b0:2c8:4c29:afeb with SMTP id
 d9443c01a7336-2ca7e6519c1mr126841545ad.8.1783093592281; Fri, 03 Jul 2026
 08:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
 <20260621174934.GC2206349@coredump.intra.peff.net> <ajjuoS5Qc3K0nCRl@pks.im>
 <20260628081806.GA3594700@coredump.intra.peff.net> <akIL6oJgUv8J8SB2@pks.im> <20260630054314.GD2495216@coredump.intra.peff.net>
In-Reply-To: <20260630054314.GD2495216@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Fri, 3 Jul 2026 11:46:21 -0400
X-Gm-Features: AVVi8CeJv0QwtmOJWxsThl5iT1kXVY84KvjFVdPQp3tKFRj4MvZHMFvrxLOAkLU
Message-ID: <CALnO6CDm74rCBQu6Q0djsvtuw5U14V=PApptcZTgP+pic1f_AA@mail.gmail.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 1:43=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jun 29, 2026 at 08:08:42AM +0200, Patrick Steinhardt wrote:
>
> > > True, but AFAICT it probably is safe these days, at least one some
> > > platforms.
> >
> > Hm. That makes me wonder whether it is the completely wrong approach to
> > make this a build option then. If it works on some systems and only on
> > some filesystems, then a build option is just too coarse-grained. A
> > distro wouldn't really be able to ever enable the option, unless it kne=
w
> > that repositories will only ever exist on a filesystem that works. Whic=
h
> > I guess is an assumption that no distro can make.
> >
> > So instead, I wonder whether we should treat this the same as for
> > example "core.ignoreCase", where we only use nanosecond resolution when
> > opted in by the user. Ideally, if we had a way to detect brokenness, we
> > could even make git-init(1) set it automatically.
>
> Yeah, this came up earlier in the thread. It would be nice if we could
> set it automatically, but I'm not sure we have a good way of testing a
> particular filesystem. I think the sequence is:
>
>   1. stat() a file, getting nanoseconds
>
>   2. somehow flush the kernel's in-core inode cache
>
>   3. stat() it again and compare
>
> Step 2 is the tricky part. ;) It's not only not portable, but probably
> something that would annoy users if we did it for every repo creation.
>
> It would also be nice if we could actually verify that the sequence
> above _does_ show the problem. I was not able to come up with a failing
> instance on my modern Linux machine (even going as far as unmounting and
> re-mounting for step 2).

Brian suggested in a sibling message that a statfs call could be used
for "known-good" file system types, IIUC.

> But I do agree in general that it should be a config flag and not a
> build option. Run-time flags are more friendly to users when there is no
> good reason to avoid them.
>
> -Peff

If we're all leaning in the direction of a run-time flag instead, I
can noodle in that direction. That certainly involves a bit more
surgery than just giving Meson access to the option, but the dynamism
may be nice. I'm not too sure how we'd write a test case for it,
though.
