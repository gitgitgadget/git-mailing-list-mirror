Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45C170826
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743228428; cv=none; b=G5wSMf8urGWiRmdi2p43DNa/ODTgC6oco26nBVH86UIZwPxpqUdjatSVBMqdxFPwNYyuxAE7Bd6q+/oKFEi0laxbU6KeXTcBvEXwZjaenG5MNER4885CEoQ/sM+WxufnGB56KPfH6xLSjbXl5zPBWaI2i/H+Gy3hl3NxtHbekPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743228428; c=relaxed/simple;
	bh=Cimt5IlIJMqEcG1InFJcS+0/1C4LmFLvB2yJ/rfQdpk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aBZEksTrqqXPB7y5KHLAvLEwv7x5yIH8NTmDSryyjHUHTl+++PdIacv07TtR3JlbAggqCZT4LrohkJhMX3YjjpqbjoDoYcQehVQSC+ONWZ60XvO5ke8wJvLNVr1lFJwcT8qZNnSpFOQFbzLDPQrkGg8sBPR5hd84uudAzwvL7Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWc8HD7r; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWc8HD7r"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22403cbb47fso63701935ad.0
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 23:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743228426; x=1743833226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=itjcDF69KQoNEIwmIH+Mkgn3RM1BfeT2Xy6sP9/bkSU=;
        b=HWc8HD7rIdmeRehhS1vzbzgvkcb0sV9rIPeqFeHZDjAjZgFjidgWWdI03QpfyBWCPI
         Th33TodGWEfYFHaMGzzsrvhw2sE3/iIeOdxdSzvMaG04Z/ERN+A7DM9z+W6zFoJlX7qn
         kCqY8jW2p5Y8GtQJKwPHv3U+KV24xY7cw+srEObeEHi2L53h8lLZ+Cfcy6lnCPZRw7O3
         QZRa2P/kB9LSebaVDmx2t/0+wYcqFpZrChbQTY+SsgN+6IrShMwzRqZd3K1xfE8pUvF5
         6shszAjZnKXc6svA3wwNtyTmFwCfq4AHbTRB6xqLPg/L8eUpW11yDWZIjD5iTEr/Tzjm
         e0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743228426; x=1743833226;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itjcDF69KQoNEIwmIH+Mkgn3RM1BfeT2Xy6sP9/bkSU=;
        b=V5l++MgRO2lBP3LSaYLiL+vZnvbgEg+OgEMxFl+SWD26wZ8aEszB3YdSp1PtZA5+qe
         MFN+uEwGwCSKyyt2ogbs0eCGZnVVF0zCPEmkrhBfwFVorATn+mwJmexmjSNuV9zal5mk
         GWOD9hPUURZxwC9GmRMtX7jKm0Rhgd6FwuxIh7v37VWRE32Bk53qhSEWVGSx43zFhsse
         kKAQ3cXOECXzanciaOS/PDIcBFsh1Ae/kLuKT2mqVCXeRET7JmCAIrzB9DP1qHJQwtoV
         uJkk3el0cCyE99kEMwxBd7r2LmYJ/UD9PzX5rIZDLzbYuWy9L6XW+Da+K/+jqy6XCqwm
         ckuQ==
X-Gm-Message-State: AOJu0YyDHQ1ArwtpaEqAmYFeyUpi8cidMfzvInBw4WqlBLMuG4h2oMW8
	uqmzm00vLk2LodVJued22p++81AfOUxH7sIJZGkc0BFdGPvTpGuL/3RFjg==
X-Gm-Gg: ASbGncsk5ZEMdJMxK9/kRKs4oCOoxM0540O6EgQUV7z27JQu1c+3QHgI3mEQdS/3XCl
	9uAAWVY3W7ufuwTfUQYeMcUbiu+ZwKqQ+yxNTN1wQKLgGvZ8YollwLAnSoPYVGJfnDzdHM2abUE
	9/q/EBgGbvIj81aODvY+vyq4UKw7DIFzeTjhbdpUFpRuPSsgmd3E+hPRQeLO2ax8Kedsgs8gid7
	4gtHv6JjFlRmuUZQaPazGAfyUskiN5LY+ahMYzZxCzCPHMlRuUv0ogvs9/NJFhNavqH60O/WDoY
	9DRv4J2NS0AS5p4pGWrwjfpHS0zOruzl9MpQLPemoZrM22NE9XA=
X-Google-Smtp-Source: AGHT+IF3O5+cAtga6pVC1fDvA5nzo+Dk9eJFy+2c+uUBabxAi1Hg9qeFph8a+qnqcFh+Us29GFCgkg==
X-Received: by 2002:a05:6a20:d498:b0:1f5:889c:3cdb with SMTP id adf61e73a8af0-2009f5bc26fmr3657196637.8.1743228426204;
        Fri, 28 Mar 2025 23:07:06 -0700 (PDT)
Received: from [10.61.238.175] ([103.21.124.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93ba10c88sm2587137a12.76.2025.03.28.23.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 23:07:05 -0700 (PDT)
Message-ID: <7c55145c-7a64-46b9-8501-3662bc5d1367@gmail.com>
Date: Sat, 29 Mar 2025 11:37:05 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v4] rm: fix sign comparison warnings
From: Arnav Bhate <bhatearnav@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
References: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
 <71098ea7-9136-4ab2-8e15-27017773e054@gmail.com>
 <0286b10c-2f38-43de-b727-bbebc2f05108@gmail.com>
 <ecaaa968-f337-466b-b719-22ebb3587167@gmail.com>
Content-Language: en-US
In-Reply-To: <ecaaa968-f337-466b-b719-22ebb3587167@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I did not notice that the patch I had sent previously had a mistake.
Now, I don't remember how it happened, but I have fixed it. Probably a
mistake in the arguments to git format-patch. This patch should have the
correct name for the variable.

-- 
Regards,
Arnav Bhate
(He/Him)

