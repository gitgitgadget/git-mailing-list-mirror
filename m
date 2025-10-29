Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429DE19D08F
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772756; cv=none; b=jnv1HDe/keYWSInU/2H8Hlkb3F7MJBAR9z5kh/8r8VUuRJnrBdER7flGQrhHskGlHGppjF0u8LJA26LuLlqWUKeJttKlAh6WArNspn+mmRad7O3+HzWVkQUMJYCBKbzndn93kNG7ZgvpRJKPxIMSeu2g4z6QzGKNfiOpAYYl4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772756; c=relaxed/simple;
	bh=gwWcJ01y24SrVrcduLxRKXb5bcd7oEjbiQaTFJnYtKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/kmUFn6blSHAoQfLc1GiCeJafEQRMMU+gSL/daBXH486+eY6jWeJupOFvZ9jfCv4mJZ0MjHFvzIiQPRc6XQiaMwocDRD8QlVMTNPdt8uTpDtS6yHJ9aT/LHKzr3hv8EWCzu+vUb0a1hZlvY4FgTEUCY187d/oEJJ8yBeLNLh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGZp8/MH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGZp8/MH"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b4539dddd99so83518866b.1
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761772753; x=1762377553; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A1CUzKaXRwGZ4xVedXqdBXxq8iuSvapH7cVHMvXbf9w=;
        b=aGZp8/MHqPqySYhDXTlsyL1TsqKXBCVg+GtNc8OL+mC8BmDfgAVe9T33QtYon7poyT
         mFgPEkXP4OFguyc1P+8aCy2ErassObaf03pFO3802Btig4BUpZu13CHZiGm27mIAYQwK
         M/yQeRA/sampq4TtwAELhAfwU9zSQ7Vw1uTzlhCYUj35nSMN/re3as4uiqIzmTiHqPzX
         +QAajp1jV+WA3mkDHX+imKGiQEuomPv8bT80fTXYLrPV3L56f6GAgjhGBesiWgbjo084
         GcEZeGnLp6/VJwW3YmpaPYpeTQbIIbn1wKdsrcXvmk3H0Y3kF8JLCXqT8os9JKaC/9IN
         OsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761772753; x=1762377553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1CUzKaXRwGZ4xVedXqdBXxq8iuSvapH7cVHMvXbf9w=;
        b=EMsBSAyQdSKLF0H4eIuLIHzfiO9PLtFVD2nIKpU/lwpRpIZFPUV6FAG4u5kScGSizj
         3z0wXaqkEYrurf9T6cbSVh0kdUOWQEnD4v2/fCsfLWEbQquSFQ+j1c+CG8IiApeeulUX
         4X5AHGi385LDp2uqEoFhQG+PkQJQ1kRqrreB3ZbFPUI9abgYUeWJXYUVSJDdet2TFIKi
         okB5B74O8J3u2FwomCuBA/YX8dQ75YGM7Pa7mL8Brus+Z/2vvnxOBIegCxnj1IEE1s0H
         +et/yTNVL3bxQk3oBQOAjRw/oY9EcTVdBYmOeRg9dM6VzsQDEZymheuZ3LAy5hDUixkg
         uL1Q==
X-Gm-Message-State: AOJu0YzdsPYsdswZ/l9Pi1XGmkw3dR2apBMXT+/YxA1AdlHhbUHleCbj
	o1gyMaCDrwq17HBvKxnX2hH83A2LGIpWtHJ4nMGqFAjjmY387f8ywmw/MOL1HQ==
X-Gm-Gg: ASbGncsrn2cjV0Mkmmiy/mRVnpytTh/jzReKFnihEVRoDN2vfu0tgBbL5bLjxFmNPty
	qgxv08Jh9Tz81jk6AcUF+MhxhT7TF11xBqmGcQ8id0EX9eBfoU0z/mrUJbPPSM36lNRo/DLYhUI
	UbQP649/NUsCQeM5RQOS/hst1UAhSCcwfGO1l4D9HWHKu3F5xkISBRAmpQi3yF5TZzpaW2MpsBX
	1+iqHcHyjUmZYVxRpC5l5eTZIMaawUnUrm0cj3YAI8qL+m4/CWKVzH4G2NWGhfsDgeDbIwVQGQT
	ExFa2rYhwd/UfQr6veFihIFKAABj624ALWJZn8f3AY4Rr4dRLcS6P5feew6LVBCY/uV0o876dP8
	4AO4r0mxnrCYZkyUbIMtajzW4Q3y6iCH/WBNr7qPQ/hpXpB3XkRrD+KqTrRBdmwMEmaD+QssfcT
	V6eqCkpUTPzfhM91ougIPmqQo9D4YvuNlNVl+oBogL
X-Google-Smtp-Source: AGHT+IG4cmURumLwAPZ3N+Ke5X9YzbSNmQIxFVSoccG2ILBIlWx8hfl2h4eCVjitRY2+qgBsUt8ixw==
X-Received: by 2002:a17:907:7286:b0:b3a:7af8:c4a2 with SMTP id a640c23a62f3a-b703d2e2094mr493428266b.10.1761772753355;
        Wed, 29 Oct 2025 14:19:13 -0700 (PDT)
Received: from localhost (62-165-236-60.pool.digikabel.hu. [62.165.236.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b704d7a9867sm165219266b.46.2025.10.29.14.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:19:12 -0700 (PDT)
Date: Wed, 29 Oct 2025 22:19:11 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
Message-ID: <aQKEz5bnPHuCSjlR@szeder.dev>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
 <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
 <aObPzzLtZzodZf+Q@szeder.dev>
 <aOdIRnB-SGQwj935@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOdIRnB-SGQwj935@pks.im>

On Thu, Oct 09, 2025 at 07:29:42AM +0200, Patrick Steinhardt wrote:
> On Wed, Oct 08, 2025 at 10:55:43PM +0200, SZEDER Gábor wrote:
> > On Tue, Oct 07, 2025 at 02:36:30PM +0200, Patrick Steinhardt wrote:
> > > diff --git a/ci/run-rust-checks.sh b/ci/run-rust-checks.sh
> > > new file mode 100755
> > > index 0000000000..082eb52f11
> > > --- /dev/null
> > > +++ b/ci/run-rust-checks.sh
> > > @@ -0,0 +1,12 @@
> > > +#!/bin/sh
> > > +
> > > +. ${0%/*}/lib.sh
> > > +
> > > +set +x
> > > +
> > > +if ! group "Check Rust formatting" cargo fmt --all --check
> > > +then
> > > +	RET=1
> > > +fi
> > > +
> > > +exit $RET
> > 
> > Our ci/*.sh scripts usually rely on 'set -e' to catch failed commands.
> > Either this script should follow that convention as well, or the
> > commit message should justify the deviation from convention.
> 
> Ah, good point. The reason is that subsequent commits add more checks,
> and I want to make sure that they all run even if previous checks
> failed. It's otherwise annoying to fix a first set of errors surfaced by
> the CI only to then notice that later checks also fail.

Well, OTOH, it is annoying when the error messages from a failed CI
run are not at the bottom of the logs.

