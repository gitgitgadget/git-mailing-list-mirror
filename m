Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF454315A
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230145; cv=none; b=Jviw2EuLtckBoSc65B9xE6vMRicgeU/7/eK5rGtFBAfNZSeNhFdARXYtAZGnUX034/edaOoUoUnowy2XyoHt1BohjXr2Qo2HXtGhcI90ueqT6iueVsHeWm1A9fCxo5kNF1GWqCLphpnxo6QJUF3DB66bWtxL3/nJMc9c0hNflyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230145; c=relaxed/simple;
	bh=u79sG+4q/m5Rii8d/yytPzK5KbTwj/hF5tb1Fcw4nU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cU7Ys7auZxAym04FFwwgoEMC/UwUeI3SOnaxh8KrTIP1e4FY14EmrikjkNqSJ1xRqNCbqu3HUWOqQx6Hf0Na4nPUZyDPPeoazNvXmceoDFmq+5v9Wf/4f8bgUdCWVFr8ib14zsIfV+DFuAo0uic8uWnUmaZ3qNoVqAqm/9qMo5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izY4VqXa; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izY4VqXa"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-509061dab77so35187471cf.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 18:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230143; x=1774834943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdtmMAfJN6ZsaK6MA6Ymxjj5g5TJYo4PMP5fCxhBVv4=;
        b=izY4VqXavkFhKAoddSJRgju5sIkD4WUo1GEjYK1+lFPYEpUXghiIwbB4wR2PFJc3Ul
         pRGQ05NjUAusLYTZGzUoQDRiv0EfrkyES9usgMzBjqdC77pD9vjuhGwAAbUrDhTpCThf
         eTlblKkP/O7IYhR/ROxxHJzuXR9DQzgsV95g6wX4Wyx59kegvlLQM/Y90dv1DEEVKzau
         pVrV3Aq8C1f+TMxRSP4CNrfAF6CjOqXJ5ZMF6r/Cbya/GoAd2oWYAkVpuEXSe9grmg+t
         NHOzcklEFC63H6cosNqzU0O674WWMPjGCaMa/uYr/LUJ7maWbnyyJfm6wyHZshwxF8Ln
         rOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230143; x=1774834943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdtmMAfJN6ZsaK6MA6Ymxjj5g5TJYo4PMP5fCxhBVv4=;
        b=qVI73WZ+peEy6uW7h9mS+waCOUgGCPpBhGT57p4UUS2sFwy0oFVzVcQ3CO6Yf4ealL
         ADx87JnKO4hmaWJw9G5bp6k4b/X8bxKSDD8eHHb5IBb3Qc6QVDoPCUlb7bKNqfhz5Fb/
         b/A16b24OmqSu/ck9oBhvfAbnLwd4Lp8YP0qtUryOZo3Mv+zzMoquXyz6JLuyraZSK2P
         HN+D1/98ocrQehsdA95RGUJLGcZgBbNhMKKl68gKeSQwNoHjxdVn2qlBtyGBeLxHLuQ1
         guRgN/iWMhAw1+IS63AuUztdSrPfaN9+yDxbE/FokrDtXOiY+uH9qgk8x65qSHZ/+Y36
         2GIA==
X-Forwarded-Encrypted: i=1; AJvYcCWw8mLP/8F1iMpiwuTMmsHHIbiLrkoeHE8cSgTmOgvUGZ8ggoju3HnoxsMuCXUMSLh8xq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPdu5HcoRQ40W7nOj98Pc+ZDYI0VZX1qvxWbzntmQCF+Br6Ab
	wz0n/RdU57A5EHMzv2+ixsEEJMT0i28gTpeeqmMjtiOIZjQ+G0N798Me
X-Gm-Gg: ATEYQzxzgoVrGK7jN+UlBIc5tn4NRvY95aTSQSBxm+hVN0Hwr/FR2Wmn7vsm6L3YjyA
	wznyKBfD78PFik8lTvDqiyuWIKVFaTwrsCV1tMqK7wqK3dRuN3p8IR3zFbt+E8hQ9qHex5trAJ/
	nMNuyA4pBOLTxIVtOBoW+fLHNwCO0Lut6td+kBKRjRXUmSvaOJe05mqm1xZt5MTrbjFrMj57bO5
	ZaMS2nio//fE3b2w62mDWX5mgDqCvSb31rI/13lu7hy+C6MBJH7+YSziMTyOJN5mXAB+p8P+S57
	vE2lki2UXSMSY6xSGkZ0stnWMimTHtib19mX156ujY/jTrTPkEj5ydycWCOQ2zIwXzN42iNiEuK
	7+AcA7pbzodC8nRf2ZTfscMiEcXGmuoXMHIWmXLX1n0Eahza68jP8k+i3mcPjcgyYwoNOVSw+Qh
	My8/EegmDRWJgZLkgzbXeNgFbG4ltMjdNhJ8Mp1glTeMv7Za9K3gxBxRO3bBMd1nA/YvDcfotqa
	avODmj700wloiMu0X340BBFcNj06jJjJA1XqVOYU5KJUhC+8Xk=
X-Received: by 2002:a05:622a:1cc9:b0:503:2c16:c1f5 with SMTP id d75a77b69052e-50b3753dd9bmr167233931cf.48.1774230143067;
        Sun, 22 Mar 2026 18:42:23 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6b4:9c00:dca6:e357:abdd:ee2c? ([2605:a601:a6b4:9c00:dca6:e357:abdd:ee2c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36eb54cfsm75365891cf.30.2026.03.22.18.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 18:42:22 -0700 (PDT)
Message-ID: <6460601f-ff72-4683-abd1-2ae4c8352a27@gmail.com>
Date: Sun, 22 Mar 2026 21:42:21 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] backfill: handle unexpected arguments
To: Junio C Hamano <gitster@pobox.com>
Cc: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>, git@vger.kernel.org,
 ps@pks.im
References: <xmqqfr5sacps.fsf@gitster.g>
 <20260322053207.60992-1-r.siddharth.shrimali@gmail.com>
 <d8e6f854-e838-439f-bc5a-27cbb4091e4f@gmail.com> <xmqqa4vz7400.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqa4vz7400.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/26 9:01 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> +	if (argc) {
>>> +		error(_("unknown argument '%s'"), argv[0]);
>>> +		usage(builtin_backfill_usage[0]);
>>> +	}
>>
>> Before we get too far into this: How does this interact with
>> the ongoing change to introduce revision arguments to 'git
>> backfill' [1]?
> 
> Ahh, that one completely slipped my mind.
> 
> Thanks for a doze of sanity.  This patch becomes completely
> irrelevant if we are taking command line arguments.
> 
> It will become the responsibility of the other topic to detect and
> complain about excess command line parameters (unless the feature it
> adds absorbs all of them, which may be the case).

At the end of my series, the error output for an unknown argument now
looks like this:

   fatal: ambiguous argument 'unexpected-arg': unknown revision or
   path not in the working tree.

I'm not sure it's worth updating this, but I can incorporate a test
that shows that this is handled.

Thanks,
-Stolee
