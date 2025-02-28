Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695C1C01
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702749; cv=none; b=MX2c21xkeU5fm66jxLua6wJBc1jCc6aiAQK3oN9TDZqFA4+nEb87ra/SC2kmP2tH1GBmDbXHQaoQSvOcY6zfSBryvsVtO1HEVKzGdfAOMp3sMmyCnCpXsVrXwkatriQhL360WmdMKLyfANV2loRETet45BAe2sq6YwJPhdabJ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702749; c=relaxed/simple;
	bh=D6YeDmYsoU1BEw2EctsWFD/FegU7GkbijK1LJHAcYbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2vMGLgaVqRJ5/cEbFroxhCAmEKjCYrbLUF06ZXuRBnRCeStYA1LmtXvnYjKiFHZ06Y4UBMIhpYaXiPC7he+5S141exZ4rcF9D48C1hW6TtO6Wx/kFVmqv+Ieyfwt8y1OJVbZg5on8ppZ7mpNucEfKxPko6Z2cyC1qLbQ8uuNe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Yj5cO/zm; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Yj5cO/zm"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fcf90d09c6so14098607b3.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740702747; x=1741307547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Il2xx5o+/CtXxabNGCqOP8Ybvq0t7WUpli/xCVw3C9I=;
        b=Yj5cO/zmdCsmg28uWyw54IGO83CE+Gm9WAjQ/8aYZbA94E935B5NP9HPQGLVIGOFcZ
         HRDJBH4Hv4eeSr/CYMYQ74Ie+BZSXKMgmTUHxuH65m86BmAmbcmCIjjq3rjMFXLs/v7/
         Ppm2Nww+4owWKtruI2gTdqJXhX73SYjExYSmQZ2PbdeldtE9L46F5XdNkRA2o/JOuPFb
         IZZZofjSEhwhbVY+cxzGkI3qZL+cAl3dUBot+6/zPccPH3tM7IqTyy7YS4ETYj5Craqe
         MCYjoS7MqGLsMvkRROgmIhX5ZJf3yx1eUz7DkN0UUDz0abfXuerNn/iF0oK9u9hLbSd5
         8Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702747; x=1741307547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il2xx5o+/CtXxabNGCqOP8Ybvq0t7WUpli/xCVw3C9I=;
        b=J5vwHzwbny1AQyB7nHQDWKId4yrwscgfB1EwPQfSbBgdh0ALcOsqQ3hGFM70Qm3q1g
         GxGbUXbobD7QUyCaPlPZcR4mUG3jADLwAFZdUSAkZrYNJPGxDAsPEWvVpVy99BG9jkme
         kMwuU7e7RcVy3KSjS/RhWN6FcpSNPue8VGRLPB56SGHT/eikolyx55Ka2S9WKRyhQBVS
         i6e4MNKNswWYhNSbns+0mY5iGWtDlm0nCVPU+0uHfa93Qj4xAazwhf9q34neDvWSlkx0
         NTOmk/dk6A/Zlu0B/792diW3fgs89IjUjkKMM7trDrFNa/fqdCXMH6li/x+PnvH49V70
         dK8w==
X-Gm-Message-State: AOJu0Yyxila3yZlzjLIbilAB4erKNBAb/pH+Kctae/IzJ2Byr9dKN0Xn
	WxQpQvw7v/lbb00wkc1zvgkF6l0tjWpdLFYiAOfdA4LZETPYToQc0mOHdEn5xMTyyYiA4Ryv5DJ
	e
X-Gm-Gg: ASbGncsSQgPh2s5jRoeRmgLW7FTFjrpy9V/zQzvAln5BbXxs+cbha92JmHV+GPAPAMl
	E4rZMajq5fdlPcPwi/K0nAGUwTnPLlAxH819g+GI6V3GAwGCVWeMz7xmZ+WsoutdnvJoh2NfGUZ
	3Usea2gg9xOCEo99vYfQSaX6vCTntWQUSuYG2qNijX/n838tAXOjxo+osEy799e+0xtbOiSlekL
	0YSNbgzP0MfLn49NesctXvAROL80ME2vPp3QgkQmL8FJvfhu/esnHqkH+t+Xj+ECbDFoeMd5UhL
	Hs5PKBuuDl/tQQUwDwjJrBuVOQBm/DaiSmSGsZac0+kOPWq3KfOZH1la6at2unPsWEUaNLkXcA=
	=
X-Google-Smtp-Source: AGHT+IFBHBW2iVrLcHK8pvQoGF6vmu2qkyutMpv/pol84QH0v3aDLyoBamEixQ41FVDPW1W/b8QZYg==
X-Received: by 2002:a05:690c:3686:b0:6f9:492e:94db with SMTP id 00721157ae682-6fd4a0ad3bamr20103057b3.2.1740702747197;
        Thu, 27 Feb 2025 16:32:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3cb7e1f9sm5107837b3.88.2025.02.27.16.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:32:26 -0800 (PST)
Date: Thu, 27 Feb 2025 19:32:25 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/10] unpack_loose_header(): avoid numeric comparison of
 zlib status
Message-ID: <Z8EEGd4Q+Py3Ym0l@nand.local>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225063056.GF1293961@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225063056.GF1293961@coredump.intra.peff.net>

On Tue, Feb 25, 2025 at 01:30:56AM -0500, Jeff King wrote:
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index e493600aff..86a2825473 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -951,6 +951,8 @@ test_expect_success 'object reading handles zlib dictionary' - <<\EOT
>  	printf '\170\273\017\112\003\143' >$objpath &&
>
>  	test_must_fail git cat-file blob $blob 2>err &&
> +	test_grep ! 'too long' err &&
> +	test_grep 'error: unable to unpack' err &&
>  	test_grep 'error: inflate: needs dictionary' err
>  EOT

All looking good here, too.

I think the test_grep is hiding what is a fairly unpleasant error
message that says the same thing a few times from different points in
the call-stack. But that isn't anything new from this series, and I'm
content to let it be a problem for another day ;-).

Thanks,
Taylor
