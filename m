Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26523793DC
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791458448; cv=pass; b=XQGrCqGctC7Jvmk+rgVLST0OVnfeW0t/JECO/JvXAN6JV3twDUHJTiNF/eC0Wo1hmixpQj3w8Vv2ZqFT7IkX25cj5u3wDOTiQdYUJl0XS67yXP3JrYlUoBryR3Km0ciJ0CUS+lKQoZBBUYQZP2MdT3zLWARjkYbNH76BTEOKuRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791458448; c=relaxed/simple;
	bh=p37ZoLAM6dWAnJ9JGvn8RK3vsZQSkQY6EP0za3eGp38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNsGPx+Mm12r3FMCMmncJhLhLjD9LZP6GgzWrFEAHeunjCZcujLiv0go1RE7U17ZsmcOAcLkgHbJ2PWDGVsdr9L1tVTOJwdstTreHGf4YZ7kkFeigAH6cJC3Tu/j1RnQetdc5iDjlDbCW1ijaZFs7SUP6UP2kIIhN3kPUwv4rSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=opencanopy.dev; spf=none smtp.mailfrom=opencanopy.dev; dkim=pass (2048-bit key) header.d=opencanopy.dev header.i=@opencanopy.dev header.b=ULyTpHFa; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=opencanopy.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=opencanopy.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opencanopy.dev header.i=@opencanopy.dev header.b="ULyTpHFa"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so18508155e9.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 04:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791458445; cv=none;
        d=google.com; s=arc-20260327;
        b=pw5hRd8yL5CQaES8zAm3tQJRjK7/8jBjqKFu/j4NJOkVg7axcc+u3+t25PzpI7An15
         YdLXXQFE4oZuzy4aCwBH6nYOlecDxVXoYgz4dYnvcaBSXl/5VSCUzmmP+Hd3O9hupSoO
         2VlwuaIolIeCGWiTM9JYAInC6nuugZXWBLuoh1rjO1rtNJzxDaelLQiHUxXLpsuXjQl3
         eE1XG3TVNpVqFN7um+NHuGgI7nswwlPt+wDMgp9ghJPsyDGlR9BIA3JZeF3PiFDAK67V
         IOkqC5tksYSgHIQE3zKsu+BJEohe9sIE1N4l5q9sIZhfBc0FvTwSb1yETTDWiBpPdSWn
         pZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xL+kBYnhfTxeOerYC6LPZXRVwyTScV0q30s/TV6fGGU=;
        fh=8vWCVlEZbk1ksoVkWiCrBvrsZYHHaYo99+L1+d1l+88=;
        b=snrng2y5XHCctTM961l2uh1f+8I8E94Yk5nKyhxYb6gRifDweTmNJSNvvRNLSau8+e
         4RxvdZmWHUH8RvQTPfTeGG+Z3ZVoq8GKYxIBaF3l4+gl58nG9HtQHsN2izc3BU8xEmCc
         Lj6JjNp0kq4/fFj7Y9FqOVjG0pTeJdkbXWx1u5ymV0JN3Jup5pDpfcwjBRg4npHfAon2
         LS0KhOk3vCVM48W6kcQPtZTaLqtP/RX741EvvZlG7WhO+MQIlNmo80lT5SB/usgS08vE
         erbRgBwOlnPIzCLyn0rWUakHCAXsLuEh6ohe5FgsMUAe3eiYT+v53qtui4Gm6BnumDH/
         Q+hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opencanopy.dev; s=google; t=1791458445; x=1792063245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xL+kBYnhfTxeOerYC6LPZXRVwyTScV0q30s/TV6fGGU=;
        b=ULyTpHFaTqv88YitN43V5mDvON7VaqFmPVf5/LzQCa2BtCe78al/s6irul6DIn8X8q
         tQdkU9RfmStH/tWjC+YQmmZ43jMHtk6dJrmfZf8A7aBi3aHf7hfeHcPKZK/c8XDJKvN8
         9Ss+ItBc8JT+aefe7FM11XlW/3ElgFsEuFu+x3EoreV1KcCpcof+XzEtLN8PdTM1ZFNs
         U0R0ab47VID9F8qOZoF0GYwllUEPq8klP47zyQkq2srzbhvv0+XCDuZVcQC6n+dm8zuG
         AGagJVJi0Br3JQ57RTzrC3R3MMPavKDxauFxoEmhO0zoqaCqk4vhn62P3/Ie0jGlwza7
         tK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791458445; x=1792063245;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xL+kBYnhfTxeOerYC6LPZXRVwyTScV0q30s/TV6fGGU=;
        b=1rtbe8pTqUFUr2uNCU5Ylb3Q97kMLHVNui0/bocOGwRidWlhobd2BodSZvWaSQLnvV
         QOWl/e8cNwuL7673Q9y2hgwXE7cRJ6iuMSNgaE/moha4HRnf5/Jjwq1nFaqiki6b6NjL
         ypsqPjCHkr2SBAl413QBq6O4hDV8gpiklErQc9cs6WFYH+fUEE8pdgnxUHU+uhOK15hZ
         MvZXQY/Sz8mG1Pv1r/eFS/JF1ALDWA4fZ4qKLZbif7W7CUuKMjovAdu0fuM478oZ032L
         KNQvI/z/wWTel34D5e9392wCbZyf81x3DlJt4RC+8hFktg4hqiUVCp0yolKpJ7NuqMHV
         Czbw==
X-Forwarded-Encrypted: i=1; AKwUvBxUYARW5aRasfLnpiDWNYwfqLb/jgKQfbXJbeMzhcGkhf29jqEtjlK4lKpvzXGLG8KXfaI=@vger.kernel.org
X-Gm-Message-State: AFuF++nXgooDfXCF3Xo3AsxD5irFUfURv2jdkQCUzrex/IHlr5Vxpny1
	hXd/ngKcJUB0I0yE3GphEdgcwTHpRz54eJzIViJjUP8hMGz2SimHsTw2RYLM85+D6iAWiuswafm
	+4ynpdDGzuXzdGgymzlZOEQ3iRjilA/iavEbkyzPNp18=
X-Gm-Gg: AYBFou1ZdPnO0789/HP/vs0RqhSt5wDDo34/xnttczUspRO31W+Tr/l7VMuSVIYo8pC
	Ci1y8Bq+E3Msuc9YB0VnkpyDY/mKwiMqtQv5S/pT6HtbgDWFPSYvoZqvp72+AA74bwN/2rZdw9E
	ldC0OQBSWILd1j122M6iyNUG0wyCe2+jYEzrJkbn6TE4/lkSmMmwSWj7V4+awpQpEROIWYVezHB
	IiMALR2mCS9xy9Tm460Mp57i/ZqdAw/oR4RqIhvL8iKkzcA/xtp0eavHv2sICVzf0SnbCPSzF54
	zgfAWYLlUUQcAvXeqiqCvypDOlQEDbh/4BP1OlY6F6xugYrsv+ffh5YKAQ==
X-Received: by 2002:a05:600c:83c4:b0:4a1:698d:3044 with SMTP id
 5b1f17b1804b1-4a180313c64mr88691525e9.11.1791458444400; Thu, 08 Oct 2026
 04:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929112544.86511-1-scott@gitbutler.net> <xmqq5wzda0h6.fsf@gitster.g>
 <CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com> <79ae606b-cf99-4867-9db3-bcd7ff03626d@icloud.com>
In-Reply-To: <79ae606b-cf99-4867-9db3-bcd7ff03626d@icloud.com>
From: Sam Reis <sam@opencanopy.dev>
Date: Thu, 8 Oct 2026 13:20:33 +0200
X-Gm-Features: AclHuK-mplp2dE6knws2RyCdN_L1axLsu6WYH1tL-rB-LR_txnJI468tNVKTHus
Message-ID: <CA+Te0V+-O3avrvH353KfCDjAEzMa=_H57G4OmiJ8+d1dDzZ6aA@mail.gmail.com>
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
To: Sebastian Thiel <sebastian.thiel@icloud.com>
Cc: Scott Chacon <schacon@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey everyone. Just for the avoidance of doubt, very happy to see
Scott's patch here land and for git to benefit from faster sha1dc
hashing. Let me know if I can do anything to support!


On Thu, Oct 8, 2026 at 8:21=E2=80=AFAM Sebastian Thiel
<sebastian.thiel@icloud.com> wrote:
>
> Thanks for reeling me in, Scott!
>
> First of all, I am very happy to see that overall, everyone here is
> making an effort to find a way to speed up SHA-1dc again.
> It's so impactful!
>
>
> It really did hurt when I finally had to add SHA-1dc to Gitoxide and see
> the performance of clones plummet. And it still hurts me knowing that
> an incredible amount of CPU time is wasted doing something that we now
> know can be done much faster. At GitHub scale, this must be more than
> a blip.
>
> While it's my dream to one day have a GitHub action that uses `gix` to
> clone and safe even more power, I think Git is in a far better spot
> to achieve significant savings much sooner.
>
> On 07.10.26 20:13, Scott Chacon wrote:
> > Hey,
> >
> > On Wed, Oct 7, 2026 at 7:23=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >>> This series ports the approach of Sam Reis's sha1dc Rust crate [1],
> >>> which gitoxide recently switched to [2], to C.
> >>
> >> Which means license-wise the original is compatible with us, I
> >> presume, as they are "Apache2 or MIT, your choice".
> >>
> >> How can you/we be sure, with respect to the current AI policy in
> >> SubmittingPatches (which by the way was vetted by SFC lawyers), that
> >> your "AI generated" code did not "borrow" from places that gets
> >> you/us into trouble?
> >
> > It's a good question. I actually just submitted a proposed update to
> > that policy based on SFC's updated guidelines, but either way, I
> > learned about this from Sam and have talked to him about the port and
> > he seemed excited about it. I can triple check, but I'm fairly
> > confident that he's fine with this and I am fine signing off on it
> > under the terms of the DCO language.
> >
> > Of course, he in turn used AI tooling to produce _his_ library, but
> > within the guidelines of the updated SFC guidelines. Johannes's
> > alternative series is the original Rust code of Sam that my agent
> > looked at to produce this (in addition to his blog post explaining
> > it), so I'm not sure how that might be materially different.
> >
> >>> The end result hashes roughly 2.7x faster on the Xeon and 2.85x faste=
r
> >>> on the M5 Max. Single-threaded index-pack of git.git goes from 24.3s =
to
> >>> 12.7s on the Xeon, and from 16.1s to 8.7s on the M5 Max.
> >>>
> >>> Hashing throughput on the Xeon, in MiB/s:
> >>>
> >>>                                  16KiB    1MiB   vs OpenSSL
> >>>    OpenSSL SHA-1 (no detection)   1234    1129      1.00x
> >>>    sha1dc/ (today)                 435     450      2.67x
> >>>    shani+avx2 (default here)      1002     901      1.24x
> >>>    shani+sse2                     1075    1008      1.13x
> >>>    portable+avx2                   553     654      1.96x
> >>>    portable+sse2                   603     681      1.84x
> >>>    portable                        466     565      2.29x
> >>>
> >>> In other words, currently collision detection costs about 1.5=E2=80=
=932.5x on
> >>> top of the hashing itself today, but only about 0.2x with the series.
> >>
> >> Thanks for these numbers.
> >
> > It would have been better had I provided the same relative scale (it
> > should be 1.5-2.5x vs 1.2x, but whatever, you probably get it. It's
> > 20% overhead here vs 50%-150% overhead previously).
> >
> >>> [1] https://sam.dev/blog/faster-sha1-collision-detection
> >>> [2] https://github.com/GitoxideLabs/gitoxide/pull/3008
> >>
> >> And the pointers to the original sources.
> >
> > CC'ing Sam (sha1dc rust guy) and Sebastian (Gitoxide) on this, just in
> > case they have an opinion but I'm pretty sure they would be more than
> > happy for this to be integrated.
> >
> > Scott
>
