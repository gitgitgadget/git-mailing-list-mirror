Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792854964;
	b=nBpHa2tfVNbeF6U3Vx0kTdrAf4bhU4LfFigvq0fTKTZgnPfzPK6p/KlSsZWDncN7VSfZ
	 Fv0NiH3PEetPXpNYq1LpwDPbiwwEM3rRxXK27vo9dBtcUbdHYH4rPLU8c8Wt9fxbykoAv
	 pm7aPSRczVDx4Lpg1EpWX6b4maypAPL5JzlxBly+ZzF6HWZDqECXLPsN0f9FL4XLi0Icw
	 J6aQXz3Bb6NETtAFNOSs50INsRgGKNR0bbI0PUGJ7T5X3D/xzXmGRpVy4k9ST/PeeDCEP
	 oWpB6Y16nEBSBb5cEtCfDY9vQgu30aoEpYbcqweqiV9dobjdvz4/VcmPI3+GG0QB71A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=z7kDz9FbrQqVrGKgxdm5QpYgkpxnT/9RILgdTkETGxU=;
	b=Jt0EwXL1+vFmkxkQJBKO1+pvB8E8VZREfqLIVj9mCR1EWccjqwJD9U2JScw4zxqdyvUJ
	 iI9LfwSog1mSn3qt29Q4SLPCVI84iEUXSSFsuRMRHRvGR3eZnxWJeXS9znUCpWt3WFvLt
	 Bt44IykJye/9e0s/7ugyBEat6jQABmrB/Ls6Riq7ARfY29yfXtgedl4sBYhFmBOaHxNUK
	 fXitkY5o4QDqjOy2BHRRPao7QrjLcl8jZa5Xy7PWWK3TaCzHGcMtufjLncM0AbUP2YKZg
	 0KmQy376eQH7G1+6qV/tVWeoZgM/1xNI19ES8pXI5JxKOHB+f0FPgX2x30kvEawr4/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fL9txD6z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1107606A31B
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1107606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fL9txD6z
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e8fe8e343fso9508495ad.2
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 08:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792854963; cv=none;
        d=google.com; s=arc-20260327;
        b=NmcfDpLx1tzd7p/BWjRYKMw6R1kA4O2Cpl6iaY0v9TZ0hOkp+Sv0AUTv/TMrD/mGY+
         m6YtLLtsI7hdtON7kN6E+6/2wq6lxfF9Lwv1ZDJgmBO4/WGaN1nxbLfu/Zq3Qt8lgkmS
         5u4usL5Gz1/TyXj9XupHsmHDGH6fmd+l9e4cxNkEdW3ygRDSIPvMuMlq7gXPyIIxkn+V
         x9dK6+gqqJG22ffxsvKBTWqDVkKq1NLwuduXSIFfXRyNIHs+w1A4PpGRhJItEJDhM0lb
         2UC8vFShNx52LE4w23weObWOMBy4/7rvXWlf5Twp/9NEJzR6WTI8UFWDxS+sOj+JWc46
         doTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z7kDz9FbrQqVrGKgxdm5QpYgkpxnT/9RILgdTkETGxU=;
        fh=oQFHZM+SEk4szQrC6U0bCQoO46RWO5A983onJ/zu8sU=;
        b=Fr7z4q+6rVW7/OY96Jf0ONNZWY1APgzTG1W8Jv7rIqxuh/MhHMJyCiza5KidTYlPbR
         z7pG13ohnBKIqPb3z4Urhn9A0ofS6YSo6/v7LCFRCU8RwCnI7+x8fgS+Ow/ZIfjv9dWJ
         7Jt13m/Th69KcNPLmgYW2+FCWxJ7TP0oxvLCPc+MdLygH0GKzPrd2ZMsqcNQfP6MVXxO
         MrGRLJ5szZDTqKXuh1+FxfSgWTo0Igx/VvcQQKSbpf5O5Rg9E0rc5sHIZbp8xAt55yYB
         MAMS8xVJ2Lu27elk0I4tj9SentMPInhOyBR5MWWm4Zs4nkKeWgP8mKsiRnaFoWHOj3Te
         GQ8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792854963; x=1793459763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z7kDz9FbrQqVrGKgxdm5QpYgkpxnT/9RILgdTkETGxU=;
        b=fL9txD6z/q9BjvgzbOBBlRgYMP8zIESeuhcHXuzhKu2zzn9bKxzAiGVwgk5umEiF88
         B+Bga36aXHXXYVKk/bZsQbsdqwrsKCKTVj0lCG3yt09w/iSuDUPFw6EVj5F7CxA2DQmp
         vl3U6/qusPF19O5oKsE7IXbIz33bJo/SYaDf7/TKZHV22LT3YYLEsKkcMBoQ/Fk0vw3E
         T+n5hEwygBu0cT+lorhuZaKmVZCL/fjKMt3dQEuvsOYs76cQfka5LTEGq22R5ReJP0ZL
         ACzQi9B5eELWg6q1cniBsJDV/a6HaHwCyH1vkQ66EWnr0vrOvzK3wUVpMQ9H//XCyzXz
         QIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792854963; x=1793459763;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z7kDz9FbrQqVrGKgxdm5QpYgkpxnT/9RILgdTkETGxU=;
        b=E7mDk47ie6CqeaTM25lCHDbEbquG0KcW6W7ogl3EA3ZzfYlesAU3+4cjq8jbCCSBF9
         g3xLgebS2SqWltR7vv5tKKg4tN4cltvJRCHuUQogDmNbIvgnlaQrBambThKx6A/vDGnY
         wRPxqh6NYmY9lLrOO/0fuN+IzB8nGYGDZziuWJWdaslxM5l7QnW0xDlXlR2KvOw67ZPX
         kWaaLUyz231uhKNyG9g+1JFYMNWgSjJDFLIp6zCrbV3eKgMOcXcXuhnT9SV+Iq5aWs9B
         /vDH4YmbdBYBDKygSjUf6HdAHBxyfd2uOGXgevV7dLKzEpX0snxihv/UetfX+SbhAtrM
         gpPw==
X-Gm-Message-State: AFq9FYIol/JhKT0RsUo1LHBKbehMkZNLX3pBq0St3sHiqy9IwaC6Un3a
	HgOfWuiMvph48hLeR8OIcrkJGIQczdD/Y0cZF3RdyGKNVqIXxl5OwZoBhIQoH4NuFdxxPhehR3A
	qjXIx1FPKbtNFUicJ+jr5naj7qfvR1XU=
X-Gm-Gg: AYBFou0CgJ93SZtGnYTmz+qnZN+msvxI7IlSuS1iBBNha/AwT3Ar0+m1byDAqo41xbn
	mQPN8I++Le6iBc5bJ60kQurgDiBnGxtd3O0M0Pn9SP1srg77BYgw3U35yBwoovJwherQl1fXQ6O
	SeVpg5lYQHUZ4p2779KaKYWObTnRt2deYO7Yl128dMdPun+gWcqpMgM3Pdd9iDdTrjDZaDf6Kn8
	PKI4VRURfQulgC6iO16X+oKBYrGKbclEGTvzHFaCVLj0APmi2sOAfmFgPFDJYV8mz5NSNX8ED5z
	dzjQS3UfGYevE4QRpgsLmzwOxy9sn1I+xCvnE40G5TK1mgOae3frHGoYASslJ2I570EN82NT6WN
	T7c/QZJYKaDMD8KxhTsKZ3NSwfEQGz8MLIr5rR4M2xdzbkk5psHF81Kitg82jcBGTlXyJMzk+Y9
	b96MtT1VvGQlf/PkggGi11TUAV9EeVleRLJ9s5Pni0SyyaAoa7grDWJQsvEcKcMoPuZ5MqxxDUv
	g==
X-Received: by 2002:a17:903:19e5:b0:2e9:52dc:4c10 with SMTP id
 d9443c01a7336-2ea9c6c75bbmr16924125ad.18.1792854963127; Sat, 24 Oct 2026
 08:16:03 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <xmqqcxt02eoa.fsf@gitster.g>
In-Reply-To: <xmqqcxt02eoa.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 24 Oct 2026 11:15:51 -0400
X-Gm-Features: AclHuK_ZrhP-yYViGD3-y_yYc4VTFwLOwFGwdRclMmandWpfDPvyY7WeaS__O70
Message-ID: <CALnO6CD9sB8JCE42kWa5MO2sD=WzstZ8GoHW2PSpjdpRDF2EjQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] fetch: avoid fetching every branch of a new
 remote in a shallow repo
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 7:13=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Avoid fetching every branch of a new remote in a shallow repo.
> >
> > Changes in v10:
> >
> >  * Resolve merge conflict after master integrated
> >    ch/fetch-followremotehead-lazy-validation.
>
> > Harald Nordgren (5):
> >   fetch: add remote.<name>.refmap
> >   fetch: extract collect_upstream_from_remote() helper
> >   fetch: infer branches to fetch from a refmap-only remote
> >   remote: add "git remote add --limited-fetch"
> >   remote: default to --limited-fetch in a shallow repository
> >
> >  Documentation/config/remote.adoc |   8 +++
> >  Documentation/fetch-options.adoc |   5 ++
> >  Documentation/git-remote.adoc    |  14 +++-
> >  builtin/fetch.c                  |  92 ++++++++++++++++++++----
> >  builtin/remote.c                 |  31 ++++++--
> >  remote.c                         |  51 ++++++++++++-
> >  remote.h                         |  19 +++++
> >  t/meson.build                    |   1 +
> >  t/t5505-remote.sh                |  76 ++++++++++++++++++++
> >  t/t5510-fetch.sh                 |  63 ++++++++++++++++
> >  t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
> >  11 files changed, 456 insertions(+), 23 deletions(-)
> >  create mode 100755 t/t5586-fetch-refmap.sh
>
> This topic seeems fairly well done, without seeing any additional
> comments in the last two rounds, but I am highly disturbed that I
> was practically the only person who reviewd its later iterations.
> Because I am not a target audience of the feature, I would not be
> surprised if I am missing something large.
>
> I would very much appreciate if somebody else can give the series
> one more read and Ack them, so that we can move it forward.
>
> Thanks.

I gave it a read; it's possible the things I wrote were already seen
by you and not worth commenting on, but I'm not sure.

As for the reviewing=E2=80=A6 well, it was nice to review when it felt like
things had settled somewhat :)

--=20
D. Ben Knoble
