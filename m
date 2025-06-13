Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75AF2DA753
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806453; cv=none; b=FvmuN8xTTPpDYzYS/HBzMY+xT6O8N/+q6r/D/rK5B6XZQ97hI2Kty/NyffOlHQavu/Vo4oJFiSBq478KNBynI6w2Lc3/4xerJhV6LSVl32JmrOZoMxwKObXeDapH/Tk553sqDHNZUAkl07MqgFIGJvAQUnKp5bWLwfEkAqhFKJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806453; c=relaxed/simple;
	bh=jCCzSA8lAPFt3aMDNMf3+eO8CTIHFY7HSAvejXTPnjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlHflWQG/ruh/KvyhrtKD9VN7C5O7gbKJNaLK2Yx3fecUMN2/MVMIJR/Hsdmw2OE4Vax0Up+BTXvMEQCx/szDUU+h8w7AQDEcjdQowQNut+TGd3sVR7rTk1wJ/y5egwx4/J0QAX5hYCUTWCCEBgrFaEp7pYwV19YYLiqVUsTFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY5AuNig; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY5AuNig"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235ae05d224so26563985ad.1
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749806451; x=1750411251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuBgDMu8hKVmxRubAKopvVS3wNUvEuyFL7n2iAOcpfA=;
        b=AY5AuNigv0L2nSpWC2IeRSCUIGkN0GJ9vEfZHEhLrhtftOn8ZraRHb96Asg9C2P1HT
         Jeik9ZLW69xGNN0/kf8q4S9hGaiOhdvtnOFvIEW8Dhl2BU0D3+3tQ554ApETxbsY+i33
         GdZ4U5dkp3Fj43YDdVdLvNSA9MyQ0NtVSLAUPIm6N9RElu9OoRXjRaIiWWOH9DKLSDFf
         tsbrc/WSs68K+LnWQVbzX9/kWjXcqae+KazTtLrkTUYzg8Fx5Vpz2UADW74VuDRKw3MS
         /1etNIxw+fwZs+FUbZEzGi5Pe6jH47psuS71ldENqbQEe/AX6e56GgzafOkDmf6QZwK0
         luLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749806451; x=1750411251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JuBgDMu8hKVmxRubAKopvVS3wNUvEuyFL7n2iAOcpfA=;
        b=VB/VggHslV6rIY4P2XXWDh5weHQdYS/fR6vbHpJyWEsH26OWmvZyrPW6NHYVYfZfFc
         i1erEq+33c8hCGB0iJOCya2zGBrhsCuJyZzofwOHyA2gST+X43MGuRuCDMgh3I0g6dcs
         ra1+liZ9kxhJ0JmKfNK43rhm3T3j7ejLcXqH/Zuu/0UOMizHK8ZbdBhCIYXhbI3cocfR
         pLU2qX0DqBLNNeMx0Aupu8zU5PmxljYv9AMTA8LQC8BdhZMgq+QjSwFkYMdhebdR53PV
         /G9SQ0eFn2+8auYe9TtkGAvCL5UFCsFzj1zNlbkoC644SuzkZV6332roQO5UuqQ1TxVD
         xLWw==
X-Gm-Message-State: AOJu0YzEUm2fa6+PwuzABYBuFygbjFv3ykF4XrYoKvv3V0nwZ6+T0Pna
	1PGTuSApkZgDse7l85MN2D4B9ix65RJt9ZgyNs1ewocyiIXNje11F8X2
X-Gm-Gg: ASbGncuc6FFroOQwcWw2pVig1qYv8ulVonGcoKX+pn61buPVcU4NVqL6wP4W2Uwp4bh
	l+TpNyOcE3XVNhriolQcLPZG6hdhPmyF88Q0FjVIOSwcwCIQp6DM/ldRjXy6NldSdEQfH7tqz3x
	fToyRgfF5dYuij1Ra+GIsXPdBE1wikmQ9knDZ4ByOCbQly9g/7jEoZA4UvZIAxvSlh8/k1BDxZV
	dRPYE+kjoOe4e+a0uVJ09z7Ci//txuXVJp+SscggNoewm3Z/C8u0QDF5qoIhNLo/+rJyfcQo4ll
	8A+UUOLcZ5TeJR8KZ78WKaNQ6vVJTbQ0Q7kZy3rgvxdb88TMjlQQELeaEllzpGS1qaMa15GPcbh
	SKfP6bTqV+C2hyA+dnzx00W0NOlM6Ps7ODjo7ppeoHincYB4ecPJjtR/jEOX8vI2lsp2nbHOBqg
	==
X-Google-Smtp-Source: AGHT+IHfyneShg8hfkGbjB6Pqb/ZZJLCk/f8vb8b5tYnT/wsvVlUhJ+XJlfAxh7Xrpl/K9hIbWI/kg==
X-Received: by 2002:a17:903:2ace:b0:234:2d80:36 with SMTP id d9443c01a7336-2365fb3dc95mr28393765ad.14.1749806450838;
        Fri, 13 Jun 2025 02:20:50 -0700 (PDT)
Received: from ?IPV6:2409:40e3:18f:923d:783d:9594:9008:776e? ([2409:40e3:18f:923d:783d:9594:9008:776e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365e0d0abdsm10039855ad.254.2025.06.13.02.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 02:20:50 -0700 (PDT)
Message-ID: <c9c39e01-1244-427b-a496-ec35e43f7636@gmail.com>
Date: Fri, 13 Jun 2025 14:50:45 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cat-file: fix mailmap application for different author
 and committer
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, viakliushin@gitlab.com,
 johncai86@gmail.com
References: <20250611062643.8639-1-siddharthasthana31@gmail.com>
 <xmqqy0tyi8aj.fsf@gitster.g>
Content-Language: en-US
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqy0tyi8aj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/06/25 21:23, Junio C Hamano wrote:
> siddharthasthana31@gmail.com writes:
>
>> From: Siddharth Asthana <siddharthasthana31@gmail.com>
>>
>> The git cat-file command with --mailmap option fails to apply mailmap
>> transformations to the committer field when the author and committer
>> identities are different. This occurs due to a missing newline handling
>> in apply_mailmap_to_header() after processing each identity line.
>> ...
>> This ensures that all identity headers in commit and tag objects are
>> consistently processed regardless of whether the author and committer
>> are the same person.

Thanks for the detailed review and suggestions!

> Nicely described.
>
> While the above explains what is wrong in the current code, it does
> not tell if that was buggy from the beginning or we unintentionally
> broke it.  It seems that this logic came from e9c1b0e3 (revision:
> improve commit_rewrite_person(), 2022-07-19) when a much simpler
> version of commit_rewrite_person() that worked on one "person
> header" at a time (as there are only two, author and committer,
> anyway) was rewritten to use this function, and it was broken during
> the rewrite?

You are absolutely right! I should have included this historical context
in the commit message. The bug was indeed introduced during that rewrite
in e9c1b0e3. The original implementation processed author and committer
separately, but the rewrite introduced the loop-based approach that failed
to properly handle the transition between identity lines.

>
>> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
>> index 4a6242ff99..98dd0ae12f 100755
>> --- a/t/t4203-mailmap.sh
>> +++ b/t/t4203-mailmap.sh
>> @@ -1133,4 +1133,37 @@ test_expect_success 'git cat-file --batch-command returns correct size with --us
>>   	test_cmp expect actual
>>   '
>>   
>> +test_expect_success 'git cat-file --mailmap works with different author and committer' '
>> +	test_when_finished "rm .mailmap" &&
>> +	cat >.mailmap <<-\EOF &&
>> +	Mailmapped User <mailmapped-user@gitlab.com> C O Mitter <committer@example.com>
>> +	EOF
>> +	git commit --allow-empty -m "different author/committer" \
>> +		--author="Different Author <different@example.com>" &&
>> +	cat >expect <<-\EOF &&
>> +	author Different Author <different@example.com>
>> +	committer Mailmapped User <mailmapped-user@gitlab.com>
>> +	EOF
>> +	git cat-file --mailmap commit HEAD >log &&
>> +	sed -n "/^author /s/\([^>]*>\).*/\1/p; /^committer /s/\([^>]*>\).*/\1/p" log >actual &&
> Perhaps just a  matter of taste, but
>
> 	sed -n -e "/^author /s/>.*/>/p" -e "/^committer /s/>.*/>/p"
>
> may be easier to read and more portable (as some implementation of
> sed is picky about semicolon concatenated multiple commands).

Good point about portability and readability. The `-e` flag approach
is indeed cleaner and more maintainable. I'll update both test cases
to use this format.

I will send a v2 with:
1. Updated commit message explaining the historical context from e9c1b0e3
2. Improved sed commands using the `-e` flag format

Thanks

>
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'git cat-file --mailmap maps both author and committer when both need mapping' '
>> +	test_when_finished "rm .mailmap" &&
>> +	cat >.mailmap <<-\EOF &&
>> +	Mapped Author <mapped-author@example.com> <different@example.com>
>> +	Mapped Committer <mapped-committer@example.com> C O Mitter <committer@example.com>
>> +	EOF
>> +	git commit --allow-empty -m "both author and committer mapped" \
>> +		--author="Different Author <different@example.com>" &&
>> +	cat >expect <<-\EOF &&
>> +	author Mapped Author <mapped-author@example.com>
>> +	committer Mapped Committer <mapped-committer@example.com>
>> +	EOF
>> +	git cat-file --mailmap commit HEAD >log &&
>> +	sed -n "/^author /s/\([^>]*>\).*/\1/p; /^committer /s/\([^>]*>\).*/\1/p" log >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>>   test_done
