Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE633470A
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780203; cv=none; b=pJ9PD1/zBdo57UJbPyhLJMo6uOXryH/SgMQvgisf0nUfu5yTWFfamAv4StX2GoqTsInfDDOsPMJDCEJcydv8Opl0aUUmo7X7HXsi0rDfxY3Z2Pckry3SIGGXT6d63X7Z0XLDAUIySncR/iYskRGnO7CGDE6LJJzj0pFN5+kLjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780203; c=relaxed/simple;
	bh=Gs1YdTQnF1kfXFPrb2gZLPvaqQ3TkSZ2p4hl2LPEbfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTB28tdmBQSreBkf2LafiaJUzgwhuz3egy9wN/6dJ+EeHItzyZg/h7xL8KPrwJjrjnmLV/8UqTdlbpXx1rS6lQR+1Jggbrb9UYjyARHil7movh5MTWzWBBctBVf4yZwt/oAC286dB6vWTgbPAPcIpIjK99yF66T556LQSyBtUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLOISPDp; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLOISPDp"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e872c3a0d5so80358885a.2
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755780201; x=1756385001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXzzrGgoE2whLpCiB9pAlq2/n0L0fs+qKHgo1cLu6ag=;
        b=TLOISPDpbLZ6unxXveZXv82lYG+jQQHcxljp4k93beOSysFaI/EszxmQ9p2VQq8Ugg
         T1Rf8hBFCe2lTPC7vZdkBok4d5boXPNeeXeC1m+teNz5qzlnvyvCZfd8DT6f/FIs7d0R
         L/j8/CcTJ42D/fMrGWBhXQXJ/Kb5gYg74xv6MIsN0BOt/G+Kc9eA1BR9ew88pRTRO8Vp
         PfkmDbDwh2UqoJvJ48hXjzYg+Ug5QWGVVtZ2v/1b5cgLffhX3gV6Pm8a/TWnDy7Mqx+6
         rz3ByJu2MBczIYBSHNjOxbGT0aDCCN5Mdd494BSFPRL0iKixKByw1ZshljhZToeQ8O1H
         2dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780201; x=1756385001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXzzrGgoE2whLpCiB9pAlq2/n0L0fs+qKHgo1cLu6ag=;
        b=fO8kIajVJrDD/d7AUxbaFlZ3NYDbjxKcU8nXnlV9lGTvPndMI63Q3iJerinhInoBP6
         214UwMSZEHFAK3acMZIrjX9Qaxd8JIYPtId7ZBkByu8hLO317CKv/ewQjIg2/Enttlsw
         kGOCHW6pWtKaTsUSr9PcfqB9XxcvLj6SvEJ4n1yJskeQq5ZS37HX54z9fd1fWHIe+AIT
         rs9oRnqsOXbSd15GQEze2OdHScTrZGZChqlHhFIcA33aK9ZC8R5yy5NQvaU1Dj29HO1K
         zIiF3UNg1rKsEAi+8i5rGe2WGmpMqF7/FKzRdfkBRO9nDsW2fRf2oZ4AxBMBvmjcIdMs
         5YIw==
X-Gm-Message-State: AOJu0YyTxPSqAiS6LHjuaH3YnLK2K5PouILJe6yLwta32iq5GtMJyiL1
	hcyZ8QuXMoHFrGTDKylWk5IFbo/c5f3e7kRb0VKI7qXAEi6Bd5McLjU2
X-Gm-Gg: ASbGncuGu8euLewwFFc9pRQSRx7cYH877WnHTFtKe5edF2MxcdDuzqeR6rTtV7KTcYY
	DDYQ0AwXkBlHiYKumrLFyvFtNVBOoYhoshyyvybjEMYJjli4iaMO76yPaix/SCfxCoOlXYr/nGN
	M1lF33Bg4fxPDjUyTUuFtiqmyaQnbpTyi8RhUSjV/gHkWjE+t/BkshMDR4O/zj8GvaGqt0rGN7I
	pxwpH39EFPjKZYYcFa1sR3TxSac/JWVhqh2jUJ6oWjkzKC3fJSUuPREiVAKvbd1IaOLGFzb5vVo
	/9RjYGvp8CjFjU0OlUmSC5xab3krV4GC42qP+oEwSxJVE+dii3xseQ9upyanjjTHb56WrvgkNbp
	EF5QEfnSfoE5BPFZsNXouRuA0P7J+VcN2XRo=
X-Google-Smtp-Source: AGHT+IGPJrhr2vylSdoBvD2n7MXpl0mkOmQnYFMeT+nPxBHdU/lMw33FkTBK0l1F6fUtdGkXQZHQOQ==
X-Received: by 2002:a05:620a:2941:b0:7e8:6cf:5fe5 with SMTP id af79cd13be357-7ea08e7b0d0mr235821185a.65.1755780200688;
        Thu, 21 Aug 2025 05:43:20 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e191efdsm1136124085a.44.2025.08.21.05.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 05:43:20 -0700 (PDT)
Message-ID: <d9f69281-6aa3-4ef7-b52f-9660bc60a46d@gmail.com>
Date: Thu, 21 Aug 2025 08:42:58 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] t7700: add failing --path-walk test
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com,
 karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, me@ttaylorr.com,
 newren@gmail.com, peff@peff.net
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
 <5b19173c03da676b3e1effda7ba6d2ef5666cad6.1755715196.git.gitgitgadget@gmail.com>
 <aKbSObIzXwUtjAdE@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aKbSObIzXwUtjAdE@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/2025 4:00 AM, Patrick Steinhardt wrote:
> On Wed, Aug 20, 2025 at 06:39:54PM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
>> index 611755cc139b..1998d9bf291c 100755
>> --- a/t/t7700-repack.sh
>> +++ b/t/t7700-repack.sh
>> @@ -838,4 +838,47 @@ test_expect_success '-n overrides repack.updateServerInfo=true' '
> 
> Tiny nit: I would've probably squashed this patch into the second patch,
> as we usually don't use the add-failing-test-and-then-fix-it-later
> dance. On the other hand though it gives some nice context, so I
> ultimately don't mind it all that much. So please feel free to ignore
> this nit.

I'm probably the person who is always asking folks to create a test
that either fails or demonstrates the "before" behavior before making
the actual change that updates the case. This allows the ability to
"test the test" by checking it in place to confirm that it is indeed
failing.

Using test_expect_failure allows us to avoid breaking bisect. 
>>  	test_server_info_missing
>>  '
>>  
>> +test_expect_failure 'pending objects are repacked appropriately' '
>> +	git init pending &&
> 
> We probably also want `test_when_finished "rm -rf pending"` before
> calling git-init(1).

Good idea.

>> +
>> +	(
>> +		cd pending &&
>> +
>> +		mkdir -p a/b &&
>> +		echo singleton >file &&
>> +		echo stuff >a/b/c &&
>> +		echo more >a/d &&
>> +		git add file a &&
>> +		git commit -m "single blobs" &&
>> +
>> +		echo d >a/d &&
>> +		echo e >a/e &&
>> +		git add a &&
>> +		git commit -m "more blobs" &&
>> +
>> +		# This use of a sparse index helps to force
>> +		# test that the cache-tree is walked, too.
>> +		git sparse-checkout set --sparse-index a x &&
>> +
>> +		# Just _stage_ the changes.
>> +		echo f >a/d &&
>> +		echo h >a/e &&
>> +		echo i >a/i &&
>> +		mkdir x &&
>> +		echo y >x/y &&
>> +		git add a x &&
> 
> Nit: I think I would've moved the explanations you have in the commit
> message into these hunks so that the test becomes a bit more
> self-explanatory.

Hm. That seems to go against our typical pattern of leaving comments
sparse and having the longer explanation available in commit messages
but maybe I'm out of date or tests are a different beast. I'll see
what I can do to make the test more self-documented.

Thanks,
-Stolee

