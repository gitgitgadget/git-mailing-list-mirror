Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC310A3E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546332; cv=none; b=dd3OPXT7+C7Pka9ovC4F53nALAKvn+SuHU6wN8+5ePnmWA0FGXw9YG2trrDjSfKtYgcckzcyDZOXOppp6OrEUv2zlwaJkZME1Tqz7JP/gvCUvNh/CWITmyFxrGGrePgGcuGgCKo16Tq75djK7DDIUge0rAbtHs3Mna9UMgHmUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546332; c=relaxed/simple;
	bh=1BghLOBLM4B+Ji+HRicfwXfFwjxgdcZ3WxQ2LqcyZvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlfjvmjQGTXn38oSSDjgTggVx8gEiINK77rdluvsE73QlC4CS68t/PJbTBAtsskK/zI9zPETEG+DE1oOVTgNnryNIu5Q19cu76KPI24aImc2DQ31zCplYwroBMM7OobSckhm3ZrTntmtO9770u3cbIXvJD/HpfN8J21Q/7tg9Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=z6SlgKcp; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="z6SlgKcp"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e3b7b3e9acso45374497b3.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729546330; x=1730151130; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5L1EQDMc4fRwoyIwNGO360uwCOEd1dxj8MOU51h7Iok=;
        b=z6SlgKcpi7nTd6ckmeJWomsVOfuNPvK2nCvzTOa3mqjh3XmpXarOf9nlAfoAU8kbkz
         SfQFxOQDa2NKgoEqy7aUizUPqIZ8XFqE7U9yj1D4k5vwmquK9llkkR/w0KoJO4h/5buq
         N4HE03yXdK+erTbkrtozuRyrinO2NczFP6/XPNLHjC8KPyLD8VcnpcdhWb+oLlYxqtRN
         CYkyxU3v0LWRN5d1wtINYLdkPVeILx6DQMTmDQ6aNW1VXVy4a2q/3wmc818UUYefcnIS
         96AOvZk/RqESTWYfxBcdIw1XGtjO0T7cEOCL1VMGtPiM4zwPvQGwX3hxcHJUcyp+Ko7V
         qBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729546330; x=1730151130;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5L1EQDMc4fRwoyIwNGO360uwCOEd1dxj8MOU51h7Iok=;
        b=ZZ8V2I5NfYJQ6r+L54YcJHl6zJycKGiSynyu/sv4sd0Z/CdAEQpX/5SCeC+hRui722
         caVyDhDp/e5wgyN0XEUOfllyMlM+0+NOWeLi00qK6cZ/8hBUMZShjTmCsHBzUI7XSNMj
         zaE4Er2UEctGOIFYHtOErVnlKQRDtJY7/IvMKXSGXqWVfDdccdZu9mkIe4gfyfVIoJWp
         JCUqvlxpejS2sG6ZXhDBve7iBwXjOoluh5MYok/pJwF/bPruqqKjISpPB39Pri06ki5C
         b6w0DxhAi8Ab7hDlIHEB8SXLRuFO3rWm2yuBkLCxfDNgQQfEYWqIQ4lb74NC8xebrFdO
         YCqA==
X-Gm-Message-State: AOJu0YxG5eXnVLZKqqZ/2l8669aseLaRdCwZPQRpPrSUajipxlvUPctr
	xZ00EJWoCpyi1ropfu9/U9n1zvMnzI+rZQCTgDYCFGhyz4MdNzB43ZMkQPrA3s0=
X-Google-Smtp-Source: AGHT+IG4O/gmOcsxpufYJMUOw32xt98Qx5/HMYGXRSBSTgU4HMRcoMGBa1W3PFuswryn1/Sv+XyO8A==
X-Received: by 2002:a05:690c:660c:b0:66a:ba89:d671 with SMTP id 00721157ae682-6e5bfe94d3emr104534467b3.35.1729546329841;
        Mon, 21 Oct 2024 14:32:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb428sm8395927b3.78.2024.10.21.14.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:32:09 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:32:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com
Subject: Re: [PATCH 2/4] Documentation/git-bundle.txt: mention full backup
 example
Message-ID: <ZxbIWEGS1UB3UIg+@nand.local>
References: <cover.1729451376.git.code@khaugsbakk.name>
 <f7d9aa89c953ca7d15b5047487b4347ef62e77a9.1729451376.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7d9aa89c953ca7d15b5047487b4347ef62e77a9.1729451376.git.code@khaugsbakk.name>

On Sun, Oct 20, 2024 at 09:15:00PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Tell the user how to make a full backup of the repository right at the
> start of the doc.
>
> This is a requested use-case.[1]  But the doc is a bit unassuming
> about it:
>
>   “ If you want to match `git clone --mirror`, which would include your
>     refs such as `refs/remotes/*`, use `--all`.
>
> The user cannot be expected to formulate “I want a full backup” as “I
> want to match `git clone --mirror`” for a bundle file or something.
>
> 🔗 1: https://stackoverflow.com/a/5578292/1725151

We do not typically use emoji characters in commit messages on the Git
project. The convention here would be to write this as

    [1]: https://stackoverflow.com/a/5578292/1725151

> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-bundle.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
> index 7579dd309ac..bf0d448a736 100644
> --- a/Documentation/git-bundle.txt
> +++ b/Documentation/git-bundle.txt
> @@ -26,6 +26,9 @@ They can be used to create both incremental and full backups of a
>  repository, and to relay the state of the references in one repository
>  to another.
>
> +You can use `git bundle create <file> --all` to create a full backup of
> +your repository.
> +

Looks good, and could likely be combined with the previous paragraph
instead of breaking and starting a new one.

Now that you mention it here, does it make sense to drop the more subtle
mention that you refer to in the patch message?

Thanks,
Taylor
