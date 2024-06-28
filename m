Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AD01400A
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 02:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540732; cv=none; b=VEnMR3zVVj/+10etCQNKCGSLt4MDve9l3J7KEQySiFK10FYPRz5HHvZEix+tlPZrEe0brgLDRYFq3ZMuXFHg4db/WUpQEqXLDQXGMvZBjuL1MsJ1p7LqRKpyek6aUYmBVdi7T+UDv4RKBYOm0gVHYkRS6YoNfy0+RxKuj7NtpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540732; c=relaxed/simple;
	bh=qy4Yv/lXaxWzA0S/BYFxCEv/utXp42C81V9WQalq+Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqEzdgqemWbIQHNzYly+oNSIdCY1MxYb/GwPq8cHSP8wFcp7GjlKA3r8EBe520UEafrXWn/TC6MleKKcNfNOvyHtNjGg2Dcz1suJpErzVLsNUbt++9+UYDAdwUvHbKTPeRed9Cf7iuAvpG+c61FwDtGhNvGNsybmdTd5/5dWBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJfk9xzT; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJfk9xzT"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-643efaf0786so987357b3.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 19:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719540730; x=1720145530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PcYUZ4Pp97XRZlzCuD8ksYc2AFy69ONXWoihDH4FuU=;
        b=mJfk9xzTBgg+VeGwYtfPUc+KmsReJSpVhLVfdkIlT5taaAJt5piPUKeFILuXHLKgPN
         w9QwXB6dHJ6KYa1fcGVnh0KTDL287LL+35jFAJEwGPU9ebTuBDbfwpAaR2Oof9dlJsLG
         JCIcqNllthO3seK7FNfOQWule8Pbr0CILejN+CfLzVweh8w0GHItbJ9xawiyUcE2lzoV
         9WoNB8MPMHMYzoX78nbt1GZpm6zMTWuKyZ4kTqG10+9T4pZ2JuBgdTqOwvHUjsLX/Rwc
         TAOUOz6e/2uTTEGpKefB9PzW04ppJ3ghNPwVTP3MIr3OK4sg17sW90sla/2P+0wzucc2
         CEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719540730; x=1720145530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PcYUZ4Pp97XRZlzCuD8ksYc2AFy69ONXWoihDH4FuU=;
        b=YAOUrTXYnWsc/Jaa+ri6qVbiBAq40LzFLGlcb+EZTH/y9xp7ymBEqlmRpAr2mgY+Mg
         FHUoXCWT/q+vihnejVeF/P4Yj1P4XBrffwL4uQeggUwZ9MGfjBsTf66GBuXkr69Ntu0e
         okawGBJdD03KQ0T68KWCsF3ewVeLXnRvLnHZ8Txek0M319xL6GVDm/ttsUHkDduVmYCk
         sgsxkn82p62sk9IXX9D+FbCuxmwUwa+bVuVT0UWGFNcZXtoJ7PEPUEihDy35c+LdCSJl
         BGWuBeiourdj7NY7gRobjk7Txfbt244eDV0tliSSxHcIm3NaOwpYDX1zJ6LoCvIUeWLQ
         Kz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxowQ2V4fRiJslMSy9aN3CZUpyqPidp6Zx4yKVz6JxkCa8KD1Snv+eHqWAUgJoIRtuO1LfLjNmulyO7n3ynaNVDc+j
X-Gm-Message-State: AOJu0YxsIxuwTawEG8t2aRbdVoZvXO65xS0oS77Q0Yp8hd9VZvEaRTA0
	B+0tRwB2ZNLpvRCnVmji1/ee7WY685+GW2OW/gEdI/qKAgIDHUmn
X-Google-Smtp-Source: AGHT+IFObpIE/j8qHWB0SkPEsyr45DAtFl5JtV0v+ZAuBCVK2bdXHiqADZh6c6+hQe/myr3wDd7njA==
X-Received: by 2002:a0d:e890:0:b0:63b:f5ac:8cc5 with SMTP id 00721157ae682-6433f0e1f98mr154326337b3.18.1719540729739;
        Thu, 27 Jun 2024 19:12:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:5cca:8078:1e70:3d3c? ([2600:1700:60ba:9810:5cca:8078:1e70:3d3c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9ba5ac60sm1761087b3.94.2024.06.27.19.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 19:12:09 -0700 (PDT)
Message-ID: <63caecb4-19cd-4b6f-91f0-bd00df2ecb54@gmail.com>
Date: Thu, 27 Jun 2024 22:12:08 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] merge-ort: clearer propagation of
 failure-to-function from merge_submodule
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
 Elijah Newren <newren@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
 <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
 <2813a15b48b70ead7e3fd062d1b49baee665fc9d.1718766019.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <2813a15b48b70ead7e3fd062d1b49baee665fc9d.1718766019.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/24 11:00 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The 'clean' member variable is somewhat of a tri-state (1 = clean, 0 =
> conflicted, -1 = failure-to-determine), but we often like to think of
> it as binary (ignoring the possibility of a negative value) and use
> constructs like '!clean' to reflect this.  However, these constructs
> can make codepaths more difficult to understand, unless we handle the
> negative case early and return pre-emptively; do that in
> handle_content_merge() to make the code a bit easier to read.

This patch is correct and valuable.

Would it be valuable to go a bit further and turn 'clean' into
an enum that reflects these states? Perhaps that would prevent
future changes from slipping into this mistake.

Thanks,
-Stolee
