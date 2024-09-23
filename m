Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC09010E9
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727055366; cv=none; b=tb+WB3ggBjKFBSHF4tfkHQKY8YzIYZAsMKV2Z0g9r+3KjXM/pTf0EHIdLPJaxCYMy4z2dv7ZiffZZUV+XINeUyNQVXuzWC4sO+pCMOJo66z+C6w430vmzIaIeV3yl7NxK406Pxo6ZfYEtsbOyDnjmBKpMrrDXYjVivzXzs0lMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727055366; c=relaxed/simple;
	bh=P99YIJwNxc8E9OJ0U8OG3u9Ruw1n6YewbcY1sHkvoqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcjWAEq6eI0yActMKu3gib9lvtjjoaaiKEvF7ilwgb10dUXsHc7hAo08Gw6yefJGindsYOft3oGoHuimoVEkKHDoqUujKrO0r8a796VuGtn0a5bN45Q6ghaPuB9nOfc+h1FgQCMFLFWifm0S36wvIghAHGYGM5tJpgIADH0fDxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGR+vauy; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGR+vauy"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso3087968a12.1
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 18:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727055364; x=1727660164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfpTKY6MbjoUlHjQ1u6266S8JAsTD6w+NvyzPRih3Q8=;
        b=cGR+vauyD9p0hw/nMUHrFlI/Zrnd/pGVUTBHWrYekSrScIQLVp37CzdBFFIrgkg21E
         uDQW83nAE/HR0Vq981h3gp+VFUORm/TQ3F23dVKXokAb/YEgFgsRzWEq03dQ7Nag+G97
         x0GQUTPwHf+GJbXwsS4dvsocc8c02pD09t+icRJqUE9/upevQMJb9g/ixha/WCou8WTD
         B6nKZz3QTGVXJ+pqSjN9clthby7RdVWtBQspjBJuSMO39NReVxN1Ydznn2/LZyDTEzYV
         aEyYkhr38MPRT+PWInGN0HJKwJYVeCh26PChwYsVIvKLotMfYA0LCACOJ6ErNxYG2bZO
         ag7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727055364; x=1727660164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfpTKY6MbjoUlHjQ1u6266S8JAsTD6w+NvyzPRih3Q8=;
        b=nCToaAhayu/rhZU7wi0u78zd114ZrGF2Pr8XeFgWf0wRHdxXrFD47/bbcykZ/y+smu
         jgP1tD/Ekm3m1AOV5fHjZECvUDgyQK4Jz3J90/xsX2hvM/4MOpjXjSpT6LjsSibGJBAR
         FvFopuhuJ4C6j90G5cx+gUnoguAePfjLPpiv1e9rzuSsNnbJQqc17VyOFeiBWvQ2sqFM
         e0TJPF2H8fWUxFJTFnrEjLggyyina/mYqYCOZhvznJHsL3yFGcmXLIR/0xISUs8XTnPd
         RQPaeKHPWiYGdTuVtNhlSk5RsoLXwpjKIvye7+1F1X7pNn78IIAch5xmeXJJL2+ZQ2zl
         P7Qg==
X-Gm-Message-State: AOJu0YwLOFF4gHHYWHhNaj1xJLymeQVtQv4+RA1mvixZ5F5KTY5vnOXs
	1KatLztxZxTG7FzHYf64ThddhYUDf49wfc41t380nSQ0sXeFFOP7
X-Google-Smtp-Source: AGHT+IEVGUP5n+MMMIph4UrLpFxqRJM4obmlQJXqofY/NgPmFJWFZlV+NfeU1N2XpBvUi+qWG60eXw==
X-Received: by 2002:a05:6a21:460c:b0:1d2:e807:b65b with SMTP id adf61e73a8af0-1d30cb1cb9cmr14623813637.37.1727055363982;
        Sun, 22 Sep 2024 18:36:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:1803:188e:65b0:6321? ([2600:1700:60ba:9810:1803:188e:65b0:6321])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc7bb5sm12938113b3a.207.2024.09.22.18.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 18:36:03 -0700 (PDT)
Message-ID: <5114e7fa-7858-458a-bc5d-5c82ea663a48@gmail.com>
Date: Sun, 22 Sep 2024 21:36:02 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] maintenance: configure credentials to be silent
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, liuzhongbo.gg@gmail.com, Johannes.Schindelin@gmx.de
References: <pull.1798.git.1726790423.gitgitgadget@gmail.com>
 <xmqqfrpudm51.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqfrpudm51.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/24 5:56 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Add a new configuration value, 'credential.interactive', to specify to the
>> credential helper that it should not prompt for user interaction. This
>> option has been respected by Git Credential Manager since 2020 [1], so this
>> is now presenting it as an official Git config value.
> 
> So, the other helpers are also supposed to check for the variable
> and fail when it has to go interactive now.

I would hold off from saying "supposed to" but Git is definitely hinting
towards that behavior.

Perhaps I'm just hung up on the idea that we are not adding a new wrinkle
to the "contract" but recommending a good thing that was previously not part
of the interaction.

Thanks,
-Stolee

