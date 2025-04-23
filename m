Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC6223DC5
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402693; cv=none; b=QtpU90JPu0TyLRG2Gaso5hjGJ2AWCHDZGuCdAkadfpJ+Hvy5rGy352Fpzb+exwnulX+yHL0VPBH9YlipF5Ww69r5thap3s9NyTbEoaiKOx7P72RTyrwra8Fq4prDqZbMtouDP0D4HwSE/yVXue6G59YYlreeMBh4ioOPKVlt4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402693; c=relaxed/simple;
	bh=UcvYPwPqec/XpubRGIt1HD0xDTwlFldFZQ4t5XKbThs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VmQ9sHnnpEA22ZbVwBPAuh0cr71GEyn813lf8Npe5Xk+Nf6FSQnZfWhky8SFnLb4NGQggu5fOwOTmJ97TvVxwvBxrLWFHUWypYLtBC+K6mZ+988/22Yg+fZ7qVFf2a4LHZS2WEtWwWKSqh4yK+mNihpZsPqbAr7gmOjF8mz+DGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr9/6Cws; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr9/6Cws"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso39248075e9.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745402689; x=1746007489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+K7kb5zKJcg2UB67ZcacfXMKxyZiigB05Ur4aT7Adc=;
        b=lr9/6Cws1mHZ0sR4Is8e+wLZDoeyKUJPqgec57F/DamaVtfiRMAE8IkgCH/Zv2ZA3Y
         rWOnHDc4H5Z18OxhgVXycEktzeWpCM93ruQtEJGA9BaIfXdF6rnADbzix+H+p/8KcpK4
         dCgfpiRWmvyHUJlRuUOb5DNxqQ05fV8GfZy7HRSfqV0AjIv6QYN28ZRGOQiotmq0IQxe
         0F/KUP5w44cEY93O+h3gmv8vb9lPIZAwJMdRMjX6GY64f9oIhrk4pS7Mu/emBp9IJQVN
         GTg00teBjBzZucsnUSWVAvaBuW8G+gCNc5eHnMxzyszYysVlsxAXQnlStUuhJYU3JBD1
         ZUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745402689; x=1746007489;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+K7kb5zKJcg2UB67ZcacfXMKxyZiigB05Ur4aT7Adc=;
        b=Jt4W7NFWCa6D1DM+/hyhkZKdHO9QpCnp3lpXH0aOhNtLBZR5ZpyJ4VUgrc2QNWY14N
         hLKNnu0GAg53l1tLPrARaHsxDWPOqOAEZzE0vTEzuB4qz20joxrcrVEMKeGnFd1E/MrV
         sJprCcKj2flXxlQg+RaIwaLVdjgs7x8h6gw/kCSU4BmoA/PPCWiIRJ07acbyswp28jjU
         nMIVXrs6MhNTPKuVBUd4aPbhU5jLWSk6E2nhJoGnRWytJMHuJpLq2YG1eJL5IOyn9ypC
         DoIry994GXDNrPXOdiirpu/gzFa5pue3hSyN7k8lim/PVnM0ad+bl3sGGcbOJu/8a28p
         jzog==
X-Forwarded-Encrypted: i=1; AJvYcCUXXz+zhNR11l9liF8Rwc4c/uaa0G4BcwCXBxPPbW7cWfV586WUnp7qwSPcRel8myNvlmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydG3mykIoHOf10HPM/jHfSI53HSLGPxR0xJsUic4eROjSrgj7e
	FmvUJlPiJcUt+c3+2ZIAtqUGcHvuHFmgC4pAgfO4DTqBiKOEtWoP
X-Gm-Gg: ASbGncuBH4TyARZSKZ0chV6j4TMGiZOtxbW5kOUW28+73t8uLKPMoMmJS4MxvcDhj2p
	olbt1akeZK3C4NXiDoLFJBsVyJVPW2GJAjt+KYTOLOrTitQPi6rO5ULk+sSBOlBRHYt2HZEGNMK
	WSkaLKc35nwGVI7Eduxw2O4H9A2SS0L5MJV5HGZMBC92ZTm7ZVt4qZYSbzCagoOX+Aw9MQOoiI4
	ivou5Bi5DuMMwQXISj4eUHztGL2CsJm/65AE3HM5QJHjxy4/DOxfTGb/koxz+h+ULvwJ7sFXbcn
	PB9yIfy3DKA63mjpKv50p5sncosikHoev368OdP1swKcr65OBRc2swXFjAzx/s1hiay/3Ub+OpV
	YXszYvcjPARFgindX
X-Google-Smtp-Source: AGHT+IH6iWqFDgd6WppKfdP37Jn6PpGean+RSS2sEzl0MlLwHqXAo5BIXbiQuhGDf0nJqn4NRPtFxw==
X-Received: by 2002:a05:600c:1e26:b0:43c:e2dd:98ea with SMTP id 5b1f17b1804b1-4406abffbe9mr149140365e9.22.1745402689331;
        Wed, 23 Apr 2025 03:04:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092db2a5dsm20299475e9.25.2025.04.23.03.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 03:04:48 -0700 (PDT)
Message-ID: <895a796e-86ab-4b9f-b480-ca749312601f@gmail.com>
Date: Wed, 23 Apr 2025 11:04:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org, toon@iotcl.com, ps@pks.im
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
 <xmqqh62i6jli.fsf@gitster.g> <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
 <CAOLa=ZSR=7TEWLHa-wzBB4x+4+-BH3UC3G7s24Bc26JH63QKOA@mail.gmail.com>
 <17c2eb4f-e291-4189-9846-0f42bdead01d@gmail.com> <xmqqr01k42cx.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqr01k42cx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/04/2025 16:55, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I'd be tempted to check for which package manager to use by using
>> `command -v`. That way the only distribution specific knowledge we
>> need is the package manager and we don't have to worry about the names
>> of the various release files in /etc.
>>
>> 	if command -v git
>> 	then
>> 		: nothing to do
>> 	elif command -v apk
>> 	then
>> 		apk add git
>> 	elif command -v dnf
>> 	then
>> 		dnf -y install git
>> 	else
>> 		apt-get -q -y install git
>> 	fi
> 
> OK.  "command -v" should be portable enough these days (in the past
> people used "type" and yelled at by portability sherriff).  And
> having one command line per package manager should be simpler than
> having one command line per distro, provided if two distros that
> share the same package manager name the "git" package the same way.
> We had trouble with "awk" recently ;-)

Oh, I'd not thought that different distributions might have different 
package names for git. We already have a few uses of "command -v" in our 
tests and ci scripts so I don't think using it here should be an issue.

> Curious that we do not check the availability of apt-get here (or
> just "apt").
It is a lazy way of erroring out if we add a new image that uses a 
different package manager to the matrix and forget to update the list 
here. We could instead check for apt-get and add an else clause that 
prints a proper message.

Best Wishes

Phillip

>> The commands above omit anything that updates the package cache as we
>> do that anyway in install-dependencies.sh and we only really care
>> about getting some version of git installed here. It also uses apt-get
>> to match what we do in install-dependencies.sh
> 
> OK.

