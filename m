Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629CB204F97
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292422; cv=none; b=Qgu8ZzkKH9eKvwEVeukwESUFisEQeMbpeBuoIRrhHndmx6MjDy2BXRSxx/jUZmH04brSn61WNy6MewYhJJVF6Q4ojs1nH+3CEREb/YfWu2NgQUgLHJAi9TPKjnSVv34mLynxucjMAWTiCdaVZjMEaWAtp/mxCYwp8EZIcLtxb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292422; c=relaxed/simple;
	bh=QtAACuGFLRM/nuBamO7HKRFWmg6Hgfunmmy66onRFGQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a+Txcuvf5WeZ5rxhwDefsSY3qDBc3BL7EIfY62P4GZhVFAJuO1P0nYwyR1RW8viIslvAqn+12n1I9t3QswiZ+FEwouOL7lHwc/UEBKnZs3KZR2FbJlx8fS/C3T3boqNASW2xpK978M92jVUgN9xmiV/Ck6TgMfkmgctPYXYbQiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJu30bwp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJu30bwp"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso3578814f8f.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742292415; x=1742897215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JYOqCYzWB+3Yx6QlHeW3m0NsELFFSmaFRhn6h4fQjp0=;
        b=eJu30bwpklpo3I4FtS3Pj5obZmOsp6gN5dBVOfUGmp2DDB/GMvWLtqLjt1XP9PZlSD
         cbq6r+z2uJVj9Yp3VHnwld5jtpOqpA29wqjOm6c02KgI/nRSVXEJw0kDTLyjxlUyRAaL
         Rwiy+hWjzUMcUgfARxOXsVpuJmr0GI7ST/IPqzEk5c5ppX433RQA1UP2j9ddvCKCyXjr
         flbStP83wGREn33NpdtdSMgEyg9rerQC7hCg9VCRLBMBxirUy+1o9/e5QAsJk7/jtarE
         4k4kKerJ5rPqr2E41J47UaVgiOihngiNs4oL/zKMLh2hRciNJjgdzqcSCJCy2xpiMynE
         IFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742292415; x=1742897215;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYOqCYzWB+3Yx6QlHeW3m0NsELFFSmaFRhn6h4fQjp0=;
        b=atFz+mhTeV69NIfZb2R/qN9zp3ANi3sBRxLqhmZwVWF3QNzcgOg6/mVCkEX2exxn45
         U8xMwSG8+fZr7gqDNHthwmOm4Yt3PwG4iR6k/2Qnoy2qrDrDd18AkMYzFc3tb0XOcfIN
         Ayfk15VNM2+PbjIj0+DiRF3IQw+j+eJCJj7VcKeCMHDA61/SqbCAykCNVHAyoKxF+W4a
         tFCJNOmTMBL5ECwq7iaJ0KxbJQWZa5LOhu/ztZhCWAg6VzV6+O8b1rgocFPTrxBTA/pU
         RdWBqeWM92MCOOa5xgoYm0dlC6yhnN2pPu7PKtLDBB4tBHg3sj/376RP9K+YJk4joqAx
         0WUg==
X-Gm-Message-State: AOJu0Yyt8eRFjI1bQpVgce8IJ1+pk3qdKLmvJWe3balflmiK6c95VEnJ
	pqosz60vblSuD8S1iAtzC0Uai90qpuf8xgRYjUiglpbVGs3GsLxT
X-Gm-Gg: ASbGnctYHjMziandMb0EB9JT8kMI9EUQqT/5NXCsY5ShGSqTY1ZJkbGW7tcr8qhCuIR
	FQp8wkPj5IcC/9Olw6uSOI+G3fefSEy7rlPvERIqLxgDomiDk9zFDws64jQwWdftUiMp5z8w3Bn
	l0wY56k22jNpWAm4Oq29tucV9NMCshJvZAfD9fw6u2e9+8reu/Eo+THbZPT9VUXS77wksMobgPA
	fvhTU/2nhaIXnhfq6SlcoI/ZLtUkp03ZPErqnxEg1syYLmM3ykV4sN6wdVmwjkUZ3Bew5TF3+al
	ljCgIjIZwIreiwQnrP7fMcwWq1ujGNWeGW7Dlbr1f6N0EZkMITv4VXryq5QjpjeBdDTQ0q/TnYS
	J1MvOJUAYyDnvroBf2RSYEhHjx8TQMgQ=
X-Google-Smtp-Source: AGHT+IGm8u8p1D921WlGRCTj8mlo0u03cWZ+Gawqc2t3ynQyA59iw4UuAzbzz55uAD7+s8VaDV9fZg==
X-Received: by 2002:a05:6000:156a:b0:391:2dea:c984 with SMTP id ffacd0b85a97d-3971d133670mr16678728f8f.11.1742292415402;
        Tue, 18 Mar 2025 03:06:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbfa90sm129180865e9.16.2025.03.18.03.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:06:54 -0700 (PDT)
Message-ID: <7fee83f7-995b-4c84-9216-caa6803a69d9@gmail.com>
Date: Tue, 18 Mar 2025 10:06:51 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] meson: don't install git-pack-redundant(1) docs with
 breaking changes
From: Phillip Wood <phillip.wood123@gmail.com>
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>
 <20250312-b4-pks-meson-breaking-changes-v1-3-b89e9a59d228@pks.im>
 <44a3ad4e-fb50-447f-bb66-f43b5c5ae012@gmail.com> <Z9gqP3ng0a9Zfpqc@pks.im>
 <d341777a-a6e5-46fe-8004-9fe885321905@gmail.com>
Content-Language: en-US
In-Reply-To: <d341777a-a6e5-46fe-8004-9fe885321905@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/03/2025 14:50, Phillip Wood wrote:
> 
> Oh so if we have selected breaking_changes then manpages.keys() does not 
> include "git-pack-redundant.adoc" but that file exists and so we need to 
> add it to the list of configured man pages. If breaking_changes is 
> selected then don't we end up adding "git-pack-redundant.adoc" to 
> configured_manpages twice? Does that matter when we come to do
> 
> actual_manpages = run_command(shell, '-c', 'ls git*.adoc scalar.adoc',
>    check: true,
>    env: script_environment,
> ).stdout().strip().split('\n')
> 
> if configured_manpages != actual_manpages
>    ...
> 
> ? Also I'm confused as to how that comparison works without sorting 
> configured_manpages. Even if manpages.keys() sorts the keys (the 
> documentation at [1] is silent on that) we add some out-of-order entries 
> to the end of the list.

I think the answer is that the comparison always fails but as there are 
no missing or superfluous man pages the body of the if does not error out.

Best Wishes

Phillip
