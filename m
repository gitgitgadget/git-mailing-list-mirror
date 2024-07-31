Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A431799F
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443314; cv=none; b=jFpjSIrT6uKTYfbC3iQ9bRZaQYZXlJw12qYN/uVVC4Qs2CbPmVsusTG0tMKE/h56INrKl9CoAYTZSpz9wnk50REC8vTlqwDIrbjFwXp/rWzg4X3D/Yc6hBSHkHz92diU30W/uUYDXzfA8NHeRrlqGuaIdcIIPPcCTO+eqg9ezIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443314; c=relaxed/simple;
	bh=PPdSP5dhDdYxGQM4XNwZYCX+UWbouz2MzZJ7qebpfDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M20nEiAFKOq21/pCvVXGfalaAjmm5jBQFmcw0Kd3upL2Xro5+v1wRTmXZO3nHW4EcjeHWoI5C+vgtxgd5M1cHkhjRybC0CMEWszis+0PF4GXsBEL5/TFOkEtRa9qmv2l5NJILv8lHHGuUYGBqoYW8E0O7T55lEr0P2vRQ4kqzsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MIN6S+HO; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MIN6S+HO"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70940c9657dso2983837a34.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722443312; x=1723048112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AfXHxNYlIy9F+uCuC3oc0+m1Cox/ttErBOAQNr8sou8=;
        b=MIN6S+HOVpZV02t+yjkYuTZZQZ6M5QI06AJPYW2Y2CmZjhw5w2HMcq8AKYo6cj5gt3
         qCRaF1kDd0RvyT8Bffo5HkVVRb0eOmljCDUzMCrrfB0V+L8HRKtYZiCVSJ/1/iHqICXZ
         gvso7D29Ci9f6kLOUYwKktJxR3g2WBzT0QEVShusangBfoHS9B6k5Rvvbz0QxEaQF71W
         uyUd3wojii+OXLGoGH/z0AwG9AAxU9BGd0zWG5uk71NrA3iy3l8Tc5S4u+mkw9wx/iNd
         /6pnhs1YYqrIkwROzYy1OEpt/zqVLEebqjeq0EovDgH1d6cXTK7K7Q7nS5PSzRYkJHhk
         svjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722443312; x=1723048112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfXHxNYlIy9F+uCuC3oc0+m1Cox/ttErBOAQNr8sou8=;
        b=eyDX3ShO34w8D5Kr2jhuNlF8JvBAN/POb4raFGG5DQQ4xw9tma4W3Pl+RgCJFgWPHR
         bWCug1rOKjxUL3jLQUjdkiPVC5Fyb3EVHOYec29Sw5Ug8JrEY+4dW7aOf/HO20J5UfcX
         By/g5dtq3Q7k0KunvAyeA0RKGysoruFParhwSVOxj5rAle0Yg5lx9yPfKQGsCpNgN1CH
         Gl5qxp3HI5wdWTQyNYR4UmTx58AxtIBqZQs0678GOBGazvMH/xfRBpB7Ox4lNpQ4QXoC
         tgy7er1Vfr5vdRp+dFO2zIR9zZgtb07pSktN/D7oex8fI28g1wplXEvKGcO9xL5g4lmE
         +8Pg==
X-Gm-Message-State: AOJu0YzWWWolRpeS0vTGlhLEzfwzs6Pmd/iCmuvs0JpyfaoRZMg2LlKs
	TKiHWCDdbd6EQKHajjkhbSRHbrWdhgaOq+ma0Djsai251FTcEuzgNdT/0vw+oBG3a6/O4cwSMRk
	r
X-Google-Smtp-Source: AGHT+IHSABq7PgZ0oLBC2iWVnmwhCHry5woE835T0bJEY2H0F4LgCkdwot7+2GJqSHXpaMQEnDn7AQ==
X-Received: by 2002:a05:6358:4782:b0:1a6:758e:cdc7 with SMTP id e5c5f4694b2df-1adbd0eef7cmr1825625755d.8.1722443311826;
        Wed, 31 Jul 2024 09:28:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d825esm74679126d6.29.2024.07.31.09.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:28:31 -0700 (PDT)
Date: Wed, 31 Jul 2024 12:28:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/23] builtin/describe: fix memory leak with
 `--contains=`
Message-ID: <ZqpmLsX8pug6qj3f@nand.local>
References: <cover.1721995576.git.ps@pks.im>
 <08a12be13c2fed247d6086967e7a3f03fa6519e1.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08a12be13c2fed247d6086967e7a3f03fa6519e1.1721995576.git.ps@pks.im>

On Fri, Jul 26, 2024 at 02:14:18PM +0200, Patrick Steinhardt wrote:
> @@ -637,7 +639,21 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  			strvec_pushv(&args, argv);
>  		else
>  			strvec_push(&args, "HEAD");
> -		return cmd_name_rev(args.nr, args.v, prefix);
> +
> +		/*
> +		 * `cmd_name_rev()` modifies the array, so we'd link its

s/link/leak/ ?

Thanks,
Taylor
