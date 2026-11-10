Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309120;
	b=FpFE26Empo3o0O7YaS362UHuDzumYukfsPWseK5qsNchkZAtzUjcL4QFiL+uphvMUb99
	 mI93L0wJieekzzLde8GI2wpFrJ3LJOMoKOOR35jpAGe8i7+VO84JEN22PXH35TG46p+vJ
	 8/Aa0nxSfFvpKfLo8W6/Y2cQbCoxPoxk50tfy0eoV4dFz9OSGKktWYTxK2NgIB+qQYfaw
	 O3rkRceoDQXxLP9VUTwUd1EpgNlTfoEKkoyTTJPpJt0DkWunP1OMS0TWtSrAWKBZRvbeV
	 f/+y+MmcykkJ3b83JJJJgiw7st9Invt21IhyM/m9j4dfMdG/xkxhjt2k+RVF8K0muRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=2+woK6RCXCelC+yj2pQwLs/ciPVnyB4bK3/EUs95l6E=;
	b=b1/blJmqXQ0XUn2AOV0nUwecOkxwMKs2MdQgBhrSIRn1NC/MA3PUHMpyIheXd7HakWa1
	 zOHILpIe52rhVPWuAPpEzzbKUR1iadj4PPUj0xN7fcleLbiXIYS34sGgF9cYmaXBn5nUR
	 7QX4BYn/klrpiPu02HZX6/JZl/cqOBaBjYuyvskBJo+NASzVfXiDA5VLAfRVyqHlZ+7Ql
	 X2rbwiDQxJ+Z2Ri7EDuBOn41WGf5q7KnmAT6bAojkU0RiQdGPBipDbqvbER2NHZ84YVky
	 VK8QVX66zG1562EyT4LxdrJNaKZgLtINLwxb0h+G8tFBAclEwzPTPYzdq9MHDWehgEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XeM8MEvq;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E9606A330
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 493E9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XeM8MEvq
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso14419385e9.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309118; x=1794913918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+woK6RCXCelC+yj2pQwLs/ciPVnyB4bK3/EUs95l6E=;
        b=XeM8MEvqsB4YveW2XPKwZe/JKfNEYukRZU8PxFM9VXUmLrJqkjMExDxo3UaJzLp9/d
         BgvsRMPFC3W7ajDOE6NXBPtXSDat68cbeWbLJrdjAnWdeBn7OCi3TObze0ByyfWzQJ+C
         /xkItZqRechxkyb6rlCfGjnVebvZSMQJoHJiNewI8038Wjq4/R2W838AOfdWqQhzuaIf
         DZs9BCtTd5qmWR/4gsf/i0oZUmIWIxn6RE0ufVyPwRt6pGCiUZFoZZpZcLHM4yo3vYNt
         qtAusktzYAwbOPOKhNN3Gp4BM9M8u7bbf09fLWlIt8zOz8T4EAhde5ee4vZXMmidJVOD
         UJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309118; x=1794913918;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+woK6RCXCelC+yj2pQwLs/ciPVnyB4bK3/EUs95l6E=;
        b=BRcS85fQLdSDRUh4Z7BCINDyaMLPH/E+Mc6BeW/JxxuUhThCq8VY9s/E1bMMZZA+Rx
         KyRPsNLtCz02WJJL/wyq0SRT2efEHPEfv5mgzpfrGlOzwODsybL9dV6W7bacwooBnHhp
         MpHfLq488EbD6sk3Usyn1SrWkpuC/ziSBBNL1NNGWSILNNNdQofHtVW7cbQGXONq5Ou5
         C3B5jQLXzikvHLvFpXZohh7RCzSHxXdjWwiELgsxiCkS2Cbu7r8VNpEF/ZhnOdc48uD0
         qSzKRUbXPU8cZ5AiHvQSOJiXzvZKXhasonCCiEpUK8X2SzsDjuhxQF/xT37BcGEZiSHP
         8Jbw==
X-Forwarded-Encrypted: i=1; AL+hErGhv/PNF+JO7K/hNcv9PsWDdjfEBnprrw3WWvT4a73UXrRDwbauv0W/XQMd8fDKRMpL/sU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SYzp+ThFO/w7YYI2ObHXjpUgJTTYBBoCLsEcwtlqdecbmPRxy
	jtf1dXIMxWgO2oon6HTLLG/Dhj9McCPYBkCBpyNnU11PDUeA98OBh+VX
X-Gm-Gg: AYBFou2XXIhAXwHq2qrY1S3+Kggcdn7tyhat+6F/IBX6NZL3IHLZpbAqnN29BMROEi+
	LHmYDBlj/piUrJe0HsEEe4ry8wXZ67Lv+SQ5yx6F63sV4l3iLdWKLfieZ2XiSJb3Qrh+UiOo7rm
	Lcnq7BdzHfekpNbGzFBUW2dfs/fr4ms8pm6t6NJCV8g+zSPrWmEdM5aSn6rZyMCpNpsuKy53FSo
	LiFpwWtsNQTYVm7ypmSTe93Yi4EE5N4a91WLY3xMwrjJPHzETi54FptsdU45dQKNGyoka52Q8gK
	myivKtwcv16SMkLIPw85qY6CiNiMg0BlImGM9ko4ay9hMG5X72olz5WvqZxO82OFcAADjQAHQFp
	mguSkKdonrEiZSkn6zEITqEZow+yPpQHmB40Fr3dOWVUKZxjtYwotLr3r/XPjwAEYT+z3G6HD9i
	bubYSx+OAEsfpOMKU07JkWkvKtr3I887dKLwHxBYLjTA5LvfA2g3+2hL2YEJDKizdh/17xEK2Ba
	y5H7suh1JjbkGyWThUKNZiZGyyvISoFfJD/PkEHKXAEXXW5yMJhryQNgLyojelm5jN5oAmPjsT5
	GM6WhkXsq0IzO//BkvSwmWVjZ0XJ32wbcdyxZHUcx9M7PRY8M7bMO3DmRNk5bfuQz5Fd/Jro9fu
	S4/3JPZQ=
X-Received: by 2002:a05:600c:4f4f:b0:4a1:dadf:9876 with SMTP id 5b1f17b1804b1-4ba0234ecb3mr43378295e9.23.1794309118333;
        Tue, 10 Nov 2026 03:11:58 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01feee1asm73545475e9.12.2026.11.10.03.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 03:11:57 -0800 (PST)
Message-ID: <ac00d92c-bf67-4629-bdd5-41c80d548354@gmail.com>
Date: Tue, 10 Nov 2026 11:11:56 +0000
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
Subject: Re: [PATCH v2 14/15] bundle-uri: handle NULL values in bundle lists
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Colin Hinton <colinlewishinton@gmail.com>,
 Matt Hunter <m@lfurio.us>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Miklos Vajna <vmiklos@collabora.com>, Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
 <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
 <fb9e63541bd42aff0fb8b51ba79781e0d80e8531.1794296205.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <fb9e63541bd42aff0fb8b51ba79781e0d80e8531.1794296205.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

I'll defer to Stolee on what's the best behavior here, but it seems that 
in a couple of places we're erroring out on a NULL value when we would 
ignore an invalid value.

On 10/11/2026 07:36, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 67a717e857..41c817eefb 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c> @@ -175,6 +177,9 @@ static int bundle_list_update(const char *key, 
const char *value,
>   
>   		if (!strcmp(subkey, "heuristic")) {
>   			int i;
> +
> +			if (!value)
> +				return config_error_nonbool(key);

Adding a bit more context below shows we ignore unknown heuristics, so 
do we really want to return an error here?
>   			for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
>   				if (heuristics[i].heuristic &&
>   				    heuristics[i].name &&
                                      !strcmp(value, heuristics[i].name)) {
                                          list->heuristic = 
heuristics[i].heuristic;
                                          return 0;
                                  }
                          }

                          /* Ignore unknown heuristics. */
                          return 0;

> @@ -216,6 +223,8 @@ static int bundle_list_update(const char *key, const char *value,
>   	}
>   
>   	if (!strcmp(subkey, "creationtoken")) {
> +		if (!value)
> +			return config_error_nonbool(key);
>   		if (sscanf(value, "%"PRIu64, &bundle->creationToken) != 1)
>   			warning(_("could not parse bundle list key %s with value '%s'"),
>   				"creationToken", value);
		return 0;
	}

Here we ignore parse errors, so should we be returning an error on a 
NULL value?

Thanks

Phillip

> diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
> index 70ae94c4d0..a91c1b428d 100755
> --- a/t/t5750-bundle-uri-parse.sh
> +++ b/t/t5750-bundle-uri-parse.sh
> @@ -312,4 +312,20 @@ test_expect_success 'parse config format: bundle with url instead of uri' '
>   	test_grep "bundle '\''typo'\'' has no uri" err
>   '
>   
> +test_expect_success 'parse config format edge cases: keys without a value' '
> +	for key in mode heuristic
> +	do
> +		printf "[bundle]\n\tversion = 1\n\t%s\n" "$key" >input &&
> +		test_must_fail test-tool bundle-uri parse-config input 2>err &&
> +		test_grep "missing value for .bundle.$key." err || return 1
> +	done &&
> +	for key in uri creationtoken
> +	do
> +		printf "[bundle]\n\tversion = 1\n\tmode = all\n[bundle \"one\"]\n\t%s\n" \
> +			"$key" >input &&
> +		test_must_fail test-tool bundle-uri parse-config input 2>err &&
> +		test_grep "missing value for .bundle.one.$key." err || return 1
> +	done
> +'
> +
>   test_done

