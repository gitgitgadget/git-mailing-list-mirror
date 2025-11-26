Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F282033C1A5
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185329; cv=none; b=OIq1nWu8Wy8fRAk+nNCEgYhmWMrJWS19P9teaUD/B/Sq9CvaJf9uTG9vFOQpjwgNO29mE6cXtxhpkIrulbbBbONvZyGOQhciIWJyBGkZTTesrEeUXGOE3z4hJCZnzPCzVDsMeaTkm0apvek64yrgreessc1nTB5B7cOe6UhM8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185329; c=relaxed/simple;
	bh=iybYpzehGmIh7vLzxEy7qQ0uPAUOL00CjSl1zfyl5mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0+oOhAMmOgm7oz4oRF+xhC06v/yaQMReFoXfYDNRzwnjR/eGZZsEEEyHWvj55pplGeHOzBepMhoeXq0LEJgQCE86pYlyVHnstlBC2Yeq0WKWexJPwOK5T8vus2bF+xS9+WBgVmqn4jKJqwZbm9z5T7dyRRPZZPo+pZoit/YiuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv3Qhm86; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv3Qhm86"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso46058b3a.3
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 11:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764185327; x=1764790127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYgKojYqQ4M09EIsZfFHhmUMaF+oTC2/N0SXY9ZhFTY=;
        b=kv3Qhm86qVvTlIP60FLScIYkFo7Np7edjPbchB+gky5BmfN5t9i9uHP89AdWUQ2EJy
         4m7vkEwp8VCxT9OJoOgF1XbyxLdUrNB02tHi/XtBPYNDiOon5v0rDBkIE+A5t9IspSfZ
         W+KX9YRRy8Ba6qeTaDSDsIvraIFZi72Jx8AO5Kibk9OzEA5FPy+dH04NmT4JujXE0GGB
         eutQjH/QbxMtK6RB+Q06rAOLeUIDeeIn8J7MouBRsdCvxQOjJOBEPtrARsSuEWkJC+rW
         dMuBTVv8xlLVNbYgMApqaS+SWPnhaZ+MfnqHzvc8C44qrD5guWULkjBLTzzx0Zam2FHq
         tp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185327; x=1764790127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYgKojYqQ4M09EIsZfFHhmUMaF+oTC2/N0SXY9ZhFTY=;
        b=ZDJnuGGBKFgf4DlDwbgbPMR1/mvnMREvs9h244Om+hkd/8DktnsB+E8Ku7L/QRJ81h
         KPceS0T4FwBnIROPCGuv+QqhEdRK+LbTzV9OxZdvnVJbi+P73G6Hx8P8BOpRDbdoYWUL
         aIHOnBwwLD+oBqeEYvKQwaGs8hGCEX3FycZj7ni+AZOs9a+2/Zvvjdgef7RC+mya0Oip
         y3aYX/jJzxzXgscLeaas1V5goFrOPHwmCvU3iT+LUhEKFe0N07CivPdoRh33oWZlLszJ
         tokWn7HBfQJOplKSDRuGCWO6b1BWc04YXd1rnAHWzu9pgo7ilYmDRI0c17Dw4nYkR6aK
         XQBw==
X-Gm-Message-State: AOJu0YwMAVDVqezaesBQgt9T3GVm1uJEB8ZoyhijiuAnj5k5zptyNksf
	2cvNCSYzgqbFSNvgHh5G4glxPOL9NzHflboNdpL+A3DoIxRRbroIDTRJ
X-Gm-Gg: ASbGncuPXIN6iLs9Gz899zXXPfVm7cE/AZB00aayEVfNZGCi/WLLxzUFqQPonlwM7N3
	quzDEcrTqyEnUFpEtdZfq21ZLJhCGayoCNVPxGrC5nbMkr8lFo1slh2HXvf6yihnISxxJwOUtUQ
	vhT570P8iHe57iB/pr2THu5JmTu2N2b6j0Hxu9xyY8ewhwR4bO57r+nYOPBrSrZegmw4ksj9d5r
	xwuPTQEQ/k4H64F7OIQi2Wl77HZ7JViZtidnT7I+W4RQB8cI94EfDVHrp8/jL9QlWJrRkrt1RBS
	x+ULBeEGX3b+U85dKPbUzmK0mrxAocqLfi1VbBUrdNKwKGS6JzmjG/RLdUysWRrRAwYFmYdKfUA
	082VDIJRmQpy3MGjFK8l2oelmtdBMvTwS8nkvaZY+TBmGJilnGXFN3R7wLgVWwnzyTPV6s9netI
	WJsG7aln3ffacnrHtZmYmaquSuGEPTnch1WDNs/PLT4kVQxh6fxUyk50u7hKAI8Q+oZ54q8d3C/
	BBDt0nIsC56BxKq8YNCzvE=
X-Google-Smtp-Source: AGHT+IHHoxFPBaXjgrpD8RnGKEJQ1EVyW1Fn8Oy1yYerSJKxQcUq0k7uS9FCdxj0dobuscxHWgGRxA==
X-Received: by 2002:a05:6a20:a105:b0:350:d523:80a4 with SMTP id adf61e73a8af0-3637dea0199mr9085972637.28.1764185326840;
        Wed, 26 Nov 2025 11:28:46 -0800 (PST)
Received: from ?IPV6:2409:40e3:30a4:b776:bc94:4b73:d55a:67b2? ([2409:40e3:30a4:b776:bc94:4b73:d55a:67b2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd775ccabfdsm19885592a12.29.2025.11.26.11.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:28:46 -0800 (PST)
Message-ID: <515c997f-f562-4081-9c44-5a3049d75121@gmail.com>
Date: Thu, 27 Nov 2025 00:58:40 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251125170056.34489-2-siddharthasthana31@gmail.com>
 <xmqqwm3drk6m.fsf@gitster.g> <xmqqo6oprjti.fsf@gitster.g>
 <xmqqjyzdrjf1.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqjyzdrjf1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 26/11/25 01:09, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Dedup with do_pick_commit() where this was taken from.  Possibly in
>>> a separte patch before the main one.
>> Forgot to attach this at the end.  What I meant was that something
>> along this line may be a good starting point.
>>
>>   sequencer.c | 14 +-------------
>>   1 file changed, 1 insertion(+), 13 deletions(-)
>>
>> diff --git c/sequencer.c w/sequencer.c
>> index e6d82c8368..29909952d4 100644
>> --- c/sequencer.c
>> +++ w/sequencer.c
>> @@ -2365,20 +2365,8 @@ static int do_pick_commit(struct repository *r,
>>   		if (opts->commit_use_reference) {
>>   			strbuf_commented_addf(&ctx->message, comment_line_str,
>>   				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
>> -		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
>> -			   /*
>> -			    * We don't touch pre-existing repeated reverts, because
>> -			    * theoretically these can be nested arbitrarily deeply,
>> -			    * thus requiring excessive complexity to deal with.
>> -			    */
>> -			   !starts_with(orig_subject, "Revert \"")) {
>> -			strbuf_addstr(&ctx->message, "Reapply \"");
>> -			strbuf_addstr(&ctx->message, orig_subject);
>> -			strbuf_addstr(&ctx->message, "\n");
>>   		} else {
>> -			strbuf_addstr(&ctx->message, "Revert \"");
>> -			strbuf_addstr(&ctx->message, msg.subject);
>> -			strbuf_addstr(&ctx->message, "\"\n");
>> +			sequencer_format_revert_header(&ctx->message, msg.subject);
>>   		}
>>   		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>>   		refer_to_commit(opts, &ctx->message, commit);
> By the way, I probably would not be queuing this version today, as
> this has obvious conflict with a large code movement made by
> Patrick's "history" series, which itself is expecting a reroll.
>
> Perhaps collect review comments on this iteration a bit more and
> wait for that other topic to be rerolled, and if it turns out to be
> solid enough, base a v2 of this patch on top of it?


Understood. I will wait for Patrick's "history" series to be rerolled 
and base v2 on top of that to avoid conflicts. In the meantime, I will 
address all the review feedback locally.

Thanks,
Siddharth


>
> Thanks.
