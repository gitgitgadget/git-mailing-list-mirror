Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401A53570AD
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446869; cv=pass; b=draV6QklIMamvRQKxm8Af50CFG3OU6jxpsjJ23NBQmdWM5CLJoYA8mmYwkRHnyp92iJj59ud+i7gcMkoqZzNh/yc0CqjQyHuT6VmHVbxdI0yH5JRIPp2zzxjdLqX5OnYekucNLnvWTbt6Zm5vzgKKju3qfGqsKFSVKnw6Oy9SN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446869; c=relaxed/simple;
	bh=8SJH4nb+O5wuPt/16M9JySuQ4JIKiAEUCn73/uDDg/c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OHmGt9qTqzZcXlHvNVQQ7RSDe9DUFkQI9CQc3p/Bd3+1eWnP6Y4AS3sapQLyzhuFrN3X48jR4LTuQNz37LW7WBL4vDSIp+y97SOEQNf63CowaV0N7OUdBKiUfC8U+OFIeGJaDA3G1J9ajnFAyXW0YSLP3Nj77cIntAP5s2c9GOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4gURqLC; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4gURqLC"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-44ae14b4fd6so1853272fac.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 10:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783446867; cv=none;
        d=google.com; s=arc-20260327;
        b=iya+smlMQd2FZ9mUWkUL1PYEvTth1ZaWvfSt2Adn4srFmMNo4kx7FN3LXBk82gwqyB
         4Bobgt5aT6YcwAHFsiyBNqU5rDnB8PfY0TnCwMa/Xn+8skStwt1+imJe9tvdjimiEj9N
         FaX5gOAtZUFDF/g4apOouHedeQ7vC1Pg8yq5KVN2wPZIVHBY0WOyE5PfGg3yB5Tcv92x
         br/ihzV2MhL2bi/0Xc/fnfn/hnoYzIgIdjBUlkvg3p7E21Q66WshLtrEDEXR5w5LVG/V
         D5c866RVf5rtK0CuvgQpM78lwmcr0K42IvRoDaiCELl9p+7dv75YVOA+Po8kGZlAA4re
         LbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dyQVYHgSnZnnM4LybV2zMqIAk8TdSSEIGCXnLMnx23E=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=VYtE+ttVir+9SDx/ojAVkJEToUYVNZtoXsQPNX5Yzc+M5u8gW0EmUPrWqap5Zo3SHF
         gDWNjnk9yMMH5z27xJijYoprNvkWySofRd/bErMZcO7OSn2LGXULKKHNfWmcAeiIu/27
         aKVlvLo+6UULpxup5xEmssLxObj5pA+R9fB9ls+dqlqX4285DlZrwW8L78zWZEnA/fi+
         MqEV6wi4CyiLEo6u2drq8R1ZmuzaVMGB0PcDW5kvnvmNqZU4QHMtzIwKN37Kc9umyhDi
         wGiE06qohRr5dL20Bf4ju2ahy3WnCx8NheSXhjJVbflSxI6ihweQPbi+YvDAUesHHvP0
         Ewbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783446867; x=1784051667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dyQVYHgSnZnnM4LybV2zMqIAk8TdSSEIGCXnLMnx23E=;
        b=l4gURqLCJBQ5JKdD3rzBnIGi/O9IZdhDfJui2ba9RwZ1Nne2FzNUh9ZCg8Gt/EbY1p
         fbZsVXamzZ9w+tIxCRcAI/DC5uUJgIL+9gQkwDSPOYRoMknUPx3oymGyUmTE6PuytuaO
         W/s4t76yxTU/wElmxYqfP/558ICBwTY2gZp7fmEZMnhkiSURLOA5nRawcYxErrjK+NCz
         loDdPucGZWqN/6ycgYjs8EN+8RpE73JY78urCJaHdT4mQV6cxVTjw4j8y+jCsDz5hbUG
         pVKevwXSq/16UyhXWLoZpKr+mKurVm0GwkQhoCRPawCld1YYqh161JiG5a4oRCEqV03p
         u1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783446867; x=1784051667;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyQVYHgSnZnnM4LybV2zMqIAk8TdSSEIGCXnLMnx23E=;
        b=XjtNKc/znH6J/LLzl991sL7Qm53q8Y2E3ZMuH2vBtUl6FzNi7spLq7s6gk9Xm7PVK/
         6IXMZ8Ec3XXkj5Y3na/7a7Y/P2Li87j8292k6psbNmZegtsgP93H0t6AdBWJauKB6Iau
         S3f3F/0y8bYmoXiTP30hChy/iKs8Y/j8MQkdflgrjPun8/yDsGY9p4pwOyKB8Cp7JqZg
         lyeEBEnMFu8fRvlPnnsN7HJrkTzOaHT2TYtID6kEdr41CRXdX7po2RI1nvpzXYgZLauV
         LOcgW0rLbxn7B6b1z1Cc6b1ALVMevybDL2686BtIJtXJWmPFbZmAnEsbqjITz+lYxaVe
         u18g==
X-Gm-Message-State: AOJu0Yxj8zrvqKXZVwG7ObMWugRvOw1xHJ7bWk706qXKdqJLZwM/rxnm
	5CKcJLlfGWKs0NtWAIUJiEDE0mcZnzcSsL4/VAGSmRNJ2LDCxR1Y9oteOYD4gvTbR//y3Ier6eN
	BwuwSzsR4xY827EDl+3TuQdQElGEwsZbly1pJ
X-Gm-Gg: AfdE7cl8LG1n42Ahqes3auSBrYJkNM2hkfziH/Ss2Utimhz/r+na6bKKOLKElTBi4LD
	2eBgbyPNnT6Mx/igPf+1DoOTZDCH8//MoEQik/cb6KfEwxzu/u9y5x8SHEwHSLzQayn10Z7tIF+
	A/CgvBd409e9PYaCI/GrNIdof/iGG65B3HOdGjJdbnSKQxEU4gerJB6V5xLMtlKtPjz5Bnf/U1m
	xanij7HoZ30nq+IdZE/LKUekdnieOQI34wN7e/I0+WgLGnyoWa8ywI6yl/Q5ouHceLFL13Qp/tz
	M24oTjNIwfOX4f9PnWK4M7K2x4uhI6Of1eezzsAY3eSECRDK1C4y+Yqr/pGjadT1aYwnyQiEz8W
	pbjOyH0riLF7L/w4=
X-Received: by 2002:a05:6870:9a1d:b0:44c:fb6c:4fe0 with SMTP id
 586e51a60fabf-451065bcce2mr4023817fac.21.1783446867190; Tue, 07 Jul 2026
 10:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Tue, 7 Jul 2026 10:54:15 -0700
X-Gm-Features: AVVi8CeSf311VtrM5MaZyD7brT9NvbnCMNeKH2i6DYh_M9YTQtqly2tVbvNvzWU
Message-ID: <CAC2QwmJwYqaJioPJ9a3_CY0vMp=wN1E90eq2VeExFkezHh97iA@mail.gmail.com>
Subject: Re: [PATCH] Rust: fix description in Release Notes to 2.55
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/Documentation/RelNotes/2.55.0.adoc b/Documentation/RelNotes/2.55.0.adoc
> index f5643534dc..e7e77a8112 100644
> --- a/Documentation/RelNotes/2.55.0.adoc
> +++ b/Documentation/RelNotes/2.55.0.adoc
> @@ -85,8 +85,8 @@ Performance, Internal Implementation, Development Support etc.
> * Promisor remote handling has been refactored and fixed in
>    preparation for auto-configuration of advertised remotes.
>
> - * Rust support is enabled by default (but still allows opting out) in
> -   some future version of Git.
> + * Rust support is enabled by default (but still allows opting out);
> +   in Git version 3.0, Rust will become mandatory.
>

LGTM.
