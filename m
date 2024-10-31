Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8784913174B
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730405734; cv=none; b=KHvIyA6h2TiKVRJeOEpPH5iLyrcMVXFIDjYFJcaafhErffoUj8SXAmYVCajTHUFIjdvaN+LtxR8Zbt1oIbf9rcrSggZ0KnNsQwPNmwmx16xAHYcvC6YABUxYEgs5eSzKMUB0I5Y8MhqVa16OWQVZ4d4SNzjbl8nO1zz9t7ly578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730405734; c=relaxed/simple;
	bh=snm0QW0hrH+3+D7bENVb6T1BoLIi6sc8FE9mya3yh0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a22322YmHTjtRHmDYctXVd36VKmIDCe52zF5zwCGSBf5P1+/b2S1eeNg7ucHDVWF2YiKeZccYEd0QeqEL/M/NZQCfp1Q4TbJid7AG8CSgq4QgpM5gPVXGPpt88DKBpjsQpMq8FFWcc84yc7a38CASV3JfH12Pc9OhrPgxsmK4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ydayOZkE; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ydayOZkE"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ea50585bf2so15392527b3.3
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730405731; x=1731010531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3HVvKWXwMMhMdEw8/4LzFV+4In4aZGjtvHauqmdujqQ=;
        b=ydayOZkENzJD1YMbaIlcyFq15EQEI8UxYWJSCMJW0VSwV0Yywq6xTZ/gclEuUHWux6
         Ruk5g+x4sAoRITcG7rMGgdohBG/jy5X90vfw/RQQVsCL8/chvf4FnViWot4xhlyF5so3
         6FDhrpL4ay1a1bULsc34YySXot9AX6hiipbomsKJVfwHEzG8rwrqg9Dd0PYE4Osg7h2E
         HkLmrZK3G38Nk8E4AyZLbKuSGWT1j2rK79fKt/3QX2B3RUg1ldU8Tat/VshxwhFDJvk6
         HKIgkgZLaiNTSFEPHnmGVU0aBxNyOYEjk4/s1Lag+iM1S/aDhR45VsrHytvvOSsR0bLC
         UBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730405731; x=1731010531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HVvKWXwMMhMdEw8/4LzFV+4In4aZGjtvHauqmdujqQ=;
        b=TK5B+BFa1aONXlexiQr2+9NybR2wsz2xbo8pvvSGuTwT43HBz5qu34Oxu2jQOKHIHA
         VHHsMptk4BnSQ4GTRrcsxHkSN7LWo8i9ARrNmBduHBqt6Ta3zDsjBg7UMQyRCpl/e8Am
         zeIqwUlXYtXKp3rsjjzU0q2YzZwqNIsyDvJmOHqqQPHK3DVzeSNzGBgr+KzCy6XhOTIz
         LhmYZohGadslhtESDIVWQY7Nz8g3O7N2tzjrbNOFpZrDJMcgsWPmte8l+QM5VH3yA92Y
         Za1Ah1vnXQtDtsoDMkRhCUor0B/KmjLfa5viT7GFuVMglwHEHtJw2RbhyM7Pxyh3jw3P
         kv9Q==
X-Gm-Message-State: AOJu0YzS91hEwRp5JhFFTUNHQeICmH2LKTr8B+LNNxMq0idOEhDOWi3e
	4w09VbFd3nZBv6zphftBPc8qAF/B7jyZXIRtFdCAqBQMyvU8p7ZyNqBCh5LQl2w=
X-Google-Smtp-Source: AGHT+IGwpIqw4d7s3EzdJnoUCdff5HDAPe5VxbjBDXMaIHVzgecv3/gPZAH9/gnZaehmunYX287APQ==
X-Received: by 2002:a05:690c:6d8e:b0:6dd:bb05:3137 with SMTP id 00721157ae682-6ea64aecacbmr16126747b3.12.1730405731495;
        Thu, 31 Oct 2024 13:15:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55ac9d34sm3996157b3.15.2024.10.31.13.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 13:15:31 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:15:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood@dunelm.org.uk,
	kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH] t9101: Refactor test_expect_success format
Message-ID: <ZyPlYkwsFrxH+JwE@nand.local>
References: <20241031094554.68916-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031094554.68916-1-kuforiji98@gmail.com>

On Thu, Oct 31, 2024 at 10:45:53AM +0100, Seyi Kuforiji wrote:
> The current script uses an outdated formatting style for
> test_expect_success blocks, where each argument is separated by a
> backslash and newline. This style can lead to readability issues and
> makes it harder to maintain the script.
>
> The modern style consolidates
> the multi-line command arguments into a single quoted block, which

Strange line wrapping?

> improves readability, maintainability, and aligns the code with current
> coding standards.
>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  t/t9101-git-svn-props.sh | 48 ++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 22 deletions(-)

This does not apply cleanly on 'master', so I assume that you wanted it
based on sk/t9101-cleanup. That's fine, but please let me know in the
future in case it's every less obvious :-).

The changes themselves all look quite sensible, though.

Thanks,
Taylor
