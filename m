Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C91474B7
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728942394; cv=none; b=eQlX3oYVfyoTp4KFgKxYzt2hbBiIWRKX16eGbG81ug3/s3eVDMOEWvT9DXkq4ALm8f415TtLvL7uEri2Plty1sjElF4NY3XBwuhe/rDtc0S4QX+yWxFdw30oVVOJL69pnC/IqeB8+DSN88qcTD/CLbtrFWUeERu/iFxnDI0r8l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728942394; c=relaxed/simple;
	bh=MW8i+tOAm+BHKcsyZnIBHCkJxt22zrCOAyemzog4pX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWfCsbaRE2obXvsB2WKDLJpji3k6IYrv5FWxTwmkRIhJ335Q8amtEryCDcX+975AXXhAmx6LD718hKGaBenOd3GiWokNgQpYZsGTr1FnvOFWr43zgLBKMxDLJ6Y5UPC5IGETX/b1zG7910ZjYjONHotqIkIBUOnYh4crbCGIO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mEAl69Ua; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mEAl69Ua"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e2e427b07dso33920877b3.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728942392; x=1729547192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6PTaRGITeakj/VkYb29+suPOuHyhG+brfD7fvKN/dE=;
        b=mEAl69UaD0dZksYGMYkmq1gkF9OS69hBBXCbVFhGzioDk1yCTkzKQnr2DXhRq5s8wq
         QBSFhY474TotgQvqszKU02iYIzCIi1hUoBY27wTMTvkEPhti+NGN0XOUXolAxzuSETNN
         uqr1HZkBv77QBhSWbBTXkoXnz6I3bHmE0n2IdIQHgHIO5VlHGhUueObnl8PyzzHxLCiC
         H5QboYI5nqdBPp/hHcFPgm6TcsUwgwmzATi8YUwL/Bei3Y4WhAElMLYMn0j4mpkQGuEp
         RucbBR/lzi8zvwMPr3XT39i8EV9+PXgCPDeHmU1TBGUE7c12wF8bZUWF+Xxa25zPmcvy
         zoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728942392; x=1729547192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6PTaRGITeakj/VkYb29+suPOuHyhG+brfD7fvKN/dE=;
        b=q62Pr4Iao8p89rUHvTaCJ54HO2N3UcDAAy2RKlzcoAQtlLZQwl6PiWnyGCnaGavcMr
         I7Cs5mfk1GTVrC9C1dzHR7OVt3EUzK/EOnWv/GFjqxmoEZDyyTyUfTNrIz6bkcWHAqwT
         o1X2nzmWPGhJJOrIp6dcHMhuK/OLIizWFDuf10tmnYtrBtKZ1GTX6rq2cNtjzMjiu0oj
         Vr77fnPHWcC1NFiPFG1j46EejlfGV4xyq0v+uB6Op2ILFPJYq/hGCkgBrlYAkvor6e7z
         y9XUwmGXg8ijnmF9HTQP0naYZxeDcj3vJv2sPCnjin/MN8qQpfgDwh12HeqWX/cqCNMM
         Fndg==
X-Gm-Message-State: AOJu0YzHZKhHK2nWtdvJvLusvpIrKwS/rFajDFmzOR5NV7kmdxw2BVwT
	lPc0INTYihxITJQjJFp48fi7uePTHMeMDdld/OGafEeN2ppSNCwNGuXTCRnaIFI=
X-Google-Smtp-Source: AGHT+IHdvbfOydUNnjtSoLQrNCiT0513veXoB7FV7uzsGpmhV+DH0kkatIbPA5SqVpA7UEOPHSpycw==
X-Received: by 2002:a05:690c:399:b0:6e2:167e:8155 with SMTP id 00721157ae682-6e3643a636emr56188897b3.33.1728942392173;
        Mon, 14 Oct 2024 14:46:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e29177e3e2fsm2231096276.63.2024.10.14.14.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:46:31 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:46:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] cmake: fix compilation of clar-based unit tests
Message-ID: <Zw2RNsptlkHCyTgi@nand.local>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
 <cover.1728914219.git.ps@pks.im>
 <b9afeffda292a068e81d05b91f759a5c53a24b15.1728914219.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9afeffda292a068e81d05b91f759a5c53a24b15.1728914219.git.ps@pks.im>

On Mon, Oct 14, 2024 at 04:06:44PM +0200, Patrick Steinhardt wrote:
> The compilation of clar-based unit tests is broken because we do not
> add the binary directory into which we generate the "clar-decls.h" and
> "clar.suite" files as include directories. Instead, we accidentally set
> up the source directory as include directory.

I am confused. What is the difference between CMAKE_SOURCE_DIR and
CMAKE_BINARY_DIR here, and why does the difference between the two
matter?

> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 62af7b33d2f..093852ad9d6 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1042,7 +1042,7 @@ file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite" "${clar_decls}" "${clar
>  list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
>  list(TRANSFORM clar_test_SUITES APPEND ".c")
>  add_library(unit-tests-lib ${clar_test_SUITES} "${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c")
> -target_include_directories(unit-tests-lib PRIVATE "${CMAKE_SOURCE_DIR}/t/unit-tests")
> +target_include_directories(unit-tests-lib PUBLIC "${CMAKE_BINARY_DIR}/t/unit-tests")

This also changes the 'scope' parameter of 'target_include_directories'
from PRIVATE to PUBLIC, but the commit message doesn't mention such a
change.

Is it intentional? If so, can the commit message be updated to explain
why this is done? If not, is this a stray change that snuck in?

(If all of this is obvious to you, I apologize for the confusion on my
end. I'm not at all familiar with our CMake bits, so the extra
explanation would help me quite a bit in making sense of this.)

Thanks,
Taylor
