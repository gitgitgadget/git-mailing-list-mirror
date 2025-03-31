Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842279C0
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743449376; cv=none; b=pJIsb7MMeheCyLBatcq3T9Iob8FgF5I2xO2nTf2Ppk9k4vTrVmf4ThQegkYGcEZo5OW7EEEooyNUWZic29rcjSEx7DyRpFG5iNzT5+4YPei7iai+mOYAoKh4ydbQxQfwGgsbmF+gnvX/VtSLJuj0RoUbd3xqyvmaEl4SJ/JCmCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743449376; c=relaxed/simple;
	bh=FP0m26YYaffO/VHoh+lM8HIuqtTzmsN/GFnQwJVQsJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rj3iCFKh0yDzT0VkOkKK1ilRDIrB1rlxe/g/N1/VkeT1yJFLGZpEzYWlMIDtrwFtgoOBA39Xt90cja6xu7X2BZAUW8Yx2SO+PjUyDX0hCCF+Ah3jmr/Z5Tt/hvOcy8c1bCYdCR7pp9eThrg1S9uOubFfhxppupWLZQ8Pg2e65FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8Dsake/; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8Dsake/"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8f254b875so44406376d6.1
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743449373; x=1744054173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pS7zwybNEtx9b6rt5s/1bNsZ53vFnSAX7KJ+3p1mo6A=;
        b=N8Dsake/huwej/iJb0cNz2AEVtMcOuB34Nxu+89i5YFtE4daADUgJCbTYll4tYMUyd
         EV1Za/lrkfrD3+4r6SlH/ntPLK8q1D28xJzz7DgTmg+01IuoBDeyOUQCet81U+bIzHKq
         EW2wuKJ+ZaSQyG+9jNaECtLgplcLnnB2dmb1dUzIT/4/Dv6rVCdP3TKPd/Gz2S8SqRUf
         /MS+s6I6eDfUU5wwl7qa+4UZpzGpmtATyaIM0g2A8KXwjJSeFzmsIveBYjc5J1x9Lgn9
         tW8FXBgGpGfjyEyNMv/FyISbuTv7UuEgnoJD+Y3MPIeRj1XzKBSgr6qflLEQKoOW36rv
         ED2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743449373; x=1744054173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pS7zwybNEtx9b6rt5s/1bNsZ53vFnSAX7KJ+3p1mo6A=;
        b=u7Sr1JT83KmcWhbGVae6mmMUpyCOABNJeWnnm7FWGczrdOAyM3X9cTkfp0CrV26QDB
         tzBS5ocUZECMVuS1cs7cK4iIRXYCfgMek1K3j6UpXAbSvPOKGnEq5zxaDV/qVur/lEms
         sb6HK0uzJc6dUaP0eE/ZzX+PzOTrHzx8/Pxhvld1pmAdnKGlI6ixPoN7+F81F9sxasfh
         Kmk4CMzfE+nX6Mg/GOxO6tlN/bYsO3pvW0q16OON7lfEJSRx1B0BTLOi1pWDduR84zGB
         6EL3ySg+k6Wd2iGXU21U51hIFFVpbDqFBub/3u9nEVJJ/QJaXMLoX48rCu55hiVaAr9F
         WBvg==
X-Gm-Message-State: AOJu0YyPSY3tySXypuiitpwCY8Sk5ccEIh4hfApEP7Rp9rr1MwyntPXm
	FyAkkOQzrQVg0mO1dDqG8PWPyswmr7/Y5Rc0OqifgN0RKxVYPMbT5ardHg==
X-Gm-Gg: ASbGncvBC1CjQOwqh33UWVco3/F/TaVSfkCB4Sc22aoWPJcQm815N9q0bmowCIfX/Hb
	xLeQszepxB+b3OY4irVTLksPoWFJHIcORkEGkPSx2ugulVKBlOIGxMa+uodfK3dljpQolyAwSMk
	iQywakjRR+vV9IzA/bjdfcSaK/7QmvWHHiWOZEThUHraC+fyyay6x6vcQCZ9RTUBcOF43b7l9BN
	puCUCV5oJhla/vdMWfGDyEaj2Jox5wBQ8szMii8P9V8zCE7jort7uiVaHOrX8Y3IvgGJyVYphh7
	2vL1Vi+ngNHo2BuAOpFV74WADfyUY7hLHzWs7pZm9oK7oMs4SN2AC0jswbf9VJ/3mA==
X-Google-Smtp-Source: AGHT+IGTUlUQrBO6REAVqaN3OEHesNqv7Weg3u3HJSRK6kEU9Jhegv+3AGdE8puODAlQmWm6YHcB5g==
X-Received: by 2002:a05:6214:f0f:b0:6e8:f65a:67bd with SMTP id 6a1803df08f44-6eed5fb9b02mr157944006d6.11.1743449372957;
        Mon, 31 Mar 2025 12:29:32 -0700 (PDT)
Received: from ?IPV6:2600:4040:2644:5100::387? ([2600:4040:2644:5100::387])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f765ada7sm540594485a.9.2025.03.31.12.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 12:29:32 -0700 (PDT)
Message-ID: <5b09f1c2-be58-43a2-9908-7243b5207251@gmail.com>
Date: Mon, 31 Mar 2025 15:29:31 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk - override $PATH search only on Windows
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
References: <53c31331-97ed-48be-8399-2701581b09a9@gmail.com>
 <20250331151213.274691-1-mlevedahl@gmail.com>
 <58556f57-698d-4f58-bbcf-c752cba00ff7@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <58556f57-698d-4f58-bbcf-c752cba00ff7@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/31/25 1:12 PM, Johannes Sixt wrote:
> Am 31.03.25 um 17:12 schrieb Mark Levedahl:
>> Commit 4cbe9e0e2 was written to address problems that result from Tcl's
>> documented behavior on Windows where the current working directory and a
>> number of Windows system directories are automatically prepended to
>> $PATH when searching for executables [1].  This basic Windows behavior
>> has resulted in more than one CVE against git for Windows:
>> CVE-2023-23618, CVE-2022-41953 are listed on the git for Windows github
>> website for the Tcl components of git (gitk, git-gui).
>>
>> 4cbe9e0e2 is intended to restrict the search to looking only in
>> directories given in $PATH and in the given order, which is exactly the
>> Tcl behavior documented to exist on non-Windows platforms [1]. Thus,
>> this change could have been written to affect only Windows, leaving
>> other platforms alone.
>>
>> However, 4cbe9e0e2 implements the override for all platforms.  and
>> includes specialized code for Cygwin, copied copied from git-gui prior
>> to commit 6d2f9d90 on https://github.com/j6t/git-gui.git), so targets a
> I can't find 6d2f9d90 anywhere. Do you have a URL?

Sorry about that (bad copy / paste). Should be 7145c654

https://github.com/j6t/git-gui/commit/7145c654fffecd1f3d4a2b8bf05755ce262903e8

> Now that this code is only about Windows, _search_exe is always ".exe".
> It would be great if we could remove it as well.
>
Will do for v2.

Mark

