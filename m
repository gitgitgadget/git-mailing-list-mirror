Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63139187858
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105314; cv=none; b=Cm1tMLf0GN00IqnWpEeK8Upg5u1tGesn98LSpOJsiNeeMv69KyI7O3FXtMUkDrR0qbDjxTVcJGMffvLXWql1mycwMhH0eOHeewB2hja+IFUqNQN0TbyPt+HtuGqwm/KIFKDuMouwRvl1B0qTPQ+8egACl4P9CXw6nN5k6xLAC1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105314; c=relaxed/simple;
	bh=bqjljcUkT0VOu6VwA4HmckREfy/6H1d30Wd6lqTpPaI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqYogWHybGY6vtgXgEKS6tyFE1rjZx2PYCVNFhX0Bqp45OtEDlkXQ9fHo7cZw1o8TWk0sTeVbg3ztFaNPMtmqxmRcqe4nMoP2U329tvnMWo/eiyAuQ9n2xbFtcrtat/UP/IrZr12wtGTnJ6pCdyUu2WgSfZLm+x42amXdCiX5h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VdqRG0dY; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VdqRG0dY"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6db20e22c85so2283837b3.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729105311; x=1729710111; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ymd46LhwTLvb6e5YQ91OHgqrCcQ986PLPn07lTkM3s=;
        b=VdqRG0dYO2UauLk/WMMfoCd+Zjt8CM2RsN3KFgzytwX8hmUPIKtnrBG9rRr8lZh2Ra
         alDUn7DxiTupURvTdvlq9i/zrndyF2RPq/p5BcZcs43m/qLPdkVamg6Jn/z7FJSDo7Hn
         DuMEm/wHSu/MQRTuTDqScL5BYOYoV1JqJww23SY5yOZlL1NQLOFaAP6Yk79kGJV0gcyg
         1F/YzeuonCJmXV8ZiiT+bWQx4XcGf7NoLyIwSUjaiuQ1OYssZBeIa3BSj6ccjtgr1CVI
         9S2m57yv3EdAGm6IyGT3C85Z48/+kT5+1IL48YJSYeLoTnkMUFq1wXshN0BRSdiCozA3
         0rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729105311; x=1729710111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ymd46LhwTLvb6e5YQ91OHgqrCcQ986PLPn07lTkM3s=;
        b=VMqlX9M+Tm5LsOEQi+zdByrw0HaNPbcrhLWa2L/aJYhsEItqVPqOBvuGTFvxGkMv24
         I7qrdJg5k8I2OOeKAMnw5vUzcGOQPDNSC+7MIooLWrS3mo5R8zrcXm8osxRfka2TWxby
         LwVFDAeNK9DUjIdBO68HKAHWscPDVnjDgyCV2vFtaoiqRt9mPkYeGp3lvk4CESuPAvuG
         j4me9mz0cZ9e2UedJcjINhEXP8LsLlLXjPQnxTTrZz4plh2NotJvw9GLWU/sq4eOU/cC
         QIFPEq8vsqQ82p3UveC3iheeaUvZ5aB0JE0eoG8zvIRcbJDai8+TkzEiLIM1y8IzKlxz
         28Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXqCRRpMTCoQKtXlkK3uTobjwl9RTmk5jMZBHWWevpBF+h2RLUnsX9rZ50w+n2dGUSgBtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzccFaqzWn3jtyOl/+nUsx7KRXHLrE8f3q30yvhNzLUNMScnBWQ
	Nd9vY6abnOElIgPxCyRBv16thoSVGMXu02EwNl39zfPQJDynsg0kDH3IVw9PJg91AnryVrVv5Q8
	G
X-Google-Smtp-Source: AGHT+IFHOqPctud0St/kXlKTytOCL55msarDWUAckiQMl+A+jaBpxd4T/Cj49lPSatvhoKzBxi3DTA==
X-Received: by 2002:a05:690c:a:b0:6b1:8834:1588 with SMTP id 00721157ae682-6e3d41c6c79mr55444647b3.35.1729105311080;
        Wed, 16 Oct 2024 12:01:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5b86ddcsm8049317b3.65.2024.10.16.12.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:01:50 -0700 (PDT)
Date: Wed, 16 Oct 2024 15:01:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [RFC PATCH v2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <ZxANnCw/yVzLl0yn@nand.local>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241015114826.715158-1-wolf@oriole.systems>
 <Zw9P90_QtiAAH3yz@pks.im>
 <gtdjnvonjodr435wuv2pofnww2pdcd33s22xxz5ypwkpvdythc@vrajz5ttkjbz>
 <Zw9_46fbvbGhjmYw@pks.im>
 <w6vzuumbd5vrdluvnheescdgw36teuj6k5anlyiphvpr6slcgc@2gkwe2ye26a6>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <w6vzuumbd5vrdluvnheescdgw36teuj6k5anlyiphvpr6slcgc@2gkwe2ye26a6>

On Wed, Oct 16, 2024 at 11:48:24AM +0200, Wolfgang Müller wrote:
> On 2024-10-16 10:57, Patrick Steinhardt wrote:
> > Given that we do set `log.abbrev` I think we should be hitting code
> > paths in git-shortlog(1) that use it. `git shortlog --format=%h` for
> > example would use `log.abbrev`, wouldn't it? It would be nice to
> > figure out whether this can be made to misbehave based on which object
> > hash we have in the input.
>
> I dove into the code again and now I'm fairly sure custom formatting is
> only ever done when in a repository. shortlog_output() itself, called at
> the end of cmd_shortlog(), doesn't do any formatting, only possibly
> wrapping the lines already present in the shortlog struct.
>
> That struct is filled either by read_from_stdin() or get_from_rev(). The
> latter is only ever called when in a repository:
>
> [...]

Thanks; I agree with your analysis here.

> So whilst we parse all the relevant options like --abbrev and --format,
> we take a shortcut through read_from_stdin() and never get to apply a
> custom format. Commit hashes from stdin are discarded.
>
> I'm not sure a test case for different hash algorithms would test
> anything meaningful here, unless the plan in the future is to have
> git-shortlog(1) support formatting when reading from stdin.

I think that in general it would be difficult to support the full range
of --format specifiers when operating outside of a repository, because
we don't have all of the information necessary to assemble all of the
possible formatting options.

For instance, let's say I want to take Patrick's example to test 'git
shortlog' with '--format="%H"' outside of the repository. There's no way
to disambiguate whether, say, a SHA-256 hash is either (a) a correctly
formatted SHA-256 hash, or (b) a corrupted / too-long SHA-1 hash.

So that means that '%H', '%h', '%T', and '%t' are off the table. '%an'
and '%ae' seem reasonable to implement, but '%aN' and '%aE' less so,
because we don't have a .mailmap file to read. The same goes for the
committer variants of all of those.

I don't think there is any reasonable interpretation of '%d'/'%D', and
likewise for '%(decorate)' as well as '%(describe)'. We could probably
go on, but I am getting tired of looking through the 'PRETTY FORMATS'
section of git-log(1) and trying to figure out how they'd work (or not)
without a repository ;-).

In any event, my feeling is that while we could probably implement a
handful of these formatting options, that it would likely be kind of
awkward to do so. Not to mention the user-visible awkwardness of
supporting some '--format' specifiers but not others[^1].

So I think that the best course of action would be to document the
limitation and move on ;-).

Thanks,
Taylor

[^1]: Playing devil's advocate, though, perhaps it is OK to document
  well which formatting options do and don't work, and accept that a
  user asking for '--format="%(describe)"' (etc.) outside of a
  repository is nonsensical and warn / return nothing appropriately.
