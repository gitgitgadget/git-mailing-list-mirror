Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3B210EE
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707592264; cv=none; b=OqgcUkL2IbA7nMDY/wQDqvMyE6DxU/Vf7ZWyutIkJkSvs9W2V9nRHXWRIRMJ18V3ofROiwjSHtG7foPY4IhmU1dcAsJP0+kDSONMGOL3nSmoAfANI+I3lynPxtw+JSEHI00cvPuZESpwyy39DU5Sr0bHo9iMs2JtkZS9POR3jns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707592264; c=relaxed/simple;
	bh=Ygx/UbUSP3FW3en/iMcqU7/bqad28ERJmrdsx9gXOlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gr6iQtblJfJyDxSaouTsCI0P8QII42m0i8Z1cL3CWrlzXijzU0QJbBBtRMfPFF61XyadHqxwiHtarU3Ln1kvZBry4BJTmCtg/w8R1Th7diAvDfQr9SdBLCHcKIIYtab1nuLzEY2vHTuV9nlKAY0CO/whGMH07pUEF3M5Vu+BQJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JW2sypm4; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW2sypm4"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbb4806f67so1513392b6e.3
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 11:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707592261; x=1708197061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cs8/hHjX/9qUnvLRbWQKNBur2C+Ms17a9f1UTyvVWL0=;
        b=JW2sypm4GZHVBf56ybO1gZaT9IVm2lxUwsbGcHQITUnEkd3rVKHDV9d0ISoMcci4LP
         8ZsbQ0ZGIA046vtb6u1Fa+47qB8W1mR/GS4zq5M65v556WgcQNGJqOOAvbl9LnCV+tf6
         TsQbiyqHE13JtNMqdRpc02xGU/AUvl/j2xIyTF4x0BnFO/3jjyyTo4m5S0sSuj2nTA3x
         7x938vemo4H6+uvK7v1gkdVGP0p3f2qGdjy3EGEqRMJx0bnCdnT5SlFj5mkPaOZZIFDg
         y9Iuf7nNsWh+rZMD/6AqwCGhox09+t7AeWYdSdHO59aDRGT/QisDf5qLKv36Q53vYIX5
         fzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707592261; x=1708197061;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs8/hHjX/9qUnvLRbWQKNBur2C+Ms17a9f1UTyvVWL0=;
        b=HAbF1nhMTqzJ77nrKOsuOVqdcY6/oeiY5zwqANK5o33/rYGln049jLmlurm4mYZvzi
         L0PQmDrj5bYXt2sFUBbCBBBD2Cd5MWe3JPEKMMv8Zg0ajll6l+yP51qwfgLa1/brej00
         gNrpJ85X2WntzI3YFI0p7P+pa1hr4w83oqTFTml9JsKFZJ8SkOtvZpyvZ3x0ZNBupydi
         bY5U/7VPEL/pFcJWLHeFfQgDQnFORoVZknLjg0yzo4kyev7+rJ7EfRF9UpJx726fbBqb
         o28MoQnUq4Uu60RTGDBnxr00xywFpbs9Q62cU336OYdWLN15Ky5vf6ooO4IGGvIO2Kgd
         +SHg==
X-Forwarded-Encrypted: i=1; AJvYcCXg8ZARYla1nFg4EVqFfhwxNlAPDwOZDDDddvYHuIdCF2+k2RNleDQatReeRGjXv7C96cIAs1LltXN4fgjad1rXjGn6
X-Gm-Message-State: AOJu0YwyDqbcB1O6uutlXI3SWwsgsm2ysCVISyhSVjW8sC9ZtYmlCkeN
	2U5ZlxjOJitnnPivpzuTepr928jg9ERhlP807hENGeIg/nmRk1FdV/o5uANC
X-Google-Smtp-Source: AGHT+IE3Fx32yiyX9rIBHM61iPZx+A2b3m/DHKATS7M+VeFzy70YjuhSJZShC5xHm9hoHTA+nQzLxg==
X-Received: by 2002:a05:6808:1448:b0:3c0:29b2:5ae with SMTP id x8-20020a056808144800b003c029b205aemr3187791oiv.46.1707592260965;
        Sat, 10 Feb 2024 11:11:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXvl8v4uWDubO134NEA08/9Kd/wEyUVn9MFvSHB0Ccfo3TpwYdLhUcIrntRBZyISHxCsjfG41ikcIP42t4d76yrkfQ
Received: from ?IPV6:2600:4040:264f:8a00::387? ([2600:4040:264f:8a00::387])
        by smtp.gmail.com with ESMTPSA id u9-20020a05620a022900b00783f9f6d5b7sm767164qkm.10.2024.02.10.11.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 11:11:00 -0800 (PST)
Message-ID: <b5c93203-633f-405b-9bb3-1f8be87c16d6@gmail.com>
Date: Sat, 10 Feb 2024 14:10:59 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GitGui tool - new local clone is missing commit(s) and missing a
 tag on master branch
Content-Language: en-US
To: Allan Ford <Allan.Ford@hambs.com.au>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <MEYPR01MB6534B74E07CB2231EAE8D5C7A5452@MEYPR01MB6534.ausprd01.prod.outlook.com>
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <MEYPR01MB6534B74E07CB2231EAE8D5C7A5452@MEYPR01MB6534.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/7/24 01:00, Allan Ford wrote:
> Dear Git devs,
> 
> GitGui tool local clone is missing commit(s) and missing a tag on master branch
>   
> As compared to using Visual Studio 2022 or Visual Studio Code ..
> Wondering if a bug somehow / somewhere ?
> Other colleague devs observe the same ..
> 
> If I switch to the remote master branch then I get right content ..   but I should be able to do a new clone of master and hold locally.

This is reminiscent of cloning issues some folks on my team raised 
nearly a decade ago. git-gui uses a custom/unique do_clone function 
written in tcl, rather than native git-clone, so problem diagnosis is 
difficult and updates infrequent. My "cure" was to make git-gui use 
git-clone. I still have that patch, have rebased it (some conflicts) 
onto current git-gui master, and it still works in my very limited testing.

But, git-gui currently has no active maintainer, and Junio is now in a 
release cycle, so the list's concern is not on new topics like this. For 
both reasons, I'll hold onto the patch until the release cycle completes.

Mark
