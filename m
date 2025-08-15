Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51238308F1C
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273100; cv=none; b=Fve1nD2njC+v7Dq2xKmpoOJNl0XK6ndMDOjyhs8CY8I+8Igd/0ZaThM1Rm/LVYrm5oFaolcg2cvx0B8AbjnZ1934FjmHqSvqjCbrlg3FDQdy+YWaBHWbQnMj9NRiCbX2vz3F3W+73pa06QFKH9QKKTm2SH+4/aY5fCjHjPa678w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273100; c=relaxed/simple;
	bh=W3FLrw+a2kemXFYyefpyCzDNs52oHAq5HjFjgnX2tAA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dkUFBXVQmrsfuAiCzhwfyL3lYnLxjpg/eG0cnYmo1Aeo8CfTYYdXfYcGng4zs9tieA7vDFqwBxWKAdKqpiYr8jKjtqoowUQZtFRIVeIsBREED88LNSgERpFbvLsfO+XsYlnsyich9HNMxLiCJb3SLbOOPOEGko+3n/BbtD1yGQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzVXK7uX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzVXK7uX"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9d41d2a5cso1747638f8f.0
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 08:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755273097; x=1755877897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OvzmD9jgMF3EZ1XKLPtGN2wum9ZnGn1BKTllZxaG/J8=;
        b=YzVXK7uXNH5V3MqJsHF+Ax6p8DGP0LTLuV3OjVTt9+QvgwZ1wmvlcRE+00gVIjuWIf
         2W7TFgIvE8eKak8DecJXy9YKwB5zS8BqtXF6P4wkf8OhHW//CGimSmEKzVnlywUmFL2k
         3XwfBljgy4zXbX0Jco12GTOD/8FMOkpNmewmMA3B2HQDIbiRvEp+5ANaxiC208jKsdCs
         ggEylVKkF5zXegNbToGCNVhMZmNxb8a6CyAzB8cOMwF04ySjiY2adlQRafBs07c4NHcB
         otqE70ARb4ujjbUobnby5OX+lZHMhnFAvV1NpoNih4nwJPm/VDPHRQYRQyt59XXhjcQo
         1eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755273097; x=1755877897;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvzmD9jgMF3EZ1XKLPtGN2wum9ZnGn1BKTllZxaG/J8=;
        b=ImXCOIDlIBBkAE5+7gTBxBCMLNDHospvuVkh8eN3WONTInMK+SwDECnqReqSFzZ+WB
         f8CIH4GQWGu9ENYtKn2H1H02LCrJgEueqPB/o3wfoRQM5ub2KyZ5lVbMlVqp6fJpGjLy
         F1P1q8y426y8AJqTHJ4t2Q+KIc9lgzTeXp05cFOoFC9zSUzXPeeSbhPc5AxW0HI4bGT5
         RhzPiPWsUqA3cUv5Qbj0YDYLzglO20hGlBfZhKnzzeEzXe8EeslliD4f+dMdxKjZqByE
         Rlz7DL2ia/6qQ7k+HwwYaiksCzWzkb2gOI24Q37iygfnZh4QZzAIej0v5tqHFV8C9l4n
         qIUA==
X-Forwarded-Encrypted: i=1; AJvYcCU2+pVkQY2rMvNSPB4pU9JytmqP3d4n/hZlgwItFbtACiDcgrINnaViIMKVMmttOL5yfMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+fpFOlaDQmXaBZxrambmGM2+h1z41A5aSsV8D8Kfbwda0KDLZ
	IgWJd9B9eY3uBjAegykwsRbacDC1FetFypFETDM1twKxZTGLbwZfN0nccI5L/w==
X-Gm-Gg: ASbGncvETVltUsxlwMxM//tM1qQ5JJH21WXCICRH7GxUlUxy7F2nB6uJ/I+bAjkMxhn
	KjxSK8+NK5RkbFITYj6K5+jL2FEzkoukD+0INXtQybbiGxy0BS8Uj854ufHRRtLv+bADmsD5hsw
	Zhe8qBp0xwyljMCMvRcEorkBx6wJQ8wAFd+KUUjyXrbzjkCIIpRJar2JixWGIc3Hd+fwQ4mlr6M
	UUDGl55bsfxhdyd0CRdc/63AEJYiNwG86WydqRolj8hk4jbGrpY2rcVy39Osk6P4ymBq9E5LuMM
	iMnbK8HkXdHEgV9ukXr+bnf0qDvmrM8zqBMnHMKsvCGfmDBn4BDzESzAzGvElgPK8537cr8y74y
	QsvIccHwQ4qsD0f4faGFMfPCadtv44IxouJ9aZep3Uqwh+SiSFgB8MOXDKZnhgkd9uCQziZgY6q
	fXIBqnRnsCqks=
X-Google-Smtp-Source: AGHT+IF3poOVVk7QL3pcUpMKsYwOEbW2VrGv5wzWPAVmiRMQoXWT32a2Av/+tA9o1585xWMO5R5iCg==
X-Received: by 2002:a5d:64e5:0:b0:3b7:8f50:f469 with SMTP id ffacd0b85a97d-3bb6675329dmr2192268f8f.1.1755273097160;
        Fri, 15 Aug 2025 08:51:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb656dbec5sm2362522f8f.31.2025.08.15.08.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 08:51:36 -0700 (PDT)
Message-ID: <101c0157-a542-48e3-941d-d4c84fe2efc1@gmail.com>
Date: Fri, 15 Aug 2025 16:51:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-jump: make `diff` work with filenames containing
 spaces
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Greg Hurrell via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Greg Hurrell <greg.hurrell@datadoghq.com>
References: <pull.1950.git.1754674979929.gitgitgadget@gmail.com>
 <CALnO6CDnSXpUVQEUJr=dc1ZY6errSv2M=4EmeaOmfDvcifHvnA@mail.gmail.com>
 <cc90fefd-9234-4fb7-a00e-96c4004ddace@gmail.com>
 <3f9eb0ed-576d-451a-93db-9b9508c99c27@gmail.com>
 <20250814231402.GA2937@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20250814231402.GA2937@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 15/08/2025 00:14, Jeff King wrote:
> On Sun, Aug 10, 2025 at 02:20:13PM +0100, Phillip Wood wrote:
>> On 10/08/2025 11:09, Phillip Wood wrote:
>> 
>> When I wrote earlier I forgot that git quotes filenames with control
>> characters. If a name contains a tab it it quoted and so cases 2 and 3 will
>> be quoted and so there is no ambiguity when trimming a literal tab character
>> from the end. I haven't checked but I suspect git-jump does not handle
>> quoted filenames, if we wanted to add support it should be pretty easy as
>> Git.pm has a function to do the unquoting for us.
> 
> Yeah, git-jump does not do any unquoting at all. Ironically I used the
> "+++" line because I wanted to avoid quoting and whitespace headaches on
> the "diff --git" line. But I guess it is unavoidable for truly weird
> path names. ;)
> 
> I'd prefer to avoid an extra dependency on Git.pm and just leave it
> broken for quoted names. Since names with spaces are the likely thing to
> see, and those aren't quoted, I think running into this should be pretty
> rare (another alternative is to lazy-load Git.pm only when necessary,
> since we're already in a perl script).

I agree there's no pressing need to handle quoted names.

Thanks

Phillip

