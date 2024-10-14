Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9DA26296
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728942163; cv=none; b=OSSolOeq7uLzcLp/ehs0OYRTeKPY3rlVZrGUPMTGWKm5l2thHsqzGj0PJrCfWRWksYq0oHAWrTwV/ico72xG98Zdkpc2L8sW2X6yV6wZTMysUNtGvUSXqaAfBpqJvmFW+p+A+MT1jDFXEMg++9fcTV344xSdCR63UmwBa4nAOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728942163; c=relaxed/simple;
	bh=y1KFVAcxvb9KILUriuvdnsJeLz5xOs3mTRYKfVUK0BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHJF93+7k2UA2FKFqCbVfrx1vdFxStrQVpBEUdxJg20XtwZQuGiqHwmcvvysE49oAXdRdJCsFzXJJBjyMt6S998LQN1+QiZB1foxL3XLLjzowWahIyJl61sBKcfgoWkoSfgn4BAi6xhfnh84Ej0+TPySahSyGx/Shk5y/F4VhwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LDE6ihU3; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LDE6ihU3"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e28fea0f5b8so4185270276.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728942161; x=1729546961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=janTmEkWXXZrTy0Tm8V4R7iNXfE2uJLj47GbxpkGgGU=;
        b=LDE6ihU3ySwVwg+xxBfDu9lKnIQDGRZJVwL0wFSEcLDQm4hgghDQc+5pYVXBtpO+HI
         UojAwnr/op/HTyKAmKcgiAr+K4MetOS+GtgvcDR0qSOuRZGdrwF1MNl+KLXlFX0+0FFG
         DR6IdBQljgivNrSBujlhB6g7fDan7B7KSKvjt1wqrThYI1PyFlkAe+PQ63E31oYP0B1g
         0/GFA2s6NSVgpifUio0oZmKC5u83A+mR0ZEs7xkNlrPzxRRbAAdGQ/L55xa+Xlg9j5Sl
         afRG1TZ6EVfe28kqIETEIbiT41+/7J/so2Aj8hMXHh/BcoeEe92tWV6dbZECP2GfGoXS
         LGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728942161; x=1729546961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=janTmEkWXXZrTy0Tm8V4R7iNXfE2uJLj47GbxpkGgGU=;
        b=w/gOg7GcTnQKBxrJTJFvGdX8D5CH+pEDYDK8ZkmO1jr48ZuFOkwD6cXBXRpBsGd8vU
         U3skQxG57SPe/w2O/UzOU9qJMyXNN3EA4LejFwPixXszg3Pr1DVdB4Bz3WEWtm+Cc7Ix
         iY3ELA6B3RBiyu3p3H/XxlbZfYnn4CvCPgX4manYKO7Aqn8gVDCMeO/KHqDqLT7S+6yv
         pLY/BumYJ/PwP4juA0wWtTNcXNIC1hSmTa5u0j+tvB3GV1v9X9xoxscgbQP339ps2YA9
         3OWcr72OBZSlkzzfwPx0QaN5NO1XG8kFQd4rbWOemuakXY8WSqratHJrLnh0+2CE6+Gv
         Kxhw==
X-Gm-Message-State: AOJu0YzckvzYs+1mb3vhM8znPgDcwpeLcMjlBvsg2d0Ek3zF3dG708K6
	rIUMRZFIpKZuoYf1oy9issNgDgkclnCGT42YXF3bYPx5OACLZhrXpEiTvYhlAmE=
X-Google-Smtp-Source: AGHT+IGvvMFAQJy2z5fsBvCBNNS+sVmpu1dHiwsckP+eCRJfXRQlHQglnyWAkc5s4UAvQ2OkYljq5g==
X-Received: by 2002:a05:6902:984:b0:e20:c63:45d9 with SMTP id 3f1490d57ef6-e2919d83c92mr10715019276.19.1728942161412;
        Mon, 14 Oct 2024 14:42:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2920b13135sm2128861276.48.2024.10.14.14.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:42:41 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:42:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Makefile: extract script to generate clar
 declarations
Message-ID: <Zw2QT/Kx6IoPhJtT@nand.local>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
 <cover.1728914219.git.ps@pks.im>
 <346aa2f08307fb9c501a4b9ac3322beb44dc9d5d.1728914219.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <346aa2f08307fb9c501a4b9ac3322beb44dc9d5d.1728914219.git.ps@pks.im>

On Mon, Oct 14, 2024 at 04:06:41PM +0200, Patrick Steinhardt wrote:
> Extract the script to generate function declarations for the clar unit
> testing framework into a standalone script. This is done such that we
> can reuse it in other build systems.

Makes sense.

> +while test "$#" -ne 0
> +do
> +	suite="$1"
> +	shift

I'm perhaps nit-picking here, but I find:

    for suite in "$@"
    do
        ...
    done

to be much more readable than 'while test "$#" -ne 0' and 'shift'
above, since the for-loop variant does not need to mangle its arguments
with shift.

> +	sed -ne "s/^\(void test_$suite__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p" "$suite" ||

This part is a faithful translation of the original Makefile. Looking
good.

Thanks,
Taylor
