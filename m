Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CFD3FE66F
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785368490; cv=pass; b=usDuK7JZE088ha6pyXo+C70fRqFZ6NimfW2vqeFU7IbNDcljhabwOcPJH/injJzdPsa5D/SiiCsWyDQMJrjzzM4e8UQjkJEt2kcCehtzXrIzyqq3+uN93cq9u6kybEY2KUSfxRkYNFBnMv6mriAsQVhw42q9BvirLwPjXYt2hVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785368490; c=relaxed/simple;
	bh=l0KzR4u0JaaEnG4UC6BrVB3eg9B8okI9rp5OVvAC4t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQJ167y1OPxbfonqT1AdU9GnZIzBgHMz1d0QO61Lc3Vkvln4ZcOSPxOG+b21Q09g8BH4wZ54LIQrtdV1q+ERQ0DAXWjTBPa6u0KvAXNMXac2+lzPwqbUGIHqSeDCXiks9yot/lLiBZ+VchCNXnmxjZXrD23cYI/m7mOMVHjfvRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9RqnzFh; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9RqnzFh"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6aa9606ddadso1246183eaf.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 16:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785368488; cv=none;
        d=google.com; s=arc-20260327;
        b=oOUrIDQ9Wx9w9yJ+RnGvzPxw7tUI82yMcqopJH6MnKgd4V9dVKvShsVGtxG8sCNfdl
         fuiMv3eeNBeKj4pQbYdCKVgsVeDViJEqA5OnA7J2m2C6e8tmU4H0dgzpDOKfkVzjPMow
         c/7axqFiDjajrRBaEvwQQ4yFCK/PJJtHiSRNvlhbvPmAbUFeM+3+FdxXU9u3vOYFTUnt
         zRDDVnC5y2459EfA//dyXWEQof2kE5LkR/0pMqAqXOj615n09f7jhOOKFtHwUfRV/ZGP
         GPW8UZ7JdV/T96Qse3NDP/s8XbqHf7gaRjv2FF1xbJ0eVvmLF+YAfxqr5E6qbVw0HeXL
         ysIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WFoPKeVLfaS++yDPpbFMVmCZWtMMSV5TOdhS/ywSUOk=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=sJinWScS9rBHynIiNQyaXmg7XDpXw6wABEaYFsJfAJhY0RnuL/UsHp+D0Ublueg0Zr
         55gfP4FeOrcmVa+XqMUTgs2IRXjHDiQ7qtG06Nz4ra6n2ffW5GXC7Q8c6A7qrA0+XInD
         qr5yAgMmzDFE0W0DORCOX6FAHMAtXDjAqo3RRu4nlwlL9e3c0KUR0zVCOSBhrKPfO1eB
         FqPxDKsr39IjayAh/ftcCuswftxkPhuJECWkRn+DuvH8VgXTwgwhk/7xDMZmGsrXtAW9
         wyxW6fM8EmEF8FoOxlE/TxBx1+UbOLlOqym0JgJag6VeMYL1S4ejFnaAiieGL891b7+T
         LccA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785368488; x=1785973288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WFoPKeVLfaS++yDPpbFMVmCZWtMMSV5TOdhS/ywSUOk=;
        b=c9RqnzFhRtKc+g+HruSxavGfH+MCG3Ep7tGdDfi/yJxVdskzCVWXZV5I1q2sngaF0x
         Ox/iYRxjN0y18okux20gb4SISokXUml/gRHetybSt21gDPcDVdCT2Imf6kfw3nbiANuK
         Kg+WlcBSZXNhxAq67HjDih2uDgAYJfOOaQllOVal3l4+2cGwxLGaNcIWeO+RtA2F2nO/
         LNtHlU8UjgtFlqjmZ3s7pfNSLeWaRKnekGGWUPxkF7Td0GG43s/OI3XILO+CSm/rCwY5
         wSyVaIxaxVEHheRCtjWnduS+0qSj0XXaqXVyI10+tbW3ADQZ6OFc5eYxYmjeTf1HwaQQ
         eOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785368488; x=1785973288;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFoPKeVLfaS++yDPpbFMVmCZWtMMSV5TOdhS/ywSUOk=;
        b=AHXEYiEqsfHPjZtKFcJL+C50vRPIub9jRibLZKT2lOnrt7zF3BUmiz9Z07sHph8Ndo
         Gy0hMh1oPsucXGlSh9lhNqzP5w9SjQRvlxNES33qWLjmcr/f580X0gSBWpBSHTHbf5dh
         PPaC4apgmigr4Lwz0fAI8sdYn67JY8oQ7IEv/NruEgxmQkZ8IiiosGmlHZPJq6YL3ozI
         g7RepNyMglV6k2JXBn+ejD/F5CXluCVyREv6wwC1i98SFiigQ+38jdOgfD1GxFAvqDPO
         envVHBAEtrgOFyfgNCtouZehsaWk7aWmCtN4gS7S+QPb9P41sedq3g8f3YIJ3KsQNLOn
         J+TQ==
X-Gm-Message-State: AOJu0Yw5hRrC2Bkg4AUAVAwDhL6UU2ErsWRheCK8CUIEowIpp6gWmo3e
	MtwOULCQNjfm6X4x5/vxVjo/1vPDvkHZikNKJhz0HtpV+jJFuByu8TYFUPYPGeeMV80qQG5IyNL
	jc2RN+90CEUmwHn/TtJYFwCxmgKlCums=
X-Gm-Gg: AR+sD11o1MaBYEDovFkJ7BqFaHk8yZi80+yTcLCW+hXWD/1QPyL0gPfoNM+pj5yJXKe
	ir6ThRwm9DfM1hB974xkS4u0qAIR2mDURXtbYCov6B2puYZbPfRBF7Irwm8vmB/cIj21Av2A/Kv
	TfvbrI0ai6qlpzEVqvc+1ddsu92jWgzgbPXAYNjom1TyleySEudbc9fsXlTFtVuBrbD6M1u0odL
	OHwomvx0PmCrLolOWbXwPfiSrMbDLiJGKFwKmFhv+HnAKIECAcqjYjoDDF5qBPLyqowrKH1ZHdR
	PFEGSLqE/s/Cfan6oREjMd1GnReS/vwVipYONyXLzS/Wkghuzh8vkOYZK5sE1iYzbC7fgurtEXj
	H7JfSWxYi2TdW2UIIBeaUw8uzdebB1MWKImKs/M/6CLAUfafQLpEXMDhhBjcIWuo=
X-Received: by 2002:a05:6808:169f:b0:492:8920:81ca with SMTP id
 5614622812f47-4ad8780ba95mr310217b6e.5.1785368486698; Wed, 29 Jul 2026
 16:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728215219.753678-1-gitster@pobox.com> <20260729172524.4022621-1-gitster@pobox.com>
In-Reply-To: <20260729172524.4022621-1-gitster@pobox.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 29 Jul 2026 16:41:15 -0700
X-Gm-Features: AUfX_mwv3K7ByQlNZ1ownmzE8iLPILq554YKp8aF-M-VfuKhi4EX-4f-YQSx6vY
Message-ID: <CAC2QwmKD1d=-mz4WrkA7CHwi-ko75MP2LDFPWx+1FGLQtf4QtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] git add --resolved
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 11:37=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> When you are the maintainer of a project and make many merges day
> in, day out, a lot of your time is spent resolving conflicts and
> adding the results to the index.  It is not unusual to have local
> changes in your working tree that are unrelated to any particular
> merge [*].  In such cases, 'git add -u', which adds all changes in
> the working tree to the index, does not help much.
>
> Here is a new option for 'git add' that lets you add paths with
> resolved conflicts to the index, while keeping unrelated local
> changes out.

Please take this feedback with a grain of salt, as I am probably not
the target audience for this feature and am still familiarizing myself
with the concepts involved.

I wonder if it would make sense to separate the structural selection
of unmerged paths from the conflict-marker safety policy.

For example, could the user-facing option be something like:

    git add --unmerged

with the same default behavior being proposed: select only unmerged
index entries, and refuse the operation if any selected regular file
contains standard Git conflict markers.

That would also potentially leave room for explicit policy escape
hatches later, such as:

    git add --unmerged --allow-conflict-markers

for cases where marker-looking content is intentional; or
something like:

    git add --unmerged --skip-conflict-markers

for a mode that stages marker-free unmerged paths while leaving
marker-containing paths unmerged and returning non-zero.

I do see the argument for "--resolved" in terms of naming the option
after the workflow the user is performing when resolving conflicts. My
main feedback is that the implementation selects unmerged paths and
applies a conflict-marker safety check, rather than determining semantic
resolution, which a name like "--resolved" might imply more strongly.
