Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4999F17E9
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710554150; cv=none; b=jCe8vizuq15uoG1AtfKRpP7csZlukQydYsw9piAf3BbbAy5ZNsAM0Eu7zAGJkIohMv//osyWVepWho126XYe5ySGBt+vXYv5Y6HCK3lx6MHZdQC9zOsZ//22eSNStxD/gpVlKlI3bijS9WYX3oa/fY0bvQDek5hv/JiAD0JmEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710554150; c=relaxed/simple;
	bh=EDMLedOLGD4xlZDvtR7auiRqChR2xzrZEqfKDLrM4yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXyFT4m3nR64fy79cpx8fs4OINW7wAYs/wsC5AgP/XpwPRTf8RDFiEUuO8bDH8NVbjWtjKnnfSzFwXTriRcDe13hrREMDryd3tDRUhdID+xiYpm/zr3d2QyhGMZbAiVvQHdmuHeItNcwwcZmlJ29CU3ROTuKRzbrkOm3srCrbKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=uwmmIufv; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uwmmIufv"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-690d75c73f4so16742636d6.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 18:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710554148; x=1711158948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/u9sUxUzUm02yNcIS096mPfF0eUJHGAp7tO3K0NY0m0=;
        b=uwmmIufvRPyGciOxiqSLklIigAZjUoFxRXiMUFQMkfli6LPhVH4U6J9y8uvaXUxIen
         HH3mhDSnJnwJatJHGy95zxJpD4czOPvmulwIgSihjVHglAjeXNju+QuXDREF/pzTGoBx
         ynONxU0W6P6pBP4Bu5UHYbb0S0pcGP3RmqOHqo/SRAI/s/B2NFNB6C9p7C7utW5RKE/0
         dE83G2vYdRhhnFZv0bFSkrmuqZ+iKdjqDn7lpH7kyhRzlspv/3ePGaP4tFsfO4r4vfqy
         4SoPGhrMlw+Gh4KuIUcVIIvDu3TAU5isiRT/8NZaH3F5tvggyXdujnb+IPW3pZgA9TLz
         GHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710554148; x=1711158948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u9sUxUzUm02yNcIS096mPfF0eUJHGAp7tO3K0NY0m0=;
        b=iq8KAe2Zn4UbHsKGQ8wZAlvB13LEQmJLeszc8KFWfiKo6MfJgXU7xCzD4JTAH2xm9t
         q9qffPx2n5xZM2mHt32Q1uUoNJ9D8YZzypgYMFfxsMydpR1hG1uXwbH8iYxD1h/ZlbjO
         Y86Gbjbbe9ussDqeko3xLeletGVA+Ajl4jRGLEszYs/TAKFU3xOGk6FJE6puXjWqw18h
         ESmDITAitBVaxqjG0vPFzQUQ6vBGy8v32RwnscSLaa/TFZwg/S4Pa6nqlUbe0Iaf5Vjs
         eqqKM87uYZ0nJSSBibfBNDWC5ReQQryuJU1eaeINvsBzqO2gfEHPyhSBHhTiNemqu7wW
         pO8w==
X-Forwarded-Encrypted: i=1; AJvYcCWLH1zeve3CFbSn+zERYdiNMbYaDaZcxtE1UVI1l/SaAZD1wDq56KR2UELH37Y/sf2vkszYtXRPGqgxw4f7S0Ju/wJR
X-Gm-Message-State: AOJu0Yycv+kOTIOkOQrBcBsR7il4P/70gpryKOR2F2fzNJjZW5Tj4QWX
	XeOxOhte/P/2EqVhNGSMIrLyx0aKkDjQWtcImos4Z/DD9E5BQ+811Enk6JdF64U=
X-Google-Smtp-Source: AGHT+IEH5kHG/Wo+UfawNDAypqQjALcYQxR5BLyfjTxf/HfakqNA/ksJaTPH+mMzmMmN6RiTeS941Q==
X-Received: by 2002:ad4:498d:0:b0:690:dc3f:4fac with SMTP id u13-20020ad4498d000000b00690dc3f4facmr6826821qvx.9.1710554148187;
        Fri, 15 Mar 2024 18:55:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 15-20020a0562140dcf00b00690cbd296fesm2650349qvt.121.2024.03.15.18.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 18:55:47 -0700 (PDT)
Date: Fri, 15 Mar 2024 21:55:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: barroit via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	barroit <barroit@linux.com>, Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH] bugreport.c: fix a crash in `git bugreport` with
 `--no-suffix` option
Message-ID: <ZfT8I3eoU0dBQMsv@nand.local>
References: <pull.1693.git.1710260812280.gitgitgadget@gmail.com>
 <xmqqle6mdsw7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqle6mdsw7.fsf@gitster.g>

On Wed, Mar 13, 2024 at 08:59:52AM -0700, Junio C Hamano wrote:
> "barroit via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Jiamu Sun <barroit@linux.com>
> >
> > executing `git bugreport --no-suffix` led to a segmentation fault
> > due to strbuf_addftime() being called with a NULL option_suffix
> > variable. This occurs because negating the "--[no-]suffix" option
> > causes the parser to set option_suffix to NULL, which is not
> > handled prior to calling strbuf_addftime().
> >
> > Signed-off-by: Jiamu Sun <barroit@linux.com>
> > ---
>
> "git blame" points at 238b439d (bugreport: add tool to generate
> debugging info, 2020-04-16) that is the very beginning of this tool,
> and the bug survived 4f6460df (builtin/bugreport.c: use thread-safe
> localtime_r(), 2020-11-30).  Apparently neither commit considered
> "--suffix=<string>" would invite users to say "--no-suffix" (authors
> of them CC'ed for their input).

I can't speak for 238b439d, but at least in the case of 4f6460df, the
conversion was purely about changing localtime() to localtime_r(), and
nothing more.

The commit message indicates that I was blindly grepping around for
'localtime\(_.\)\?' without looking too much at the surrounding context.

Thanks,
Taylor
