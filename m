Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE31F80D0
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754099; cv=none; b=LmRfKIoheJu1G0Ut44JeqwJKgjOzdH+Cb0unQZxl/L0SjU53B2KImwi8umFAI6Xg6kcN2PgjLXPo7smrw6uJbUuzSfdZZg9tZIdvcwnNTB13xG4fzBOvWzfUEL6/dkrTNUJPcA1zDfK/9lQ+xxjC3QQj8LWG4CrD1t/dxQeyQSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754099; c=relaxed/simple;
	bh=3930GDFUDQAZz4SkelGf4yEnmVp1NYQMd9+n3kxj9pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFtwWnVi5ZYnfsKBeHkf9gANHjC4tul6mxbaQHDsRtByvjq5MQtNESRePMiK2+MRwDsjaBFOjUS1GB2O/VaCXDdiFBr3a4aPnnJY8OQVw8I1RZqTPcyoK/a2ve5K7MuKD07TA1WcySslYDzeVVbb386OAv4qPnSkKsz3yNcNnlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=RZgU1q7L; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="RZgU1q7L"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e390d9ad1dso38605807b3.3
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 13:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730754097; x=1731358897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3930GDFUDQAZz4SkelGf4yEnmVp1NYQMd9+n3kxj9pI=;
        b=RZgU1q7Lbg8bVX2X6SWmYe8hXohMmN0Zdh+MH3+DeWlKnYoX8Aaz7U7kxJfUGOCKtL
         jE7+XsryLhPRSR+DOl5rP9rEK9zkv9qjL2Kimi3HSt62oLAHD2jzqh1PjSq7EddXc6KD
         f4sRjP/d8O8SUIU++lXXyGG/KmEbSneIz/7S/RQx507P6LLJngEbAvFNE5FMuO91PoJP
         yLg8JLkDKlHcuKx2Rg0D98EfmcLc+4ksxNJzjc2hDKLIRq0MNszDf2EGtSoRsBPcxRw1
         37/NY34HC2Xost7eVRZoUxBtX0TRMJPJhOkAii68Lao6nzBMwlQuYQzlJwFyMtSj5dIA
         23Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754097; x=1731358897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3930GDFUDQAZz4SkelGf4yEnmVp1NYQMd9+n3kxj9pI=;
        b=OihBMmZdTBIo6nuPGxlW6qEYh0xfNglisa7FCA4hFGsFGE+O0XHGl0gUc7rxwXruwU
         m0w6j8/59UPlPFytTS4Y4+1nG+ktZf+xLe3QYm1p3x2IoaCPSvEJQEfytFOzSOmAJUgj
         SdsyWnEAHDFJYZJDKGbqVNwaV108sDAOtUAWPt5Ms5wtFrwhNYDQJIh/m9ysnbcruym+
         FQgtxvaKW4ufeJByIfM1/CaZwVxc8RIDjiRm1FRoJ2R+BXYZwuxe2bA4i6Lnub4VSXCl
         oFyaNbzxHoxAwuMThmU8sSwDJ1/E3URA82mkI6qTOxR8ibjrFPzdcgb50zx3FjhD7j5n
         j0mw==
X-Gm-Message-State: AOJu0YzgfO5n1EolIwHPUl17eYYXfE01lXtnTFCk7RwPISQ0SQJlePRr
	u7ZTJNOWOAs42LxRcwWhb5jB/nzNnlz/eK2rQ7e3gJW2EhTi5Ll6yXPalRzKXYk7hPWsWhj93ok
	Cqj0=
X-Google-Smtp-Source: AGHT+IGuPt/vX+mVezdOiAt05FDanOiobHOYdRpzvNMhWUXfKRj7IOUJzQw6A/8b7id4bNxBEJmOVg==
X-Received: by 2002:a05:690c:6c04:b0:6e5:d35b:ca80 with SMTP id 00721157ae682-6ea52328e99mr178389427b3.5.1730754096821;
        Mon, 04 Nov 2024 13:01:36 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55ac9c1csm19129487b3.25.2024.11.04.13.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:01:36 -0800 (PST)
Date: Mon, 4 Nov 2024 16:01:34 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 10/11] pack-bitmap.c: record whether the result was
 filtered
Message-ID: <Zyk2LgKfwJ5vT3Eq@nand.local>
References: <cover.1728505840.git.me@ttaylorr.com>
 <dffdd794de3255719028a5f2c64d43048a5a5f60.1728505840.git.me@ttaylorr.com>
 <20241011083545.GH18010@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011083545.GH18010@coredump.intra.peff.net>

On Fri, Oct 11, 2024 at 04:35:45AM -0400, Jeff King wrote:
> I wonder, though: should thin deltas just be turned off entirely when
> filtering is in play?
>
> Likewise for --unpacked (though in practice I think it would never be
> used with --thin, as it is about generating new on-disk packs).

They should; that's what this commit is setting us up to do in the next
one, which does not allocate the "convert to REF_DELTAs" bitmap when
filtering is in play.

Thanks,
Taylor
