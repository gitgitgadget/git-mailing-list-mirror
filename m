Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE0333ADB0
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769789176; cv=none; b=hi1Rpk0FL67Rq/Az0b9uADOQ9twNG8bpuQkJc+dQX26fPCDJ3d3ZfqyyB0ecAWuDndnsNXoMzzNcujcmkyBbZ3LcBDNBkj5J68PFSmf8gxb+bGInwFKET6arNsLQCGsk80hOvTuDYnOL0jVKDHsb3jd89hdus0fEbCOUi2N+hYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769789176; c=relaxed/simple;
	bh=vKdKbR+vqVt5p6D7QVzI7I+JXJ9KLgen9UpjX78gP8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l91atGp+6ti3X3360Fb9clWZj9v8FfFcBaKVMeMfzRM83gZnnhFpPNlYLGZS1QhN6af1C4kmyo6g13nkbQ7B5SLDmLpbDlAwNc40kDspixbFOiTTAP/LpTpUOg9cm/Y+U0u+qhfGYRG/q41tXqX25EmTNVJLLzpxigHpJZZmjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kt6nL7ZP; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt6nL7ZP"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso20481445e9.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 08:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769789173; x=1770393973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H3/rUYDQDvr9UeeMtn1MyZFZQglQYhuoOu8FVnUwHxU=;
        b=Kt6nL7ZP7QW75eWuK0twr+NS+JxC2wmhvj/BXSDPxTCRtLGTOZRJau3AcWTu8wpIk8
         +Szwpnf0/XXgXxOtD6P7Y9prA/Gtr8DJ/Ju58ttvAi+aCz3NU13hmCdPDviVfErRbC9x
         1Qy/IdqcBGU+fTrISV3vFbN1YpWuCITQdHBiGI9U0dw75fGXtVoTbBN3YE/DzRu5+La2
         ZASANYadVmhJmyOt/s40s0d60O8s6GcLnk3xhbmp0hrxlgXPUdJwHCkIt+OR2QYAp3Og
         g51u8CiHcH39w09YE8LI4ScaQZJnlNCdN0vb1sdQQSnDlzpRpLG7HU/dW3C5j0GoSZ5t
         z88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769789173; x=1770393973;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3/rUYDQDvr9UeeMtn1MyZFZQglQYhuoOu8FVnUwHxU=;
        b=c0ckQjCFzFUEpJKCKhEP+Y1BmcRFyU1n9AiDnSuEUsVy0QhHeMdPV6duTgWF7q4rn/
         fHOlGMxVPY1pPn+oiNhWw22Mb6GN7Iquo3jx3M7EUM4Vm3VMZeCQXhOnPdkvPh/kKBg4
         c/4GGh9JWmpb6CbrzmcuTH8ozQjjqYySMl0FNNs6QqukNxcpJFQwTxf+E3iVKjX+00eZ
         fMnGOhMiA4X2flVqnZQH3NYHkSDfRGMnaI9JCCh14YECRQS+IGdDXVSL38KOQGOderc7
         6FNoUZGIY12DX5Semo6r4NDjqNC8n+5vxe1yGuGAqvcM+vkaw/VzPPvOAG/FkU1g+H78
         3TGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO75zj4LqnyihubwFA/qsSmm1Ux0MfqgciqUvoA8WFqaL5T2T2W7LcMrguN6ZvCizDPz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpKj4Kn12u34YYaglawiKqz5IaS1ATX09K9HaWnAiz16Tl8uf
	j4O70go8jHPGlxcmbLHYNCvaacnqGQtTfoD9NCOMbG3DuHXXnoGlTWoY
X-Gm-Gg: AZuq6aLvC8zugzJZcc3QcR2Dz4RFyah+36M8QcsmpA28lR/wPl8kYqDmNSkgHYL+luQ
	qWLilI50+vwAB48u+vGhkG5V/0mkiZABlu2+DUUZAtrXsdojoe6XrbajlAtgCZjIt78G0EpDjx+
	yO0Jc3bszTaDOrJHIQsLFes6yl7EesT7oSPKJgmfPHTtLXx9JOK3sS6IlIu3LSMfA65WLpLNOdn
	My+x6R33leEImb3Pl6u5qgZQcVDFe+9wORRJq0rFL/583wHHbQCEQV15TZ7CslgLnBFKd7UHMR4
	OEUY/tQ3EugfYO1UW00Ss/WtY6oiAgLR8xbRMQQRYEc/aKDYlgh6H+hOkIUnjIL1/mRPhMMdmNL
	qkZYVVwh5hV7Gk3kU561mS2Vb/xidkknJasRUysE1/oqHnwQ/KyIV3rjv0cFqMpEG2XkVF3QYMQ
	RBvxOrURFrZQ5mpqCBktgNKEYb+SBNldCHSw+Qljjz0ktfoNlGKtUhNLgVcYraMJ3N/w==
X-Received: by 2002:a05:600c:8b52:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-482db476c30mr42473195e9.9.1769789173172;
        Fri, 30 Jan 2026 08:06:13 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e047e644sm19119515e9.2.2026.01.30.08.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 08:06:12 -0800 (PST)
Message-ID: <b66b8781-a826-44e0-9a2b-2c3a57547f06@gmail.com>
Date: Fri, 30 Jan 2026 16:06:10 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] xdiff: re-diff shifted change groups when using histogram
 algorithm
To: Yee Cheng Chin <ychin.git@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Yee Cheng Chin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
 <xmqqikcusn8p.fsf@gitster.g> <4fa413ae-f2a4-4de2-a2fb-0b1db379750b@gmail.com>
 <xmqqy0llk33y.fsf@gitster.g> <3aeb49dd-8618-42e0-b9f9-6a4fb8065793@gmail.com>
 <xmqq343sjn4x.fsf@gitster.g>
 <CAHTeOx8SOZmqvi0pkcheSjFpbEALmOwaUiX0tKLmNP7fqvjMXA@mail.gmail.com>
 <xmqqsebo9lv6.fsf@gitster.g>
 <CAHTeOx-TLwqbcdGcb2drD4vE6D3M93EPMjcAeTNR+XNTbmTVZg@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAHTeOx-TLwqbcdGcb2drD4vE6D3M93EPMjcAeTNR+XNTbmTVZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/01/2026 01:58, Yee Cheng Chin wrote:
> 
> Case #1 happens when no *remaining* shifting was necessary, but note
> that this happens after the do/while loop above, where previous loops
> could have shifted and compacted the diff blocks already. Case #2 just
> means there's some remaining clean up work to be done.

That's a good point - as well as commenting the new code, it would be 
helpful to update the comment in case #1 to make it clear that we don't 
need to shift back up to align with a matching block, not there there 
was no shift possible. I agree with Junio that it would be useful to add 
the example below as a test

Thanks

Phillip

> Just for a concrete test case that will illustrate this in case
> someone is running the code and want a demonstration:
> 
> File 1:
> AXB*
> 
> File 2:
> CD*XE*
> 
> The first "*" is used as the histogram alignment anchor, which will be
> shifted resulting in a compaction, and therefore needs to trigger a
> re-diff. The correct output is as follows (which will only happen if
> we also run the re-diff in case #1):
> 
> {-A-}[+CD*+]X{-B-}[+E+]*
> 
> Otherwise we will get the wrong output (note how the "X" is
> erroneuously included on both sides):
> 
> {-AXB-}[+CD*XE+]*
> 
> Because of that, I'm leaning on keeping the current code structure,
> because it *is* indeed a cleanup step to be run after the previous
> one. I could still refactor it into a separate function and put it
> into the the case #1/#2 if blocks if you think that's cleaner.
> 
> I will also add the above to the test case in v2.
> 

