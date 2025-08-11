Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E023F40A
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917985; cv=none; b=V1EQQcEB+R2gyO/hIp1nJ2C8XK0OJD1GZDf67nbHOU0RO0c3hS7nMhQPc6t2bmQtNKXMsNSlGpaBENA4Rv+IF1TOkiPrC1/2yuQTUy4E9TZHSjLHDKZ6weNw1Vkv6uDmFgjxGlF5LSkXwIUF/0G1JyTmAXJnE2JhTu4oqouTiIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917985; c=relaxed/simple;
	bh=4GsZtCW/qse+bjFze+fscPVXV2IWGmh4IP7C1d3mMKM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mkxK5S518fH7ZNduubucYNhHiOLZaizfzeVAvPmUyXLWXb4pV8wdOob8pKcU7t1cZRvu5DFsIx+mygI7uvGydWwX229CPiPWx7sCO15TQbzXds+QMsePN2LkOUzBYVl2rFalBNrXM6Rp9kja6a9se4R7jrdKO5ZoZGYq6QMME+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6K6hMum; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6K6hMum"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b78a034f17so3350870f8f.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754917982; x=1755522782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wL6knrg9g7lzZk+swFJjw81WGIV/aiy4SFNdgRbVeQ=;
        b=L6K6hMumDBblb+rTbV9NaG4IeJS91ymlKn8wM2KXmm/gfeMxg/b4wAZYi4G+AFLjkM
         GZQlVzOXJRI8MuopfwxON88OS6h6lJqREb3C2eCAJ2JOV4FeLM8WCuX63d/xMUKewIO+
         MO173tHoFoeCDDnWxyd0qZam1tiLUl3MqI+ri7V/PQpc6bk5m2aRJGiiIIOWFq7TjT2A
         cPih1pgyivHRCDnbJCExakZvKwE43+KmXhJgkyiFtUVS+E9OP6Kd2EeoofI6BPyf+ISu
         jwQ7CdItVQmgSWOKoWiswEF3qAaKLb4m74+YZ65HkfqKKi5l1a00jfcCS3k0SeSLx0Z8
         iyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917982; x=1755522782;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wL6knrg9g7lzZk+swFJjw81WGIV/aiy4SFNdgRbVeQ=;
        b=jWJqZGV3H9ebeBQwwC8kfVG7nPjXLs0UCVcRsidMlnF77xEIs092rpFa/rKiqUu8h/
         Ck7YrUWkoRxn0+QkqJo6w8W2WGOGflknbPrcJxFMEQz7E4J2cpUG7Rejnm4Bkbvzen9Y
         wzF+m0Ubus6yzuTkW+F6ZfY7hcWitZ5p0iyS4O0mv5V71Ogm1Fj0lvK+TKEHZdk2dSHP
         RTkV/dXwlqfVl5gzb4vHfUJ+Xsftr41r0TWqmvyp787Ku/A8hIYsK5peuklekQ/X8l6l
         O4LtJzPj8SNugm+71DnpBm0gW7C4qI3tUnwh1zNUBuXf2f4HdUvNJG0YDkNSbb9KtfMR
         eF/Q==
X-Gm-Message-State: AOJu0Yw6dokVS/259lRRPFLSmZaq0lTPEz5kkc5hw33PiXArSIogRlVj
	QRRyt6oG1I5xE3Om7RjCN8gBF9OhPu2MHoKv0ZIzYscpikyJJm6ZEqT+YVSEBA==
X-Gm-Gg: ASbGncs9gTBRYgZkuw+qCojmHjumKyDS1GNzVA+CBbmbQiQbCnQlmqtVIXMHmdJ3vYQ
	8FGB2ytNfQnKcakXFGfC6nYKQBujTz7SYzSHuZVfBrgjB6ImK8zf7+HOiMYQcxJ4ie5gbtpGhnA
	HhFWcCsdlew6h6FD4aQ5M+pA8sYKv7BIFHPNaIblvFXRO1JOlANE41trxMVGLCkEI+MHfUdm5Qg
	A5wUpd78U/9f95d37naeYRhffgJEFizgU1BXkpmfq+7YO4KwgP0mxsVLDmOtOWbu/o54kR4u2+h
	iYq76TXW5bTY9eVe/oHN7EEqxjfNueBf2sFbThKrFra/eKCzHUxdEZUhD4f0DhSlPRShXfdXkre
	/SuYUGNYA1htB+GfZs0U1qWS8PRcOVWx3iIP3yNd7JjBec6koiP2pgtpMFb7eq3Je6aM+z40KBG
	41D7937Zs=
X-Google-Smtp-Source: AGHT+IHW5ck6KyFA4f7bJdjFItusTYpPmvIxg23Qa9JiBA/a5PrjKkQxB42ka6I5XqwqbypW0BI24g==
X-Received: by 2002:a05:6000:290c:b0:3b7:899c:e887 with SMTP id ffacd0b85a97d-3b900b4f687mr11770691f8f.24.1754917981986;
        Mon, 11 Aug 2025 06:13:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:9bd8:62f6:3085:6ee3? ([2a0a:ef40:7a5:4701:9bd8:62f6:3085:6ee3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abedesm40993993f8f.3.2025.08.11.06.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 06:13:01 -0700 (PDT)
Message-ID: <5cf47722-7073-4761-8698-090af840d0c4@gmail.com>
Date: Mon, 11 Aug 2025 14:13:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/2] xdiff: optimize xdl_hash_record_verbatim
Reply-To: phillip.wood@dunelm.org.uk
To: Alexander Monakov <amonakov@ispras.ru>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org
References: <20250728190520.10962-1-amonakov@ispras.ru>
 <20250728190520.10962-3-amonakov@ispras.ru>
 <aedb1be1-3151-421e-94ce-27bc77d80b83@gmail.com>
 <353c7865-d9b5-2a1c-4d71-cd1136581f01@ispras.ru>
Content-Language: en-US
In-Reply-To: <353c7865-d9b5-2a1c-4d71-cd1136581f01@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/08/2025 15:39, Alexander Monakov wrote:
> On Mon, 4 Aug 2025, Phillip Wood wrote:
> 
>>> Switch xdl_hash_record_verbatim to additive hashing and implement
>>> an optimized loop following the scheme suggested by Noah.
>>>
>>> Timing 'git log --oneline --shortstat v2.0.0..v2.5.0' under perf, I got
>>>
>>> version | cycles, bn | instructions, bn
>>> ---------------------------------------
>>> A         6.38         11.3
>>> B         6.21         10.89
>>> C         5.80          9.95
>>> D         5.83          8.74
>>> ---------------------------------------
>>>
>>> A: baseline (git master at e4ef0485fd78)
>>> B: plus 'xdiff: refactor xdl_hash_record()'
>>> C: and plus this patch
>>> D: with 'xdiff: use xxhash' by Phillip Wood
>>
>> I think it would be helpful to say that B is the previous patch and provide a
>> link for D.
> 
> Ok, reworded locally, will appear in v2.

Thanks

>>> The resulting speedup for xdl_hash_record_verbatim itself is about 1.5x.
>>
>> While that's interesting it does not tell us how much this speeds up diff
>> generation.
> 
> That's what the 'cycles' column in the table gives (6.21/5.8 = 1.070...)

It would be helpful to add a column with those calculations in it rather 
than forcing the reader to calculate the speed up for themselves. Also 
what is the cycles column measuring? What is it that takes 6.21 cycles 
for B and only 5.8 cycles for C?

>> Running the command above under hyperfine it is 1.02 ± 0.01 times
>> faster than the previous patch and 1.11 ± 0.01 times faster than master.
> 
> Then you get 9% from the inlining patch and only 2% from the faster hash
> function? That's a bit surprising, which compiler and CPU you used? Is it
> with default optimization (-O2)?

I used gcc with -O2 -march=native on an i5-8500. I saw a similar 
improvement from the inlining when I was playing with xxhash.

>> Using
>> xxhash (D above) is 1.03 ± 0.01 times faster than this patch. How do the
>> changes below affect compilers other than gcc and clang than do not see the
>> re-association barrier?
> 
> I'd say under reasonable assumptions (e.g. a not too ancient CPU with 3-cycle
> integer multiplication) the new scheme is generally faster even without asm.

Thanks, fwiw I don't see a measurable difference in the timings with and 
without the asm on my machine - sometimes one is faster, sometimes the 
other, any difference is within the noise.

> But Git can certainly follow Glibc's choice and employ this only on x86_64
> (and only with GCC or Clang).
> 
>> We'd want to make sure that it does not result in
>> slower diffs. Can we use atomic_signal_fence() on compilers that support C11?
> 
> No, what we need to do here is outside of the abstract machine's view, standard
> functions are not going to help.

That's a shame. I'd hoped that stopping the compiler reorder the code 
would do the same thing - what is the asm doing that's different?

Thanks

Phillip
