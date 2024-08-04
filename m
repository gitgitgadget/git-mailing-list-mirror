Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B22744D
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722788385; cv=none; b=n06jc9MQ7cl/ysiSutH++scQFpt/KzFQiq0PqCSUkRjAPjIqIht6IpJMghQ4UdY34rUicyfa4fWOPHH7ndP6vMXE5roWJJRDR5NiI+KPiuUhVLh0u/p7Vze4IywLTiERFdIeD2hzFir7l2Xm2s3pvO3/D9smJ9vPXWk7Y5Wdx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722788385; c=relaxed/simple;
	bh=hbfTSEGLm7cFPNTOmJhS+GDk+cvAmWnTExpsEFY9Zmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY40zxjvJn9WQceFX9BGoOKRtiNOXO6ouUgEVld8CquiLWHWtPXR2MKst0vhNtjWie/tqzkyvY5m9hu7iz0eua1et7FC1AYfU19gzmbm9HDCRasDCBxUJCLwszi+XAXrOyAW5Vhi4pNK5nIpj94gOKoeF7V8PF/tXEzl0zLGVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XGH+LaXg; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XGH+LaXg"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-66a048806e6so82337317b3.3
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722788383; x=1723393183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hbfTSEGLm7cFPNTOmJhS+GDk+cvAmWnTExpsEFY9Zmg=;
        b=XGH+LaXgAjmbZjsnjMxgpOe5XtTOEjHkKLbol2u0siqBN8MPdSo1vsSjT5YYjjabLO
         0kvmXtbbSzzIL1pWBTU+AdYNDROzDnlDCUyf+YwMzdKhibX3lQ+bTU5XkTgSRCgl8TeS
         sEGHxxrMMIx6jp+dj1QE+eA+ZWeNoK6wWY2+VPSyHTRJiqE449GXmtsv+bmVniL6isKW
         07ORv4Rrf/KY/u9qbi9Rkd0lzPVXwLCqHy2fCd3DgdD3z0eMxhGpj2J+0Pq45uRqdgot
         rAMVAGPnZ9YXuY082PaiSc19pqbhYR7cMCvfz4iotUn9i2R6XfpybgEWnq7s8wQ6mSXm
         3OiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722788383; x=1723393183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbfTSEGLm7cFPNTOmJhS+GDk+cvAmWnTExpsEFY9Zmg=;
        b=JObYhAcllVSomATrP7M6smQV/jF2knX2VSeK4H4+80oE/aGkQcfsuhZZ75nI+Tg8lL
         JA4SVu+dlUmngti+rF5AI5WEii+NvYFEx2l4E3FRw0PX0m8p5Oski0a+nLlfxRxpESKV
         7tdgxmYMvEqVdTulM9bq6hkRLRKOlYtBCqVrCn+YC6/d3PxED7K3iiDLRjh178e81O6e
         5emUmiLMGPvveTmWaRh/dosGa30OxQNVGeZvI3n7NEWzvXUSAW6Qxy1vz04+UbMVfiBG
         8483HZdMNWRVQzcddmM5XNizLKonrriFgEyigOzsDPEHQXS4j57m5ND1vGU9wSCkk701
         U2hA==
X-Gm-Message-State: AOJu0YypQfWjTsXGs/Uy0jEjp7heXnjiQO+saCgbZS2XBKSViSZX5ZQy
	5RlqFqUm3z7sGvx8OFrjOXJdl0RVkTfWDAM4q4I4qnpdk1qNDPbqZDyf29nM1oD5OpfEbAGpnWD
	C
X-Google-Smtp-Source: AGHT+IE6uz4gJC2GMHScnE3XOixp12eeYmtOjDPwIXEQEP56o+StuGUOusO4fyhIvB3QN9siu1u3MQ==
X-Received: by 2002:a0d:e405:0:b0:64a:791b:60ce with SMTP id 00721157ae682-689638f1cbbmr100739847b3.30.1722788383496;
        Sun, 04 Aug 2024 09:19:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0fdb3f5dsm9082107b3.50.2024.08.04.09.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 09:19:43 -0700 (PDT)
Date: Sun, 4 Aug 2024 12:19:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [BUG] 2.46.0 t7701.09 fails on NonStop ia64
Message-ID: <Zq+qHRwHC3sD14eN@nand.local>
References: <02d301dae43d$2202fc90$6608f5b0$@nexbridge.com>
 <ZqvgmYl8BTYvsSa0@nand.local>
 <032201dae461$c7bcc9d0$57365d70$@nexbridge.com>
 <ZqwvQUAqVozGHG/t@nand.local>
 <040801dae528$70966d10$51c34730$@nexbridge.com>
 <Zq+mF2fyL5hux+3k@nand.local>
 <04ee01dae689$90b0e0f0$b212a2d0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04ee01dae689$90b0e0f0$b212a2d0$@nexbridge.com>

On Sun, Aug 04, 2024 at 12:15:41PM -0400, rsbecker@nexbridge.com wrote:
> After git repack -d --cruft --max-cruft-size=1M &&...
>
> ./trash directory.t7704-repack-cruft/max-cruft-size-prune: git show-index < .git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.pack
> fatal: unable to read index
> ./trash directory.t7704-repack-cruft/max-cruft-size-prune: git show-index < .git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.pack
> fatal: corrupt index file
> ./trash directory.t7704-repack-cruft/max-cruft-size-prune: git show-index < .git/objects/pack/pack-b8dc9aadaadc12c82b0053fdee0039ae1025a8f8.pack
> fatal: corrupt index file
> ./trash directory.t7704-repack-cruft/max-cruft-size-prune: git show-index < .git/objects/pack/pack-c2357b2b204fda52bc1f5515de94227e1db012af.pack
> fatal: corrupt index file
>
> Apparently, something is wrong. This is an ia64 Big Endian. Not sure that matters.

show-index expects the contents of the *.idx file on stdin, not the *.pack.

Thanks,
Taylor
