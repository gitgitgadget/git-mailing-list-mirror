Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684659;
	b=AGiGowyVhtkENQSdxrEE1c+zb0TnCnJa2oWroVBqe5YK38TGWwRJVo5giwE6S6RYOHzp
	 +1itz2Zj/TFGuziFo1RvcTzw6i11MbFzt6n6TUV8TJ4EYt6Ic5yD8O7ybgVsvxMMwMOf0
	 +uV1rf4Nh2VHFs51TDfFI8sO4FHHMdxHAND2SG2w35e21Q67uUqAKUE3B1IPKye8kbgww
	 nOAUdxITb7lYm+KHK7y4cnLQVsVfTnOp4S2nc8iw9SrlsCG8hw7WJ+ec0QiqvE6qK6yBv
	 9lAxHORmAEA36sSR4mDCK374Wkd42xAa/oRCpu+qqvyp30g8XUni+vNyD8+wZySVd3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IUDlMewJTaj53BGFWAcgcRszBgediaKg/xVZJjMI9W8=;
	b=LBpU0+3gl4um8wysZiuS3gubHTaDVHI+hXMvS8ff5itiRUhTiOHdkAohZ4ii2APYU3Oj
	 WK8IsW5vAngiw0bemKjbgkE08dnZSTNP7z7GLP1dxwoFjkvModqlrJiDfR9Gk9CptbuHs
	 CWWPfUjAk5xqY/6ZNUKW1WKcstwV6v/8XCmDEtBm85qmBjW7RF+3ro1i8nXJGunvGIdQ/
	 pJtpW2thVPPdlkaTQOnjrW9NMf0Dp+88v4UnZSr6Smsw4wYQLOMW9CFiEtqhDl/qLj0XQ
	 LvZRWDPjhpk6dAIxkwLH+0ks2+REArrqUkB3xiebRIZXu4Hc1dY5WTtPKxWpAZhxJAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UK2vNe4p;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC36B606A328
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 15:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC36B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UK2vNe4p
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b001cd92bso1160894f8f.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684657; x=1793289457; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IUDlMewJTaj53BGFWAcgcRszBgediaKg/xVZJjMI9W8=;
        b=UK2vNe4paOjAGX7wZqGFGT422PmPewC8Ke7O24xR+ZBRl6sBOibAuwn/p79PPKJwNY
         QwYf2/uAfFzOvJ+MvOoMnMgnZ4tE3zh5mdhtOKBBQ/dMs4I5s/6t2tbBfrzPoKvrH+Sx
         PqHUzWkiqEB1Wtg468SJ0Ove7mzXG7iw/0fy3OubSb8tAalRoNegPKXuPxbUgwBBsCbf
         JudPxdATyobHrh/nSta7jL1xY8LeorFbzGxPabeermx/wHIhPKSh1X9WZjHYioH395GL
         KpztBlGG51EcCQeTdno4DRkXC/rxhAZtYFU3PnHpN9kfNE9whsq6fCLvJiS41qVMGZNE
         C3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684657; x=1793289457;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IUDlMewJTaj53BGFWAcgcRszBgediaKg/xVZJjMI9W8=;
        b=wBUpJedu4rclSYN2RwR2TyKAlcXVksxCB/jmmbwSabLpMCaz/99NJGFrCPD33j8XMd
         4zTNolIjDImTtnS/MFfTG6L3hposM6TqyLePenICZMnEC2BKHh9j/0gtSEVtTOLCa/NS
         7VaKTnVS5Bv8xbTvWiAr7Mg1sJGuJj2FJYGlwGYnpKfdEI/otk91wgQN62opWdDoGMMd
         I3v/TnzzZuZsTnqzQE3xGIUccConrOdax4eHZi+ostqP3EeuFAFLgTQRdsAN1alnhJIR
         QS/VYuUr2UON80Ww50a2yAH1T2ZAycp9qXN/CBNiPu6sH2vHK99XOV4B75as4C0NTgFN
         grBQ==
X-Gm-Message-State: AFq9FYJGHzqjviVfvMfFDOwwKITmMaApe1BusELoQqxjUjIclGJsF3uX
	rhyGnHXo2gxL8Iv8pcZZw7u1g8D4IJQ78OiiBB+AgDGTjMQdLGU/unmJ
X-Gm-Gg: AYBFou1leHUxtazww+Hps/c9VoBNg/J8IC6F7dvQf/wJ5Oh0zZwu3YJgTk9D7+jV1r4
	Ro6kJ5YTbZ+v1NJOInAHeak+HE6i5t641F099EdYddoEiZYqWgTZRSLujauA/Nf6spm3S08dvx8
	qD5SdNnYHwYMASkAPj7nfB9enGf5vhqQ9WTiobZeic29KgQBLyZHnu1EzUfv67zYBjSWI42zAMc
	Qu2C0cnaXWd/+IIoq9qz5N4Nl38tjnJ9FckLXseQ5yazUWavlNL+J6oXk2KlsNEf5QBDDboDy+i
	WZFric8Gat6XoLdW4uPx8rua701XNEsIKvxL4TnQl/GdVBGnHNS1QSc+yVJnoduqvaU8IKG5HVN
	GGVakxTrxDiJbHovtrfDSs8HsKYIFxLaU+VFrC6ikEv7KGHbng8KPkZXhPeetsGfq0gqEp5QWtG
	xy3wuRnXBVthfgbjT80Zb6+Reb2NVxeWa2tI3Eok8g3rpkL52XjA+BDeYKdYkwbd+vknN7RC0dU
	NSWfBkiRMes2bzmA6RIjkVR9ud9+4P7PCZ0KCecfowQpwY5dqcZJlPPQ3X2YKQGLArbM+rUA0BP
	qsfJApZF6WjHgQhWJ6ztNG0dN+SxhA0uWQ==
X-Received: by 2002:adf:e74b:0:b0:48d:f7c0:97c0 with SMTP id ffacd0b85a97d-48e264de434mr9831370f8f.50.1792684657065;
        Thu, 22 Oct 2026 08:57:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828e54sm13859204f8f.27.2026.10.22.08.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 08:57:36 -0700 (PDT)
Message-ID: <7ffce2cb-07de-4bd3-a9b4-81fd27b920f5@gmail.com>
Date: Thu, 22 Oct 2026 16:57:32 +0100
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
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/7] stash: use an enum for create status
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
 <cover.1792509606.git.phillip.wood@dunelm.org.uk>
 <9e27bcd676ee763ed499fb337b1497f3fe2405b2.1792509606.git.phillip.wood@dunelm.org.uk>
 <xmqq5wyvsi2j.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq5wyvsi2j.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/10/2026 07:07, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> +enum create_result {
>> +	CREATE_ERROR = -1,
>> +	CREATE_SUCCESS,
>> +	/* No changes were stashed */
>> +	CREATE_EMPTY,
>> +};
> 
> SUCCESS immediatly following ERROR that is explicitly defined to be
> (-1) may qualify as explicitly defined to be 0, but personally I
> probably prefer to be extra explicit here, like
> 
> 	CREATE_ERROR = -1,
> 	CREATE_SUCCESS = 0,
> 
> even though this is not worth rerolling the series for.

I can do that, though we really shouldn't be relying on the value for 
any of the member other than CREATE_ERROR which we want to match the 
return value of error(...).

> 
>> +static enum create_result stash_staged(struct stash_info *info,
>> +				  struct strbuf *out_patch, int quiet)
>>   {
>> -	int ret = 0;
>> +	enum create_result ret = 0;
> 
> Not CREATE_SUCCESS?  This can be returned if various checks in the
> function assigns different values to this variable, right?

Yes, I forgot to convert the initializer when I changed the type, will fix.

>>   	if (patch_mode) {
>>   		ret = stash_patch(info, ps, patch, quiet, interactive_opts);
>> -		if (ret < 0) {
>> +		if (ret == CREATE_ERROR) {
>>   			if (!quiet)
>>   				fprintf_ln(stderr, _("Cannot save the current "
>>   						     "worktree state"));
>>   			goto done;
>> -		} else if (ret > 0) {
>> +		} else if (ret != CREATE_SUCCESS) {
>>   			goto done;
>>   		}
> 
> I wonder if switch/case is easier to read for these users of these
> enum return values.  Some check explicitly against CREATE_ERROR
> (like the one above), some treat anything other than CREATE_SUCCESS
> as undesirable, etc.

I've had a play with this and I think the enum is better here

>>   	} else if (only_staged) {
>>   		ret = stash_staged(info, patch, quiet);
>> -		if (ret < 0) {
>> +		if (ret == CREATE_ERROR) {
>>   			if (!quiet)
>>   				fprintf_ln(stderr, _("Cannot save the current "
>>   						     "staged state"));
>>   			goto done;
>> -		} else if (ret > 0) {
>> +		} else if (ret != CREATE_SUCCESS) {
>>   			goto done;
>>   		}
>>   	} else {
> 
> Ditto.

and here

> 
>> @@ -1660,12 +1667,13 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
>>   
>>   	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
>>   			      NULL, 0);
>> -	if (!ret)
>> +	if (ret == CREATE_SUCCESS)
>>   		printf_ln("%s", oid_to_hex(&info.w_commit));
>>   
>>   	free_stash_info(&info);
>>   	strbuf_release(&stash_msg_buf);
>> -	return ret;
>> +	/* Do not return an error if there are no changes */
>> +	return ret == CREATE_ERROR ? -1 : 0;
>>   }
> 
> Ditto.

but here we're checking for a single value, so using a switch seems like 
overkill.

I'll try and push out a new version tomorrow

Thanks

Phillip

