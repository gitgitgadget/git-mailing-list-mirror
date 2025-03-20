Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3286352
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514719; cv=none; b=QVdhzhfxFRhq7YPJCM9aZMPWHCMYuOzgHgEiRq28fXv4nd7U5y+4vYUF8lODgL7h6lwSiOvdkzdFyjOZ9cC23Z7eudr3Jk2Wu8AmKfrgNoQnlZP6e7EjkhcgTG+uaLGciwUY4Fp/Y/duLYx87Djbm06sqev9DmndtilGUT2NYDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514719; c=relaxed/simple;
	bh=quilwg5iEofFvDhBvBZ7bl93AUMMvt6dqcOfgY/zB4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ti2rJMrwYp83s1NhWT0wOEzBn2M0sI2rHO6OnB7BfewD1YsMXOkwCiYXkzBxEgyjce3loS0tUCJbwte74pEZeNDz2mRtBRidapX+dMvMltdITUqTtFgf9tXEfl7IIXGf1lWXOBwBdpMjoNGK64rqhLAwypbCTi89sFim0FqGch4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOuuTTiD; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOuuTTiD"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72bbfb6f3c0so719504a34.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 16:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742514716; x=1743119516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYr68NdXhxGMHYfQo8njiYKMvSnBBEcu9Z499gZ1eUQ=;
        b=mOuuTTiDfxAJE1TAMdsHrazXhMRyaWwoF0lJdoU1fmH3H2wdCZuxQeN3DcI/XpM3or
         koS7LlxRrxsS+Wm5lRLN3+CsfyerZLBA5MhhRvKaYiHv1+LKjDyZX23FD0qCYUYwIGP8
         FLX6kRbhEmiAUd1U30F+Z1fDJab96hg9mXUvJrIDHFHhtL4RXjuImBureTHqiVMRE4mT
         nPvSXl9VHOm9ybTJ77drkQGy0uR0wDw5lyMtUl1GjJ3WpS4XTWH//ZNLLIQPfwRvs1LR
         mGT6XWelO+aPNvMaT5nOIIUPFi6EmabrjFSBbH2NEm7kTZrhjGVqLj9uMtKjwWgcM7tg
         z0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742514716; x=1743119516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYr68NdXhxGMHYfQo8njiYKMvSnBBEcu9Z499gZ1eUQ=;
        b=my2n+7c0ZBHjbjVgknevXe1Ph23gmkRKwPBsRJSPAgSirm01UZEfMLTuuu6PsEyVXZ
         tT5OHQnxgU2bf0DipqHeacEaMN5B0pXjCKQ2CKXuXVjTXFr0k0CUcZcyq7HtCTF9Tc/d
         H0VNL1u8bGyDfdznGPXep6j8iPvdhoE1XsT+YVbUEPrmme0yxYVR3kB6CpfYBqttMkXe
         ahdEWUTh5zW4cLqq3VRXHEIZffY03YQSF4IjhFGXgRUpjV8eQKhadaDQS8s2BQTcx+GO
         RLWXbukcWDn07RDjkB/nAZqE4EppnSa/BDeocRf6u2ys9mpfoiGyD5JtronQvxnLtZX3
         ekvQ==
X-Gm-Message-State: AOJu0YytqQs+vTg4bOvBP/LjdpX40D+PiZ68OlkArc7jc3xOdATi1NZJ
	3Zkx2mKk7TumMcIofyjJ9HNJloDjsabgYYUqvh5k1YE0WvTKth5Q
X-Gm-Gg: ASbGncuv9J7Y4pjincprOWx+y7UUPvi+9WDI9c21nNvZLBE3TFb2v1IPw+je6tSh688
	tXwJ330W0jho9dAvTbGw4RGFlIHDTGw1oy6NRSGTzP0r02Xle87eSonvWU6fjW3VPckjrAWR7pW
	bKkrWG7XsjgWwEBi6yzX31gubviPZcer+rbi+tu7JqRfTQTpxHwNUMepJHA2p+cfCIlowb0rKLd
	q0/Z5jYNbeTJD1i2JRbzRx1gthYPWdxmP8J4wdKbwwheC8UINQlqyEl0xDGd4mEoPnLq2AFGfIW
	g6nDwWaXbMsXpc/zWodYLHAXsKfbmz/L0A6XYw==
X-Google-Smtp-Source: AGHT+IHSk5g79b0JfhOwbkNdVEyOHnxgZHnL/XLQZpSzJuMq9JskXK1aSN1pa9g4Qgd5cLIFoICX5A==
X-Received: by 2002:a05:6830:490a:b0:72a:1821:aa9c with SMTP id 46e09a7af769-72c0ae6a168mr1072409a34.8.1742514716225;
        Thu, 20 Mar 2025 16:51:56 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-72c0abb941esm161958a34.16.2025.03.20.16.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:51:55 -0700 (PDT)
Date: Thu, 20 Mar 2025 18:48:21 -0500
From: Justin Tobler <jltobler@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 0/2] clone: suppress unexpected advice message during
 clone
Message-ID: <yyeid3njdsmws7rl3kcsxne52fuadd7q4emqdlvatwvcrnyl42@rfnk26mvcgoa>
References: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
 <20250320014646.2899791-1-jltobler@gmail.com>
 <926210f4-a8ff-4ac2-8b7f-85cd5598d77b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <926210f4-a8ff-4ac2-8b7f-85cd5598d77b@gmail.com>

On 25/03/20 11:10AM, Phillip Wood wrote:
> Hi Justin
> 
> On 20/03/2025 01:46, Justin Tobler wrote:
> > 
> > A side-effect of this change is that the location of the first
> > `git_default_branch_name()` gets deferred to a later point of execution.
> > This matters because `git_default_branch_name()` only computes the
> > default branch name once and returns a cached value for subsequent
> > invocations. After this change, the `git_default_branch_name()` call
> > site that actually computes the value becomes `guess_remote_head()` and
> > is configured to always show the advice message.
> 
> Isn't the fundamental cause of this bug that advise() ignores GIT_ADVICE?
> I'm not really clear why "git --no-advice" only applies to advice that is
> guarded by advice_enabled() when it is documented as disabling all advice
> hints.

From my point of view, this advice message should never be presented in
this particular scenario regardless of the configuration as it doesn't
make much sense here. This also happens to be the original behavior so I
think we should probably return to that state.

I was also a bit suprised to see that not all advice messages respect
the `--no-advice` option. I'm not sure if there is a reason for this, or if
`advise_if_enabled()` just came later and not everything was converted.

In general though, other users of the default branch name advice message
should probably follow the `--no-advice` option. I'll add another patch
that does this in the next version.

Thanks,
-Justin
