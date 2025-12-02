Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BCF2BE7BB
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764702270; cv=none; b=FDFvJJFl8kIiarmJJQ7s1i567J5kWgvBeYVjmpb8i5/LoKxTg5l0CQStwzKINO1/El8MTkIrdrPevdMJfVcbhJc8yNX7zTk8v7DZGHdY74JHhKRTBgpBB8aGgzbfx/kYt1CZrGA1cyZoL7YsNO5X2372kY5MkNHVtWf/9xXTHJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764702270; c=relaxed/simple;
	bh=GdGmTLhHUPBX94Z1f8zsheoPajWr9iUlw9ZptUELwGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKMMe/lRFgKbZ2144lomL3Uz0szR0C+COBx7DvoJp5vpzd8YN6fUHWF4++Gu5d7ebwMzAaD5B2R12HdgKdh4xQw+66XyCLLhWTfCXLkRLQAxLRJ6T92r76nFzeTmjCwZ5vAlKoO9jIrKJY/2Vc7N7cER5XU/M1MP+6WW1R8Sbh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U34B/n85; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U34B/n85"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2e2500517so104442585a.1
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 11:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764702268; x=1765307068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GdGmTLhHUPBX94Z1f8zsheoPajWr9iUlw9ZptUELwGM=;
        b=U34B/n85fchKYWQ31SO8H4+9pP2ezQEi6f+NGzTaRLiE7KxI4HbtzSIVaX6XS8UC3q
         7CdqzvAEwnwluEgks5oWP8kfEUX+pft7c5KCoUnK7e+PCk7P8NDPjsF8IE82E2S8G5YS
         ffyrpob05BNxqebgSdwSAiZj8s77RtBIDrQBTy0DuI1JT6WGd0Ds7g8DZr+H30x+ZhmY
         mG5WLhVaxBfBuf0B+Uh7qVa/VSZ5f2ngA75kzKUxYAGtKhcQmisjFRpFR2+2SHWpOT+0
         UfxhXEBf3d9KAHunYsH+JDR2nOgcRgvvZ1J4etVOhFDSSMcPK2eyliRRuAz+X/JYKX8Z
         k2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764702268; x=1765307068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdGmTLhHUPBX94Z1f8zsheoPajWr9iUlw9ZptUELwGM=;
        b=qbzA4yHqkyvnNDVWx2JE6t4NSlH1amYiQaWE18KTE/CD92Y5lmjGAMAv6RHJGN47Wy
         3OjPEysdFYeoIBD2yB3pc7IZLfibIkIwvXfHpfaLl27uX7ivrpmdKuGe+wQzgldM9eHP
         s0ceV7jfVT9wyclrZwChGuD8hBDpNdopkwEO2RXyGJ6JVJtaa1ZTSd735dh7I6Zs7VeU
         FoCV0GlAdtsTjPNBlY/V5xbcLUvz88N9p3aUx68TLUS5djwvQ29pDGgoGBWTV/Sw4cbZ
         dx1+LqA0S7rQ7oWmtMgJu8YteWyg/fiU+Pqel9ITBtcPFaSBI6CMGfF9UxdtSjjeaiJ5
         +BGw==
X-Forwarded-Encrypted: i=1; AJvYcCV4Qu5MrMEv2E02+VtPSgfWjqY61MJcg0m4LmcNXkQfvjLVhStGea2V8wIRrbGmIhC+YMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZED6COTOeDIvNndzkO1B7Y/xlIom3xv052jng7Fx8ssyGD9sJ
	Cn4HIUInVhTT9riBlefHDGde+zyd+kOKzwC55r1phXSem7KUbi9BVz8r
X-Gm-Gg: ASbGncsKt6b51cz4OgPRSXTqoGNUrjsyP2v92hQwirmZIySIp5eaXI8/Xo8pvdclVeC
	mQjf+u0XPf6pKgso081uqnR5g7L5kuheJUnSMQD/2LvctlGHn4IPl0zcu8rI9aMiry5DllLvAvi
	si3a6pj+2//eWxG51lrdYoqycFXuqgYfG8FuL5/g8L/EC7+e7cwknb3WM5McK/2znB/S98M9ASd
	B6wNFaecA/niRp4Ks9Yns7i31Rc9hJWfXqtkvP94GmBHpAr8ryNto/BX9kz56XOuOX1PkHtNhfA
	aZ4rlwdf6g3TEz9D4JsiVPOSkRKYxEf9apt3Aa1j7+U2YQi4K0dIFVFDJa9rZXG7+btndt8J4FI
	wGypfK+tEgBX5Yqmy6pUBF1E4fwH/mC9phw0rOgAN5AoicKC45mFOZmrY2T1Nt+YSVGquXRP0ib
	U8pBkCzHgQeyw3RA==
X-Google-Smtp-Source: AGHT+IGdJuNbDYBmCQhQOEA7jKDRM0oPHfXN1aE/ipuJXWrpb5jlTxtVhQOxnCqrDM6ueW2p2uyP3A==
X-Received: by 2002:a05:620a:1788:b0:8a5:2246:bc29 with SMTP id af79cd13be357-8b341d31cd1mr4416071185a.8.1764702267731;
        Tue, 02 Dec 2025 11:04:27 -0800 (PST)
Received: from desktop ([194.127.199.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1b6f72sm1119063685a.29.2025.12.02.11.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 11:04:27 -0800 (PST)
Date: Tue, 2 Dec 2025 19:04:24 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, gitster@pobox.com, atthewhughes934@gmail.com, 
	johannes.schindelin@gmx.de, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/5] scalar: remove stale config values
Message-ID: <zbmzxqckpmf3h2sc7g3zvrhcyur2kmanv5uz6nyd2lgmi2it3b@i65jeyvcvqqy>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
 <8783db6153875deb52aaa354da189ae611de1057.1764607847.git.gitgitgadget@gmail.com>
 <ciegbs72xbepxawuf42pne7eu354ntbok5e3p6jxcuyddvaea2@6ykt3iej32xt>
 <aS6bCU19x-QM84tp@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS6bCU19x-QM84tp@pks.im>

On Tue, Dec 02, 2025 at 08:53:45AM +0100, Patrick Steinhardt wrote:
> Wait. Are you saying that "index.recordOffsetTable" behaves differently
> based on whether "index.threads" is implicitly enabled due to the
> default value or explicitly enabled via the configuration?

That was my understanding from a cursory read of the results of searching for
'index.threads' in git-config:

> index.recordEndOfIndexEntries
> ...
> Defaults to true if index.threads has been explicitly enabled, false
> otherwise
