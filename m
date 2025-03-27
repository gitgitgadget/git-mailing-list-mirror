Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411AF211A3D
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087580; cv=none; b=PfJqfct2YGf3nhdMWaJhpQ0+oF2XGOztWYwEsEUR+rTbWdSuvuTGcld9vPwA4EhgmStjCb6FxAf40eorAUoG3iJqfkce+ipGXV4dP48czfk+h13LJDDr0T6kFuahXEf865LuV0RDT+jzqLwejbD+5X8KFfoowPPeYFoDZ5sC/gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087580; c=relaxed/simple;
	bh=YU+CHEAS9eYUJ4ieZBGAtYQJ+lk5Z0MCgZ5qesXo080=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mj8CtjA6GRiJvvdgnj/wXKOX4NgNr+7TPSWQhtIZ1x+pktj2b6wOYNzFXZ0fsjDXsmN7pQqLBFWly+2GaxPUnV4kbke9VJlaXmZAMwvSRTENSUxD7L7t2UJZD2CzhBUjGagLx17mNS+/Dk8FjN3Xr8nkjTlL3Uaewb9hynfcS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYEBEHyC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYEBEHyC"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913cf69784so786606f8f.1
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743087576; x=1743692376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ty1gOJaAmQFVkMjpUjV44KW1E62p+Pq73dXzTGuWk60=;
        b=nYEBEHyCCE9Qy/uerl7Ef3ZH3fVjwJkSbQIJ2BGsflO5dqIJMfS58Zgeetzgp0u3YL
         /0g+a8so1y0iyqyxXZ1DkE3bERcZBdCXYAOX30HyccKba3HfcST+5PmjSAT8BtFgh3pS
         GWRtPRH8FFJ3WWHRV4KhPe8KfFVbDOmFZ94PoZ8/2u0m1x8vVRm21iBMjgPB2ge5R4C4
         He49ZI5LBBIwIUahuFYmtlX2jUcNmJNgCuj6Six9G+YLsUW1qfMLsDsaq2q8ODou3qLL
         8rmXFnB+S/zwxB3vJkYm+1errf9gKBfAHRA5mi1h70tkc0WuZkzPEO6oJIs/2QVFhgbZ
         e4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743087576; x=1743692376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ty1gOJaAmQFVkMjpUjV44KW1E62p+Pq73dXzTGuWk60=;
        b=D2lgYN0VJyOpYyipZbx430zENbn4r2A+3hf5USLyGMmEf15iqP9tybExbQ7UG4hkZT
         AAPl84pXdE2XCA3lcKzS5OoYk6Yq/VP26NXq1L7vH2ip436IEWAHsRQ63zzcT/cqwRrB
         NDTkCHsh4voamvR7Y7+t7Oc7qxYzIzOfd9r9M8UUyZRMasj6JHvrxGotPmKDx8meYoeq
         b5I4+Ddd0zDLIbn5FJG7N/lbBwJCLUw2ONTSt7FTXzfoPUTKTxgsDMODlI/dxW4Iok/i
         BRiSSaAoSMi4izcmtqnh9DOor0rpnMtuJaVwmidJYrlcPkDuOmlSbRidkQaUMEnmxyhC
         D28g==
X-Gm-Message-State: AOJu0YzyJJ3njz/aKWTd+tYPdLOv9FSZbPXU97N8J7buhaxyjhlFJwqT
	3HCmKVBQNlJwpDAVFxEoKWTaPDbgDqEkmwQFXd+tCafN6t5b6Z7I
X-Gm-Gg: ASbGncsCUb6VCLEFE/cu+rlkYs1OZ8lN+IO2lPL0gcLby2jc82Cp5wxnOFbCOPLHy/i
	daCgscSUCQ8wbf6LnbwgWHh9jBIov1/MsFtwQPZM73cEhkZ2sJhZ5IO5rcdavIvY4CFezJ2fIxC
	kCpKK5loEhGUcYgV8KNm5AWtBmFZY1YXvP87EGUwdBLyl4hMYhb62zoGbGbrEjQO25A8MAlnaq3
	Lz5h/fX99NSvW3Ysa8MDSpujHI4vwGbIj17tlxF2+2Lk7GtbZ29Q2J05Ze9jYN80AStMAn+Y9GL
	2E5VQSzJ6BUBwMslnTBkYYa3FUAplLj2UjdLWIbLopTq5FLBhDaRx685gZ0Lrp6DW5yy/1qeu9L
	AqG6as6x679tt2JRYmPPo
X-Google-Smtp-Source: AGHT+IEp6HoZBQoq34QQU2q9Kg7SCkuoY+SCZecQ5ctLSxPG4EtKTxz+7zfnVP3hW+NPQJOWbCM+pA==
X-Received: by 2002:a05:6000:40e1:b0:391:255a:748b with SMTP id ffacd0b85a97d-39ad1784903mr3710099f8f.39.1743087576305;
        Thu, 27 Mar 2025 07:59:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82dedd6fsm42704735e9.7.2025.03.27.07.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 07:59:35 -0700 (PDT)
Message-ID: <49721689-f002-4ef0-8d42-6d9ee829c7c9@gmail.com>
Date: Thu, 27 Mar 2025 14:59:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] diff: check range before dereferencing an array
 element
To: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
 <ddfb44ed924615bdb61a30ae7627326942575567.1743010011.git.gitgitgadget@gmail.com>
 <xmqq8qoqivp3.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq8qoqivp3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/03/2025 11:01, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> Before accessing an array element at a given index, we should make sure
>> that the index is within the desired bounds, not afterwards, otherwise
>> it may not make sense to even access the array element in the first
>> place.
>>
>> Pointed out by CodeQL's `cpp/offset-use-before-range-check` rule.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>   diff.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/diff.c b/diff.c
>> index c89c15d98e0..18ba3060460 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -892,7 +892,7 @@ static void fill_es_indent_data(struct emitted_diff_symbol *es)
>>   
>>   	/* skip any \v \f \r at start of indentation */
>>   	while (s[off] == '\f' || s[off] == '\v' ||
>> -	       (s[off] == '\r' && off < len - 1))
>> +	       (off < len - 1 && s[off] == '\r'))
>>   		off++;
> 
> I suspect that this is another false positive, like Peff pointed out
> for [2/2] of these two patches.
> 
> Especially if this change squelches the warning.
> 
> If the check against CR for s[off] could be oob without checking how
> large 'off' is, then the earlier checks for FF and VT should also be
> equally iffy.  After all they are accessing the byte at the same
> location.
> 
> I think what is going on is that the correctness of the code depends
> on s[] having a sentinel (which is not FF/VT/CR; I do not offhand
> know if it is NUL terminated or LF at the end of line) so any byte
> other than FF/VT/CR that are in the leading part of the line would
> cause us to exit the loop safely before going beyond the end of the
> array s[].  CR alone is special cased because we want to treat it
> like FF/VT only if it is not a part of the EOL CR/LF (hence "is our
> CR at one before the end of the line?" check).

Exactly - we do not want to count CR as being part of the indentation if 
it is followed by LF. It has been a while since I wrote this code but my 
recollection is that each string ends with "\n\0". From what I remember 
to detect moved lines we have to buffer the output from xdl_diff() and 
so copy each line with xmemdupz() and somewhere the xdiff machinery adds 
'\n' to incomplete lines when it generates the diff.

Best Wishes

Phillip

