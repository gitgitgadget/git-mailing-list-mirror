Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF5B17BA6
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673375; cv=none; b=XiOXqsfNBhZbZOcQWSYChCeILbvZjNp1dSuofVgpzNpJgwV54ToZZxNxYJAcvRsjMAPpHhdqu/VArqpAuMTY/2soTl+IJGLOMZOTS4gmcp7c6tBtBTn1ThLzTzT23ghPhZEaGNI18dho6f89qOVTHxfDU9Pf9Wl9nsWM+xkZJLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673375; c=relaxed/simple;
	bh=8Acw3NpMG23eJxIa1I1hfh3USG+vPhoao5fGBfE+Wik=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FPfRe1vXTdmWiqrs9+7M95lPLNCGSRZ7LwyWitBTWLP5e8D1mjKw42IFl70ib3f3GUWfDkjdUptq/PkHwtDzRmvLQ6NcxTnc5tlhHnNE+WHktg+Kbp4kgDxnieQ8+j4xFL4oKAeYH6ktOkv8js+MmL5Js2hGrIoF6AxZ8uoXRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlfQxSH2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlfQxSH2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43998deed24so11679795e9.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 08:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740673372; x=1741278172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xejvQe2/nA5ornRG4cciN4pAt4vzlOBEppESUhjC1Dw=;
        b=JlfQxSH2R5rKVAnasl3x08C9S5mlOfOG2z4+/VCd5Rc5tRuHi4uDmhsEQgAmQUu8fS
         ZWNNf32BKghWDdVEsuLxTUu0lCQl9TpInV1yKaLyHS3wSq5oMN5DN6t7RSHSSEcgXqY8
         snN6VAwfSbAqNL8WTaWLypzxyASbml/61PgzhEi2XeRwDYXDLWOrDO57TtudYwF8PF/l
         w4LXXW9yAgnd6Im8aSlbHch4c3nDvPks/Ej1ID1hbSCFfym4s8dFLSBbwekdSQnAOWcA
         7PuQnq2XC3VwO6CDNSbESnnXv1js9R4naJ8Fss9tl2ojiFV0sg6m7YyIeZ62EypP8zrF
         xVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673372; x=1741278172;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xejvQe2/nA5ornRG4cciN4pAt4vzlOBEppESUhjC1Dw=;
        b=BkkxyBRhGsbuS2QwW/ILMR9mDAwP5pkdt19eZfkPZ4OVSx2GgynD/D95IspoZXg7cH
         J0RP92X75jKfszDdlvKjJrgrXg5HF+OH5tjCibivW85wWXpzrD+vAX0Zoa68r1MOLVkq
         zW0IouHm0uBqbfqWHOal2sVgvOveL3SAIbjj+DVdufVbo1ngKkbskCmMJYBdBXbo4p1D
         g5CTgh3BHvAelgJvW7zvY7YLWiMeauvvVlHYWazPKKtLaPPTG3voSdB8mMd6GExOKrk2
         jpw5or5u5YjKHQBoo/Yxy4dqbdmIZHBhU1+UlJqIR1i6p85qMrqQoxvxpGWrHAFqIeGa
         T8rw==
X-Forwarded-Encrypted: i=1; AJvYcCVsRgaqJ8Z4jT9dPiSazB6yGE4tv16dkuFRt9H7D0C0lv0QX/JO5HaHTXzw4/bOibgeeKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgBCfcZGTsRBT/3jgBVtzv9hyfT06kyYyECJSJcYju+TRpbspL
	YNwq0wr5LYDtD1GUdrT0eZXVvKlmvUjbMJ2v+mEdI5QUBJ1CZmWK
X-Gm-Gg: ASbGncvFQORXZmDsGnvQ4rYsbfjv5PTF1cs0Po1TiwlS7x03MmQ3Z3FT8/fMWRc4k7+
	8bcRRr+BJJTzlDcn4W+91Dul5sNeAzOKkIY0BHip73j/RyoOYuGfXz4niFLv6FRe9IzofLXpYZf
	0U4xp9xM5tbQq1qYDX4ZAGycugEKOAmUOZM+YQQkGKE+5vC9sDk9X216W8w+YOvDIDSTRp+tgdf
	5OVLdGQgo3NFcGFQJFins26tmF4xrasSmBPvnl0X75qgQeQBd6IiBrlmVCS/r3M1ApumuoP6Bku
	gMXToSIpXdjJocmrPHmZgOujQIZ/jYlJ8oJL+DJu26YinwYbFFuqCx236l5UCHjHld3o0cATRf+
	70XbM
X-Google-Smtp-Source: AGHT+IFeDVD+FSA3zGQRNnlRj3OkfY/Ya3WjpzPjOXBJMnpG61YDaM1UEmt+BascxQX97afHrLX1CA==
X-Received: by 2002:a05:600c:3506:b0:439:9f97:7d6c with SMTP id 5b1f17b1804b1-439aebcfc40mr217402975e9.29.1740673371874;
        Thu, 27 Feb 2025 08:22:51 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73702f42sm27772265e9.9.2025.02.27.08.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 08:22:51 -0800 (PST)
Message-ID: <180271a6-eb0e-4c15-9916-b2ab5760f4ec@gmail.com>
Date: Thu, 27 Feb 2025 16:22:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] add -p: mark split hunks as undecided
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
 <43a0592a462cf68bcfdc54373da2319431c3c1ca.1740149837.git.gitgitgadget@gmail.com>
 <xmqq34g79e8k.fsf@gitster.g> <618d4a61-7480-46b7-8563-221264290ed1@gmail.com>
 <xmqqikowejmb.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqikowejmb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2025 16:49, Junio C Hamano wrote:
> phillip.wood123@gmail.com writes:
> 
>>> "Ah, here is a big hunk with 10 changes, most of which I like, but
>>> one of the lines I do not want to include" in which case I may do
>>> the "Add the hunk to grab 10 changes, visit that decided-to-be-used
>>> hunk, split, and then visit the one minihunk that I want to eject
>>> and say 'n'".  This makes the workflow simpler and more stupid by
>>> requiring the 9 minihunks to be chosen individually after splitting.
>>
>> If the user wants to deselect the 10th mini-hunk then they have to
>> wade through them all with or without this patch. If they want to
>> deselect an earlier one then they will now have to do more work.
> 
> Or directly jump to it with "/go-to-the-one-with-this-string"?

Oh, I'd forgotten '/' searches all the hunks rather than just the 
undecided ones.

>> Currently after a selected hunk is split we always prompt the user to
>> make a decision on the first mini-hunk even though it is marked as
>> selected when it is split. This seems inconsistent and confused me
>> when I first tried splitting a selected hunk which is why I wrote this
>> patch.
> 
> Hmph, so there is an obvious alternative "fix" to the inconsistency,
> i.e., after splitting, move to the first unselected hunk?

We could do that but I think it would be even more confusing than the 
current behavior as it would make it harder to change the state of the 
mini-hunks. At least with the current behavior one can use 'J' to move 
through them immediately after splitting the original hunk. If we move 
to the next undecided hunk one has to know where the newly-created 
mini-hunks are relative to that.

>> I can see that in some circumstances this patch does make more
>> work for the user, but I do think it makes it easier to understand
>> what happens when hunk is split.
> 
> And the alternative may resolve the inconsistency and make it less
> work for the users?  I dunno.

I'm not sure either. I dislike the way it works at the moment and find 
it confusing but if there are a lot of people relying on it then I'd be 
reluctant to change it. Unfortunately we don't have any way to know if 
anyone is relying on the current behavior without changing it and seeing 
if anyone complains. Given it is a bit of a corner case I'm not sure 
whether it is worth spending much more time on it.

> This is totally orthogonal to this "split" issue and outside the
> scope of this topic, but one thing that I do not like the design of
> "add -p", which most likely was inherited from the very initial
> iteration before it was rewritten in C, is that we never ask
> reconfirmation once all the hunks got decided.  With 3 hunks, after
> choosing hunk #1 by mistake, I can still go back and correct the
> mistake even if I noticed the mistake after making decision on the
> hunk #2 (thanks to the fact that hunk #3 hasn't been decided), but
> if the hunk #3 is missing, going back and correcting #1 becomes
> impossible as the program exits immediatly after deciding on #2.
> But I guess this depends not just on the user but on occasion.
> After all, re-running "reset/add -p" after such a mistake is not so
> huge a deal anyway.

I can see the problem and asking for conformation before quitting would 
have been nice if we'd done it from the start. I'm not sure it is worth 
the disruption of changing it when one can re-run "reset/add -p" quite 
easily though. I guess we could add an opt-in cofing that eventually 
becomes the default.

While we're talking about tangential issues it would be nice if when a 
user revisited a hunk we told them its current state. At the moment 
there is no way to tell if a hunk has been selected or not. Related to 
that the help for 'J' and 'K' talk about leaving the current hunk 
undecided when what they actually do is leave the current state unchanged.

Best Wishes

Phillip
