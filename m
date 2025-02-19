Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8F1DA4E
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976936; cv=none; b=YUUu6IxbPMe2iyY8OQizohBBwM8Oj+qoXa2rsLIEt93txTOpkx/OfOT4n0Puy4uPrN5uwiLszk1zSU9sMlLUGFwHORihOuX/VBZT17xtMtgLFWbTYQH+vIFwU+vFcOVfHl3eA1ybkGNlysRpPa3szP+BtBCOnZmo4j5UAOep5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976936; c=relaxed/simple;
	bh=ibLSteIaE8AS0+l4gv5MeNLXc0W/L0yyt1ho3Kn2zcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRUeJC7OXnG+eB33WinPl7sYgl+W4z19SFu0RsEtGuFufZROG9FPhjPrm0yGd7uHyFXLiToeqFf42P3Gvcmoie5dkKhRsg2ohH29rINsTlqhh+2nMiaynoPOlogYCbzmO0mrx0hkUXmhm8ZE6lEgGQos5EUHD7ijx+autaoeyS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt/wTSBe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt/wTSBe"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso22817145e9.3
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 06:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739976933; x=1740581733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zpQudfRSXN40QMbP4YyJRmNsFeK/48mRpE3CxrR3500=;
        b=Nt/wTSBeEQvHHlBfI8foRDwQ4gJgl61GUJVmh1JW5nCS4vWVEexbj4zr7TYLJ+Q9eS
         cJCobS8jNu0QP97RZN1rAJqxVQRTlyJ3gKq4ssT+6/CkGupw89rY75/TFhQzrjZkh0Pk
         X/8+X8/2YycplcPmp+cA2QNMAfEFesCL4zgiJldoSPlO76vwPViAHQBudxW4a7oNWG2w
         GeDaTMrtrEsSu+fqdDC38VUMrYa5AhZ9RxtX5sQmmCtKKvOOe0/1e6UoWngEo2MjQXXd
         ciJEEiN2kL6CnvYFGzCxMXVu1XWgbeZrtSgCwJdXXVzIM4Z1+Ndhp7luOL6KNjE+xN/l
         AmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739976933; x=1740581733;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpQudfRSXN40QMbP4YyJRmNsFeK/48mRpE3CxrR3500=;
        b=Rj6IqZl/8bS291uuXDUUBpQwMCXuufgj86vu/6duPDWqTq5xMFFnPRGetfewYKZQ8+
         hlVYIcejmucV2qbReU4IdLI3HeMUSkYIpbqywpFPtzpf+1aejNOey4E1bUDHm89NCXDN
         dORLSU04Q5EXks5hqYR3q0zWsHu5GLeOff4i0BkKv11/hoK4+CxCM6Ny+9woBnZcK0DS
         6SvnPzIdyNJPRGUfHjQki7Y0jmaus2R4fZaJGy5qD5VCf1L/MtTLSyyVc7ZNxbzKIeEL
         rYNh+3jiWRYICT9DcWEOoEqjovSScfSNKXyQDeML6eSSsZko33UFxIliFdg3TrDffPiW
         GQGg==
X-Gm-Message-State: AOJu0Yx/joUhvwqqFt1fV9SGxvIaTsRssoxmqpbZDRh7oXD7Rp5xMJEJ
	pLBOoFs6IHflJrGmVJBWCMvsKh4ZY3M6w1aocyX28oLfOfAd84fY
X-Gm-Gg: ASbGncvxi+ZYWOPpzgqoJlFTlehHC7vl6+eanNy82SBx9KEyYd2jWyFesJiCOziROYL
	4xYf8V3fEKDdB+qcrDp1lucEnSdG+klewgKM0MNueYm2WoG+wdpeW1h+ZhfQRlZJ6SYx6P8S3zB
	lkVRHK1WlEPT8kSfYU7/P1jJyKItVE2O2iezDPLF8gJo/CysioX6Cp09N8DL7RQgQ1ba5s6gDN3
	fdjCuLfWYTgQy4DMLdZiWCvF67Rv00+mT7tIGiUKCxA46KiFNDMLiKPVSGJSlYn+girlDPNAz5n
	y/w3qIl7SYb8Z103zAjPJEGMqyUN1z+OUpaHX7uNHr8KOOZCOITXGA1uAtBFZju4Qboxig==
X-Google-Smtp-Source: AGHT+IHRS9yUEGuGQX2wedt5T+00VEcHMMtsXGJf7emj2PO4X7sxEVS4DxObYiZj9ty35xXU42kUSg==
X-Received: by 2002:a05:600c:35c2:b0:439:9698:d703 with SMTP id 5b1f17b1804b1-43999dd1187mr36887805e9.23.1739976932419;
        Wed, 19 Feb 2025 06:55:32 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8273sm17670504f8f.89.2025.02.19.06.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:55:32 -0800 (PST)
Message-ID: <49dc31a3-bdf4-4abb-85f6-2a80dbe18cad@gmail.com>
Date: Wed, 19 Feb 2025 14:55:29 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/5] merge-tree --stdin: flush stdout to avoid deadlock
To: Patrick Steinhardt <ps@pks.im>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
 <pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
 <3b3179785098580f3336bb24bdbaf0aa1366bfcd.1739895879.git.gitgitgadget@gmail.com>
 <Z7V48_q3Uu9d0D3Q@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <Z7V48_q3Uu9d0D3Q@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 19/02/2025 06:23, Patrick Steinhardt wrote:
> 
> I was briefly wondering whether we should rather move this into
> `real_merge()` itself, which is responsible for writing to stdout. But
> the only other callsite doesn't really care as it will exit immediately
> anyway. So this is probably fine.

I did wonder about that when I was writing the patch but decided it only 
mattered when --stdin was given.

> Overall the series looks good to me, thanks!

Thanks

Phillip

