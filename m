Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3D30B524
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 03:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772161636; cv=none; b=D7jRX9ssnVYeSBULZAcL2brQULQhrp0iEUc5PHKjHD2PItXeuKNziZNkZn3AEj8ZrPz8WEHH+yAz13HO5f2fCYEUyFmt2hDaPejRBVsAKi2Kz/O8IwATLSrrolhtlEaUF2Wec4hY1+qLHEUPwmzPkIodnVc9dVhZCEmePgKJYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772161636; c=relaxed/simple;
	bh=AguHQe5dbzUK6wqwwN3lcHNOc4DPQb4k9ctgHtiNMdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqOWh+tSDwHVlKZoHaPdWjobR/VvqkibIAzZFsX6sFXlliGClYFiyULk+31nQvRZc5JuthFkn1wt3DWabf+7STN/Eo2PYcOR3EAqLjWh817vtu9HG9FsgbJR6rCyFLj8/3KXhJOHwsV1KU7JeEqwVuLXWRyriWrpNSxiOTJXnCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FIhnZEqN; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FIhnZEqN"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7986e0553bdso14642267b3.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 19:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1772161634; x=1772766434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mMjNdhFK9jccEFDqjXIYSG5etWA7MGQjhCecS9dgHl8=;
        b=FIhnZEqN5WOF3xIxCab/oIKWTW1nBjr+Ag8PwVU5nsSR+Eu15eKf8Gm4Q8eufulntX
         3fECnDCHtXjdiP+kOBv5H6hMWvma1bV2DHHJLeSbT4jSpdZzL8WC6fg9naNnbiv/zmpn
         Q+8ECho9eivjZIXub96IFFDZDhpX6e0mIKJVQVibYlZukoWJlU3QWkJm5m5Uiwf8Q3dl
         QdYFYEPnjpw0bjopMbPCESoX6BBjp44zxorh4wvIMNXkXAoDAliQnPP3OBOToj2w1ZEa
         qDtfTFjdeyQVQE4eIT0vN4viJGo/oVnuJ8b+tjqxOo4EUIu0RvUso44ZmYJK7fuJ1gNm
         ysoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772161634; x=1772766434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMjNdhFK9jccEFDqjXIYSG5etWA7MGQjhCecS9dgHl8=;
        b=SULaT7EF3V+KfZLuNeKbox8PrDlRioFf0TstpshJF69UCe5cLcY296cey7SVIMj3Hb
         +ZAXwk7hTZ2fBYj64H8/7plE+khqXNi/H0BBToSWpfGBK8S0sfcqboDhxwumVWYPb69g
         VFTt6+nXMrZXrFtU3eqi4M1ZDilZdOWJ/8qFGxwobqtQ00iSQAAnDE0sVtmkyFdCtbfD
         ANVwvgMMIPKhoECan0elMF0gUPAnw8YL/PikWLIYYM49LjSRush0CpnnJ0Drju/3luzc
         6hezXVmYyd0oReGOmIDiN3+LdbvN7Dzon8JiJQoiND/L4qZlMCvZAvyZsmVXfw51wYNP
         Zhfw==
X-Gm-Message-State: AOJu0Yy2xy0GWZU1Owm5Ze15WlnC/5sOlKdh7XI9jPiWBBt/QuwLOYUA
	5ynKNjffJcx7Uth6ZyTZQRLtnuVvWGt3WipZW/lBew1BE+OEwNcf54xO8cJX6bXgyO8=
X-Gm-Gg: ATEYQzx/K+VnvA/lO/Uo3AYGUtGbw5XaJFNnb0ynbySYSJDf53wQCbDQIsB47JvpiDC
	nopCQsKL93ZO4oZWtMunr3zdJIcneM+TSF5J79OhPyzg534uQNVza7qWeFS/Kp2voyIMrsADSiO
	YoaqAOkeuCfqKB2o4Q46gs6chJz9aSkmEQJim+apcsne/JHhmkk2z8BqcFiGxxySGRxUKVNtcto
	vnLoAwbBOq2tErpMlRux+6WMUqdnozgFssYXM7NCWoWgtAANDybYnC9p5wBSOt8cleBsA7Dqhvm
	NJOhNKlPqIwqwrJicQlwzZXtUPIixVhPZm9O09Aw2U1y0Slh49sl8wGkT07HDJwlXlBdO1GyFM8
	WyNj7BDnK6tQirKKRo0rCPy6GwdI+wuLTkgPuS6JTLvdpAS9P+IBXmSNFRBWzB+0w+gjp2+19sB
	/SbwF4Ej/Q2DSSk/K1fGcAg2Gs92/DFu+9qPlHBw64T3Ya+7KFaiZGEuzXhsiHfB1b+Cr6y82sk
	RkdP72lNjynxW3GirUGnkY0/Df0CQ==
X-Received: by 2002:a05:690c:4441:b0:798:4fa4:c6a3 with SMTP id 00721157ae682-798856495a2mr13069157b3.62.1772161634231;
        Thu, 26 Feb 2026 19:07:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876a8fe93sm16387637b3.7.2026.02.26.19.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 19:07:14 -0800 (PST)
Date: Thu, 26 Feb 2026 22:07:12 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 02/14] strvec: introduce `strvec_init_alloc()`
Message-ID: <aaEKYGWi7nd1VLJc@nand.local>
References: <cover.1771978829.git.me@ttaylorr.com>
 <50efbbb0fe8d897d7c4cd51489af4cb4c4c49d02.1771978829.git.me@ttaylorr.com>
 <xmqqh5r31byc.fsf@gitster.g>
 <xmqq4in3xlvb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4in3xlvb.fsf@gitster.g>

On Thu, Feb 26, 2026 at 12:58:48PM -0800, Junio C Hamano wrote:
> > It is not satisifying that strvec_init() does *not* become a thin
> > wrapper around this that says "my initial allocation is for zero
> > elements", but that cannot be done easily as a strvec that begins as
> > an empty one has a small optimization to avoid one-slot allocation
> > only to store NULL.  So, ... OK.
>
> Actually, we should do the same optimization if a caller explicitly
> asks
>
> 	strvec_init_alloc(&array, 0);
>
> So perhaps we could do this if we wanted to encapsulate the tricky
> bits in a single place for maintainability.

Ah, that is a very satisfying change. I like it and squashed it into my
series with your:

    Helped-by: Junio C Hamano <gitster@pobox.com>

>  void strvec_init(struct strvec *array)
>  {
> -	struct strvec blank = STRVEC_INIT;
> -	memcpy(array, &blank, sizeof(*array));
> +	strvec_init(array, 0);

I suspect you meant `strvec_init_alloc()` here and not `strvec_init()`,
but I applied the change and adjusted the typo before squashing it in.

Thanks,
Taylor
