Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896718EA67
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052649; cv=none; b=ukZrq3jOapyBIO5ufk40NBdGvE0RFo03DKZvHju2jLUIjr6zMxHbR79KimD+KFOsxEHqvkdxybfjkB2jrQxZiySrkThS6eDh+WVpS/zgArnNsYvpJJWxrezJUbi0dvFMLJp6HzN+04McQuIWvLJc4ZEadqmblievTugHQ1n4QjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052649; c=relaxed/simple;
	bh=ATeoe3/3oS18VgE3ypROAXafqX7NXHvgDmeQ5oub/Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bl7J4Y4gQFGcPdinVskvDM+fknKfFzi/E85nljgZE597Vp/cHPOlgzRA/68nB67B3952n0KNdRsSmeLhsv/1Ii9X/Hu9f4bmKeaX8W2dF69OAYAUZR8skULD+Zoie17AzSKFIA+k9IK5Dw846tU2zf7O+4Gupa7uwtBzyv3qZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbltvh6Y; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbltvh6Y"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eea7e2b073so57228791fa.0
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721052646; x=1721657446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YnfDOGsoQbnUeDeUTS0xOj8PChLhXIsAhOf71eK+MIE=;
        b=dbltvh6Yo0v3wfzyrHnelFuyzCY5MZX8IaiOkoM4QCKaDC+otZH9yjSRYq0AyFsIHv
         vnHC16jo08D1KU1+o+bRv1bS2Vy+WD3BakuJrBAV5JtVcCF+u1cI7HUnB2xONWVxj3cM
         srzLDO8GKCEVMVQp8aI6+pGYepYAtTdsB9ujQ/HbYBrC84WNNNMTWjFufl+WWfrNIDHG
         GaTajhURG0oP5KkBx0T7DW8QR7x6YFS90pUiamW8hEO9frViizfjRwW6vwtGona+JAy1
         MFIfNExEZAmIG7ZtW/XtcX7Str3mPTs+LBiWfT85BYfB1vbqaeo9aMpXElRLANJOypxK
         fqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721052646; x=1721657446;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YnfDOGsoQbnUeDeUTS0xOj8PChLhXIsAhOf71eK+MIE=;
        b=nzGBXHtSUMXKvkAmpSByB7xMYGZke3gWkcNyPG45J3f2HJdvuYOKXwraGe4pksDZnV
         oT6AdChk8gOBy2VLgM/B5qN/XR4PjMuhaR2avcrrkpjuCFV/B3rto17LiitY9FaUNcTI
         eMWMEWk/TfA0Bo1LIXz0Q/JD2LI2pOcPCSoznpaBfaWdswNyBwkDo7lCSzYOixFWbg32
         oGfKI01tuU6yInL3Iv65klQYEXewo/VlB5V0MB1Ivxf0JbSAkBExvzn5KOzEUwmdraM5
         cncet7THd+WqL3BVWCbpg+iKzbnqpuc/KzKeAqbUqCQz/gMOy3zRdCN+YcYB9iiN0L6T
         movQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKVFq/+HEiiL6ldcY4NLHixa4avyBCyFrLk9imaX6C0EC29CZ/IWS3/UFKuDHcYQrbfvSNRgoMNHcDxn+jF5chK08g
X-Gm-Message-State: AOJu0Yw97BV9tAZh8MrPd4cPYX2k5oYHDIvg1vh6icil0IpTD3UtgBVR
	s0R0Hd8J25a9edhbbRYWn9j8q3bH+Ojc70n8MA/O5Hhyz2RRBxar
X-Google-Smtp-Source: AGHT+IEgACKeSr3EIuyKT0Iiq7jsgG7pYA4kOpAHvN+JCnKluadC7YV8Mv0Zgc58eYJhFU1nrqNS9w==
X-Received: by 2002:a2e:9310:0:b0:2ee:8dce:2fa0 with SMTP id 38308e7fff4ca-2eef2d718a8mr118471fa.25.1721052645180;
        Mon, 15 Jul 2024 07:10:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef3256sm89712235e9.39.2024.07.15.07.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 07:10:43 -0700 (PDT)
Message-ID: <bb699ae5-deb8-4bd3-ab44-d66f401c7e17@gmail.com>
Date: Mon, 15 Jul 2024 15:10:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 14/07/2024 17:04, Rubén Justo wrote:
> Make the print command trigger the pager when invoked using a capital
> 'P', to make it easier for the user to review long hunks.
> 
> Note that if the PAGER ends unexpectedly before we've been able to send
> the payload, perhaps because the user is not interested in the whole
> thing, we might receive a SIGPIPE, which would abruptly and unexpectedly
> terminate the interactive session for the user.
> 
> Therefore, we need to ignore a possible SIGPIPE signal.  Add a test for
> this, in addition to the test for normal operation.
> 
> For the SIGPIPE test, we need to make sure that we completely fill the
> operating system's buffer, otherwise we might not trigger the SIGPIPE
> signal.  The normal size of this buffer in different OSs varies from a
> few KBs to 1MB.  Use a payload large enough to guarantee that we exceed
> this limit.

Thanks for updating the commit message to explain the purpose of the 
SIGPIPE test

> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---

> +test_expect_success TTY 'P does not break if pager ends unexpectedly' '

I think it would be helpful to mention SIGPIPE in the title as this test 
is really checking "we don't die if we receive SIGPIPE". Maybe

     P handles SIGPIPE when writing to pager

> +	test_when_finished "rm -f huge_file; git reset" &&
> +	printf "\n%2500000s" Y >huge_file &&
> +	git add -N huge_file &&
> +	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p >actual

If we're not going to look at the output we don't need to redirect it. 
I'm not sure if there is any benefit to comparing the actual output to 
what we expect here.

Best Wishes

Phillip

> +'
> +
>   test_expect_success 'split hunk "add -p (edit)"' '
>   	# Split, say Edit and do nothing.  Then:
>   	#
