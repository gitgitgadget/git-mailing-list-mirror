Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795457151;
	b=damAbL4NjkQEK1YQ1rmTWYlgvqymavOegi2OTGmEWOAyS0Ipclomh0NqCCplnRDXP9ip
	 xta6drYHOdVZeX61qRpRMqWC4vX30tQMN4/4GabKZI//z32AAG2LDoyi3WUCK8x4xKJrk
	 sAO+nnxHTN2+qR50+5iZaRksIToFyPhSM/U9KCWr+GKLEGC1m443EqxeZwYVIXMKhlbjr
	 v0uaqlnhJPGPjd5JeanvHVpWlpT5AXD48Zc6gnvMGJLQyHB06/aoN1QLs70KuqpUIevtE
	 pOoaDryQHR5H7XqWopETFbpOChz1MgUXqDLaRUvmJz3YFvP4y7qjEjdZ2+EyVEg7Vqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qIPqkYHNYbI12qyjnWZlH54GfgPeotEQ0EBvowR340A=;
	b=s9c/z2uqni2FkH1U2NdXsmuCjsZiwogNBRiH8MMptZzfaU3zbqjGOnthFficRYVTBoS6
	 uqcmeJOv3ZrfNBa5hvaimnX0lu6mywPFl3qvUkEzQA6Bt9KPNCBaHCL9C1x2o9WpA1TyP
	 oShc5Ie9CXdGcQWlV6e6uaEWkV0RPjC+6iyIqNW9cuW0ozDrDN1ImApeboE2EMxqu0hsP
	 TfsMi2sJoot5g6BlIeqthrbVCeMAawPi16KH3jafTZdGxjikp/bpY6nZyLlfCEgbLS8KM
	 lwxuQeskx1L1z+yQi1ezf98tkps8EiQO/j8FpycAD1ST/3ROTdcOjR2fXVrre6Fqnuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=odEcAdIR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CBE606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 18:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7CBE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=odEcAdIR
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b40470fdd8so1718173a91.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 10:05:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795457150; cv=none;
        d=google.com; s=arc-20260327;
        b=Xi+sK4pSUgVjMyQt9N9Ese6q49n8JUaN0CJlqYFjYfvba8Zu2B/9XqKGGxyYaRSTOD
         UHi5taX6niacygzDRFcnbsqWsknr54GUzep1P0vS42PFfIvSDPVLVu14ImFhkppK89FA
         xUIzAjuyJpEx042XS1o2sYlP2E3bgigodesFOeVfpuQaBcu0XgHEdGBdSspJOQt5UKap
         hkkVPJbVvktNsIr6NiDS1e/LV7FzVNm65O1WVnyBxmtClna5Hhx7jyQpGm6cRrD+eTpL
         ZO9jbjdthj3ng9+OSw5e5IJsO4Dd3Sp6bSbv1ssE7h4MxLCZsP4dT7J92i7V9dZF8GAw
         0dxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qIPqkYHNYbI12qyjnWZlH54GfgPeotEQ0EBvowR340A=;
        fh=LIqhad+NoHa7UkcdeeYAFV6hhpuvO8N8/6+L/FmmQn0=;
        b=oHT130RhlRygIynqMOxbXuKT7Y45zjKfy7KP20jL++uyxfMWgT+K/WqtN7BdbxRDd6
         V/DD6hjgkMRU94B7UsW0vcSK/RN597lBwSKVHUE2WxJIYlIvni+PjMipklePU8qtULyb
         os0DjDOZnk3m7i9GtM90E8Wg6ALBlWBTlKz/H95c0JaehzIWFZ8uGH3u7zV/ivIaM4Fl
         xueIsNZ9nNvZyk3KjI1dgmNZujlTLu0MQ6FZf55Hy/lWuUXdX42jrhvgx8utETv+9A2P
         ICS2DJDC99EvD/b34TZ1aHRXuLF8eR+5ZN6r6Wyv6i1788Y8w3YXIArHaADAmSvo06ka
         IJqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795457150; x=1796061950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qIPqkYHNYbI12qyjnWZlH54GfgPeotEQ0EBvowR340A=;
        b=odEcAdIRpaaKeUuH08a5TAL/7viMa1EkubwoUZoMDaiRgiWNNh59e6eW365fm/yfb4
         4shu4Fw3UAux4qbT7fkVXARBzoegm+IZLt0MlGvQKb9jmOnS5cOqwtpfq3y2JIJ5/xAj
         LzNHWg2I/Fl9+YY2Yq31F0KAYOzX4cWjPPRWkxPUousRmGgrlnS0CDKeap16eWFm329J
         4lzK17t2eZ0JDH+zxtjRlEjleC/zJBSrzSTfiIGOPkSfTE26mEnhTiUMhAnrTyZfMTJa
         +7H02RrHEdWit8fpvwwC07kiMpJfzhyPc7Ey0EYnlUilsIQNljohaJSHtsQYOoIzvaYS
         CZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457150; x=1796061950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qIPqkYHNYbI12qyjnWZlH54GfgPeotEQ0EBvowR340A=;
        b=fMn16U7yFhGoepZ0grl5DK7Z1y0icDaVBp885WLYQOd0xmPHXOimWCgeoppk4BNwVL
         g1L7zFhCeCxolPCT5DjBAQcfFys2yaaJidR2kwxmsEkCSKmGzEGLZyoRi0yY2ykD9kqp
         X9+G2za/pbfRpgsiuZo+vqmw+lO3Pkykkepn/aEB4co5JGC11v5Xc/VkmtK1udaAkSOF
         fAZl8OW6+O9zv28ACSxeLWZ+SvWYWo2DeZggDmaYU5VygzRYRRcuXCoZMpOSc4hMaz+d
         TUSJAyiVEecBf+PJLov084xN3//7zfsXsyRR9a+Cy0s8EKvAGqFarX6qLXrpDv90xj8A
         XxZg==
X-Forwarded-Encrypted: i=1; AL+hErEFZgP2O/vETbabxsr5tmJGHg6B8Q734KC9Dl8hZXFPxB512Mos2SoEiQjoJKB1+rRAVKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z85hJ56RlfST1bAZxF9xVUe79rIovWCfZQZg8WbHL2GAsu1pe+p
	4q/cqtjwnG1rY3BzQYjccsabS2LkzM2c8wtXvnJTHeM874jCPJJTeZAQ2jjTDAeXmcYqr4mLsIM
	hGpWJANnkqDi9OsrG4I13vhrVKYt6fcQ=
X-Gm-Gg: AZFdTZcuNNXZ4aIeXTfaOu9rCQavR0uetibN7GZwfpIn+mDXoLMT0BXtImOWVyzYiRc
	DGT9djuhtEqtMLbYzjsx1Ty0SOWcUAuDNetGdS2HntxhTRN+7CK3gM9pvwtGrmtGqnpo88y0Bgs
	2Fwyy811Wy/4xtArtYVo4BknhlBo2+lQDTfei2jQhn6baAmPkCc39ALML8PR/HLwO1yfF+gMgOU
	LmK/jD5lCQerAEihIOSUrv0ZDSCd+5f2SNH6q6s/Z7w7PdeO6j/+K9Jji4kAnXI/dtC/4YTP9dm
	iAeQ6xCC9p0ks3k3k61lCj2wUBkVVIbd2taVdI6jOd+VUm2h/eKpJC1ua/AKcICqH+46CTOSL3x
	pbW2LoR+Wd7wlEZrMIEtvnDbU1vsfTUedtUi1vjosFjx+ciptGr6V8Muwj0kuIJ9uXgoQV1YadO
	ABDLDi35Yg1VcpAwvo8NjDNhtLxs/tZuOUx7TxgLJU25bjNDpemyfDeGnJPDq9ywGYqHL9CtfDk
	FblAXeB1Df12PWDg2mz80t0ydH3CjXSpu9E
X-Received: by 2002:a17:90b:35c3:b0:39d:f08e:e6e7 with SMTP id
 98e67ed59e1d1-3b41c7d5bc0mr9859978a91.9.1795457150040; Mon, 23 Nov 2026
 10:05:50 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2307.git.1794259990263.gitgitgadget@gmail.com> <09bcad81-4bbf-4849-a3a4-a409f5ee5434@jvns.ca>
In-Reply-To: <09bcad81-4bbf-4849-a3a4-a409f5ee5434@jvns.ca>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 23 Nov 2026 13:05:38 -0500
X-Gm-Features: Aa3M54oDQMgyc8gYOQQyJyP4c0hdVWAg_5kGkSrcKxp2I1RYyA_FT6YCH2fhQnc
Message-ID: <CALnO6CCiC3JzXx6=dMNXz4_=p7kGMFY7sAg50xJjcm65AJbcSA@mail.gmail.com>
Subject: Re: [PATCH] doc: add tutorial on branches for beginners
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 7:43=E2=80=AFAM Julia Evans <julia@jvns.ca> wrote:
>
> 1. It was a bit tougher to get test readers for this one even though so
> many people said they were interested in learning about branches and
> collaboration, and I'm not sure why. Almost everyone who completed it
> said that it took less than an hour. Maybe a table of contents would
> help folks understand the overall structure to see what they're getting
> into?

It certainly might! I also wondered how many of your test readers were
genuinely new to the ideas here, which can make it harder to get
readers.

> 2. This document is doing a pretty tricky dance where we're introducing
> some example Git workflows for collaboration without explaining remotes
> or upstreams, because the tutorial is already quite long, but
> ultimately the reason many people use Git is to collaborate and it feels
> silly to not talk about collaboration at all. I believe we gave at least
> a basic explanation of everything that is actually used in the example
> Git workflows but this will definitely leave some people with questions
> about how remotes work. We don't have a great place to point people to
> learn more about remotes. In the future it might make sense to write
> another guide on remotes and upstreams (maybe `git help remotes`?).

Yep, agreed. I've mulled on this a bit and will keep doing so---I have
some paternity leave coming up, so perhaps I'll find some time to
write in earnest. Mind doing some early feedback when I get there?

> 3. One of the test readers commented that they were confused by `git
> switch` because they're familiar with `git checkout`.
> So it might be better to also
> mention `git checkout`.

I waffle on this. It's probably easy to mention "switch is the modern
form, but you may see older guides teaching checkout" or something?
Any more than a sentence feels like another distraction, though, and
I'm also perfectly content to *not* mention checkout at all (and leave
that to folks to discover if they choose to).

> 4. Only using `git log --graph` for the branch diagrams is tough and a
> lot of people hard a hard time understanding the ASCII art diagrams.

Yeah, this is fair. "git show-branch" is probably harder to learn,
though presents similar information when it comes to "what's going on
with branches." I only mention it as a way to have *more* branch
diagrams :P

Anyway, I think my overall feeling is we want folks to learn how to
read log output (graph or not)---it's an important skill to working
with Git IMO. (What if there's no graphical environment available?) I
like how your approach sort of sneaks in the vegetables, too, and
future guides can build on that so folks get more exposure to and
build more confidence with the output.

--=20
D. Ben Knoble
