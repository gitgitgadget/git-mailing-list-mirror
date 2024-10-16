Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778FA1D1747
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112371; cv=none; b=kLAVE0PrZdTuuRMVpN+9Qb16LLZXGn2U+4dDPXzhDQVvT68pIrxV097ZKVhiIGX0+ocqISueQ6wV2tIMt2eDT3H5nZoyPt8ykbGhr6kDrIJcuV0kA0lVyc+I3ofCPKbRjTjH/FaiYY+I3L4jmlhwMl4LHpO+4zvezuINc1VMiOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112371; c=relaxed/simple;
	bh=+gIpDYWxSU489LdIk8IkC0KQe+aTh3Ahf7zlo6iMWnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmFzAIhfbatpojbn03s9mjcOrVU/I/fr35iVCpi36mMbKgcks2JnlMmokRfdTK1BGaksD9bFaa8XOvDlQ5oFA7ZZQv341HQLhFbfMVQjlfaBKZ1UcGWSiMlhgCCJKXjMd/sV/LsKgruUP3+6U+H8vam0eUVv7BBtCva/0LCSwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oJAzQk8l; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oJAzQk8l"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e3a97a6010so4503797b3.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729112369; x=1729717169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/VZcC2gA3r13+RT9eS03Tq+K7FeXvpK2HtKCBXEVa4=;
        b=oJAzQk8lAqClpQ0yNBK4iXSyONdtLqQVb28zu/OV+u8EH6BSF/3/QzDdN4DCKXMixS
         WoW5ouA3AUBqkZXtRLjivR/bU/3QqAAsx177gvckVm+AMerhie8NjmDLNZ4fGcc7qw3Y
         x6ubLyTBZC7oN2O40YSEmDJBtgAK3Nlqvucwnck6eVY2DGP1JKgNn7tgtpcevtGCGDsf
         n3xdVg6ld8w7qx7eicStw2/AwMlq5eF8sKki124Wnv0UU6UefSaS/TOo8F5AK+iHSu7B
         WqPpB2oZVJ1MIMfwryGyE5mr40OMgP5zB+3QN4lrZ8WDekhE9oVzn/euYL5EfnfJ+j83
         noww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729112369; x=1729717169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/VZcC2gA3r13+RT9eS03Tq+K7FeXvpK2HtKCBXEVa4=;
        b=S+QD5sR91llUyL9oXa6r/IChIl4tOs17jxHgxzR2C/nZS5S5jMgBjIxBw1uCxqhfSs
         iXny3THcrKCLlojppjdz8QJ2lnQcGNMAS0X8lg+RGpQo5//Y+feFpMv1khL4NyX+dikr
         0SfNWejv/8inz6xxCEs5GZ1wA19n090hWKw2M3WSmDDPECTtuWHy9OvTNAAazcs2M2Vb
         o2cRme0cRkceqL1fYWBJfXd3fZW+mBISE/CcNto125WsfXm3b2BMws5rddZ+vNYDP3se
         WYNm7igCYhTB55wSlLkOu3hHa07zCpoiPGFn7eaBcHm0EcNhRW8HnofaeLR2YsGPl7Ur
         fFbQ==
X-Gm-Message-State: AOJu0YxIfVJZskyTr0+pkeLrf1ysUSCMOIu/TOhvHRBxOZb747yw9CXt
	Memcca9U9cKdagy6vUIb4ILqgIxACnYnphKOY7jIagwcAKf1GmZ5nXWRGs55s6dN3Pzg9W/7Ng7
	r
X-Google-Smtp-Source: AGHT+IGGhfI2fRgixDJ6nH6ekg8Bbhy9C4IqrNRbUIXpvru3p88h7aZ3GYdhR63UcYVcDiRNgBvs3A==
X-Received: by 2002:a05:690c:10c:b0:6e3:da91:3e16 with SMTP id 00721157ae682-6e3da9157bfmr30768897b3.22.1729112369402;
        Wed, 16 Oct 2024 13:59:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d26220sm8529697b3.123.2024.10.16.13.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:59:29 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:59:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/10] t/test-lib: wire up NO_ICONV prerequisite
Message-ID: <ZxApLn9Qf4hdAlBL@nand.local>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
 <f6a8582c34a7b77aa3e2e45298208050333c384a.1728992306.git.ps@pks.im>
 <Zw8AaF4VOaQO+P2M@nand.local>
 <Zw85joY3Hqzx23xc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zw85joY3Hqzx23xc@pks.im>

On Wed, Oct 16, 2024 at 05:57:10AM +0200, Patrick Steinhardt wrote:
> On Tue, Oct 15, 2024 at 07:53:12PM -0400, Taylor Blau wrote:
> > On Tue, Oct 15, 2024 at 01:45:11PM +0200, Patrick Steinhardt wrote:
> > > Further note that there are several "!MINGW" conditions in t4201, and
> > > all of these fail due to iconv-related errors. This is quite likely a
> > > leftover from times before dce7d29551 (msvc: support building Git using
> > > MS Visual C++, 2019-06-25), which switched Windows-based builds over
> > > from "NO_ICONV=YesPlease" to "NEEDS_LIBICONV=YesPlease". Consequently,
> > > adapt those tests to also use the new ICONV prerequisite.
> >
> > This appears to break CI on Windows when I merged this into 'jch':
> >
> >     https://github.com/ttaylorr/git/actions/runs/11355564982/job/31585450667
> >
> > I'm going to temporarily eject this from 'jch' and 'seen' until we can
> > properly deal with this.
>
> Ugh, I'm looking forward to the Windows jobs for GitLab CI being merged
> down to next so that I can finally see such regressions before they hit
> our trees. Anyway, thanks for the heads up, will have a look.

It's OK. Ejecting a topic out of 'seen' is relatively easy as it
requires the following (after removing the line out of Meta/redo-seen.sh):

    git checkout -B seen jch
    sh Meta/redo-seen.sh

I was mostly confused why my build of 'seen' passed 'make test' locally,
but failed CI when pushed to GitHub. Of course, I'm not testing on a
Windows machine, and you didn't have easy access to Windows CI runs on
GitLab (for now), so the result makes sense.

Thanks again for working on it.

Thanks,
Taylor
