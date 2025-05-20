Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAC288AD
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732883; cv=none; b=rMShosLo3mzVPdK+nV9QTdfpX8PySRnNCT1US9YVK9c5exY/ZQYNsGEPj/WWJVs0uin1dkByseW+oZyEZg/zBjuVQsYVJceoWMRBflkK5+x30jw9l8tiwXyGl0RoAAqBVYNlBRBePO6uX3azkJOI/k06Z/5YJt4/ZOuMrsfajkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732883; c=relaxed/simple;
	bh=RyrLIcjVLAPsh2Ss2QECsns4607dDWV3a5c2U+rTgkU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lbNY5UFYK082Aq3ynS8Hd6zN6Zus6KxXsEjYP6DVs4Ffeg+LXAhiYjqTWXp4BE5pYZ41Hn9tcIQHgMMVvKDNkmnZw+9S6c6BVOlUkweEbppA/4i4jxdUsEht81E0xZ+f0u2xtRGarXBdCVAqhvHxoMv7qkIpKmgKvps2F0TqgcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyUbHa9U; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyUbHa9U"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so34612515e9.0
        for <git@vger.kernel.org>; Tue, 20 May 2025 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747732880; x=1748337680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Vpkcf0FOty4d585/A4MY56Gla1juoF7K1xHSc+tRv0=;
        b=KyUbHa9UXlLfeVXcOMTDZJVFMoszLh4IrnpvnMxrc9OxHJdK8ktbnMEQWMquAOxoTA
         r+c5e0+r9Fn2ZzAiPJAXDcC0FCoup9glu+nPXVYtQZ+RXL3cvuC3ymsKNj6bc7EAXLDc
         GoaVVvNNLLbyPqPnD42gwtox3t7/xHc3Er7CJOiqzGC2ekWN6nta7FuyjypT17ioB8Xe
         Vl0dlXWhBpwUF521C6whZmocacFY+eokgJ4w7VbuQGCNwox+3XIGKgl2PbXHpLN21N6F
         JrKx/f++i0AnEHFujGyjiIjNk1VPCeCgXCxyf+UQf7fXwcq2cew5hHxkqdg1/eOxegxt
         NP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732880; x=1748337680;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Vpkcf0FOty4d585/A4MY56Gla1juoF7K1xHSc+tRv0=;
        b=md9Oe8UR2GUZawDawsi9NxCNcRjdwBu0hSplr+LFEvbIftExt9brwcgBqZR3OvMNS1
         Ncx7UNevmNyWGvdaNOjOGGTTTqrkqvk60GLutP3Lhz7TtD68nwFbnbbSRJTBOSvWm85a
         DAel4PIWafK/+NWyIoZizk+F7XJQU+F93FfEQh7fcjcwylxPeTdtUMyu1eFVKmNCuf1W
         xlO83MnggeMX3MCx7acrB7Y5mVJ4FnrW0dXLrRz4SSYA+GrkRu3Tma2JfMBu+78/RlbV
         zr+t8sulHLOSG1Uu7k77d2YEA6N/uNFyFTOScwO2GOIdBy0jrr0Kpb7AXuNBGcCuM88d
         8JuA==
X-Gm-Message-State: AOJu0YxZYtEjiIrQMgLaWmjouPaH25rPa1FwQAIpRQideiepglNXhdnz
	Z6sflAQYsNhbPoHfRPj3TWaWcItPQi+dmxsUXqNVjyrQujguHsikZwj4
X-Gm-Gg: ASbGnctnlr5wi0S2wAQcEv4fzNQrd2L0p++38puMRnk7IdjvLTziZZ0SlSePXznACQN
	QLtk+aQs1GI+bCKcYtNwlCX9ZCFA6RTIobsqYAr+R+I5Ebb0gPAgOhe6c/1NI52XI0DRd8P7IWq
	TTNND1IQxJlarDphc1beBUwDJjejPOYFJmIZT3/8oYlXHJp5qMGW2FggIk/KKPFHZDzMkL0QSj0
	b6lDX0FmqRvBIAo+SmGTaLl5nQHVmb0A9BqBVyM3YQG/51FYIYTsJjdiWAZZ23SoaFSlp2xUReO
	znFpiEgQnvokSQvLJ8Qoe0ww90wdC378kudXxAIr0XQ/J2AdJYMtzNkQoz00mC0zGY52ofPw+cM
	b6Ga5IbOrprc/IRGdSEnhVtjAnXA=
X-Google-Smtp-Source: AGHT+IE7lpQ6G2ehxl12lpPTkWAtq/koMFcsn9C+Yu9u2aB+IGQehuJ93aeouB/vW3qNUrJlClDUSw==
X-Received: by 2002:a05:600c:821b:b0:43b:bfa7:c7d with SMTP id 5b1f17b1804b1-442f84c2008mr178912245e9.2.1747732880137;
        Tue, 20 May 2025 02:21:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f23c07bfsm23825715e9.23.2025.05.20.02.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 02:21:19 -0700 (PDT)
Message-ID: <0ca879cf-303c-406f-8040-cc0c7e9b0964@gmail.com>
Date: Tue, 20 May 2025 10:21:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] stash: allow "git stash -p <pathspec>" to assume push
 again
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
 <xmqqtt5ktlqm.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqtt5ktlqm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/05/2025 20:10, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Historically "git stash [<options>]" was assumed to mean "git stash save
>> [<options>]". Since 1ada5020b38 (stash: use stash_push for no verb form,
>> 2017-02-28) it is assumed to mean "git stash push [<options>]". As the
>> push subcommand supports pathspecs 9e140909f61 (stash: allow pathspecs
> 
> Can I safely do "pathspecs" -> "pathspecs," here?  I found this sentence
> hard to read without a comma.

I'll fix that
>> in the no verb form, 2017-02-28) allowed "git stash -p <pathspec>" to
>> mean "git stash push -p <pathspec>". This was broken in 8c3713cede7
>> (stash: eliminate crude option parsing, 2020-02-17) which failed to
>> account for "push" being added to the start of argv in cmd_stash()
>> before it calls push_stash() and kept looking in argv[0] for "-p" after
>> moving the code to push_stash().
>>
>> The support for assuming "push" when "-p" is given introduced in
>> 9e140909f61 is very narrow, neither "git stash -m <message> -p
>> <pathspec>" nor "git stash --patch <pathspec>" imply "push" and die
>> instead. Fix the regression introduced by 8c3713cede7 and relax the
>> behavior introduced in 9e140909f61 by passing
> 
> Hmph, is it too much work to have a patch that only fixes the
> regression and another that extends the feature on top as a separate
> patch?  Not that I am opposed by the new feature, though.

I can do that, I was just being lazy skipping the separate regression fix

Thanks

Phillip

>> PARSE_OPT_STOP_AT_NON_OPTION when push is being assumed and then setting
>> "force_assume" if "--patch" was present. This means "git stash
>> <pathspec> -p" still dies so do assume the user meant "push" if they
>> mistype a subcommand name but "git stash -m <message> -p <pathspec>"
>> will now succeed.
> 
>> Tests are added to prevent future regressions.
> 
> Nice.
> 
>> +test_expect_success 'stash --patch <pathspec> stash and restores the file' '
>> +	cat file >expect-file &&
>> +	echo changed-file >file &&
>> +	echo changed-other-file >other-file &&
>> +	echo a | git stash -m "stash bar" --patch file &&
>> +	test_cmp expect-file file &&
>> +	echo changed-other-file >expect &&
>> +	test_cmp expect other-file &&
>> +	git stash pop &&
>> +	test_cmp expect other-file &&
>> +	echo changed-file >expect &&
>> +	test_cmp expect file
>> +'
> 
> OK.
> 
>> +test_expect_success 'stash <pathspec> -p is rejected' '
>> +	test_must_fail git stash file -p 2>err &&
>> +	test_grep "subcommand wasn${SQ}t specified; ${SQ}push${SQ} can${SQ}t be assumed due to unexpected token ${SQ}file${SQ}" err
>> +'
> 
> Good thing to test.

