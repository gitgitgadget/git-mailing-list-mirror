Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88222C027C
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945455; cv=none; b=uAXhpCGmTQGT3S5QHr769i4nbqKTSup0H2YksCd9vtoX1jxjLtyriOV7qcW3IoARABpmdj4VpU1kKD8EaDJX3bPyQM4DUI/ZUVeKrLzMaUrstMNwbBH2z9Ad/Q/Op1TXulfh5ujrhkj7V/zRw/Hp8q9JQ5L3wAxwfUjuyCoiCLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945455; c=relaxed/simple;
	bh=xI45n1JlTFeNTa96iNgG4Ov6q5BL7AYTQocCzLFQ6Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZG3JmQEJ5X5XJ4/YcdKAlsAZCrCOd5OAyGWAeIv7ozbdZ6il86AwPERYX7L75ofdfpHHUCRp86JWJsGt9wHVwLH5T3nb/TDFgGB6mVC8QNQEQRm//BvH4e/QId85pviDB8uX/8pgDxvUPQnrJtHmKOABqPRxzi/SJ20K7WVGZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDUPCukB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDUPCukB"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3eb0a50a60aso758338f8f.3
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757945452; x=1758550252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TrbXeDPHs4QdJxvAFmcQubXo8TQA8UAxZf4g3roZWVQ=;
        b=DDUPCukBPlPDzD4J2nC/Eo5OXFYwRPCuEtJnpWGUv2oNhkN+A6G43Abe7mB35ia0Xt
         z8y97orrioTIKYP4v4B6GuKPJR1CfIQQDdE8RctD0v0iOdn6idXUwzQNMHyBvfimKflB
         jTWfEc3RuAtvAkCMJvk4w5MIffU3aslsG8jeeFUvUeXt3U4bpXXpUoHK6pKAgKAkZUX/
         nxduY/+/eLfoz4k5DSiHdih4j9NBmnHHxuUli5kVq9HEaJ1ycPd3HlLIUtdjG31gU77b
         JFmxSl/fLC7HrpgieONcdVPIBB0FNG3ty5M94WXGjBatGcGXgcKS3T8OvfjzLOs/myeA
         iOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757945452; x=1758550252;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrbXeDPHs4QdJxvAFmcQubXo8TQA8UAxZf4g3roZWVQ=;
        b=hX+yWOTxdMcnl3joY/zt1JbxxU6A427GAeGirBKWx5ljiUeDXEGB/MF4A3TFnzEHfP
         2eE5oFXFb807eSgedJL3yJDobe68Qy1UVEgG8/J+jvPZeYcfyWy1W6FqkP+fFs82N1N3
         w59qTLVA5lso11dw4UbU7fWvVMeWz3IX7mec135RD705mpBhGgfH1A90ck9F/XJnnNC0
         zCi5GoStK6dKp4cV9iYxcDYSGaAG3dZ85dj3cHtAx7ZZVtn7fSb8ScW8g9wrYRJJmPEL
         ei8D5Z1Ta02e/8ATc3I5iWRE99SXzU3Syp2vIeDrfBlpkzwe7AwjNorAEhPWrqd+FysV
         Q9uQ==
X-Gm-Message-State: AOJu0YzxPR8PCzJVK4qo3Hhk3qGaorqc7Y+BmLqk9/bKQIhNm72YpOyC
	G0R0xBTEaMl04sXXdK7WvnuIh6Y9FPdam3ucawU7MLP+sMvUigYEj6gz
X-Gm-Gg: ASbGncsaxOM2EHQts07zwCHdDMccEiTId7uTrozJshVLudxrXi+5S/UjepgBvetXsgb
	0kddK8/CsZ/pMVmx3ffSlwJWzTYNOvFZEmLRgkPJ/ei6Qa8BmGw5ZAuCgGuRLMC13pzg4BSoH7V
	QoePwo0hpquZJNHMUsG86kJSFokybl3lkZmdsEWmdIZekvPjlaUt9zukptZX1EwFPEYvkkgxF0U
	KGVJbsKFAM/Yi1T/Q12r1Wyda3drPeReHLSqRlJeGP93c442Yti9hfVDQrrRfmpJKYu/k6irphL
	8yXttiqafjj+XsgkMMsqEtghme4W2CZHE9nUrBSgor7fTxg4iLS+uwn1bcocrQPbtSsiHczSQdV
	5SLfq5XQS2dmZL0hy9reFnwAf0XoN9mAWbmZ3FiTScdINLN4tslG97hhAv53LidL7l5xJQ8NNoK
	FATLmxFfJJCg==
X-Google-Smtp-Source: AGHT+IHx/YK4Asa0mNdoj7umTAXdBTIrQA2FZ6UryGnvK65Jd5wCakIUUxlb4CNxsbLFTuXqOq4NPg==
X-Received: by 2002:a05:6000:18a6:b0:3e7:486b:45cb with SMTP id ffacd0b85a97d-3e765594133mr10434530f8f.3.1757945451791;
        Mon, 15 Sep 2025 07:10:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760775880sm18106524f8f.2.2025.09.15.07.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 07:10:51 -0700 (PDT)
Message-ID: <66e9aa8d-762e-4f51-b049-347b76578bf9@gmail.com>
Date: Mon, 15 Sep 2025 15:10:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v3 02/18] sequencer: add option to rewind HEAD after
 picking commits
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <20250904-b4-pks-history-builtin-v3-2-509053514755@pks.im>
 <f74b9dfe-b05c-431e-8872-92e2bbb75b8c@gmail.com> <aMfdQFYdL1xoHADp@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <aMfdQFYdL1xoHADp@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 10:32, Patrick Steinhardt wrote:
> On Wed, Sep 10, 2025 at 03:04:00PM +0100, Phillip Wood wrote:
>> Hi Patrick
>>
>> On 04/09/2025 15:27, Patrick Steinhardt wrote:
> 
> You probably refer to the condition in `sequencer_pick_revisions()`
> here? Everything else is basically new code.

I was thinking of the code that restores HEAD at the end of 
pick_commits() as rebase does something similar already (it looks like 
you're using the same reflog message). Though thinking about it again 
I'm not sure if "git history" detaches HEAD at the start like rebase 
does. Rewriting the history with a detached HEAD is probably a good idea 
as it will stop the branch reflog being polluted. One nice aspect of 
rebase detaching HEAD is that at the end you can check the result by running

     git range-diff $branch@{1}...HEAD

Thanks

Phillip

