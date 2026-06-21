Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D11E573
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 06:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782022816; cv=pass; b=j1M2fQAEd1dnn0um3jACHkXEMmRHwVWgqqYXGXvgytj7Zi3CPZS5Sr1u7Ye22asAqD50fq6KxRxsI3Z1/1b/rI9YjM9aI8Qrh4kCLcU3K1XyhSGxjIy8V/sL6xyVg4E6MObBZ49y7EfK6tgKNBwvtS8yoyMGU5BMX1nxS50vjvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782022816; c=relaxed/simple;
	bh=aXLlty+DcAGfcI489yrEagvxvhmNrhfMIpcxVpSEw1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEGzYW2epHpiZ7+hbKFY4E0367YD3YQE2zp9lzqZnB7AwApUDWFDA9xWK/u/mUXfFi2Yy88EVJHAGdO++ZO7J28NuwibWTtsV2bZ70NwlonOwb+KUEsudC0mVwoFfQOGiHhHbYug9g9+qBU0yxPtoLdNm8EFFHiIG1zRjqXrt80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WePCm+pC; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WePCm+pC"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so6249154a12.2
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 23:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782022814; cv=none;
        d=google.com; s=arc-20240605;
        b=hbmdmWRgUCmw5s21KXCIxS6A2lNmqWhd/Jolz+mFMJ5aHfT8z84XBCCX+3gYRlmQda
         UOOd28gzgZujLOpyCkPWNxdtL4OqD+nnt0YmfCCThJsSWIJQOUzcxJ/RhqhuwZV6AvDM
         FmoWydGUgcJAKBR0ePYqsFx3iCe8Pu/LleMzEt51esyZwxCfSrF5FpXUa0vMUIws384E
         Uw5JO7OgUgg30irlJCBHOkWjVdPyZiueKyOI9WLy92xcNwqhFV+yog5XJgW9hDlbqqyB
         CIYSMJJpGrhWHKkgR38CuuzReEHxRYQOpqboj166MpPV8ftKd69HXxvMssAXhQI279B2
         Qqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aXLlty+DcAGfcI489yrEagvxvhmNrhfMIpcxVpSEw1Q=;
        fh=yMxj6iN820ZoemfwDey4+5nHotcDMLL/UWb6PYYSCzo=;
        b=ax/rqq6vhLt+twoR1ef8ednTOjfnqNSo9JFPnI+BaFZZVTN184YzEa4C/66OChksmV
         7GO0ZalvHWOHemyw4044n350Ecc8v1zhB0/yPw15inpVLQLsOM5QHY9RTKYCrrCHi9w4
         vdIfFAPLf3ZvhG80WBnjpkTXh9KWGCDKs8/PtFEf0nxnDjp/LoXbdoShxufKubnJz/3X
         AeMo4c6HdVXcHN8F7joCMfZ21oGEoXIO3s3L1+zGw5eWhrhijscr61+rpUznJtZKmVmC
         cesn8110tG0yjUIiTh4qhWraCOXlyJRItEln+wUP3PGPyjNK4a4WOrsdKMgh88W4b7kb
         +JrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782022814; x=1782627614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aXLlty+DcAGfcI489yrEagvxvhmNrhfMIpcxVpSEw1Q=;
        b=WePCm+pC8fTEXPJkMe10Us5uswJlfQQo7yb5kyKZItHu3aDsDTV+mC+xoUmRhXbQuj
         Wt2Txx+JNAFUD4PaKA9URrO2KBh9QgLXtowd2/9uFwE7CoSMZcaoUH8F/ZXM/yEOyeY0
         GxO5i1u5oXORONi0SyXqKnOdSpmDaIYJTfGj9OuTVBwwPbMan8fhf5EOItD3FEGFugPj
         dCOF0ZjOMRjBacJNGHZcYZytk2GrAh4NKZuaukcP6Se4YpmyJbOrbimKlBinH5IGI9LM
         Y5uyooq5ZH5HP5KVGEREyj5f/5ar1GiIs7P/nzNdu+CzMFcEbLgLMpdN5+RrMrBqI2KB
         /ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782022814; x=1782627614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXLlty+DcAGfcI489yrEagvxvhmNrhfMIpcxVpSEw1Q=;
        b=XDNDcBASvL1c9nZGZMdb+mvBANjInxRdE5uCOmPxcGwU9phKPSvXnJjKCSbsPFhyeB
         NNxw3EIUGuVtTu/U8Az/fHOKYkAB9PQE1d09DFxQXBXQUEaQkv7MJNMqdF8JyixSW89j
         rr53q7m5YrOlHH9O43CplfHSAQ2rFOsne8HK6lmFTWICi7ytakMgRLqzigP7iRJs3T4i
         juk7sPzNq6ZfUr7flpwgpr4C9y1dbGsAS7lgAwCpqy/JioZY8ZTlUGQjb4dNb6HjbXOn
         dTRbSw0vQUxjn+XKkGFc+mk4YYCFHIEPkWeaNGzGctwBY2TIjqAkvVg+UBwmTXSQmBdw
         bz6A==
X-Forwarded-Encrypted: i=1; AFNElJ/URaOPYaeykFiqug1P9VrFKWfrgVUAZWNik6qCIDuebp0AwuPt/VQbD9T7660jaVlWJZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZeLhOdTjojU0YNnmm/ZOBxx9zprbLa3o++esI/2Q4YakFQQjv
	gpQDyZSh1F1yt/8W/CXNkPsIO7c/DJyggwzHDIK1F/bkLcc65vnOHVHNpqZxmvSAwtOJRM9Ma96
	vQO6D4HWj6pL2LMdEMDlJ3v/5P8Xj4Jk=
X-Gm-Gg: AfdE7cmzEbt1+sCpqaUSXXXA6ksaSNNYfw9ym4C4J/L5VkMjtXq1oeXLaZw/PLhYZnm
	K8QLQbCwnYISsCP/YvywJ1YKCipc9oNxMS/I3JdWlBG0xDHuxTLEplX3LeF6SvWd63XDhtznvaC
	LQgmZKZkn0CrQF+HeOZXazmf/HAbiGr7e44WIK0PEhlbI8peBwJ7btHsxnDeNZsyA2JktsPseWq
	sQRAyIUZ7vz6Im9c+MQtPOgfqD9r1fFw0y1yb4mlZ1/dMQM5+bynr4iAiMHPtZFSlE9lSomMtZE
	hlyxdVC2JeyWE/unBzawHBaJdjjfxoHOyUphyD6/bvDFjI7hHtYTsgu3iJpoaX0anjcbfSd5SXs
	8XFC2QwqAu6ZKpJGuG8UB
X-Received: by 2002:a17:906:2091:b0:c0b:f76d:63c0 with SMTP id
 a640c23a62f3a-c0bf76d6e0amr161022066b.29.1782022813543; Sat, 20 Jun 2026
 23:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com> <20260619-ps-eric-work-rebase-v13-12-3d4c7315d2f8@gmail.com>
In-Reply-To: <20260619-ps-eric-work-rebase-v13-12-3d4c7315d2f8@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 21 Jun 2026 11:49:45 +0530
X-Gm-Features: AVVi8CeBLenizS7nEl7u1XF8wV94luEyhPsAIMMARNyb3HmdkS1zSSCS5-Bivno
Message-ID: <CA+J6zkRoS5uZFkW1jJv1JO7jPMPO-ZANOYerbUxn4WPaApPV6g@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 12/12] cat-file: make remote-object-info
 allow-list dynamic
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, eric.peijian@gmail.com, 
	chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	karthik.188@gmail.com, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jun 2026 at 20:27, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> The static allow-list in expand_atom() is hardcoded to only allow
> "objectname" and "objectsize" for remote queries. This works because
> up to this point all servers will either support object-info with name
> and size or they do not support them at all, but we cannot expect that
> in a future different servers with different git versions to have the
> same object-info capabilities. Therefore, the allow_list needs to be
> dynamic depending on what does the server advertise.

Nit: "...depending on what does the server advertise." ->
"...depending on what the server advertises."
