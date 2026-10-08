Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB435E936
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 04:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791434982; cv=pass; b=cOmoD/NIB13Fpd+3LxotaDXWST/ug7F2r32jBfuw/KwKswgxyV36KNZm5ZffokTA0iOyffTTH8l7fAx4/yyelGmMnnGTaE8yx4p3tH0oMd+tZiqv0pBRSywqGXyVKd24H7cjPCLLbwamiLUpASfcDkMTz+jGh96Q7ZAijIvPIqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791434982; c=relaxed/simple;
	bh=rqEu56vQiTh/VMJNHa1FtcNEnRerPdxC4paD3lYt/84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bNg2Z8gaOSXKfrKMFedYMQEkzPuM8cfK3cnCKhDXEckarg56n1u1bld1uOIfu7J4fx8aNZ1V8DIp+nDmoXjlYjoaHb/H12N9GvQ5azbIZ8zAXuVH79h2h41Vc/hx69pTT2qiz5weqfbZF4fjH4xTRMT9a4+EpEW91zFfLTmqqaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzWW5Rq5; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzWW5Rq5"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso5972532a12.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 21:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791434979; cv=none;
        d=google.com; s=arc-20260327;
        b=GCi7qF4VVPgAUKf1vZod5cDtZIBmKdwkQwJQgYVsqDKhMiaazYkvPcnlSM0If2wQBZ
         ya153GJXaK+3sW7JjAG7+87VpOPKmCmHmx/uA6NiZVyw83pD+IhXauz1uXYSZ6Opy1dU
         ZUaQ1BlGvCbwvUdNpWEtx27xm68Dh8xQ839PI8O8YrA5tOfgEUFGFcCy8C/s1Vbvx8j6
         KgW+HgcfnVJ52A2CMwUpgNJxBt/qlyITFR95R5kmDn/wrFPeMfs9yLcjMf3p0tf9tXi0
         k0Lt+UbV4s2sc6m/Yrz7pg25S5rSrYVMhyxhdzPjfQYmjPD0/sxe9Fqay2tnLKS4Uf6S
         voCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mg6BUv9KWlSh/hfa1b8a2GP1Liw5uG8pOXVjj28oxgE=;
        fh=45Y8NdvB0iJIN5lG+R6lNcmy1KV6LwUykJ1HSCrYjrA=;
        b=L9v90xtJtG8Lw3aEv/n6iTO6dfXiNDHzfP5cknoaDqbnb6Hx3oSnVpo24jf1tnoHPt
         Ibw+AmyEtRnECUgcVU8VbpHKemFjw/s/F8R1krISwxW0X4d12dpstnmMruSOdZc4c3Zc
         gRq8DnlJHyjgxElHZwat7zUftZNqvjmDDBKsAzHm8W5nLm8s6JfcEEBRMb/zUevHmKnW
         xSVcQ0yLSuIsEzHgegwddwWNv4KK72sNsYn26PD1aVsomI9YMb0dKuBxAdDQ89obyutA
         Ynu16oEb5QztTy7PD/lbREnfQBqjE2bw/DjdFYEOQzQvcnZd2oLFXsOs2gRH79W+zjkr
         3k2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791434979; x=1792039779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mg6BUv9KWlSh/hfa1b8a2GP1Liw5uG8pOXVjj28oxgE=;
        b=GzWW5Rq5l1IQ2xNH8kDamT9WWhSuXnjou9+CF7ORYq57C/HFz5CfxsnhJt9uFRaVLe
         h8FigxT1w/3XiXeJkdRHawzU6EvbsoIgM3w5MT3CAT3RpjYGYain9HLd2S9Ir0qzsIr9
         adxihnBrgzcErvLltdR90Bxfu2dkApT1UhOUJyVk/LzreGF3cPDFaF71LqfJxxmDLkbj
         ZTAPyaR7gfRY0w3tmr64smPtUU4e2AnkF46MBECjrqvz8zHe/DsKioSc2lGezX0KOgG2
         s3A1mnOayUpS6CDHVlbLdwJdM0qQv3LWvzn2l2W4+UVcEaQZTM7Yo0JKAph479pCCKzI
         lhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791434979; x=1792039779;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mg6BUv9KWlSh/hfa1b8a2GP1Liw5uG8pOXVjj28oxgE=;
        b=FjjXWVUqHJLRPr08LU1w2hS2CYQk0qu0njpwYwcOcOHDSKyiAdwvOBaiqq+7iQTwA4
         XW/vH5Smr2IoyAGhdjtuZ9mvaiuUyRs87mqBnBL4kQ5dHCEF0/z+Mco1hHZagBf4TcX4
         FMb2E8avf8boZzXEC3FEHWpZ8QAmNbJBOKV79zQiN/T7vToDC0HyzFxyb2EH30Bq5LZO
         i7TOd1vPkOcV8oybTaGaC7LUMRFLCJi9xcVERRmAOoXA48MvTIv+Tc7hpTwbY/VhDI9m
         sTEyhQTmWYJEsb1St0ALB82cCamAfPeVTjS+BQRREp5O/lBgHqveMwT3SfeBjNqVFz7t
         dwPA==
X-Forwarded-Encrypted: i=1; AKwUvBzMzl4hoemGQ0OeXPDEZ2E6yjP0+AduUre3+hunC0PtTkJds8MMilXopn1kHU9fJTYAT6Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkWPAl9ccjzmXSSU9/0MsIbHrORvrs5gD5vtYwVxmV66IJY8M/
	oIJjSSXrA1knn02x4r3wKlOVxEIBgL9016kG5LhFyhjiYYwiBk3CTUvdUseVJ2XhQzMhrUETdOj
	aw4Yz5wpf/INAnRx/iOFgjIpCSYmSO8q/adN18pwo1loB
X-Gm-Gg: AYBFou1LPm1w8Kov3nQaqmZBZDHeEIDCTkPNyEiAO0BAF/CxvGK7aYKJoGEZ7Io2S25
	ja9Ts+N1gEgKLgOckPij4+Jp2xLtsdo5WgggxT0nhyn7Pac6M1QnHzZNgM61Glw8a2vDXCchS8Z
	8Ac1eufTq6t59QDqhKwhB9GaqyY1kX4J/BB3Sqh9ii3vYqXrmvkZP4zc5qBr1w2f46SnpGANu9V
	eUatJvpVv8BExD7t/+YZDmJIalpqIDghjFG7ARh3o8z+fbiuWobOGESU53rj31sXmWVvmszijiY
	ljkMLJdzCLkNYbt6ac0x1OJuJW8LJ18jSj9XERh3osaTgivmbxyhDO/nZl2JprYokcem822htIS
	IkMg24hb+RhHX
X-Received: by 2002:a05:6402:460a:b0:6af:859a:f301 with SMTP id
 4fb4d7f45d1cf-6aff28fc814mr3603391a12.23.1791434979003; Wed, 07 Oct 2026
 21:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007142954.31761-1-scott@gitbutler.net> <20261007142954.31761-2-scott@gitbutler.net>
 <asa8ymCv4hoRJcZM@fruit.crustytoothpaste.net>
In-Reply-To: <asa8ymCv4hoRJcZM@fruit.crustytoothpaste.net>
From: Scott Chacon <schacon@gmail.com>
Date: Thu, 8 Oct 2026 06:49:27 +0200
X-Gm-Features: AclHuK_G13kBKQ90m6-ReDp28otwb3UOBfru7mSbWvKG9rYNlyUFgRjNWsGrv_g
Message-ID: <CAP2yMa+kgphMe-cpcZSvPSqwm-npUDVp=HaNRW+MPmPzZ_aOXw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] SubmittingPatches: allow responsible AI assistance
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Scott Chacon <scott@gitbutler.net>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 11:42=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-10-07 at 14:29:54, Scott Chacon wrote:
> I don't think I'm in favour of this policy.  All the major models have
> been trained on a large variety of code from a large variety of sources,
> including sources such as news reports or personal websites that do not
> allow copying, modification, or distribution.  Given that LLMs are known
> to reproduce portions of their training set or craft code or text which
> is very similar to items in the training set, how can anyone honestly
> assert the DCO without knowing all of the sources that were used to
> create it?

I agree that generated output can reproduce material we don't have
permission to distribute (though I think this is incredibly rare for
anything complex). What I question is whether that possibility means
knowing every source in the training set is necessary to make any DCO
certification.

Human contributors have also read code under many different licenses
(and news articles and blogs) . We don't ask them to account for
everything they've ever read before signing off on a patch. We do
expect them to have the right to submit the actual contribution and to
respect the licenses of material they incorporate. Again, Red Hat, the
Linux Foundation and the SFC all now state that LLM generated code is
acceptable and compatible with DCO requirements.

> I'm a distributor of Git and I don't want to be sued or arrested because
> I end up distributing code that I don't have the right to distribute.
> Large companies may have lawyers and lots of money to fight those
> claims, but I do not (nor does the Git project) and I don't want to
> spend my resources fighting allegations of copyright infringement or
> have my reputation besmirched for that reason.  Just because other
> projects think it's okay to do legally and ethically questionable things
> doesn't mean we should as well.

Again, a lot of my argumentation here was directly taken from the
SFC's recommendations [1], which Git is a member project of.

https://sfconservancy.org/llm-gen-ai/llm-backed-generative-ai-recommendatio=
ns.html

> I'll add that if Git were to include a portion of my MIT- or
> BSD-licensed code without including a copyright or permission notice
> because it was laundered through an LLM, I would absolutely file a
> copyright complaint, and rightfully so.
>
> I refer you to policies from other major open source projects that cover
> this exact provenance issue:
>
> * Gentoo: https://wiki.gentoo.org/wiki/Project:Council/AI_policy
> * NetBSD: https://www.netbsd.org/developers/commit-guidelines.html

I'm not saying that other projects haven't taken positions as
conservative as Git's current policy. I'm saying that much larger
projects with much larger legal surface area such as Linux have
adopted more progressive ones. Linus is fine with it on a project with
the same DCO, the same license, and honestly, a lot more legal
scrutiny.

> I also will point out the notes from the Contributor Summit where we
> discussed this issue in some depth and proposed an approach for further
> discussion.

It was unclear from the notes what a "vote" meant exactly. It looked
like Taylor was roughly tasked with providing a Linux-style position,
so I thought I would help out by providing a first version of that
position.

This was written to follow the current SFC guidelines. I would
encourage Junio to have them read it, but I tried my best to follow
it's guidelines and advice.

Scott
