Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8971858AB9
	for <git@vger.kernel.org>; Tue, 21 May 2024 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716335461; cv=none; b=uuykNRdWZKMLL+LbABRHFWFzNpUNDMwYI3EZE9U9VKWuRdp5165hRx0Fgn7wtYjl7b6mwmT131ct+INKyB1XP7P+bi4IzxeX90ClHN3QGSDiDSyVafW7m9sTycewmd0fsaAv35+wfdqWAwVgREEw8cTbnCgaFG3ZwxqU9rSzohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716335461; c=relaxed/simple;
	bh=e7AbokHxcjfUlbAH3UNIrTiboimJte18RC9BGuTyuDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9O9Mth2TuLyj5sYsFRabCmrzz8UeH2pvUWYbqGPcXP4aAttuI9t25gZlxFZ74MSAi59yOHYssfv/nC2lQYtGjztC9iu190Od7HcLE96pxcUIz8A0AkXdK1Cmy8+rCylpMA2kQYNzO+xID0D8XFa3vN3K97dzDyRKoC670cXZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeOF/gBX; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeOF/gBX"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-24157800275so2091479fac.0
        for <git@vger.kernel.org>; Tue, 21 May 2024 16:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716335459; x=1716940259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+1t+pv+IoDID67ox/Ft8yh/liVWz/YOF4g4sxZ8fJA=;
        b=XeOF/gBX0vBvk2hSd+s/PVIctktn3IQXFoS2L4VyJKvohCZ5qhWa/mGEbsu0AvL9DD
         V8S25UdeHVKbs7rD8UoLdYFQUxkiwRvzYLHx1GTSROR4/O0Lydfl7ngUhrEOjefeYu3c
         8sfxGlZfp//UztEH4y1P0I/yGuFgR9Xq6Uobl29wUgzeIlrJoy0eVKQtSv4XibQ3VII+
         vTQj0FbSwBjeMxYwUkKwFgnwcl1SHiomvX9+hCGi+Lxni8SlMQD1TGV+jhOuFqkbTfdA
         iBSzoY1dIaAHRX82xGpkyKQGYRhWbIYFsCUayT4sMEQY5YrAsuUrEWWrFDGg32C0Xx32
         JnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716335459; x=1716940259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+1t+pv+IoDID67ox/Ft8yh/liVWz/YOF4g4sxZ8fJA=;
        b=AnyN4XLVo1AKnLMzbQSM+Sl5rlMXvY9vde+a/S5AOpal/uJbwzNtbPnERioiK4dXG3
         LwFEZVoNiyGAsgMNQ0aDJjf6vsV5wsJnt4LhZKQQCLjvcjOPafV4jACXzGRzcyfRBRER
         cn6+C7eRVIpKIAoZX5BnZ10sR1kYJIKe7uP7Fs4NZ0vsw2Gte+m8WGun1A07PSATvgLs
         j8iRLeH5sS+q0mWkIBoyWhcRa/12b8JsIlMASMsns4V4p70GXkdkki8VKc1fZPW2JzND
         EvcvpUVI+60ONF5Eg0RECdMgmizewsy51lFr3CeJ0PIEmfQf8y9ghpl5+qTyRP71TGsF
         e5EQ==
X-Gm-Message-State: AOJu0YxIqWlxWdwYaRpuTDftUT3jIrvPlD2QssSM3TK2mi8N02oj8CEg
	RFv8emQqCK81K/MjhzV/KZwHU65smeQe3w+R/Ucc6v/Imvy9DQ9Z
X-Google-Smtp-Source: AGHT+IEt1uMjic8nZ27dGyAewCuUQpMrQv+Dqv52UaCVKzkA4zUwGKXmU+CS6ZSOZMK+FGBqtzuU0Q==
X-Received: by 2002:a05:6871:552:b0:24c:523c:b6cf with SMTP id 586e51a60fabf-24c68b80c30mr648949fac.30.1716335459532;
        Tue, 21 May 2024 16:50:59 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412ac76e5dsm6251240fac.41.2024.05.21.16.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 16:50:58 -0700 (PDT)
Date: Tue, 21 May 2024 18:50:58 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/11] refs/reftable: allow configuring restart
 interval
Message-ID: <2zq4lspmqkcw6ssaxgc5txaubivwvghwgf4kmsmk3nfsizbmnf@twznyofqazml>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
 <2b1579570798a325f8a5c97438b1fdeef65aa049.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b1579570798a325f8a5c97438b1fdeef65aa049.1715587849.git.ps@pks.im>

On 24/05/13 10:18AM, Patrick Steinhardt wrote:
> +reftable.restartInterval::
> +	The interval at which to create restart points. The reftable backend
> +	determines the restart points at file creation. Every 16 may be
> +	more suitable for smaller block sizes (4k or 8k), every 64 for larger
> +	block sizes (64k).
> ++
> +More frequent restart points reduces prefix compression and increases
> +space consumed by the restart table, both of which increase file size.
> ++
> +Less frequent restart points makes prefix compression more effective,
> +decreasing overall file size, with increased penalties for readers
> +walking through more records after the binary search step.
> ++
> +A maximum of `65535` restart points per block is supported.
> ++
> +The default value is to create restart points every 16 records. A value of `0`
> +will use the default value.

Out of curiousity, if for some reason we didn't want any prefix
compression, would the best way to do this be via setting the restart
interval to 1? I guess this means the number of references would also be
limited by the maximum number of restart points.

-Justin
