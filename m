Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365D62C11F0
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042483; cv=none; b=UwGMPOB09mzzAE0wuXTkIY89RXY3mIFttBZAJAYyH/Mu1yDc/6E8L1/gF4VH0ERTWktgI/5PV6itEtj84vhVPylrCGxjIzex/M/d2pzZ4AQ/2+TOL0x89d+u48t4Q4zgcF7gXp/F6ycus+oMqbGFYg5x7kOgV8eg183MnbH0mlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042483; c=relaxed/simple;
	bh=2KcIT+3tvPS+8JpmetmL8hM+LcMBPBd7gXcvvfv6DKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNfego+1b2wh0S8WzLSekBxFuk39PA9pBtHMAfQVwamcMyjYD7AJnTa4w5vhBFfgz/fFVnvLURvKG6DcDc/e+qSFl2EJucGnXV4j8Omm9CNv3YC4dECy7TFau67o1bKhxqnPN/HVBmaLdkhyNA6cM3vCTwAH1t4u1q1N+kSD5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vddo4Kp8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vddo4Kp8"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b0418f6fc27so975350766b.3
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 10:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758042479; x=1758647279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KcIT+3tvPS+8JpmetmL8hM+LcMBPBd7gXcvvfv6DKQ=;
        b=Vddo4Kp8I5IxdoWnsyFZz5JfSH2fSOtrJEKRAn8fBGccFkwf3/awfgwG0xSWmL1y7Q
         2RANOzhfNBSeCYdDCmnqgjVkKTMIWYxSNXeTZWY39pjBvMZsPxnGfGwi1IkHRRY+fG6n
         +HhXAlqXrkJsmMDqq2j0qeEKt2P9mFXB8nCXudzFM8rGOtR2QVkkYBL/5uoA8AWWaVz+
         zGDXIN3ERe0srMc2fRG6b51bT0QDq0AxOScN/PTLifyMRHxDIkbefkpgpuORpIaJaRdk
         O8JNqdrBDHM+3YPU7pCgCtV5X3SHfa/FDqYKfxNbjcutnFZ84Xf8VT9ad3Dw4SpX45gT
         wJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758042479; x=1758647279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KcIT+3tvPS+8JpmetmL8hM+LcMBPBd7gXcvvfv6DKQ=;
        b=rHUcY0ULqttcN2J2MTu8Osi2mVNBwyQT0v3FKE0wHFmm+1HtPX9RoO5SsC9PiH/ll6
         zkaO6eh/DRoP6fnf/re0oO3RgogGfEOUEmS4XWJB2W9qaIulL5QncNIqOiHXzL1+7pLp
         cX3u/YOXoV+QaQHKK9AdoDz0DIzuNOgX+U/4NZrDRvgqzmKNgs+pdw6XgWEM1U/CPFzi
         3Vcm7SgHaXkWWdVkIHOFaBDViCuMZGWlQ8a5ankrTgMCkT4t4gEiqk+coXy9zUdvgR2T
         mmvAoi6JWqsBMLnRV1d/TrPGCrf41cv225dPbvHe8AIzCrGNbN+BjvMXLECcL0wFSS+v
         Od9Q==
X-Gm-Message-State: AOJu0YzpSswnK3NuKYGO3R3MW7gLzjY6dPRw8htMSn1I3q6zSvJTClUT
	OJ2nhh5y+fV0hRj7+MZ2rrU0HZ1hYAA4N0XrW1JJ5nHWKxB9hg6hSTsmFct9aJo/Jmz/GU6K0bY
	E7N2nWiFNiR9NzXAw8AxK45H7Z4oKqwU=
X-Gm-Gg: ASbGncvvzd5Uywh9+l/Tau07jC3Ss+tK6oM+q1zfxWTHP2IIDwmsWLZjVqMebLT/hG0
	dtLIIRDgsGgtRxYcinJv5V8raXXhUIIl3q61GGvP5FsUwLU3coTyFLgSORLpVYv79dXfVvXPy1Q
	2MK8hotTyT51KshPr2sA6pcnnTuuujfAEBC4JVyzjozR6viAosYV4sc7X1swRQr+P/HULYKaRmd
	zuQgsGWTkxyJceIL12tI6okUlFJtrx9FN6AjhZzBexpnkXCc7hs
X-Google-Smtp-Source: AGHT+IETduudaxdpOJZ9qUh8zmryWSP7uYRuV9qkOZ0I5BjPvQZoxeXFqpOp9LlpJdcyh4l+DW2KhgdOPiqtUvJDy/E=
X-Received: by 2002:a17:906:cf84:b0:b07:c905:21c with SMTP id
 a640c23a62f3a-b07c905147emr1364753266b.48.1758042479444; Tue, 16 Sep 2025
 10:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
 <cover.1757982870.git.ben.knoble+github@gmail.com> <585e124467dcb1ec1de71fa72e749140d44dc367.1757982870.git.ben.knoble+github@gmail.com>
 <25836bc2-db3a-4761-b13d-c587728f4c3c@gmail.com>
In-Reply-To: <25836bc2-db3a-4761-b13d-c587728f4c3c@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 16 Sep 2025 13:07:47 -0400
X-Gm-Features: AS18NWCy4MovPVekHAa6fazTBMUD7w31_znUY1kfn68MNc_O4xD-4dzy2-Om86c
Message-ID: <CALnO6CByUNHWFRYBSOpP-uD8moBrm48UW7k0MaGTUtL=bDL6GQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] stash: honor stash.index in apply, pop modes
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Glen Choo <glencbz@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, John Cai <johncai86@gmail.com>, 
	Denton Liu <liu.denton@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:18=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ben
>
> On 16/09/2025 01:37, D. Ben Knoble wrote:
> > With stash.index=3Dtrue, git-stash(1) command now tries to reinstate th=
e
> > index by default in the "apply" and "pop" modes. Not doing so creates a
> > common trap [1], [2]: "git stash apply" is not the reverse of "git stas=
h
> > push" because carefully staged indices are lost and have to be manually
> > recreated. OTOH, this mode is not always desirable and may create more
> > conflicts when applying stashes. As usual, "--no-index" will disable
> > this behavior if you set "stash.index".
>
> I don't have a strong opinion either way on the new config setting but I
> do think we should rationalize the new tests. Assuming we already have
> good coverage for "git stash pop --index" then all we need to do is
> check that "git -c stash.index=3Dtrue stash pop", "git -c stash.index=3Dt=
rue
> stash pop --no-index" and "git -c stash.index=3Dfalse stash pop --index".
> We don't need an exhaustive list of tests that check the config setting
> in scenarios like "create twos stashes, drop the second one and apply
> the first". Tests like that add no new coverage for the changes in this
> patch and slow the test suite down.

Ah, yep. That's much saner.

I started from a "git reset @{u}" of the original series, so it was
"cheaper" to keep that copy-pasta. But I much prefer your idea.
Thanks!
