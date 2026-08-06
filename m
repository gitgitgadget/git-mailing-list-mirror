Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BB0480331
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032000; cv=pass; b=lzMr9tdfdXkR2xJ3u50okeSo7gj4k4jKG7qkIMGId+STs8oqUHP+kXJCSWiTqVFZ++hx1ex5oTP2lND2T1He6mZ/Awdv2hmpXZyCXkHAzlGs37OxkSoRvuenPSHdScnnBWy0rhKAGdLS+R0xUeFTxlO9O89Mb8NpEv8kUXj3gnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032000; c=relaxed/simple;
	bh=pXOiikr+i7yBl5kFZ2mSxixaCfqJ+phTogb9uuEEIWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMRK+SQ7WgI4mIcXrB7+mnwSqMzMcTus0C6s25QouafA1cwoxM9S5VPdAsLvao9APRoRqIHzhLd2XkOCyT40fTA0W5QP0GlrM/w/KDnMaeWbjzhFGsmH1Lc4yvxYnmyXQz81lmPo8Zw1ytVjou63qVrZ4c2yR5WyXFpRrou5LI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spz0LnPX; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spz0LnPX"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso3558231a12.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 08:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786031995; cv=none;
        d=google.com; s=arc-20260327;
        b=a35Rd1PgBHuEUz3dWAg1rk8ToRTDb6rSxbNwaaaqjOXLhxOl+F+NKh8cdiCl1aNlNB
         ZB+buZ801TKsgPhR5H87EOvr+t1BdWJ7qGTf5m8s6aCDSei6loE3uMemAy9+d5fwH3Du
         3/4GgXJ2e47HGf16ppsadtyqVUnc38aC5T7wHr9vVLpcjwiE6Epiv4UM7+lN4STmjHz2
         CIocYkSh+GVRbLKDXa6OwP5BNsNnsXEZHlkHVgKsmXM53Byqb6GIrPwYTcD/HZeOQ6aS
         cDXIEkOy7qcsCjMcqGz0VktpPnekSXzg/sW4L5icyqINtyiBwKFCFtmb6xXg1AWt4zsB
         3u4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hzKoablORe/aCwuHcvVHKgCXa4zY993VP8fWSCEDFvo=;
        fh=fUIyouBM+bQq+KD/y9TgugC3cUG1UfBR1MRSG3jLYK4=;
        b=NwoZtHFYfvd0ZqYwFraf+NLvQI7jcwcjBChAbuTjtiC06lDYipWMX4eXsZ4DXPO3ra
         hh8Yam0yIkKLprtxAgCdTr0azJCLmX3p4URqoU9pDeEiIRgUMl9qGg6EN/HM95MYL4Ma
         lM2y2BsTpl3JhR5lZg52ADXfUO78k28Xh7oKfVkX06GtsIkfqYAIyQwJ/UQTLb/MPRgc
         nSEDwExUqekDWfRnGGu4fuKhpZSwq5Xq/kEysyAPZ+450SV59K/8rFo44X5tK25AuFjl
         EBbreIEwUqLLNmLN0vVIhG4jvjZ7oH7NthWwCcU3nt8+TZOSlfKKRcdzjhw5TQQVvG2e
         t1tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786031995; x=1786636795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hzKoablORe/aCwuHcvVHKgCXa4zY993VP8fWSCEDFvo=;
        b=spz0LnPXza7yitcakY0xiwifj1moU9Dyar+f87a5B38gxpTOl/HkplLwwRqhEiLSn+
         MDcr8I5ixEur3ARxyl1IBbDwZ/B1dsyT+QPHFJ7rmLRI7ntD5KnHJKTFFIj9p4cZ2HUf
         8KLPEWGmJ/9h1naekBW+kM/RmEIBswVfuzkv7B8ONmkQcva+TfjdYf8+VvnzVFyLDtuH
         LZIfkBOFQXacOBWNy5omRK4sSXpVLAEcmCDkncWn6bc7tM5qfJPMNBe4VzZ4sP3Dfo9p
         S2WUPoFYGGplqKab19kF1qreAnrDOznloKkx6w93uZytbzyxmi2lO3f8kYcWKFuczZtj
         TTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786031995; x=1786636795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hzKoablORe/aCwuHcvVHKgCXa4zY993VP8fWSCEDFvo=;
        b=qGPF7BIsJEUEyfvSDAs4vZiiBcoCivbLED0z9Sfe9dfJVWD0Kwb2eckA/4tN9e5FOs
         4pUwhJzYdYNegssMqNKcH0UA0hCcSvA5zt/o77B5wlRdQzk2O8/07kD6pMd+Vvg+fAFZ
         rcEcKB5cTJKRhzvQn9+dZ7pOSVWfC+XU+b0D/1UKmqZHZ8cN31w146WL3+LnZH7jPCfw
         cfHzVNGWp860RYzZymQ7lQfgIyRMQz4Hx0qf0b0COj2WP5PSzw3PkkwuIgX61KGDTSkF
         MDqbE8aibPWKIBWb9RrqJ1ddcD4gao2McuX2FNZ7So/5IO5GROiTQHxGFg8JyOipDnB1
         y9SA==
X-Forwarded-Encrypted: i=1; AHgh+RpJxp7TAgar800P95q8IMig8anLXKufSrYrGMlwfZnUIzE697Q+NYYZHELtAOm7bqrAWYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYHWxwzUWAFyAMBqKbDbzT8M6wmLDbX41h9QgL6XIl+VOV0J7
	GmjOojKHAzphTjQ/S3JCXAhWOnwX2Xu+V9cXspEVVrlEg2gdWKGlk9NNWs2oCjJJITiYu/r8M5H
	JUyB4kduYKBQ/SstI3rdAdjSPTwfhiZs=
X-Gm-Gg: AR+sD12kQuid9nvAtrirNKblPrQuenGzZ0cEUTgh8grM+zOUSD71qc1IRA/La08XFa3
	6XxZxXJ1A7KUJEx0GyLnnnaayv8PN0+TQV0WRbm+Kn25GkBqaePQCU0yQnCiRjER2YimPuV8eA2
	n5hAGkYTGtMWcDW0KvztPqnsLBMzVw76ZDzduyzxCwKfZZra6Ph9tb7wyhge/eC0pPoQLqVHpA5
	x47EVCk/Eiba4GQJZ8whB+jjAel91yIUgZIlWPH8vt9qDkAtDNbM6Ql0WaGpw+MmCs9pKPBUpsH
	iBmrLn0SUG3VmexyT2+tkozG1xVi2+9scCPiSF+DEJFC
X-Received: by 2002:a05:6402:278c:b0:69f:4c65:86c2 with SMTP id
 4fb4d7f45d1cf-6a14f09fed4mr7887209a12.2.1786031995058; Thu, 06 Aug 2026
 08:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
 <pull.2335.v6.git.git.1785705860.gitgitgadget@gmail.com> <97a4da55374c6dc52e6e990b3cadfaaa86a57640.1785705860.git.gitgitgadget@gmail.com>
 <xmqqjyq812wr.fsf@gitster.g> <CAHwyqnXOno2De_eOvH=LizyfWSpyVWpzGBwV4ZGW4bxOEtETOg@mail.gmail.com>
 <xmqqik5nmk7s.fsf@gitster.g>
In-Reply-To: <xmqqik5nmk7s.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 6 Aug 2026 17:59:17 +0200
X-Gm-Features: AUfX_mxFTzOYyMVXFK84A0oBOu2k5bnwld7vNN_ULaiMkqRusZ_FDnGCj51uDnA
Message-ID: <CAHwyqnX2wUsccqwmp-3WTsZQOcq0VV2TGHMPEpgKsGxOcH3sTQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] bisect: add --reset-when-found to leave when done
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 3:50=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Harald Nordgren <haraldnordgren@gmail.com> writes:
>
> >> Are there "dead end" states, other than '1st-bad-found', in which we
> >> can no longer make any progress?  One thing that comes to mind is
> >> "you said this one is good, but that contradicts what you said about
> >> its ancestor that you said is bad".  I wonder if we want to do
> >> anything special here, just as this part of the code handles the
> >> '1st-bad-found' state, for such "dead end" states.
> >
> > Maybe, but I'm not sure this topic is the right place to dig into this?
>
> No.  But thinking if it supports such new use cases in the future
> before committing to the new code structure is something you would
> want to make a habit of doing.

It makes sense, but it is still hard for me to reason about the system
as a whole or how it will develop. I still have a myopic view of the
codebase. But I agree in principle.

> I personally think the new "do your thing just as usual, but then
> the new code cleans up afterwards" structure better supports
> anything new we will throw at in the future.

I'll take this as not needing any change now. Overall, I am a big
believer in the power of iterative development.


Harald
