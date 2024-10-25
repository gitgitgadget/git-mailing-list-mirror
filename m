Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23D1217F32
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890593; cv=none; b=S/OO/mBQ38ncK7C5ywwZxR8O0IEoc16U21ledEDLo/vZHo/CxxDAEqTx0r0COIcNVZa54sGx4CCRTuWCwx6PgLct3Zsg+s84FIsA43DynZB6ft4gmEQbsrVutW3HZrkUPk7QzUXa/UfJciSw1LfBh/KE25OqmvQ7KxQquu18ugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890593; c=relaxed/simple;
	bh=+kS1oxa01p2wxsVbCmVgn7344jWmVMVCsYtQk5BO8B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9OVing7WhKaGdPdOURedjeT/ccQ0vgcnF7dGJHiDpyDv6B96vvLnXEfSFr39LEIXZfKfRw4toHy608rv1EPDjapnTHoGKWLpWE1IKXX9D3XNmg+9fFNgTmb+qtHJQrCyn5SCE+bO79JD6AIa0tz4wWmhI0M7XDwjIqjCJu5mdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cWurU+m3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cWurU+m3"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e2e508bd28so22821077b3.2
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 14:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729890590; x=1730495390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3yhxXGWOde5+yKnpkBCa6cTgSaUS6mjvVlGV+DCsq0=;
        b=cWurU+m3NomVEJAIoiNhfh/riQ7TRfhW9tATw3lH/ankgw3PrzCBWITgL+hXgVf+Yv
         VvFHVPEg0s6rg85XGVLpp4qkrrNFNmNY0sKUKql/Y9+G2dn3C9ckaGVKo0wx7An5IGQL
         6MG4Lsny1viZoYR3BIEZB85ZISp+/AYtgefASTFQirPe485OebfjFOKZ0CdQs8a/nB5V
         wuXGXk9mR2hGyVfvdIyL0vstrMkaTIcKpUCdC3j9JuLzWCs1oDLaPxItYcISqvY8Gt69
         p5Dx5yD2LVP4OgJF4mw74yDTz6oQ8TPoqCdF53x/18Y79+VqNdjtkzHFWZPkXXsdJppq
         glfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729890590; x=1730495390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3yhxXGWOde5+yKnpkBCa6cTgSaUS6mjvVlGV+DCsq0=;
        b=pg8+vCM4PkjheUcppeletad26nV5YldtchiVc4REt0bmV2ljGc7rjF0rN6mekxNf0T
         EQcY4hsJaAIm5GRzQR7xzlDm8ln04hJOnkEeUN/INtdqRGrs4Sh5XiwZLCQ+P+0l8v8x
         6I9LI33AkIf8HI5mO2uPKLqTzFsDCsZ3JQe/fOqrS+fxmtGIS1NrexW0N5akdCdVgKC/
         VZVGIfMUK6jgqWha7Ibl+fthgOe5qVEb8i/ElDuwi5v1ZcOsOxetJNjma12DN5udHKW7
         yOafl3zWzOJQdCf04tgFiJWQ4ABG26yQoGhOJzMdnahhyDEeHP5yDyeAdeCaYpX/5Rje
         ZtWA==
X-Forwarded-Encrypted: i=1; AJvYcCXSb1h5VKc9DTQNZL8weiW61S1/cVaF9PeGlBbtobfUWWxWmasFxlPOcjcvsgjkFwu5E/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLjMFhRe5/6E2cKinyQIXwknJ5rQBLmfrZ6gnjEhGi6qL6ps4/
	WVbXLYDTZb/P1BKP5WAb5ZkO5VUn/ZGSQBfSHaPyEcyAMjkRhH3/gXlssMNp4cg=
X-Google-Smtp-Source: AGHT+IGHOJtC7cNRgEuPERTimBpzAwcIBX+nNfKFC2+8G7ApiVZnhQiQ4o38lbG7i8TyGlyV7955dQ==
X-Received: by 2002:a05:690c:360f:b0:6db:c7a8:b0c8 with SMTP id 00721157ae682-6e9d893a668mr11462087b3.15.1729890590637;
        Fri, 25 Oct 2024 14:09:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6caf8b8sm4249727b3.140.2024.10.25.14.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 14:09:50 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:09:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Derrick Stolee <stolee@gmail.com>, fox <fox.gbr@townlong-yak.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH 01/11] midx: avoid duplicate packed_git entries
Message-ID: <ZxwJHY/BQJvpGT1s@nand.local>
References: <20241025064148.GA2110169@coredump.intra.peff.net>
 <20241025064340.GA2110355@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025064340.GA2110355@coredump.intra.peff.net>

On Fri, Oct 25, 2024 at 02:43:40AM -0400, Jeff King wrote:
> +cc Stolee here as the original midx author. I can't think of a good
> reason we'd want to avoid this dup-detection here.
>
>  midx.c                        | 20 +++++++++++++++++---
>  t/t5200-update-server-info.sh |  8 ++++++++
>  2 files changed, 25 insertions(+), 3 deletions(-)

:-). I swear I have written this exact patch before. I think this was
way back in the early days of MIDX bitmaps, and working around this bug
was the reason that we don't generate the MIDX/bitmap at the end of a
repack in the same process.

I don't recall all of the details at the time (or even if the above
rationale was what I was thinking back then or not), but I think the
change below here is obviously correct.

Thanks,
Taylor
