Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D0D10A05
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708571082; cv=none; b=upti79n0heGNuCdYiDuHXca25H6shi1R7eAQyAynPZJBeLVPyvvUVLBxZEecmuxe8UwoHVx3xM1WI78xlpf2GWzw/RU5ewTFivrstx7jls6wKEHOA+7Kn9sN+UtLEsLCEQLvz5njVad4n2rSuORCxjr8ECHhHRF9k1UcEYMIFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708571082; c=relaxed/simple;
	bh=ZL9rGrmLbMSnk+9Vms+aPa0uLaTXn7mKfNsmF+015zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNiKhG1L3LMOPrJHQLZnBWgut5fTKN7r8m08F/uPSBJ0WqD81ph7pX2QVsnSFg/RPZB1tc38pQqJQ6xL70Ocjos6LfaodIY8lZbiPVA8qgKSCRtfpy0J0PEtk8ZmpaS2F9ScaS0bAV9nXzGQJ0eDTmJD2ZaXx7aOQfD3vdlmmRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAX7FE7l; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAX7FE7l"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c132695f1bso5600752b6e.2
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 19:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708571079; x=1709175879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XW6fDGRb+l2fiv0a57IRA2qKEcdy5V5Ksd97jT2HHV0=;
        b=eAX7FE7l4UCEdhfA9XInva4dXvXThmjzxhuUv8N7+/bZ2aNWZnh/mcztIWGpg+0J4a
         sA41ZgTvXCH4l8yHMwVIGVkZ8Y08vnUOfk5S4L+6GWlUt+Imc87iK6a2Af8TMdEtRk91
         /D9DQxTWk/AEay8UIMkFeOLmbBVfS9odD8JEj3+lExVyuXE3czkVhcy9RVfbqDmJk+nw
         CVnyT1oqnaW2wpxuiMk+ovKaJ4xP4oXM7dOZIvWh3evmmPhDBV4b2YTYBq1YhXftK8ZD
         UvCwhc/Dmie1kMMGBVhxbKvoTRp26d5ZR/9g+ixQFI1rq4oFAfd4kCEDZh2feVnzTmXY
         /ETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708571079; x=1709175879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XW6fDGRb+l2fiv0a57IRA2qKEcdy5V5Ksd97jT2HHV0=;
        b=RDL0NpSSd9v2748JRv+0op7F2d2DuthIK/44bM8/4j4CQNsw5ErpH7gNkyU+MRzfVd
         QRqF8NfNfxbUgJuhY2rr6+5ND4rPom0cFg9uMml7C9hUUf3M1bPGtiXOIBcR0QQglvPR
         oAdwZi/s/muVbHoMiJJ7ErJDEV7glQHe1CJqLpsRDODUVrkd8HHMD9xyBxnFXMsCbx9s
         2PkL3c597h/tLze0iNAKUjPSKn/zxBktKYQzxj/Gk/ibRoKn48yASOu/UfW/tLowKz/e
         jxXjXTgrW9UwZ3mkk6B7MJ00E1UedjpQACrdfMtQf7SjX2WBjdpFhRQFIOojDPbkmUHm
         hIVA==
X-Gm-Message-State: AOJu0Yz7UtgZ05snjRbRbwhz0/Gzn4+ZHjZOMtQeTGhv63v++4vbx78k
	XinbHuzwupOkYO9uXjcXl61WSGNNVKZ3dwLOy9yi8icno4OxbsAo
X-Google-Smtp-Source: AGHT+IHoedaQRCnrayhBUbkgQT2mMuWVB7qQSY8vI3tn+Or32/7kRAcmTiodxjr/RsS+OKe6F1hGSg==
X-Received: by 2002:a05:6358:722:b0:17b:6e2c:524a with SMTP id e34-20020a056358072200b0017b6e2c524amr477422rwj.27.1708571079562;
        Wed, 21 Feb 2024 19:04:39 -0800 (PST)
Received: from [192.168.1.205] (216-71-219-11.dyn.novuscom.net. [216.71.219.11])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b001db2ff16acasm9109936plk.128.2024.02.21.19.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 19:04:39 -0800 (PST)
Message-ID: <5a857e76-659d-4d94-ae54-f5c22c9917c6@gmail.com>
Date: Wed, 21 Feb 2024 19:04:38 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add unix domain socket support to HTTP transport.
Content-Language: en-US
To: Eric Wong <e@80x24.org>,
 Leslie Cheng via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Leslie Cheng <leslie@lc.fyi>
References: <pull.1681.git.git.1708506863243.gitgitgadget@gmail.com>
 <20240221220945.M686016@dcvr>
From: Leslie Cheng <leslie.cheng5@gmail.com>
In-Reply-To: <20240221220945.M686016@dcvr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> No need for trailing `.' in commit message titles

Will fix in the next patch, sorry!


> Personally, I'd hoist the #ifdef part into a standalone function
> since I find mixing CPP and C conditionals confusing.
> 
> disclaimer: I'm an easily confused person and don't usually
> program in C, though.

I considered extracting it out, but the other conditionals in this 
function follow a similar pattern so I didn't want to change it. 
However, my use here is also the first time there's both an #ifdef and 
nested #ifndef, which I agree makes it a bit confusing to grok.

I'm open to changing it, but I'll let it sit and marinate for a bit.


> `nc' isn't widely installed, its supported flags vary between
> implementations, and our test suite doesn't currently use it.
> I suggest either using a small bit of Perl or writing a t/helper
> program to do its job.
> 
> Finally, hard tabs should be used for indentation throughout.
> 
> I'll wait on others to comment since I haven't looked at git
> hacking in a while.
> 
> Anyways, I think this feature could be useful for me, too :>
> Thanks.

Good catch, I'll fix in the next patch. I've subbed `nc` out for a 
simple Perl script to pipe back and forth, just making sure CI is happy 
about this before submitting.
