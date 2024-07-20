Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B41E481
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721515522; cv=none; b=JlI8AAekH7dl1bg1c21RyAeblSTZmRSa2BXnSTOHubbvNo5q3USzu9cVYTUYByu55blywJuFJWDqknAPwo+OOLi8rX2WtzNGXT2OQdI0rmx5DWxOciO+5JPwd0Mz2CRq1Ids6hpCAt35zM3U6c4GLGIY8DPq7L7HS5aoQfseEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721515522; c=relaxed/simple;
	bh=Uu3QxC/Hbq+BhHMsrkU8D9FupIlWHTPH2FEsbnNVfLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmUFc6rS8wFH2Cb19E5JeS48X9EmffTwWiXyx55YSn++MfYo9XFaomMG+vg78OXEsEE9wQ0a+2HteF0zlMyUz5wsK+W7bwEG1djix/pAyp6S7EGrlZlJE0MehrD9WofrTe0UZuyMy3e1yNWvN0vT0tsZwFPf1C5a/yPze+OqV+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R45TfLPl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R45TfLPl"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso21466285e9.0
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721515519; x=1722120319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fUqN+jLEnTR9xglUIFpMhos6MMvuSv+zGmU39pRobiM=;
        b=R45TfLPllKrW9s3YSJboZ0fLD9D7G3Nke+vHydBfXvvqJfbyvtlr5otMqp/7KKDZ3X
         ypDxB0QR9S7BN0dlaJArrEtXZC/ic3+1vDmEnLYZdI/+P3G1hZc0YWyLig3cxFDLwPQU
         9/SxM7EMBrGxsdMl/8L/mTU3TvbC/CxN6eBBerD2WRXxkqBpO8scbq5UDuWhkpD47WNo
         GoSoZ6bc54t37g95OO8PTaNtCTyR/Qxog/B6P8q5bV/I1HRlNnJpOE+swQGXSj9TQlHl
         7iCJ0LOggnXKyqZSL8bTNFUv2dDy6DGhxi6ZXIlPByApAK1PpY0tfY6LJ9JqIVsmi84s
         Z4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721515519; x=1722120319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUqN+jLEnTR9xglUIFpMhos6MMvuSv+zGmU39pRobiM=;
        b=ILfCwy4WZhO8M70ASIBEQYCrVCXrG60AyYvDoUhAe5FC1nE5wWKzI27lSJGLXCR12T
         ZeEzICNrO/xT0IGmI4Ajgb7wzjgGEO4lYJVetEI30kYJIHGYt2ADea3sP6ugFHpvHgdr
         43Ah5JnAEggmZGBBUzTVGJBO4uiemx0UprPpKYa9woY33w9kLjgR/EKqe94VYOsH6hQW
         /ua0K3zd89yAKp9gzfqHwOrzMxqkG7oMoC79tLJycs+xcP/rus/kWpuhfZmUmpn2pbGF
         mDIheX8WABc1YMtM0ofLQPVLrYRueLtBb/zgoR6xuV5x+gSEnPN5xYS7FHzovQpsWLeg
         Pryw==
X-Forwarded-Encrypted: i=1; AJvYcCWtodlMEWvwihWQsbCgBdpKbhTQjjsb+XhOS6cJeg3AJL1rmyNes9unKhCnx18eq/pwu7VBuSxjQjfRPjPeOwadWYMS
X-Gm-Message-State: AOJu0YxnEW4liGvdDP5fF0HhR4V4T9GpgENniFrQrkR5GyRKbiZyuDB2
	F1N3hIyaoE8+wREJtQ49xfuKEiwQO+UrfA0MEpUcaFCFHdQ1gXt7
X-Google-Smtp-Source: AGHT+IE471zvH3gTyg+cpBdcQlf7dCVemKOxSxBqSUOtn8ci+8kq3P54Q2nOSe0xWFQZBo8zQvwqXQ==
X-Received: by 2002:a05:6000:1fa9:b0:366:ee9b:847 with SMTP id ffacd0b85a97d-369bae49e21mr1881734f8f.14.1721515519169;
        Sat, 20 Jul 2024 15:45:19 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ec979sm4677555f8f.94.2024.07.20.15.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jul 2024 15:45:18 -0700 (PDT)
Message-ID: <ba1c3bca-177c-4dae-b4c3-1a4deab27d5e@gmail.com>
Date: Sun, 21 Jul 2024 00:45:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeff King <peff@peff.net>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 <f52d5c9c-e96c-430f-a49a-eb2ee6e19d9f@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <f52d5c9c-e96c-430f-a49a-eb2ee6e19d9f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Jul 18, 2024 at 10:58:36AM +0100, phillip.wood123@gmail.com wrote:

> > However, this error has exposed a problem: calling `wait_for_pager` if
> > `setup_pager` hasn't worked is an issue that needs to be addressed in this
> > series: `setup_pager` should return a result.
> 
> It already dies if we cannot execute the pager so maybe we should just die
> on other errors as well?

Honestly, I thought 78f0a5d187 (pager: die when paging to non-existing
command, 2024-06-23) would be sufficient for this series, but I missed
the optimization mentioned in my previous message.

Thinking in the context of "add -p", it might be more sensible not to
die but simply show an error, so as not to end the user's interactive
session.  But it could be a change in a future series and thus avoid
prolonging this one. 

However, if you can think of any other cases where we should be stricter
and die, I'm all ears.
