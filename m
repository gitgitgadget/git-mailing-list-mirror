Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88E1EEA3B
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817592; cv=none; b=ZuDxziApzQ7LffHnAEQ5bwM/uU4Cw7XHbDLhZsTJi+1kWHcDOz8m3sZyVlaa/6rveW20TE+1I0JgQRfwEeO2KMiJ5AaQkmcZFKTc5/sD3qTc7J8BQdd9/VqImQMmqRqCrjMpH/evMbwOlbqp5lqihXciXpTfKLiLrJdc8VVHe+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817592; c=relaxed/simple;
	bh=j/kF09mYPlfRJdv5r9NdGtngDHIkzbigEvNTivuPFpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSdqDygjNWeK4TzflBPqAnAU6TjM+cSem+hK6ct2DY1Y4QE53rqML+F6AkPNHCwn80yzloLZSTR1U/PZY04NNKRs902EU9i5TI8oPTXH+tAg8m8e2sjUjaix9yQONV7Wi2I+Zn3XBHcUapB19BwJx9FUHXdIZe1/63uA8It8uLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3pJ/6bM; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3pJ/6bM"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2b199bb8af9so989995fac.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741817590; x=1742422390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PsG3Mfd8J36kNGr57YjzsnsnzwyqieOHu0/GkApkXHQ=;
        b=e3pJ/6bMRmjEFf3GuVUYd5GXQIeVsjw3YNx748JP2wvAYPycslIxLzAZ1JkQnpBiBU
         yuWQyLxL+5cSfRuaUu7j/IMteOqJqLrwVQ+WOXSyTS2TAOZvBBQkfgGjeU6k0AV/iE/h
         y9TZyIpxd8TFmzQVn2OsjNctnJeKHwpOxpR5sLNt7eV/LED1zDr0AwYMhJxUAECdVDD4
         KcP1sM1OI3XRHpBGXdl3FKYgfbLJQbTLlQ7OSJ4z5NlV87O05um6Zcj1blvjvNdzBb+q
         dgghkmREqnn8svc+5KAf3mxJ10Ef80+32jwTzDiHZzk4PkuKwXuUoq+8O5DHC1YTmVMa
         M4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741817590; x=1742422390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsG3Mfd8J36kNGr57YjzsnsnzwyqieOHu0/GkApkXHQ=;
        b=pbfhUwSe5lru/UUDBvlIcC85mxXxKTcKEjvJg5Iy687HZegfHFhBlqlo0xIALrZxap
         wqdUT4wjtEptP2Z+bAOOk//fcoXTESNnsZWWQg9UuKy2gN12yPCam+GMbghZHCkbHTwh
         EOkRKWu5S+Jb8aMIEZxAXyL4n9HHRdhMJ8VgpZs8JLlSbZW0KVLrmIYO6yGLaVRUW2cr
         rzM0U3CgIKQkPRQOzqspRQh4AbA6Lmg+jvrOkLHIhvLNScQQFBtAWieIPfM15mQOO+9o
         7jVaSfez6bJX4Psm7fGxa4hGuncdB+MX+X74r+PIS7gNKmpIBZZL2M816GodNXB6c3AV
         8UYQ==
X-Gm-Message-State: AOJu0Yw98dUc/1cLa5tUwd6YRoYwhVKMkdIueF2CUHFf4o9HHiL6gaab
	5GBUnRaPXF4sjSKfw4nIYK8AlKF40ASCb09j6Uix78V+527bgiOrLdByng==
X-Gm-Gg: ASbGncvQYrfwifw6kZvV3rvzcD4Pg8V/0XzBEpC9rklbM/xMUCWxQbG4UosSP1PhYAT
	qvTXS9LDGZN79zsStiW+Yzgx5qFJVlXYos21Og2pTo+Um6kU8ReVaZYXXNNOeL9pJCGxmZ21RWw
	26oJsETPEz8/qnV9OI2SU4O3aTyhclxeoS4PcWqf/pg4wqneH8ME638+RYLD5S4yT42P1M0W3h7
	ALwS1Ehyd2tvTILsrRcvP8gO+K282Vc9T70DOHk1MnFHfb3wBywxIdQPsOstUXO7dKrUd2GtML0
	KrL6CtdxyHP3ehzVKfob/IEsowt9W5PBxYfEwA==
X-Google-Smtp-Source: AGHT+IETu2VRyBpBgeOuhnLCzvRSoARZFtVPPfq34yRGFtZvQ6RfyWHD35N0WsFPk2nLXJW7QIJKhg==
X-Received: by 2002:a05:6871:3285:b0:2b8:92f0:ba5d with SMTP id 586e51a60fabf-2c66f88b26fmr122567fac.8.1741817589978;
        Wed, 12 Mar 2025 15:13:09 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c6712e5774sm3943fac.31.2025.03.12.15.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 15:13:09 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:09:41 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <sm5xvh7bipyrlpw45bptlctbuhey7v3qktpskal5dzexomt34f@wgfziyhcf3t6>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250311235720.GA73755@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311235720.GA73755@coredump.intra.peff.net>

On 25/03/11 07:57PM, Jeff King wrote:
> On Mon, Mar 10, 2025 at 02:28:25PM -0500, Justin Tobler wrote:
> 
> > To make machine parsing easier, this series introduces a NUL-delimited
> > output mode for git-rev-list(1) via a `-z` option following a suggestion
> > from Junio in a previous thread[1]. In this mode, instead of LF, each
> > object is delimited with two NUL bytes and any object metadata is
> > separated with a single NUL byte. Examples:
> > 
> >         <oid> NUL NUL
> >         <oid> [NUL <path>] NUL NUL
> >         ?<oid> [NUL <token>=<value>]... NUL NUL
> > 
> > In this mode, path and value info are printed as-is without any special
> > encoding or truncation.
> 
> I think this is a good direction, but I have two compatibility
> questions:
> 
>   1. What should "git rev-list -z --stdin" do? In most other programs
>      with a "-z" option it affects both input and output. I don't
>      particularly care about this case myself, but it will be hard to
>      change later. So we probably want to decide now.

As others suggested in this thread, in the next version I'll make
revision and pathspec parsing on stdin also be NUL-delimited when -z is
used.

>   2. I was a little surprised that rev-list already takes a "-z" option,
>      but it doesn't seem to do anything. I guess it's probably picked up
>      via diff_opt_parse(), though (I think) you can't actually trigger a
>      diff via rev-list itself. So even though this is a change in
>      behavior, probably nobody would have been using it until now?

This is correct. Technically git-rev-list(1) accepts all the common diff
options because it invokes `setup_revisions()`. From my understanding it
isn't possible to trigger diffs so I think parsing diff options is
unnecessary to begin with. As it also isn't a documented option, I
figured -z being an accepted option for git-rev-list(1) is largely an
unintended consequence of it using `setup_revisions()` and should be
fine to use.

>      If it is possible to see some effect from "-z" now (I didn't dig
>      very far), then it may be better to continue to let the diff
>      options parser handle it, and simply pick the result out of
>      revs.diffopt.line_termination. As your patch 3 is written, I think
>      the diff code probably doesn't see it anymore at all.

As currently implemented, the early parsing of -z doesn't effect the
diff options parsing in `setup_revisions()`. The early parsing doesn't
remove the option and thus it continues to be set in the diff options.

Furthermore, revision and pathspec argument parsing is all handled in
`setup_revisions()` so if we want to NUL-delimit arguments parsed on
stdin with -z, we would still need to parse the option early anyway. I
think it should be fine to leave the early -z option parsing as-is.

Thanks,
-Justin
