Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6834828469A
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781406993; cv=pass; b=bFXDknchezD/eNpW0uFaeO54qmBXsgcSxQZkUV9S/bdjLCcb4MgXlj/urLw4Lxax1EvdHe2ScDbAfMefBK6ieALJq5qBk/RRdC6EKvzzzbnjiBcWxcfynidoEUfXn/I5WE/7xB91dp8BoMekvFdg9rPjFgyMjHOrbTXHH1CdKYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781406993; c=relaxed/simple;
	bh=d2bfoLgo0rxkClHV4OmuQUctNAngS+XE7XeIOQNj3Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnVpTOgoILvu/Z1EOY9U2tz3w41xfFUkY/SvAxVILQPbjB9du/IdxXfzviPAE9qnPifw4u3u+a4cWy3DG+DoYmPkrWVz/Xt5bvC9fLTsj/eYHXIWvfMUtZ0g0BbnIY4Wz/Sdwo2otvGiUofgX29lqEBIH5bZ3vxN3w4ATAqVc+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsl+z9jB; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsl+z9jB"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-48762009daeso50618b6e.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 20:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781406989; cv=none;
        d=google.com; s=arc-20240605;
        b=V6KQn/B2BiuuWV8hKkcNwCS5a9KmnRH86RcgOCSW7CCah60MrJEFymkok4sGBaYx1M
         texwB4+NxBvKYiReSf5B37w2cLJROt0N+mnrEQYYZ18ELNNYDGLhPrnEAvXUwham20j1
         nOVuB3RgsWHYA6eebDD5WFTMbEbz+JQ1uR0vAcqw734VPM0Xmf4UGUUGWxkkb48i0yZA
         91xlxyfUPWhKyKaqTZz+Jl0XTyqmJ4LhlHe/9O1gd/wadWy/vDnpnRLDvD56wpCoAUF2
         SpMCbehx3e5JTvONzZo6JzaRul+6E1jxI07YvJaMOXDb51Yb1KKQOQ8K6p3F6wJ5dmOq
         Vlpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hc6T567tU9VkKe5KZBV6YVHiTTZXH4R59IGoNhYlJBk=;
        fh=0YPN3te+jO/zBso2I1t5tHiT1wPcU13jrM8YPmwhsrg=;
        b=f+lg/Qhpecl+XL3vyX4u/ChiNirtM59oGR6NCpguyruS4LRxsKhWSyx615I/4Zg2LJ
         df/UG/kd7mRde25c84eqYgktrjWF5uXKLoMOugebIYlLnluMS8m3qo174V21z9mRau8X
         HibkkEkYUNm4YxXE7Ln6HykWS9NQb8NdDjp9nCTLKRryPVAclvF8h0PSQnEQt/CBgHpV
         VfXoT7KWUcb5YkwgUJ83AotvBgnXIch7W5Qgz3P47MbuN9ZZdwDb495M8cHw4e91SZcx
         Zgsrg+UnFsmTYwZMgz5z9ic9JHtRqd3sj+wz/1gJJazIPxwj9atqAS2G4jurtDLrWaxl
         FD4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781406989; x=1782011789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hc6T567tU9VkKe5KZBV6YVHiTTZXH4R59IGoNhYlJBk=;
        b=gsl+z9jBhbkjQMYjWlwaoOpbDg1XCxrL/uei8MMphrdFku5ZD7JXxY8DGaKJRuvGzk
         h1bWswzw4HWNeGfMDmpNopaaC8EYyc9Q5PJN+lroXfRWOAnEv03DK3AQO6Hw0l0glcW1
         rr9PoKngsJl2kOUocZIPMeMWE+CFFCv4jDl6JRjUH31bMVS/GuPS2tupxfg6IBzMieaJ
         obZ27Dr5r2DLaUTrGzEUUtIhDlKHBqrtwpVUM+7uF15PIVH0PlBCdMkHAGM4m+CsqYG9
         JAj75r8y2sACYaKn1s4+CYRXW4Kbm3y5YjEr7oVGSxS71ZcCYLuK785F+JtLBjlMpPj7
         SZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781406989; x=1782011789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hc6T567tU9VkKe5KZBV6YVHiTTZXH4R59IGoNhYlJBk=;
        b=URpgrbok179c5WqYRL9nhET9X6nK1qmNV+FG4dhgLU0nlm8rncXQeqMHayCcf7uAfv
         blm0BYMDD5el3gHjBhwUAvZoXmYVeJVrlPsX5fTfgF/2qcGsVtqwoKmfrNNWSi2JyRnE
         xzSe51rYkPtxUN8KXvx2GJkUz8gTJ8WFci5TtWhVJtfLpFMtBWyPJpjUY4oN6AFtiLnZ
         7vKgBE+2l3EwZiHqj5yKXcR1Sck9DRSjypydezTDrMKBQRuIr5rFBC8QO+XVh5ejaO44
         R4P/ooN+//Vb5d8Rv4Si4la0QWEULwN3q0A0GKhCfKsDP+NCwhKzFQzaIQvAY125iG6f
         gMkw==
X-Forwarded-Encrypted: i=1; AFNElJ9ezH4oz+8LAXV2Z40017aBZTfqXkQ7UJScQLtxhp4GkqDLK1efdDxfBIGXV9e6MH18KVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSUBOORwv/Wq/Q4RG7LXLtXf1SGouYtmH1N0kYGjMJUOnIYaPi
	y98AuiP9z8bwCkmu6hilR2f1ktwbictPJQnOaNa5dMfgaolz8hrhw0hGkcRa7knSACnYiZ5GqnY
	+F2pubw0B9NW53wUyce3JoSBfOtcQHfQ=
X-Gm-Gg: Acq92OH5PRu2x5FnO0jbAjFHnw5nu9u0ZqfYC5C5X0/MqIFd9zN8TuR+cV0RZTaBPLE
	2ozyPFSELoSj/dNl1nDpedrGuxF49D6/MqzBSq2XxryxeiE6lPTv7aoVawiU116bhAwKv6Yh0ch
	FSfSNjH/jNlcvC5pqLVdaV6LSU7FCEX7wnIH27tweYpqIpcPiHh7ZA/wZ7om6WjWsQPbQ3dQBWq
	q7t30Z/6LrUh3vbJH0kCV//oRxPyeWszK1BzPfuoP4LA296+ef/CqbU7gbjqXQ3D1D04Lvvq4Qp
	KS1Fpei6vsdao8rPyzigozLfRAJCN9U3Tgmd7K+y9oqDGrzPy5pbl6GNLrbwiDiprNoTU68JqFL
	2hKL0q7xFvYOmBlcuBhZPhcfnKg==
X-Received: by 2002:a05:6808:1b88:b0:47b:c2a2:1c79 with SMTP id
 5614622812f47-4872f38e363mr6336224b6e.1.1781406989276; Sat, 13 Jun 2026
 20:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
 <a87bbaa84fd5dcb2a585f82c4a5dfa1572b54588.1776731171.git.gitgitgadget@gmail.com>
 <xmqqldcy4f07.fsf@gitster.g>
In-Reply-To: <xmqqldcy4f07.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 13 Jun 2026 20:16:17 -0700
X-Gm-Features: AVVi8CdURS-GqxAFV0Ou-angsO42YZFjBk4oW3t2P00qhmw-rOMTfJa94pVR36E
Message-ID: <CABPp-BFW8vMcPascUsujYSjSz79zUyuryNoyH+Ej2W+f6FNGyw@mail.gmail.com>
Subject: Re: [PATCH 5/5] cache-tree: fix verify_cache() to catch non-adjacent
 D/F conflicts
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 5:33=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
[...]
> The narrow and tall comment block is a sign that this loop is
> getting too deeply nested.  I wonder if it makes it easier to follow
> if we extract this new logic into a small helper function on its
> own?

Good point; I'll break it out into a small helper in v2.

> What the code checks and how it does so both make sense to me, though.

As always, thanks for the careful review.
