Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B2276C61
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287042; cv=none; b=Bu+Xp2pyNzjp+vpgaeYaE1ZsuzuKKhjSBrI1tmJY4ib0ghG2Lr4MWv5rAqTnEmzde09folJe+wFwsTuS5W2Fs2y4TxLpaSmIAo8U1vQCaDy3lQgpsL9n+9OgG7+BnMXh9OxOV0zsIie8q6P8Tc/Pc4tcSu0FqMMafvc0xT/1pTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287042; c=relaxed/simple;
	bh=nXGQMyOkVxhZcUO9+fR+VG00rAxOcHImnErgbUeGDyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bStpNZqVW+IQ/uVGTRTccJVnJMb0HEefglHMPD8nNC5mSo8aHthbgcmWilLf56QJ4AYszfPyRq0WGdzeEntENwlbPUybC6ZhxoAxsQ2dW444bpno5h6KTRzLbFSWswHbGuJ5mQIeggia3K0aMuYPc/rljlXDqFn27aDQyc4SJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kvOdMXF7; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kvOdMXF7"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e290e857d56so2688097276.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729287039; x=1729891839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nXGQMyOkVxhZcUO9+fR+VG00rAxOcHImnErgbUeGDyA=;
        b=kvOdMXF7kbrkcunv6HnI+lETKJ6cQp5WyYQx0whz0ojzM2evz6rgfyxe/YVrlan5V7
         E8dhcKZ3temb6Thj010XFxFKY3jITapmkoavPr/+J5vphqO1cfyzBrczKfcqUAc8Fx7x
         acpaZPFS51UbbHFv7abM7v7VTJ/dGCigrHNdYsceWXsFbcJGkvCu/qk6CRCplQD+MAsT
         EuGfx4K+DEhz6BIqfQhvOWR6U5RY4/pcBGrmxR4DeV9IeesAWT//J/dfPYF4k+l+KMDi
         lrlV+BzOu7FMqgE5WmMcHijrH33ljXIlZXl7QWk+2BqR6Tb9oLJYlbaZsOsZ5jMaLShk
         16Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729287039; x=1729891839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXGQMyOkVxhZcUO9+fR+VG00rAxOcHImnErgbUeGDyA=;
        b=BpeZeGQ44zyQCPnW+paW68mM8NQ2+htznyjjINNdN1E/oRNrHMu9dpsttQjSnwiQma
         LEa6hf2BZvxvuOMHtBQhXfTSrItxydMUunLPgCBOHwIUp12TqK3LmIUeg9gb9SMq3AqU
         jnsSO8S/GkwUF6orhBMy3Kw1gwOSprmgNig6kafwtYWHBpEmSSk87+u5/lTZRssDJA0W
         biF1A+YLSpqIGq9XVrpEJ4AKGgJJe6z4GAmFQN42y0vNZ2KRpCCqI7XRyVKaXlNuTSKf
         6cZnQqc5itLKieyooBuava9FkKpUxrRNPnZ2e9839AYwjG8Nc2f4c4cQqxO3WSobUR8S
         U1Zw==
X-Gm-Message-State: AOJu0Ywr+8wE7tIQhjikFQaQebb2i0TVRPL0IVPhBtFDAqjOWD5A7kzF
	+W3VvDJRBLEjsH45tOsTT90Nfy6OxbgZsuHnvx30LrFUb+uqHKwK/xp9sLP/37ZBo/lPkUMO4sr
	C
X-Google-Smtp-Source: AGHT+IE/ekdSFnBzDFEE3vMiUn66ZYP8iL1xoAG+4ISRtpFb1zhQ9OmeYNKoTDBuXCxx2bNIwgbYtw==
X-Received: by 2002:a05:690c:8111:b0:6d7:f32:735b with SMTP id 00721157ae682-6e5bfc9c4d6mr26385437b3.27.1729287039131;
        Fri, 18 Oct 2024 14:30:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5c0207506sm4755507b3.91.2024.10.18.14.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:30:38 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:30:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/21] Memory leak fixes (pt.9)
Message-ID: <ZxLTfBEIEpvgM376@nand.local>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

On Fri, Oct 11, 2024 at 07:32:04AM +0200, Patrick Steinhardt wrote:
> Hi,
>
> here's another round of memory leak fixes. With this series we're down
> to 10 test suites which are failing with the leak sanitizer. There are
> two patch series in flight [1][2] that fix three more test suites, so in
> total we're down to 7 test suites that we'll still have to fix up. So:
> we're almost done!

I was just looking through Toon's responses lower down in the thread,
and realized that I never picked this one up.

I think that makes sense... since this came on 11 October, which is when
Junio signed off for vacation. I think that we each assumed that the
other would (or had) pick it up.

In any case, this is now in my tree as 'ps/leakfixes-part-9'. Sorry for
the wait.

Thanks,
Taylor
