Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21820AF87
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594702; cv=none; b=OW9Q5xzmEhhOSJ6in5jWky3xtTMXJleLGsBqqe0WXxzyR4xXjXInLl8fGv0wwmXmpC1q3QPxz+oxvsoes+VfHruQxxJ1IRZycnXUrZCWU1+fN8+vqm1UgY3/Y55RSyA3cWhxwZowWsyiPKa9UY62yCJnFspu/moV+r6onMIEtc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594702; c=relaxed/simple;
	bh=AzalhW2TUPpctJ0ysU4lVPaDMN31EX8Sks4WfXRqbek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJVcKRTMjrLpxtQu+dTre3JlIgP5ZlIWMh2RcfCLMXnAFr5FD2yJ+pJhJCYxtazuxBQBC4WjyQE6CE9xewqKvMANpROfrx3iEqHuDKHGM00bCXNxDyck3hBmi5KM6/Q4CgoFenBK9p5GacK0CmUTfUYTj8Kz/dTQoDWpVjUhceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2Isxxhe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2Isxxhe"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso3205000f8f.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752594698; x=1753199498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hFsOgSJAj1sab20o8D0PZbKAgvRyiIwGYAb77t7XFBo=;
        b=S2IsxxheTry02cGP/yuL1tUnFokWmCFNly/7NMqctXn2SUyZZ5KroQjKu2pQ1PmAQ+
         BrCCZnk4H7kFDFfQFUtT4tMPN4IftQ6hY2/DLWW7B/xe+vEpzXnod7EX2a/8E2PDQFRQ
         7/ctQQojZQZlCEmHEapZJD8xtRmI1Tvk5zknBC/R5VyoAzxsDA0So+c/kS1KccGcwUBg
         Fq1EeDfJfFSekdFK3ET2eQaDDoBjduO/6V2PVxt5vH+jMRE4um4Zq7HBujZjJ423FUjj
         6uQwrRxo4Kn8OHf7vmtcKy6GILMUBFqS2/v0T2wAVBFfeu8Mbv6vKX4503Oe/eAjRqMq
         G5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594698; x=1753199498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFsOgSJAj1sab20o8D0PZbKAgvRyiIwGYAb77t7XFBo=;
        b=a2mU4PWs1BTHMVhDhW5hgyrzO36tEBzvSl5n/Q5jXLyQbjQ0CQGwmlWsofBxrfedKt
         PYul54VPEPxlW6bb8kPeue5BxMx9ttbyVF5D9B1wHZaLXtoa6cJM/sML3eeqrs4VMgwS
         9LVteaKGBKa1APajVInO1txXcTSBMj951dHuF8UmzsAmZgjGc6yTUnJ1sY5RH8y7Dy9T
         T7B/yr2aJkf63sGfmz1UBcFXlDPrXjpm/p+XD4C6itbtjXOmgS7Dj9mXuVEdcI3FnQLE
         xaMTDyRuSMxXOFY/hmI/+PmeFbZ1MfAZ0vvBbiJE37CR2QCaFg2J0i8vzZCj+KbH8uHS
         XRrg==
X-Gm-Message-State: AOJu0YwkOBUBgUcpATma7uDYnlu2ijTG9MEm4fT+YtoRM5ttDHqdOwdC
	7HxtSBMHWoSZBbzi5Mf2GOP5plUEMBmdbKh5HcpuRObaq6YBl4hcRFoW
X-Gm-Gg: ASbGncsA2jSHFKt2CeuZ2Mtxz43EKPVOYwsSZkIPsvLMHhAQeQoIKOEKY8q9VaotQEL
	WMop+QOzTRZIceiS65I2tb3W9Sq+CakcPJhaOD5yP4ruSGxZIBZM9pap4QReWXCbAmBDbK1JWvz
	nDoVGOwu1AqOHlJO2PtGmgwaj/1lzmS/1rQRCp3KHJh3lMMl76dBSd7uOGm9U5ktwR4Gz4Bi5Op
	JA2DuOeKdelnm8pd/K8L7TipjUBL3DhrFrkEZ1i55e3cN4T/3aYmCjoD9TBAk08FoVeTb17Ah0A
	XPOd/GzMTLb0B0jAPiTTGSjpXNrmZc8Z8Bpjc80qCSDNp4YCQOuYsBx+lhsJ71ysYxSPo9aA5U0
	vHr4sS/qe2Vf2w+UgGXwQShRZzpb8dFBijH6W7viaiuWE7gzs4tKDawdl69KZ4d74iOS2wDpPWh
	Gt
X-Google-Smtp-Source: AGHT+IG1DKAhUhx1e5aQKTwjYi6Cf+WO9OZjSmZNesgOAziMFCkHY7/zylj/TxCfLtStmtkr/SIdfQ==
X-Received: by 2002:a05:6000:4818:b0:3a8:310a:b1dc with SMTP id ffacd0b85a97d-3b5f359b173mr13158148f8f.56.1752594698236;
        Tue, 15 Jul 2025 08:51:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e8b1sm15335731f8f.82.2025.07.15.08.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:51:37 -0700 (PDT)
Message-ID: <f6479d6a-32a4-4a49-a75c-589978cb9a57@gmail.com>
Date: Tue, 15 Jul 2025 16:51:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 17/19] environment: move compression level into repo
 settings
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-17-62627b55707f@pks.im>
 <32fceddc-c867-4a47-bde8-c873279edbc1@gmail.com> <xmqqbjpq1rs0.fsf@gitster.g>
 <aHY7LYHqVj-ECf_z@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aHY7LYHqVj-ECf_z@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 15/07/2025 12:27, Patrick Steinhardt wrote:
> On Fri, Jul 11, 2025 at 11:55:27AM -0700, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> I do not think adding prepare_repo_settings() calls all over the place
>>> is a good way forward as it makes it very easy to introduce
>>> regressions like this. Our builtin commands parse the config at
>>> startup for good reasons if we're going to move settings out of
>>> git_default_core_config() we should ensure that they are still parsed
>>> at startup.
>>
>> I think that is a good guideline that applies not just to this
>> series but to other topics that attempt to move globals to a member
>> in struct repository (or repository_settings)
> 
> So... the only real solution that I can think about right now is to
> start parsing the repository configuration whenever we instantiate any
> repository. E.g., something like the below patch. This has the effect
> that the repo settings would always be populated when we have a
> repository at hand. Consequently, we wouldn't need to clutter those
> `prepare_repo_settings()` calls everywhere anymore.
> 
> But there is a big question: what do we do with invalid configuration
> then? Do we want to die immediately when we see such command? The answer
> is probably going to be a solid "sometimes":
> 
>    - Some commands must function even with an invalid configuration. At
>      the very least git-config(1) needs to handle this alright, as
>      otherwise it might be impossible to unset/change invalid
>      configuration. There may be other such examples.

That's a good point.

>    - Not all configuration is equal. It may be perfectly fine to ignore
>      some configuration, but other configuration may very much be mission
>      critical. And whether or not configuration is important isn't really
>      something we can decide, as it will depend on the specific use case.
> 
> So I'm afraid that there just isn't a perfect solution here. Does it
> make sense to die due to a config key that isn't even used by a specific
> command? Maybe. And if not, which config keys _should_ make us die in
> case they are invalid?
> 
> The overall situation right now is a proper mess: we have config parsing
> cluttered everywhere, and the behaviour is just plain inconsistent. Some
> parsing is delayed, some isn't. 

Indeed. My objection here was that we were delaying the parsing when it 
wasn't delayed before. Is it feasible to call prepare_repo_settings() in 
repo_config()? That would at least avoid the problem that moving config 
settings into `struct repo_settings` changes when the settings are 
parsed unless the command calls prepare_repo_settings() at start up. As 
far as I remember `git config` uses config_with_options() so that would 
not be adversely affected by such a change.

> Some is per-repo, some is last-one-wins.
> Some config keys will cause us to die in case they are misconfigured,
> some will just be ignored.
> 
> So where do we want to end up?
> 
> My dream would be that all configuration were to be defined in one
> central place. The configuration should be typed, there should be
> verification for each value configured by the user.

Being able to verify config settings when they're set would be a great 
improvement but we're a long way from being able to do that.

> All configuration
> gets parsed into a structure, and it can be parsed either via a
> repository (in which case we take into account its local config), or
> only via the global- and system-wide configuration. The whole config
> needs to be parsed at startup so that issues like the reported one don't
> happen where a subprocess that uses more config keys than the parent
> process dies because one of the extra keys is misconfigured.
> 
> But I very much feel like this is a pipe dream right now. We already are
> working on multiple fronts to modernize the code base, and I don't quite
> feel like opening up _another_ large transformation right now.

I agree with this

> So I don't quite know what to do while we're not there yet. Without this
> large refactoring, all approaches feel like they aren't a perfect fit to
> address the bigger issue.

I agree addressing all the shortcomings you've outlined would require a 
lot of refactoring. If we can find a way to avoid introducing anymore 
shortcomings as we migrate away from global variables that would be a 
good start.

Thanks

Phillip

