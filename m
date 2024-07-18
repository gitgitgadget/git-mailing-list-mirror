Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698C57CB1
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342300; cv=none; b=VDCXMTX6f7h3QUhqfARslIMxBMhhmiJWGXaVvSjKKx8xdotFW6hKFf5sPgUoyZScwe12Y+udPKK2soLbG9WHvVghjTHH+C4PSlhLMv4t3qHuL1kopN9u4p7D73EmrHYKfjNbJS15i2YrH9AumFFtV0hhpQ1bbOR5lJEg/+C0asw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342300; c=relaxed/simple;
	bh=NQws2B1+p0dnSJ478e8W5AkvrsKDcSU2xQGmW/YBFKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oo3MUs/HJHBLfQgNmCfiPryWcT2PaD+SjOW9VxjHD1S9ffp6O7+rm7PvltQG6cueqNkWWFIlx/RrE8bqE98hPvWk/RaUTxLG37P/jguLVc0kRgRVKbmpLF8N7OqekUGZcLCSZ6sqZDenr2mwpuRZ/sS3EuRwTEYIhdsexdtwEmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jzjPSrWt; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jzjPSrWt"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44c2c4ccb7aso6989651cf.1
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721342297; x=1721947097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQws2B1+p0dnSJ478e8W5AkvrsKDcSU2xQGmW/YBFKM=;
        b=jzjPSrWttSpxAoNviCO+0eREq4JRA04QlWi8JzL8Xe2N1Xil1bzt4LhsNxwt3Arx87
         7a+SFtZVoX91pwWYaGtRqvG4SzhZ1kj+uBc1zI4yFrQdUxo3KtSKJe5LG2hS5z5rQ17A
         vRjEjWieiuu8eJPGBgixl1Fm0JZ4EMEieWLxfp7J/eq7jHQO/8YOfC/Mv1xtGSAocVT4
         RUUhkpGGk+OqboFGos/+SLTyKxRWecFeeY3I7JncBqw8Ym70ahku8II/pIBIz7yLDtJM
         9N60d7jr2Y7T7IRzajPYflNsrBZesjlJ2aorRwqaOvXbGGsLkSL4RFkvhg3v06obXRRI
         /3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721342297; x=1721947097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQws2B1+p0dnSJ478e8W5AkvrsKDcSU2xQGmW/YBFKM=;
        b=pkXp4KtT7owwNYzTurPXZOZh8uahMmNGEfMMywsdk9qHww9gOn98WeNc7gy0h0CcJA
         yyaF1zMJgk6qTx9XUsHiLHMWZSIEtdkh5zBp7YQ4M9TZIniV4M7TTi642srWH9U7ZB10
         ZSgRNo+bmXKyinN/2SIT0XyyK9inkasyq8GrBva3F+LSIgJLkkg7Mo8owWDL03B6Ic9p
         JJRcofD3UP4OnKpoXW+fmtJTfnuZpjjKzE2GRZdGxdZKydblRlBh7rf/lyRnXyeJzdXZ
         iMWf2CO891xQKP4IGAmnVBuOCFINVetrV6mIrFS230txrgmKFXuS4dQguPRWg3fm4jHu
         10Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVhiGMM/7Nyy73FKmb7VZ+WIAaR28fXyo05+esxTpgOhkQFPMjSG4AE5B8HyivbPbeVozouvTBfUPYTCsHQAif+luV8
X-Gm-Message-State: AOJu0Yw93ocy8bs90yF2sahG2cQxQW/KgTXjVmRA2+jbYpRWx2JQVTcz
	dKRXLbiG4uu/ilYucrhBP9DPHRkBR5Z4rtp1JF1PeoemaWwA9a+qJ9w/1pbsXYY=
X-Google-Smtp-Source: AGHT+IHVnEQoJTS+/hxXU50Wo3DoYRA9xUbK9JPdkz5ORI7EsdmRc4TLK3WbYsttuX5dJ73fQ3xNjw==
X-Received: by 2002:a05:622a:18a6:b0:445:e9:e67b with SMTP id d75a77b69052e-44f96d6ae10mr43867751cf.23.1721342297577;
        Thu, 18 Jul 2024 15:38:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cbed33fsm681711cf.7.2024.07.18.15.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 15:38:17 -0700 (PDT)
Date: Thu, 18 Jul 2024 18:38:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/2] Fix background maintenance regression in Git 2.45.0
Message-ID: <ZpmZVAL5MihrNVbN@nand.local>
References: <pull.1764.git.1721332546.gitgitgadget@gmail.com>
 <xmqqle1ynz18.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqle1ynz18.fsf@gitster.g>

On Thu, Jul 18, 2024 at 02:57:55PM -0700, Junio C Hamano wrote:
> You already Cc'ed Taylor, whom I would have asked for help if I were
> the one who found this issue, which is good.

It looks like there is a small typo in my email address as
"me@ttayllorr.com" instead of "me@ttaylorr.com", but I saw the message
anyway ;-).

Thanks,
Taylor
