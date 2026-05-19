Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22AA3812CD
	for <git@vger.kernel.org>; Tue, 19 May 2026 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217226; cv=none; b=aNkyRZM44MXNA8rzCA2NaRr0/In/RLRFZbFrWpO2EJbxkO9/HVJJ5y+Oo1IcrI/ydx6F9pwfkfxp7YFnfLQwSfvXb/fGjYddCa164QrMU3nD0sb/0r7x4PTGxgwApxAmCniUobuWMWHs29FKHm1MSCHhdMQFhYe7+4R8v3X8EEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217226; c=relaxed/simple;
	bh=LBuVSYVoJaQSRJIRD4Q5W853Cq7VDAQ7UQAiyUxelpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtOJ9b06r7B8Rv9Ka2EY9tlSPAdrDFNw563GUNFf5Thm0BoB8kfDzskKw/jTkx6DE9gXrirUvodQHYR9CES9eDuqDnnGccWDEGqpWQe/j48nRhXfeHTUEjRSly6QJgfWclB7Tt+1WTMCoeBiISkg0OKosn1pni0pHkUEyYeaCqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2K/zq6N; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2K/zq6N"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-514ae601e01so41758641cf.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779217224; x=1779822024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QREsH3M6vNKo+/jw+5byJ5iAZUQpIP1DkfTWcpF2Z2A=;
        b=P2K/zq6NivJplVcUP2on8iIFfDdUO9jH3Bwhm4EcQISIN/HEwW4tif/F8QHZxbxepn
         9Fmf2MtDARZr21yyt0EWVC7sO3rz4a8pUSAsk4D3kOdWSYwX6K94EwQrYLbE+xxf/RuZ
         RNxnkbYJmlnEmqkE2GjyE2QWkUGxWNlBHnkBQR0DsvMc0HcbUwGFuz8pUU+iY6Lh9Orz
         /kQN64qd64tMehhwqWWcY43Ac5zOnillas8CSNIpFF/Vnnt+YbtD4ELU3U+7o7yc0KzX
         8XDzRBZlXXrM8GGS4nUHc7Dre1ftlNiq+fNtk1LSUowoTySvMVov3ByWhA3bV2EqXAFS
         fPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217224; x=1779822024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QREsH3M6vNKo+/jw+5byJ5iAZUQpIP1DkfTWcpF2Z2A=;
        b=LuqG3md7OFR0HNrJk5vEcWTDeynXtLEvhX8GekWmTKtlL2Sr7zZGIPEKUgn8h5OMUn
         g8YMjp8qPr6Ql/LQXUoDs8c4wkxWkldtvJfxgnJ0VCy6gCognLTXBciT6PBxvTQMwnL8
         GctvQk5QA9sXa5xBdd+KecdBVUhEC/75y0s8zCMBFKoyD0DiM8xFtfML89b1tZkZjXOT
         Cb8BQCEP2Om7aehFzXxVxdKOLzQeN/o6wzdgJVP+bL5wH2oNbjJwngz9Wj+lvz6ctSnb
         V2tPOZFHa9gMdavdQvshIwaSHfr7BC9+HuFV8PxgHp5l0vUUULvtVot0QfU0PJbpaEpo
         BSiw==
X-Forwarded-Encrypted: i=1; AFNElJ9npwSEA4RstLUXPz5VwVC9DhCpilMjQNIR6ZXQDkBT8w0cdinKGrFzHA/In4oIatcfqto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaRqZkZ4HIJM7x/6trbGinSpNe8rfZHP5eCMnRr+juQyN3trx8
	t3g3G06ii/eLoCojsjY+XKiX8UoJT52F0m74BEMD+OdVvqJYdQ2m/E3H
X-Gm-Gg: Acq92OHXT/X7+WB5U3xfwy2vlT5XRe1fwubsJQ8NXXf2L/ENUPQ73PdRTMTwd5gRKZr
	fJuun2oD59/sz3kRrvw/z4qVtz29IydqM2/CQKSNwxMKydyBPWm6LNYr8wWsiL/UzEDanjaxFaX
	Q/Xtk9G023h5gNN13MiP3Rs0sHINx7h+9T4U6Y3ZsJIepW02u5Q/sd6FAk+qV/+R69YhWfVWdih
	FikKS9c5CnArCkZmLGGuUIKpQ4TDPTarXA+uW71jRR/A17p4bD2aNwXGYx7i8gNGrdBxNpJSCC0
	5TGQcA03S0oXTmNNDd1g0lBLzCd/Cnb8zx5/w8/xxLOgImCEcuuy2xnhjq7mv5T1Y0Roe645j+Q
	6oMz3EkNOnkOSzwp40uQQFEK5pSB/BhBhSTXU+hBsFabReDbWm5kU2uhnRAM+HWCctIKgdCGv1O
	SIvurVlcMQne5TgMacZMpCaWHAow6RxBuXzwhYy1xAthMAgzbeP+mVwQDy
X-Received: by 2002:ac8:5f8b:0:b0:509:34b8:a373 with SMTP id d75a77b69052e-5165a0d04f2mr294357061cf.32.1779217222695;
        Tue, 19 May 2026 12:00:22 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645688bd9sm171594421cf.6.2026.05.19.12.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 12:00:22 -0700 (PDT)
Message-ID: <7851b418-0641-4365-aa03-4ee4d95509ea@gmail.com>
Date: Tue, 19 May 2026 15:00:21 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/11] git-gui: improve worktree discovery
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-11-mlevedahl@gmail.com>
 <8b8feffa-1651-41aa-ac76-d2721d656b45@kdbg.org>
 <f654eab3-2157-4591-9ae0-440efb052e8e@gmail.com>
 <5081fcc5-19b5-49aa-a33c-2c13aba7edb1@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <5081fcc5-19b5-49aa-a33c-2c13aba7edb1@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/19/26 4:16 AM, Johannes Sixt wrote:
> Am 16.05.26 um 17:28 schrieb Mark Levedahl:
>> On 5/16/26 4:16 AM, Johannes Sixt wrote:
>>> Am 14.05.26 um 16:33 schrieb Mark Levedahl:
>>>> +	if {[is_gitvars_error $err]} {
>>>> +		exit 1
>>>> +	}
>>>> +	set _gitworktree {}
>>>> +	set _prefix {}
>>>> +	if {[is_enabled bare]} {
>>>> +		cd $_gitdir
>>> Why change the directory here? If we run `git gui browser master dir` we
>>> do not want to change the directory in an uncontrolled manner. The
>>> argument parser will want to check for the existence of files, and then
>>> we do not want to operate from a random directory.
>>>
>>> Also, I think that the check must be for [is_bare] and not [is_enabled
>>> bare].
>> [is_enabled_bare] is correct. This code handles the case: 
>>     - neither the startup directory nor GIT_WORK_TREE are useable worktrees, so [is_bare]
>> is currently true.
>>     - the command given is browser or blame so a worktree is not needed. We can proceed.
> But in the case where the command is browser or blame, the argument
> parser must later check for the existence of files, provided that a
> worktree is present. But this conditional would change directory to
> somewhere that is not a worktree at all even though a worktree is
> available. So, I am still convinced that [is_bare] is correct.
I did change this.   but...
I have reworked the blame/browser parser so it fully matches git blame parsing for the
single rev + path (or path rev) cases, all now do the same thing with or without a
worktree as they all work from git history, so having a worktree becomes almost moot (I
found issues with how git-gui handles --, it is dead wrong in some cases if the intent is
to match git-blame). What doesn't change is what blame displays based upon uncommitted or
staged changes in the worktree (if it does anything, but comments from 2007 suggest it
does, I haven't tested). I've done nothing to change that, only finding the args to pass
in to browser / blame. So, if a worktree exists, blame will still use the info there as it
does now.

Mark
