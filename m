Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05E64A01
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765551679; cv=none; b=QD1Koy8b1ZiY8tB2NUK0jr2q3k5Msw/sDSuvHzau6IUBmmaXOiJ7WM4aYIuy4wc9G8vcSMvKzTOFZ+g4jSC5gW8orhUJ0wZSW4n09lxB7+xeKkExCSwLmeKRE2WODcqei14Jdd00Fp2KX800un2BIBe8xVkJN9CjOYCSyqjuPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765551679; c=relaxed/simple;
	bh=WVesdPb66V7wwWNtOTueAl599KhvEQpBGwOFNLUibjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKwnYRMiPbKYLm3i6tbvDT9aLjj7WZQ7UQoCPKV8Ol4erNEr9W4U2PTKPULPO9YoLztgwFkpdZpxsSNyl+rpaRYUrFF80Q+aQfO+5BeBi8nPr1sL9M5bHLtP9QpWrWoUULmoliNzGOUkbvRwHwtXOHE2aqJkuAWIvX5MfodkPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsB8xyRF; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsB8xyRF"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-455af5758fdso369067b6e.1
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 07:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765551677; x=1766156477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+G2LsNbu93OWaNDtBlRcIBWX16WrBaSl8Mp899t1fk=;
        b=LsB8xyRFjMb3WBYLJFX8NBLJLpnpMy1RKaXd0oPhy3enH7wUxev6rGqkNXbD14lEeC
         /6yy+pWm8BVKmb7Az9uHHSebTdt2a8B1Yn8je9CN0RpLxh8qnIR/sH4wTOBZ0HYq7AtT
         f1qztZHw2j2MuxNpZ7kkC3qlQpl94wFCYJXbQ0NaAr2u5DNIiC8LAjhOLM4B1WooTU8x
         K1RLz9hfR34QwpJD8MWumxbBJb53n+NirLs6mY+xoGdMaizWob+c6YFA4a4MF/b8sINo
         W6qVqIYda4PMYI7n5smegIHCKCSPAgI0sRVUFa6IG3vpM2YnXuUwUXFkaBooCC8/l8/V
         qFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765551677; x=1766156477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+G2LsNbu93OWaNDtBlRcIBWX16WrBaSl8Mp899t1fk=;
        b=GP2pHzr0UbE00dkMx7cRS1X0Vjmlt2vB4Knyu+nCKQvZD3VDLHoQU5hKyattvfRsyq
         ZmojNNEYEKG6F1ZNtog4opwXuPTm+GgKs+PApTNcNYYbtB5xp+a/mGZzF3YS3r02vPlW
         2OnrYlHa/iuDRd+Avr0d9EbEfbGqyWgR2aId9mRawOYbIrTBF8DH0BOLetGLSekZ00OK
         cooQ5CtkmJ0kCOqH/1hVOk2wZio2GpYfkywHO1TPYRtxvHij/sucD0PhFgAAPje5ZH0U
         wUjotnfj45vLF/05L2cQTRwExHJUMa8n4WSJuLyZCaCC7Xr4Y7vGFlmFeSc70LF2XoM1
         c/Lw==
X-Gm-Message-State: AOJu0YyC4sv7EFD5fyGoB420mU8ltemBJEbog9+usK5dMlYfXcSvns1h
	kyEuO2su0I9NK020jg1l9dEuYVNnso7/Kbqk759SETb7Hc3iAkwl8JZNWhKkow==
X-Gm-Gg: AY/fxX6tePGs6OY6VsOb35PYHZ+R/GTDuGNX40qITmPLpBuO9VYex2l4o0+K/IaujBC
	A/VwsIbYJ7A/77B1rQVaktKAhVEdsz/OwzlqWG+ofM+pd+y58jcraFkHli6VAmMWP8VaEfcOZn8
	IAXjLuyg+kH454vJad45WbBSfbO7VVjGGx8N0OQ8kYh8LL/0Np1YUGvjYroZLRXG3lz8FQwz/xW
	yFlEEZZwl/4KZlnQTXHNABuBsPScpYExU/Lc5MJNZ1wHDGIO6wxdR6BngMDlyyxCe5NBP0h3TkM
	5fmQVbBjja94d1Xb5mH4Hsp2V36w71LSeL8XsdHc5D2Tb5tFi8/hYpJZicTyQ+uCL/dRX/dUcLZ
	u9s5zny1nvGCQRZ2Tz3sAo8mc/kJJFIeDDzilqMbvq7UTe5CsolbR5S20wLFMWUYnMQK5zAsAtp
	Aki1eX
X-Google-Smtp-Source: AGHT+IFoX7bWxi2PG3hHVbl8XkTFQ4SNQdYmK8ooTvEYFyeSF3b8rcPZYFql/FPeR0gz6Ib+FKpD8Q==
X-Received: by 2002:a05:6808:3505:b0:43b:252e:f793 with SMTP id 5614622812f47-455ac951413mr832052b6e.36.1765551676048;
        Fri, 12 Dec 2025 07:01:16 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45598cf2becsm2589390b6e.13.2025.12.12.07.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:01:15 -0800 (PST)
Date: Fri, 12 Dec 2025 09:01:11 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/2] Some random object database related fixes
Message-ID: <eerya3xfsrf3nb5onk6b2nefaj2ghsu3v3rhtijijht7r77rxt@chqmu6gmhq3f>
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
 <20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im>

On 25/12/11 08:19AM, Patrick Steinhardt wrote:
> Changes in v2:
>   - Drop the first commit that regards geometric repacking with promisor
>     remotes. As it turns out my assertion was wrong: geometric repacks
>     do and have to consider promisors, but they will fail to handle
>     them. This is a bigger topic to fix though, so I'll rather want to
>     move this into a separate patch series.
>   - Tighten tests a bit for the commit-graph generation.
>   - Stop referring to a "subsequent" commit that doesn't exist.
>   - Link to v1: https://lore.kernel.org/r/20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im

The change is this version look good to me.

-Justin
