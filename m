Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709D20BA8D
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704608; cv=none; b=braIJc+vkRXQq/KsRGR7MYS80+xSgPIaKVD9yaZB1pTnXCFxhR26S//Ztg2rr2rk95ePrNuGgs1k3PVJk9lWRfSaXBgu0VVKEKDtDADApsjsnKyMJ2Nsrjr/pWNFCxBteS64B+Zyc5ZHYtewhp6fLV/78HPt/r1LK4DbHlHskIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704608; c=relaxed/simple;
	bh=ZsU5Hwh+6xBSZio+rthWO28+8674Wyfbnwx91D9wYGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEvn6tkV7FadShuSXWyRNmLFIqLwIFmAbc+S5fCsJUtFlXVKjkGFzMblQ/cnUJrghqXre9tjc0XP0kAtMuM3bbTntQZ0VdOCpraoyr+m1CZeWwQecF6qeseLmlYJJmfghRgmiU7WhVlLEC/2dl5XeI3aWsWeP8Vdm8WHEtsaW+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNe08tor; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNe08tor"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f1c567ae4so4128604f8f.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 02:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718704605; x=1719309405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O2JkJLypybo0g+X6kLGqNGSvLqikiOVlHLnGFe/XzaU=;
        b=cNe08tordjzIl9kCiyGJ/oJcv3hHISOIqXSOmK68XxE60ALEdxG/9muLK3htT7AMuG
         xCxgbF/gPWKE3qXyj44dSmFw0DKSclFL6IBbqT1pymWeCbs4BbskvweENK9Bb4NrZh5g
         Yx9A3VNpwkCiz8US9AfFJI6md1cI0Uy0fH/rW17vxhj/0mN396iQijTcc4EGSCZ1IsFS
         kQt0m8aK7xiuzXrmcI3wuWPbOdIomtkF2y0IbNw38KRviD5X4YXCvduEGpmb/cRoNMnt
         K3m87OMvZ9NX3qoxuKYhhppoGBgLbqRxYNXwCm/+SVI+ljM2U8fAeyT3AfOJrWYSvP9y
         YBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718704605; x=1719309405;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2JkJLypybo0g+X6kLGqNGSvLqikiOVlHLnGFe/XzaU=;
        b=gQhjcq2jUxWteUiGaS0KVe4AGzF2wZM9DaVrFQdWAtdXvvsSd11qLDYeXZr6yQWp7c
         oyXeiaRn4qW3EVift5iRGYeq7+cqYcDQHbNpXzghQ/gljagipSyqijoRL0SBFPgD+AjV
         jK7AdcLx4yXt2vPmhTVKsi8Tv0FQ8q277iyiYtSEc73iRNOFyXTUOVU9Gu43fYIx7lgE
         5I0VgBKgJRSmj01+1Sh65aA5R9Z2GiyrbPrYuKgaIspaBEuba5ViUMUnE9hDDMFqP0vj
         /iK5o3FFEsImOKT8PwA3mVM1bEh6A902syskVf/EwizQhq8drpq9VOGgEJ6s2B3Gbd6J
         nwlw==
X-Forwarded-Encrypted: i=1; AJvYcCXLR1rMAkbttDowe7XZ8aRuXbbe+Z3lgTHllsy+/GKCbZdX43OuP1X29bZdBkoO1qIA0eikIzXtiC/Sae7mHiltONjr
X-Gm-Message-State: AOJu0Yxyxq7zrZ63H5iB7AOlMpAAgQa7uBnr6fGY9xUcjejUtuCG6tqK
	1/FY3ztj9X1ZkOkoXNIocdolYD4shjmTuXbdVkk4V1Vs2W7eT6Su
X-Google-Smtp-Source: AGHT+IHXWMcA6UxPg14G0B931FAU5Gl9LsCSmYKQSjC3HYqD4tSZfMGkTvCp7uiqHfDj16pH7P7+tw==
X-Received: by 2002:a5d:414f:0:b0:360:7a68:1709 with SMTP id ffacd0b85a97d-3607a769141mr7632239f8f.39.1718704605234;
        Tue, 18 Jun 2024 02:56:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3607a43eedfsm12033761f8f.78.2024.06.18.02.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 02:56:45 -0700 (PDT)
Message-ID: <b2a783cc-ad34-4647-a388-33f75b3122bd@gmail.com>
Date: Tue, 18 Jun 2024 10:56:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 00/20] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>
References: <cover.1718106284.git.ps@pks.im> <cover.1718347699.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <cover.1718347699.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 14/06/2024 07:49, Patrick Steinhardt wrote:
> Changes compared to v2:
> 
>    - Note in a commit message that we aim to have a faithful conversion
>      when introducing a `struct git_hash_algo` parameter to functions. So
>      even in case the calling context has a `struct git_hash_algo`
>      available via a local repository, we still use `the_repository` such
>      that there cannot be a change in behaviour here. Fixing those sites
>      will be left for a future patch series such that we can avoid any
>      kind of regressions caused by this comparatively large refactoring.
>      I also adapted some conversions to fully follow through with this
>      intent.

Thanks for clarifying that in the commit message of Patch 2.

Best Wishes

Phillip

