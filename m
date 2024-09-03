Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322EA1D7E26
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392070; cv=none; b=s3NxuWpsKSgEaoBfXFzcFARCePj5Fb8cj4088QcZydrE7oUin91MoRUoIzf3o0+Qa3esCWg41wAxlqUDhtfGhSYsX//a9Kfm6D3ZWaK4dXwAJW0/vHvp9GOQ0VaDfErj1bdeQ+LM0ZhBzizvoOEA9tg2RmD3XjXl9cLGafR/6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392070; c=relaxed/simple;
	bh=0mT6fkGh3x715yzRGXw4dIkPSO5mo2RPUQv5p1t9VXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmaItKo641D16ccp9W7bMRMENl56tVlEeOkWXRKUsiZs6Pk9i/1t5Js1ojhN1FcTP9Qc19qInGYrpOpIxsWQ+g7PwHTX7yuwzbA3Af9FgHz6U0tEiTF8p2Y3a7RhgUYYcgZ1TQsrlPSaKSpaDf09+a1n4+nrbaK6cmfNtlGrPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tJTUxZs+; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tJTUxZs+"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6bada443ffeso44468627b3.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 12:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725392068; x=1725996868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mT6fkGh3x715yzRGXw4dIkPSO5mo2RPUQv5p1t9VXU=;
        b=tJTUxZs+Spp82LH8w5lOellA4fBQRb96anTKoYGFDScnob8qn3J1lxx5ogqTtoflUR
         A+EXWC2a7kUGqYnE3aNcjZ/YtqhSRkUHGhjlpmotJimFvW+CpMy6p73t4CgTcxirs2Wt
         62ZM+5YUz+eEBe/N+W4gWLjECvTLIkHS+YOCyse7Ajjv7NMs4sbm/kQIQeurRvegX37G
         00FHo3r8DgmmX+yJ+RsEcV77y8OAAsdm361VRuLR5MlAkJPt8QEk5k1Bpqqm0um3IhDG
         vH1CHrIxz81C5AR8IAFRw2kYCj/CuzOb8HINiftuRhWGcJhI8mOgIFmLrZc1AeCOh1Ls
         pwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392068; x=1725996868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mT6fkGh3x715yzRGXw4dIkPSO5mo2RPUQv5p1t9VXU=;
        b=L3/RsEvbJaMSz3Oy84ddi23kZf2/1D2uF0kZmKpE7a1fJQ71bAlnnJzoDEaorRO/Mp
         mlFSh79SH+Q7x9kLzYFqEVXE9XBis1cIVseV+LyFZF+4up7PXrP/DCHNgQFd4OlhDr25
         OovDv20C+XPm1vSYEGabtpTFQkKGIXH2Mt7lyXfkgxg59oPRJq3vhtl2BIig7LRKcVvz
         OybXj+16j+A0H8hTlS2DuIZSbhHXjt8niUgx+UIruaNLVy+ro4n2uMlGYuRM+SZwcJ9J
         H0KkMfjwTmdt9eL/sLD66AHFoL3b4zwa2hDsTXbb99i8EwdJlBKOeO/QZrAY30enm+76
         qgwA==
X-Gm-Message-State: AOJu0Yx+lSPyXALrXrGanC/k5XRNmASHWu2bawGmJMLflGTRJVlobwlR
	wY0zjn/+ilgBELBHACarOeiPhc4ghM29PSb5jLEDFJibMRyxBP3dHyU+bEJqS0lD4RRGnJsN2BI
	QOSk=
X-Google-Smtp-Source: AGHT+IGV5lmo9rT0ssrJFiwfRQ3GV9TDVaNhzgcnXkm1SyUMz0SDE+63BEriR0i+dOcFzH9pmMEARw==
X-Received: by 2002:a05:690c:4b0a:b0:6d5:ec7b:ae45 with SMTP id 00721157ae682-6d5ec7bb259mr96012077b3.10.1725392068166;
        Tue, 03 Sep 2024 12:34:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d47b06daabsm15816997b3.142.2024.09.03.12.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:34:27 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:34:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] sha1: do not redefine `platform_SHA_CTX` and friends
Message-ID: <ZtdkwtVt7wl887gL@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <e7cd23bf4cd232fa2ce610284199996383fb3323.1725206584.git.me@ttaylorr.com>
 <ZtXAgFfhaoTxF1tC@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtXAgFfhaoTxF1tC@tanuki>

On Mon, Sep 02, 2024 at 03:41:20PM +0200, Patrick Steinhardt wrote:
> So we now pick the first hash we find as platform hash, whereas
> previously we would have always picked the last one? Hum, okay. A bit
> curious, but let's read on.

In a pre-_FAST SHA-1 environment, we only ever #include one of these to
begin with, so the order doesn't matter. After this series, we may
include two SHA-1 implementations, but we include the non-_FAST one
first, so we'll always pick that one as the default platform
implementation.

Thanks,
Taylor
