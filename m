Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84BA3A3E91
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069373; cv=pass; b=NBj6JnO+7ktI51kIiKFhwRrvsN1L2eohQMJhtLEFx0wQ9rwWR7y+JqUIG0n+6+Swndxu0R9ld7aUSNL5EPTQSYxNMWe5vNJwhnvUeIyji701lZBVxUJ/OU04B9rLBdQsmVDtK2n3i1QSLarX0rYih2wpvI0A0g5ShzGN2GO4+sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069373; c=relaxed/simple;
	bh=eTjJHU5LvB900MUmBVpLw+FZv4yxll+OM15q34ielLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhW2KVBYsmX1XSGb83O+4fKE+EGDe8v/2T9yI1rUfvwcSiVQAk9LVspmAPvPk+CMRBy7nyfiAGpleCBqoam7d85xh0sKO1as1Si/JWbEWBXSK68KqGn7o4VPYQ83cVsAC7TIaKEPohvGMwrwxlG9aO3GmGKkWwD0sPYUJbaQvpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lozL4Tdj; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lozL4Tdj"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4b1bf68b387so60779b6e.2
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 09:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787069370; cv=none;
        d=google.com; s=arc-20260327;
        b=r+GQOWV6xAFESxlJg5BuUAiMDKl0jX1aRunEgVFcVEiK36OBRrrQ/PZYtKN97ByOg2
         RlVY1V6YHPVE5wFdgOC9KOXk8pSOEUIgHlG0t+UftY2p63/78QLyM66FHHt8NdHy3tId
         p8XqHwjkULunxlN/VKPKqexdvXkGk8PWJfcsy7u1FkYUqUJGixFdYlZ+WiwlI/FW+I2m
         UvMx63cFlYdhZPCDCg5KOcoRGQg5ErbJlc6zNysPyjgoUCb8aoEkSMzbdZOYkO4g14QN
         BX0CtG2FJiZFM3Dnzxw6VcQOomHGUjEOCwG8V0T5PEBbtVo6d2qN3o2y9ypvDk8419JI
         96bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eTjJHU5LvB900MUmBVpLw+FZv4yxll+OM15q34ielLo=;
        fh=2fKBGui0CPLp/DkOGwBJS2c6k6TbQqR+qLNrnXY2Uzw=;
        b=qGoDv8apHzAVJAj+lrgwYr3Anc0XI5ATnSFcmvKRRGmJLvoDGk8es5O8XsrR56CF3V
         zgy5pgnEDzjktpqD+ODVpid6CAGnE5AD1SY7GZETYFe5Gco496w+D+1z0KKlhFiWQTf3
         DX1OqSQpBDbOgtNg7Dz9fo+3ymv2JCAOS2AKF2MQqfyZasssSBIeBxYvNsxK8ezUxJGG
         L9gLv2e+RF548Q/+2AvPvM8GzdmX3nZ5kSC0nhlh1fax0qMIXLREbz95Nn50sCQNqWAD
         36hW00iWUHlfh77Rxt1JTkAHI8SAhxItRbEqrgYC8mXqaixSEJ+23L3NZRSOLPCKiVvx
         0gyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787069370; x=1787674170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eTjJHU5LvB900MUmBVpLw+FZv4yxll+OM15q34ielLo=;
        b=lozL4TdjoW5/PDXSuJlb53VeDR3nd8P9aMDdP1b5bN62gsFcDyYDdTlf+05I9d76zp
         gQf1Gx6D7+5HjDJlbPjKyF58963IXBZK9+A+5Esn4t4Lt8bl32rhiYJDAkOHvkXjHw3j
         cqLVUUz4vfikxRlccUUiwTrCUEJNL41t6Jxf6I2NF2hlrgVehM7E57LuJ4hxqipP8eH/
         bIZzG6vMeevYN3pzH7IssztRGT0hxvOsv9/95li0pZ9o9v3JmJFsaz/4ydFNe0doC00n
         y/qF7KSUSxNNohpWl1tmbm7GsQBd7ZL7KrKiwS2gbrL65ZNvn9jGUv7jor29qfP2/K+Q
         GDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787069370; x=1787674170;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eTjJHU5LvB900MUmBVpLw+FZv4yxll+OM15q34ielLo=;
        b=Orx4qNbJToCmClNGj4Afii6eZD7gGpVHJ1GZbCPwpa1xhmPvR41vMu0uQA/yANGoVY
         DO5jCl5mw/i3qzC15UJZbadLi5iRdsxwDQ70i4VlTF7KPZCUwBRejnwYuMocAl+oyiLu
         O2b4kAEaGVoLORpptkIAPOMLqhA0bgjopBGVgFUxgozTB9RVhInp4fZliyhVCyCWkhCf
         nb1ADzV+ppYaHHNqTwL+9fhm/0GnM8xwMUB1i9vksEky8gnytzA/92Pzkw25cRa3uZvV
         8zt/LwwtHmq90TwAf/qlzu1qeUXaNjJJGXe8SrP82NSulULrWi9YI6K4mVGlPOsy14XQ
         8hTA==
X-Gm-Message-State: AOJu0YxASy0J+oT/YpNNt99ltpreDy4+ucsW533h5sZ/AsF61B7aSqMF
	H03a1G9axNFnZpioBP1gH33SVfd+0lIA+ctHySZf2f9qFCHIjFuLyhjsWxpv8fangC8EsV/vcIw
	ee7WOou37X7SrLAE+5Ak25uN7EVmW+BY=
X-Gm-Gg: AR+sD10HMx35+U62Yfh/JDQ8iP+MiSYaiB8xZoM394djrDfFOZUWla+hTrHXbhtYybU
	3nDMVowfHvQtcEtW4h9DJS0heJv+c67Oq8j/bvevrJtzPk4LM/4cXTaFugcalFHQqvFXDNiFIxI
	hKlJwhzYXx3Lyjx9d1LNPbbAn+GhqKvCHE/NBppDB2ir0vsm2ASDW8FQW2J8h/fOgN6Dbye9Arp
	/WnxgLRmfq82SA0uqlUIfBztNESJ0RLHzu8h2EhH1R3RGbyfeUZRlowUK1KzdXy3UehceykSCfQ
	jG6RtUYgPC8BK50G8YLB5DB73MjPFTA8pH6NnJpGMDWr1yk66yR8voiJOTSc/xXBHCMPt8/8DLk
	BENaArtuykjgGI7370Pp3CVpU3aJArp5KAQVuTifaSR1PYSe6ydXIOF9ul1p0Heo=
X-Received: by 2002:a05:6808:280b:b0:4b2:69a1:26e0 with SMTP id
 5614622812f47-4b269a145efmr15702452b6e.15.1787069370582; Tue, 18 Aug 2026
 09:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260716012138.6714-2-jayatheerthkulkarni2005@gmail.com> <749F5FAC-5803-4E7A-AEC8-BA653D329EE2@gmail.com>
In-Reply-To: <749F5FAC-5803-4E7A-AEC8-BA653D329EE2@gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 18 Aug 2026 21:39:19 +0530
X-Gm-Features: AcwNN1XZ8GZHKH9jj30R-_njpXs4YHUzCwvnhzlTZqSpCrezqJcJRRLdW3LboQI
Message-ID: <CA+rGoLf_BPjsxxSz0-DJgGos6iE_7mo=3FMvQsfNpgpFg99VRg@mail.gmail.com>
Subject: Re: [GSoC Patch 1/7] repo: add path.toplevel with absolute and
 relative suffix formatting
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Lucas,

On Sun, Aug 16, 2026 at 4:37=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
>
> >
> > +test_expect_success 'path.toplevel absolute and relative' '
> > + test_when_finished "rm -rf repo" &&
> > + git init repo &&
> > + (
> > + mkdir -p repo/sub &&
> > + cd repo/sub &&
> > +
> > + ROOT=3D"$(test-tool path-utils real_path ..)" &&
> > +
> > + echo "path.toplevel.absolute=3D$ROOT" >expect.abs &&
> > + git repo info path.toplevel.absolute >actual.abs &&
> > + test_cmp expect.abs actual.abs &&
> > +
> > + echo "path.toplevel.relative=3D../" >expect.rel &&
> > + git repo info path.toplevel.relative >actual.rel &&
> > + test_cmp expect.rel actual.rel
> > + )
> > +'
>
> Question: why not use `test_repo_info_path` here?

test_repo_info_path doesn't quite fit path.toplevel as the helper assumes
an $expected_dir suffix and constructs $ROOT/$expected_dir and ../$expected=
_dir,
while toplevel is $ROOT and ../, respectively, therefore I made this
case different.
