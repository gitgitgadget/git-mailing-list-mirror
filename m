Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C77216438
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110176; cv=none; b=t4R99R0u80dxIJpb0mhCnOoOF9x4AtV6IKTqhiyR6xRMMhdi1dqFKncsiHGrQJ2/g4japV88+aX1sBBbC6Pqx3hpvYD0TT/sMu20degxB3FD7gH2BXLWcri9ywcnBIIE1F1B74iuxpox6w/Kl4zi8/vMJBZdiez4Vo1HYw2IHwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110176; c=relaxed/simple;
	bh=en0jrUrofzUg6mvmKsTm4fGX6lpuL0MQfoO2bgODfsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O97EwmSu03hZJjMsA4eZEFAobQj+ONabm5g4ebYQ5jItrghObKAOjL8XpU8wniHpA7GP/RexhSeT/70SOnIiTeHqAwkDDEEroXYp5GLMKxDuZd/5oKWTRZzp0JmM7yJUIhvR2+ZcdspS3Dz3XzcNPmXNc2WiXGdOkLui171af/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2RanzprG; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2RanzprG"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e22f10cc11so2567387b3.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729110173; x=1729714973; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=en0jrUrofzUg6mvmKsTm4fGX6lpuL0MQfoO2bgODfsM=;
        b=2RanzprGaygFygYK9QRI8+JEVhX7+hZSp3HqSQg3XiH0dvJqUaJg1nYhcF7K2Xe3vj
         eZmsiGPzq7c03Thxzggj3RjDsS52yDet1nOmKk8vnuPlzzUDIlATAiq2OAgxqNKkwNSk
         yMDF+qyZydT1qp2Tcq0jv3K0/Bl4FwxOxjyYp+hFTFTz9h/H6mpdZfiwB+FjjtJx6YBn
         M64WKYQ8boPoD6szPiwugNj46UtsykTTaR1lYZFJ2C4E8O4Z9MCRYirBpDEmmnuc1Nl8
         mUCxmVCyU3AuZi7GtM0/OJGFgbpylplpgq88Tc9f3BwWtYnrGjfZRzs5oDSUadJMSEVU
         g3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110173; x=1729714973;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=en0jrUrofzUg6mvmKsTm4fGX6lpuL0MQfoO2bgODfsM=;
        b=FY5nLQtlSv8fIurqEQJachACFZgiXNDVfjOL4r72K66XJrVNX0yErlygquz9x+rTlR
         f4Y8bPMQIu8dQ5snnniFmL34GLtm9s5TGWy/RqB+XfcasNWKWkoyh4/KzBnnDu9zYc2i
         x0Q7OZIea4NoA5jyzCqa4pbuOx1x2r/eV/7P13LbSmi//17C1X9s1E7ooZUX+i/L0GJn
         3FD5IB1DPFt2zImqLdaB3WU5iOjNtt7bQDky+X4B812x5PQIV69nlsC4fWhLelEbDkSF
         FeWI7cMt6cMTevLC/mVIC22L5UMOGEYw9THdmCYsm29Eoe6zn/Q7gW4iiXcOVBEzxar0
         G//g==
X-Gm-Message-State: AOJu0Yx7Vi3Ai/OhvvNPUG6mifHHIx3KXcpXlkYR2cHY85Y7oVnKdfdM
	fjb2dl9fTUpPVkadxMuAWWKtfAZd2Dg/N2Pgg8JRCfPoF6eGZLB2xKx7p3yUszs=
X-Google-Smtp-Source: AGHT+IHsP36hLVo+i0tBN7hinp+9Y/eVelnUNy4+Lh6lSdus97WrbyyYYe/f6pwklmlI9PrTcpUJ5Q==
X-Received: by 2002:a05:690c:6f91:b0:6e2:70e:e82a with SMTP id 00721157ae682-6e3d41d08demr57661657b3.31.1729110173369;
        Wed, 16 Oct 2024 13:22:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c97eaa32sm7637997b3.40.2024.10.16.13.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:22:52 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:22:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?B?U8O2cmVu?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org, tboegi@web.de, phillip.wood@dunelm.org.uk,
	gitster@pobox.com
Subject: Re: [PATCH v4] mingw.c: Fix complier warnings for a 64 bit msvc
Message-ID: <ZxAgmvoyxZNnY1nQ@nand.local>
References: <20241010191939.GA17171@tb-raspi4>
 <20241012062243.3350-1-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241012062243.3350-1-soekkle@freenet.de>

On Sat, Oct 12, 2024 at 08:22:43AM +0200, Sören Krecker wrote:
> Remove some complier warnings from msvc in compat/mingw.c for value
> truncation from 64 bit to 32 bit integers.
>
> Compiling compat/mingw.c under a 64 bit version of msvc produces
> warnings. An "int" is 32 bit, and ssize_t or size_t should be 64 bit
> long. Prepare compat/vcbuild/include/unistd.h to have a 64 bit type
> _ssize_t, when _WIN64 is defined and 32 bit otherwise.
>
> Further down in this include file, as before,ssize_t is defined as
> _ssize_t, if needed.

There is a missing ' ' space character between "before," and "ssize_t",
but I fixed it up when queueing.

Thanks!

Thanks,
Taylor
