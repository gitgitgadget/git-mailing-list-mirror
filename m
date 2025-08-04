Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39661236A9F
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299692; cv=none; b=j98AvK4W3WPcbwy7D4Zwf7UosVqjDhuluZxfr0fWG/nO+uKkL6Q7mTP8ieGIR5ZIn7ZMH1WTma73X/mEYyLZ+zaJYvDu2A9KksKkmBmDAL8QWCNRUkgjV9WgIOIiBYUqEYGR2T+HGiu5yiaX9myAOIOl11t8v7E51KsBlCt4Wgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299692; c=relaxed/simple;
	bh=bel7dXGmAFYiQiHqeu7E/2uNd+HxIXAIoRXhj6Wtdrk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nM3Iy6dHHiFII7DyDtv1ad7T3Iv7nEp/VENF1JgwBHl8fjwkBGSVIn/NFIrZUsoXQBkykHB/AcD1L4apl6/vYGk4BFfaW/t3BvS8FGs8RS+gDla0eSTOAlzLLqNQ9iq6nW18jLrCIkXDPR9cX4yskoU5ZCun34DqDsVAgQVPNZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EH8RpU4C; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EH8RpU4C"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b7892609a5so2740566f8f.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 02:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754299689; x=1754904489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jcm9eUtmYXnJ3CFHdpqUO0aWeL+U2G30VqbydC7XLk0=;
        b=EH8RpU4CGmFk1GLSX0XwuQXrwHa4lP/zfjFBrZBlJfaM0Nqw+XjPTUwmyX2GANpwbn
         T08ZXIMHSCbk4vPTX+Rk9fests01pxFMgXnNuwqAbWyvUbDPzLw0dbSRjKp7GQ4lnMIZ
         kaUPr8DWlVNxHEzgVx4/OfcNAJy2Mwa0iKBp1vIPh6v0hB72eF+Q0VPYy6KbR0LQT/W9
         CTvkWwKDOMQeAPYwV9NTM3aIQlxw8+xboXnkKd7MDL0SQtupJwaBVkzyKwfZEvqWQbgQ
         he2n3WX8rBkpalWthS+F/Gn/IcrxKIji1Tceknq6xCpAYkIpgN0gZNCCVdPSv21mqGQN
         TjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754299689; x=1754904489;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jcm9eUtmYXnJ3CFHdpqUO0aWeL+U2G30VqbydC7XLk0=;
        b=uIzCplLpaRPzPWf0B6AzwXN9/26RalwF/hPNN2PKBuZJGU9z9D90emGMbWMMryPeil
         9eg/Gj+Tho8JuWJ1r/XmGxux3AQqCqIjthDNXuVW3x0PPIX6f88GfLSwYlcfMRZJTsmm
         POvXtTIIg5mvBadZ+P9xz7HESF3BOoWkXvf0qk6VHL3EGFBOskFP9yiefckJt8BBlQ6b
         dcTdYeambQBb74m8hxSiR+rWWft8pi2M4wkucp4f8lsSFw2soqaIkpVsyS0d4m8FeC9S
         a8yq48gbte1e/4ZRoS6sPIWJWwN1N3Lh9kuZTFOxoDT1shk4TY7X0C19yv0MGuTQxhjQ
         sXAw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ2kfVHXSOczHXD29r14f7KfdlBQt5fbn8U7O0hhbLP3V67q7QyyIyGEE8XufAAhzqXe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGf/rPUzugBakjq1+03DSTyJAWThaVXG4mhF327T/zAMbRieoJ
	XPVuEMclMGthFvozMFYBndXvIgT7qh8sCg2PJDUQZgIC6b3WJ9GXp6D5
X-Gm-Gg: ASbGncsQLIOpTDkynxqhhCdAdOnq5M8ywsy/9wKfL2WTIFURvbnEF4vsVF3rzvKzjIN
	pIJBoK+h06I7ZWJdBp3vMSalFWFq62dH858ATPPn0EuamZWPtjpUMD9uWMHw9k5LjG/G2Nry7LF
	sZ891k4vm1vlWMwptkViFCjCHf6RMb4yU5S8SdPxEliGpBwgHxGoyQ5mPmIvFw1HPbjnwHN8x+c
	TcF1vlsATCLRD51ZOxRohHVbL4IRCRlpQh5yy5ENT0TnERzjZC3I4QJsSJdkJFBS1Ahx0mXespZ
	rTymB15fsBBsr5HtXdP8NzrTht5mm8DixPxWpa/i08pxyXmjQ+4hnVTNlOJzMlarjehKfED3XSN
	e1Huq0otdhFcNTyhTXnbSROMGKyKJ9Jugbaiqj6L55X54NVf4B3thoZ8QMKk/+cGU8wx3IwPre9
	5F
X-Google-Smtp-Source: AGHT+IHedC3YBd3mNdu/x3X90rihqMDOwMkjxpWjQauHWNlEUd+pwjBHWdZ7nliOva0Cam4Ln1GSZA==
X-Received: by 2002:a05:6000:40d9:b0:3b8:d08c:cde5 with SMTP id ffacd0b85a97d-3b8d94ca07amr6709325f8f.43.1754299689480;
        Mon, 04 Aug 2025 02:28:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4d02sm14627898f8f.33.2025.08.04.02.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 02:28:09 -0700 (PDT)
Message-ID: <9544a669-3e3a-492f-a312-748b5d49bec3@gmail.com>
Date: Mon, 4 Aug 2025 10:28:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][RFC PATCH v4 3/5] builtin/refs: add list subcommand
To: Junio C Hamano <gitster@pobox.com>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org, ps@pks.im,
 shejialuo@gmail.com, karthik.188@gmail.com, sunshine@sunshineco.com,
 John Cai <johncai86@gmail.com>
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-4-meetsoni3017@gmail.com>
 <2d2f823d-6e85-44a0-85d2-d45d4dc287fc@gmail.com> <xmqqseibm7ap.fsf@gitster.g>
 <c4d9b25a-2a62-41bf-90e6-455c62b03aa3@gmail.com> <xmqqwm7nklqf.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqwm7nklqf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2025 18:14, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> It is confusing that refs/heads does a prefix match but refs/heads/m
>> does not (unless there is a hierarchy boundary after the m).
> 
> And refs/hea would not show branches, for the same reason.  It is
> what "anchored at hierarchy boundary" in the message you are
> responding to means.  In other words, it is not a simple textual
> prefix match.

The last sentence sums up why I find it confusing - it is not possible 
to tell from the pattern what sort of match will be returned. If a 
script wants to query some property of a ref it either has to know it 
exists (which is racy but probably not a practical problem most of the 
time) or it has to include %(refname) in the format argument and check 
that it matches the ref in the query string. A script can force a prefix 
match by adding a trailing slash but there is no way to force an exact 
match.

Thanks

Phillip
