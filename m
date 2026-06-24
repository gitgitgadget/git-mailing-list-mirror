Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B4234676F
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309336; cv=none; b=uOy0BRbyurkJa+WmtQPjjSRxIwhRX9PCWsCzZF1Ad5MUhlkvwo0HB/6U040Dz/DX1lq9L8BFh9LfEs9R85ay/kObUEo480VwSHIbpc8v36S4NVVUH2SeKtaae3iGaa6bE61t4Zp6p6TxqcChuVb6m48V2Wg0X546pPFzblPzEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309336; c=relaxed/simple;
	bh=Ru3TRTITWTEYgFxEwgpQcdgei2vIsPfElCCGb/qVNFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vauq/EiEAn6mnXMg/5qtTeOiimq8rqZZ1HC/GaROwjT6iWlhsmJ7h0IPuExarDq6sKJkU+tvnOfz32kIJdSMhXxXyBXl7UQIDHX1LiRA7oFyhPSueBUOQGICXCmTxHHU/jDQ+B2HjrcNjiOxJv2NaACNwqVXZkkg2cXEs+cVCT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAFXexbh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAFXexbh"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa624ff3cbso1036802e87.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309333; x=1782914133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=beoOszewCIbaprT3za/RLh5gWg63oIPaRzk2Mruo34s=;
        b=cAFXexbhm4B79CK5OYmfuyI4ef+XJR6j7qOXDRX8PgqgLPle4Pg6pNUrA2GA2r8PdB
         zXGtSiBnFZMVHfPxDzjjxUu+AP3z4wzZAe0ZbbQYoLuZqUg/j1rvVj23vbx7C12lgrUE
         E+PKYJiuLpQEJ690PjVD1WjY3LvPaiI8tfGcm8K1qWehLqSyIypSPBeva/Mp588tb/Bm
         kGw7V9D5IpeTf59xluNV2dK5Qd/vLmLruDgzwvzR0qO2LIWPTgoIXDH/SOxbAS1+bsia
         cpTc6zukFqMwL8iukt6LIrBjyJeoLFo0w6I1wYJ9V7DVpZVxs0MsQCSoiFj9U84UfChp
         iQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309333; x=1782914133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beoOszewCIbaprT3za/RLh5gWg63oIPaRzk2Mruo34s=;
        b=Wx5DP7qVheQUX1Gm4Eo+zKDY1V+dfoO3URwMTRYKCUugzsoaeTYcedt0DVrhCxMimL
         w3pwRcjGJszfLEQWPKkMUEPDzaF/tfUt2YfYEp7dbgfQc/HA54NAxGcdmg+bwS8UDY27
         on2xODmYR/9ordpbS3lMZmikWkD9LysqmjZ6q7GRPgXGsdwVUIe8BWOkp8TODoYkWgfl
         XhfuW6PZAHRyjcqhBzJw5Xp7b3FrGt0+aDpv1b/DvWz+lLaT/nQfPO070slGq2GVH21b
         EWF8SxzUpOnf+1G7I3eFZHo/j3VfQ2QnDarFFGIriW7ld+RzfLPn57tE4BNdj+F/16vs
         pYdg==
X-Forwarded-Encrypted: i=1; AHgh+RquIn+bSoI/D9JtlK05xdrprJKJviq+fjMIXQ0ZU+x/PK2oZEsB+zgPXU59VtvYYCXf8X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0X1aHRpqitWIqmB8ve4AGBiGbmT0kEs8lV/VBUKVPIjGQQEmE
	M5y2qJAt4/KwU1T3ydgZO6AEMLAy9BGRuCFJ85z2q+xm8kHzV5EIC41TGiMZrQUh
X-Gm-Gg: AfdE7ckEpqxJ8sSJSKmrKmuqO8IQHX7PF4oKgivz8/0Z+kImEeSOK9E+petxnfoH4sQ
	sHyNCsoKTPFkmREbCfWyz/UEadCZtaofbCk2d4uQgdS3txTAWo81XSjeAMdfR0t1+rT+JEhSrAv
	SpwMJTkzhbqkSMqO98gV8dix8u8Px5Pl0UmcdkZVayXOQVH/vENj8SLKdf5bP9v+te7srtdO8fw
	kyuYgY4alAmIW7opB8XcqjAcB3s0VgWxi65Su0bgRoQNQScjsQ3RIOlloi85QEq5oplcDHkNKLu
	B9XXpu6BEz9Q//Ro7bVz1sve3lVK3exMiX7DH3Z3vsVR4wk20ShL12jF2IYhSsM1D4RQzykqo8n
	0k78ChpuDza78J6ba2dYscGNYtjA7vfAYPrq566IIrdnHXUY4fYn9W6fvhWBeH3zG8mfG+41ZUw
	mWytELVSPeXowhxVhlOMNRM1JYljsszG4pN18CGR7UxJ0ON7vV3l6stn52tg==
X-Received: by 2002:a05:6512:2456:b0:5ae:9c5e:abef with SMTP id 2adb3069b0e04-5ae9c5eaf2amr1105457e87.32.1782309332372;
        Wed, 24 Jun 2026 06:55:32 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999af9f376sm36495021fa.9.2026.06.24.06.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 06:55:31 -0700 (PDT)
Message-ID: <a029b1ff-07ac-4199-96b7-e85a76d957e3@gmail.com>
Date: Wed, 24 Jun 2026 09:55:29 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] commit-reach: remove unused nonstale_queue dedup
 wrappers
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <8c72f01083237c00397dd074beda8f854e882cbe.1782303254.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <8c72f01083237c00397dd074beda8f854e882cbe.1782303254.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/2026 8:14 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> nonstale_queue_put_dedup() and nonstale_queue_get_dedup() became
> unused after the previous commit. The core nonstale_queue functions
> remain in use by ahead_behind().
This is a nice cleanup that makes the previous diff easier to
read. Thanks!
