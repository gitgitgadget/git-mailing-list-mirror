Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03651CF7A6
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539502; cv=none; b=JGZQgPzCItKbU6fKDI+t0kCAIrh9iS1tioozn+Mt1qWqE+QA+ZHDf52KdWWecdO3wp3XalJKYg1Fk29Y1Q7+m49ALbQ9Hm62ufbSjaLf8vVBsxoZSypkP5GBm2pMEpxNOv6lygpfUq+MlzJSI6hoeCfEMjqUyYBz+iFfQijKbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539502; c=relaxed/simple;
	bh=yHR+vyCzOraf4mA5qynWHI0zvai2yUQfWHUDALH3Og0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frWumPdsjERCH+V0WIDG+iDLVscWFsatNUaQIPohBF2iZWxkWW3kyARgKbeSevmZS2MRMlEQdTWHVsoMnTs8F23b078jjNl5YZ/SL+38AqD6kZGqfg05AaHGCHbP3eIQJurbI2xO9b39KtX+vpt3Z+XEqZGxXTVVva59pmj//wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2U7QPkE6; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2U7QPkE6"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e214c3d045so37881267b3.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729539499; x=1730144299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=deQFgJnbvoROKlvp/UG6p+9aLc4R7lc3NJlg2NPHxhk=;
        b=2U7QPkE6UBkdL8UXcry/FrlOqNnpwAvn2EM2ul7nN2NrdGqnGjcm3cORLgIgywcBEm
         a+0LWo9KNoqVjTs3BZm+o73ZYiUFR2EDG9u/xiTD4lTPgXKeaHMWBT+JrOrK4uvPYTUA
         OG6nlwhkN54jJEmpqjboaSLGScnZXcagieWLaNIAoN9WqMwKnAc30V9+KOU59JV9mc5L
         kDXankDQJS1EPHPkG1YPqESaUSOnIIUmVc50w7Y/WTUXxKHu6etmfNiWnfx7c/mjl823
         3dzveYqrDNDH7P4eMTe7Rq3uI5tW6zYoC0arWQID1sceIm+EDnaLXh2bkItTxomCRqII
         zs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729539499; x=1730144299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deQFgJnbvoROKlvp/UG6p+9aLc4R7lc3NJlg2NPHxhk=;
        b=bqSALZzdAtlukjlNdsmPA4+Al+hc86cLlmcQjAVm/+LnW92ZNMizkCWaDgpBodnr7v
         pRlfEZslZx2QH4U4wt34qAoH5R5Pv87cz4mE8Sh7ojousWzM0O62RcvNWHI3jVeiboSy
         XXQmfVjV+45p1l1MwwcoQi9Hsp3nRGKSfvcjSjuRuBOUCYVr4zMU1ziaU7gnEKpR1glz
         n8QUwNbxwg/UecpezpQUHSIuqFYmDJnvQzFdJ9KUlgtR8KRkdou/usz9PujH7OgPpT30
         Zo3AEWBYe6WLywkL5wWBWRrosIL1d5hPDhpq1JTXOmJ17nsHdyqCSblTHW0YUWPnPXTF
         rUaA==
X-Forwarded-Encrypted: i=1; AJvYcCUn33f8eZoeQj+Yy5hhQfM+pDaFryTX4+31a2RytGOxLPc4UgCgCZyELCnXLmF0sjBT18E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAnCb7Cl49vaxYC/peZkh2IyT/yf1oOQ0CwHlf5XoH//pYfv/E
	3tXdF7dbHE3ruXjBBaHiIZ250R6nsZdPNS5/8Q5TLkWHOXmHlcyKPUtfUvEyEEY=
X-Google-Smtp-Source: AGHT+IG41adySv/1MvgaB98yTPImZKguBmr66lZ8HkljxTNBTPfS869L3wnPU2A+R5sJem5JqCqbGA==
X-Received: by 2002:a05:690c:3747:b0:6e3:34b9:961d with SMTP id 00721157ae682-6e5bfc8ce70mr116310177b3.38.1729539498777;
        Mon, 21 Oct 2024 12:38:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f56efsm7998457b3.3.2024.10.21.12.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:38:18 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:38:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Philip Yung <y5c4l3@proton.me>,
	Y5 via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: setup pager only before diff contents truly ready
Message-ID: <ZxatqdBiB+NoMP+j@nand.local>
References: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>
 <20241019211938.GA589728@coredump.intra.peff.net>
 <UZMh2lyzbLOgsf0PXfMnq6HnWVnCK3y36jY3IMKUykPi74ztNucf8bgywoeO0DdeApq31JDDGMZiEya99zAcI3l8y_zcVqiN8FpEnT1DRZU=@proton.me>
 <20241021190045.GB1219228@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021190045.GB1219228@coredump.intra.peff.net>

On Mon, Oct 21, 2024 at 03:00:45PM -0400, Jeff King wrote:
> So I think in an ideal world we'd:
>
>   - convert those two commands to do the pager setup themselves and
>     retire the USE_PAGER flag entirely
>
>   - move configured pager handling down into more commands. So git-log
>     should set DELAY_PAGER_CONFIG and then call setup_auto_pager()
>     rather than setup_pager(). Ideally DELAY_PAGER_CONFIG would be the
>     default, but we can't do that until every builtin makes its own call
>     to setup_auto_pager() at the right moment.
>
>   - push calls to setup_pager() (or setup_auto_pager()) as far down
>     within commands as possible (right before we start generating
>     output). Your patch does that for git-diff, but there may be other
>     cases.
>
>   - consistently handle pager config whether USE_SETUP is set or not.
>     That means git-diff should set DELAY_PAGER_CONFIG, since it handles
>     the pager itself.
>
> And that would make things more consistent overall, and avoid pushing
> early errors into the pager (though of course it would still be possible
> to get some errors in the pager if they happen after we start it).
>
> I don't blame you if you don't want to start down that rabbit hole. :) I
> think it would probably be OK to peck away at it incrementally, and your
> patch does that.

Nicely put. I think what's nice about the patch here is that it starts
us down that direction you outlined above, so we'd want it regardless of
how much of the rest of the work Y5 is willing to do.

> > > would be missing a spot that needed a new setup_diff_pager() call, and I
> > > suspect we don't have good test coverage here.
> >
> > This is actually my concern as well when I was naively testing the coverage
> > using GDB, which turned out to be quite tedious. Would you consider it's fine to
> > add a pager consistency test for builtins, probably in another patch with regard
> > to `t7006-pager.sh` OR a new test `t7007`?
>
> TBH, I am not all that worried about adding tests just for your patch.
> You'd need to identify all of the possible diff code paths in order to
> add tests for them, which is the same thing you had to do to fix the
> code paths. I was mostly just commenting that we're not likely to be
> able to rely on existing tests to help us here.
>
> It might be worth adding a test that shows off your improved diff
> behavior, though I would be OK if it was a representative command and
> not exhaustive. I think adding to t7006 should be fine.

Agreed.

Thanks,
Taylor
