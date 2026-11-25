Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795570889;
	b=XpthOk4e/7LiM3BG3IfSaURYv2QGzD4Q/A0lpN6IREB+ABqhBRuWmSfgTumzpXp7I3ux
	 Rs5yeC63Z5KJfec244YSXN5iYZE6OpX3uxo0uCWkMukJJuycnjfhFWJcybV7xc9cZ9Lk/
	 QnuZZe5EIAgOisUTX+YBfpIbnEr6YRiNslZeeGAUVHMPcVhWjM9xHhUIY0HbXFnEEHsS4
	 8PNUdWOle4lReONU76PA8jyaAVtp3GFAO0tDlK/DFWwugWoQo0htHy9T0Q5V3t8OIOHq7
	 7MntB/NUKpKIpTonhnjBsBjz9RG0wOWXTF6zJS5HbHSvG5Z15otXQ8xBwd5DEqadVnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795570889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=6pfFpcTEJae8tqNsdBYZON2fvYsuNtMPvWWRuyK/AX0=;
	b=VCQR9KtIQXc99GnqQDeZFpb3+fh3tBkcX84P5uhAoMrF/RI9IWD8z78kgxKkZh2Iqr6R
	 GC6iCeQmde8YG9VGTpO0jYhGEQmeBCR46KKAMbGNGZ4PLjAiinH4+XqIzFkV9MTdfnggU
	 nFxctq6d5uMxV/un3sHLgwlDJgLu7tnIF5KTak/422nhvsxyENxHllbxUR1f2Vm8p8Njz
	 TihdyBOOpjDTZS72GBP5X2fXm8OGVXID65sT0xuHhvD4fBTFlOROKAN84Bxx1U02TBVqv
	 G1n0M8hdz+2Zdf3dBEzsjXS5Vi0zzksSFjvR+4b507KAr4a4/x6cSkFKFHOqr+4IQNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WXJCMqqY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E07606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 01:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E07606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WXJCMqqY
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-71ae5389c00so3223387eaf.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:41:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795570887; cv=none;
        d=google.com; s=arc-20260327;
        b=BPXJZu94vn7kCcc+ptjTyyFxkkjHQ+bdZh2WiUL5z2L9/mHtifl6ZflNb3bPYSuFYS
         QaFp7dh3TmVUt71gmiBAZJDq8nSHF/tefE/kjcUZSrc7o2cR2obpW3R7KEZIkYe8JRqp
         M1LLRrgEyzJ9tGRckARnjQzlaascz6t2IwTbmMgKNk3NumwxGM+aBQOVE6zGM+XYJb5D
         k2R0+oeTi5cJDllMXCc+3k8JxoN+mWqheKi9kFXrtlPKJMTYd7pkGtk/Row/z00IFZkC
         hnBSA6rsY6TuPPAYsk0dR0dTm0ehPGW9cmiqMJcaPC5mKC2KZVsFwAq4pevJhCxm1sNq
         9Vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6pfFpcTEJae8tqNsdBYZON2fvYsuNtMPvWWRuyK/AX0=;
        fh=YKsNCcQ4kcGGAi7o9uD0fCcpA7wdqApBQ1jkss5zTVY=;
        b=BsC2JRSHq+PIpgieD/FWMOWLfQVhwHWoTdvMPj3hOm1vKVKJz2lbbKVjC/fTxDIfOH
         C5fZaUjStQ+VObBJHvx0PMcVnVM1/Ocnt5uUtCJNR1ihVXASLYmnnAKHM0OHSjUPmXoX
         ZOtYCiPm4MQ6i0Rq/biO6W6JSbhvMf0cEMBYvYDcYzeUkJ2Wr+/FLzHSSGLSxkytng0v
         /iv5b4sxaGkT2ZQKb2312l8LN1ZeXqj8EnJPiwoIqZCpKcXFG2PcUYzS4m1NYxeQ0kEa
         UsQfCNv9hoNrQPDfeHwYyo4DLxZtkzVHUGBjsONKQB7DJMqjpbZ1bTNiRplhykuoEOxt
         vX4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795570887; x=1796175687; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6pfFpcTEJae8tqNsdBYZON2fvYsuNtMPvWWRuyK/AX0=;
        b=WXJCMqqY/aQRwb1xajK/wXLGlG958KlKvLPtm9Zw9ls3tuRR84RGYgMUM9KaVGm1cO
         VfqMD6PXhHaSmYy0ZAC0fTlYX0YP+c93HPRUo0U8qpB0+T1lH37AnvRQDw9R7eMIW91v
         lwqRqDf18F/kQ4sV7iSrJr+0BMU4jPTCD8uwa8Iq7o162qpZT0nDJvAIwjxFSCf7aP80
         mrtG0tWBoUtiA8H7tDnmgfNkKoLy8BzqE3y1hwgyOXILlYpXnOgUKi3SLm+/Rl9ZD/Kj
         jzHqXf1OR431HQCDjCkWnecv33FwL53RpR6HsjWSggUKcAJWcmizIDi4C5SjcOrq+dBO
         +n8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795570887; x=1796175687;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6pfFpcTEJae8tqNsdBYZON2fvYsuNtMPvWWRuyK/AX0=;
        b=OyeleIKMpGzDKoNR4fvBmGGjDpxf2SnUD7PNAmS8ue7seXREM/BbOJDZ190eq/oILi
         lqbyA6vpwb39WtJo76Ie5RI/s/eo9BWpo6diQy5ToEoJo79v2hkY8GZ3//SX7q7yOyH+
         CNuNVijDRhfKXuOjmjMK/u9W3U03j7o0+x50xcYpDqa6QAxoQdsgYZvsHc7FW9d3S/B4
         l/qPdcWWrjIoFzmNnZZXm2EECzvBlcqQP4vEDDkFyDbypR/kcusUsvh1aZpInc8167zq
         uFKzjU/kcvrT9obsaXHFUKsA+fNEo8ta7urDg9Ez79AzKdvdShoFfOj6KyGiSmcfCDYv
         wAhQ==
X-Forwarded-Encrypted: i=1; AL+hErEK3y0EdoDMKMsQ2t2dJ3kKhcrTFG5JFEhqbi9/aEd20v95b56sG+yxJLgLpWcQ/uc3o0A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ViHwy//1vl3/5RHviBqLDrwN70nvyjyndwRKJvAslTTKoORtW
	6qMiCcCEpEJE/jvwxXYv7bxKAILIx+h9YYaoAKyOQ9QaphOfXI+e4h63KMZkUbzZIy/LbGYXP6X
	dAvBmKpAAa5CXf1uYp6zyP/5c0sFtAubqkDW6X2Qzjg==
X-Gm-Gg: AZFdTZd/XVDj30fPMrsvmXH6ZtKgw7dDJoCplr+ZbEgiz1uG8nQw1vSmIX81g5GTB1R
	7HZDyE/nDoBRP4lWcMwIeCozZvIdtaxBOb95SoNdlBe2BmVpqtrZJAYRRooqL5Eqna8Zo3NN8Iq
	GDZiIjAxCmQg6xV4BhMbkm+ytyVvA8kpywC+i35N8AOrc22QSUTtHUr3MbFVxHHrkJB4M0qV8qm
	RYjzuNnTKaxJrcrw605xVFAfKPL+wvbO8E4WNVYzMeOHeDqyEBk69/pmlf1XOQx7aP2AMGJLi2H
	rM8LR2IKzjEPPFqmpKdViFkcsvHV3EdBp/RU5cbOhWkRHfX0fb97gGTHhdFHU/AE8KT6poVlj55
	xjb4QtgoKJbAUcBGUSusgPLkGxxBFkeQ1525CG8CHslVSF5mxNO4GT6K1WHbog2ojx6+aJZBb+7
	htawn/ywHyLKMFASXtBdhpMfp5cb+DxrE4KErB5ZCuxE6ciVP9bpFXeA==
X-Received: by 2002:a05:6820:3395:20b0:716:c032:d480 with SMTP id
 006d021491bc7-71b3943684bmr9976941eaf.19.1795570887596; Tue, 24 Nov 2026
 17:41:27 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
 <20261112-kn-fast-import-tests-1-v2-2-b8c3a0ab27e8@gmail.com>
 <db459a4f-9454-4855-b1c5-c8ffc9b277ce@gmail.com> <CAOLa=ZR3bYW6KS=80zWcEjzxhD+C=Qt31x0ywdDTets-KG9fDA@mail.gmail.com>
In-Reply-To: <CAOLa=ZR3bYW6KS=80zWcEjzxhD+C=Qt31x0ywdDTets-KG9fDA@mail.gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Wed, 25 Nov 2026 04:40:50 +0300
X-Gm-Features: Aa3M54ratPUVnJikMc_euTELc4iCsStZhubM9w6X2SV284JQfuZTG4z3QIZ6sqU
Message-ID: <CAKrRMNrcnD_N8kcTspgAn=q5kwkhbtbSTqFn5_QO6BDLNn7AMQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/20] t9300: make the series B tests self-contained
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Hi Karthik,

On Mon, 23 Nov 2026 at 22:49, Karthik Nayak <karthik.188@gmail.com> wrote:
> I haven't actually tested, but moving them to different files also
> increases the parallelism of tests plus significant readability
> improvements.

I measured it out of curiosity. On my machine (4 cores), all the
fast-import test scripts went from 17.8s to 21.1s when run one after
another, and from 11.0s to 11.9s with prove -j4. So the split doesn't
quite win the time back at -j4, but the readability is worth it.

Thanks,
Tanga
