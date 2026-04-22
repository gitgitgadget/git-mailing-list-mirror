Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC9A244687
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867254; cv=none; b=NXN75g7l6E2zVTg2VpNuEvrmH0k6D4kxwQ3xvcwoMnCdeGJ7Ig4lM6BJ1T05X3XHcUTbqCybFpWBfRa6Yvp1eQYfzXTEiku8u48ameZ21uSRLbxKTa04+84Y9Irdlknh55osWas+bTE6T3D+4aowWayOOOGf9mrz2Rykx0MFFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867254; c=relaxed/simple;
	bh=u9NbPEwqjds8vsvgFe256g8ZJlUJL2/TGvTcV8/O8WA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ioEoF/w5niDDBcLF/vHxBC3ABP1PtZ4XrCJHMpb+fBl3w6WjW/I0GhK5wsVYkh4czJmtj+9RktbK1+JJgkv5gy0OX3XQQumNOf65x9lhk/SISH7qFnGb32fE4PTgptenkuLCeKc69mWG/eOpbaYKZuWx3BO01rLPNHZW0vnR0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jygCQLxU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jygCQLxU"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so23810245e9.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776867251; x=1777472051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/KhhEuaepn6vgT66ZtBEzX46EY95prVn6Y8FtOANGM=;
        b=jygCQLxU+GOH2aXGojkKzm2WpG0pyywrrxtU0pL3MOfVvL8ZnFqqOHR3bZVHVk3p1C
         LWn/72asFAs4WK/xgSnF8Rf1o6NWn82rElZr+V92NL1/sdkMurFCBZquG1b7hReGzdaf
         asDFa5dWPnbIHU5u6wR814vOLWGJ3AzrUkJfClg6bdyYXNDEUlzZFWuF9Aj3iyeIFSvd
         mbuXVqSFpzy5995tCJDn5qP3jPIS/+iuKelE0H12XHtG6IUWjkuF1WUCVK6WPWkCfgeW
         M6hYCjzrut/jPv2hw3jQ6n3O3sCq7lS3AK3zYqM6RuFui3JHkqtvjG+vklzjdfj59SuI
         WQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776867251; x=1777472051;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/KhhEuaepn6vgT66ZtBEzX46EY95prVn6Y8FtOANGM=;
        b=RFvtqToN3KiCfWN3nSl7s+nabNIp8qb9Iq9fO5gZclqSYhSkAESj8EmUpcq0UXYe47
         RfpkMYzCxIrJxbJVoAYjGjzOvNCuRPeWh4vJ2aivF1JQbLD1byJ+CWVRv7x0C4ZBo3Wy
         dKFXIoPk27BD5f4yTQ805HpLofQTI8e/tQO4lo/SQWDA7oQtJ31OctOo+Z2hlj7YYviQ
         7FvJDptVlvAHWX4zImeqQFhKc/WMaZYiuT9IwwoUeEFRw2mSHimBiUMTqgeRawoT7HwR
         Y6nFlyJjAbHhHgKEF1hrtw9MZrw98DJ2805sd404WbPXp2frS2u2gN3bm+UY2s7J3p0B
         y7Iw==
X-Forwarded-Encrypted: i=1; AFNElJ+t+lfuke13TsBOT98jH3ZL3rWb/LU4A58Qc8PLZ85bTbwRzpZc8LPq6PxHFxFd+6kWW5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1cnLjPZ/luybxygw05hXOLPJ+RB2OIw9zpXLuvs3EHErgz6v
	rNnRkYf9zOJ5hTAYPDdKlG7W31qBzq5y4zrWri8VCciQBjeR6ShLJjuy7ijoKA==
X-Gm-Gg: AeBDiev+DTUpDDTRHr5Nc2E49cL7nAWcEcABlJn4No8oKwjd4q60Z2paLh0OPoG7DqW
	aBQ1sOwCjDz6APHDFUYr8cbffofp8xURNKeJ9pLGx8q6UgCPP7bk1eYDaqzVEEc5gQ6MtEK0QpX
	Oxj5m0uDZQrImpngGvOjybq9wqHKZMSpMqQ9QgyvJ501xNGU8sTtBNZufHaSqu5UhQ/MGSSyT4D
	MrhRPtu1PY7x+pXrK98jFZddybKdv0SL7toIACV2oefF8hOO8Kn6pPfBA4lPdcvcGYbS4FlbkRJ
	BjbUUAiKg1X7o3Zzv9orRsCSRjPNm/7TD5Hc7nci/78k7hliI0URor9T1cVAtZrRXVYvRfA/MDr
	N4kSxolLCQGfUXq9DUclR0aeNRxIyH7wInu0e+RPizNav+4L9awGkVb10BWvuutzLGTYDJng+jQ
	BGp6v1kdwcEcykGlIHqynsf5Od20DIVRN7D1t747yz/g7EEtAafq9ojY/crdv0RasRosLmup2L0
	ev+TncW2tGfAQ==
X-Received: by 2002:a05:600c:1d05:b0:489:1baf:8c03 with SMTP id 5b1f17b1804b1-4891baf8d2cmr178436345e9.11.1776867251261;
        Wed, 22 Apr 2026 07:14:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55b8baaesm200984935e9.10.2026.04.22.07.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 07:14:10 -0700 (PDT)
Message-ID: <95b91177-a4a8-4039-bf37-b4ce8d2477bf@gmail.com>
Date: Wed, 22 Apr 2026 15:14:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] status: improve rebase todo list parsing
To: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
 <d20dc1f6550078883995ae963b91faaa00984c6e.1776697483.git.phillip.wood@dunelm.org.uk>
 <CABPp-BFziRXjuMKqf=RHgCwuCcujXSSrz0f+BS4pvE6EUbk-WQ@mail.gmail.com>
 <aejM4EY29MGht5or@pks.im>
Content-Language: en-US
In-Reply-To: <aejM4EY29MGht5or@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/04/2026 14:28, Patrick Steinhardt wrote:
> On Tue, Apr 21, 2026 at 05:32:21PM -0700, Elijah Newren wrote:
>> On Mon, Apr 20, 2026 at 8:25 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>> +       /*
>>> +        * Avoid "default" and instead list all the other commands so
>>> +        * that -Wswitch warns if a new command is added without handling
>>> +        * it in this function.
>>> +        */
>>
>> Nice. :-)
> 
> Do we actually use -Wswitch anywhere? A quick grep in our code base
> didn't surface it, so I'm a bit sceptical that we would actually detect
> any missing cases via CI.

I've just double checked the gcc docs and it's included in -Wall (I'm 
pretty sure I tried deleting one of the case statements to check before 
I submitted the patch)

Thanks

Phillip

