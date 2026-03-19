Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8605E28CF77
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898543; cv=pass; b=AdMBfV7PZXeLYbsCP9DSFMUPRPR3g88+fO3lGLbP+zfbSemG0/wnW7FotArlyR12XDZcBMgFtIZe2OxDQPF+zfrdF23NzPtQS9MTo4ZPQnAtzW5xjwALRW1xuQSZvO8g11AWweT7QamgMSjcA+oxJU4SCvrV/jkURY89vOTMwJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898543; c=relaxed/simple;
	bh=nyQSaPEVESP3BOHBWemySU+pbZBTbVWv0hJtO+ddLkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtpffpChop/tW0yD5mPlEONWU0NK0isRtpq1bhKtu6qP+GAplM+qiFKAEppSCxsDtAOQ6e2bEyjR/ISdn7brfmIf5DjaPdK3mckUM2fMAzB0Zq0z3B/bABa4Oj/gw6PN7rTQlpNP7WLlPsJg8VV68nNPQTvq2qQL66aLJpILJCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI34fWEC; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI34fWEC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso1812955e9.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 22:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773898541; cv=none;
        d=google.com; s=arc-20240605;
        b=V9ztsOu279UlJhn9Shh7EPqx7lMulxJCDRpR+VJorVavvUjUfSJtEpx7v69M189C32
         vDvO/L4nWwmFXM75gyb2jxbBuFBT0a7JhQ7T59Hm7JIfZ4dDMJLHN35I9FANB8CY5ubU
         emiDmUFAGv2KZ7ceEfPrdkFDTSDr8w8Vott9G9Fsz5UFdI83qEVGERFdKTCmoEFb99mO
         3Zu6tDaIyJCYCpviOfVisDNRy7rRS2f7UkM5yzXuagjoia1v2raKymqF4Zhfz85DY4h1
         yxhqP2DZngM3Cb++YCFcXlKqCxH+7rx9qyuAo+wokRH0vmf5zmVpj3n6p3o8ybUQCxGk
         CLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nyQSaPEVESP3BOHBWemySU+pbZBTbVWv0hJtO+ddLkk=;
        fh=q3FwEuqcmu+syEBXkYX01gKL+3nTK1MeVWYK6W4eKi0=;
        b=KDXjCAZNjXMIx8Au+QNPTupvI9lA2hCv0Zj2gDQEgySUS4y4lSLWr8zuExeeq1t1JX
         QV9RX65Uwnrw6eOGM0mXjNL89LpzM56e1jFXS6QQk7u4ooE67xZ13lLKXuJNQJLhiEdh
         7Hn/XzV+Tgi1b6PjmAQmt84gmIljolpAV7oNaI64hU4Xk15CUvVUzvVDERdaDi+0G6Ja
         ZrpWe0Nf5U0PJCg5mWSsZuw8YmmFdHVixYbceqei4fDJ7U/rkBaPmascUCq2Ff/+80jT
         bsJkRW0qo50+HMJLO9hsouhoPWVG3V9ZgczulppXiyeSEcZauiWDPP4P0NmPF0bvN2zi
         8X9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773898541; x=1774503341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyQSaPEVESP3BOHBWemySU+pbZBTbVWv0hJtO+ddLkk=;
        b=AI34fWECnY2wR4grBaWi998pG3a2lMbauu5jkaR4QMo1mtD1iDyEDROgEBXXaJ87k1
         KXSuHlVzcV4Z1pzycgm5UQRJDhHGgTjzf4B/ogkoCRnvbGWvjD+01xlY3O68QtmBtBaw
         TJEw7nXKzXZkL5P6HQ72/OO6fhpdpR3DQvWrAdI94R+qlwABNbyWQ9tfpim4xDD39VDV
         hHzNnm9xhvIxvNhrahIwh+ivIHRoUclLnvrjj+8G/fc0tVYc0XDhh1KgyOIzrZ8gZ6Jf
         x9LWufSev77MHCEQjJegihNeZUN2EkoN7TcHWpg+smh5kfUzv8vte+5PKd7ZLlMkxmp7
         ztMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773898541; x=1774503341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nyQSaPEVESP3BOHBWemySU+pbZBTbVWv0hJtO+ddLkk=;
        b=EZQyNLtZuuTyILWUpx2DYlfefQBfmVPOD1r4iWRdw7kO/B9eeXOTC4yfexM/qxV4IZ
         dfn4kY1DuyKk+YI4jg8s4VqIaPclshSQOh6RSIzLjXg+9OtF2CCn2178DDJJEJxAR09O
         Pn/sKI1DeuYxXM4D/HS5I3nMoWOV4+mxebhO2lFC3nRREtb3WG5qcfiDN/exLIsp3lK3
         xFz7RED8N/y9qW0xb80/EStmMJwBnlSlbwEIsV4OYoJSsRdMC1H9wbZVexoP4cjwYKI4
         QEgV0Z3zEIH/z3/GdPckhig+CPG8oDpCf0iwdhOdnUuFttU4yCGNyFHrRTY1mPGvXH9z
         Feiw==
X-Forwarded-Encrypted: i=1; AJvYcCW8zcazvFowMFJnSkxEdmMdcLIYAxRZbMhDO30Jdu7EKmVG+g4zkoGAEnPP1hiCROewMVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRiFxBFZ9P1+nk/Hrx3ESdbySn3TC8dLZqH677RInfyM7DASq8
	yxri5kGK8InEPjOjkn9vdHs2uiKSyOQjSRTVhFN9y7ZBa4TBl2x0/nQDU5f+eluJwEN3OIQPtCm
	tcUSiOTEtdJJtkd05rVwLdBRD1ajwLh8=
X-Gm-Gg: ATEYQzz15okw7tkdkml6HJY/30gT2/p+En2HrtftTmRUhZqdfsUE1NO7QWyAM4i9nBG
	zpBTZL53RoNIutvIlCoKTa7+fAO4qVcWDpmm3xsVjNGjJioYwRqJHs/Yxd5m2+AUOmGiUxvtK85
	87aaRSSAxYWnS01pNmFdcYVJg8YNL+3sah1eH6YVdqBLEU7x/wVhigUYtH/cTl83JeeY34SctAz
	ZCJiRai/MRyuYAOn2TcCHPNqH28LKmsY8qFGu6IB+402t5oQ5txLM1ty52MWgRQdi3Oqc0IAxkj
	b/wJvjs1/NBpkEPqBZge/u98q0fCGItH13/iLXx/WAoLtQ4dqw8=
X-Received: by 2002:a05:600c:a016:b0:485:3fc8:de9c with SMTP id
 5b1f17b1804b1-486f4426488mr88620025e9.12.1773898540432; Wed, 18 Mar 2026
 22:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2071.git.1773857555312.gitgitgadget@gmail.com>
 <pull.2071.v2.git.1773864455956.gitgitgadget@gmail.com> <xmqqtsucq4l2.fsf@gitster.g>
 <CAP6n+1Uj6sd75ENFY8=7NtcOUehTjY86YQV9YOWgdOqfmFHYPw@mail.gmail.com>
In-Reply-To: <CAP6n+1Uj6sd75ENFY8=7NtcOUehTjY86YQV9YOWgdOqfmFHYPw@mail.gmail.com>
From: Aditya Indora <adityabnw07@gmail.com>
Date: Thu, 19 Mar 2026 11:05:29 +0530
X-Gm-Features: AaiRm53ALgZOYzaMf-ExFh1T7EYO0uTivEv6trU_mbyMAuPUvg9iu6yWCPIhxic
Message-ID: <CAP6n+1U9UHp8B_DXLJu6d1tsSo1qCuKXdH0tQjXXj9wp01iHtA@mail.gmail.com>
Subject: Re: [PATCH v2] t2107: modernize path existence check
To: Junio C Hamano <gitster@pobox.com>
Cc: QUANTUM via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Thu, 19 Mar, 2026, 1:43=E2=80=AFam Junio C Hamano, <gitster@pobox.com>=
 wrote:
>>
>> So we've seen you identify yourself as quantum, aditya, and aditya
>> indora; which one do you want to be known as to this community?.

quantum is just my github username inspired from steins gate anime, my
first name is aditya and last name is indora , i want to be known as
aditya to this community .
