Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807153;
	b=wQv4oBOMWLM1nt6u+9CEh/l/TJS0N2tDtMslZ271uxvjJPWQbkY7DmGggbt1D+VEzkDX
	 r9tdaW0/XZfS1JR1zj0aZWAUVs2uPdSFspQ1YUoE7dC6kOF+DwJxZcxEMZyptT2pbq4Tp
	 96Ubt8N6y+/UF9Texsks6rItIS69Dq/maX690itvtq5lBBeP8ehDHLhobj2ucWCOspo8P
	 ie+9k9kXB9PLTI+bvw5TSJTGd+skoKgwavhhSxymTzIarnBP8nreE0gaNfCkLEQzkZMNs
	 WfG6WByKkosTY10YRBg7WT3VOo23yqqGi/uzvjXwSpGMuit0EEUx9TWYJ1QBQ3sq2+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=xUsg8DNFnZPoeGVNQF+kJARP4HUZXbwzWzCgWEx9BiE=;
	b=QoxeNY1zvYHKhVU8vczvr5e3LjnFcyOwHozS5i7VNNujMQZI4f08kIaIRR3UzgF3zH0Z
	 fs6TvCw94Ex7SBGVHxVh8tVhC4gDtutWwOn/tBTHN7MnPxH9UCOCjRvpKMugsEc2+txY3
	 dyXA0V5aG+fdRwa9aHo05oAzWg2caBdC/t9isn/bujqwwES2LdnL33kD65B0R2Tmwtw8Q
	 ++gzXVXMGavzO7axTxCDKBNPLnyKI0Wql0QOKwHohipUNcRlARHWuUci526/27jtb9YTu
	 XPLOrGHyvbCuKpY8QBnk7yCtPe7t2Nydxl4vruDBzPg/AA3/e13cMmLzxQne1gnanYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cn+gqLwQ;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B9606A329
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A8B9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cn+gqLwQ
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48df4f540ebso459039f8f.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 07:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793807151; x=1794411951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xUsg8DNFnZPoeGVNQF+kJARP4HUZXbwzWzCgWEx9BiE=;
        b=Cn+gqLwQE0O82p2gaaC4XD4YSwXuUF2ux37x//Uhbd9q68bfwK3brX/opFLrFJIfFR
         PIN/mcPj/KjxOCNxqjNvDpmPYi5ol0cpRJrBIwVygCvKp4xz6LvGRblrnJg+hhkqc2ga
         iDNJLyedHb1v1KbXvDLU4cLmmsRzJdtiv69siqrQwIpDVglVIbhZI3n4Xm8w9BMRgGkq
         djca5Ph219gcLoBzlqCEUFy/rZxmoMvjSXZEUwA1nNASP5XvtKnS47NyLzhxrnT9RJFM
         erOxlsge7959AHb+/5u9DVjEqOBP3Tv5sMw3IQb9OIGRPrGF651oz90eakFlpqdfiCL7
         Vs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793807151; x=1794411951;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xUsg8DNFnZPoeGVNQF+kJARP4HUZXbwzWzCgWEx9BiE=;
        b=n8p2ssOnvHmKtnMA1MlMHy++kifE+LTEVwEs0R7XAg4ODuOwsrz89IBGGfikWgMOH6
         C8nLVnA+DtyziWwUevwBxNKB/krzU3qWYM32i/w+3e//i7O52UpOJhn1HTfzWbB5sD1G
         FxrKLiUoUAiqUulegCfRAqmi5+DhW6n7i54aicda3RJJtRx5eGEKSyDuN+XWoQoSrlOS
         yUIH5xtPAEDtr6ix8xhTpDpwUdBtAPixSXiu0ksUXPDwsW+0lxaml+tOilsJ5xeehjhN
         yqxLHeOpkp+bPgAHG4KAiuh4XAUfs7Q+zQU4BS5jD9updl3xi44FuVWkFLdLIyQDHU+0
         L3Kw==
X-Forwarded-Encrypted: i=1; AKwUvBxNM9REwmgSXUQTI7Xwrg6MgcpoBbg9jbzvxDQrJvJ7yJarjmRoN/3DakKrkPkb1hja9fI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lelWO5Q35II3aMp4WO0F2GNDXmSipyAdWJyxCuCo/QN9jJVAO
	Yf/M7tGTVZpNo9XhJFSkImOEhJj65AEk/RZuWim1D7P6mrzOXScJeLIF
X-Gm-Gg: AYBFou0I0b3QqiyTnNl62BnofqIK7thvs+onzdqqRupGR924HLZcvML8xi/8D66bJmb
	wLqSJ6K07xZq2anP0fUiPKfJcq5nzK9nFgsyZNNI2GSgZM1/Uw7WFSGACBhnWm4U7yLhd0H8guk
	HKgkrCwmXOcFXEaCoLoNfz/2kZ+Xr/MZ4kfurM9VHOjQyjaa8B+5cxbz+Q47Zg+3hH+hW/WvVc5
	vtisTYsO/1i3osFdmF66vhmPiO2gv8EX4HEWtr3NLqQNzkudvv0Df6w7N2flp1s1IInsliuNP9h
	Q3uKIQnPZ9QGojS5N6cswd4vcw1ZvOi3txdAKO8k7UMt+juLcamVo6XCTbuAFHJocP+gEVmRNt8
	kCG/cOpJ0rF0lPebkiqDdVuKA1TF6AyHMZWl9AdJ7vQn0S3LTTPDxBa7Ihd7NP7fnEpC7y9TwM8
	SSYRZij6xu5TxkeSrghENO9XAOUCKk3kM9I63Vzc9DKzpjhjgMPMAF7/r53I68W+BlSatJh1LG7
	2AGTwyiMEy2YCg3Ua6c5HjgGXq94I2AAfHk5vgBjdDGTelxukrOGiLK4uBIQ6xVc7ESL1b7VllW
	soEvEMdqCnzprpWAKIjNJIBnopi4ogrYCPsTwg7oL2MXLs5rMcqHd5AYkksg5tythyUb5RJmFVC
	ox61uWQ==
X-Received: by 2002:adf:e18b:0:b0:490:e367:782b with SMTP id ffacd0b85a97d-490e3677ca5mr811738f8f.37.1793807150556;
        Wed, 04 Nov 2026 07:45:50 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fedc09675sm4627500f8f.55.2026.11.04.07.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 07:45:50 -0800 (PST)
Message-ID: <0b3f8998-bb3d-4a91-822d-291562691a6f@gmail.com>
Date: Wed, 4 Nov 2026 15:45:47 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] diff: use size_t for the size passed to count_lines()
From: Phillip Wood <phillip.wood123@gmail.com>
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Michael Montalbo <mmontalbo@gmail.com>
References: <cover.1793546752.git.gitter.spiros@gmail.com>
 <2011b90d80c5a823878055fd1016bc38b6a072b7.1793546752.git.gitter.spiros@gmail.com>
 <0cb42395-3e62-42e0-bfd3-a4265ed7cc33@gmail.com>
Content-Language: en-US
In-Reply-To: <0cb42395-3e62-42e0-bfd3-a4265ed7cc33@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/11/2026 13:58, Phillip Wood wrote:
> On 01/11/2026 15:36, Elia Pinto wrote:
>> count_lines() takes the size as an "int", whereas callers have "unsigned
>> long" or "size_t". It is used for the diffstat of complete rewrites
>> ("git diff -B --stat") and in emit_rewrite_diff().
>>
>> With a file of 2GiB or more, the "int" becomes negative (or truncated
>> above 4GiB), leading to an incorrect line count. This only affects the
>> diffstat output, with no memory access issues.
>>
>> This was verified using a 16-bit simulation, where "git diff -B --stat"
>> reported 0 changed lines instead of the actual count.
>>
>  > Make the size parameter a size_t. The line counter remains "int".
> 
> That means the counter is subject to overflow as a file can contain as 
> many lines as its size.
> 
> I don't know what the simulation entailed, but this patch changes the 
> return type without changing either the type of the returned value which 
> can now overflow, or the types where the return values is stored by 
> callers.

Sorry I seem to have misread the patch when I wrote that - the return 
type is not changed. We're still left with the possibility of the count 
overflowing now that "size" is a size_t though I think.

Phillip

> I'm concerned that the preparation of these patches and the others 
> you've sent has relied too heavily on a flawed mechanical process, and 
> have not enough on manual review reading the code and reasoning about it.
> 
> Thanks
> 
> Phillip
> 
> 
>> Triggering this requires processing a file of 2GiB or more, so no test
>> is added.
>>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>>   diff.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/diff.c b/diff.c
>> index b4ac17f8ef..ed7a931c41 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -655,7 +655,7 @@ struct line_range_callback {
>>       int ret;            /* latched error from orig_line_fn */
>>   };
>> -static int count_lines(const char *data, int size)
>> +static int count_lines(const char *data, size_t size)
>>   {
>>       int count, ch, completely_empty = 1, nl_just_seen = 0;
>>       count = 0;
> 

