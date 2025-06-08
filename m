Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817717E4
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749411091; cv=none; b=QLBoHNk1T7GQreLCWU2bEAy9c9Bd5GU2uRHayCs9fIC/2DAW9KsufUYtFZxI1W4pUZTQGzccrl7122OHimMSczAeclVXZB3ZBF/kqhGbqhLJqps4XiUmVfzN92FdqJ9JNfbgBJF0LVdgMz6V/zqNZaGvaRk7WL7qFfq2dBN2TSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749411091; c=relaxed/simple;
	bh=XyofXwc3oaWDQmtMrYVuK+UMzikFC7L22i3+eBoYxEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gDFf90sywBceWVWZh5OJpfyVtZ3aoqB7GFOybpm527OK1YSAJnU/jefYSs9vm/LMlZzqfKm+AHo5dMLn96Ei9CKoUqikKPp0AVs8kVDEfU0LLVW14O2ktjBI3qxEq2KvmYWw+BtkLSJVMId9G0dWLOq7bzdz3/MQSf3WyBGIIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFabZIBq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFabZIBq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450ce671a08so23129925e9.3
        for <git@vger.kernel.org>; Sun, 08 Jun 2025 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749411088; x=1750015888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9j7RkBQxUiK9OMipQKVbRiVXwTdMNsHiKus/jMMNoeQ=;
        b=WFabZIBqhp7SPXmM8m3qZIhc+ZfbaDY6LNfM24V4cmLrcbI9hfEJ5b922aTEOGmrOp
         I5OpxlyAmKyisF3S8lvuVZ3o/KnBQXK41dAsvlyhMjO7p5jO1eq1k62FE98QoO7aBIUr
         KpY1AVCwBqagYq4v9cUCEkDMvIqqH/C9zIMpfsK7smp3Dzj5AK6d/aAiQAAbj07gPbgE
         9aZVGWtRgTTmsErGzlm3o0wN8oV6mT9henpExiWhDiZ7N0dkco8iMKEr3uGVmzXS8ARK
         2P/K2pvSrIJqTSXpPvyEZ3FRenh9/XyRAaJWMy+Vaws+2Y9jIAf4wGuQmzJAGtKr/mtO
         3vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749411088; x=1750015888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9j7RkBQxUiK9OMipQKVbRiVXwTdMNsHiKus/jMMNoeQ=;
        b=vQLptU8xbgdO0u+Bh35lqg+9MlVtrE1oj9sk0eARZL8ziOO9GJHSAL8xxucIfos0EE
         n6xXgUsiEPnn18Lj2o+taOgRffaWaxZ+uq3KPqXdByA8okDTO7vUZJChRo0uGeRi/xOQ
         6PcG89bjm272Kr8eJii2is6nybSd8fYrhhBdzdqv1NAdcw94Ub7Xc/6GmG/n2xg2UlLn
         7bpi+ioCxY0ExP+jzGaRIKIwWz4Pgk3vPnQ9D1S5RKOUSojxpxxEDoOSVEVopFVwKHrn
         byikwOeM0/gNAYBjO4MAKtAf1ROLbhswO9O/fXZptEMJqMF1zFYiI8ZGQZ9YB6UmPTUu
         N5bw==
X-Forwarded-Encrypted: i=1; AJvYcCWo8CEwzAA06ms8PT4bx4GBVUfpy1oHy7mUzJ/JDic9j+lp6RIAVvrCxu5UsxFR1yDaCY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQVeTRLgjDeuKpfUgWctKLOkybaalKErEABUeMJQIqgUAprfW
	v4NlgL9F8Yl3ILHs0ilnTzyO0IgtTgBwqHCMkJP28ugC7CH2FaKT8WCR
X-Gm-Gg: ASbGnctref/bckJI/Oe2cjmEOBV9f93pkTQpG61iAz0XUXhlZzpSRqG6cnflXnTKvy3
	zLr+KvFwUhsdWCpuSptnmXBP2SExOkoJ19aSBpxsCY80y/iqXBi626qiu3iWqsrJlFm+tNdNEdY
	0RCj0BWYEcihlOL497d1QclzCrwmMPXic5mfDoYsMuysikz6+XVsRqUfzdcgX3/orggzYPl1OWa
	AZ4VslOnbm4oqVhBX0Fn0aCJneA1PxnGtOcLpW6e2OxpO67Hb1r8V+w3lB6D9Txfyk6Kw/f4FHG
	MMabhqwvN8tCNvZFM2nt+phqkV/F2SPHQJgPY2y/UsKudg1gVKKI7ELfswN3KAVcYdBNWXEMul2
	anFY4SmaklzLt4htcH5wSl9VQJ+U=
X-Google-Smtp-Source: AGHT+IGA7qZ1aojZuIku6/BAdRTUwMPE1OS0vHfEQ2t78Wz+uGHmyj3TFx9hkO7mZW0NYjgc2PlI1w==
X-Received: by 2002:a05:600c:19cc:b0:453:1058:f8aa with SMTP id 5b1f17b1804b1-453123f5e09mr12788265e9.15.1749411087655;
        Sun, 08 Jun 2025 12:31:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452137258bdsm92920815e9.27.2025.06.08.12.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 12:31:26 -0700 (PDT)
Message-ID: <993914f7-5023-459c-b1e8-ebec2646e243@gmail.com>
Date: Sun, 8 Jun 2025 20:31:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Question: is there a short way to merge the last commit to the
 second last one?
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Aditya Garg <gargaditya08@live.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <PN3PR01MB959708ED22FE7FE70C17C852B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <aEXdKMjAbry1aTXe@tapette.crustytoothpaste.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aEXdKMjAbry1aTXe@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/06/2025 19:57, brian m. carlson wrote:
> 
> If your goal is to just do the fixups and squash and not anything else
> interactive, then you can do this:
> 
>      GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash

Just a quick note to say that since git v2.44.0 you can just run

	git rebase --autosquash

and it will squash any fixup commits without asking you to edit the todo 
list.

Also "git commit --fixup=amend:HEAD^" allows you to edit the original 
commit message and this new message will be used when the commit is 
squashed by "git rebase --autosquash"

Best Wishes

Phillip

