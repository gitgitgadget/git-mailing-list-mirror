Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44C1BEF77
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575336; cv=none; b=SLWlmDNpzlYNYE8e/ppOlP+zVQ/vwrRS2pTnfBMOalAKtOOwd6fsLAktFITIiY8aoGklRlf/s5AzoRuWXfinMEFYZ4WoKNhmtx/48MfEyW6uvKYAb0/+BSFP529bS/skZxauF95UCfVgFL+Xt4PZrAq/VoktgR4BhksqU+jhPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575336; c=relaxed/simple;
	bh=bWjAhw66k6odcGDq9ssnBP84cPpXv69qlL6iQwbzp24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5AbyzLnLSsoZ9fSruqD3IzSPSvDdP0ZFZmPIcM6lQ4LF21H7V9HtQKLBM4kaEBRCQJh3T5oWRAkhj/F1Mu7e/5E3qhzdoslHPWTq3X8XtHTp+j6yQnHa3XWahgGyYxl8gSMduj4suTpC4zc+XydZ0qb3ZHf8i/zuKg1kWuBvJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHQXNp6m; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHQXNp6m"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d0618746bso15515635e9.2
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742575333; x=1743180133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5SKYt3sHHGtmxEbzGtA8VcDHjqrPC95q+6qjv67gS2E=;
        b=QHQXNp6mKuBl7EXXxb6LTOIHepxPDwoUr1VjhY4WMP9f24qXD7r3v/yvV9LnC+ENj3
         811zT+DCeMGE9745GyV3Yebn2giAgZVucHLTm/k/ISpaeDY0qw6Mtr+SsvTTdEHns0j0
         EgYZEAjFH8MF7PLabjE2Yoz8Pm9UAjH9tzTDmoXpJhT0IUnSnRMD2Q40jKuj953Fvlik
         fgBJxSD3E7eH3AKF5wZJcRge3GH3vclbHNTCAcCSQzMKGv1dGaKrWaL82Em0Q9O+VOFX
         h+SPUV3p5bVMY+gAQyQFFi7pdJapHl61asuzrLTMWEthIxdXQiGjRO3keRp/oJ+QECpf
         OaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742575333; x=1743180133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SKYt3sHHGtmxEbzGtA8VcDHjqrPC95q+6qjv67gS2E=;
        b=EZFnbVx2ClRFhEd8njPBm/Xd4bacbSloGnBlMl3qyudt1WXnREweynfBPzAqbdlGGd
         v/W/YipL9oSDideE5xkX4url3wI7rSyy3weifJtZkWRtYG4J/tGn0DI05xRUIbSeCdcE
         U5JZc9QpYuRS+BJ/HLSmgFyXPEvh1KRc+TRPRqdO1aeqF4GEZMlaX3jaF6UulFC3UqgM
         Ee8D8LyS6/h9a5tJc5Fiwy1iPGMopdY12E6oVTXNnX4qQ9AAvjh7/3n9HVo9JLIraobv
         Vu2KDFA8WZFxgdF1LMEUx9kq+hRKda70GTOkigGiReDHPFDoGt/LeF3+TUQNtkRdBwB+
         4+Tg==
X-Gm-Message-State: AOJu0YxfoL1GNsRrzt4NRlvFjyNy3yevrG+2kS6XFftml4HoZydrFNO3
	ZEzot2ipGbxg7qzt2rrRj8rIqdENXfCrkOu+SC9LGYLhBc111RCDWKaXNg==
X-Gm-Gg: ASbGnctiUN+PJMoebZlJaH47v6MIToDRNQ0ADMJuofQIj86NjXSZENFI69NUrHWRxkU
	HGH0kkDwuJlxMZmsSMuaUl+YZ5ygRsD6h9rgHHF3wwjkLPUeKJ1on1y6XlHMKhz8n7iFN8yLdZx
	mQJxk4jXJ/E4iG/6QhRAJ4ndNa6TbmvEP8LYXzG4Yb2kzB7vSD1XQO6xK/uMI5m+aeUv+mLV5Y2
	EAan9Eri2cAuCa+oT8YrVqzVckliUcnXEwQRV4SsubLDzDxvQFaGlrni6hVNilZUjEu1ODvnoRJ
	PaOgUiEmqbFWwh5RVnUhfzmhHA1e1SDRRteybuKKKb3llohv1CHQmNCUYcJT9pIaXP7G/GCAmip
	uprPnDLvD22c5K/91mwxc
X-Google-Smtp-Source: AGHT+IG4Il1IbILkWBgUstwbjXK2kCF1MnwswXHCe9ilgpP1Hnw3FZGlioTot+SOFwhQ3gJWdQ2Lsw==
X-Received: by 2002:a05:600c:4503:b0:43c:fabf:9146 with SMTP id 5b1f17b1804b1-43d509f5a43mr45737555e9.17.1742575332829;
        Fri, 21 Mar 2025 09:42:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efe61sm2837322f8f.97.2025.03.21.09.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 09:42:12 -0700 (PDT)
Message-ID: <1849284e-b5cc-40fd-ba59-43559a20ac2e@gmail.com>
Date: Fri, 21 Mar 2025 16:42:10 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] clone: suppress unexpected advice message during
 clone
To: Justin Tobler <jltobler@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im
References: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
 <20250320014646.2899791-1-jltobler@gmail.com>
 <926210f4-a8ff-4ac2-8b7f-85cd5598d77b@gmail.com>
 <yyeid3njdsmws7rl3kcsxne52fuadd7q4emqdlvatwvcrnyl42@rfnk26mvcgoa>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <yyeid3njdsmws7rl3kcsxne52fuadd7q4emqdlvatwvcrnyl42@rfnk26mvcgoa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2025 23:48, Justin Tobler wrote:
> On 25/03/20 11:10AM, Phillip Wood wrote:
>> Hi Justin
>>
>> On 20/03/2025 01:46, Justin Tobler wrote:
>>>
>>> A side-effect of this change is that the location of the first
>>> `git_default_branch_name()` gets deferred to a later point of execution.
>>> This matters because `git_default_branch_name()` only computes the
>>> default branch name once and returns a cached value for subsequent
>>> invocations. After this change, the `git_default_branch_name()` call
>>> site that actually computes the value becomes `guess_remote_head()` and
>>> is configured to always show the advice message.
>>
>> Isn't the fundamental cause of this bug that advise() ignores GIT_ADVICE?
>> I'm not really clear why "git --no-advice" only applies to advice that is
>> guarded by advice_enabled() when it is documented as disabling all advice
>> hints.
> 
>  From my point of view, this advice message should never be presented in
> this particular scenario regardless of the configuration as it doesn't
> make much sense here. This also happens to be the original behavior so I
> think we should probably return to that state.

Oh, good point. So the original report actually highlights two bugs - 
the regression you're fixing here and the fact that "--no-advice" does 
not suppress the advice.

> I was also a bit suprised to see that not all advice messages respect
> the `--no-advice` option. I'm not sure if there is a reason for this, or if
> `advise_if_enabled()` just came later and not everything was converted.
> 
> In general though, other users of the default branch name advice message
> should probably follow the `--no-advice` option. I'll add another patch
> that does this in the next version.

That would be great,

Thanks

Phillip

> Thanks,
> -Justin
> 

