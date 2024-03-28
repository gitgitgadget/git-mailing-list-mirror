Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A1BE4F
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711586357; cv=none; b=R8ckALH69bxLkmW7qTDDiil0IbUA0BT0zjGwpWUqketop2ink/mnmQdXPD181HWAElZkVjMpfgmKdkD/cjBRM0XiZCUWG0YbVzMKjOZWsKIv6PxhY7xIw/OOMbthAPwlwZCCkh2fGOLK2FmjLW1Y5e3iQWMJCwABlo6su8Zkt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711586357; c=relaxed/simple;
	bh=cW81BWiyZI0tvusHgzSMZcTNr/ejWXLfJE8frOpa2a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFOl2umdLgeUDP+YY7qVgmDwhmsuPJUtauOWVvd0XihjDF8Urso7ObTepvNTXbeLSbEr/fMr/D4ehn1zfCwJZTo8AKpiap2Hd+gF9PPFOF4XNYl5cf5hzPcYl2U5Y+vbCWfkEyGGswg9FGpbwo6+vGRwiEyodNmsCiWKAdDIEYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHppXnGv; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHppXnGv"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ed4dd8659so973593f8f.0
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 17:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711586354; x=1712191154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ikN26aDjYKr6p5OdzJptbKi1tKTBT57sC7CHecdTQA=;
        b=eHppXnGvG7AfQq2+aYzR++giJfiyao6dm0g3uWrB8q5FDx976sU/EMftd+297xOtNn
         pGEWv/DZN50YozdkU+XhCEc0lJlbViI0vSvKsFeujJ++XtbzFf4OZTT/0wiZx2RQ7E2U
         PaCgxVgjyfarMGxeLEc7mTcPLrlBtBWpcC1cAWyjc6PqFVymc4xPNqhkQjo526mW/Daf
         l5eIeF0OqasrlmwdKW+NMhVkI0GR2Ec7+at8DiB+93W1SJgduAxEYav/8XkD8+wD5/nN
         00zbyi0l0yVWf9Y1aF0mlKM3dPDS5fgp6dDEqBFafphz4us+V4EJjAWJij7hFGzq454X
         UCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711586354; x=1712191154;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ikN26aDjYKr6p5OdzJptbKi1tKTBT57sC7CHecdTQA=;
        b=ORXzwlkH6M2y9NClAJt6a905rzr6IuWpLtxqxgBslVjG3NrHTyjCKoUoNHjP+zKj/f
         dOqzwejzyjHuJqHfNHdyBRNA69/0FwkJDbdYNmJBPnq/XBs5whEzIhTP/bgOD6NY9sTh
         5vzvQJddIsYv2Gz85h7msjvD0Z5y3ij19aob34t9lQfBbkfLfYVhfllvD3HtzEPzbM6P
         5ua7MxiCUvjpCsbAd2wpQETKak4Jy1NrlP0R3fSqsWAqnEsSujAmD7kVuiyVhp8rMtPc
         AK6tJvoeWu1EiIfl8Gwgf8V06Fdcd5sGbNhm7lPBOmGG8BixsmzKBPyFHGhtbWsexDhK
         hJPg==
X-Forwarded-Encrypted: i=1; AJvYcCWsuFCSHSdt1GPpFygOW5y0TY3NM5mrPMdyBsgsUxxM19Pvph5pNsipe1Gs8znW6sgvgyjghpY1MoMhrfTFbZnFcuZS
X-Gm-Message-State: AOJu0YzQEIeNHrxUr1cunJ7Hs3/CrVxTUn0CYDgb0EdkSvZuEnqMrQBK
	QF/jqipJ8+7PVg2DIopwb/5POhNKmMxB/aW5re7LsCk7H9eCebDZ
X-Google-Smtp-Source: AGHT+IHwG0krbJJwwrl+y9OZ8BgOQwphUd0vlPV8AMV/rnMfkUwVSPS8oyBwhZqKt01vfzZ7XRBIIg==
X-Received: by 2002:a5d:6781:0:b0:341:e382:3b6d with SMTP id v1-20020a5d6781000000b00341e3823b6dmr586821wru.32.1711586353817;
        Wed, 27 Mar 2024 17:39:13 -0700 (PDT)
Received: from gmail.com (200.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.200])
        by smtp.gmail.com with ESMTPSA id s7-20020adfecc7000000b0033e239040d8sm292057wro.84.2024.03.27.17.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 17:39:13 -0700 (PDT)
Message-ID: <5abeffbe-892a-468f-8d2c-40016662b0d9@gmail.com>
Date: Thu, 28 Mar 2024 01:39:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] add-patch: do not print hunks repeatedly
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <c123bf09-7f4c-46f5-aa09-48b2816bf85d@gmail.com>
 <b3c6a5dd-2d78-4149-95f4-57cf8bd1240a@gmail.com>
 <db774d76-5ecb-4b4d-9ede-dce0217c324b@gmail.com>
 <b578630c-08d5-4a85-85db-c0bdb24a8486@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <b578630c-08d5-4a85-85db-c0bdb24a8486@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Mar 27, 2024 at 11:06:49AM +0000, Phillip Wood wrote:

> >       (1/4) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? U
> >       Unknown option "U".  Use '?' for help.
> 
> Yes, I like that (though I'd use the same quotes for both parts of the
> message)

Yes, you're right.  Using the same quotes are the correct thing to do.
I don't know how I thought we should print the result of
git_read_line_interactively().  After thinking about it again, I see
that would be misleading, to say the least.

> > If find having two strbuf_reset()'s in a row confusing.  Maybe it is
> > just me not seeing that that second strbuf_reset is "close" to noop.
> 
> If we don't print the hunk then the second call to strbuf_reset is indeed a
> noop. In our code base it is common to see a call to strbuf_reset()
> immediately before adding new content to the buffer, rather than cleaning up
> ready for reuse after the buffer has been used. If you grep 'strbuf_reset'
> in this file you'll see all the calls come immediately before adding new
> content to the buffer. By moving the call inside the conditional we're
> moving from a pattern of cleaning up before adding new content to a pattern
> of cleaning up afterwards which I think is harder to follow given the way
> the rest of the code uses strbuf_reset()

I have no strong objection.  I'll reroll leaving that strbuf_reset
untouched.
