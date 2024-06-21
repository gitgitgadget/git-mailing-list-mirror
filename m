Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09CA936
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975001; cv=none; b=qMg40G78pdcmKLfQiAKd4RP3LPC28mFU/CQTLhSc/J37gr8uJMkBThTwCTEqkk1BXLpoyTA/vYeBedsZdBUHXoFX2gQrGrojbRSM17NTVpOFSNYmWBjUaTu08Tx8AKiMJsVEe0pnvO6WDEAYpN8qh3h6iVKAtKGtfZFzN5zQTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975001; c=relaxed/simple;
	bh=WWQt5m9lU5VT3lBv4Ork62Ht0oMtaTXld5Lwlcm4g6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkD7z8qbVKjhkQ2NallpnQe1Ldr0lC3FFVSKU5NKDdt6QRAIBTpbc4YQHG7uq7hSVEUZUzNEOsy2wjJ1sYLGpQWQ7Hmy8YawsldhtaPRGiPnC039vQXEUtk07ue5U58SOmGbCjfdKaQTBC1uiUIyXZrzOW7moOxuuzsEjUj09Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aont6PrF; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aont6PrF"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso1902273e87.3
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718974998; x=1719579798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ljNTcb9uhCFrQCwiG13x1T8ug7qasxTtJCNgjuZbQu0=;
        b=aont6PrFwzhTm9rABXjRp/CZOisdvbUq54V95/INXpOXbZ8zLQ5etl+HCF09ZF3cSy
         IWy7uI5svXTNoM0kJs9jJhyq4rZx3VYmK3vnsuqYMOkrfsDqFi9qXOzhnGCophoCIma0
         iCsZ53hDMbxyOYpIZYl7Ngc49HrInIqXBbq5gr7jdEI3Elx541h+JtNfzzno8DOainKo
         zmZzXGkPoBKabxL3Ms6WCYh5jjgM9szJamenpP6FYpnZKhrtjtujOq5hBdbkrsALy454
         JK+cZw42ZFW7pQBz5dFq1MciIisL9eBeE4GgFnHTGPnRNhO2zsnrO4wSu9K4ondjLOCo
         8KYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718974998; x=1719579798;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljNTcb9uhCFrQCwiG13x1T8ug7qasxTtJCNgjuZbQu0=;
        b=wR2mHoD1UKiLwu4A5NhtLfivK+Suv8DlWdzSdDAgxYiKj/n8Pn2poOOFlmW3bBAaID
         8PFPHqgtD4FslszBRn30/OO+Btd2k+/1B2xSIVToDcCK3LQJGbyi0VbuuVvIA4t8GDvd
         yMLFmkchNGwYMjWqi4zl3AhlEaJmnRdXSMLlRUInTp4avEZc/iwwR6WWoN5ifiyw10LU
         1XepF6xepE5wscBKo/7DWdOar9MJeqAH7reKjDzpcgYmL5wpM3IX9r8KVd1UgatlfTo4
         igtVI7YfVB6BcZ8rv/Xefywg+6pXWcyEx3R6lDkWlF946ZDHq+wJyG1FXWK4uoFFl1+j
         q3pQ==
X-Gm-Message-State: AOJu0Yw+KtwM9qyzxhdWcRDvkWEZxeoCn809JUagl/bBFrGXwq6ZP/l4
	lPuZT/0w1mDG9VWi8+7oZ4orxhocjcMKMTEzH8RLdg+98zSqWT9ZBQTx2w==
X-Google-Smtp-Source: AGHT+IFD6YUaNg/GhJ7nZNgEitje0xnQPrkfeVuekTuogm7LYcWh2Pnqx4EnRVCcPR49l9I18j1Dug==
X-Received: by 2002:a05:6512:138c:b0:51e:11d5:bca5 with SMTP id 2adb3069b0e04-52ccaa974c1mr5202132e87.54.1718974996113;
        Fri, 21 Jun 2024 06:03:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3663a2f663bsm1717265f8f.83.2024.06.21.06.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 06:03:15 -0700 (PDT)
Message-ID: <d5dc3cbd-72ae-4f1a-bd9d-d2608364a08c@gmail.com>
Date: Fri, 21 Jun 2024 14:03:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] t9700: ensure cat-file info isn't buffered by default
To: Eric Wong <e@80x24.org>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20240617104326.3522535-1-e@80x24.org>
 <20240617104326.3522535-3-e@80x24.org>
 <6e80eea5-b6ce-4218-8c43-dde2b5a698f5@gmail.com> <20240619180807.M97115@dcvr>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240619180807.M97115@dcvr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/06/2024 19:08, Eric Wong wrote:
> Phillip Wood <phillip.wood123@gmail.com> wrote:
>> Hi Eric
>>
>> On 17/06/2024 11:43, Eric Wong wrote:
>>> +# ensure --batch-check is unbuffered by default
>>> +my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe(qw(cat-file --batch-check));
>>> +print $out $file1hash, "\n" or die $!;
>>
>> It's been a while since I did any perl scripting and I'm not clear whether
>> $out is buffered or not and if it is whether it is guaranteed to be flushed
>> when we print "\n". It might be worth adding a explicit flush so it is clear
>> that any deadlocks come from cat-file and not our test code.
> 
> Pipes and sockets created by Perl are always unbuffered since
> 5.8, at least.  If they were buffered, Git.pm users (including
> git-svn) wouldn't have worked at all.

Thanks for clarifying that

>>> +my $info = <$in>;
>>
>> Is there an easy way to add a timeout to this read so that the failure mode
>> isn't "the test hangs without printing anything"? I'm not sure that failure
>> mode is easy to diagnose from our CI output as it is hard to tell which test
>> caused the CI to timeout and it takes ages for the CI to time out.
> 
> Yeah, select() has been added in v2.

That's much nicer.

Thanks

Phillip

