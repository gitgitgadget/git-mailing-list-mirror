Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B4480953
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912581; cv=none; b=TTtxemy74rbE8SK15JWD7p0i7vIAh8uNBzDaYYc/KSb6p3JTvn/z4Ow1VCtqIAwt0Nho9PschHkOsWVdlZfQrsDteMEDIA2aSV7k3zDrJjgCvKyugEsA5ChmVBPWl4X9vASgAH+WFaDbCQ5n5rMb+TZHG7FkgUCY0H+24E/P6uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912581; c=relaxed/simple;
	bh=baJhW8qaNhMXulrEuFDaAOcb4XHmggQ3rYpLkECFwEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uu4O9XCCdnOQ+WON5k9Zjs/2E57ghTnHb4s06a1O95CPNCJXPTOoAn++ICjoH7dnlLy1SJoi7bqGEcUaKLovRxpvckeVmOVq1UC2kFKB7l0fWQy6YO4pMGEk4TW9GVOWzVznqRoDecIp4aB4dk3zmaVE6lA6LK9HZ5YhiSwEDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6PP/4F5; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6PP/4F5"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6976b0b2c79so746275a12.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782912577; x=1783517377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NYizcFzUn7hlojDwKBSVzMoLDrBoRBBZRP/VuG0xUVc=;
        b=Q6PP/4F5asiyWCf658vQ1pnR77f9aAix9Md0KM618PBO8/irUP5+3LP6Fk9q0eP31A
         CggiF4re2TN5GhHCUf5UA0Sbmh98XJMf8VntNCROlth2BizEK1z82T+gDmwVKcU4Rmn+
         44xdhYX41d9TLu1c0B1kPA1wqTLhIxoTNxVVRn8tq1bmWZsmqK3ejbi5asu7cmwbiDww
         L3+DNy/IwvcZ1cLqpsO3GBJm6MenGBUL3GODtWXSsSRT1w9ZhczhQVU8aHaULT1zy7H7
         QW0O5wlrghnorULKo/XfdqGLcTORlOSwvks2KUndoGsKY1+xdHsyc18uNrFUU/nZ57Z9
         teag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912577; x=1783517377;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYizcFzUn7hlojDwKBSVzMoLDrBoRBBZRP/VuG0xUVc=;
        b=Ggx7BMh2WPxHQi6IMFhSssPxJxhyVLofv4FdN8dowBphMKsPr2tnaUi53ZQmEhF6CI
         IaRe22XtOsRhaHBv15A0dg5jkE2DafvVz5fiCCnwL3JaUfvEAgJoJaCvBd8EGdVM5oRg
         1rXlR77BucESpN8mGX32D/uimM97dKh8gR+FR0lmgteFt7NzVSxDTfMWcD7dvTuE5cnW
         GcwvsyiGD+pbp9c3GbBBJq+ZS4DElfE6qTmBz0quu0nYmOY7YuqedP8AUITchfwfU7YA
         4BHKZnJtyRRHoQtopCFtJd/LFEnpjneP/JGic4QqUNcItT855CHuHhwD5BuMRezFBB3v
         i08w==
X-Gm-Message-State: AOJu0Yy56reK+eRZW2zqiSM9UvdGAQE2PujLNdPGNABpG6H6WV6L9J0C
	AKfvZYZkka5mW3CQbsf3Ysx3KMuPt4BmNnSD8TIyeB7urh6C+PS96E+D
X-Gm-Gg: AfdE7cmRErbpCs+Dg4+JdaEKDAqpxOMOt/mIb/GK/6p/crcDaVe5cxBQDxc/VfLbWi9
	hYbUvMces+bpiQmH9PSjJiLOAXHm3BCEYi4iAiTGaCns9eVESjnR5vO+WCWEZmVNxVaKMFTcxfP
	77JhYR4hWJHdOlMlV/Ct16SKlQV7DlOq5YPs6j2MTFGNPQ0tf5/Ck5Fxk4TecFqAoxeWwQNahYA
	/n0B36y/1dXJkZmC1+zVPVvyg3FtfKypWz6hXXE0iCrx47yePWQeZjJa3Q3GV6os+yVmgB9xWrh
	PaXJ3Z+2ODqtgXk0gyR204T5iMbZBT5VHNTHJpXV7SS1CNUbcRH3WCLphESB92owZ+8Ra+47jJ6
	TdmpXW7r+uoerIG7HXYyzzTBlu8HmS0WsDm2ogEFwa/IY+waV9qNoDnbx8S9I0rCxRpgZnZ6g26
	kVw89UF/7R4fk8rbQLQNSaIpW5Q9O2zBFKWV4kX6R0kH0qKp7ggPT7ZFngU0Tutzn1TWb501vhp
	7qkQQ==
X-Received: by 2002:a05:6402:4347:b0:697:84d1:e5c9 with SMTP id 4fb4d7f45d1cf-6989f2dc2d5mr834757a12.3.1782912577124;
        Wed, 01 Jul 2026 06:29:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c3a42f6sm2712578a12.6.2026.07.01.06.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 06:29:36 -0700 (PDT)
Message-ID: <822d2b16-8275-480b-9fed-9f9c5cbf09dc@gmail.com>
Date: Wed, 1 Jul 2026 14:29:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/11] sequencer: do not record dropped commits as
 rewritten
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Konstantin Ryabitsev <mricon@kernel.org>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
 <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <xmqqpl17rec3.fsf@gitster.g> <akSqjIzdvsjK0yoM@monoceros>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <akSqjIzdvsjK0yoM@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/07/2026 07:00, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Jun 30, 2026 at 12:57:32PM -0700, Junio C Hamano wrote:
>> A tangent (I Cc'ed Konstantin for this), but
>>
>>      $ b4 am -o- '<cover.1782833268.git.phillip.wood@dunelm.org.uk>' >b4am.mbx
>>
>> failed to produce a usable mailbox.  It somehow did not think [2/11]
>> existed.
> 
> FTR: The mail is on lore.kernel.org.
> 
> Also to yield a usable mailbox my patch shouldn't be included.

Sorry I had intended to send these as v2 to avoid any confusion, but I 
forgot about that when I actually came to send them.

Thanks

Phillip

>> I manually examined the References and In-Reply-To headers
>> of that particular message and compared them with those from other
>> messages but did not find anything suspicious X-<.
> 
> 
>>
>> I have a bunch of typofixes queued on top of these 11 patches (made
>> with "git commit --fixup reword:<sha1>"); please double check when
>> you reroll after seeing more substantial reviews than mere typofixes,
>> possibly from others.
>>
>> Thanks.
>>
>>
>> Here is the transcript of failed b4 am invocation.
>> ---- >8 ----
>> Looking up https://lore.kernel.org/all/cover.1782833268.git.phillip.wood@dunelm.org.uk/
>> Grabbing thread from lore.kernel.org/all/cover.1782833268.git.phillip.wood@dunelm.org.uk/t.mbox.gz
>> Analyzing 17 messages in the thread
>> WARNING: duplicate messages found at index 1
>>     Subject 1: sequencer: Skip copying notes for commits that disappear during rebase
>>     Subject 2: t3400: restore coverage for note copying with apply backend
>>    2 is not a reply... assume additional patch
> 
> I think here is the origin of the problem. It guesses that the t3400
> should be added, and it takes the place of Phillip's second patch.
> 
>>    ERROR: missing [12/2]!
> 
> This is irritating, I would have expected "[2/12]" here?
> 
> 	b4 am --no-parent cover.1782833268.git.phillip.wood@dunelm.org.uk
> 
> works fine for me.
> 
> Best regards
> Uwe

