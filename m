Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B26175A6A
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772384304; cv=none; b=KI0XhRmmg+HqbdBRSy2etJ1iOfw+fvHk1sbvjYt4VeL3+nQ1D7HiOdFrE+iUFsn19otPoTPZe0O4tHlql99AfY+gKUsX45OvbHb/iFG7x/IwL2srs7+NSlmsyGj1gD90Xp/qqwo7rOCLlq6mPvmCLF6uXohvGZiv+kA2yhARMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772384304; c=relaxed/simple;
	bh=zLDEtfHCDB/JJes9FWyaK+CuU2tLBynDWolGrI07w+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lu84v/uzJHvxfpptD4MVOmdy18kXe1TYhss6QfU1kMlJY4sllSWrS+JivzdRa52QND4yYMk94H07GiYXRJ5TyCktuOqZqLYGbL5kWbLBBkVdmQIainbjwtsiIoylLOcxOQDUavZR4inN2GbxlIZqeG5vwmQVZh84oJ/9Y4leO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpE3Pp4z; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpE3Pp4z"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-358ee55eafcso404183a91.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 08:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772384303; x=1772989103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MT5dDn9rzhSWIT2WrbH2wNl34KzXpc+we7ksNqXyGEY=;
        b=CpE3Pp4zcYdvGueP8Qx31YbkNrXtBm4ug1YTorWXFjyH9tgbGbIXCqfRexoPoOB5Ur
         cIYCWEBYekh1cmCI6yncH/AOFIR7OMAujauuFjl6WHE2AdQZAKGR8v70/m1NnpPq9Jv4
         Qwm0kkvqFJfCX0MjvEDHO/nDN+LmA7BqmUkBDNy26FuylpEPcHjahNFDyn4S1UTmbW4k
         mSr4m0ewguo53H4khx5+NJhqH8JQhlHqaFpopG4BvUQPciaRP/8HrpwPBQwLrQhQtXzR
         e/DI2+fhkknnb5GrOaK0AyY5IErJbSt6Gd998xHi63YH8A0Llwu6dnT/Mq1Fg/V9JOH7
         Yyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772384303; x=1772989103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MT5dDn9rzhSWIT2WrbH2wNl34KzXpc+we7ksNqXyGEY=;
        b=I2ahPtx3HUOULuAF4ykiSN8AsrCXKu0t+Slm5J8qeyHFGcCDqtjgi5Yuig+1w6MsuM
         IF7mCu+qnT2yqnrM7120QMgc8RemCxRj7josAwIO1dKdI/SAYWpmCk3h8yjtJuOWE52Y
         TG9oHASCzdUc8Se4u5izpn7snj4qmIHn/gbjnLDen1by8u0FlLH3JtK2s/OsqoPFYftL
         z7YkjQWCMcc14gbXarmEk5d+M0y9btk/Z0eWDtuBbl45oSPhUPc5lbqXiAR4roDZISSt
         Hc1h8oKqqrjwxF7BInTcJOqJZrfDxW/83xUv/hBNy+gfb3LudyKjNHUloi/zTNoWo1Xd
         WUQg==
X-Forwarded-Encrypted: i=1; AJvYcCVvGMuIeTlJxlgG7pI1TCRroFL0WRqxxXR1WUPPq/dCKBgD+3L8DzdBMF13gQ0M/rwXv/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqnGHVBmPPzZwBlGE0vUS5CfoUSCAkxnDqXCtVmfhxq01b05XW
	LXg6aCN73aU17h23T9nCQjrien6Pnw/wilGu/TJ1jTwF0eAC4wsQ0OfV
X-Gm-Gg: ATEYQzxYJgGClEPUtYmQKWI30HIicQiXRcUIGD0uG9mk8myrMibQoW0itx6E8GrwGrC
	2HI2VLlx6RQBVyNPolTstHCSUVNMFvRJrSLCZxc0gE8vCw7mhbPXCSpf41XIjEOxOQfsUNE8DDD
	k3NTh+vww4ZFZcoK2XKWVFXuv1g1STuikDCEU+8AP2EnXbAkhktFvFMHoMlgBC+qNRwBPL8na85
	sXfo7gsnMqIVptlUrFHlh5jZ6PsIbUZKHzU5SxTTnGwB1UUVAP+NsISpDb1OPw+Vo13Yhr3bZhW
	YwHsxcmjscgcQuiXhJMb/X1OMhjt6Psr7SjRTLKpvRUFsdRcIvUX3o7FhqqHQn5e7nh8SGkf5jG
	Xw8eGRfPZKVPKPus0NO7n/lI0xv1wXjEFVbcOXawrHFDJ0h4qTAjUZIy1wlaUSKNDaYuF+lTm2F
	SIC+h8zqn21ugg/+Orpnz6WY5GLdrm2XfbkdMbe10Y2ZlbGF2o/o72Mr596sQFO6EpoK7kgEcKG
	xe5pAOuhhc=
X-Received: by 2002:a17:90b:3812:b0:340:29cd:dce with SMTP id 98e67ed59e1d1-35965cf70edmr6603846a91.8.1772384302806;
        Sun, 01 Mar 2026 08:58:22 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359807618d1sm3012318a91.0.2026.03.01.08.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 08:58:22 -0800 (PST)
Message-ID: <7fa1f5c9-d1c1-4d81-a170-74a77468b923@gmail.com>
Date: Mon, 2 Mar 2026 00:58:17 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][Draft Proposal v4] Refactoring in order to reduce Git's
 global state
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
References: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
 <b98780d7-3aa9-4838-9234-290b1d72ffd7@gmail.com>
 <5e5f07ec-72ba-46ee-812c-d6773a4bdbe7@gmail.com>
 <0a944142-7c51-4143-af00-2a5798ea68af@gmail.com>
 <eecd6531-a7b5-4f0e-8e4d-3807f47d1f9d@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <eecd6531-a7b5-4f0e-8e4d-3807f47d1f9d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Phillip,

Thank you so much for taking the time to review both my patch and my 
GSoC proposal draft.

You are right on all points:

1. I now agree that commit encoding being a user/environment preference 
rather than a repository-specific attribution. My example was indeed a 
flawed assumption.

2. Thank you for catching the contradiction between my patch and my 
proposal's guiding principles. However, I changed it to lazy-loading not 
because I didn't follow the workflow I wrote, but because I thought the 
original eagerly parsing behavior was *incorrect*. But since I now 
understand point 1 above, this is no longer an issue to me anymore.

3. I deeply appreciate you pointing out that the GSoC ideas page might 
be misleading. I will study through the link you provide.

Thank you again for steering me in the right direction!

Regards,

Yuchen
