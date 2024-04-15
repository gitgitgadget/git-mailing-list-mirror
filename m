Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54152E852
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713220933; cv=none; b=XoNIEsEP3kLDMxb14lJKZRumvBdy9yevlEh3iQCGVH0pV1UuoodWIUuZiMce90el+VoPZvT5SaeWnqxey8bEG5Y1kj6PTg0MJPGEz1rCkBXtuQvMG/guz7jYgaD6m0OAXJPxPRglazVcFH0c0biMEMXY0BExSJZEYVZhvTFeGHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713220933; c=relaxed/simple;
	bh=bc9Mv6p93V8/MdZoyNb2HV6LTA4uzt1W+/pB+3v68Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rb0FhCN2YP6WSqfAfIn/eeQ0uXas8F72UJbx74jMMjtVapKLWSylkvtOttAoHxww5Sd1bcHzpxngMm5WuKSw9aeMYBUYXnpNSL84HOaaeJXh6W0e6UlA6lyYx1D1t0zKk+IlgEMQ2pG5Kykt0ShSqJvabKU+XQrm025E882aIyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PRF1hQyj; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PRF1hQyj"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso3988905276.2
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1713220930; x=1713825730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvbZRLHQUvJ6cfl2SNeJCYPrBK/pyWujOXmhqyVWi6I=;
        b=PRF1hQyjyoCpKfxYKxS1R9y14/lrpdicconJoXqY+XRbxm2AjHvzdRnSgvJ0Gc27LF
         H4jBAkV3V+8Nm13I3E6zKOIIFDMJHankybencjggEhFuD5qLJNASRPiG6QrHxxtlB/0N
         ycnN2O53/nv36lsrBjHQ1sBL5H+btIJCDIcOqsoG5WjfGsVW2bt9CnRM9yumNRXkAgpi
         jev+9pmXT0g7uNNIXaWXtVuyNAOwC5Jcaa6xsGa6ACg7z7OQy+g6XZ7kqypUyPEvZf1j
         ux2GF2CyklhPFDY+gabwzrK36Gfj4KlA7GXAD/FYhhSxxgYOwpgaaSW3IBMMJxDvUehE
         gy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713220930; x=1713825730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvbZRLHQUvJ6cfl2SNeJCYPrBK/pyWujOXmhqyVWi6I=;
        b=JS0fNz3jOwsFnSkucUUkm334TFC6U55ZXW2yMl4MAov9ErfpWXMEIYV7UaBOvVfm4S
         JAyw3E0QoAbKG1K1IH5pcEA8I+qWdukeaxzriGfUOab8c3L/EY4VG6734g36uCMsnXnG
         I4vNlUOtGF4e+eAkP1Lt6tUs8BDcCS2p7px6ZX02gpEw00I7IJooRebuSXfsRLiU6CAy
         uafNcunJVAP4rpLh/IzqCK/J9dW2qOvfU2sRF7PdWh7vXyUxnUW4H4itYS33Fz7r4TBl
         RDMZ4Vxua/JgYZeCCoEweM+cztOf1L5gYdj3n1FOqz8nmZsZN9hj51kr0k0FtNshMltL
         lgLQ==
X-Gm-Message-State: AOJu0YwuQWB9yvkYbGQyrxLmCSMSlXcX8TQFdJW7B35k3yYdQQVZIUX5
	e+oofn0IlhU2wHalaGGEUF+Oq8JXtV0HtX2fuxuzf4Bu3pWIqG5iGdir+CpcwMCozHdTKuvNfoH
	wUPA=
X-Google-Smtp-Source: AGHT+IEdIhNXqzxrHdUM1Z3RCNOTxacoV4REzdYS0H3qR68Xb3Fb0hpzl9sHkkgFvbR3jdWuZatX1g==
X-Received: by 2002:a5b:385:0:b0:dcc:933f:ea83 with SMTP id k5-20020a5b0385000000b00dcc933fea83mr10150237ybp.30.1713220930518;
        Mon, 15 Apr 2024 15:42:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m8-20020ad44a08000000b0069b7eb7edebsm1593818qvz.71.2024.04.15.15.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 15:42:10 -0700 (PDT)
Date: Mon, 15 Apr 2024 18:42:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] pack-bitmap: gracefully handle missing BTMP chunks
Message-ID: <Zh2tPdvhQgD4342C@nand.local>
References: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>
 <Zhap8iyMYytCM+on@nand.local>
 <ZhzKeR9C4UVpEm29@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhzKeR9C4UVpEm29@tanuki>

On Mon, Apr 15, 2024 at 08:34:33AM +0200, Patrick Steinhardt wrote:
> > Of course, that is still using a GIT_TEST_-variable, which is less than
> > ideal IMHO. The other alternative would be to store a MIDX file as a
> > test fixture in the tree (which we do in a couple of places). But with
> > the recent xz shenanigans, I'm not sure that's a great idea either ;-).
>
> I'm happy to convert this to use `GIT_TEST_MIDX_READ_BTMP` instead.

Thanks, I think that is definitely an improvement.

> > The way I would structure this series is to first apply the portion of
> > the above patch *without* these lines:
> >
> > -	if (bitmap_is_midx(bitmap_git)) {
> > +	if (!bitmap_is_midx(bitmap_git) ||
> > +	    !bitmap_git->midx->chunk_bitmapped_packs)
> > +		multi_pack_reuse = 0;
> > +
> >
> > , so we're still able to reproduce the issue. Then, apply the remaining
> > portions (the above diff, the test, and the GIT_TEST_MIDX_WRITE_BTMP
> > stuff) to demonstrate that the issue is fixed via a separate commit.
> >
> > I'm happy to write that up, and equally happy to not do it ;-). Sorry
> > for the lengthy review, but thank you very much for spotting and fixing
> > this issue.
>
> I'd prefer to leave it as a single patch. Junio has expressed at times
> that he doesn't see much value in these splits only to demonstrate a
> broken test. An interested reader can easily revert the fix and see that
> the test would fail.

Yeah, to be clear, I wasn't suggesting adding a test_expect_failure
here. I was suggesting instead that you do a refactoring that doesn't
change the behavior in the first step, and then add the test plus the
fix (after it is made easier to land by the first step) in the second
step.

But I don't feel strongly about it whatsoever, so I think that the new
version you have here is fine. I'll take a closer look at it right
now...

Thanks,
Taylor
