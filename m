Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994C394E91
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781645343; cv=none; b=JoJJkLOOjrz/Z/wSC1OdzbMXRYZ6jnuXlwT6qD5geBWOjMFVBFvxrzqf0e3foeNjWIkY79cOVCBqLi+Y8tkdqm04u/n+DGkDup/RQ0RkYMhJTXra6A6q4HP02QGDzFVcCEstVGS9CHJX8U5bXUlOL7gfS+xWb6Xw/k2P5+Zz1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781645343; c=relaxed/simple;
	bh=2Z7X67nmAHy5sCCPINMPlDm2IJLYExFqP9MBVHBfJ9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbF9Q6GlAFFtjxQZ8X9pow2IHa0mjFAEHAu4SpsZn+YRNURu8T5EIU38WvZx08znBdUkpPDOL7dwF4wf3I5xwppZ3Bt0AxZY+toremtXpNbYDNu4NsUlL9ZrRhvYSqB61MTAtX5VbU0ZZPz1Ff/BTHKxzRJ1N7P+0lydNP6SOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s63WzaX8; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s63WzaX8"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4864a8e80bbso2589934b6e.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781645341; x=1782250141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w1adKW73pmpDkIrgN/F5V2N3ZnHCNu8vF7DTE5CfzbA=;
        b=s63WzaX86dUoLS3XmwDPPcqrP7nlU+Mx71wIm/4K2kmeWUuFHXAAw7UnhYT0c+YZoH
         9lvXUsvJNhYSi1qhuBPAqE4jWltxOqXaCsDJ2f+a8A/118KuAewQeObji4+Oh/hs4FTt
         bClknj3Iq6WX0ugyoTZmDgl/WcBcDH1khFb8hsBtgoQba/+0i/3fNKwApkM1sjNaXBhS
         NQCGZYOp5xGIxTj3tl+xznYaJ6QRlAqEGowRh/n0HrJvVYttW3sG9BLj03dhTqfR8FiE
         ZkYlKN1HXSDsFxxQ0H6Gl8rBCgn3NpmLPuDmAnrqWJUWpdpkMcQOx7yxaa/HIfNs9SYJ
         8Mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781645341; x=1782250141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1adKW73pmpDkIrgN/F5V2N3ZnHCNu8vF7DTE5CfzbA=;
        b=VE5dabR5QqumffpA+994F5Ffmw9NwhX9WjPRNON+8txBsZXTIIvaa60HSg7bZLA4H/
         utxIluP5ArJ07YpnVw8ACYqeX5+bFyyZUEvPGWOrHb9Ng8fzLdP1Bi7pb5hgiB+qo4wD
         W81BHbKhuFdxnxoQyjIwUWpuAGBuXgnOPX+pTTdCdl+o0NItZoABbZ0Iid7FNdVK2k4x
         Gjbu+Zl9BxijBz/y3KwAD5F3/F7Djf759Jtnt19SoPYG2ULrETA9Q34igYu3ha3lmyKQ
         s573x8o6/g3cyVgt+IGZA9x/HyvD2suEFTmqcXCnL9gwyZ7E4JerdpxfRlc0SNUvxmLF
         hv7g==
X-Gm-Message-State: AOJu0YwpBIul1S2WqAKWK8IvD90DQYBFBZcRMQf6VDSTaoLrVgkiSKHI
	ASN+epMycFHnX95Kp9QYTHKYoIWdutahSD9DaWBtoNuDNO9aeDIlylB7udNVYw==
X-Gm-Gg: Acq92OFhN1pXxgEG9kri0TocdNu0zUFTrs/u7KWmE2lSDGpZBl4zqXVL+bcIPYA8BxK
	Z5QV2FYQzNDrjdVUuCBtB85kCuBqmJD0aO8d083U3bQj6aLindC6ni/LqiVRFZAVuFgmQxWk2NF
	X8M//ngpoVsD5sB3yuHwAyQRfmDI8TTzuCOLsaNWasv0koVe9Vn6WuCDldk1+XkgG+ArrdGlXTo
	PWqkGsw7XIyF3h1l4P0wyseLjDKc8Wy1VMTtgs5vC0juYJf19foE8O+1aApcDcZuAl1jz95lJyC
	uiSRIQKr6QnCK+AtTR1hZ7Cz+lmcG5s0DItVf2K6iqYS0kOeOa1lF7ziwEC2t2lLqA1i7giAFIM
	ruzeYSrjjTAvGD4KkMjmAO5bC8w9e3L/IBI1joa2Vf8MNXIUak6Wo7khjsNnJoSYLFsWdWb2ZAC
	lmMus1tx4tNgU0eiOE
X-Received: by 2002:a05:6808:1205:b0:486:ca9f:52fc with SMTP id 5614622812f47-4894259d5admr989194b6e.0.1781645341009;
        Tue, 16 Jun 2026 14:29:01 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a11efsm7659541a34.1.2026.06.16.14.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 14:29:00 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:28:59 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 04/17] odb/source-packed: store pointer to "files"
 instead of generic source
Message-ID: <ajG_gC73ch923EkI@denethor>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
 <20260609-pks-odb-source-packed-v2-4-839089132c8b@pks.im>
 <ajG69JZHx_u2mt7q@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajG69JZHx_u2mt7q@denethor>

On 26/06/16 04:14PM, Justin Tobler wrote:
> On 26/06/09 10:50AM, Patrick Steinhardt wrote:
> > The `struct odb_source_packed` holds a pointer to its owning parent
> > source. The way that Git is currently structured, this parent is always
> > the "files" source. In subsequent commits we're going to detangle that
> > so that the "packed" source doesn't have any owning parent source at
> > all, which makes it usable as a completely standalone source.
> 
> Out of curiousity, `struct odb_source_loose` also stores a similar to
> pointer to its owning parent. Is the plan to also eventually do the same
> there?

Ok, I think I got myself mixed up. IIUC the `struct odb_source` pointer
currently stored in `struct odb_source_loose` is not to the parent
source, but to its "base". And the eventual goal here is to move towards
that same direction which makes sense.

-Justin
