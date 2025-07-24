Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C720A1DD0D4
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374040; cv=none; b=CJIsAMSVAmRQV74gwDKlcWzRCf5IQlTBh1kngacO4xoAr6Jo016/g6A2F7Hg670iBq/HLr02tAr1ECXOC6nqtAwWN7qRpKgknHE3mEp1uDRGw5eFKgcSu0Nd2KfYRcUy4+TOgSI1gt0WH9ATliVh9ZPxLsKGx+/FfJ0BgXUDl5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374040; c=relaxed/simple;
	bh=aQstDmq9GobvhElUgG4nLVTF6uLpFZ2qkfbjRzffp0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b59ddsiIXPLHo94cekDMPrkCPr2RM2SpaA864ZxlnV3ciGTJ4YHP16dge28q8CWHLiq3QY6OzuktXLLTMHD4g+g/fufhWfoGoLAmAncBdzsW8hj0lf8+9xJ7kWQyZ1b+pHFP3WOwWopcXleXkOreitL2FGDHGWxNSyvKgg3dINY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQr1k4cZ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQr1k4cZ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61360453fa3so1873888a12.0
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 09:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753374037; x=1753978837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b/nwc8vqZYY7hHLYrGWI/UGQpM77MNCvKWKaeYedhVQ=;
        b=nQr1k4cZn43JpCN8Bw80oK/Enmm4y3Wik0F2q2jkvfAO+Muu/rmNjxdrToHjSXAuos
         pcZhHsaN6bIWh0yuMoR6oBfRb/2lpQ/wWFxuGB34ycjRGmOZti5jM2oKpXaCc8cWOPJa
         5FSNe3tLBBgdE/154diAOnWTW+JFP6eksriXa4wg9S2RCK3N5X0DTmlIpML0gGgO2IaM
         8fluVZAZzwvZD0RJlFl7PpF/3MKP+lTR+9IamgN+uLPHiUFbGPeT2nrL5yZzS2eF+rVb
         XPKC5BF5B8384pa7hOvxREzT49P/RjHOxFGEiHfleD6xrqyRjO7f4QaYa9+ipbaf7HiW
         DUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374037; x=1753978837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/nwc8vqZYY7hHLYrGWI/UGQpM77MNCvKWKaeYedhVQ=;
        b=nDNBGa2/nKlWuuQD4EXbIk/JFwUCPzmwLIdEbLtdeK2Sg58HyAU4pxJWkgDRm6ngI2
         Va+O4VYPE3xaooI/HcSQXFyBRIuchHsblGLcC/g6+LO9XmZ0ch+5PBCMw269jCFAdZK/
         kZNXG6aVg3oe1vVSkhr0fpxhiFaGrJROCloZOZDfY+AWsYdoVKHWR80Ge/Z+j72m+Qeb
         sWwFgHziRV17iSylSIESsR1lW9/IQZLypBDXSnZwQXNWWhCrCpWnqrLnPGFlh1QpncIY
         rST8Nhc4jlr5mI9HBmxRGHPknNx5/pOUx3sW3x4McYyjs7eADjYXm3xRAC4oASb2kZPU
         9ANw==
X-Gm-Message-State: AOJu0YwHPesVYlw0FTHBarhv1w2KBUTYVlc3Ax3E/sKoW7R1BSDgfeA2
	qwQDGK9ErojBNe3FdTf8ctsGg/4SFUPbmGvRfynDyM+kIMNCqKIS2hEB
X-Gm-Gg: ASbGncua4FpAhXL4a1kGV4D0ktpNA7PcpD3LWLuJ+MuJTKcOeL/eVA0jhMr9IsUddrD
	fFmCa44imf33/9xNByD82Fp7bAGPmIouPQXNEjf23QGHzCCXgU51Es/4kLpG5Icfn/6zysudtQe
	4JdbxHnY6Jj8FwFPQEVzQETVR5QFJDvL4wbJ3J0Th0el4Paxa0wR7qBuHRfPnhAkTt92enSo3B8
	7PPHWmLy4vLL48p1YrMF6rsuM3RdG56+t6lHdedugn6KbyeAjJmhoLfIe5S/z3CU8JIRFhmonPD
	e1GfVTnNnIEbpVSrMdOkTCQuUIIWBI96A622saFFiTdtdJv9WyfC238ncqiubciMcZzrR0iM41w
	SwCrBt/EvCKKvtjUsGOe/QXsmPQX3eNA8O4tD2kGEj0Syar/mr4Ilhb4=
X-Google-Smtp-Source: AGHT+IEyRcWG1EElHz4lQniio20WH0+Vr+HFTVsjOevcEbdDe6q8LcwNzLMHG9uyC1tyXoJlm/PaRg==
X-Received: by 2002:a17:907:7204:b0:aec:56e3:ce0b with SMTP id a640c23a62f3a-af2f6c0ae3amr869976366b.19.1753374036634;
        Thu, 24 Jul 2025 09:20:36 -0700 (PDT)
Received: from localhost (92-249-246-243.pool.digikabel.hu. [92.249.246.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c496250sm133711566b.13.2025.07.24.09.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 09:20:36 -0700 (PDT)
Date: Thu, 24 Jul 2025 18:20:24 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/8] builtin/reflog: implement subcommand to write new
 entries
Message-ID: <aIJdSCPEHoiWWxrP@szeder.dev>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-4-183e5949de16@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722-pks-reflog-append-v1-4-183e5949de16@pks.im>

On Tue, Jul 22, 2025 at 01:20:53PM +0200, Patrick Steinhardt wrote:
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index b00b3f9edc9..d0374295620 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -3,6 +3,8 @@
>  #include "builtin.h"
>  #include "config.h"
>  #include "gettext.h"
> +#include "hex.h"
> +#include "odb.h"

This series is queued on top of v2.50.0, which doesn't have 'odb.h'
yet.

      CC builtin/reflog.o
  builtin/reflog.c:7:10: fatal error: odb.h: No such file or directory
      7 | #include "odb.h"
        |          ^~~~~~~
  compilation terminated.
  make: *** [Makefile:2821: builtin/reflog.o] Error 1

>  #include "revision.h"
>  #include "reachable.h"
>  #include "wildmatch.h"
