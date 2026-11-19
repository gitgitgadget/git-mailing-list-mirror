Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795085057;
	b=MRKJa9FMDa/8Pvk6c27L9FL5c7os5MFdBGNzsq7y/7SrsJnWHtnX9a6p/L3yY21JGSRS
	 dUtDmWc4sIvAkV7ZQPGkkL0g0UMxPmaULuqbE5FP3zzN4DWUWaNifUMRZuG67NmMg0/D7
	 azOVbC7zgfVSvHxRDDWIgYnWTT+LxoGRIpO5zwT5tJCvJRJdM1Fe+Scut9vT4nvEeGjuY
	 sxmKzAunqvis0hCspqPzAm0/mT8nKUUC0Yq48msN5esZyodJCTxr72HCAFF4zUAAkminH
	 cV8aJKPE/FbdAXhZpctkox3fOiBAHS1+vpCHf2A2bD5tVdmMbgCek63pBKVSSdHJkZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HL4vYVHCSKGHhDc7A7KE2aWNWSjFIYqCjZmmX7dPs4E=;
	b=AOhV9kBd/xNBWFh9P20875GqRsVYzaYahxKYqcMIQUrwJTvoaD3ZXkbcLsdml7paP5ia
	 /CZ3pCSmaohE8WJR0jwb34Mw+SQzUvzNf3B2ZQhK3PtF3oJ5nTenQFcRZaqbb0RZzJgE1
	 k0o6VYyuWrCCW7juUEQ4ZlDQ3IQ9WxeiXHmFUmTetzcOHrbLxH84p41wItJXhfsMsFHEM
	 EjiPUjmiYvzLUR4XHLQVWl5bslY8Ov82WO3tIFODJH6rydI5ytWCDpQy0fYZ2Vhxdbqz1
	 Zo/ixx9TIaJqS3yau0UtCAKlGjLMuzr9+S0RNChIIuKF8sK1LO9pECXzx7rs0FyICEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xRj9vHn3;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1079606A324
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 10:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1079606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xRj9vHn3
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so13109105e9.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 02:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795085055; x=1795689855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HL4vYVHCSKGHhDc7A7KE2aWNWSjFIYqCjZmmX7dPs4E=;
        b=xRj9vHn3edMlo58o3PwE4qF5FjsmxWY+7oiuN92CeODH+8zaKcnkcEqivvpqBn0UmM
         kVdjVVs8BZdmZwV6Is6CFMm4H/WT7rZ7pDFXG/vO4n/HslFtn/lWIKyfs46tfOU48POU
         6RhhS5Nc6qMG5GTHD9fFscIs2lhO7FZtnrQSzbQCJvjSOD2P8zNI8jE5gzV5cH4ZDA2H
         6aLyzlWs6T/ehvGb1l3JVKhng9hVAo9GxT6EkwPOBZMpeaoGCwjoZnrsx0owrQCUdkgk
         pq6bZm0dhfrRpyI1v61UvQJwHlYy/sb84OrvqFrn6L+46oywMi/UqKp0Lv5n2l5ZeEHE
         IbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795085055; x=1795689855;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HL4vYVHCSKGHhDc7A7KE2aWNWSjFIYqCjZmmX7dPs4E=;
        b=mTg4dq6H/IoWdVfA36yNb49+DabYUMv2RKSlRajFVLqMVUiPB9cnxUr3MNIPeTYhDI
         IVNNL/sokRpDbSNgiOjHkgsp3AL8tkTTQVaqQTDUqvsyjmqiwDzDTtpqHXHMMHIPEH09
         oDx9zeHlF5qi7cIvlwwazg+TNPSdzrwnJmrpsFn534ZfSZaRNXzwibqIzo2942UCOz0l
         0MkbKksJZSILvvHb15hvs475YvRV03QvQJxfHj4g18gKuNf9DPlea1AAByDLyRpAxUU4
         +d8uI5DsEud5k5yF5STgIITpp6dQAO9DkbhwwOd/WPsPMg3EEQH8KfPuJZnMeu0P0ctp
         HPGw==
X-Forwarded-Encrypted: i=1; AL+hErFPbjKyPGPAI7JId82B6f3Hg58bRRhrCxRbDwSE1l7Lko8f9RzIQRixaAvjwjUQOEXNZk8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YIPrAod05AZKuJ5X+2xqdH1r0cmWhVB84ENzq/Vf9hWhaBbh9
	legUHrZ06LcxdfG7X7zHQqGYKcvf0EQ3njK+6LQ0mvnmHLhySFTxw+RW
X-Gm-Gg: AYBFou1HecY3oWHXN3WKHRT5iZMh3wwIiotqbcHohKrHaQR1QQOiKhM1TFgbx1mOZdp
	VDTLu1Yq2ZIX7jHESk7IrvPW1qCqV02q9VfgSYZOazb4jYaUaggrgkmRynsfsYDAtMgiQRnU+DI
	9/Jnw2witfNaEvzhkkpDsPJ0RjwJLwgPpjKy55fN8bt6vnR1tOmg/2htMEsFnhmnCYfmaU109WE
	qiPzFIWn3esLYoom9SwHQHJjet0phrRpaW02LHdFp5NRwpk6qO7oICh6UdjwJhieXkzty6W150v
	kXx3PlyvfdIJIGNIoMAS+RIcTCn2M75BkVYoAAoAhrEa5uoWDTF/Aing19XYRbqDZ0LxKWKRdw/
	Gk1DhKsO0ORu2ourcfAYw5OWFuC++hch0e81AMeYG/HFU97qFLAiXbn+bpyHVGhh/C8edMWENjc
	PeFmfmx/sY72tzAsqcH47EoVitY0lSn5hl558rU3uktxvKE6Gb//Q2EOe1t8uW//XhqJTmT6qpA
	W843o54E7J9ahTUWsb/QJoHfwndML+q4NUD9pQpnOdA0Ihx42SeJsOvqIgZTOQJtl9xtfT/itmG
	t4WOFtFVXymXT+2pDwko78nG6HAJKyQ0Qhbr1VgjtzlifXQikEpGv92OOW87GwbzZ+TkO1EEjtq
	nx/gosxBxnODvYgcr5wSyaOx4Nlzm
X-Received: by 2002:a05:600c:470a:b0:4bb:6fd3:5ac0 with SMTP id 5b1f17b1804b1-4bb7da2b98fmr108924215e9.28.1795085055143;
        Thu, 19 Nov 2026 02:44:15 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm32491475e9.11.2026.11.19.02.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 02:44:14 -0800 (PST)
Message-ID: <ebcf98af-a633-4e51-97f0-099084beeef5@gmail.com>
Date: Thu, 19 Nov 2026 10:44:12 +0000
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
Subject: Re: [PATCH] CodingGuidelines: !! is not all that exotic
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq33sy6lgb.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq33sy6lgb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 18/11/2026 18:31, Junio C Hamano wrote:
> Remove the clause against "clever tricks" that cites !!value that is
> a standard technique to normalize a value to 0/1 boolean.  We could
> resurrect it if we can come up with a truly exotic example that we
> would want to avoid, but this is not a good enough justification for
> this rule.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   * I think we saw a good example that !! was used in a recent review
>     thread, and the idea to remove this rule was floated back then,
>     but without following through.

Yes, its come up a couple of times recently, thanks for putting a patch 
together.

Phillip

>   Documentation/CodingGuidelines | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
> index 3c8d6c7dd3..4bfa615bac 100644
> --- c/Documentation/CodingGuidelines
> +++ w/Documentation/CodingGuidelines
> @@ -522,10 +522,6 @@ For C programs:
>   	    that_is_used_in + a_very_long_expression) {
>   		...
>   
> - - Some clever tricks, like using the !! operator with arithmetic
> -   constructs, can be extremely confusing to others.  Avoid them,
> -   unless there is a compelling reason to use them.
> -
>    - Use the API.  No, really.  We have a strbuf (variable length
>      string), several arrays with the ALLOC_GROW() macro, a
>      string_list for sorted string lists, a hash map (mapping struct

