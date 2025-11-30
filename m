Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D32C08CD
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764532452; cv=none; b=Rg8/0DDt8mjEpnHVnqIu90SRe+UL+X1bLN8qb7Hh0eQ5J2GhyvVTxhZXeIuaf9es/Cj82m9c0PTyR+elHoDLdh4CvpQjHQ/Hx+i4UKNFLtVIKpXqQescmzMqhgkKwMB7GU/1rymi1K5yTemjQuKyEwSuwv3iEt72VluN1ZAlHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764532452; c=relaxed/simple;
	bh=rh/HcwfO1/7HDRPsnxYwRGGNtlnAEZ6X7J6mrlKNXFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1FpDp6+6bL/iE/DYR922pvZkDbyxfrhsCm6pAlivhGqXAB6BuhUth9XhtR5KHqHHV0NL1n6qC1+WQrewd993An7dEdM+BsPOb4Rzl05iEFyxOZ3vObwQwH5M2rH59O5TG1hVDOWzQVzZYeaSEebwfqmSO+y+WofQnisBvoVjhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbt/Qojh; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbt/Qojh"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88059c28da1so34262276d6.2
        for <git@vger.kernel.org>; Sun, 30 Nov 2025 11:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764532450; x=1765137250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRWQA/0cDkNalCXjycsSvoXu1S+YaH9lQSw6UFrZAdU=;
        b=lbt/QojhSa511QxLDMUNPQYhwj6sTsAC1JJAMb3vJcJbQh7mQSbCcatJan3nRcOYPp
         mIbNGduxiv568yJuTKqscNHS29qo6iPHSFBRFpbErGPROFGdPevGgXzOgWTHQLv9biqA
         iRhWUIGcU2KQBcyxyMQj6EMtanhMOCmiCjiyY+OJi5gE01lxOvLpWzTcSyW1LDOdOSDg
         mIVw9Z61b9OxGfCcYx6R8p6CIYZevDzJ0eEf0rz6Y4WUUoX1Xg1gi0KaRTnPyAzguX8T
         qJg/OW+vcfcALXPfsAPTy/8HNpV7FyUF1ElqVWYlHjO4OUE1MlHrOPo3zXsf6sj1AYmH
         1ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764532450; x=1765137250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRWQA/0cDkNalCXjycsSvoXu1S+YaH9lQSw6UFrZAdU=;
        b=As+3QqbLf2aRriAubFkkmVbK1xQrsAyH0DrVxO/HwsouYjJf7bI1HNenXjP/KQ22hB
         V2t1Zfwl8yr1nOQUBkDalKFtR/thAh2PhruvcP3wOFCcZ9DbH5IdtJbKPMLmts9QIJlu
         dWjabp/TrS0TkVZCEBfXIY067tSKCJ/7MjtrE6B0OAd+QxALAumag2v+r/Uju8Qk/0rU
         9yBFcpQrroyBjA07Aewjozh5fuZCu6puQjRr366IpWcLxbZRsP8IULsmqfHjlBxJn22i
         RPi3CtaucDs41teiLh3O5LuXg4eZr0yT+RBwm5lL+nA/bomrs2xGx5t8y8RFhy47P8v4
         CNCg==
X-Gm-Message-State: AOJu0YwMA+cZSm8kPjHgfQnqIryVz81OmNzlThO+nnPq5uLHsl6oPSU8
	UFD9wU3yjjxOtkg45W/wQEqPBtHzrX6LkD2+yzO1C/qPMh53K3aJfjrz
X-Gm-Gg: ASbGncsyOjrGWHvLF02MvP/2TV+vpjGXQJaK1z9L1p7XdCkdxGG1mHHlBesPPgKZ5y3
	0m8my3FBQ2sp7qp0xie0/i/DT50wo4EWajzzWVbSMS1353vUdvj73EtxYzC9c62ksMHXolBnxLI
	2SGEAVTTk5wO5WVHLQpcmqbuydyNrYO3wjCFvfice/Xiy7KSv6rt6nL7o9IIH9Serio0r6Swgw8
	41It8zRyREhUxkEU5yi6NaSZ07/5zTkrh/vzvA7FDXt0XO3lFcaIwOxRVGpMBbiWnbiXhMvY7vr
	1ZW6EvC1bSTUKu3dyOw+sD7DeQob4V/eML4ejY2kO0Be5+h1AAgtSt/RnYcaMpbL1xSyQEj+AUn
	s/aply3nXMdXk15WzJtvSIcqfS0sa1My3icY4CavAcFyYP1pIoK1tXSwyn6dBxcRa4PRXlUyoYu
	A09CUlSoTRYhAjBoSFlXFC4FzPTIiGstZ+VTO4Pi+fiyvPkqxGVclP+XuS6g==
X-Google-Smtp-Source: AGHT+IFNi99NUycyN4f2Tp85wt7RfNkjnJClR7xV7Wq6DdlXUAR6Ervc6Oh0u4ZpHLjskcPBFtFqNQ==
X-Received: by 2002:ad4:4eeb:0:b0:880:447d:407c with SMTP id 6a1803df08f44-8847c4d5850mr518887446d6.9.1764532450007;
        Sun, 30 Nov 2025 11:54:10 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b6851dsm69202366d6.42.2025.11.30.11.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 11:54:09 -0800 (PST)
Message-ID: <06bebb27-c9df-41da-997d-14299fd2ffe9@gmail.com>
Date: Sun, 30 Nov 2025 14:54:08 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Update documentation/discoverability around
 `scalar`
To: Matthew Hughes <matthewhughes934@gmail.com>,
 Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
References: <20251129183236.52760-1-matthewhughes934@gmail.com>
 <FD92D0BF-E2C0-485E-A121-4C92BD20F7F9@gmail.com>
 <jcqsqytuxpqwn3yhpz7fxucbuuf635q3jfgkjzauxwhrkhl7gg@g42r5kwwoknd>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <jcqsqytuxpqwn3yhpz7fxucbuuf635q3jfgkjzauxwhrkhl7gg@g42r5kwwoknd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/2025 6:05 PM, Matthew Hughes wrote:
> On Sat, Nov 29, 2025 at 02:55:10PM -0500, Ben Knoble wrote:
>> I think Stolee implemented a few similar things in GitGitGadget PR 2010
> 
> Ah, indeed it looks like it with https://github.com/gitgitgadget/git/pull/2010,
> that also covers the first patch of this patchset. So In that case I might just
> redraw this patchset and submit the second commit on its own as a documentation
> improvement, thanks!
 
I see that you also used the US Thanksgiving holidays as an opportunity to catch
up on this thread. Thanks for the initiative! I'd love your feedback on [1].

Thanks,
-Stolee

[1] https://lore.kernel.org/git/pull.2010.git.1764195516.gitgitgadget@gmail.com
