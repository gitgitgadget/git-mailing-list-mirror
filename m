Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B98E55A
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102256; cv=none; b=UTXGINwRmSJZJoTFhtOaNBUMSe2ntLuG4ceO9y3X+NNun+EbqqjumfXnzYsMuXq5uBZ7fdFV/xsqTzvFEen0pbRh5mtQm9CRhYhEacKh22codJn+3swUAaUzVKTkia65YkbglQj7oPZo2mvgY9hSiQvYe8M8uuRTDkVtIL2Qhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102256; c=relaxed/simple;
	bh=CXJfOdT7cq8/5XV1V6xBbz2M+XWJus/tFZRMqIymm9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pr1Na3aMOFPsp6o+Gmiqzk6Uq+h9s/GhfvUaduQp4611Uqo41Vts4ew5skH1HBxlqkv9X/TJIHc46T37+89PH5diFayVwxQjI9z32GQuyUjPinvEooR1wUJ52RjSOmx/hwdvsYv+1zO+UeIIZZbCfAFuZy6afh3Q7Ky43PZ6Lzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AecuJd0W; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AecuJd0W"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-80e33b9e2d3so241985585a.2
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757102253; x=1757707053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TjTb/6ACzacFpsJaccvtZ8C0fYUOlsd1jMdHoOSeIE=;
        b=AecuJd0W8aRvu/PdU8AYMOYffe+SAK5nIWLkSyMOkvO6TIl+VW2lSt5Q3gDdB1Sw6f
         asHGYG4S+Zra0Tyi4+Y/5wexTJpTjDbpP1/JWT0uNmupCUnOAKJNqQ61TO12fFr1norw
         7uK/nH4CCM50/h7Zp/u49OJSDsUxSMWePO4JyeP4waghuMGpwqiDBi3hSzwmBa6yMO+r
         TLZ2GiTAVwQ7WjFKaiIWb1mFPBxRjfdLM0rTINprXRKMa8rQ8dgkcg95ivJ2xEwQ8+OR
         JpkFWE5KYL5x5IaMQ33LV01mQdrSdKE+KpAvzr3VVAHdV+cOB0+elNYYqVz4Kh8suT4Q
         nsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102253; x=1757707053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TjTb/6ACzacFpsJaccvtZ8C0fYUOlsd1jMdHoOSeIE=;
        b=ks+IKdqFmuGQPSH/qGO0rIdzWrsxdzTeq/qjsa9yp0A7JhuhIwUrsiNc9wTklBK0aM
         ZFQ8eQilU1z+QZvSFRVPeJUH3nUXZ2mVlwDgmrd8ZOC6TBGit377mriPNwk1Fzg3ultX
         TE0Onqj/d9NbTOyazktoLtBgh0u3DDZrLB+D+93sR+CY0ZJW7UK8FR4jEMhzNvNlLDN/
         CU89xoGOcsaqu490gnCp2a8NaUZHkZtg7Kt7H8Tu5CYMKzCTglOvyVI0OtaeBLNU2Oap
         BrSDigSY5wtU8RXvRAk9rdCz+JUP6v3RfJ0JTb7COFhELH7ajNUXDoQ79jJjq5FZauZo
         8ecQ==
X-Gm-Message-State: AOJu0YxZ7Az4UcLIjjerAn30jm5iLpNaDs4YN9l/q2jGu7HeQFeZLaHJ
	Sym2YiHUJa+mnIV4XON8BWM2wWvHF2h8dkfrbIywWIgqs3AfUweiU/yn
X-Gm-Gg: ASbGncuWfdfd95X5AV5cnoA1wWc7Vq5k0kUtu0MV5KZ+LOuBgPZ/x4bafYfoIKtmp1s
	4xT88lgbKRFIp9SEF4oRBHL9kSqUdXZurqyfDvvdO4g2/zhMeG+rWrAxrz41LYaVXCMNPDVPFgS
	LIp660UNMp/pjomrgI/nX4DrinEkFGyygVkoCqiKgfHd9ywwcCycq9JHWgGCJRejxwjGaPEkp4w
	57ht29xWa6+mQ1AH5OTD5SE7FCIREf6K3J1L3NG86mIBwSpfyntwYhgj1dNJRXnx2e02dob+odN
	fjuNFD2Fpuun+cXlUIVGwdTGYAPG37CmZ8OTHyH06XIQZG84mcHXDWKrd/d+5SLI8AMhKYqKWK9
	+w44E9VarQUe/vUkHZ8lwpnXmleHf3SmQfae+wh1LjCAmaA==
X-Google-Smtp-Source: AGHT+IEWr4xlrH/Hn4hWr/UhHbH+9/9VGTG/L6kbB5nxJiLvrl+2PnaEDZwQMizNn+kdVY/sNrU5ag==
X-Received: by 2002:a05:620a:a10d:b0:806:cfb:843a with SMTP id af79cd13be357-8060cfb8488mr2135040585a.49.1757102253442;
        Fri, 05 Sep 2025 12:57:33 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aa60dbe70sm543574985a.4.2025.09.05.12.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:57:33 -0700 (PDT)
Message-ID: <cc0c30f4-5e03-423e-a6d5-f8effb953f68@gmail.com>
Date: Fri, 5 Sep 2025 15:57:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] midx-write: fix segfault and do several cleanups
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, Patrick Steinhardt <ps@pks.im>
References: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
 <pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
 <xmqqcy843d27.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqcy843d27.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/2025 3:38 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> I was motivated to start looking closely at midx-write.c due to multiple
>> users reporting Git crashes in their background maintenance, specifically
>> during git multi-pack-index repack calls. I was eventually able to reproduce
>> it in git multi-pack-index expire as well.
>>
>> Patch 1 is the only change we need to fix this bug. It includes a test case
>> that will fail under --stress with SANITIZE=address. It requires creating
>> many packfiles (50 was not enough, but 100 is enough). As far as I can tell,
>> this bug has existed since Git 2.47.0 in October 2024, but I started hearing
>> reports of this from users in July 2025 (and took a while to get a
>> dump/repro).
>>
>> The remaining patches are cleanups based on my careful rereading of
>> midx-write.c. There are some issues about error handling that needed some
>> cleanup as well as a removal of the DISABLE_SIGN_COMPARE_WARNINGS macro.
>>
>>
>> Updates in V3
>> =============
>>
>>  * Use test_grep over grep.
>>  * Translate an error message.
>>  * Clarify a commit message.
> 
> All incremental changes made sense to me.  Will replace.
> 
> Shall we mark the topic ready for 'next' by now?

I believe it's ready. Thanks.
-Stolee
