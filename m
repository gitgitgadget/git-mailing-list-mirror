Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5E172BA8
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726934879; cv=none; b=Ki5cJv21/pJzyIbeq0pJul8kQPfEzzB6/qi4WP+q2lCHHmBRSivUy9POMtP6YzI1DFRaiCFleSJifQ1sdxhORzOBOnSixV5bgw9VQl9x+RXExzlOU6gFPXb8nkhaNcje4RW07LzVRHG9zM8VTcd1UohCTur0UFABaflCbWPfMnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726934879; c=relaxed/simple;
	bh=/hMrSiZc1/Bs0cUYJoSADizhNtzZ0tGrVcPdg62HeEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbkQUnwaW+AkI6irMB+KM/KWaDDGuVaRE4ei63y796Av13ZnWlothBa1LktF1Ah6isrA5Rk1t/5NwjTaN3gtuSxSeH338c0b740ICh0pU3acQZW78zzNv2B8neptMr6cfZeFis2K+JPfxRSYQqX4ub3xVmcvYheCalXXzcMTiiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTOq3K/i; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTOq3K/i"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-719858156f4so2449971b3a.3
        for <git@vger.kernel.org>; Sat, 21 Sep 2024 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726934878; x=1727539678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWmYOZU8pcHuNGJ13u/zgDdgwk5eU90tpp67HJL1kic=;
        b=OTOq3K/iY3KcdfDTpl6BStwzAFA0lT9MFpXIL133VNDnG9oQBiTCHSuysZjZAEpTb0
         Rcqh1cbTztKXottVPnKrQRkwx4J5QrsBwzTz9KnK9oWC6gN8zbmwCDl5y9vMKr3O3cio
         kryZpWboHrhlcpfRERCLpCAor1wr39ePsoIomX2SyuuBOvYR9F7+2PlEfSUwjRVnAlze
         jp28tb/eaklJiflr6Nfc4MefBQ0Eqo086XbkUJQ66+bc7vZE5ntS1OzqyBXW+adsJbEW
         g9KYu7H9TSsWn/fqT4EaO/Ka/wStV62G1o+mQ8PXWopqLwTuSN1hscvlUsPdPC3HFrkQ
         RWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726934878; x=1727539678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWmYOZU8pcHuNGJ13u/zgDdgwk5eU90tpp67HJL1kic=;
        b=QdSx8E15hBagUTBoHe58yIRc3CmU9fjN/MujcJBt19J4CQfbscXRsdExwOp6fxX/At
         /DIZlUK1MPncaxEeBxE1xosjtWodrdMPNmE0n8hxBaS4Tt4WcaPoaljv2Qn5+b1d6wkW
         pTpoJXS7dLkZ8A5zavCkzMvu1i6YOmCTIvQHHM0ZOSY+b9wB7E+JFfn02pMmT05oMJqU
         hwqrBw86q4ik4CDbvrqw9rdDR42nUVgvQcxe7ny2i/7a+1RO5HU/uxba6luX7CW8toSl
         xjHOVOJrrPiS7CONkdHmiVllE/Qlf47VBYvaiUNS9qYVE6lHkWxOn8/0p+iLCOd5PQLO
         D+Gg==
X-Gm-Message-State: AOJu0Yzzu5ohVczsxRWG7nD6UBj+i7xq3KE+SiHG+02Wf8d3kEIPPYlK
	4DLDYPMVER21Rf2IVY8OUt2pdjmegcskW+ahhQM152K+TDZ15BIE4ukDjw==
X-Google-Smtp-Source: AGHT+IGNct1/PZISoodAofBRA4PL4l3GPj4x5GIqtz+DfdOM/qqXnYUqo5gBZ9tBPn2vFmZYHDFMKQ==
X-Received: by 2002:a05:6a00:238d:b0:717:9154:b5b6 with SMTP id d2e1a72fcca58-7199c95955amr11295387b3a.7.1726934877613;
        Sat, 21 Sep 2024 09:07:57 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719858156f9sm5773577b3a.76.2024.09.21.09.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 09:07:57 -0700 (PDT)
Date: Sun, 22 Sep 2024 00:09:08 +0800
From: shejialuo <shejialuo@gmail.com>
To: Ronan Pigott <ronan@rjp.ie>
Cc: git@vger.kernel.org
Subject: Re: BUG: refs.c:1933: reference backend is unknown
Message-ID: <Zu7vpPs8fcqlMlNK@ArchLinux>
References: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>

On Fri, Sep 20, 2024 at 05:37:40PM +0000, Ronan Pigott wrote:

[snip]

> The following is an abort in git:
> 
>   $ git --version
>   git version 2.46.1
>   $ git --git-dir=notexist archive  
>   BUG: refs.c:1933: reference backend is unknown
>   zsh: IOT instruction (core dumped)  git --git-dir=notexist archive
> 

The "git-archive(1)" command must accept at least one parameter as
"archive.c::parse_archive_args" shows:

    static int parse_archive_args(...)
    {
        ...
        if (argc < 1)
            usage_with_options(archive_usage, opts);
    }

So, it will print the usage and exit the program. I guess you omit some
things for this bug report. Could you please give us more information to
let us dive into this?

Thanks,
Jialuo
