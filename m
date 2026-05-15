Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855D38757B
	for <git@vger.kernel.org>; Fri, 15 May 2026 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851385; cv=none; b=fIdHIOI4odaBNRFADeIFwwzXMqdZqMyJK9zv9fXExFm7RGQ5DlnK5xpqVmpGC4e1gC5anl73XjXrbeGjYcySkFldqkoxoPwhVVrISRhgQEsnT6NXJx1T7xBOq2n9phart1e1uAdb7gOIvlX9to2joDxGjEbaIx4oSpLKhENRnh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851385; c=relaxed/simple;
	bh=BAMB+5hiX15AnVx1H0V+vXO6MCILNfBj2SpsDPDlZVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imoOb6gNkPNvgdTk4G7uOEyQC3V34bicVf24rg/uDrAUhFvep6etWGRyzNrz2cl0gcwchALy8lTL1/r39jmTh7tkBm7mT0waK+PpNDlh8CAERD0hZwgXnayX+tA4IIrvBT+RbW3yIgIRDoAtkL4trQbZzj/RNkN02AAjg3QfVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSCgCQkp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSCgCQkp"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so87139825e9.2
        for <git@vger.kernel.org>; Fri, 15 May 2026 06:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778851382; x=1779456182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dUqxNwatHePDcOhfSYrNQaSh+Y7CNZ2Scsqxdhd9PzI=;
        b=PSCgCQkpJwPJX9WDIHK7Fa6QWXOH2QxIWqkmoE2DKcMiFSZVBPqM3KTtEVupYfPTTK
         x6d150t3ACEqAQddkoCQAWE2cuhd3JYfhUgIevlvH/s4yJmfPeDNLfyINoKiCJkzYnCi
         iTser/kevIFe/vGm7765PbGsVG7/RnCzAV5UsJxqZZotAapaMTNqusWnDI2KH9JPwQMw
         z2PAny57CNmAc9+PpgknLSnQt92Nkps0QDQwfxfY1o2OjVsk0ZKjbHZmgYVgdJhsUjd8
         cHIGK+7nfLR62U7N7/HT6BUSBGNM2aV8S5yQQfL7yi26aD5WnolCkHc1yfcrBFHl38hx
         ed1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778851382; x=1779456182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUqxNwatHePDcOhfSYrNQaSh+Y7CNZ2Scsqxdhd9PzI=;
        b=HW21lczJFkdFZifX3bEvw69cKESJU+mm5n+uwTkK4wHm2JUJi/INTOUXQHkiz5TU7g
         rzYaz28lE7UYG9uaPFTmUPXEyqAB+OQC3iaR752garNBzWz5U3RCygOKAxspmMEHLqtG
         esSMXsC7HMSz+42rkIk/eIQXoMGk+xEdjZBnUoAksZp+nmkEPFwfmtPnUrk9yTSFglGx
         IJ3uIaLqfF0BzZ3soXFGBJ3nRUQxu+WlBlNzUkTdy71EjUQzj8/DNxPwd1O8kwgY8PXu
         9Y+ixKbusQUcta6QJvV6QFRsgb6EPqrRl/T8O96xB2gSHQYeMJtIFoiyvf0bkNziMD4n
         7acw==
X-Forwarded-Encrypted: i=1; AFNElJ8Vbs226unA0wOOWGRkGHW0c8OJnbmRVGu7SJB5e0IrAdP2KvMtR/UWHD3SFZp3vhffLjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZdByiH/3gjH1PppaZSH3AiUUnOhoNoqhDtqpouj+7YBnE1UU
	mBZ3Gb54RT2O4pULV5RdfeGiqaxah/61pGv2tyLSJi9aL2PtS1qx1eEI
X-Gm-Gg: Acq92OHzlSyImykS/X0Pi1RsEY5YIIqJlYI0eDVUCDIOHSBqACDYaZ91MCgQ6DMaFuA
	t/wPlcoryMvsSPVEdrwlYdd42fRE+/kjrGm/ffBUjPrAEwdhxA+SO55ntkb6uT/3yOMcaMiPF5a
	DiLdDJ/+SNobBfF5n5X8wJxNt4BSaGu5iWXN7RR1vahWEw7wUY7k1z41IKtv4SsgIC+1tnlyUwz
	cDsRM/NZMNkK1MqXcUUNxiWly0zMBNDcgl947v00/rcr9ahOpBcL4QP3pSqrwpBKOzQPdNExnPW
	rkGxEicos0vmSgIgryPoTgu4qeO2nTSxh2DRMFXFADXzoLqXTMLmqDYMQ+mG80rOiLTscB2+/yi
	Vrl/XLsKsuTsUtBS4gTAjKcjGUgv7WTokoIAGWEG8cI4e6dfqBq9OxvXeEENd2BYLXOTWkuaGvo
	pFzaCXyLOuGgqf1VfNya18yxR5USUhCyiEyj7NzJJuoqZq8Bxn7zAKYSfGtiisFdY5GqdTSnrEJ
	1KJww==
X-Received: by 2002:a05:600c:c167:b0:48f:d410:6065 with SMTP id 5b1f17b1804b1-48fe66138dfmr56687355e9.29.1778851381638;
        Fri, 15 May 2026 06:23:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:662:5a01:509f:d84a:9a5e:1263? ([2a0a:ef40:662:5a01:509f:d84a:9a5e:1263])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5ab52a6sm59156365e9.10.2026.05.15.06.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 06:23:01 -0700 (PDT)
Message-ID: <d888553a-8a99-4c79-b720-a562ac9900e2@gmail.com>
Date: Fri, 15 May 2026 14:22:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
To: Vincent Lefevre <vincent@vinc17.net>, Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org, j6t@kdbg.org
References: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
 <xmqq8q9migqk.fsf@gitster.g> <20260514095522.GA159111@qaa.vinc17.org>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260514095522.GA159111@qaa.vinc17.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/05/2026 10:55, Vincent Lefevre wrote:
> On 2026-05-14 16:37:39 +0900, Junio C Hamano wrote:
>> Michael Montalbo <mmontalbo@gmail.com> writes:
>>
>>> @@ -457,6 +457,11 @@ endif::git-diff[]
>>>   +
>>>   Note that despite the name of the first mode, color is used to
>>>   highlight the changed parts in all modes if enabled.
>>> ++
>>> +Word diff works by finding word-level changes within each hunk of
>>> +the line-level diff.  The line-level alignment determines which
>>> +changed lines are compared to each other, which can affect the
>>> +word-level output.
>>
>> The added text may not say anything wrong, but I am not sure how it
>> helps the end user to know the way machinery works internally.
> 
> Perhaps only the first sentence should be kept and that the following
> should be added: "Because of that, using the --ignore-space-change
> option is recommended."
> 
> Note: Earlier in the discussion, Johannes Sixt suggested -w
> (--ignore-all-space), but this is wrong, as
> 
>    git diff --word-diff -w <(printf foo) <(printf "f o o")
> 
> gives no differences while one has 1 word "foo" vs 3 words "f o o".
> 
> However, --ignore-space-change is actually not even sufficient
> since
> 
>    git diff --ignore-space-change <(printf "foo bar") <(printf "foo\nbar")
> 
> finds differences though there are only space changes (thus this
> may affect hunks in case --word-diff would be used too). However,
> I suppose that the cases where --word-diff --ignore-space-change
> would not give a "real word diff" would be quite rare in practice.

I'm a bit wary of recommending -w unconditionally in case it gives 
unexpected results. I've not really found there to be a problem using 
--word-diff when reviewing code patches. In the examples you gave we'd 
ideally fix the problem by computing a single word-diff per hunk from 
the line based diff rather than splitting the hunk at each context line. 
I think we'd probably want to exclude the leading and trailing context 
to keep the hunk header accurate but we'd get better results by 
calculating the word diff of everything in the hunk between the first 
changed line and the last changed line.

Thanks

Phillip

