Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16720298272
	for <git@vger.kernel.org>; Mon, 12 May 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747074812; cv=none; b=X4BHDFz6stxq3q85+QuGvGlKxTt6xgUHfOY/qRr4GD3ULFyyZ7VYVh3zLngZkLWxQdzozq8Wnd+deDZpCfBNR06PglZydA+Ec0rxYoKlckSDLgfGOdbOvLjuFe0Dqb9JGIomN2B4j8+kQaCzXPE/h4Ri2fylUHAlSlwOka68Rog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747074812; c=relaxed/simple;
	bh=j1vRwwT9ZOuM+lRPZ2FX+83EVPgMTnuhKpTQL9/nvk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxaSmY5qQ2+xad3nGXQZ2+xAJQqmvEzV7/jdaZ1tTN1m4HfLpOJSn3TkqZS9cLZVLwDXm4YA2YOtNKdJqhyR2fNkcOlx3bGVhZZ1osCpJWoK6Goo5s86jrszx+liZg+KAqFkAouBHmcYM+npzP6qik61hWDvBvUypSJ9msknEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ip6HJ0Lc; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip6HJ0Lc"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7adcaea616so650229276.0
        for <git@vger.kernel.org>; Mon, 12 May 2025 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747074809; x=1747679609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZ4ZhGrjmRCAOCBw7hg7u+TSM2GWlFsX+XQeTf0fXNw=;
        b=ip6HJ0LcBPpw1YT/X3e1edNFckHCFiGQ8y9dwZNLO085nE04M6puwqIz9lm5EbtCXx
         Oo1CyvMSDd9DV/yH39D+4i2HzdLeDJJm1/KRhq6QqdnbntPENr4unIysGa6uVMhIHZSd
         QhOkcs0BHdR8caq3HCgOnKAJJIslXBFgSe8LxodMCpUCpl7i5FSMj98ybENyg0JBZFAw
         wojzCR5j3aVsn05Go6aKHOd2gTyjn990ktOR/Adipf8WZVqEwoUd5fFHMyoL+8aIwQOc
         HdTRM+Tt+F2xaNTx0Mv/Z4UO1eHU4ZWz1e0N70P7+WME+GkfNmQhclsrCzD+b5VAQs2y
         7CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747074809; x=1747679609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZ4ZhGrjmRCAOCBw7hg7u+TSM2GWlFsX+XQeTf0fXNw=;
        b=q2ASgV3a4NfZ8EeHWoqYx59zJ4uVnBWB4Ewtw1dEH0vtvVbZCiY0eiQeSsMgJL0K6V
         2AuJaYzfRmUEyHJexPs3EaDlCt5arwjDc3U1niI030wFBJZqwxa3lNX2VAVGtUoNkqfT
         ayUN/KZJZNPIaNh3jWu2zc1oWdwQZflASRsEfC3TgzIS0OGDLK4Ljid/n6LEwNpIWcrk
         N3ujfWXEj54m45SKYzQuUAiwOJVhGqZsNe8yGDOBmO0pjgaiw8FPYNhSyeYMalMs8VkW
         cjnYglDmN8hnN02F4BI+7ZSt9gq/6cFyptk80aHvPrrKVStDSKNmvxvVLmUVfmOfbAkT
         p7Jg==
X-Gm-Message-State: AOJu0Yxa1wiLORywnaWxLd/nrNoYQY5NdwAwgqpqmN1Y/yMKMO7Nk+GT
	by59tBocBUwzy58eiNhsikkI69ZQv50ptbvWbKuiTTGeQkAa+csya4NpRg==
X-Gm-Gg: ASbGncuzni16/ZxoSRp4Mvvyg/qWmVVhkq2O31GHJqX0s5zJC3mEE/ccVXZ8Bs4LdKm
	Eqn3dkdFqbMlVoCP0CPDHRxqjcetB1ZrYcqEel1Yq8qo9syKqSJLtzn57P8fTA8KUApKm3dMyHN
	iA+wKGLgvpRs+JSg5TEv1zSFOcxIC74HFoVSzIZQj0424/xOICT5ZinHvU13OFPpDiAYWtR7IOz
	mvIVa7keA942qVDYxZ/iL/ZYPmHN7XCfnwOEbYHFIbH5CWkXr5oCCFNIz03Y0dsyFCjZs74KDvH
	Oz3C3wrGMrl3nG2C/F+kSaneOQqlsOuyzL7FWv+4xdmepTICKXTyzjOsOpybEMcH6ixm8T6Pv2L
	I6wBAOcrZ5Y9dzn17cAUs/kSQSuI1J1EnRG75GUo=
X-Google-Smtp-Source: AGHT+IF7Iq15RHhghDiKNZtAkTlD9CRCgk2vQcpcvkeF+JQbXLPbXOGnA3eBV7Mov/6fUb/6UG/sYg==
X-Received: by 2002:a05:6902:1009:b0:e75:bea4:5eab with SMTP id 3f1490d57ef6-e78fdd612a4mr17702732276.43.1747074809486;
        Mon, 12 May 2025 11:33:29 -0700 (PDT)
Received: from [192.168.1.237] (70-237-88-18.lightspeed.rlghnc.sbcglobal.net. [70.237.88.18])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd651b3asm2216242276.40.2025.05.12.11.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 11:33:29 -0700 (PDT)
Message-ID: <21bccc17-7e8a-47cc-a48f-de16bf075e54@gmail.com>
Date: Mon, 12 May 2025 14:33:28 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] object-store: carve out the object database
 subsystem
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
 <xmqq8qn5zci8.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq8qn5zci8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/2025 5:43 PM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> Changes in v2:
>>   - Fix for a copy-and-pasted commit message.
>>   - Rename `struct odb_backend` to `struct odb_alternate`. I'm happy to
>>     revert to the previous name if we ultimately think it's the better
>>     suited one.
> 
> Diff between the previous iteration is quite noisy due to this; I do
> not have strong opinion for or against either name myself.

I agree the range-diff is noisy, so I had to reread the patches.

Thankfully, the patch organization was already pretty good, so
it was quick to validate that my earlier concerns were handled. 
>>   - A couple of fixes to move changes into the correct commit. `git
>>     rebase -x 'meson compile -C build'` is now clean.
> 
> Good to see that we care about bisectability.
> 
>>   - I _didn't_ back out the rename to "odb.{c,h}". Junio has already
>>     fixed the fallout, so it's probably more work for him to kick it out
>>     again than to just leave it in.
> 
> You do not have to make me an excuse, if popular demand is not to
> rename; I can cope with either one fine.
I'm happy that you considered my advice as necessary.

Since the rename doesn't appear to have huge implications for
ongoing series, I won't voice any further objections to this
rename.

v2 LGTM.

Thanks,
-Stolee

