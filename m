Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8022EED
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722762080; cv=none; b=eTkR5NzgC3crhChbr4s0RHkvwol94UZujETiyndAzn/7Fm5hZfVd6Gu6XjDZBpbpprHkbde1609E1o2xKT7PAoMeEjM8FHtBOr5ftULC2pNGiW4Fk55Nt435aoE9veLIiAf8LCUgmK+l1myGm4fBy2M1i+twg2oXxxT0sa6Httw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722762080; c=relaxed/simple;
	bh=+Vctvnxmf/W8ao5OVcVqN81AjiMSuzobuiyRk1vSsZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBX+D9JOW8HtyIP4G3SnnKhJc+1QfAhq2qB5ifH7NBNqop+yCXrd9wnWTvGxX9576M1HDIutUoJzYFeXBQPkfysF2u1idRE7ScJaIl7f8arCIhTzDQHyzO1c7hz8cG+PjkJ4ihdmFRM5db7HQBpwgD7JnFs51g2aQXstjgfhN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHrOKAcf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHrOKAcf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so62065065e9.2
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722762077; x=1723366877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fHd4Q5azrb/emx5Oy31g6DeObT2Q6ZtNr8yQdFI1oPs=;
        b=WHrOKAcfwGe4Jp/A+FVm1JptM7c+rG/xS8lqhMTFpYfCzIXxhTiiUqlOezgvqaY3Wy
         +RE4R2eP94StbFkZlNcZTACdITtpT/xyLfvk/pAiRUTuTyk7ICK4wgNfFns/qICQfSJA
         X6Nzfwayd69aEm4J2dXR2PiFYNoOC/LqHmnnX7/QiCsHwh6f6sXP9OUy3F1jJTyzt7AF
         VDsP+zCjtfBUmYXAUQqTxUhHkQXXFwh6530PysS6/gl+nkSO/HfOpE3uI9wSo4BxwdaR
         KS3KEzzNnVu3dgx0YFuhBYgLXz8cp7cF0bZHhp+spH09AZE6d3Jlbh+vwxkO6Ldfi4fL
         6EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722762077; x=1723366877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHd4Q5azrb/emx5Oy31g6DeObT2Q6ZtNr8yQdFI1oPs=;
        b=ZYHAGZHowdcVeFy3WC3LTwQzIBy5BBvWQnJM5AoSc0iK5XjqhO7OMOBxG3SmUxqtgc
         S3mbM4FMPfoFjGj8E2w0T4mMLJNFi4lou2/CS04pKngQOlq400pmN3RX5ZfZwxsJUWyz
         xIiWegsZTlJEVy/gKL8Icni5n/vP1UhNz+GuMFm2t/vznT4K3psuZNFHnHyNaxvFMT1J
         f0mvmN1oKdwQt/rMmbM9CoPyy45h1DpLD7B1X0vg13MoPwG+oyV+ZkBLvqjKR9wwhsHQ
         w4h+8bYGv9gSHho6PlOidnv4fuoJKqKXrSA1vSZe/wtiOoWwJBf0bMD2qL+VwZzWm54b
         mrwQ==
X-Gm-Message-State: AOJu0Yx5i097KetQuAS/aWvNcHOsnXbMEjAZpR+Sn9HJTwcxgppfrEgZ
	gvyoR8U178iCvEL0jwuMiG4OE8Tyv4jmK5xPNWoTRb2rWVoMLl69
X-Google-Smtp-Source: AGHT+IElBZVI91qXdDWYNmxvCxR7UVyX+rB6icvPQozzmub94jU/pg3nVzRvzjX265IhcvBoya03qQ==
X-Received: by 2002:a05:600c:4fc9:b0:426:8ee5:5d24 with SMTP id 5b1f17b1804b1-428e6b2f79fmr61187775e9.20.1722762077440;
        Sun, 04 Aug 2024 02:01:17 -0700 (PDT)
Received: from [192.168.1.5] ([197.40.96.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e11356sm90487915e9.19.2024.08.04.02.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 02:01:17 -0700 (PDT)
Message-ID: <a3d28946-2ec1-4388-8eab-0ac0c5298cf6@gmail.com>
Date: Sun, 4 Aug 2024 12:01:14 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] [Newcomer] t7004-tag: do not prepare except
 outside test_expect_success
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
References: <20240804071137.30326-1-abdobngad@gmail.com>
 <20240804071137.30326-5-abdobngad@gmail.com>
 <CAPig+cSAG4hcLRg9nAg7JGssm5Eh87-z4kWSu_RLgJZuzhyX8w@mail.gmail.com>
Content-Language: en-US
From: AbdAlRahman Gad <abdobngad@gmail.com>
In-Reply-To: <CAPig+cSAG4hcLRg9nAg7JGssm5Eh87-z4kWSu_RLgJZuzhyX8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/4/24 10:32 AM, Eric Sunshine wrote:
> On Sun, Aug 4, 2024 at 3:12 AM AbdAlRahman Gad <abdobngad@gmail.com> wrote:
>> do not prepare expect outside test_expect_success
>>
>> Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
>> ---
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> @@ -131,10 +131,10 @@ test_expect_success 'listing all tags if one exists should succeed' '
>> -cat >expect <<EOF
>> -mytag
>> -EOF
>>   test_expect_success 'Multiple -l or --list options are equivalent to one -l option' '
>> +       cat >expect <<-\EOF &&
>> +       mytag
>> +       EOF
>>          git tag -l -l >actual &&
> 
> This patch also changes bare `EOF` to `\EOF` which correctly signals
> to the reader that no variable interpolation or other processing is
> happening inside the here-doc body. Such a change of semantics is
> significant enough that it normally warrants mention in the commit
> message. In fact, often the `EOF` to `\EOF` change would be done in
> its own commit. However, it's probably not worth a reroll in this
> case; v3 is likely a good place to stop unless a reviewer finds a
> problem which demands v4.

Thanks for the feedback.
I'll keep that in mind in the upcoming patches.
