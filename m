Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794993786;
	b=Dm7LuCUQxl+llFwv0k2u+yCuAaPkM67+TuMatm9uBk6CoE4AGqi6apX6dkjS/0fDgHRS
	 1dLyWAdLGAPWCCi2YURa/u9V7geADWogFuTJ7YogeLZf6sG4SsAMzMWhfvHqLRyB+V9xS
	 vxsvP5heiKAmDr3ayROh++Rs8Gzmm8ZwteIfYWwRAbag9b9ATH5Esjo1wFI9/p8PQ0w0k
	 Mm+El3b/BCMq54Arn1nIk2ppbc+HrPCwnPJKY0XO2tawpIH1cs5rzSZ0clJOzeHodCKF1
	 OOXLSXpf10aF9PoBiULJIduN5ENXxfqJUabaSFp7jB/lSk6FYyIGbSHbgkKMNQazFsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=W0pdwS74aEgHZDULOwjrGpk9Jqf6DS88SonlXeirVLA=;
	b=1cJUz/g0LsW7sLNIUIx1R3jZHO7f5ieyFGVW2k4YcxqMqS7pQwlEWHgqxBOaxj0t5kSq
	 ArdBsGZ1Js0XQZSarFYxtIxW+Fpb2MVq1tL4N4i5Z4iL43dR9yT+sCsJ0aQOZ0gbJ7Dur
	 imHUkkfScwrbX6ag/ExX2ax5VS6VATXnJ4V86XO7MsSlp8xE1FCQGiqMbafxIonImRAFl
	 fNvrxOnER3XdP1oH0nOyVeLtFFhP3GVDsfMJfZiuKPdFvxTWwudU1Ku3/seLInl5HFcLW
	 0ZhBSIBdQD5tK7jPcZjW++NFxHlX2yxiDCLVlbysBDlo3TT7wNjuGabxyz37ZEwRtNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AFtjKZPC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D4606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 09:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D19D4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AFtjKZPC
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5365f9a04c5so10186351cf.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 01:23:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794993785; cv=none;
        d=google.com; s=arc-20260327;
        b=mvdTGPAUAPW4zWf36QQM1uBeB5RQ2otejbZcl+bvMtovDIAILtPMLqRAUJQzT2d2ud
         o3LmF8dXTU9RRIxrkGaUxTMJrW1iqgQNFzcRCko01KhwxvyV6ztle0CDuf7Mioe7nKgl
         FFPCx3EuqsuUyyP+oZQXzY+w1Hkb6wvtsYHigekQJXkZjJWK0V3d65TWZHbrdC+8RuEp
         4A/+zO4YH+3uSh+1X0tPW4FZBrhRtoXxlSCF2/EBuTZSz8qQ3QYWXiejxoB3mX3Hm2iu
         x0Bg9FLGPqC9tC/0Pg79Z4Bv8xt2jJZuijeCg6oPTTHNObfcB2GyCUHujLLvYeNvpXWy
         FX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=W0pdwS74aEgHZDULOwjrGpk9Jqf6DS88SonlXeirVLA=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=mcrFLfJSp4kRJgYlMHyHqGCY+AlaI8BEuzKZJLPCIAy02ATiBC6e3aNv7N1lMP/9iB
         X0iUMXIX54d+ZsHZXymM+Oqz4XHF1gLgS642gvTixzsV89AzVpkAz8ywgHPdVA0EgKIR
         edGLlIhEG8djeac6Mj9ASTfgAzPCGCPR3qafQuOPGhFmHSAmDNmhEYxKIwnR76bi1lSA
         TF1lJRd/trr+R4H8DybdisGGwnopPkLYLw1wao74I0DWHHNW80TkesR1Cr0vgaygAtGC
         iNSZ+At6mavzzU2Twy9+QFQc4PnRYJ0EQRlSTHjkssIbCvu6jqqclNXqnMhe2M76C7vG
         TMgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794993785; x=1795598585; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W0pdwS74aEgHZDULOwjrGpk9Jqf6DS88SonlXeirVLA=;
        b=AFtjKZPCvuGmyDs2yooWAu/fD+rxzOJAkzWG1YdZQKcmyh+NDyodNtmaDQemOBlLlr
         h25DRGQ8EfIkmCLXDo9uMT1bYpoV2IghNP/IiOFW8tZeh43dW9LeCmKqdJetgVFP5n/M
         8jueBHECuMX0cavnNskTCZ9XjGoE0FFQQfc8iql6KgmdRZLqt9XI/Sr4ch8tRC/yq9Ez
         KjIvPnZ0+sMJoiaBMpkCysxvEEIeeIL79O6mnU4GBtdaeh1lWINDudEhsrmKrHSoEbLG
         dDqHZsWCz85o9Z3lfOA10+EWpBtLeJEBfV7IgTWvuZ5aLK9OmNPyQ43Era6pJxM0ROKY
         92lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794993785; x=1795598585;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0pdwS74aEgHZDULOwjrGpk9Jqf6DS88SonlXeirVLA=;
        b=JirEmoU//QQLBi8XhQZBFOOb7bHIqHNPnqUq2ZSZZMdEJC9aOX+V+v0sCjGxNSKg0X
         ucD3pqH7PTm532ztySuHreSK2Ibu4p0X2YnX6fmLVbqkgGHS7iQ0+BPttfKHg03fGZN5
         SV0OdipLH09CftuuBlyTkW3riZu5d9/UdtlkJz6IKIFPSiMgBlfwnm7ZHs7yx/QlCAKT
         qglMnMtPUgjxhQomfqwr0Ou3khHz+VSg/Qj4OyXhyIXzEW0kuR34nopcVeo1hvoeRZos
         AybR9aKwOnMm6tadPzyharork3w8sG3oS6+6Q5S3y4lmVYHuDLTDDq3KFfLae4K4d31d
         PXKg==
X-Gm-Message-State: APuU4Z8si5GklL1lBcJZUGI9M2jL0Dkq74HKu3gLVxsD7sFbeCjhj2p8
	E26zU/b/oksLnHO9YtfaoPtSvMeZ931xq/xrr7dQyXvpsUEd6gz8f8TJ59ml3MmBdiWtaSSRK9O
	QwFzvrd+rj4ljFLeVRpseSg64Ui+WlwBcbwv0wGQ=
X-Gm-Gg: AZFdTZeBS3y08MEAP7f1LBdXL2MmbY8wuklM4+PL6WOWbJpnHGKskFkw6g29gn0lf9h
	YQBLKa53f8e9DoYVza5xLnO3G3OeX06XFR5tF6ZwRKKa6jUcRrvErYx5c/H3sSexntmEQvl5yF8
	r8BVOdv0IyGQJa1GOJJlehSrq5Of5sSn1QpBWV2G6fs8KCNRZqsBDm149fSEnBrA2GpGdBOfptC
	DFghin+fWaB4LZ64Go6rQGN02ijakMSg7OAFvT8n9TRmkDpKUYh8d5RhaU9jjV0l0ZEw/3vZmBO
	xlUtro1AqWZ4OO5+qe5GFdqtgjC0W/BJEX7A7cU+n8qZNDewis5xuAOPmMx7FxHZTTP1xwyBeQn
	QbbVGtRohBkTKxHJEkLpnuOuVmmY9t4Ta9pu+l3diwktXW0l0yrd4SFwIimMXYUOW8M6KlJD4yI
	gmclQwXiapUuXOSEgBuXEXPfW+o8AOH6KSXo9G80RsKg==
X-Received: by 2002:a05:6214:27e6:b0:921:4b6:78b6 with SMTP id
 6a1803df08f44-92114e3b70emr29373706d6.29.1794993784495; Wed, 18 Nov 2026
 01:23:04 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Obayagbona Uwagbae Alexander <uwaobayagbona@gmail.com>
Date: Wed, 18 Nov 2026 10:22:28 +0100
X-Gm-Features: Aa3M54o7VxUEludUvXuWHN5Bi5lf-lTTUA-R9BofsCwmHuqJszyY-8joetuu46s
Message-ID: <CAEocypwuxFTM98WA_puQT64cOGbAzWC7B9+=wuTZAM+7ZNu6ew@mail.gmail.com>
Subject: [Newcomer] Hello from a December 2026 Outreachy applicant
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Good day everyone,

My name is Uwagbae Alexander Obayagbona, and I'm a software developer
based in Lagos, Nigeria.
I applied to Outreachy for the December 2026 cohort and chose Git for
the contribution phase.
Unfortunately, I didn't have enough time to get a contribution in
before the deadline.

Even so, I'd really like to stick around.
In the interest of becoming a long-term contributor, I've decided to
keep contributing outside the Outreachy period, not just around a
program deadline.
I'll start small with something from #leftoverbits or the good first
issue list, and I'll check here first before picking anything up.

If there's an area where a newcomer would be useful, or anything you'd
recommend I read before sending a first patch, I'd be glad to hear it.

Thanks for having me. I look forward to learning from you all.

Warm regards,
Uwagbae Alexander Obayagbona
