Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7CC339AE
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVR7KIDl"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3364b049467so623347f8f.1
        for <git@vger.kernel.org>; Fri, 15 Dec 2023 06:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702651598; x=1703256398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sorMhbAixFW7Zcs5Q3QgO7psk1rR/yT0T2RXmnZNzAA=;
        b=ZVR7KIDlaF1swVTm311agyDFGYHTWh1HFsjmtdqzf1B1jB1TtShuy3y9p7FW3Whbuq
         NNlFxD0D9pBWH7ZWCbcRH1+HOefMlKdyaMI4zGSieAvLeEo3K+jnxJPXHP1SZg5NNaFG
         l85DET+neFEVCoKHlP27WmN45ie+w0Y4HmZzbWyn1zDUdn+oRh3RF45LupyvNIucQvua
         Hgl70KZOFPwhAQHQ2qczKc3R6QATx2R4U3/Xq+XD9Y45oVOSsaFyN7YPfKE/mKYGkmlh
         zeNc1w11ixxC8cDD5D8NDX0jZEtrwec4NTK3gz7SJYBpCJtKKnUwmEcevsU8rZFEgJgV
         Tf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702651598; x=1703256398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sorMhbAixFW7Zcs5Q3QgO7psk1rR/yT0T2RXmnZNzAA=;
        b=Zx7A3wXqZePxuTx/hbegWF16rOOZ8LiNno2s3MZkFq700/aJVCaZ1+QNiF3n8WK7NJ
         4L6lPrcbZ8EZgsrL1m9ZtER7bJMGn9tEUWTjJa0SWS/VjCVWQsh4WPKOFYjuBC66Rwcy
         SNAzQUOGxr4ldoS6rYCYK95+X2Gd6v+aLy065aY0NHSJP5oswqAY2ok0TiSqnH4xXB7d
         TjHdIk77y/JCbEfEMGqbZl+mnvCIgplxpY7OLcTaZMgodB6cYI20oU1JecKkf7kucanZ
         jA895jTzkCSTu/QMncn8QC8RjsnSwTAsXw/kVGNJ07hdDLdtvPDV9cI6J9MunJESkZ+0
         T4RA==
X-Gm-Message-State: AOJu0YyNdVPBc9HmrBLRCnxal1LND60KoNTBQa2UBVcbX6AfdUG+78Wk
	XwP3CecaXERDLHXHpGQy8GI=
X-Google-Smtp-Source: AGHT+IE7mu0leEvILNf61NM1IAH0ks4yDpxOud8jPpOWMIrlIzNdlpQ4NUzL4vev7rwyJyZY/01ztw==
X-Received: by 2002:a5d:4a50:0:b0:336:4b3e:e0bc with SMTP id v16-20020a5d4a50000000b003364b3ee0bcmr1399614wrs.27.1702651597698;
        Fri, 15 Dec 2023 06:46:37 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b00333381c6e12sm18985892wrt.40.2023.12.15.06.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 06:46:37 -0800 (PST)
Message-ID: <99b3a727-36fd-4fa5-a6be-60ae6fc5911e@gmail.com>
Date: Fri, 15 Dec 2023 14:46:36 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] Use ^=1 to toggle between 0 and 1
Content-Language: en-US
To: Jeff King <peff@peff.net>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: AtariDreams via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
 <20231212200920.GC1127366@coredump.intra.peff.net>
 <8bea38fe-38a3-412a-b189-541a6596d623@web.de>
 <20231213080143.GA1684525@coredump.intra.peff.net>
 <4d0b2a5f-305b-4350-b164-44923cb250d8@web.de>
 <20231214220503.GA3320432@coredump.intra.peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20231214220503.GA3320432@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/12/2023 22:05, Jeff King wrote:
> On Thu, Dec 14, 2023 at 02:08:31PM +0100, René Scharfe wrote:
> 
>>> I don't even know that we'd need much of a weather-balloon patch. I
>>> think it would be valid to do:
>>>
>>>    #ifndef bool
>>>    #define bool int
>>>
>>> to handle pre-C99 compilers (if there even are any these days). Of
>>> course we probably need some conditional magic to try to "#include
>>> <stdbool.h>" for the actual C99. I guess we could assume C99 by default
>>> and then add NO_STDBOOL as an escape hatch if anybody complains.
>>
>> The semantics are slightly different in edge cases, so that fallback
>> would not be fully watertight.  E.g. consider:
>>
>>     bool b(bool cond) {return cond == true;}
>>     bool b2(void) {return b(2);}

Thanks for bring this up René, I had similar concerns when I saw the 
suggestion of using "int" as a fallback.

> Yeah. b2() is wrong for passing "2" to a bool.

I think it depends what you mean by "wrong" §6.3.1.2 of standard is 
quite clear that when any non-zero scalar value is converted to _Bool 
the result is "1"

> I assumed that the
> compiler would warn of that (at least for people on modern C99
> compilers, not the fallback code), but it doesn't seem to. It's been a
> long time since I've worked on a code base that made us of "bool", but I
> guess that idea is that silently coercing a non-zero int to a bool is
> reasonable in many cases (e.g., "bool found_foo = count_foos()").

I guess it is also consistent with the way "if" and "while" consider a 
non-zero scalar value to be "true".

> I guess one could argue that b() is also sub-optimal, as it should just
> say "return cond" or "return !cond" rather than explicitly comparing to
> true/false. But I won't be surprised if it happens from time to time.

Even if it unlikely that we would directly compare a boolean variable to 
"true" or "false" it is certainly conceivable that we'd compare two 
boolean variables directly. For the integer fallback to be safe we'd 
need to write

	if (!cond_a == !cond_b)

rather than

	if (cond_a == cond_b)

>> A coding rule to not compare bools could mitigate that.  Or a rule to
>> only use the values true and false in bool context and to only use
>> logical operators on them.
> 
> That seems more complex than we want if our goal is just supporting
> legacy systems that may or may not even exist. Given your example, I'd
> be more inclined to just do a weather-balloon adding <stdbool.h> to
> git-compat-util.h, and using "bool" in a single spot in the code. If
> nobody screams after a few releases, we can consider it OK. If they do,
> it's a trivial patch to convert back.

A weather-balloon seems like the safest route forward. We have been 
requiring C99 for two years now [1], hopefully there aren't any 
compilers out that claim to support C99 but don't provide "<stdbool.h>" 
(I did check online and the compiler on NonStop does support _Bool).

Best Wishes

Phillip

[1] 7bc341e21b (git-compat-util: add a test balloon for C99 support, 
2021-12-01)
