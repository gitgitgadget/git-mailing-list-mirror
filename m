Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C97D071
	for <git@vger.kernel.org>; Wed, 22 May 2024 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399549; cv=none; b=QEl8l0+iqDwjoZXEq1TBFAhhBDh8GFKGWPBqNaI7qvMXu2GA2ksEGy6acDFm4XeuK8jFurLG+4K6i9xKB6N4qWRn0KD5Bpm6E2PF04G4ymRW8VStxDJUCAbEtBBYpwBLY7X3BFQk7+upM1ibBWTeMyoX8pCb11ZiTixoXbasMfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399549; c=relaxed/simple;
	bh=y3hrhBn9Rtr+jnomos/mq+JQQX5WWnQ4tk/4VrRZYPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFKu8WTDavQRmByKYx+nB51TVM551HXqb3m6e+ecOsLCGiNk75f7M0E5/lSkQTP8WSMxMRB5Rdvt7gGUUYjYyfOMS98S7/x++8zHsFkNjHiAtfLRUPLlsIELpkxAIqeRQ8wjgIZFFV0QJJ3epcuoXxDVeIpzaUnLgn3M9IomdWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KC9PVsYG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC9PVsYG"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4202dd90dcfso10296325e9.0
        for <git@vger.kernel.org>; Wed, 22 May 2024 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716399546; x=1717004346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZD0nSxShqhVw6aLFiBLRO8jZ9VfzrPU9CpR3et//v4U=;
        b=KC9PVsYGjVjNrNI7PeF+tditZfWhJrIZaq64T3SSVM7fJOVYlbh57V1/oh13RusVHo
         m4iFh8PYQOGeMvDAJPqiGWv4ZxhtY095O7TTMbKv6Em25uuWk+3pTvzWNvPH29rUA8f3
         Vp2AxliuQoGFna2FQ3pXY+U4CFBLzlUhlx1heMbyvirYknMbRIAEsC+JuTdV4od4LP+a
         0Vz4zH3NHaTyeHLZjJYMgxriEDGcJel6+Fg/Yr9TUfAL/ui8EI2Hh+MPcQEYNRhOeSWu
         9u7avvEtaX91OW/ddBuxx9RCEOR5yZz3ZvFT5+9PWPjeB+f5/DXm3bfS/8hz7Yp3y4iu
         xK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399546; x=1717004346;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZD0nSxShqhVw6aLFiBLRO8jZ9VfzrPU9CpR3et//v4U=;
        b=a1l2j/JJxnSeRxcfFZE+J3QQfH3RwSst52mXhwEqX6vlEj9eGuDKWgXPU0268naiEA
         UE15lQhFO+btvVn+If2hYeqZf7Eu8InnnBkoA+G4Yo8ofzML3HzNmQWRBACwxaN7o3+6
         S/wy5/NNXCohGrAd8854FfrUqH0zamgMwiMtLaP5hXXptJUzTJ1+pznaG9fS8yJPGeKI
         k+xgDutKvMiTHrbMsatWAcQamub0VOGZiD9aN8PEVhMmjTJsh2q4Obx8IIUxm1BEfIOG
         pU+RvF23AL63/FXeGeWbKeV3mJqLejGiIsr3/9XS9TwbXctqAtoeU3X83p1NKSGI4Wxy
         7E4w==
X-Forwarded-Encrypted: i=1; AJvYcCWMlX6cJRQ0uHA43j2o24CcLk0KNa4BXvY9vtL91m6MV95yk/3PcHlCJVqdzp5t/b11mp/nAML5fv+Vf2X7Y5yOAEQ3
X-Gm-Message-State: AOJu0Yw3JZh8R2jKIHMZPvKKIg+j83/M0BuYeTkQe0JsDQRMAFqpMtjY
	NAkWVXdXN9514Ow4bl59nAppWAfTWkXvu52MUF32ZVQAGS2UL5oGZJZFPw==
X-Google-Smtp-Source: AGHT+IHQN+3uLL/e+Y2HewrBPshCJQoQkJV9P0LDXXn5fxB7xuN8RL0MOouZtyBcrUBj9Ph9fs+cUw==
X-Received: by 2002:a05:600c:2205:b0:41f:f144:5623 with SMTP id 5b1f17b1804b1-420fd311008mr22238685e9.14.1716399545937;
        Wed, 22 May 2024 10:39:05 -0700 (PDT)
Received: from gmail.com (133.red-88-14-54.dynamicip.rima-tde.net. [88.14.54.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100e4c1a8sm1226445e9.0.2024.05.22.10.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 10:39:05 -0700 (PDT)
Message-ID: <e9f41db1-741c-413f-81ce-a86b1802e507@gmail.com>
Date: Wed, 22 May 2024 19:38:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] add-patch: enforce only one-letter response to prompts
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>, Dragan Simic <dsimic@manjaro.org>
References: <xmqqr0dvb1sh.fsf_-_@gitster.g> <xmqqh6eqiwgf.fsf@gitster.g>
 <xmqqikz56a6o.fsf_-_@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqikz56a6o.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, May 22, 2024 at 10:14:23AM -0700, Junio C Hamano wrote:

> +		if (s->answer.len != 1 && (ch != 'g' && ch != '/')) {

This "len!=1" introduces a nice dose of sanity in the UI.

> +			error(_("only one letter is expected, got '%s'"), s->answer.buf);

Here, perhaps you want to do:

			err(s, _("Only one letter is expected, got '%s'"), s->answer.buf);
