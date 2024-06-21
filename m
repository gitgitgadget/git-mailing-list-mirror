Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6E63A
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 05:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947553; cv=none; b=JSCZ7+dPiIZYT0BmxmB2IGndJWSWfwPjLfjTQnOjrI8VDI9NTjS5jkXms22tG2FbiTS4G/aqmbKCDMuOv67/JzofEA3iiQlrddMIqFxe/iOzuIEOgSN+WwWdNxF+Y+zZuRqHLpa/iZME4OkJGrGYZOs6Zx6y1us5iHC+fsSXoE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947553; c=relaxed/simple;
	bh=0ilDKeMHV2c6irPIw2bdniR4rVnPTpcLL/AHwIDkErk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dUbu+CUaT2wOUwtCLFd7/SWo4/zmwTWWNfj54L+D4H0DXO+tF5cdVgI9IRK7KJBKHSLUzYmFjQ45oGR6PUzwDCP65SL4Z7vebN/JXi5YLoaThRVOqA+b2DYHACvIAK1i3rkIhZg9l/HHP11s3yxpf3JlHz2DuR3+TPuhdR/Gn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzBWSjb5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzBWSjb5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42108856c33so16267925e9.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 22:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718947550; x=1719552350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GrpNWFS0eWPf2OBEFF/0Qb9CSq/baMPaR+R9/sZOqM0=;
        b=OzBWSjb5UVEG8HRTSZLSfLljDdBy1T4FthjJxhykMR9X/ulBcZ0QlG9r8MBhB+nvLI
         8mfWmhtaONaXdpPCFyYN34qrGH79kM8VKel3TZGPkWeeihgczen3782sG+zDLuDfQAXS
         YJjlOytu8Ge8Pw7NfdkY+MY1HSZSnTHyqX7/8k+lBmtATRuSdVZmXJf5Lgy41y9q8ZwW
         Il8cU1oHwdvv8X3Lws9Pj970U8x0R5gMYFroEqlYfKJ9E436CSTQvum5DXbDiEWy8Dt3
         jmXUM6Unia5hAlnmzeujL7eZaOgD+GZM5rEwVj0/DjgtkGpXCecZGoOSY14O0aMrfDYU
         e7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718947550; x=1719552350;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrpNWFS0eWPf2OBEFF/0Qb9CSq/baMPaR+R9/sZOqM0=;
        b=RwuhGK4mXkBv7jqmms3Q58xnvEPJ8DRGJeYyyGFirEVofwMWiSFtyyH4ILbkmRV1nB
         zI6+XyU0lEDCFcQSKGYY9lDR4eV/Sx1BXbl0inPldgt0CK1CV+r5eqm3GJ90YXbp1k7v
         uKOCzfz9qyjDIZJ2h6OidNj/ggRBCpnJZzkjmQc4qLbCSxG3GoZwwmsuMk0Xd3zvH05I
         qFfvsSHj6uR7LtG09RMEgWBlrvmqwIikkeS8L7o0Cq8qk4E15bmcvMV7P4zfNYmfrr6P
         w92ALVxPrLrX+dcadshkfqizhoA9Pv42ZeUkJ5T1jYeR8icr9x4owZibst0V93wpW1fx
         ShUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPLj4bgJd9ucHEOEeRyWk2ILR0XvcqMLn5AvIa8ZmDPMr71umXHE7n0LaOHY5Eqc6QMgh4UfuunutSseVslmbCEZcv
X-Gm-Message-State: AOJu0Yyzn6XuAgLIwKP30DVhfpU7GDhPqgy8e6N5VR1GQ6rfXMWUf+No
	U/vLRjHblMWFiHI3D0euPbcILe+KmrvMX/aN2EcS8smv7s/Icv9G
X-Google-Smtp-Source: AGHT+IE+yU+Xb/sHZrwh1QDGbFIs4dclIdiyegwK6V98pJVDeil/QznUAuy5TAPHhW4PLWWBwhWnsw==
X-Received: by 2002:a05:6000:45a7:b0:366:595c:ca0c with SMTP id ffacd0b85a97d-366595ccc2fmr395906f8f.24.1718947549443;
        Thu, 20 Jun 2024 22:25:49 -0700 (PDT)
Received: from gmail.com (179.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663ada00e7sm699929f8f.112.2024.06.20.22.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 22:25:48 -0700 (PDT)
Message-ID: <8d903487-2479-432e-a171-931f264bf9f0@gmail.com>
Date: Fri, 21 Jun 2024 07:25:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Jun 2024, #07; Thu, 20)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfrt7p3ra.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqfrt7p3ra.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Jun 20, 2024 at 04:56:41PM -0700, Junio C Hamano wrote:

> * rj/pager-die-upon-exec-failure (2024-06-20) 1 commit
>  - pager: die when paging to non-existing command
> 
>  When GIT_PAGER failed to spawn, depending on the code path taken,
>  we failed immediately (correct) or just spew the payload to the
>  standard output (incorrect).  The code now always fail immediately
>  when GIT_PAGER fails.
> 
>  Will merge to 'next'?
>  source: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>

I'll send an update later today, with the minor change suggested in the
series thread.

> [Discarded]
> 
> * rj/add-p-pager (2024-06-04) 6 commits
>  . add-patch: introduce the command '|'
>  . test-terminal: introduce --no-stdin-pty
>  . pager: introduce setup_custom_pager
>  . pager: introduce wait_for_pager
>  . pager: do not close fd 2 unnecessarily
>  . add-patch: test for 'p' command
> 
>  "git add -i" and friends learned a new '|' command that sends the
>  current hunk to the pager, instead of dumping it to the terminal.
> 
>  Expecting a reroll to work well with jk/am-retry
>  source: <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>

I apologize if the delay has given the impression that I lost interest
in this series.  Due to problems on my end, I haven't been able to
dedicate time to it.  I'll send an update soon.
