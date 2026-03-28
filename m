Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D730F7F3
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774717435; cv=none; b=UKSF02ULROj/bKKhltkjC1Avh3QP1DXixe6rTWPaifXNqQz3hI+b1L96WH+VWN2ljwfS4phhdtW9Q0fmkI4nzIN/mW7Pcqczd1H+0bSWWp/aPj6ZquVhodg8vyPzrDZnN0PW6dnwLtxo1DCZz8b+nzl5Hl1Wgchps9cRoCKH4UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774717435; c=relaxed/simple;
	bh=8n6wxV4yDiyRNXWGZbqEs0HM/C9y/EquV/6UCCLyceo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxvkCsOMPkB33jlIp2LuGY3bInnf5W24fl5ooDyNHXT5tj86ivMf5VttimkKXtY+SAvpicXkfS2n9TfkPm+cEVWIyjVIzSpCDoy3q0g4wDUsCLobG9L6yoMlm4J2D4mana5SHYIZmJ1D9UZsUojbQf45J6zFnsf3dGh8bPusEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEIQrUTJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEIQrUTJ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d9986da48so38850a91.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 10:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774717434; x=1775322234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ePFHIzQCo0dpH1Augn1Tqh/jPOYXziE5o45x+S46j4=;
        b=lEIQrUTJJEJ0eC3b2kV/hamgqgMu6c+xWyWo7Ey91fv3Ora7W1y1GKJp1eVOg9/1Cg
         HUYkPOrSvHzAq/+DldFcIXvDivnPmYmkzkjrfKcOtOKgIuUuRmGpTf9uyfxZlvtXBWAL
         JHIRCmZqIEcHQQiwjtKVkzmEbYLMv7ofUAQwD4aEpk+kPH24RrET5f8igHo9u2EKKvXG
         XRjhY2SL6uolADkS38j2hJcPLgQXl+l44Dy7DVpQZVt2ldl9R2SeHQCK8emyUtZqHH3r
         DEX7jSu+f1TYECDQbW+PALoiBumwKqSUYF64DF0eDc99yVOgut4bTRnGYHtB1zTqANvG
         GRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774717434; x=1775322234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ePFHIzQCo0dpH1Augn1Tqh/jPOYXziE5o45x+S46j4=;
        b=pkugVIHoPExM5btFoPTLyYAfZv6OgNxc3a4qRO8j5OZPDGU7p1VOjFk9NBqBDC+F7v
         Y+Zi8ayiYYU7uTxJx9+hP2j921WuFpPhtkZ65NM0i8JLByhd9aR/jG40bCxH3n+Uh0BB
         GNz3qOHDTSJWQdE1O3slRf+fW7GXFSOvqKvvxs6DTBoNLIat6uEdG8XkJdeZhR6cW5c7
         e8716ftkyyoyU3jPFlNQgNAEYb/Dz3KXMroe3fXbRCXBpQIL882S3gZs9BRTHY6bxsn2
         69rhwDZCmS/C+B4Ct8LLIfgIL2e1QVKtyRf16D3M1BFGsqbPbLey8Ls2aaO6BM8F1CAg
         OI+w==
X-Forwarded-Encrypted: i=1; AJvYcCUBO3OB6wwArNpfoTs9crJbPlK6tvI0QyeXME4z00qOErDW8Vko5XLjpwHDC4p0FY01A6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2XveACYt4/Q/rnQGU5OaIFuVHZ4lKQd44SWX0+tUJT051yGCM
	3dkBQzYdl3aFMtDVgc1i8NpjTrMeh1MMjqk6ydJM2zw3VXaRMb0qSB/M
X-Gm-Gg: ATEYQzzKZLln6Dy2ZJcbnqf0zOvrgPGeoHSgabpsA8o0WoODWX9suN4K5Ix+XH5LBLF
	DKbeeMzAGgV7IuTX4M2ZkTgkLv6u9pE0a6CW8GTRA899bLp8obTH1RB3mtUKhHLFLT1+cWSrg1s
	h+t8Tttxq5G6eSoDURGB8D5qD6FylRVOFA9vVvwCXFFIRpZwAbcQBAqZgPj7GexjonNozd9ekwW
	ETXJ0Y+I9mjjlzrgOdjXkXNb05XtmC87FkX9sIEoDndGRZ/Oax+glLw+q65tJGYcdvWZUZBx4S9
	6V/szZnENt0oAwv96HX+dzq1HuuCUvEBsKAKpQrrnKBbEvAcXn0BQ5C7o943nUfEBDXeB4QLgbv
	2QpzcyyrchilG6hPK0cKS/lcDiOpd2KB97UCYobyew6W3Jqq0YEoaQ0gWFBkxNPbHf7AAPGrF5b
	qq/kh2AFRQ2x5ScMWODdIVjMBRNWAmINuKUPxwN9LVzxBxDVHd1ZGRs8wzspXp8VYXj/XObS6bL
	euhvq0xPa4=
X-Received: by 2002:a17:903:3d0f:b0:2ae:5d79:a163 with SMTP id d9443c01a7336-2b0cdd44230mr41906375ad.5.1774717433983;
        Sat, 28 Mar 2026 10:03:53 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427658e4sm34883955ad.48.2026.03.28.10.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 10:03:53 -0700 (PDT)
Message-ID: <3ac6eb2a-4bd9-44e2-acef-cc80799925f5@gmail.com>
Date: Sun, 29 Mar 2026 01:03:50 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] refs: remove the_hash_algo global state
Content-Language: en-US
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-4-shreyanshpaliwalcmsmn@gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260328141146.1095115-4-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/28/26 22:09, Shreyansh Paliwal wrote:

> @@ -3153,7 +3150,7 @@ static int migrate_one_ref(const struct reference *ref, void *cb_data)
>   		if (ret < 0)
>   			goto done;
>   
> -		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(the_hash_algo),
> +		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(data->transaction->ref_store->repo->hash_algo),
>   					     symref_target.buf, NULL,
>   					     REF_SKIP_CREATE_REFLOG | REF_NO_DEREF, NULL, data->errbuf);
>   		if (ret < 0)

I have no objection to the logic itself at all, but this line of code 
looks too long. ;)

If I were you, I would write:

	const struct git_hash_algo *algo = 
data->transaction->ref_store->repo->hash_algo;

then:
	null_oid(algo)

Just wanted to remind you to pay attention to readability. There’s no 
need to reply to this email.


Thanks, Yuchen

