Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D922538F
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767781071; cv=none; b=BkMJowqOPh6ZxuAmyiDnDSqzyytNiqxt7mn3Qizrx+EQQoVFKrM+48uYLBd8iPbu3CbuTfw7sB/1sp2I6P3cOjr8mP4gEjFytrzrTw7sRa5TqyIfwTu7e3dHcASwKcKo6NcKgdE/vMwNPXWbiAvMed+4Dg2mK3ITCOaNi6mwA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767781071; c=relaxed/simple;
	bh=nUGKgcuoMVRbiqJknyMFRKVo4qOl+ETsuTLTbgHFQY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzfFpxq3WO16L8cRHTliOAr6iQf4H7zeDWwAjbwtfxPEPbWXkPJupWLxtAJE4pdHSzLNNP27czHewroPBZKkZY45VJUgdM1ENn2PyGGOThE4jEskGB5eyl7S7bMnRwlA1oPJCRc8TK/VEJ5geyBTFBcqRRD98PbEZhbID9VB+O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap0VcfSR; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap0VcfSR"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-477632b0621so11484865e9.2
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 02:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767781068; x=1768385868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kh5Px9sMwxMsl/wjOEN+hAhblWqI1vonYuM7EbwYQAA=;
        b=ap0VcfSRbhP2btEVHELr+QzCXPrkqSelltQ5PF/L59ihxWffHY5nCk6RqFNM+QY51E
         0yV2WtG6fIxWI7TBv2oWouEr3dQhGXRX2Fo7L5fJNN8qGTdEp4JJZ9WOM62nHPB1TCmU
         uYpZHLmRfKO11WmKUNkN24fITjtf6PPUbUmFd2GdgcHw6UBPsypsZVLsrQ1dVe1iQ5+p
         WqirfsinM+EUHRm0Lf50cZg/te6xQuJ+Kf3RGxnsj4Vz2P/LnJ2OiZCGGsRsLX/KYlqm
         10qNNTFu2pHOPEcUnVtJh8JZu/4jAVFl1mN99SX7xAauzyt7cNz7yY/Q2CnAqRqVF+88
         wy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767781068; x=1768385868;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kh5Px9sMwxMsl/wjOEN+hAhblWqI1vonYuM7EbwYQAA=;
        b=W6rkkvQmUkEEjO6/Vqam6ViUUOyT6RPUNn9zRL5RkACPdGoJkeqntMNFfA0eIHLByS
         m7paEKEwI7Kf5S5jXLMXyP4ltZcI6gO2APcQz7RGOlxDjDp6sAPSDGauT6wD5MZONXVB
         hV0FHUeJbUUyMx1f4OULuj7uSCdP3g0Sgw2ZIM+5ztYp+IqcEmCBL9SYMq73iC2GBanV
         OYTmCVhyvDBS5QQTXSYdx6mdSN+k5JkhrQomK1aD83hQTZgPQ+PQVK4Jhy1IqMAtIEPR
         tbiDerCeQXFOqqwL+OB2aRGMuuGqhmMBauIcWI7WMx5X01/+C2wcrgIdxInGhOSDDHdz
         vBHA==
X-Forwarded-Encrypted: i=1; AJvYcCXpOPC/0wCBu3DoxyQ5Xyc/bqP6ZGfepPm0VXUr4Y1yu1UFGebMANRG64Az+zqF7nw589I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3X6uPmzODU7CDrEPWa2HIxIgDYVcwPm7qhfbT2bwStCFIDD/
	OL0SfgUG0U/2joVKW9/RCbp2PcFeQRXLyR1rt/83OdjKent46ZpJNvMB
X-Gm-Gg: AY/fxX5bTn9FgPaItwsyW8o1tVS3cm0C53+TNF8Tw15UX9t5bjzS7qbFyJMj9sBIHE5
	zSJXaJTAj10zN+evFaSuXIQdKV8RAOFsiBupoDytgar1htVTsAXmAy3CEkTe5c8jMcSdm9Nso6N
	OonIbJNHfCYMAMywf55bzqkryGqxo1/3ojZErWg6Zlt1bDW+UilPR5AIycezVQc+uIyAtqXGiRn
	8VdYP7yvH65pIzVub8vElYkvWyEWNo4lXKlmP7zjxWGKLKqzMRT0voklhkGmuR8Id/U3cScgnxu
	wi48A6BoTSd1wN/EFbB8tIi5+rUuaDZP4XhHzGoHf6P2vGcCm899VxUe5ZPGMLnjr56lRI1EZOa
	aGmZo1ZwTpKLslU2XD79fXoPC7/Ea4L3T9EolhPoV3Ys/3GBvliYLZMM02pki6amtaOgwaG1fob
	VcCi1/2Gs1/E0XfuYSgMMNQZJ8EUdNvpPWJG2VV5Q3s8tcaWEwYSdwLUNRlWFTDoD53A==
X-Google-Smtp-Source: AGHT+IFaaq57CuL+NQS1QNb+9ZheTOrQXLWuAnfg40JuEYA0RxU9u+bD+kYj722vhtJFwvDZX9Bt9g==
X-Received: by 2002:a05:600c:3555:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-47d84b3b692mr24287415e9.31.1767781067821;
        Wed, 07 Jan 2026 02:17:47 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f69e802sm90746755e9.8.2026.01.07.02.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 02:17:47 -0800 (PST)
Message-ID: <34175f3d-0814-47c6-9945-7c19f2c60ca4@gmail.com>
Date: Wed, 7 Jan 2026 10:17:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v2] environment: move "core.attributesFile" into
 repo-setting
To: Junio C Hamano <gitster@pobox.com>
Cc: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org,
 Christian Couder <christian.couder@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau
 <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
References: <aVfzMsN2ouY3UBFG@ubuntu>
 <a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com> <xmqq1pk3lmu3.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq1pk3lmu3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/01/2026 22:24, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> If I run 'git -c core.attributesFile=~does-not-exist rebase -i' with git
>> built from master it fails immediately with "fatal: failed to expand
>> user dir in: '~does-not-exist'".
> 
> Hmph, if you call any behaviour change a "regression", this may
> certainly count as one, but I do not necessarily think the above is
> a good behaviour.

One can argue that it depends on the command, but a as far as "git 
rebase" is concerned this change in behavior is a regression. It is not 
just rebase that is affected, for example "git merge" in a partial clone 
now downloads all the blobs it wants before erroring out which isn't 
terrible but it is hard to argue that's an improvement. I suspect "git 
cherry-pick" and "git revert" are also negatively impacted by this change.

> Think about a use case where attributes are not used at all, e.g.,
> "git -c core.attributesFile=~does-not-matter cat-file -t HEAD";
> would it make sense to barf when your configuration file has an
> invalid definition for what you are *not* using?  So if the change
> makes it stop barfing, it can even be argued that this is an
> improvement.

For some commands, but the fact that other commands now die when they're 
not expecting to and so end up in a strange state is a regression. Given 
how widespread the use of attributes is it would be hard to audit all 
the affected code paths and adjust them to the new behavior.

>> It is quite common that moving from parsing config settings eagerly by
>> calling repo_config() at startup to parsing them lazily via 'stuct
>> repo_settings' causes regressions like this. We really should find a way
>> to address that before moving more settings into 'struct repo_settings'
> 
> Very true.  If we know the set of things we parse early and have a
> way to say "this command only X, Y, and Z matters (but not W)", then
> the above cat-file example can omit the attributesFile from the "we
> care" set.

That would be nice, but it would be painful to implement for commands 
like cat-file which sometimes need to read core.attributesFile and 
sometimes don't depending on which options they're passed as we 
typically read the config before parsing the command line options. We'd 
also need to be careful to update the list when adding new features 
which depended on config variables that were not previously used by that 
command.

> I think overusing repo_settings is a disease.  Moving a singleton
> global to per repository (by adding to struct repository) is one
> thing and it is very welcome.  But changing the way configuration
> variables are parsed (e.g., what used to be parsed by only those who
> care about is now parsed by everybody, or vice versa) needs to be
> handled carefully.

Indeed

Thanks

Phillip

