Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792499864;
	b=G1qBHRrky6xsyJsiTc1DFDlfM7l7IPmVChTyyPuRqd6T2325+oszch1BDlqdnW8FfI7y
	 4e2tmNJ2IDZpt99muGhAYlJ+LgAAB9ruq0r/0WgYzMf8DWaAYdIv+5UP4Real2LUWyrh7
	 vY5DGOC9E6NwOarfTfHflga2YC2YdWv6amGsFt1ZsIHWBL5FJ9KRsvbHKL3oCS3UdpiUe
	 nqsL+O0o3h+9CUhR6yhJ4gLm72AzePTc2haNQavasnJTLdt33h/ZiU5WrkzvVfsuiJc2H
	 MEd0tMJxDQxtVq8sgdrfWhcrpW7unHcumNVsluHa6Uu1K/+cV6tfARQICsEdZcb9B8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HxVeICsoU82MdKxByB+m68DoL5Iqw05i7ovkTFjJPJQ=;
	b=5qyY1qIxrzW80BFj3QMugOYUSlD1XBlNXKmXlTHF6rHHiYxHUTk/LO9DwujiECfzcW2B
	 u/DZ8WzPqID4nbAEv7hcKKN0+UuVtloXGkUupyIXXpYGB1boFgP57d3g48tr0TQ8ioHR3
	 a05gErjS+DijLBlSsrl3PfDxEkDVtfP0Tzr62BhBT+ISttG6Sj1C9CTODeLIinXx97oSh
	 xZu0dS1NQBWYxR69f2iW4aKVpTqOkQEKGUucaPic3K5J187XPmc1OO7/IV500VoDjDE6T
	 v48eBu/sWqULrYyENpTePs/KEBguoAPsBT3MjBBnZiE46rRWXJXEzr67LGyCxJkUnHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c74UIkFT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0C4606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 12:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B0C4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c74UIkFT
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so4356727a12.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 05:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792499862; cv=none;
        d=google.com; s=arc-20260327;
        b=OoxbFo5fn6xe6tlo7N04bo9nvE6Dn+/TPAOdtYAVpzaXdcyTvmT6sbiZhNBLLvC0bx
         Lv2D+/votVWPaGVY0kXBcKdn9Op43TaGstDFDeeGqDrxpYuRER+IzlS7iwz2w5SkrO07
         u0L0MFD1+j2elk5uX4lwW9ts9Xeuhfzn7rrxCXvusUF26Vdl+YpoVuPfRMMt4a4RSQ1i
         5RTsz63O9ffMnalcxc0pE3FxjOfqdNI80BVJ9aRJZCqs9HyJ0ocmP7aRPI7hbWs15T/C
         3F4mmZayn37/N+YZEBwkoGTEMa9IRdsFcos0rOff4mLctcP31pXOG7Mf76j1XxTJsJBY
         1rfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HxVeICsoU82MdKxByB+m68DoL5Iqw05i7ovkTFjJPJQ=;
        fh=BvQ4LGTioxSNZQS1K8JVF0n8kQmRVmLuiRp5SB+H2yk=;
        b=RFfmVz1K8iJwCjXa85+K1LIikyyzuHGpJ7x1E+ymsipwuUdNhDXMYDRqE0iJCD3ex/
         ad7xH5Pz52fBjAVLwtmnl99WrbaQxXoh8TwuaoNr4E5WbQlJFVD4lMIZH5t7fyNIVPpG
         XevVwhp5LzoY8YSVD7ZN9W23l999Qgm/mrCBwAvv3i6xdKGtlZBzSGyeKMY1vRVpiLrQ
         IpiQpQhh91QmePpePBgpvwHtmlMYqK/zEmDU/vB/3WZZAudxvUmYOmQwONopCUOoX5oD
         DKYfqs/7BXLeeT/cGsTMe1tfiGkprTSn+WupxHs3ZFqzrJ5F5QO0kWTnymu6vRE2kuhF
         Wz/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792499862; x=1793104662; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HxVeICsoU82MdKxByB+m68DoL5Iqw05i7ovkTFjJPJQ=;
        b=c74UIkFTUUpxIoxSO3rmPIfF9PbJRcgxyNpo172akxCvXUhVj/ZbX2O2JgJ6KZ73D4
         n2Xyoh5KlQkoSWaFEfmUkGP1WqqUIToG1BTl9otFs0KOWfZbRkfy4svZArxg1XWzkcYz
         W+v5fQfkHbfMvEY19v49lmETs4Kb0Sg3AD7yyEw3vqsiE4bRbjza7QOi37DKkVxtjgR1
         NOpTNv0A11cPEwe7dtfYEZ0WqQATVCPlxencVoztcBksBENAznRpJ0Lcuqt83nDosIc3
         DqPMf3dieoQc/hd4FEOqZWJ7MzXDu+hJJYgkDN8OIGu4N4v+Hav+ReQUJe9E+Tqq+Q5D
         SSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792499862; x=1793104662;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HxVeICsoU82MdKxByB+m68DoL5Iqw05i7ovkTFjJPJQ=;
        b=m8XCt0Uf6P6qZhife701KbWgbhU15L86goYdd7hV1eLzycZr3KuiYSCJzPQhSDXRpq
         jcPnZEJngqog6UuzFMy6keitL9p+p3zrQ48olZgvGD08hSt7e3Vb0OKQG6OoV+6H0jtK
         AUl8vIBAtye1fCcPb843jw4SZ92ipGVANOfr8UQIy0K4KTWlh2/lx407OqyBYkXDV4FJ
         gN7W8YSdKgkZW1RZgYHLfvBScjVLb5KPYUBpKcFryNU4C4Hh7Ikl3xz7Ah2o95HwZwp+
         vr4PRUmOFxHlCPDipsrOtjQKNVMTXS0wxpcm1xmQ/szrcE5E2eo6IVzwgqy2ypkz/vtX
         2xgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzg1j/zCHZHYSPQApi5rcQ3l8NLlxckkjOA5+AfCkKX6kaCWVLMae3nIoGImEDIx2PynzU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGTdyV69ssBevrIIOyWijkZ/EhvgMmgFP32gRRsm8wtw7HwBuZ
	mQmRp7LmXqAOzGuCjpaG7nRssauxyA48/iejrUDXAKtnqKSSbYNCK2kzgO9/0VkT3Sp2rldrknW
	pVcwGivX/HULrZRr+YnbL+HnQ1ZKVYLo=
X-Gm-Gg: AYBFou2omLhdqxPc+gbBQ5Ue6r5Yk/lz9ulVKv2HCqF/F8t5MUmswRG+RVJeRKYsSiU
	nYqudG96aH3Y4u+Vg7hOm8jqJIaBbLw/8/wx6eoN/osGsKXkC/U2mY/9cIw0ZcjlPr2ytlsVCvb
	fwFlG+Vd8+GIKjZxvL55h5QdXurumXHvxs2NbCBPxQbK7lJsy0kulcIVrpRqmKDnRvabpvJTqcH
	zdgtpGaU9KNuZ7XGnUBcaK5WTkgmS/c453AeMzpj4fOWNC1q7T8MzpZ7JXr7U2eiThi4PCGxBT5
	bIETLXYsYSMoKGwpSWTpxEJgVY5nDeubwBYDPLZj3xcyROpNtQNk4Fc=
X-Received: by 2002:a05:6402:2755:b0:6b1:d822:7caa with SMTP id
 4fb4d7f45d1cf-6b3a8153f0cmr6722825a12.11.1792499861746; Tue, 20 Oct 2026
 05:37:41 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020053932.1274210-1-m@lfurio.us> <atcQb_V69vvKnxoF@pks.im>
In-Reply-To: <atcQb_V69vvKnxoF@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 20 Oct 2026 14:37:05 +0200
X-Gm-Features: AclHuK9hkZ5nqVhzhyD5ZWqyLsEMyGtcLImzxxDuvCiqs_hRg_UfbF396uMIITU
Message-ID: <CAHwyqnVf++okhdjUuVewkK5ZhqbKSoE3TixhpNORdWrMGUA=mw@mail.gmail.com>
Subject: Re: [PATCH] init: show absolute path of (re)initialized repository
To: Patrick Steinhardt <ps@pks.im>
Cc: Matt Hunter <m@lfurio.us>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I'm a bit on the fence about whether we want to have a regression test
> or not. It feels like a very specific thing in the user-facing output,
> so it's a bit dubious whether it's really worth it. But on the other
> hand, folks like you seem to care enough to make the test worthwhile, so
> maybe we should have one?

It seems self-evident that we need a regression test here. Because
it's specifically the thing that would have prevented it, and the only
thing that will prevent a new regression later on :)


Harald
