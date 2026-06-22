Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD234D3B0
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159963; cv=none; b=nfaOUYp2drhCW95kPFx2VIOxIYCUTEjKCZHml/wP/dw1frmVslonO1JnU0Jp9UwD5RUkF8bv038r+x3LdNAPpU0JQQqfbxqgJQG7eOoZizj9Ky/29oidSYQutdxmaxUZHC6CbP0zySJ+U+hl9LZg2Vkk0vJy0OInFhCcduUr6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159963; c=relaxed/simple;
	bh=UPh5PeZGm3mnz9lDOOyNGBRkoXGUPlZOUZ2IoARhbMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxD/B2OHqzCA6tP1FuA7vpxdI+OwVxyVftUBxd8t66juCKK+9TiH5/hrXBXu9KWNOA5ZS7Rfe6eulwZ3d+9BBBGfeVMnDYZozHxVx//YOAy/iLavaGYP1rQMX5dmhKaZ7giNbvT6IKQYvLMHh2C2BF8ZePRqfkYouesbplH3Tnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwF8znAT; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwF8znAT"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9157d3f2098so528415985a.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 13:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782159962; x=1782764762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujnZUEhuyjnSGluGaIR0TKg2je5UzMJZpijvV6JUe+Y=;
        b=EwF8znATeorX2X4TAqaF6ur6OFvbiGjZgPw7s/PvjCDZBj9oIQCvW5x1Y+tbOsOae4
         40v+kupMoZeQ2iHYVrgm8vkLlbV4EbWibkKTMcdNwn0dMMbvaqukwPcNysP+1qCqhI2X
         vWjN117RYuGsN7AeJIAk/cRscM/fwrAIhV8fwG3nnwd/grlr5SO08DSxcNDDUp9Eb2hs
         xnlAWLmTuxCHNxizSYKzDbmST2MIzqekwQvzkjrzOOF5HzcaaWoEojmggY4cJ3TeCEG7
         hyfCtrzzAbYSrgIKyiMtiLYtfm/oKkiLAwWpoCwswSOq7BrFCoEDutcTVkHkhuMVCOOD
         pCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159962; x=1782764762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujnZUEhuyjnSGluGaIR0TKg2je5UzMJZpijvV6JUe+Y=;
        b=CfFDf0driYF/1eZpnNVRI3ubA9yQaryR1faD1IgddE6BS4aZVqYkFMS8ZStiFwQNXh
         fF3bx23OXWZvMlW1snrV/eNqqrJ7n8/lOen5EMu4DBoSUSl8WD5s9g8/YfhTQnNBmk9d
         uVuYnnEvp6CsMvPzMqXCxKsAPCqdc1m626weSxfuyA4Vrxo8Pb59UJK3098MPRR5GOzI
         eutks98KqXGVfseJZAZFbqc7Pps+pQ2JhVzbcbMkY8exugQwuCuh1fClTQ7NYbArLQUw
         xjTWSaUSrd/um2qWG+xrV2tHZdVS5T2MzxwgHJKYB+iWiBKw3/kXNvLR9cQPpcZARVfr
         mXkA==
X-Forwarded-Encrypted: i=1; AFNElJ9y8xx1QtkqPsUOt20f0vLi1BdRq1oDRFee1r/rCzffkeQCudLBPaXvYshxz10E5sezRdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSaSa60KpuTzYTmsGKQWYa8GPOEF1j4PPNUHBF2/pJBFSOBKua
	5ydOo/uylNhJR0H2WXSMUOTYB63W100otTbf5w/T/8sOgzitNGRzQA1pzhgPN4UqjIA=
X-Gm-Gg: AfdE7ckNUlxqi0cSEPdAnL37oXkwW77g0ZnfuTeoifs7wYWUNdXxCNpfgqiyCN/5MGQ
	/dSGh1e//S/x6PvX2X/0SLc3HQcccCpXEQRoWuKLNqvg/Ir91FPH57e2BLELkebEKNA2gEbupI8
	7y7xLoRdl3I+ugQBVVbQqbjrT1C83R7vxd/Ouj3raMtir4MfqdFSX9PmMpz2e5UOuAOcGluuPF0
	meCl9jImIhiMdZcjL4ji8j5g3UIKNv+3VAYwYPKVZ7p0Yv0+51t7cShQgaEc5WRzHmdiW9mnwQW
	Z7fqc0OCVxTQNj+YkRxBPqVsT25FznKGKm0mZli+Nniftpnvw3HYwd9rkz0XUyyXIku+YU7RFwd
	j8YwZUWmAmqTi7lwhf0p5Easch9E9ErmkPyrYkHzAUXchalDc7PWUhhe9yadWAUFT3TWQi52fDM
	cJhp1XUsVhmV7KsZCfRF1oQGqUUuSw9sLJYAcC2aMTc4Nuq/dgnGK72Lbdcw==
X-Received: by 2002:a05:620a:1794:b0:920:6f7b:ac9b with SMTP id af79cd13be357-926483cbbedmr204985a.47.1782159961623;
        Mon, 22 Jun 2026 13:26:01 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600b82638sm68710085a.41.2026.06.22.13.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 13:26:00 -0700 (PDT)
Message-ID: <4f9cae3c-5cef-420b-954b-d1981d9d5a67@gmail.com>
Date: Mon, 22 Jun 2026 16:26:00 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 3/6] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <ed12a5cb5b76925cff08d2ab61efeda382b4477a.1781951820.git.gitgitgadget@gmail.com>
 <5c43f6ce-4dfe-47dd-b96a-80de57ecf108@gmail.com>
 <CAL71e4NJZ9c_=0W4djRFCYPw4z_dkh_ZHEDWBk8cuwXhxT9jgw@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4NJZ9c_=0W4djRFCYPw4z_dkh_ZHEDWBk8cuwXhxT9jgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/2026 3:19 PM, Kristofer Karlsson wrote:

> I think I may need to create some type of (temporary, internal)
> test runner that runs the same walk multiple times to reduce
> the noise from parsing commits.
I've used hyperfine [1] when doing specific performance tests
in the past. You can build Git before and after and have hyperfine
run the two modes and compare them:

	hyperfine --warmup=3 \
		-n 'old' "~/git-old/bin-wrappers/git -C $repo merge-base $A $B" \
		-n 'new' "~/git-new/bin-wrappers/git -C $repo merge-base $A $B"

[1] https://github.com/sharkdp/hyperfine

Good luck!
-Stolee

