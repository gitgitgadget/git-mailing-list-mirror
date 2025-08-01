Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD872199920
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 04:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754021101; cv=none; b=tbLavWAXW8w6GghhUELAvhblSlVthKm7r7KEX6AHRNpc7+gro/LUnPk+2B8Wa11l3HGkyxI5oKYRyfAdhQVMrZd32KFhwd/VnIWb3sPcUI3N3rw4n7/jZx8Zulm2PyqOA4U/IfO5ZvpMwKMu0rNLlixGdY/FwppS1e/j98AMDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754021101; c=relaxed/simple;
	bh=EiCdZm0nPEqAGl0wJakUAJz4bpcNl7i15RYPEfFOWww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbWlG1DuZUf/H8MwbKTEgdPcjbeGBk3aBEPThxwNMCI7nax4exLRmXDxiyOgCCiB1/FWIiVQXcPCAl2u3X9stN0bOFuqL9B6lnppJR01LD+kZwFRSeV9uIOjMjtbExVkmJ63QfBH3VU+DmljU56sUHl4rXlSfNTq0EeUrXS+lg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjusbWxf; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjusbWxf"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b422b31b1c0so818864a12.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 21:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754021099; x=1754625899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFujVh/N6UoZojkajEE3OWgYP4jmAIHFt93QYLRnO/g=;
        b=NjusbWxfpPFyFFFcsvLW7xYspjxmhg6Uyl9ax5R6bZ2qkhzmu4rpcwHeqnodn6nfca
         pBL2MLHsKJsd1UClzb6QHCPXmv1RzWyhFl8QFlMysg2gfVk7PU99Au158r96rHct7Ntu
         hakUitqwPngMmfifSWs3uwXxLjSedeSA/91WMI7XsTAFAWqh1QI2TAT9pMPe/wFcQDFq
         8aALndTHiJugaEbpjJvz1xsHLYKogHOiyS0kzJDhLPHHktRGXBtjIuBRm1LL3IlttPDR
         LymFpGbZZ7kI7ogMmdGTHsfypbFLRqba8F8UtejeAin9/bFT3GaDf1e2TEE/OxlO6mWM
         Qf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754021099; x=1754625899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFujVh/N6UoZojkajEE3OWgYP4jmAIHFt93QYLRnO/g=;
        b=ZK1s41Ps4QGZftAYsks5QqaJ10EOfk63yzMXgV7wgZk6M7Fu4eJCiCtny5YSx7IjrM
         hSTmPSr4zN8mBtftnSFY4DPPe3NU6tTaz1JNSHgfmKeEdrMMePxxuv4mYhXXxKZISWcz
         dkdPuamiwTMMyPkTxHIP0DSmiU4jkC9BnX4XHwBxS2A4HPHodMFhzFt2DXcpFJMb3qwp
         oaPeDGp7PrpJgxrdNmk2TFGsnn+9YNptfzLYW7KEK4VZ17m0CTeqL/10wEIDelKxay5n
         vBtFPXByp53mM+2WG0FctChcyq2v2Qu+AWRD9TLJOFjyXf4mTaBDrF73FJmeTI1EjwpQ
         q3aA==
X-Gm-Message-State: AOJu0Yzqeg7OBlYew/awJa13wpIPY1pUfjsslqE1gSm8bQ4EdGaz7053
	fNx8fVUo/rW5pkwaPfZlPhG/GbVWbhQFtKHPaGkfeL/+5/BgiMD7qM2yGz+oXCjs
X-Gm-Gg: ASbGncsCaueEITB++TdtWHENbcY/pT07Cazer5YAYqWzvLOwhWY8I6ZMbdFczz5EjDC
	JZ7OXSHfg21TGPhRmkgtsamIX3d5V4GfwX30g3DQYoMWPsWSiBKYPTJkwOXhM6g21snvweaxEb+
	T4sFoG+32mmoDiVJqFOFUdbWoU60VbV45otUKk72cNdL/Gc6OIrKbCEOA+A6kHO6s4iLVz9a+is
	akR86O87VMNMCAprXqP0B8VLOwuhPExE8h+6iNtqFjGgDtvP/YwoOSyayNLXMxg/5MXoSLR6FQ2
	LzBZXeIBC+cEmSOaEkW6FO9ob5JKytKo5okVQEjxtUjwswgMREtgwEArnDKrmo/GudDtMaBx2WD
	piJ8xmq4ZcCLmszJiow==
X-Google-Smtp-Source: AGHT+IFXMTEAHFzM0op/7MAcDN6GqF2f/uglrUgWSOofYlR9Jk2g7f38nAA2BjcqcWaOYcN3wyghsw==
X-Received: by 2002:a17:903:1ca:b0:240:2145:e526 with SMTP id d9443c01a7336-24096a64289mr144519145ad.6.1754021098586;
        Thu, 31 Jul 2025 21:04:58 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241e8ac8ed4sm30782815ad.189.2025.07.31.21.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 21:04:57 -0700 (PDT)
Date: Fri, 1 Aug 2025 12:04:54 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] string-list: optionally trim string pieces split
 by string_list_split*()
Message-ID: <aIw85gIurfEhvuPC@mbp>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
 <20250731224607.3942417-5-gitster@pobox.com>
 <aIwyIJqEIdSdKINz@mbp>
 <xmqqcy9fog8x.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy9fog8x.fsf@gitster.g>

On Thu, Jul 31, 2025 at 08:47:10PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > On Thu, Jul 31, 2025 at 03:46:03PM -0700, Junio C Hamano wrote:
> >>  static int split_string(struct string_list *list, const char *string, const char *delim,
> >> -			int maxsplit, int in_place)
> >> +			int maxsplit, int in_place, unsigned flags)
> >>  {
> >>  	int count = 0;
> >>  	const char *p = string;
> >> @@ -320,12 +327,18 @@ static int split_string(struct string_list *list, const char *string, const char
> >>  	for (;;) {
> >>  		char *end;
> >>  
> >> +		if (flags & STRING_LIST_SPLIT_TRIM) {
> >> +			/* ltrim */
> >> +			while (*p && isspace(*p))
> >> +				p++;
> >> +		}
> >> +
> >>  		if (0 <= maxsplit && maxsplit <= count)
> >>  			end = NULL;
> >>  		else
> >>  			end = strpbrk(p, delim);
> >>  
> >
> > In `append_one`, we would tell whether `end` is NULL. I somehow feel
> > strange why we need to do that in `append_one`. Should we just set `end`
> > to be `p + strlen(p)` when `end` is NULL. And then we could do rtrim
> > inside this function instead of `append_one` to avoid passing "flags" to
> > `append_one`.
> 
> Sorry, but I do not see why such an alternative design is a better
> idea.  The helper function's purpose is to stuff the substring at
> [p..end), possibly after rtrimming, to the list.  You could compute
> rtrim in the caller, but that would make the logic here more complex
> (at least, you'd need to introduce yet another variable similar to
> "end" that points at the real tail of the string, and you cannot
> reuse "end" for it, because of the exit condition you see below).
> 

I agree with you that we would introduce another variable. However, the
thing I quite dislike is that we do ltrim inside the current function
and we do rtrim inside `append_one`.

My thinking is that we should handle the [p, end) string in the same
place. We could either decide to drop the string or change the string in
the same place. However, at now, the logic happens at two different
places, which is my concern.
