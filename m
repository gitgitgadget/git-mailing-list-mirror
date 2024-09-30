Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352B189F39
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727705118; cv=none; b=mUJLd1/7YXJc13zS6dwoPAXJ5xpfuu5Zv/Dqshe+amK/Lt8aMyqD0MW52/Srp5QIEcDrvqqF7VDgHF8nh9f/PD8QJGKtT6U/+kk0gs19xS0hnrdsrSKWfTegtM07u91G05rUpIm/Z3xAaEw0HlgqXXcrxuX/vBJehos/YKO7/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727705118; c=relaxed/simple;
	bh=Hg7vbd9g5kjxVEmFqcDc8JHjeGfk8wCigS5Axay234Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KK/7sOiMdSmZcIjGaM3QEi+EE+goeGYascC+IP7rWK63CKBtBuAmT4wuhjRousaw4+BSZ9PIHrU2ua+3vLOE7EsbCaYJvy2hc7RdmS2EHgeU+2YLD8X7yPooi9mt+G6bHA0Q3TRjEXcnwr6b/lSbAGAe8NBqL91VmJPBC0Ufb0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIEwXnNa; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIEwXnNa"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5e5a0519ef3so1935000eaf.0
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 07:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727705116; x=1728309916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m9IPH11/iYviFSrT+qifq2UfVHhTUZQHnX6lLWOYVzw=;
        b=hIEwXnNaXZzM5vfxGh8gnYCZeV1dCAT3k/PmI5co2aDn03wx2r2hWd2IPq0aKzasyV
         ViLohuFj8HUMIfPrS1B9v/CxTqhx6CSSUGxrkx/WcYYs1GYV+xLsOy1v7LR6BqMArXRg
         XGnrpjc24BZPs7c7CjWqq3lAlZjj8gCXNj4HySyz6EpkxPQk1KTERkhLnsuHTnRIEJNL
         C1Min9Zm97CV7B+m8uMPBT64hNcmRo5Fk4QLP9V4XndKG0u76ZFj/yDGbhV/auTvOlsm
         n/QpJ8+IhCBJY/Eeq2d0/B5GNh5coe9LIjt7Gs16p642id9X512OnHQ+88HFyIz2KeB2
         aCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727705116; x=1728309916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9IPH11/iYviFSrT+qifq2UfVHhTUZQHnX6lLWOYVzw=;
        b=Din4VBI+XonN4pZ81szWEDPogtIfb1IZ+aGeay83Cr4+NeDBwo9WVmtUei9RLe+aNb
         nS0rF2KMDp2JTIzLP93T/DRTannUltNPBKolMns5+awZ27w3BPhPhPwNJ3qivLkOudux
         1wDrBQWuXeyaUWkzFVZE5HcVZRxeMOOjobEaBrZiYLmR9cYpkG1sOowounfqXXx97Opu
         bTbljRXwrT0zOfKHuGhIjFDvgJKx8z+i9HdWoYlACAoG/uPOyAhtNxoyhRzu/uJ3pyTo
         ak3O3YEROKG5IDw5SrK8i6/lDojxIpm8aspeZfEkRvwBXwfX/T0VDD9YuAAtr7yvuq0I
         DXIA==
X-Forwarded-Encrypted: i=1; AJvYcCXuI7LkS3Fb8Qn2y1/tu5tyfUJxfmQ/Q5PxjNKmRf4853UomdkjLO5uXvu7p249ap3t6j0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5UhpGVMh+MWsmpzBpbO8EQii09zLOyTX8EdR1xgbf4GzjS5uK
	gQnI3PdBj7O8193A/kz5nb5IWJ/QUsJONUpfgNpqBJhZhmPK32FJyEhfXg==
X-Google-Smtp-Source: AGHT+IGYoRWkx5BtehhS3GAsVJA/vXYeHFKOdVXg+/m1vjz4302spGkDP+FwrSu3lx9B8lsR1OJl+g==
X-Received: by 2002:a05:6820:2292:b0:5da:a26b:ce79 with SMTP id 006d021491bc7-5e772763748mr5086319eaf.3.1727705116103;
        Mon, 30 Sep 2024 07:05:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:f0fe:cfd2:8cd:b84f? ([2600:1700:60ba:9810:f0fe:cfd2:8cd:b84f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e770ddba10sm2187882eaf.26.2024.09.30.07.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 07:05:15 -0700 (PDT)
Message-ID: <076932a7-d88d-4aea-8117-69a2ab83f459@gmail.com>
Date: Mon, 30 Sep 2024 10:05:13 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/23] read-cache: fix leaking hash context in
 `do_write_index()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1727687410.git.ps@pks.im>
 <c51f40c5bd0c56967e348363e784222de7884b79.1727687410.git.ps@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <c51f40c5bd0c56967e348363e784222de7884b79.1727687410.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 5:13 AM, Patrick Steinhardt wrote:
> When writing an index with the EOIE extension we allocate a separate
> hash context. We never free that context though, causing a memory leak.
> Plug it.
> 
> This leak is exposed by t9210, but plugging it alone does not make the
> whole test suite pass.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   read-cache.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 764fdfec46..0fb5e0d372 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3124,6 +3124,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   	if (f)
>   		free_hashfile(f);
>   	strbuf_release(&sb);
> +	free(eoie_c);
>   	free(ieot);
>   	return ret;
>   }

Thank you for finding and fixing this! This version should be
used instead of the similar patch I sent today.

Thanks,
-Stolee

