Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C37933997
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729195722; cv=none; b=Utfl3VJSTY+4meEiBKKEuSe4M68ngbrtFjLu1ikhNp5FxgLeKU9gm+1ZdPYTjm9JgZ8Ppk9TIrcjUvuSBFbQSkErfkosjoaT0LqzTOzyVVWuiAiQ5gsG5Uq5nf63J52+CPUK1wAyAxUKFqJbqBFjTKnoWqtQPok+9BP5e1+KqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729195722; c=relaxed/simple;
	bh=w4ksdkLXOxMfzkD9CCW093gNc7P+HOgoxXl6Auun2P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhBuXDx6dwn65Y+VgXiTHo0WGFwdInBjzfELKXrRtFGRevXJTeQ3PUxeCDcVMhv0t7MVdYkb+C7Et/rL+kphB2U8o+Q0Dzj3O1fbrByxFARFNcJgCSXfl5VtUNRBuxD0rH03dX1tMpU1JX9ZHldjW9ebLqSWJ37uyFQ5Spy5mAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wXcy7CWa; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wXcy7CWa"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e377e4aea3so12863657b3.3
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729195720; x=1729800520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4ksdkLXOxMfzkD9CCW093gNc7P+HOgoxXl6Auun2P0=;
        b=wXcy7CWa27hSiukiuyeodJd2EgMzeLFMUJZkCfs8tNcpoRzte3ju398/zXKLkEoIRw
         xc26p6bzZhBk6oYlMGkdOoLbFUaB+kdFPKFAoppeMK5hOkfCDOhAu99m8Q+vcheLuRnq
         7kJIoRgEde2PDBEQ4B3RH8UWLT+lom3G0UQp1WsX9zjU05Nyi50+RenQ8b4gsQhmbAXu
         ztQvmWMTEk/9Rdw8plTcI8MjGZrDYwViu176gBiptVL5w2wKtPYw+vtu1BwE3CP/UXuG
         uJC2KAsPVC0HwbhWBZktfVlnAm7PjyF8NrTsUrGlCDKOUSNQ0f5P3O0T+ZG7Z0XauW4x
         5OFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729195720; x=1729800520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4ksdkLXOxMfzkD9CCW093gNc7P+HOgoxXl6Auun2P0=;
        b=kgr6NxYfVNLaJ1eSzfd6vrJ4PiWp7lLE1UArJlAp7y+ul7otT/MnEnfCUDHZt/sVg+
         k+qe0C11t8AMb0oWHW4eKvzFZLG3CkW1Jx8VHyfXWy7uucU33t5gXKC1//MyDyax5iOO
         ZzMT7o52XpDaBj0KIP3uoIeYg0OdzPJT87CdhCyBFDCQQq4zwiVObHZ7/Q0DiHBtL8yo
         Ty+3Fbgwou1aCQDM4ICblEugx3TFry6NKG2cVn+CSlfR0VdMGWJa5jSFNUmxfPFWZYjJ
         SJU13FhtkzfH7NSE0VufpglFaOrjL6aHFRTquIGzXqMRl4tgWCY0fdqfX/1yJSh+dNst
         nggA==
X-Forwarded-Encrypted: i=1; AJvYcCUx+RVXR3VH5dAWQNkeSe6kepbI5gpZNFFL1TyEazmxqjjXYT0ciN06IqsgruwSJXZqfSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFo8VnYX64WJDQAB7ATFhNlMTZbVaBXdnv6kMEBvOGy0ke3Pl0
	pI6HXplR9gWyFb9IzjhC5Ltn6DG9yDOEHFVWkL4dLNDDSroBOA5dxp9Nz1j0eww=
X-Google-Smtp-Source: AGHT+IH9wVP90NmvAr4pJ2Lp4FDBmARwx30Iu/TwbaVC/1Ot597BjGLfX8RNtFjHabZol/q5cA6z6Q==
X-Received: by 2002:a05:690c:ec3:b0:6dd:d2c5:b2c with SMTP id 00721157ae682-6e5bfc3f2d5mr2192267b3.4.1729195720047;
        Thu, 17 Oct 2024 13:08:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5bffc69dbsm181817b3.9.2024.10.17.13.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 13:08:39 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:08:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <ZxFuxanlnQCHPial@nand.local>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxEXFI80i4Q_4NJT@pks.im>

On Thu, Oct 17, 2024 at 03:54:28PM +0200, Patrick Steinhardt wrote:
> We can do something like the below patch in clar, but I'd first like to
> understand why your platform seems to be broken in such a way.

Thanks, both, for the report and investigation.

Thanks,
Taylor
