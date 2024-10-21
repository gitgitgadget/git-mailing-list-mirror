Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBEF1E0B66
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540613; cv=none; b=eo0XzM4cEVf3Kz3ZBR/EMbxiPUl/uiObY8cx7gimOIdX/m2mHk0XPSkuw2QW3fmol3nCG6XhgHZPF4EmsZdRxYWL99pp7bDzHft3d2Wn1JOEasHcO26FgffEYfAcuaJ1qfkHHMnAlNLozkJaI1cgHS+Xp5635TmnITIKNFwxuLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540613; c=relaxed/simple;
	bh=Z9u4lFv/DB8HiQWMxv6auomcNq1Ftv8du3rIRU5x/hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1iLO8d2ML2+24aCIYrsdhEHFk7Z+lpSqeewHX0BjsDc0lNA4ylmHtgNMj2qYBk7o5+srLcibMwXGaLNAsO37RT32sK9sIAv7CTBB7yG2Xrmk0wpXQaYVFK41m4VfIQDOB+fGLFyc+mO5bn4rjSjeJ6yB3mTk5ShDch9ASMxhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Ug4twSVT; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ug4twSVT"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e38ebcc0abso53038957b3.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729540610; x=1730145410; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oBRIcKjj7nXcTuTApF4U+wJZflDxQvXur/y4gRVCC5g=;
        b=Ug4twSVTuDYc47ru7mlEVwLgMFkBFKhmc5awvc5lds+yI/YKH8/C18r9lj/kulhj1f
         PSytkcJURs4NLO/4DT4lJP8jlqHb6Ee3cS6k6wFOFt/cQRA/mrSEvjJSmaENt0CsaYoH
         SLmo5ul2LK9oIgVCauC0VHf5RoSMwWzFlr7Sb4HyrO7SWrCLUEI2uoikyZbTeGVLw3rb
         0u9q46tXMENVeH8knA38bM4UIz7f9LmQ+bUeAbnk3sosSg64l0xwan9aCJWWDAjnBKef
         BzEjoIPspva7eLWBhux29e2sZbc+GHJK0vFK69CuLtgeshgHYHnYqkMNC8kWnPTjr4qO
         eOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540610; x=1730145410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBRIcKjj7nXcTuTApF4U+wJZflDxQvXur/y4gRVCC5g=;
        b=Fthay88BSwSG0r7vma4tp1Duy08TO1/ee1eCS5IfDq+9uyLe5RR9lLCNiMkaz4AAjC
         ORR+yp7uAnR/LxbePISQpFZqmXakHPRgw1cuPpN3zDE1NnFjElk60XaR8j8C9tkduBHE
         S/XEzdM6ajv0+wrGteRULVIUt1VRfhC+tIvmoK8LYk3p9fAO3Gpjt3K5G6D/ZdJN8sGS
         pedD1wmLa7R8Rkg0hDb+XoG97DKlduUXQiVVxVvYCNUqK7Sk4S1DkCW/HYAvjiu70Rz1
         Ooc9S9+C0oyop5zUCPNNrKEAQJ4U1u/oYJQxZvmbH/bii5uCPnctK52696sU54zdSKNi
         cHng==
X-Forwarded-Encrypted: i=1; AJvYcCW0Nrx5O6Ji+p2g0h+Bm7RnSuIS1MKXSK8UXNu5rOaVun66/TVLnKD2EbYnF8cqCmneoCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhVvtooWSQhampp0bfonmGr/PES+yErWZfC399HNc5NvXSFoRH
	f2Gru7XVYWMRBnDRjCne157EWDeTgzl6WmL8qjHV3j5wgaCVy0VsVYIcDqisXdLZXlFe8HYZouN
	N
X-Google-Smtp-Source: AGHT+IErsuIJ4kAzr68zBxR9/PGZJVKrWx/bLEkw4Nb3PXJDEvUwD1olia/Flov3kWVcTvzf4Y3j2A==
X-Received: by 2002:a05:690c:4d87:b0:6db:e4bd:54ac with SMTP id 00721157ae682-6e5bfc5d2a9mr131376937b3.39.1729540610470;
        Mon, 21 Oct 2024 12:56:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a619basm8003827b3.55.2024.10.21.12.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:56:50 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:56:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] merge: replace atoi() with strtol_i() for marker
 size validation
Message-ID: <ZxayARcJ1nBKt2mh@nand.local>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
 <5d58c150efbed1a10e90dba10e18f8641d11a70f.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHH-oHE7g09xIR@pks.im>
 <CAPSxiM_BCz2n-uOOSRk3AsVp-Y7R+1XNfVRt6dH6=fWVBZ6cBw@mail.gmail.com>
 <ZxaClmjrLAJiVxNJ@nand.local>
 <CAPSxiM9W+YcJqxnkFmOpBcHuHab6V_vn+ibwgq-vCNWZUXPw=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM9W+YcJqxnkFmOpBcHuHab6V_vn+ibwgq-vCNWZUXPw=w@mail.gmail.com>

On Mon, Oct 21, 2024 at 06:00:55PM +0000, Usman Akinyemi wrote:
> Hi Taylor, when I try to use this warning(_, I was getting some error
> In the editor

Let's see...

> erge-ll.c: In function ‘ll_merge’:
> merge-ll.c:432:33: error: implicit declaration of function ‘_’
> [-Wimplicit-function-declaration]
>   432 |                         warning(_("invalid marker-size '%s',
> expecting an integer"), check->items[1].value);
>       |                                 ^

Your compiler is correctly indicating that the error is that the
function '_' is undefined, likely because this file does not include
"gettext.h", which is what defines that function.

Thanks,
Taylor
