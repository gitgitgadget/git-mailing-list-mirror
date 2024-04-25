Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC9184D09
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035206; cv=none; b=LXpV8UaaBz8sQHO5XCEAgfXEnIX77RcRqNW9wsfy1/DP2c514QjEwmNwTU8JYSJ34EJMesDPwyqkOgI5hNY4UaBe0gMmmcjnbcpWaqEu6kY1KNyyGqrOYpq3U0bxuC7m6f2seAx+pcmLgJvOo2k/pbO/bfuyvnPPD8iiLVeXC3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035206; c=relaxed/simple;
	bh=5YkOhu0cNEzag80RlkfM3J30Lx6josMqCPRhbiDFyCs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ohbR4zb5Hx4Cg11C4Qavv7HRbYq/EazR4H+X6QMVxHvViCl2f1Em7Y1bDkq/LewfHocLClVP5nZJd9cdfw/EG2zOhfMrFG4qFqRii6abMQhc2/HcYtSjN3Lq+vQrybWLnkLbhS8B1BkPZ1zI2JeSxb08qGt7+ncMDrTRGpWHAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRmFQ25M; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRmFQ25M"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b42ce6bfdso2975735e9.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 01:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714035204; x=1714640004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHbHWiyUOp/2+rgQ0N3okb0yJSvWQUEfLTgYOdlvCsg=;
        b=SRmFQ25MxeZ13fmg6ZNec/McIuQqYypGBmmP8r1oVqSinqwb6HP0jrAae6HrRCD5fV
         s+n7etd1RA4bZOrQA/RQ01D3QESzHQaetPNL8FS2TMSjv5pBVPDLJutIf38mvyEWzjwN
         4q712WDpENpXpynVJFyfP5A88Zmah3cowrCWTzTZJ1tOhdM8X25EWnUzBVvEBespLqg9
         I0SFbBCithhVd1YvKhS2IEk3y5V3DItYLGKAjqsIz2d7EDrFTxji8MYtsK3sQdT1QkV8
         /iVve4OUlETRPxHYq370G5L854n5CCbhirFxKm66/T4IsEw0oCcQbBFLdoyUrb10Wysv
         E9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714035204; x=1714640004;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHbHWiyUOp/2+rgQ0N3okb0yJSvWQUEfLTgYOdlvCsg=;
        b=riR6dNkyWzUHe3j+uPOan5GU7c/1wQMkg91Kprs1IWSJ51LYWSaXV6n1YxeZZB+hap
         D+Pr1K+T5SQsLplFwiXX2VE07QwfhLrqMibdX27kp6ymXaSEDIvG4OO49rgJW4jg78zK
         +pgVN1YJWLbfpkkfC3Yq/Grw8lV1w3aUz4660ov0o8ECndMpauax53V8JID28G4757bD
         LLSpftzrC2Z+4kAv0vAphzTHzT9GaS8RTt7Jdg+39ENba88tNyq9n0uS9NF32IJw9hZk
         ON6xpPfKIdzJE7COBx4Y5CqvkduOXEu3CMao3TEP8GSS9Aa9VKQYn00V4loJDBaAAwlM
         wp0Q==
X-Gm-Message-State: AOJu0Yy/nnVr+L3/TwkOKOjF4clX+x8rsBWq8KMJp4adqiWwnCb3Jvt3
	RJEC8JRX4lf3g/TwJ5XM07Tl4gLZ3efuPzREHFR70EhBjIKJKo17
X-Google-Smtp-Source: AGHT+IEG8+Ojoro3hH82nZ0P4hLcrNBtCDNUIsB6oks8gTfUIvswvy4wT2K+1hl+qybj8uvWBYiU5A==
X-Received: by 2002:a05:600c:511c:b0:41a:3369:6179 with SMTP id o28-20020a05600c511c00b0041a33696179mr5061954wms.26.1714035203534;
        Thu, 25 Apr 2024 01:53:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b00417d624cffbsm30682774wmq.6.2024.04.25.01.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 01:53:23 -0700 (PDT)
Message-ID: <02440375-2514-48a3-8f94-11d853f00caa@gmail.com>
Date: Thu, 25 Apr 2024 09:53:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] add-patch: response to unknown command
To: Jeff King <peff@peff.net>, =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <20240425014432.GA1768914@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20240425014432.GA1768914@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Peff

On 25/04/2024 02:44, Jeff King wrote:
> On Sun, Apr 21, 2024 at 11:52:33PM +0200, Rubén Justo wrote:
> 
>> +test_expect_success 'unknown command' '
>> +	test_when_finished "git reset --hard; rm -f command" &&
>> +	echo W >command &&
>> +	git add -N command &&
>> +	git diff command >expect &&
>> +	cat >>expect <<-EOF &&
>> +	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
>> +	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
>> +	EOF
>> +	git add -p -- command <command >actual 2>&1 &&
>> +	test_cmp expect actual
>> +'
> 
> I got a test failure on Windows CI from this. The test_cmp output looks
> like this:
> 
>    -(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command 'W' (use '?' for help)
>    -(1/1) Stage addition [y,n,q,a,d,e,p,?]?
>    +(1/1) Stage addition [y,n,q,a,d,e,p,?]? (1/1) Stage addition [y,n,q,a,d,e,p,?]?
>    +Unknown command 'W' (use '?' for help)
> 
> which makes me suspect a race. Perhaps because the prompt is going to
> stdout, but the "Unknown command" message goes to stderr? Maybe we
> should keep stdout and stderr separate and check them independently.

Can we change err() to print to stdout? I can't really see the advantage 
of separating "normal output" and "error messages" for an interactive 
program like this.

Best Wishes

Phillip

