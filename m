Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC774BD7AF
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213079; cv=none; b=qSUm/vQ6osBpcY9WgaEdxF3110hqUF5By/h3Sj5MY04YIMgy5BZbt3yDNWgeVJNvTDbD6echwON8oXqRxenlC3OZwYTFOHfk12GatJ4KZWqHuK/flYpB9Z8RPVNR8y4O9LRT+B2SMBjcq+TfTDJbEt8345Jk0urArY+NgGp9dLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213079; c=relaxed/simple;
	bh=Uq+PBpWvBJfy6GjAnjn2CCI+WvY9qyePGgDUw7wHf/4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c/abjcI2s5zhvHnT0dHxdzIXjVwZvS2BGlM3hBNnU4Aq/DrjEYLpi93h/HZKxlCiGWDDDbA3dPI6heFfb9lmnW5L/2ZMkGGRvLqvlmIMBh4BCFr/bHv0TA773laz7y9pwLejoCAKzfGjHFzo/Miwj2UkUMWbjT3ESIG/DjQgc50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6LyrHZu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6LyrHZu"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b06bb6e40so1528491f8f.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791213076; x=1791817876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8cOsJDJN9ay5n06+IZkvB2UkhXlkvYLHBoaoSDqFuXI=;
        b=D6LyrHZurNzObMDldL12dlk0xb35kH8U7R7JBso42heFbnYzOwoZxBQBXf4PVNfqOO
         Gww+Z/vcddapaVDJ0E0PbR+PLAZSMoNLdBnG4BuVS6fIKNP4xfODIFLH+IdjcG8ZhqrV
         WSlulYq4HRIM5fFGxLX1v8HRE+9HYgM0dvJHHGhqxMiQDVMLQKxiCubUYFgkJvsAOD9v
         Z8y28C0SD3qcQx2qUENNx7HQTXBif51euzR4KW+WM3oGvS/JREKi65Y8bY94i+JrDyHy
         q/WEZQT5eoKQKNjSIUfKavQmhBZFZh0powhO0vlXxzCTM4VbDqgBJ1C33WctHsRz18LJ
         ROKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791213076; x=1791817876;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8cOsJDJN9ay5n06+IZkvB2UkhXlkvYLHBoaoSDqFuXI=;
        b=kgEhfV0Jg77sb2g0i0n1f0V5MIk5BT9Pq3E8kWoBXs7k8iSHWCss7Hcrg5S5wHEP0L
         leYNN5+WMO0GZlMnseAuTSg77Xn7LptYOpEJGllqpPVKmyRzNFgEgZ/L+rrTbzl/smOg
         YvDzn5pSeSxYDMqAPC9c7oiRlUybbeVL70v/KikIpszA55KoPielx5A0IlGF/CWCMUiA
         Pw/Wt3CoGt6binmRIxPOUUXf8yRO/QaAvhZHCcADxeHTtUX9wvAHgs/r8DLo0VLYmV40
         NKwNfb0909OkXNR7BYAc0Ne3AgF5YHpZLn2ijXOeu6c2vxlY6PBAIk4E3jFYeIksHOqd
         z2tw==
X-Forwarded-Encrypted: i=1; AKwUvBw/eFcVbnWadyc8mg9C+zRgwREp7oGhlas0ymG2b/0vS+IfPfTP+GfnC3To7k7YoOEp1uE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7TfkRQwOWDKyIatnI6o9J0DoRTqySKHoMJu4UM0iOUmjlkXpm
	4fnt4KK3rG3xOmYhmDTDYuZFgRTkRx/V18hXyTWMh0eYHOLYrIxBda+p
X-Gm-Gg: AYBFou2zpAXZoOY7ZXizrGRD9xd/ETvTiP0fMQrNvBED+vk3Vj7NqR4vULH7igPF1ej
	jWlJPl9rIiUde2jz+DhfNUnxWl/LKvzWmg7C3DpRhUYKHKug7R9UnpHTuWW9pzWbeRyWy8EUl3a
	yHAOZNqbokbrpf5Oof/MIsNdcJFooOC+F4Hgjb3RgjEctBaGfIpVsrZqy/bXseSygR4EOr60JEy
	9Cp6ksCGq7voMFNI7lDWsWRhNH8MQhQp3rcUO/n0ZFWkRmLiuTPoZHDng0AGbdsXwunO23afG38
	gNu6gvoLGy+u3SPgtg3jMG1aUpAw5b0s4U2VHjysrcUu2I5p7GeugEFtYb1ZaQIfEj77f1+EXNb
	vBI1Y7QAG5TND5aTdIvUep94gWydgnavtnWDPRU3Sd2l1BM/nU7i5YpOURh+r0ctZl4TFDsy5ie
	3q74f5/sliVIwooY3X7sA5PX8Q7rkYGGQSobnH7BNe2HIwHJb+WfUWqbSmwDIsM+CWr7s3bWp96
	VGJ9m0SCjWLmrO3gmgaE2lL6wtPF+zQVcIpo+2+LzugGsUd
X-Received: by 2002:a05:6000:2301:b0:48b:1296:52ec with SMTP id ffacd0b85a97d-48c47fc5eb0mr14752503f8f.18.1791213075852;
        Mon, 05 Oct 2026 08:11:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c63f6434esm3597844f8f.22.2026.10.05.08.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 08:11:14 -0700 (PDT)
Message-ID: <c991fe7d-6230-4600-a038-b051993e0e2d@gmail.com>
Date: Mon, 5 Oct 2026 16:11:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/2] ci: link failure and leak annotations to the test
 script
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Ben Knoble <ben.knoble@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v5.git.git.1791015117.gitgitgadget@gmail.com>
 <3587bf44-1b3b-422f-a926-f8481104dfd8@gmail.com>
 <8b873f2e-b395-4044-ab15-f1eab4148447@gmail.com>
 <CAHwyqnXBLiAA+aX8uLA3UvsfD4zaMTcvj96H8DX8BhMVopwcfQ@mail.gmail.com>
 <ea988ec0-ef3d-4250-a0d6-ffdf3794b9cf@gmail.com>
 <CAHwyqnUO0zvr+hPT2t0CG-7D9vZuWBRdj1RjC356WEuXaZ9Faw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnUO0zvr+hPT2t0CG-7D9vZuWBRdj1RjC356WEuXaZ9Faw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/10/2026 14:59, Harald Nordgren wrote:
>>> Is this enough to call this a regression? Then maybe it's not worth
>>> doing this part at all.
>>
>> Yes, I think we should drop this patch. The first step to debugging a
>> test failure is to look at the test output, so the current behavior
>> where clicking on the links on the summary page takes you to the test
>> output is more useful than taking you to a diff that may not even show
>> the test that failed. The first patch is definitely worth keeping as it
>> makes it much easier to see the LSAN output.
> 
> I played with instead showing the file name (and line when available)
> as part of the annotation text, and leaving the linking as it is. I
> think it could gives us the best of both worlds:
> 
>      memory leak logged in t1060 (t1060-object-corruption.sh)
> 
> and
> 
>      failed: t1060.17 partial clone of corrupted repository
> (t1060-object-corruption.sh:141)
> 
> What do you think?

I guess having a bit more detail could be useful, I certainly don't object.

Thanks

Phillip

