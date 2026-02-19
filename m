Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD202C0F8E
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771532640; cv=none; b=DeC3GwjwEgt04+VqYtpmPBtR3d3ydm7i8+s8rUx3XhlPreUS9lqKZEPxyqBu4RCGq+fZmryDlf/GB1uOenHK6vKkqYQST4hIOL9MO8vsH3xi6otnxi5IrQvOuR7P6VUTEwWIDJq2hqltNxsAiCyDjSk+dbh2fq6ohZSYfhF9U44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771532640; c=relaxed/simple;
	bh=/7kYjO5wnt9K4X8Fx3+Yj9w6XCWP78GoKt1a+JD5j9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdINq4WULxiLcVlOfydHMwa5TW+/Yh78zrog9xW/C+mdI/jzVTHlvH/14jCUgZOTyIqisji5iYlppTsZ1K0+BcVG+L+kwPna1ZQfSNdE2HL95MqnSVOvPt3Ep2xoSDn5e5CgK3KXDvOI3hhj1o0cc+X5jIxOHJTuElCJqrBC8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=VFHj+Kvh; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="VFHj+Kvh"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ba90683995so663344eec.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 12:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1771532639; x=1772137439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhvEBpuFLSzJ9h93Z7iAr9DIrtra0xETX7uGudBqdGc=;
        b=VFHj+Kvhn9x4fKHzW81deiEkruct8z2KCLCeGLdF2zYU/2jJxGzAhRGYofx4E5E79S
         qM8bx9dly9WnoYh/AC19Blwa5NdqFANukZI7kfjxYcOnY/5lxlCEZLa5pmmURXfh71Sl
         LSHtS7AvrZZ3URqjB/S5ISPT58qnpnfeZ7+DbvLC4xk2bYBUqqVGEIgkdnwRFC62Gc72
         iCyRvIS6zIIqgh6Hl06Z3VKVOsveJx/pna4s6nSDp0ntbajAxstmF2dA5YIQmHL103Gv
         IcpI1LDX3JafyvpheFxpxCog7WTibl+mIstLqrAQ0GXeZ8zTwtEm8+rf5xAd4ntSB0E1
         P40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771532639; x=1772137439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhvEBpuFLSzJ9h93Z7iAr9DIrtra0xETX7uGudBqdGc=;
        b=M2NCPd7YPB5E6dmqy3pvg0qYAgwDSVTlJQxrVZpYBlJkqPdOy9U9Hk+a7qEqwvoW+c
         ZtGBnwKb5TPY6F7/BniH72cSrRZRImN7T9YDGYiEZr5tlUSXL5goGR6ndsYKtzOQFXDW
         N2AwYpElaiX/AW/h73ueC8uTbhj9ofVQ4w+Pgo9TfKnh0MOxHNRHo1TJrN7nhXEtrxj0
         GMFtrgFbKtSmSrIa1qD62QAokJJpLBKMBaXyaMZJGImlUd9QsoedkuZi6xukcRxpzLaS
         SzRKcV4oWWVhtwb829cl5jtTFB/mlc4FWvhNjlUIvw5tJ6h4njhMyN+ZGeQWMtRdyurx
         Qw8w==
X-Gm-Message-State: AOJu0YzkIC8BiMqQNPzOpfLmJQIDDsDNDrLSpeqG9mucC1JoXmkZb4Gi
	0kUtZayI4r8I+fPes9fgGYtVin+iGZefeShDYTwZYaiy1KSwm5kam0skbsFegZdA
X-Gm-Gg: AZuq6aLcujtegXctM25/zZKUNOj2X0TGn5wwHQb8Me/XZbcoJjFEmzup8sXA1QNt1dE
	ynxTi9haBOS2sXG/3JE0ACBHR3X9tmRV/Wy49PFcecp/ktygd0FknO79wg0tfAI/FPQJJ20JTcf
	ANSHxm0W5ZUPJlAybTz5XUXcM419fyJ5w6GXzUIAWLiq1Rypa9PTZaEZqKQPolseI5dYHhirQI/
	FDnHovHt95J9361rLUTDafifbNDisfZlsnqLxDdiizuhDwo5J2s7RR2lB+PiQYIqOjJe9hykyEI
	+ohvAOMJv4ESe7R8Hl8tRakom7AA05Sd5uwhfPIfAM3duHsojOSjK6e3ZDNOs4X/YxGfsBMS3bY
	MAt+XUFZcgJjA25NhBCdDuZnia09ep2quh3sX3omjsE2rSewLtZhIUxQHveNMC+/t6jS+Cf5cVK
	42zjlv7chqJtXbMxPDociV1ETnHC02TA9qk/jdxsTeaq502i86
X-Received: by 2002:a05:7301:1f15:b0:2a6:a306:efdb with SMTP id 5a478bee46e88-2bd60770487mr1222465eec.3.1771532638527;
        Thu, 19 Feb 2026 12:23:58 -0800 (PST)
Received: from [192.168.50.155] ([172.91.184.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb415dddsm25183414eec.0.2026.02.19.12.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 12:23:58 -0800 (PST)
Message-ID: <d2bf79b3-4407-4fa0-ae2b-fcb3178f36f7@github.com>
Date: Thu, 19 Feb 2026 12:23:57 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t1006: fix %(rest) test for object names with whitespace
To: Junio C Hamano <gitster@pobox.com>,
 Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org
References: <20260219152407.12160-1-deveshigurgaon@gmail.com>
 <xmqqikbs4iod.fsf@gitster.g>
Content-Language: en-US
From: Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqikbs4iod.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/26 11:50 AM, Junio C Hamano wrote:
> I am not sure if this particular FIXME has much value, but ...
> 
>> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>> index 0eee3bb878..cac88acf65 100755
>> --- a/t/t1006-cat-file.sh
>> +++ b/t/t1006-cat-file.sh
>> @@ -194,18 +194,11 @@ $content"
>>   	test_cmp expect actual
>>       '
>>   
>> -    # FIXME: %(rest) is incompatible with object names that include whitespace,
>> -    # e.g. HEAD:path/to/a/file with spaces. Use the resolved OID as input to
>> -    # test this instead of the raw object name.
>> -    if echo "$object_name" | grep -q " "; then
>> -	test_rest=test_expect_failure
>> -    else
>> -	test_rest=test_expect_success
>> -    fi
>> -
>> -    $test_rest '--batch-check with %(rest)' '
>> +    # Use the resolved OID so %(rest) parsing is independent of whitespace
>> +    # in object names (e.g. HEAD:path with spaces).
>> +    test_expect_success '--batch-check with %(rest)' '
>>   	echo "$type this is some extra content" >expect &&
>> -	echo "$object_name    this is some extra content" |
>> +	echo "$oid    this is some extra content" |
> 
> ... I somehow doubt that this is what 9fd38038 (t1006: update
> 'run_tests' to test generic object specifiers, 2025-06-02) meant by
> that comment.

That FIXME was intended to call out the behavior of %(rest) in cat-file
itself as something that we may eventually want to fix. The comment is
only here because this test happens to demonstrate that behavior. For
that reason, I'm also not sure I see the value of this patch; it's
removing some visibility to a quirk of cat-file without fixing the
underlying issue.

