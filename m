Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795023417;
	b=ik2U3N7Dy7mqCm9pIF/GfTWuRLxX7sQdRAtPNcOQPyARyvuVuTEHsTJMe7+24W/kfsCZ
	 BLGyoT2gacJPCxUi/Kr9vRomHhvhlOwW5EBDeOZ9wWQdT3QNQ1OjW/LVh+BW8+Lj1ItN5
	 wk/GckF2QYSECsXndFm/qmQK7doF15dXxgo9mvIf131vjnJINpBORMM/zzOUBSNdgSSaZ
	 FmPxj2+KSjfOdlYmeJgyWhcdlgFGqNpwiBTPzAQf40UkqnMHlVEsiJAb76mHMW8GSs78m
	 iRVBXU9wtEqYOBfPSAuwyVTHunEth9OAUqw+DW0aJXSjBLhVaxnXKJhT0yThU9yuwzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=RiHGx907fC8LNfKwcbO/qKBA7IR6ya3D35m0P9SDypk=;
	b=TTxl+f0xNjjqV9h3mbi2zKuRoOrJLQ7JpJpEdYiIMirwAFyHltUb8cEuBySVmnQo7Ok+
	 3N5RZgdZhliDPyTL3/V9KWdtqzGD50+iyUlNNHGlA7EQSjz2Fr818WVHdYHUqBPu7x4UH
	 f6B6JpOPvxpu6WxMeL9rbhDnmXdhNfKLYDNtetwz5CeuSmyPSX0rKxivHfGahuiFUqd9H
	 O7yR9PlKsWZ4eNDvvLUbPdOfvp/so9abC111p/+dFtADV124G+cBXzp42dkxjJnG3g5l+
	 He90W5E/Hkqs4rPFS8JwL8Ja59ojW2hvH6XeVPGm3I9HdGe6FTBpWLNqaAlIWARrRRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ASKgq7jt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA7606CA40
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 17:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDAA7606CA40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ASKgq7jt
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a2af4c8d00so2561913c88.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 09:36:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795023416; cv=none;
        d=google.com; s=arc-20260327;
        b=fouaRT5be/0dcunSDYdYwnVz2XU3MJZ4hktWlYwtPeG3etHJgoJjyUl0FyXBVUSzcc
         L3OIJNTJp7w0gaScYGiNBAqfa61yq2hvYfcdOIDbNTsTdIp/0g3vsmls0mEHK05jLcq+
         oT2QqDBcbpPlJW6txBV7q8b/Y1PmdYm3/M8m6jUc/0eCXH9irMhqPJh+QmUVqK+Fnj5k
         tsHwtzLa60nzQl0+aPtalxgfzoqLiS64MnkjBnNVWXDzf84FpgHxdWo7g+9mU80VRwF9
         SOD0Z0S051oeB1BPM4rMNZPzMCUaIJVYE6HJIFCqAucdOGQw4xAc1p7Iuvx8Mtc5vZWD
         kUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RiHGx907fC8LNfKwcbO/qKBA7IR6ya3D35m0P9SDypk=;
        fh=XhrkE/43V8t+PRT51BaZzfmatDRqywpwBCpxYwtL3QU=;
        b=MbaIJ8hg57x6F477ogTGbA5kKMyGn8omc/JnkloD+Rbzn7PWqqrBt2pPMOWDrMIKd3
         UuynJAaXzve3xPFAFcJzcnqoMbnhU5R/HDkZdk3hMLThJSoNr7vDOH8trYlkc0c/o78X
         EXPoR/61ueYyGi420HJPD8sFv++/8hvpF+/XZ/y7QQNDSpzyoiKQSTyN/htFbSPpQBSm
         +w+lQ2qK+2W0IWc44eWT2J9/W5+s1z9U8e0gJ8a7tcIdlYeLBRT/JyTUjqxQPOeOfcXu
         gwMcGeVjE/iveG4rqw2ujeJfn71qkykuJS2ULp6wUpUuDLTA7ZV1b/UM5u3S8NuMFBH9
         a7vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795023416; x=1795628216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RiHGx907fC8LNfKwcbO/qKBA7IR6ya3D35m0P9SDypk=;
        b=ASKgq7jtfvBpfg5YvSE1WNZRMv4ggRHqBonhitwt8d/fFqSwZjfwJUsIwQ/rtQJ70l
         AkJXv1J7Ccp40+B7+tVLoPROtLVyQ6l16hVAb17lbLLFyx0KkAiXl4664Kv+RfAGYuZg
         E4tMl5h1GXZiae3vcTpddfR9IwmaxJjE8gzU/wDQsWJKrgslD3KINrP/0pwI3ee3CHAU
         YDqwVtMuIdZ/w3TAq6Vx9Hpgr5OrFX80dpUF/TsTbdM7+oOSmVp6uPeIP/YwMGnIiMmc
         xUyHaMG/fGVBJpebsI5RkHGn7Mg9t5e/fBKn6rUXXJEqGcY/MfPmZfWiyRHBgNFQ0nao
         5tYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795023416; x=1795628216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RiHGx907fC8LNfKwcbO/qKBA7IR6ya3D35m0P9SDypk=;
        b=uRrI42LjUoPzCPyCjKQTVEu3zti3n+amCmtnu7PDPZVtBzah7ZWy8lFtvSGJbBc+hN
         63j/8BK7JXJa4Q6ITGPJ0pe/uWPrMuxJ8JTJzu7zh1rvHSpIzJoZ7nVoPwC69rckzPrW
         0FcYAlSYb9VV1ZnmfJYcYAQnXuHvJ2RoF8/Oe72cybVRU02/Fzs5/qIOcHlYLWDqEqIQ
         xOFbQ3EpWMS3kPAtd46KL9KHEmxocQgmm91tdJyZStbQFu5V6VrPGP97SInqtc3GBv6j
         81dh0Ef1nqBORRB3es3JAj/IESooWu2sBUA86nQuStS/PfxE7aopRNO3c6i1DnMZ33x+
         8ZdA==
X-Gm-Message-State: APuU4Z9ASbOxTBJPXr0DgTW6sHqdispkP4152hKLzlsuTeVJqP9WqNX+
	quICAx7lw7eCKZLOSShl6915cqnhwgRSqiNezmnnzKdRB5sYmq9hCVSnB0bJNraB6gL1/hxUeYv
	rDfoItPLgBnBQL76YY8XJ0vp5PIKbOSORNOiReA8=
X-Gm-Gg: AYBFou0A5Cqhl/flIfHDBjyqv6GDqT7cf8X8U53yZmbbwPP2Iv8JIFhpEIOlZOkBXdE
	ElMja/Y4klqx2tGdu7WPYwaF5qeBWzCVZbUCJOfOGJX81EnhhpgBfoXSXwof9vIhxACg51TnUTj
	+omHoZZUPh2dwzxOfHk0euorx3TGlXdZyTlG9O3149RSyl8rQZxpgSYqZVnYKd+RhifctD5o/4H
	A/+SrU0hiJmKYbht5u1/o5aThcmQsbKOSpNhQCGchP0VeCaG0ZCe7Gr+mFvawy0PPvqixgZMyu4
	6p9lL4iavUnpBSaBDxT/Ag348H/+iSDkRwTXqBCOQME3r/q17Dxm8BYJkPmflE/fi/LfUjwzHEg
	FARNwiv75xi+lgZly+094h21auOeWGtTwrSJKyNokWMbXaCm1AnH9WQOUuu388P+HnIHI/soIxQ
	0pjCvguF+Rgy7N+L8w7N361Rk1Ll0d+i74/Df82XetEERkS1aPU7fHoXczavmmN9WO+0v/QQccO
	0nJjFtxcjaIhowAyKV4JWXN
X-Received: by 2002:a05:7023:a8b:b0:1af:d88f:fc51 with SMTP id
 a92af1059eb24-1b543d264e1mr3357531c88.30.1795023415738; Wed, 18 Nov 2026
 09:36:55 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-b4-repo-structure-concern-v5-0-2d8f37b70b75@fastmail.com>
 <20261102-b4-repo-structure-concern-v5-2-2d8f37b70b75@fastmail.com>
In-Reply-To: <20261102-b4-repo-structure-concern-v5-2-2d8f37b70b75@fastmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 18 Nov 2026 18:36:43 +0100
X-Gm-Features: AclHuK9wf4QP168zabeThwQFQjiZC3OtZ1Aje5JaxlCN6cYOhy43YBDugQnIVk4
Message-ID: <CAP8UFD39_1Km5JL9tZu1L+JDYxG5fyfAoLT1X55km85P=-o+BQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] repo: make concern thresholds configurable
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 7:39=E2=80=AFPM Mark C. Chu-Carroll
<markchucarroll@fastmail.com> wrote:

> +static int config_concern_thresholds(const char *config_val_name,
> +                                    const char *str_val,
> +                                    const struct config_context *ctx,
> +                                    void *cb)
> +{
> +       struct concern_stat_threshold *thresholds =3D cb;
> +       const char *concern_name;
> +       if (skip_prefix(config_val_name, REPO_STRUCTURE_CONFIG_PREFIX, &c=
oncern_name)) {
> +               for (int i =3D 0; thresholds[i].name; i++) {

In the previous patch `size_t i =3D 0` is used in the `for (...)`, so I
think the same should be used here.

> +                       if (!strcmp(thresholds[i].name, concern_name)) {
> +                               int threshold =3D git_config_int(concern_=
name, str_val, ctx->kvi);

The `threshold` member in `struct concern_stat_threshold` is a
`size_t` and that's where we are going to store the value from
nearest_log2_value() below. So it seems strange that we read only an
`int` from the config. I think this should use git_config_size_t() to
read a `size_t` instead.

Not sure also if the whole feature is supposed to work on 32 bit
systems. But maybe Git on a 32 bit system just cannot reach concerning
levels of anything.

> +                               if (threshold < 0) {
> +                                       warning(_("invalid concern thresh=
old '%d': value must be 0 or more"),
> +                                               threshold);
> +                                       return 0;
> +                               }
> +                               thresholds[i].threshold =3D nearest_log2_=
value(threshold);
> +                               return 0;
> +                       }
> +               }
> +               warning(_("invalid concern threshold name: '%s'"), concer=
n_name);
> +       }
> +       return 0;
> +}
