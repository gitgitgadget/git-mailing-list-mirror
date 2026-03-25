Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16133291F
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774480787; cv=none; b=bN9mPid3BPmxX5rQ3yL3F9Gn/Zh306oiIJBo72+BMpb/VMnc+tnzbSrLjjtO7yS0+G3rJFrH2b3U3+Nd8kCPbPmJ2MGKgWLN15tOkJwV4bvFSUSzXE1Ry8aREe74ZH9k24N6G1rQ2xYdJtjKyWW49mOWSRejZ2cwv54v8xDrkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774480787; c=relaxed/simple;
	bh=wPZaCpOu3/T5GcGEUGsyokKrIhBLKQWRSVKNN2bSLS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvfuwXfQLVkjMkaDu7v0NIoRu8Y2VieZdWew2aT79M+RITxC54xyPJ5PCNLOnVkI0hzV4dma0YTkzq17c26AFgbp9T6En7neBCRMe3AE284YYZkaueRLDIVxja31RzOLAusMyjgpbyr2L+CE3w/4v0II7nVinIZuIRujJ8Xvodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Hx6fwmLK; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Hx6fwmLK"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79ab5fd969aso4617077b3.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774480785; x=1775085585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRX/fMoQGvyPAygZvcvaLf3aATVavyYi7axHDsUWIx4=;
        b=Hx6fwmLKkJ2UsIW+/4YCznj/McTDcB6As5KOCcN1QLqP2n586zqqDNqa36aHFJXd0P
         zHVJAkX/gPUJbByrhXHIxiDIGbGBgfRc2pmVDDvLEhIcQaa5cZuvjGzLtxyemIxv/JkU
         JQnHmV1x0c9yWfnAsGR5W1Fwz0b12z1uHsFpVhT50wi5CvrhesFiCbgb2ln5iYC4fvq/
         Jij47OIkQcBG2hA7KfOpR8oKF2IsKRGly0iaVsXcTkxRetL1IoPKOwXcZKx86naKzoYn
         Dd5AijY7uZkDvWAY/uqGiLrqKFyeq5t08398mwaUxI83EkAm22f/9HnIs7TGttblDHdL
         4ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774480785; x=1775085585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRX/fMoQGvyPAygZvcvaLf3aATVavyYi7axHDsUWIx4=;
        b=TnnOTF5icZ0kDvFEOrtIcQgoWD9jFrtXQtz56CDLYjQnevmK334h99IpNGEKdhe/l7
         yj4nV7vDzP87UY4/KhYH+g1dJFkQCoCRk3JerXDRUAP9utiiPyTQ6NcX08t/eZGLUOB1
         nw24SyXUengV9ERjPrXwXznbXo97G2UI1YV3zkM7gZOqztMVO9LMQEw3TnhaxydiRYCH
         L+1hJYfNaOCSx/PeJaEDT/+mWPDD59QKjEylsFxEIDt/5lJN2lBBYh3LQ2oYsj1W1waD
         ZFtV6d4IL4MjkOaq/xhpiCgRwlw9ZrvevmKhSEOBh44Zxw8FT+MDz63orf89lNJxLB4q
         5r8g==
X-Gm-Message-State: AOJu0YwQ+4Lsqe+TScV+J5/upeSmqsZTj+5o4vc7+Ob+0/UBRVxmWoOr
	TRmaPdCPHKQRKOiCRy4IQEEqB+9vXx0+D03KRyWfJwKhm2f3W5vUqOR6089sgacUD2w=
X-Gm-Gg: ATEYQzw+5eqkdP/8pPcWGyLe518u5elYaSXlLB1XoKT+uYJDSKRN4qGFPBO1rbyrKKJ
	1+LoifySVfvaWd/Q/R/xNXZ9EocqEFmsYG3/SqXknC1YrfImtTbino7wMsokfHyTNj9OYNdpat8
	Rjom9Le/pSbdOYsqAOjsRQzQQ56NlnfFH2FVXxdOwN/mKsALGwMTeGXti71iilGgrlG/ycu4/xb
	7lxYYeNfCsb4+S2wuZb78vuqiWTHvH2fkIScSSZZwPfy4APXoOx8CKbt8A0Ahmng0wDqSAmrgmU
	JLhbXAY5PKTuxaSVXfYe3bnMkogs2AIfmZCVlhtmopkQCSRtjKca8vQrTXc5OQdImd6GAezMz3D
	H7SgQtPl8WcAPniLPcSleDXDLpRQ0hzC4iKojhzC91san1ZLWYR/PnlJ4RWEevQ7qaxcoiIwYd0
	BXhXsFqq3GxpciLMlCOHueffDEJAyzatEZJsJpOjpD5VPwJFMyB762Fzpghi6oljp98afAwOQbK
	WYh7DZZhn0xN+gOHoXu9k+w+KBUzA==
X-Received: by 2002:a05:690c:3387:b0:796:3e50:77b with SMTP id 00721157ae682-79acf2f1122mr57714367b3.6.1774480784948;
        Wed, 25 Mar 2026 16:19:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b1e412da7sm5017077b3.42.2026.03.25.16.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 16:19:44 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:19:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/5] pack-objects: support excluded-open packs with
 --stdin-packs
Message-ID: <acRtj1ZualwdKwjz@nand.local>
References: <cover.1773959041.git.me@ttaylorr.com>
 <bd78919e19cfa968556ad4241391120ed56e9dce.1773959041.git.me@ttaylorr.com>
 <20260321165711.GA718452@coredump.intra.peff.net>
 <acAwZ1ARhvsTSpO5@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acAwZ1ARhvsTSpO5@nand.local>

On Sun, Mar 22, 2026 at 02:09:43PM -0400, Taylor Blau wrote:
> It's tempting to add something like:
>
>     if (!p)
>         BUG("add_object_entry_from_pack: expected non-NULL pack");
>
> But I wonder if we should instead store the result of calling
> `want_object_in_pack()` into a separate variable, only creating an
> object entry if "want == 1". That would have the effect of *not* marking
> objects as traversal tips if want_object_in_pack() makes `p` NULL.

I ended up talking myself out of this.

There's no reason to call want_object_in_pack() early, as it may change
the very pack pointer we wish to use to determine the object type of the
given object.

Once we have determined the object type, then we are free to call
want_object_in_pack() to determine if we want to add the object to the
resulting pack.

Thanks,
Taylor
