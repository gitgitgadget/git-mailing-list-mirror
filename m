Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED1113DDCA
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731987; cv=none; b=f33FlKfVcXGtsPwr+2yQK5Lh1H242Xugv1dDqGfagaRZuV1y9qqWcpsIrXgDNU00/LaOLLmoK3ZVkT9r0gEtC2d5+OIdX4yQMNq7sfMcJzyl5SypA4IhzDI+vhxpgiaqST6wvrZrGyuvwSJJL0I3Q8heV8FSMxN7BIQYjKUPBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731987; c=relaxed/simple;
	bh=mBQNkLu3tDYPykb4FaJ9764WMQji6iy+jzGncy30Tts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcZQ/RRIk+SZaQ+fUMjqZybAQ/X2lGTxXyfGME2GxXOdqKzgFf0aR1TeSaA+f/wB8sBOVWpSZJ/LDjrcG7fjQ1YAgr1e8FWRbKM/FOyX/aNJbe6EVOMrutn7l8HnUm3a/1sHTQKB+Lproq8EiT8VovFoSAI+YjXvHGvoXphQA1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=UyTXwcOq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="UyTXwcOq"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7024d571d8eso4410263b3a.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 10:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1718731985; x=1719336785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P78MKmFZtcN2BxJ5V0loQjEDg2qOqYpUz3r9IvDB9q4=;
        b=UyTXwcOqrvIHIa43D/yF7x6mEJKNYokEhSp1xq6QPgTJcStsTKNOHuGeSudY9OWMTh
         HoNuZiRkT2/coNdyOasEZcBvWGBux52gc6U5wunJDb108q5409ln5F+8GN8nYzY8nztn
         GyrEKO45KvyitWkkeQhCiSmGEWeMhvBe0OJkI5hZQJMMuRLUKv8sX+BoVSFliI0ihGPP
         6s3vLdenoVNR3CPpcCM03ilvp/JFUtX6MMoolfm4lC2D8XwSlKKt3FwkWUWop6/XOxpy
         yRj0AvF++2eBUS981qL6akXoflv+xO6BuKJZp/UId2SUeSrEptyXTrImuqd8FBJTCXoN
         0VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718731985; x=1719336785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P78MKmFZtcN2BxJ5V0loQjEDg2qOqYpUz3r9IvDB9q4=;
        b=QMmi7lEkItEvDlY31zyFoz0WHklZxJ9iLFV5U1c07Jcbxg2Izs6fguZQMennGuW3U3
         nZFQ09/y/Jhl0tHijZH1JDs1u6U2K0A5aq0bkF/kKr1yK6jWwLPBJHJApz102Z0k8s2D
         ZMbtuN5FWBJprSFAxbsi/milMLHneqW+L7vVjWdBUUgnsCTfteLrxRm8GLt2tL40e2ww
         znMdYxb+wqnFkOOdRd581V/5ZpVWl8pUbaDFTyQlqubMEnvmQDEZ0M8tlrYrI96aILMR
         KWTbcbDpul0BGnpC9sGtQQDgw/y7NwZgNvtnQ/QFj3Q0KvEYfnXH4cLr7Y4BaUNJCKIZ
         zWrA==
X-Gm-Message-State: AOJu0YyYD5SH+0PAm51fpoPtatCutV83h8nlesliE7fGvAu6VawNPqiP
	RP+zrk4hPY+oG5IewI+4X1HtPd5JSw3epfuuZZBwiTlLiH9IRxyjddo8CQ8k
X-Google-Smtp-Source: AGHT+IGtFo38A3KDT0Y7S1tGhhPqO4nafoHl89MCPUB/6DAg9/6uW21W5Tw16p1s0TH08j6qkqcNFQ==
X-Received: by 2002:a05:6a20:1325:b0:1b8:b8bd:9427 with SMTP id adf61e73a8af0-1bcbb6173a8mr226464637.50.1718731985663;
        Tue, 18 Jun 2024 10:33:05 -0700 (PDT)
Received: from [192.168.50.41] (syn-172-091-184-234.res.spectrum.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91d364sm9211550b3a.30.2024.06.18.10.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 10:33:05 -0700 (PDT)
Message-ID: <96f0ca92-b30f-4a7a-bf67-1967d8399177@github.com>
Date: Tue, 18 Jun 2024 10:33:03 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] index-info.c: identify empty input lines in
 read_index_info
To: Junio C Hamano <gitster@pobox.com>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
 <7e3bcc16e23c97d8a4efbb9e14b230ef9f44a1a7.1718130288.git.gitgitgadget@gmail.com>
 <xmqq34pjt7m2.fsf@gitster.g>
Content-Language: en-US
From: Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq34pjt7m2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Update 'read_index_info()' to return INDEX_INFO_EMPTY_LINE (value 1), rather
>> than the default error code (value -1) when the function encounters an empty
>> line in stdin. This grants the caller the flexibility to handle such
>> scenarios differently than a typical error. In the case of 'update-index',
>> we'll still exit with a "malformed input line" error. However, when
>> 'read_index_info()' is used to process the input to 'mktree' in a later
>> patch, the empty line return value will signal a new tree in --batch mode.
> 
> Interesting.  We could even introduce "# commented input" but that
> is a different story ;-).
> 
> I also wonder if we can flip it around and teach read_index_info()
> to (1) silently accept and do a callback when it recognises the
> input line is one of the supported formats, and (2) send any
> unrecognised line, not just an empty one, with "unrecognised" status
> code.  That way, the caller can handle more than single kind of
> "special input line" more easily, perhaps?

This is an interesting idea. The simplest way to do this would probably to
have 'bad_line' stop printing the "malformed input line" error and instead
return INDEX_INFO_UNRECOGNIZED_LINE, and pass in a strbuf so that the
"malformed" line is available to the caller.

That seems simple enough, so I'll include it in V2; I can always revert back
to INDEX_INFO_EMPTY_LINE if the generalized approach doesn't work out for
some reason.

> 
> Thanks.

