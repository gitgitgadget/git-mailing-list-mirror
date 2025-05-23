Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4021C32
	for <git@vger.kernel.org>; Fri, 23 May 2025 00:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747960570; cv=none; b=j7j9gC3n/w1rOdDMKI9+n9XKK5FrS7Z0lAi+Nf3DSXy6almFiQpFR032+OFLfdjQEq7r6GkxplP9EtiKHNvKlyYmNndA1/CU3WUTkHSRnEdOOX5OZIJ14OrdQtK0iwnl4MCBhXgdc3ltOYutZua1njJPPH1UR0NNDE4fOXLMswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747960570; c=relaxed/simple;
	bh=gdu75+YkoxhkhQ5ua4cmcbnwjcHRHbymGj1KQY81WnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hm8xQwDWw4gnNBvlTbp6yfdn6ORY39QKI/tNLLJYiJhtm+250vd2+qeOfSFOJOwmGSdP4vKE3U+b83W8M2vfBhk/FxaLJHmmU7kuGtIEAIaxnn0GV2Ih4dwFV9A6UgfgE2w7usm2xrn/pZCuZaapGhJ9T1l/urW/6nbS10RmJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hNbODkwX; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hNbODkwX"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f8d663fa22so75929706d6.0
        for <git@vger.kernel.org>; Thu, 22 May 2025 17:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1747960567; x=1748565367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tedQwUs8hM20IUQ4dWPsuWnBqiNKA2yDfm9Ee8Y2pRs=;
        b=hNbODkwXTbj69eDYq2vBkZTsixClVqlTvnBzWDzWAuo7CJ+MmAAXRJiACGvVj7zvE4
         PzOwAOtpWtrXvHzMHxmtqFs5e9xDo9dhjzrhXX1J1qzVACqiLkr1OtBaGGx3UpY+s/vV
         ksAA0cVcCZKWL5PU0AgH24cSwOGbAXIqc8MrDI77gtoabSTuknT/KPwXkr9GPmNV5hvd
         kpJasuhlW0R7ddViqJiuUCpgTf/zvBFH1jqyjQHwv9P98O3A/4jHWA+Xep0kOciHmi4f
         UWLPy0jbsEVtNsxQc9iXj8ckeNGrpajzjAtKt5VNVzVTTghS7BeUfUWbXnMJVQ17sNVH
         lpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747960567; x=1748565367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tedQwUs8hM20IUQ4dWPsuWnBqiNKA2yDfm9Ee8Y2pRs=;
        b=blBf234iC5Tb8W6Z9Q+rgiZ2+VQv9ZGXNAEr9kk7B0SNtpqSm0tdt05IrkzztGOdDY
         Dp7ElDkAHJJSISpOU44LE78Ie5CNeKdp1DuNwPxydD6KxuFxfU4lZ6Ihs6UhSfmEcXMM
         j6qXhJPOJZyIf/O/fRhUXlUnJIcgCRGQsGLoYbN8K3kKMJQ9WNJivbv65I4FQU/9fWn+
         De5cq2mo9GuJpFRfS8LrZ0fn6qEcOvHRdK32TZFju75zgtkzv5VOBtivD+Gkfm58P8au
         YMM62gaFWmK5cB8jo+V07hp5T525wc5kyzdqtR/+oNv65iQVan4N1OBqyjCefsCFeKN8
         b9rA==
X-Gm-Message-State: AOJu0YyApc9rpTXse8/AAd2Pubhco+WHld6q7k5Kq/Du5tZZ7tAAU+wG
	aeJpzsHGPEJoG1re7hO2B5lq5VQfTNQZ0zKif2hJ3+rI0VXpTalZMKWdz0N7ItPKqJKFxa1b7Yc
	4OnYu
X-Gm-Gg: ASbGncv0JgFyGoCDXciL8FMKtkNGxkqpkxPK+4osHNVqRSpOBMbAZbO1KsBNfR4hWHK
	pYJ3e4K7RvPdB2G8ZPpVVpX9CZqX4eWAH7hjhovQTWZQeb90ZlWnlhnkaWi5XAUCkgpsAsfN5Mk
	Sr2tpqhs1S8sfITlQRpKphQC7M1gGsLj7aBXMohnF9cqIC6eV50lxY8A63F9mVnNnMSTOg2GTmA
	nqlIMAOpiYQSaqXh6Eobgagwdegh9tnPxdJF6pNhauA3+kxC01MS0yCq+audGPEfuruTW3nXYFr
	NDDLIn94Al0glJf6Vo/zjOnbk18i1NkiepBEIqSjk1xSthHHv+9tNC5nHym2j5u28gQoEKKHee7
	PTSgr1WfaxHME2eUTbc8USgOolCDdyG8ADA==
X-Google-Smtp-Source: AGHT+IFNAfllk3XHkiBMxl0uL1j7uORyKYDrdJ5p5js5ga4iN/P6M9SiEokJ+Y4bHzmCiJNrH/JLeg==
X-Received: by 2002:ad4:4eea:0:b0:6ed:19d1:212f with SMTP id 6a1803df08f44-6f8b2c328b3mr449606386d6.5.1747960567397;
        Thu, 22 May 2025 17:36:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b0987259sm106496806d6.120.2025.05.22.17.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 17:36:07 -0700 (PDT)
Date: Thu, 22 May 2025 20:36:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 0/4] midx repack: fix overflow on 32 bit systems
Message-ID: <aC/C9oQrcx/RiyP1@nand.local>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
 <cover.1747929225.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1747929225.git.phillip.wood@dunelm.org.uk>

On Thu, May 22, 2025 at 04:55:19PM +0100, Phillip Wood wrote:
> Phillip Wood (4):
>   midx repack: avoid integer overflow on 32 bit systems
>   midx repack: avoid potential integer overflow on 64 bit systems
>   midx: avoid negative array index
>   midx docs: clarify tie breaking
>
>  Documentation/git-multi-pack-index.adoc | 11 +++++++----
>  git-compat-util.h                       | 16 ++++++++++++++++
>  midx-write.c                            | 22 ++++++++++++++++------
>  3 files changed, 39 insertions(+), 10 deletions(-)
>
> Range-diff against v1:

Thanks, the range-diff and patches look great to me.

Thanks,
Taylor
