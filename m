Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694C03D9DD4
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403355; cv=none; b=TCvlTt0jq43MBq/41m1VoLF/qDo9krsjaQLYL/+wUGRTPMQWz4WbjbrtOvbyHyd2wK/7aMUvbXD10v8ZXZKnQ4n7hQJNH2JSSqC2imjg3CZFPVO5CP6XAoEWp0Wawlu+r+qMB3Ulr3r26/D4ny4Xn8LVbizGqeF8O6czrvhKSEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403355; c=relaxed/simple;
	bh=FHb09Oe6l5ZXrkEQd9XAbs3UAtOWRiDpkNkSgSV1bJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G8sORGWa2dy6py/mVfW1bxFH2TJ5bCpONXTYGMwcKDmX3M0rYoeNbccOTZ6qfcCjehpyQbK4byue2fGU7a0+WYLF62Csa64CnOamZtyrjXLbPl5aL0KtbrPtiB5aEc4IN9lGaKCJE/AwFwtHkj7Wg0VJGwEoUBBW737Y7q4fzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReLOiRwz; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReLOiRwz"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9154ca1aa1dso315668185a.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 05:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780403353; x=1781008153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ujlcdB+khHuNOf5xrWL3cHrL1VQ3jlCO+n+SMa+zlRQ=;
        b=ReLOiRwzJLsbWLIKID1K0Q7QG6OVdDstmut5EeFK0TYDXHxHnX/PAyz2rPPKD+dyvE
         4RR0QJ6eKwjdUPr5GSl0dSQZzGVqg+WN66W7vb8cnrNzE5ygidTz7LCe6YNrhEUDDTM2
         cEBiBxh5i3oKwgw919gZMYyvtHCuIPv6wlUf/LtJ49GqCTbsIbChdR32VyrthZsF1Hxx
         Zl3xupuHHP81LIZ/xQ+1Hyzo9RzABklpMmmDB+CT67f7Izjo+BZwuvuZO8l0cqsL1cLa
         vWPJM6tDKzCAuT8x3Xhda9vMpb/qwa+pr+0otFZynwq+MJmzr/43kb/PdQuMU5crvvp4
         qqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780403353; x=1781008153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujlcdB+khHuNOf5xrWL3cHrL1VQ3jlCO+n+SMa+zlRQ=;
        b=M6cI+zxrgQ0GMUF9Iwx9X3X6QYRBQR9euVboGhzeHk6nYV6Qfqp5IGMbYdhgpoCaWY
         Lt+pTbz2hRvIGUJyuuWCNel8wdQaciWkxIrffOda54j2hMCjfv4k4Vp0fdL5qR6aoyWK
         NTbtehIT4I0jumlVnzISnfg59E9BWHg7IdgoLLsRTqPdttaMzmrIrV+Wd3Z6G1nuha/W
         YEv5Ll6dtDO1laUAxwuhx+IBdDLjiJARAqJt9H0+pQD/EwsJ0BBwXDFxt5q0pMJYlc3e
         Vx3xKni1ST4cGTPo3w8Zb0fi7+QrrEbHpmVrJ0jRQhfT37JoTyk7vjNssPmqGfapzGsT
         bsFw==
X-Forwarded-Encrypted: i=1; AFNElJ/9ek4mddVX+Id1RmyR4oW57WByF9G+Dd0nmIJNozyDInbpCBnYl/UetyXZoPC0HQHUS+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDZC3RlZjsTiA2wCkeiyfa0B73ZQisSpwfRdK3h/BKPVZ6erXh
	qCYp+MUmLWJNZWVXionOSWs0q/0JPcLQ5MEo/B+y/mInkki+SpW4723wsmgO1Q==
X-Gm-Gg: Acq92OFLBxZx0k9yutq/WxtoVTyDlyuTgt57nhBuhCNs5Dr7QRKHzAhjfnEm28YCekb
	J0CguKAhVxSf3Jj2jvmBaaUt3ZuSpgGu47oi/UwkmPZKogFo7BvldXOfXT0ccCfiN22t3VpkZRM
	n948NlXsc/llDZfFIuWtPqKsq6cBH86kSGcz9IbRUYF1FSGlqKP8qBXvIVD3YfRtOAoDbkTuooE
	99ODnQuS8QZL0Up0Vsu16MdPkGB1OosNcy7G4FDIpLkROqghLIl2Q85q35FdXghmfK6lchwBgkJ
	jPVKsmaXE/PUjGPjCinwdGoXxdQTZ26kbs1f/jEANY+gIddwvPg3hVMkAHbldYKiEWRfxbfR/rK
	uy7Zugx7tvYPV7rERHXRllaFexjFN63LqRUhTpeETRR9IQ9yIFefTvKAvR821IEToinpAHZ0R4Q
	UAVJuFMGGwleSN9XoJscCuJIAuTPzJ8drQ95QEkkzcJHaT3QDGX7a2PMISyQQWNl6FQMSgna22h
	dscACY2
X-Received: by 2002:a05:620a:934b:b0:911:e11e:dc0d with SMTP id af79cd13be357-91577f2fc73mr400277085a.24.1780403353239;
        Tue, 02 Jun 2026 05:29:13 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9157f054d30sm102142385a.47.2026.06.02.05.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 05:29:12 -0700 (PDT)
Message-ID: <fd588cff-be2b-4422-9c01-cef06b2ea5fd@gmail.com>
Date: Tue, 2 Jun 2026 08:29:11 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] SubmittingPatches: describe cover letter
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20260602090808.87837-1-gitster@pobox.com>
 <20260602090808.87837-3-gitster@pobox.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260602090808.87837-3-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/2026 5:08 AM, Junio C Hamano wrote:
> We talk about how a commit log message should look like, but do not
> give advice on writing the cover letter to sell a series to widest
> possible audience.

This is a good thing to boost in the documentation.

> +[[cover-letter]]
> +=== Cover Letter
> +
> +The purpose of your cover letter is to sell your changes, explain what
> +they are about, and get your target audience interested enough to read
> +the patches.
> +
> +. Make sure your target audience can understand what the patches are
> +  about and why they are needed without prior context.

The thing that I like to say about the cover letter is that this is
your opportunity to communicate why the value of your change is worth
the risk of regressions and the cost of maintenance. Perhaps:

. Every code change comes with risk of regression and maintenance cost.
  The cover letter should clearly communicate why the value of your
  proposed change is worth applying. You can also describe how the risk
  is reduced by the design choices you made while writing the patches.

Or something similar may be helpful? I may just be over explaining.

> +. For a second or subsequent iteration of the same topic, make sure
> +  people who missed the earlier discussion can still understand what
> +  the patches are about, so they can judge if the topic is worth their
> +  time to read and comment on.
> +
> +. To help those who are familiar with earlier iterations, give a
> +  summary of changes since the previous rounds.
I find these updates to be particularly helpful, even for GitGitGadget
PRs that include a range-diff automatically. It's good to double-check
the human description of the update against the computed diff.

Thanks,
-Stolee
