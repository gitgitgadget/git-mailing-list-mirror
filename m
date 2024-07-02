Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668E1BB69C
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933481; cv=none; b=AOVxqAoSzi9uDnJqejR9FjsXtvDn3sgIDTp4sSh7n9zgFYCywQW4hpmEk6p5n3i8m3TQlX3hn0vQNUIwrWruPhqYqD6RDd28FzpGZW2u8OVmevZvXFW6Yrirem2I488nV9Np7J14wR1Q3qmHa17Dbt2gpHZ9WCAxIgbPMN4WyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933481; c=relaxed/simple;
	bh=mqEwZFavdILk4/E5447iBwUimyCyA7HVpxgAX7xLtE0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fVPPq9aX3pyotkxsEVWXyfmMfXACwdr8cXgJMKuVvep0TJO3rRWoEb14vVlZUXxUFbPkEuPP/6TzeGRqBt9WcJ2e6Bv6HP2KVh+2xbJc1o/bCVf6oxv4+4LUNwtfvfF4+5eMw6Pw9haSuKABgaKRWom/IP91BuJppb82iluQGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks9qx8GJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks9qx8GJ"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cdf9f934fso4528771e87.1
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719933478; x=1720538278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vRCGc0j9rflmRtLOMLZsyG1BXw8sIs+nEW9R+m1tAc=;
        b=Ks9qx8GJbrtNKQgr+BKnnSYwLlp1iQ6bxNl7OJugCP0ehF7Xck1aOrt9UZ6B/KvECh
         B6Dy6bS7HUqAqRJ1dYN3xv1dpwA7ZB7mZjk8cWrjYqL7gyuLQ7lAy+qjsHJfwcNXhmjU
         NCU1NqCHgWFUNe9MIPnIaMptrWOLnUxuwEYCTiHiuZUpQ5HIFtHE6ban879LE08sQI7T
         eWCM1ZCC94oA7ndKg0WhCaXA65MyubRtTvGWvhy11TP0JqFAZbAtQBkIaZ+3DiPK21/3
         Wc3T4/NDtGYlJORUWB25j/ffTgk04gNaFDie7HTwk8Pk+UMPvFK5VZWNiZqWI5c65TdD
         SiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719933478; x=1720538278;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vRCGc0j9rflmRtLOMLZsyG1BXw8sIs+nEW9R+m1tAc=;
        b=ZyYHXNB27Mwu8ivos/ojwbi/LW+PVC5v3q/iK081zMxNk5iiGu5vLLPGeHBqiSZ1NG
         54moNaJm7FkCP6QzNSn+Euofy03fHMQN8zBqoz91bAUGe20ll4Hmp8Z3TbIYgoAbj341
         HmOhJsQQzYsnT2EGbd7fFw9TVPv2T8xDHNIIfMAPYaVe+7xpMS9B3BjNC2v0MPmQqo6x
         UJTwEkRmM17ljTytIx3aIepZjxll59y0xwZAFkJJzi3KLfLYSpFW6dm0YfmfSzpn4GXV
         zEJNASsie7jY24iFmsOKbN/2d+4dp27z6yxVoEmLONeybD8BF9CkosIRsnOMsewXDehv
         sjUg==
X-Gm-Message-State: AOJu0YxkK+YYeSLK0gXNaFlF8KPEGyQCbQffl1p/4tRetoncjKbbRo8d
	yHdikqXuYDBMGo9X0QuiRO0n24tLJULrAmAn5rgfr6lzRPToFWfJ
X-Google-Smtp-Source: AGHT+IF9zT8D1hAqJlllH6RcrgxeEbDJ+IACMpZ4zTCRR0yQcobIhegpiwFmIKwzoqKZcG7xXd2z1A==
X-Received: by 2002:a05:6512:1107:b0:52e:8475:7c2a with SMTP id 2adb3069b0e04-52e8475c155mr5218769e87.15.1719933475860;
        Tue, 02 Jul 2024 08:17:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09abbfsm201028015e9.35.2024.07.02.08.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:17:55 -0700 (PDT)
Message-ID: <add972f8-7f9f-4bb5-b053-be135a66b024@gmail.com>
Date: Tue, 2 Jul 2024 16:17:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
To: Junio C Hamano <gitster@pobox.com>,
 Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
 Josh Steadmon <steadmon@google.com>, christian.couder@gmail.com,
 Christian Couder <chriscool@tuxfamily.org>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
 <20240628122030.41554-1-shyamthakkar001@gmail.com>
 <xmqq4j98vmpw.fsf@gitster.g> <xmqqjzi4u52u.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqjzi4u52u.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 01/07/2024 23:20, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Hmph.  You seem to overwrite key_val[i][1] ...
>> ...
>> ... in this test, rendering the key_val[] array unusuable for
>> further tests.  Is that intended and desirable?
>> ...
>> The TEST(setup(t_foo)) pattern is done so nicely to make sure that
>> everybody is independent from everybody else, preparing the oidmap
>> used for each specific test from scratch.  It is a bit disappointing
>> that we are now invalidating this nice property.
> 
> It may be just the matter of doing something silly like this to
> restore the "different tests are independent and the source of truth
> array is intact" property.
> 
> The first hunk should be reindented properly, if you are going to
> take this and squash into your patch, by the way.

This looks good - we should definitely avoid overwriting key_val.

Best Wishes

Phillip

> Thanks.
> 
>   t/unit-tests/t-oidmap.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git c/t/unit-tests/t-oidmap.c w/t/unit-tests/t-oidmap.c
> index 13532aa98b..be2741c6c7 100644
> --- c/t/unit-tests/t-oidmap.c
> +++ w/t/unit-tests/t-oidmap.c
> @@ -14,7 +14,7 @@ struct test_entry {
>   	char name[FLEX_ARRAY];
>   };
>   
> -static const char *key_val[][2] = { { "11", "one" },
> +static const char * const key_val[][2] = { { "11", "one" },
>   				    { "22", "two" },
>   				    { "33", "three" } };
>   
> @@ -116,7 +116,7 @@ static void t_remove(struct oidmap *map)
>   	check(oidmap_remove(map, &oid) == NULL);
>   }
>   
> -static int key_val_contains(struct test_entry *entry)
> +static int key_val_contains(struct test_entry *entry, char seen[])
>   {
>   	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
>   		struct object_id oid;
> @@ -125,9 +125,9 @@ static int key_val_contains(struct test_entry *entry)
>   			return -1;
>   
>   		if (oideq(&entry->entry.oid, &oid)) {
> -			if (!strcmp(key_val[i][1], "USED"))
> +			if (seen[i])
>   				return 2;
> -			key_val[i][1] = "USED";
> +			seen[i] = 1;
>   			return 0;
>   		}
>   	}
> @@ -138,11 +138,12 @@ static void t_iterate(struct oidmap *map)
>   {
>   	struct oidmap_iter iter;
>   	struct test_entry *entry;
> +	char seen[ARRAY_SIZE(key_val)] = { 0 };
>   
>   	oidmap_iter_init(map, &iter);
>   	while ((entry = oidmap_iter_next(&iter))) {
>   		int ret;
> -		if (!check_int((ret = key_val_contains(entry)), ==, 0)) {
> +		if (!check_int((ret = key_val_contains(entry, seen)), ==, 0)) {
>   			switch (ret) {
>   			case -1:
>   				break; /* error message handled by get_oid_arbitrary_hex() */
> 
> 
> 
