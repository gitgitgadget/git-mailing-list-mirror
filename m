Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DD01B8E84
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815508; cv=none; b=C3Ixv86sY6zOHZuXnYUUx7nL5ccal3gMCZt4nDJj+qxXis1wINPAdtdvaXGvKpyXyOIPnTGll7Dn7sh7kAJ1PCYceLfS9x6V7p/gfBAyDAZ/0TfBq28SB63InQh54FQTxIGwV496Uvi3U9nl2vPokSPO0PNuGEZVlm34Ii5kve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815508; c=relaxed/simple;
	bh=LErZKChEKj4cDO/ULgifUt8J89Yv2+95nxRGuDqu14M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4JiWFZeky8yxLWjHFkNme4f515ancjeKUErqINTG2CqGpk7KcRB2cNibRp8ibgTGcZRaGTpnIuDIQpcxX2jB155CQHRmqfC6K0Bo87rrwG2vxgf7hewM0AsppASPPq1fU8j26n1SV9e9fpOG0Mp70z/OZRGoCb3NUTRK7ICyLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWhzM1Xs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWhzM1Xs"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42803bbf842so20321145e9.1
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 06:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723815504; x=1724420304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QIbdhCczpQAHea7eiRLPaie0HLpfhj4dR64OkEGZ+UE=;
        b=TWhzM1XsJmFJI+pWd9PrK2uqkserCdqn2GiUUEi/y+FQuDjxBUnn8omOIxkBpCcqG+
         ehUQZpHUkS+GkZxRnxG0oW0S4VvnRj/O1j7Ry2i2Ya1ZlWmn5wD25Jw+DcXZn1+KMCmB
         iB1UsEFTDS9hkiEp7gHa2jj3SsBdHXkIkV4thR98uXNxar9uvZ/xBBcSY7AApdiV3T+3
         yjO0+xwN/g8Atl1O14xg57wA/XLX4uUNX2n8TYfAYYVmrcmnSYJGGRlu0Wuw8k95zhXe
         zBm71EyGctA2HCPPjzfa2oiKOFv05mlvffEgLnc3K6L+lWbXJyXIkaoFrJxFLaCh9+/D
         nBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815504; x=1724420304;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIbdhCczpQAHea7eiRLPaie0HLpfhj4dR64OkEGZ+UE=;
        b=CKNv97gow1eiJsEZbxfHeTwHwECRwOZFavYxtl1DULmb4OjB/G2YOcu5Ijf/Niq1nY
         782QR/aCO9xbaNLGdueYHpnzzQ/zGmcKeajSR8caqhclLWVLiwvxOjfRMLw6Vsa4BlCo
         8Br8tIqP2o0OznxpnU/4UNnkWzU7Gtm6qHymhPJ74GNjLFP1DfOPwZjS8bkpFXUHzIbk
         dgCN3Sz5pd4UzWDwExIA2YF+8/CnN5NcgjD3mUNFlV0CCJ7JFEtuw8pLKn+Ipb9OglB2
         hDjoLx6qYHM3ppz3CX/VkBk1zUIWvL3kmFLDTn39OvSnm+G0M4/VjGhavEk2r6mE+RjH
         pqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpYegAngI833tXlQlEcmtyAOR1Q5CLSEPhu19ZlEmfxqiFalqfreSf+ee4LwBJym/Xn0xwCGYhoKE/RLJyK2a0EKqM
X-Gm-Message-State: AOJu0Yy+b8TOJyaUpkQ1D9ZDfc67uN03TtuNCXJiEcFFnjtt/1AU4d07
	RcV0HI0qS2YB7fgq0SkaP1FqUHqB8DZC/BFJLeg2y7hCciGDcL/Y
X-Google-Smtp-Source: AGHT+IFwWOSOqSbLBLqfJYXL6l+XqpBpF3WVfz8ZXnnEtV69MvvUuoxtublT1P6OZSY19u8svxojLw==
X-Received: by 2002:a05:600c:1f86:b0:426:5269:982c with SMTP id 5b1f17b1804b1-429ed7d64a2mr23403115e9.28.1723815503784;
        Fri, 16 Aug 2024 06:38:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849a80sm3685727f8f.35.2024.08.16.06.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 06:38:23 -0700 (PDT)
Message-ID: <1a38638e-561b-4e97-a462-f5ff034832e1@gmail.com>
Date: Fri, 16 Aug 2024 14:38:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 8/9] t/unit-tests: convert strvec tests to use clar
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>
References: <cover.1722415748.git.ps@pks.im> <cover.1723791831.git.ps@pks.im>
 <8f56b4d6264b8e5a85ba73bc8ac541efa066c8a6.1723791831.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <8f56b4d6264b8e5a85ba73bc8ac541efa066c8a6.1723791831.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 16/08/2024 08:04, Patrick Steinhardt wrote:
> diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
> index 32a81299e9..82b7635e6a 100644
> --- a/t/unit-tests/unit-test.c
> +++ b/t/unit-tests/unit-test.c
> @@ -6,10 +6,9 @@ int cmd_main(int argc, const char **argv)
>   	int ret;
>   
>   	/* Append the "-t" flag such that the tests generate TAP output. */
> -	ALLOC_ARRAY(argv_copy, argc + 2);
> +	ALLOC_ARRAY(argv_copy, argc + 1);
>   	COPY_ARRAY(argv_copy, argv, argc);
>   	argv_copy[argc++] = "-t";
> -	argv_copy[argc] = NULL;

I'm confused by this - it looks like it belongs in the previous patch 
but why are we deleting the line that adds the terminating NULL to argv 
in the first place?

Thanks

Phillip
