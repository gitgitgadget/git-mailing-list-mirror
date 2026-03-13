Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863313328FA
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398020; cv=none; b=p2sVqafVkMBUEDjadg2vmWmHXBW4pnTJCt1ru42cABNmIigkBeEW0awf7A5u8haaWwzkGNIeupmN8fqFabDLj380oh1oXniP4l+4KjBS3g85Csgp1eqaUTcQEHIy6ZRZ6Er5hZcT/tjq+d1xTxAgA5I/DPdRSYYNRxhckKVo8zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398020; c=relaxed/simple;
	bh=0zh37BU6oxF4rmyr+LxWfwOZX6R2Ukq4H3tGydp771Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AKMwMN22X4YVThvXSV8SdiodMVOcov5+9esjd1DgQg7/vtvURq3s1oIXA5X4pchocsO306L5kJyZr7CKt8cIqnxFgSOLmeh1FQnk6Ns2bGBY+6MCwmJCqCKotb53lFrIzXd2S0dDTRUJk9/R3DaaaGSW0rcB/hyCCQN8IQUxmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFvgMlZi; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFvgMlZi"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b7a87fb5so1560075f8f.3
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773398018; x=1774002818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhYX3my1dHzJoOCF3UoCj1Gd6IOszSt8CmOL3EMv4f8=;
        b=ZFvgMlZiKW/XI5fdkhXeb+qNDbcsjakxEqdsRGxKGPCtRS6un41yuzUXjxWWOWhXGl
         D9YE7ewXIcoV30p0H7sGgXas+IF3YgXDrpwCp0fkXyJOd40LSYskLwiCSPtOXOkzyttQ
         FrCnHOolkDFqfQAA6oY/tX4SEV025nOwhiYumcGjUDVE1HphBoi3EbB00oihyQWiNdyS
         71o3LSEJbp0ynJ2aQWXITlVONhfOLZaT5tqySu8B/YPhhdh2xaKl+esjohXiAJb+1DAJ
         xAUWUX8yQFjJOxN/VI70WReg1QqYub8IFw8cjA97loEJIJ8aV5X4wy67RtzXXxshipHr
         9AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398018; x=1774002818;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhYX3my1dHzJoOCF3UoCj1Gd6IOszSt8CmOL3EMv4f8=;
        b=qDl3WRhByBoSXuVupjDuRzxE0S9hFbm3MLIZzskhdP94iUR5atC9X6eHcclnhQWUef
         Ni7R0Ch4Tqwfi2Nw20jcarFwizU0LgZiI4DsEXUzhH+mOepkECBU/kIT/fms8CnAySvN
         Zz1hUi3feCFgitQb1DuCSQwyksGAub815xT+PhTImSLNysKAPH9tVOC/js7h7+vvsDVW
         CjW0f62R//FrxwMxbdLVNTvGKIflxYZUdx1PrV5xYfWc8rP53yCs/BpL+cEgjplU6HUb
         LtoN5deKJxpaiNPIaY3xPVSKnyVZgV1Z+1H1MuG7n6s8Ump9rQO0+K3J7rVfDB2q5zvR
         xsBw==
X-Forwarded-Encrypted: i=1; AJvYcCW26fgDuftad019SxxAZ0of8Z1VxyB3BZHA3UxXEWhKnm7ldBfOFoViUDgeO09CyqgwxzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKcmOKFL7MV1B1qyMq6Pn8Ah1WhKwzUVQmhPYMjPtVrMYvl4O0
	qurahpo68UmMTRoJcOGsH4eCCKm9D80vMjhd811oi1Iwt8MR6mJpTkcR
X-Gm-Gg: ATEYQzydoEKFZIWTzydvVNZF21s6Ej6mNjNYZibh9NYdz6vnXMOkvW4YyTNodenkr/w
	0c9u8BtvNjlb6Mf3b/ZQcl+TkaaXMVmXOTUZS7KFoLCE3530i6ZmcZgHi5VI1ka+fqIP597IV4O
	+q/k43/mgU3HNdDs9cT64O4Ek0AbeRFX/r1/HCmbNlfL8pjDyf1CwScuSNLpJHHM3+goIABOr3Z
	vO9Ej6Vpfkdfokr9E1rN0NegVQrQA5Fy2wwqo374wl+iEPvNH3rlqFiFA3lN3echexZw8reeUHN
	ZmCGxMVkODDxYiSPN1K1vw7MI6ptz1uQ/rf8YvnnbGbNxM7av2TS9PKkdSA5xE2yrx2K86bYK93
	zYHPHyPkka+BeJGxKdcu2kqmu0aTzMBZRx5KUveugPewrJzxzn20G5thGx8bGHjUmEe4/vyBDUy
	8/y+2YzHsEWbdoVZbmwlf5IUgnY+Av4wKbOI1fvgC6HeCTbn/KMjT+qGxcFg+kHlDwcRD6cJ3Sc
	urbPw==
X-Received: by 2002:a05:6000:26c8:b0:439:bdd7:425d with SMTP id ffacd0b85a97d-43a04d79d2bmr5611477f8f.23.1773398017744;
        Fri, 13 Mar 2026 03:33:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm16273707f8f.4.2026.03.13.03.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 03:33:37 -0700 (PDT)
Message-ID: <3be0c711-5222-4faf-bd32-117230215490@gmail.com>
Date: Fri, 13 Mar 2026 10:33:36 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/8] meson: compile compatibility sources separately
To: Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?SZEDER_G=C3=A1bor?=
 <szeder.dev@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
 <a5d1ea70-12dd-461d-b5c5-a1127e017d01@gmail.com>
 <debb89c9-2fab-4922-af1a-6048094baf9f@gmail.com>
 <abH6dayn5tJBMY9p@szeder.dev> <abJbhQwc-X0T6S_B@pks.im>
Content-Language: en-US
In-Reply-To: <abJbhQwc-X0T6S_B@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/03/2026 06:21, Patrick Steinhardt wrote:
> On Thu, Mar 12, 2026 at 12:27:49AM +0100, SZEDER Gábor wrote:
>> On Wed, Mar 11, 2026 at 02:56:24PM +0000, Phillip Wood wrote:
>>> On 11/03/2026 14:32, Phillip Wood wrote:
>>>> On 10/03/2026 17:52, Patrick Steinhardt wrote:
>>>>> In the next commit we're about to introduce a precompiled header for
>>>>> "git-compat-util.h". The consequence of this change is that we'll
>>>>> implicitly include that header for every compilation unit that uses the
>>>>> precompiled headers.
>>>>
>>>> Is that a meson thing? I know it defines precompiled headers on a per-
>>>> target basis but does it somehow force each source file to include the
>>>> precompiled header? Looking at the gcc documentation it seems like the
>>>> precompiled header is only included where the original header is
>>>> included.
>>>
>>> Answering my own question the precompiled header is included via "-include"
>>> on the commandline. This is necessary in the general case because a
>>> precompiled header cannot be used once the first C token is seen.
>>>
>>> As an aside in git we could probably get away without using "-include"
>>> because if we include "git-compat-util.h" it is always the first thing we
>>> do, or we inculde another file like "builtin.h" which immediately includes
>>> "git-compat-util.h" and so it is included before the first C token is seen.
>>
>> I couldn't find this in the GCC docs, but Make's documentation states
>> that "you cannot include a precompiled header from inside another
>> header." [1]
> 
> I think you must have confused something, because the link _does_ point
> to GCC's documentation, which does contain the quote.
> 
> But yes, overall there can only be one precompiled header, and it cannot
> be used after the first token indeed. The use of "-include" is also
> explicitly noted for "projects not designed with precompiled headers in
> mind", which fits Git. After all, we still have the ability to compile
> without precompiled headers, and I don't expect that to go away.

Thanks to you both for the explanation. Should we explain this in the 
commit message?

Thanks

Phillip

> Patrick
> 
>> [1] Second bullet point at:
>>      https://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html

