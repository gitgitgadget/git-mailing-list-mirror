Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321827;
	b=wvdnttsf62P5DddXtc0Dvva/hLd6kB3UE1NBqFKMWn7fdkOfFW+CI8zNqfaJSha8wiGN
	 GN/bDwFjiEtgPX3cANst0YYxIdVznHAFU7SM51v4nkDgeU/F01vSvcQoAkDZwJZeC3oWP
	 RsvdPJtE8zGEGVwKfyQ1dM7yU2wzIjw9Fyldgla8Ipnf0CU9a9RgLlmaLlDufKzL0Iz+M
	 yCuJjVSZZCL/O46JuI/Vmx1QojD2cZKJxQCaNpWtrHtIizZ/c6Qv6Pd5IpusxVKMwQ2gQ
	 N4ZTz7oFTKlEUmgGhqaS1/Y63RwITWahWo5TWXeeQ30GqnafMpD075LKYj4lnnwXUvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=nP37mqZrHCmzwaqt6pIfXA5hCDPkGmXZ8PuC8yw8zug=;
	b=xpcquTzq7dxwn0ZMiLQSaxFB3TQNILrfgBAyZGBFeVqdUeDbbS6XGzgN21EAYqDgaLN1
	 ItsIMjTlbL6QBzgcK9F6UsdIB2ThaiWY7dAbzGcmcm7grla1MgGOkfJHzgvao1MGf9xmY
	 c4kyTe3je9zjiJb8ct0IZrXgO+RMlxt10NBYCLER9pwzB4LWAmSf4YDJj+9K90QmCu4tT
	 V9sGtP1WBI02pG8BirDMpHnxHpsMmbcWNcCWSH0y2tPF8LlYDamyjWFRIiMMRqUQBtE7K
	 ed6jDPqiCY4+h1JA4iZ3ux1KZEZEsuHcxDhushqwlMLA5aNrPoZjS5wRhP+/4f6Gy/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kab1Ucc1;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26605606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 14:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26605606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kab1Ucc1
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso305473066b.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 06:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794321825; x=1794926625; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nP37mqZrHCmzwaqt6pIfXA5hCDPkGmXZ8PuC8yw8zug=;
        b=Kab1Ucc1q3kKGqyJSvnCcIM1DfeczL/DMHFMIGhU+MKVpwhn60UkImId1jSchshV4l
         7JlF5CcJJT4h/gozDgSrQJsiFHlTPTf0B6USjurotSaHvSOet5Z+BwWzDlF6a1z3d6Hf
         QHjnP3lZaSygE/prO1gicqEPucbkyntpggrAKj2oj1Fgz+jCw6uoCIA5cTPZYeplkTg2
         wlc/SepeydoVwM46BhxPG8iHX0BvEksOYF05FyHSKX84f7Eyi+Vzq9Uen8GtURN9TITx
         4tjG9306JPQLCjRfpj0clpeG81sjrtjWPttQsFjvTYdmIaK5uZ+JPCBSy52YnFw/L851
         d3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794321825; x=1794926625;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nP37mqZrHCmzwaqt6pIfXA5hCDPkGmXZ8PuC8yw8zug=;
        b=NE3MfrcQqIjUT6+xKXabqzyU1dcYsuS2LCL1Cv9J219+U6UA1nmnnaCVfPM6cNYIGz
         BYaepF5LG4D6/Wg+fWVE2Wn7UhNEULctwXdkjAh0400TmUVzM9PHeuLO9z0eN3jhkBx+
         7icUDXq6HPU8clOJEIyUtzKz42aK8TKBsDRRDQ72gMUIYva3ml14dmXdRnJbdC0OgJOu
         pGvQ+OLwG0uDt1WtGitqnQJcb4Vjux2JWyViVN6mSV1DQmqS1vOct9hefb7gVfrWAGp6
         afuVoGvxfAcokDj4fox/lfh/pL8CR2y0tBr12UiMAdJE9mRDcMK2Q/A9ZEsT5v1JXXGO
         KiRA==
X-Forwarded-Encrypted: i=1; AL+hErGHwqJvdxjTtT5FIJiutqsiOn/MmK9MgrXdxKZZNcHVP7Tftxw7ZoB7dhIWzp+g3mU9bXo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/6c0mcbHaSkZByQEfhuTJx3UV9h3J2hfNpj7eCcj1qoprSW+N
	+uC+6Qb34GgXwycVnSpl3N6BcSLwTWMHALkj+rpi4mlqtP/TBIwWPakB
X-Gm-Gg: AYBFou3d66zJq9nlw6MD+/6bl9ceGY64+6re+snHE0VWSZ7lf8ROiOyu1ED/kNgBHWX
	P7nqrPkZKImYDtln7VE/ACRjj0jjYxUUbJACDDfM9ULAp4V0kxyZkUeDJC2QaXC4q/T+7xKqNJE
	i03yqDUFP1Sm3uYIweZefUpdkR7bUzrEOssbMzEJP2bum/A6CkqxesDLEL89O/4RytPkuA89YFW
	SzKVkyBCr/pG1bexYnL6p055RVqTuA4L7SLUWcZRnOp7/wFqtzdOJ0UiVvyrQQEWZX0X0TPYAZv
	Z+/+lLL4ohXJ03tpOkoxEPPjqTLbNPGVb8n0naE/NKuKzk4Un3X5mL+6iihFeM6wSU3MVIEWYlc
	1xVN47yvZ5wBObZMkNBBhDJNT6Gqs1pSP2Li+SlMT1ZLG6ybePiNo6KRE5AjOpkseRUBaSKOShK
	7LY8WkJ+2WeQQmIYbJy6X/UW6jr1T7DtL7ZBgDdyUHAoR8g4lfL/ROlntIT3Y1xUXTiu11Vq8AS
	K8Yi4xnB0LwuqTM/jS9wlERvG8m44RHITWbY0gkA9b++cF3HCe9Nh24/33gMEPHEqzGlNwHz7sy
	w86ZvvelHL6H4JzsYWoBMIH7xT9/SUccOPh1Uz/N8MT8rCuIth0/H9Sx00UnBEQzxlhpWSrRSxX
	z2yBrZV4=
X-Received: by 2002:a17:907:3f23:b0:c50:5545:b67c with SMTP id a640c23a62f3a-c505545c068mr143802766b.18.1794321825338;
        Tue, 10 Nov 2026 06:43:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a63f8bbsm114978066b.60.2026.11.10.06.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 06:43:44 -0800 (PST)
Message-ID: <eb3c7bd7-c147-4361-a887-1a0f77129dee@gmail.com>
Date: Tue, 10 Nov 2026 14:43:43 +0000
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
Subject: Re: [GSoC Patch v8 0/7] repo: add path keys to repo info
To: Junio C Hamano <gitster@pobox.com>,
 K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, jltobler@gmail.com,
 lucasseikioshiro@gmail.com
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261107160100.122243-1-jayatheerthkulkarni2005@gmail.com>
 <9582c0da-7aff-466c-a510-ce5a10054df4@gmail.com>
 <CA+rGoLef6b35hjJAcO5Nm57NiyDGK-iDbWO2MUMeoKVCkbRf5A@mail.gmail.com>
 <xmqq5wy5zsqy.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq5wy5zsqy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 09/11/2026 19:53, Junio C Hamano wrote:
> 
> Syntactically you could put anything at the second level of
> three-level configuration variable names, but I thought we avoid '-'
> in configuration variable names in general.
> 
> We can see that we made many mistakes in the 'maintenance.'
> hierarchy ...
> 
> $ git grep -h -E '^`?[^ ]*::$' Documentation/config/ | grep -e -
> 
> ... but nowhere else.

These aren't actually config keys, but we do seem to have added 
"path.gitdir.*" and "path.commondir.*" rather than "path.git-dir.*" and 
"path.common-dir.*" so dropping the dashes would be consistent with the 
existing path keys.

Thanks

Phillip


