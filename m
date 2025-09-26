Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939862557A
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895415; cv=none; b=oMlkm33FO0G25VHjtK9zJBAX2eGhWshrDuouzts/WdySUBKhke/Ni0pcT/vWv9MD0fcfxmoyKp4vBxVV5AmHqTm57Z0oSMgFwoUe/ezXD6NA1d3Gjtvm8QgIlyqm5J3TgNfIftkWJERzDEGxFpwVI/QnyTjKEMgMi8l1AUjfW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895415; c=relaxed/simple;
	bh=wlMZGfx2bz21JW9+Vs4TD6kNM3WkP3LHkIOx77Bqwh4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L5fAO4XGxHy2pdrsnV4vPiZQDFEwGOftlS0FQspRYAroW3c4vZG5a740Zgmjw27OXnnkw8NvD5O2kMxKU9pxXF0h1YtiiUIicYhfC46bZfjHjPWZT6n/V5Vl0My9g/n9THPsJnFaI3efRk4aJi/Qq0pHjfKQuB85ugbp2bL8WrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBvum3/q; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBvum3/q"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-84827ef386aso139392085a.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758895412; x=1759500212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fbUbQi6rAWcEr2hK4Ua7iR+DpZKGvgSebqyYyTEEwnM=;
        b=UBvum3/qfnjZRJKHCmItKRI68ucLm55K8fovNSMDriig80XnqnNPu/QtFCg+Ue88a9
         /Vwz3HYqGGETvoutKQpxHvScD2J1lfW3L20y6CRcSugz3STnwG7ASOtImvBqQJIYaMjs
         WzYwncx8ePSlWD+K9W4Jwjfyn1c7lhRH7YU/iTHwTjzupuI6jRt3WnXBPbpjo/+m4H6M
         B1gX+J7ryKH4srWyE7yB6G+vyRF4HVGA+kqjS/0qeDgtDUzZ/lKzSFxdgVyRxLRYu1Qm
         EW1ZWLJ0e2kjYMKBXtuynSOUgs0PjlXH+RHtdfjkXlJQZcRFR0tAU72hlqinaG6NkPU+
         ZpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758895412; x=1759500212;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbUbQi6rAWcEr2hK4Ua7iR+DpZKGvgSebqyYyTEEwnM=;
        b=t5TwUJZqBVmdhuyWl+2UVY10t7i50v5fXYaGy/cu6seCoRBMXzpjjprQHyFYrUhQwn
         sdMtGuBkt3Xi6GrW+ucmQArcRV6miNKhN883acEpqXTNULzGS9O+TcbInXZMa7ozxp6M
         MsB185Fg9Nj2dqaKM2xq2U9dKnDJ/0loRK01xx4D84OVI2euHat7RbFrjAKXmHCtOiTW
         vx55mMv6ScRKnxkyjb1PLdtn3+JC2juRe4wMsacd2GVCVbz295BLE0FIILe0cmcpzoSz
         VyOu0tEEIMNig7t2aC7Z5wa1U1WkJ1jWU0EBWzP/Ry9GtZ1DoMEmflNpkHsEuSnC2AiD
         ujUg==
X-Gm-Message-State: AOJu0YxEe+bsh9fLlLT0qjS2T2OC0rfOvxpjPsPkcLx7V8L4QcQJCoxY
	CPdX9691Pfz+PE9PkVkUtxT5skeHuks3Hk3i/1jdmwdmFnevwCW8UiRk
X-Gm-Gg: ASbGnct5b00HJCn1TRY5mtHOKZIDqZdn4puzaYeeCH/briBTLnS0++AI787kwcbnP02
	z4+c5LoIilPGlPuu3Coe6JCZFFo26bh5ZpIDXx66A2aWNlJlFFFADcrMGrJJz1OoxbelSaDhn3X
	+YBE9QH+0PmYknwcYsOFaS2gl95KKnhgqyXhUYhB50r4kNwZOl4V4HYoAN0V3Rsk6jcHC2PB3X0
	3rcqau8s3fhf8b7EDX1OzPqNYbXnckN0ofyK8LIm1fAJvrt6isKFJtJJWOnDvsvAnKjNbWG0yLo
	FWOulv5BWLuCW2cl4jXlhKki7S8pyNqIPKovOgTAV1eaKHXJgfv3Denj9qHtTORcVNh1deXmlKL
	BZ2WdirlKdec8o3REozFmSen8ffvFbuDVbaLDAmf+7Kyb
X-Google-Smtp-Source: AGHT+IGTTgl0chpEDBcPqxnjV1xu1d4TrJFOMhorAPBkFzK40tNq3YqxKVECFxeF1ltfBRiE4aQR5Q==
X-Received: by 2002:a05:620a:298d:b0:856:760b:156c with SMTP id af79cd13be357-85ae95bb406mr1024111885a.75.1758895411919;
        Fri, 26 Sep 2025 07:03:31 -0700 (PDT)
Received: from [192.168.1.174] ([71.192.65.134])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c337a1c97sm275638685a.55.2025.09.26.07.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 07:03:31 -0700 (PDT)
From: Nikolay Shustov <nikolay.shustov@gmail.com>
X-Google-Original-From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
Message-ID: <f3a051ef-328c-4778-9c78-33d52d273479@gmail.com>
Date: Fri, 26 Sep 2025 10:03:30 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Nikolay.Shustov@gmail.com
Subject: Re: git merge --no-ff failure
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
References: <5cbb5c0a-4c51-4d15-816d-6d7d4fdf4fe1@gmail.com>
 <1f78a660-3c1b-7aea-5b3e-945ec2b1ad80@gmx.de>
Content-Language: en-US
In-Reply-To: <1f78a660-3c1b-7aea-5b3e-945ec2b1ad80@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Johannes,
Yes I can reproduce it, stable.

I do not have any file changes to stash, so "git stash create" doesn't 
error out.
No merges or anything else in progress, it was just purely the steps I 
described in the initial report.

Now thinking about it, the only quirk I that I did not mention was:
Our p4 depot, unfortunately, has some files which names end with dot 
(.). E.g. "/somehing/blah."
Naturally, (a known thing) git p4 on Windows created "/somehing/blah" 
for it and then showed  "/something/blah." removed and "/somehing/blah" 
as untracked. I renamed "/somehing/blah" to "/somehing/blah." manually 
to calm down its double personality :-)
(BTW, I think git on Windows could be doing a better job about such files)

But the other git p4 repo I created from another p4 depot, where merge 
--no-ff works fine, does not have such files.
This is the only thing I could think about may be a bit... unusual.

I can try to experiment with that if you think this could be relevant.

Thanks,
- Nikolay

On 9/26/25 05:55, Johannes Schindelin wrote:
> Hi Nikolay,
>
> On Thu, 25 Sep 2025, Nikolay Shustov wrote:
>
>> Git is reporting error while I am trying to run "git merge --no-ff <my
>> branch>":
>>
>> fatal: stash failed.
> That is indeed a bit terse on Git's side. Can you still reproduce? If so,
> can you run the `git stash create` command on its own, maybe there is a
> more helpful error message there?
>
> Thanks,
> Johannes
