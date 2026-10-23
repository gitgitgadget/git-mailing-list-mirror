Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768203;
	b=hPuNkVfJBeNXnbhjmEhelH6/JIzMHVOi1msA9ccRKnscqIQNOoK3LcYBEtgY/NSO5v4q
	 NOUBFg9g/YWxq/PfQ72DkJKxqpB0OREj+h22svYz0rcCFR9QoO0oRsQaLUqE+2gprBY3r
	 UnjNMDVZZ3wctHI3ePJkwo5JbqykvRDEVQ0qEwo0R2C4efg3dF/3M6Y7uVWDoK22Xtm/D
	 +PNnBpHnCOF26yJwq14jf1qv4y7mDaN17ZIZKybdiojEYPFaQLbFP1ZLPN/B1wjVn6faK
	 CkITI8Ek66gVMZQe75JWqvTUbeWeWUfuYaI13uA8mj2gaDhQqfmfAz7DbUn9U3spNqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GG3OwegKccbohF9tUBkMXiguRoaoSonBtMz4JNCz4Gc=;
	b=igMZmyU4mF7OA3bI9dEilVvZvDfTLajXq+1C2IKmnA73DcgRy/Z0uEa3n+MRBOIO2hko
	 gBm7fVDJBwvij9tPgi57tU3D6bnwIcpzYWZfFM/Cl7N3ySQA0xu6DTLuZLDfKZtjcf/wV
	 hCHq+79QLF8sFRIu0mMp9x8303Nc3SuiPadr62cvr5A6lPAL5bDxyTzgQ7487YAh0RD68
	 H+JGJFODa4Y8tBSntTLkOncJrjQHtYG7Ifzax5InXGuydO3c5Y5WZ8utRHstnWjmTT3Po
	 nZCtJFlKPvBl3PgLvR+e2s0bFCNsnDPo1A8xFViSPKpJCBwg4rJabPOMWw6pHeij/hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z12KUiHv;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF18606DB1E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAF18606DB1E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z12KUiHv
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so7884795e9.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792768201; x=1793373001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GG3OwegKccbohF9tUBkMXiguRoaoSonBtMz4JNCz4Gc=;
        b=Z12KUiHvENCV18yIaxX3Gp9RgAOYJwGKQPnRgwlPdtcwM7uWZQ9Sv/Qe3NC/+3lrvl
         /eKQ7X6KuPIdt011kKDpyFv45jLCDo9dmfl3Zvpda578Og0WNgRkWnmhjMpiuRFXwIEb
         8lFvj/kPaI23//DmVTEyVnLnOjTQVgVc/7NVLkQO5oZIzR4R7L+5lhGk1n796c0Edd1U
         NB/SKFni7KfrrbmIT5/+YW65HnqPKzz/yq+x2Q3zykcROkQQ7PON3F85KzAowC+a5t8T
         GM7O+cryFSBVO0rL/G/ZH5XLqwI5xb0spC/agAspmXOXrGWLBQ6S1NIbQ4BCZ+Wr3DSt
         8fgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768201; x=1793373001;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GG3OwegKccbohF9tUBkMXiguRoaoSonBtMz4JNCz4Gc=;
        b=s+4P2OlpZSxu2k7qmGNQYECrL7QxAaBxiffSnHeWvzr4AEETOUXnpZrlfwxzjLT04b
         OXjyOYoXHnoxPMMxNaeSLC0MOMdXRV8gEGMv1s1iD1B0ZqXEoa9sKRyBA1olJ/D2zGc0
         vFgwO4FPoIFW8pXplTL81xK8jjWMuLMUB6IMCEprgDZTyoGltPvZcrtGqegVadY9nDln
         cKspsxpdUzZO11jHf9M+uLpf3fjxT3sQwNfVuVw4EJG4t7/Nu61qEZKQMreYushQE99l
         J3+MVZhIGaiXuxa1hzFl9oBTUOU8JmjG0ILJozZQvjvQ3oScnlEZj1IiM30fJtlkI1Wr
         Si3A==
X-Forwarded-Encrypted: i=1; AKwUvBxOAgoVBO+3xVFjFckqzHOg1CzkJWDxada15Q9evjbhjyATHlR1E0XuzcbPeEtOcv3xoz8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIv/P+s+SGfBpk1SGSjmREKV9JzQrfNtuqJ2f3bFOTYiKr/w8NF
	EimksfMxkzBzk0odvHi2uWaaEulhMsLcvEgmUONSR6fqdhnXDCy/Om2l
X-Gm-Gg: AYBFou2prs7gZNon4Zv5X8X0iDxshL+2j99KVJIPS2kzfB1DJxHmPlnq12Bq3uEk8y/
	erI/iSBuVzGS6daOAWqMrvRAeA2YZ4QonBViPJOf+5Yhvexsljo0PDGrz5NlxdhUjsSDI8MIi0X
	xa4+oVi7bBrpMfcmUAfuPy70v8gSsZqD7U95VYOXermaLC0hZvyZsEBnac3kE2QAmdd98JkSsAi
	uXcGxYAX1A/zbeYX6o29cWDeFgOvIejLOJDM2qUvWpB1FNMUw7iJTHFHRiJbslXOF8u5Gt9nhyQ
	GY1Ptj6VdC45HKXR9Zl25os7Z5IWcv3qqZQ5s8A6XkkZiM+rFZ2+F6ypq+tTeILJfOQq6DFa96T
	2qGIqVp5UCiSsWTR7ivlALeVd2c2FrZPIEU70QGnLz4NI/XtSiww6y24YGbC6l5R9JFXQ85NIBy
	gK0idAOWkUYrEqD392wkMeH3ji6Lr72YlC3y9Cl0jCwLeeNadfYcPm7JMeA7fno2ixq7kQhCaBn
	lA1WQDTpmdn0ICL1+gGsCrz2Vdpw3reKFcVi6wyNLJVLGOp+Y8pgg3rVTYZed+kZo/IcDZkUaAi
	nloouwkYVTv1cIR0pPDeYnmqcDRWl6XajQ==
X-Received: by 2002:a05:600c:34cb:b0:4a2:167a:c946 with SMTP id 5b1f17b1804b1-4a2167acdc4mr31604835e9.13.1792768201243;
        Fri, 23 Oct 2026 08:10:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2958bf25dsm14291685e9.2.2026.10.23.08.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 08:10:00 -0700 (PDT)
Message-ID: <8b75a831-f8b7-4e8d-9dbf-0f7fca5e7bc7@gmail.com>
Date: Fri, 23 Oct 2026 16:09:59 +0100
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
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 1/1] archive-zip: refactor 'path too long' error
 message to use Q_()
To: kerylefondji7@gmail.com, gitster@pobox.com
Cc: christian.couder@gmail.com, siddharthasthana31@gmail.com,
 git@vger.kernel.org
References: <xmqq1p9hhbue.fsf@gitster.g>
 <20261023120358.8061-1-kerylefondji7@gmail.com>
 <20261023120358.8061-2-kerylefondji7@gmail.com>
Content-Language: en-US
In-Reply-To: <20261023120358.8061-2-kerylefondji7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keryle

On 23/10/2026 13:03, kerylefondji7@gmail.com wrote:
> 
> diff --git a/archive-zip.c b/archive-zip.c
> index 5ab3ba786f..160efd878f 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -328,10 +328,10 @@ static int write_zip_entry(struct archiver_args *args,
>   	}
>   
>   	if (pathlen > 0xffff) {
> -	 return error(Q_("path too long (%d char, SHA1: %s): %s",
> -	  "path too long (%d chars, SHA1: %s): %s",
> -	 pathlen),
> -		(int)pathlen, oid_to_hex(oid), path);
> +		return error(Q_("path too long (%d char, SHA1: %s): %s",
> +				"path too long (%d chars, SHA1: %s): %s",
> +				pathlen),
> +			     (int)pathlen, oid_to_hex(oid), path);

The indentation looks good, but this does not apply to master. When you 
get feedback about a patch, you should send an amended patch that 
applies to master, not a fix that applies on top of the patch you 
previously sent. If a patch series contains more than one patch, you can 
use "git rebase -i" to prepare the new version. If there is a single 
patch like this series you can use "git commit --amend".

Thanks

Phillip

