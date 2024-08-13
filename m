Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD541993B5
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555167; cv=none; b=aEHMfFTo4/z/hpUNsvaGH0hI2Wb20et4BOU0Qgnnn0HzeswZhvniBbrxLKl20P01ZfWOErOK9DCDOxAEsTQ5nHDUcggJBvrfHPCuT/L7bFWGLbHfrXUVWnafED8+59dxtYMzTy++XgEaFyPZu2mwU52Y3axl3/iqwUl5iEOX8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555167; c=relaxed/simple;
	bh=rZqn8EQIYMeI6eHFiXqZwZrkRn15OKyMEhXoKGH6QME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZlywCCc47WSz/9uVEAggB5d1VGHmvoU2X9b4OJyNe+UkoxSjeBRhf3WqfJx4Ypvaf8KXUTnp1WpUb/0bk+Lq1tcthD5Sa465ex8KskKDrozf2OdBnYCP/PTQAP2C1/KhowxRp25gTEKOkmNkGxgabS3sC+4pcRoH0gaj4sucJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+/LnXRo; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+/LnXRo"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso588322366b.2
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723555164; x=1724159964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P3BJeAzI3f+QoSTFL+SVH1jqq0GWNel0c5lnwydkMT8=;
        b=F+/LnXRofMQYbo+xtUZ+0zrTWgdOgYe4L2etMqv6CjhudofoWF/Xy/WhPFCEj2boFJ
         5mpNKPwJg/prTfcsfrSiZwlEoZTg/KMyxDD2uqbF8kCwynft84nYepr/5mMVLekNb9dG
         1+ohQ4hgqnFkiQ8567ZLxSXgGu06ogsbW1eKuNuTBGJZCDLThREiAqtyO7be+XhpNnSC
         dVHkIXSTdLpxaMISdrhDfFBLkIAuL/mAIfMXCA+Ilou+RiERv/0laqN9u1cl3M/iPgGz
         VyW2PchMsQpDWcDce0MtzhCTC8I9vCc/h1cz2xgygtUaQ/tKCT/vNCVkH0+YW/cq+wue
         vg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555164; x=1724159964;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3BJeAzI3f+QoSTFL+SVH1jqq0GWNel0c5lnwydkMT8=;
        b=um+/KUsZeTAWRwYNsk89OP9JAkBxGIpQhf5c0j77pFnHoE53aGdZzJouWKGJP0xCF8
         BFGZJa/+Q2wpLDSYusueyNlhIYxgU4s7sF+cfnmT7zV4ex9TMFAWOIpBbQTnJPCc5t9K
         DU/PJMQuWWgFA1fKOow/d+joDlG9uOYtSlGhku3TqhI2eK2kVCSpGq4+HRNNEmcAp68C
         ce+wsBlAChtDVE8607HkR8x7lngjihnKWAnAbWkRmKktMurf2/VZzoQ/laJKd02gZ/Cp
         DTZigxe2UuQkDWNa/BUvRYSmNqSAxdjj44QMKlH3D6/JwDsMamG8rFIfP5GZaOhZjAiW
         Q8XQ==
X-Gm-Message-State: AOJu0YzZJWNMTTLhco5K2ko1tbCeGHXH3db7RC0J3BspVj4BobKJ6umQ
	3j92Usncrw/jWVZ3+Uq48++VINd46g/guY/YB5uIGL2UtSYpg+UK
X-Google-Smtp-Source: AGHT+IHK7Wp4uaHIr1So/5iQ05B6nebukbVynSYXc/JUr1zDPW0v2cNFK6om1S1RWoVf84OrTng0Fg==
X-Received: by 2002:a17:907:f7a5:b0:a7a:b8f1:fd69 with SMTP id a640c23a62f3a-a80ed1d667dmr277829266b.18.1723555163467;
        Tue, 13 Aug 2024 06:19:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fb3575sm70592766b.90.2024.08.13.06.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 06:19:23 -0700 (PDT)
Message-ID: <a02e21f1-b2a4-499a-b767-3426876d31be@gmail.com>
Date: Tue, 13 Aug 2024 14:19:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
References: <cover.1723533091.git.ps@pks.im>
 <8d6cbae951177718b49d5cfbbeca2d5b0073e266.1723533091.git.ps@pks.im>
 <779795d2-eefd-4fac-b29f-9943f98bc83b@gmail.com> <ZrtKoVFci6cdvMS_@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ZrtKoVFci6cdvMS_@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2024 12:59, Patrick Steinhardt wrote:
> On Tue, Aug 13, 2024 at 12:29:47PM +0100, Phillip Wood wrote:
>> Hi Patrick
>>
>> On 13/08/2024 08:18, Patrick Steinhardt wrote:
>>>
>>> Fix this bug by asking git-gc(1) to not detach when it is being invoked
>>> via git-maintenance(1). Instead, the latter command now respects a new
>>> config "maintenance.autoDetach", the equivalent of "gc.autoDetach", and
>>> detaches itself into the background if not told otherwise. This should
>>> continue to behave the same for all users which use the git-gc(1) task,
>>> only. For others though, it means that we now properly perform all tasks
>>> in the background.
>>
>> I fear that users who are running "git maintenance" from a scheduler such as
>> cron are likely to be surprised by this change in behavior. At the very
>> least "git maintenance" will no-longer return a meaningful exit code.
>> Perhaps we could switch the logic to be opt in and pass "--detach" (or "-c
>> maintenance.autoDetach=true") when running "git maintenance" automatically
>> from "git rebase" etc.
> 
> It's actually the reverse: the old behaviour when run via a scheduler
> was to detach by default, because git-gc(1) did.

Oh, I  misunderstood what this patch is changing. So despite being 
tagged builtin/maintenance and talking about "git maintenance" it does 
not actually touch builtin/maintenance.c or change its behavior. What it 
is actually doing is changing how other git commands run "git 
maintenance --auto" so that it is always run in the background unless 
the user configures maintenance.autoDetach=false. That sounds like a 
good change.

Thanks for clarifying

Phillip

> We now ask it to not
> detach anymore, which fixes this. Furthermore, the default behaviour of
> `git maintenance run` did not change either: it stays in the foreground
> unless the `--detach` flag is given. So the thing you worry about is
> actually getting fixed by this series :)
> 
> What _does_ change though is when we run `git maintenance` via our
> auto-maintenance framework. Here we now do detach the whole maintenance
> process, instead of only git-gc(1). This logic is only being executed by
> random commands (git-rebase, git-pull, git-commit etc), and I'd argue it
> is the expected behaviour.
> 
> Patrick
> 
