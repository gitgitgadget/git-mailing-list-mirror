Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC32306B08
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957501; cv=none; b=nsT17znHCZAo5t9ptS7v6ZEyAwBrK5+qRRUkgL5CV6zM/kno0S4iF7sQsXC6sW2tTe1xEUusf1q6gXgYdGQ74ZisNSCdyyI0RnHt+ktHtfraQdtbC63Us6lLQu1gVtk+XMyxLULQsa0Q/DFZNgU+CnSg9F8E/dOeiegUekDp69I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957501; c=relaxed/simple;
	bh=GFGWNWuULR3rGrzY1HBhWfmVW8CjUtBFPgaGuz0Ne1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a+xOwidco8+TOOq6TptlnRY/nW4uAOqo6hLJPAmOicGuKzJBc+YnDaD3lqAjUQW6HOv2RO7fRQdpV/ToIKryCZAUqsHn0401gkzQ2nrzfRGptm+OgarNSPGNQgFCCFQxGeIUzWZZu1cwVwxMqYypIp5sIMk474FVCise4r0JngM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myGeLt8S; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myGeLt8S"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ba9ad0fbc3aso466039866b.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776957499; x=1777562299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YzLwxOAztziVUtkQK/0mtkg+MLSp5yo5eevz6OE+/xE=;
        b=myGeLt8SdgSMZa/5Vf8/1uDnhK1P6wVm2piF9pGO8LvvQ3FdPj+DFZbi3EUaw9bCIg
         WOTwrwm0VWTtEuhKBiyNmG6JU0LSj/TdmG8WVhrrLTVYH7IG7nCaSlMFfIbZJF8mi5PQ
         K6dMZM0k6zGZZO5owh/mHHlwfeHezWaH6ddeLUH6d441vVkNGVT76+Aqg0WolsoiN95Y
         AQMPJDD7y/spcwF2dka++1i0p0KzPH+ZcTXiEheAnExHuVyq86rRo36BsrQRTf/BuZuO
         M28qn4i6bvgLPx7p9EV2XGB9FlAQCeNnW5RBIhcIPKgpJRUs/c/imywC+FuASNz7bzKN
         6cbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957499; x=1777562299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzLwxOAztziVUtkQK/0mtkg+MLSp5yo5eevz6OE+/xE=;
        b=QPzvvePOtEGMKwJbE57YlBEbVd/mA+kT4TqsovDg2djBkiJR1gkPnLBYGdCHvbhtby
         plyVtIBEnMTJNzBJDyzmhdEKL3l8fRsNOpwYh00zvfgnexJe+g5dRmBJZ6FolrQBPKXg
         5Mh5GIGBYFRCYOgQwmbxfJEsu5ssVXIyLhxlMyVFyb+nJ+jC6VylRUZzi6t2+flV5f5I
         xx0pGht92ymQ58isdSAyzqPkccD9+TGCvZm3EVKPCPKeeD07OdIY8fKUdtFF64xi/uDC
         TDzjRnr6Aj/5Gcy0sSNObWwszZ5oPcEI+ccYmzkXUzYX6TdEn31bvxG7peB/PTjkO2lK
         lang==
X-Forwarded-Encrypted: i=1; AFNElJ9DgIBHHdJxLuiexOjGHf5LxZl11Q0UQ7DPqo4KBX59TFFYWT4+1GnHV7WRTJvLc++byGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHql1aHw5GMd9fRN+KL2UrCgZbJs7cVQ9oI8ulUGzUX4EBZg7q
	Hz0o8e5uk8KYFP0OsQ1PySpMyFqn7e5iMBp09NX11UZ/JsMSLvPnl0TPIT3SKA==
X-Gm-Gg: AeBDieuQ7b9TQAfwdKSDfz1/RbXqJ/Udik7ZCjcB7NFIr+RlgXnj6kp3sVXRMDz3SeE
	pQY0pFH4tMW7/0PwfBewgJAicQYfKX9JSJcQTKrqOgQGL+mi6BNLjnEtu1nFn/1xvrOAmSI+ISz
	Pyppz7bmkF3VfsQt7/r/WPh/Zl2uYPtTsd9MwchJrl0tgLcIVcm9un/XkcmdhiHK0EE2ZMsp7cF
	xNmGt6a7Nsb1UFcbpITlbbUMtDX237M+6ecjQ91NSGfA9PtTTaNKajeKFhSKmkiJGs8uvnOip8B
	PuwEpUS+OhLcHcJ+7sgUxcWEvbZiUI1zfjfqrURgemH9j2ER4B6Dz1cGrWT8v/mBeMpijPnRXIJ
	TtpEzapbLP11sTeYeQwJROFv1BhEFr5KF+MqXpSqFnKHxUBaIWjHi6dYMZUI7nvQZI0dfCGProy
	J7eNAOwQVXqKkElS4muIBw6O+/l3J/dy/nzB6HV2ujgiT4lLMp1zVosBY2XiQkoMXaJnD9KyRCD
	6O7h7cAF+YcKQ==
X-Received: by 2002:a17:907:6a16:b0:ba3:a8ef:3597 with SMTP id a640c23a62f3a-ba41aa1613bmr1520903166b.25.1776957498289;
        Thu, 23 Apr 2026 08:18:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45504441bsm664011266b.45.2026.04.23.08.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 08:18:17 -0700 (PDT)
Message-ID: <9a89b713-0f2e-4a71-945d-c1931145c74f@gmail.com>
Date: Thu, 23 Apr 2026 16:18:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Apr 2026, #08)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqv7dix8pi.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqv7dix8pi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/04/2026 11:38, Junio C Hamano wrote:
> 
> * hn/git-checkout-m-with-stash (2026-04-15) 5 commits
>   - checkout -m: autostash when switching branches
>   - checkout: rollback lock on early returns in merge_working_tree
>   - sequencer: teach autostash apply to take optional conflict marker labels
>   - sequencer: allow create_autostash to run silently
>   - stash: add --label-ours, --label-theirs, --label-base for apply
> 
>   "git checkout -m another-branch" was invented to deal with local
>   changes to paths that are different between the current and the new
>   branch, but it gave only one chance to resolve conflicts.  The command
>   was taught to create a stash to save the local changes.
> 
>   Will merge to 'next'?
>   source: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>

If you can hold off for a couple of days, I'm planning to review the 
lastest round tomorrow

Thanks

Phillip

