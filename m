Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D1928033B
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790424485; cv=pass; b=GUqmyV/ViaB9AlNdwjKp6yPYm540MWtnnsfH1n91QNz0SG4/mwXGxUgMV0Gv/TQ8kNo+lq35nEY40+QMNce/qcHBpwcsr5LDSDlFBmoDBu80B1aZ/zoihLFANtRiAn/hUeYs/emz86VRfseiKSZSYSBih0xah4IYrLxpoCwqA/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790424485; c=relaxed/simple;
	bh=f2+B/8C0KbEyhiwCaRArzKnLVXA6+wCmqArIapHav7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyVFGrWCl+LL7K0iynojpprVJHNT2ifmUuqmrii+nFlaoDyyWvEWzOGilFBCBCdyr4PK7/onJp6WleiWwAc/1C6hSKV+2+y38jEcFIGcOaC702Jd1K/t2cuFT1xot2JMqdpNXpvn1KFLjO2+J5KVrPqVf14haaHkLWNLni5Hdro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtnS1ZdH; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtnS1ZdH"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so971130a12.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 05:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790424483; cv=none;
        d=google.com; s=arc-20260327;
        b=WzSStlTq0cvDBSqWBtkFYwAQFZlcIcCMmvNrFr2c3i34aRg1Y+YtwAmaGQx1j4OFYp
         RunPSjTDr/saMQZ67+zQwUiURd+gVRV+iPUK9593IHjIm8aLL7jr3AtIHKQwaddyUPpC
         /yFOh/gz3x9nENpgTqfmFqITTFKzYpsA5NntjR70jH5DmSM6C3tyKpqK8GjEca6Pl54q
         7lROpXBJCCJsV1vtUjLc0vcdSk/S+sJgqjZFMllnsXMw0tdK6TWmsPj2gwPqcHjINTvZ
         ttOhQD2zWHMAzckv3jkZ2WCzuDy5aDMeFhKPSoaZqEYeb+sk+LELX2ykevc4AJtiJiK/
         zxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f2+B/8C0KbEyhiwCaRArzKnLVXA6+wCmqArIapHav7A=;
        fh=glCaWXGmc6Mqjg6YULaf99bOD5gPB3stA6YjpvEjc7c=;
        b=PGZTk1nkH1J/fo7xsWCKLOcJ5mzMkmxkZrVsPShcSO/2yf0ynSsBQaDtkLPCg0Ez+s
         7CEt57aTX/B5u/nfh7qVH3ydpfhxcIsoXMthdwVy7S7teYUcqEAHidESPlh54nFGR58c
         rJulo+rpscr21Ja9lQZGxzTtQyhp07o199AW4Gb8WCHXTfsj9BEYhDHxVMt/MTUzgGtE
         6BLKieMccSCknPNEW6Tmq2xm8bx1xCsj1r9wO0cskwN3L4ysoT08VftjVkcrXDPA/wbf
         gf7dqi1hXJ9wd6AotK4twZ9MZ6Mpiy+Dzf6e58TbCsp1wr0ATbmXLYN/X5BUM5v+zhJx
         NIwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790424483; x=1791029283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f2+B/8C0KbEyhiwCaRArzKnLVXA6+wCmqArIapHav7A=;
        b=gtnS1ZdHYogGn8/ztwp+vAs2A6r1F88GRuLHAe7sjAw6rAM5m+FCmpkVfrXGFDfFOx
         jKu7cfoUZWhSYgGGpwtwGK2rZ361bcwR9IDhVXF16YekiA0qhwiNTTSjGNKkouVEGkwu
         IKR38RAG1neIpPdUSdWuZ7Wovzygj/Xv0a4ekLCsovF24ykh6uMZRFFmoOAeN5a7xC0v
         J8oJM97p940KPMD9z9IcrYOOP1qrfU8IsXAnRMIrx0eW+6ZEi75xH+E7HAaBvFOcIiKI
         gRwd8s2AgZVyzBdB2MozmjOW8Vg0M0tqnFGuUeFfuig6015lmIO09lSIoHJit5xz0jPJ
         ebKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790424483; x=1791029283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f2+B/8C0KbEyhiwCaRArzKnLVXA6+wCmqArIapHav7A=;
        b=0Ix531PjXP1vyvZTTdFDfhSqAmyhV7v8ntsszWpE3b8LHv4iwCa8f9zPBAgvgqLhWz
         hCkSqmKmggvTFSwZVGRPSV+N99qai1tZ8MM26lf5kiZFdG3mUfdHvqAD1sohJPSHDm7e
         m5w9jBpNb+168d3b00ggB5dDRheB9suANWBYGu/8pkIP3CJP7JMZM1A7lvRNKHXYEZHA
         aJ3m1hYfE26E0Jo/uDMakE41R9eySNMTHvx5leOU/OhpQFZrmEWQezXEXQLtPM4vgIUb
         9a9su39z8ijV2AG+rNDAlCwBQ5BxyQLEfkEhsieJMpvwz9V2p/gcka4gC044QeFb8Ztn
         hnKw==
X-Gm-Message-State: AFq9FYLXV0BG/dMFrr6LAxxvtG1W++tDq1Ik0BcZY0lYznqyOKd2UO5+
	OhnPuKATtXTHSe5z9Y5wdM+zDjyPwHUuBfMGR03wUPqsHJ3/sE4+PFpq4WmV6xSR68FqTyS7HOi
	hPORTlExQMZZga/hQLxAGJmzqMcXyYSc=
X-Gm-Gg: AYBFou3IGN3qU2cwLyrQdSTlxgzmBVf/Z17IdrProugcG2o+FUWXMggbXq8Rj8QA+c3
	XZrYuycpMecRel5kk7Eqnoww2L+lcUWBJWJ6CG2A/i5cjrmHh/O90jdgJlxKtOQkKPHhW9G13Sj
	QZxRegD3viW8wNPKTRWEUQXDlCXuWmRIyKQ8qasF26RzsRaDj7ravjaZwlfk/iFPjuVXPCO3PBj
	BFwmcOTFifvw4LCnB3LHFTT7qFRKaomwdfnWLNJyjfShfR0ZVuskigLjv8NWcWpHvqlbc8g8Zr/
	X9dMxOH3X7iPC4FUU1T1HwVzRK11oPdEwgf9BOhZFfXt3T3jtJAYt596Be1K3kmJolcjVj/DcXY
	FUK4hyrciWZJxcb84KNbPJJehIifho37vD0nNu11VIo73s/6AwaBW9EANeM70ufRgNKd4WapeOu
	SkCDOycjc=
X-Received: by 2002:a17:90b:2c88:b0:39e:b15:7950 with SMTP id
 98e67ed59e1d1-3a0bb5789eamr3843028a91.23.1790424483086; Sat, 26 Sep 2026
 05:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790168285.git.ben.knoble@gmail.com>
 <5bd4b78cace8ba8c8887c78f739bde3513dfda28.1790168285.git.ben.knoble@gmail.com>
 <232f2bf6-04d8-4a54-b4e9-51b5ee79799f@gmail.com> <CALnO6CDTaunaBby+Gy4B5vxiHES3DHpybv8Eq2JPvQ1cteGzrw@mail.gmail.com>
 <a9c44afa-583e-45ad-9447-c00144141c32@gmail.com> <b4023f5d-efba-487e-b273-a4283c50a774@gmail.com>
In-Reply-To: <b4023f5d-efba-487e-b273-a4283c50a774@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 26 Sep 2026 08:07:50 -0400
X-Gm-Features: AclHuK_vTySV4VC46Zz8KMIR954bHf0dF8dMcAtfKl4wwz6QBhcgF2TSJRDF2eY
Message-ID: <CALnO6CAwN=Xx5NUqNg8KZ9gf9Nn+nuSP6Yn3YnxyX5w8HqhkcQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] t: test failed "stash apply --index"
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, Victoria Dye <vdye@github.com>, 
	Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 5:53=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 25/09/2026 16:45, Phillip Wood wrote:
> >
> > I think that sounds reasonable, we can delete the index lines from the
> > patch output with sed to make it easier to compare them.
>
> I just opened the test file and realized it has a diff_cmp() function to
> compare diffs ignoring the index lines
>
> Thanks
>
> Phillip

Doh!

On the other hand, I don't think we need it. Those lines are showing
blob IDs, which would be stable in our case (fixed hash algorithm over
fixed contents), and we don't make the test dependent on the actual
IDs?

--=20
D. Ben Knoble
