Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06E21DED76
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134499; cv=none; b=pO82Al6sIp7L7L7hG9acsOU+hQ1WI60byBKEl5XxtoeC5pmRBKHwvvsUfFp+MqttK33SWrNcGe95yAf93dgeJ5Ak7lCynsINLmLfOPGmNNx9fKTZhcR3o8plhDlD8KHAZMFchoWKXSOa8fyw4Sck6z0v7IwYUk7MMRfj/OuiJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134499; c=relaxed/simple;
	bh=+xQxyYSuUxLwGkyUD9wT5gQ/iszJTSa30pT5mtiSQ68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPKx+qJhc6+0zSKeQB3urdoOattAMut3oL1hjBxNIVfyUwIiMG6uJWu3STRnN1KfLtbUfsnRvREkWWYPN2DPgvIWJHgOj1RN659x+zHkKUvo8iStMkFFHIGmsVFLx0Gx46ujH9QpgEpG92g8pUpwipuelbFBYT9fFFoJg25z3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BkQgwoJW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BkQgwoJW"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e5fadb5e23so39489327b3.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730134496; x=1730739296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZP21e0Z3IkznqG0P9cusAkCDmmQCbriXcNiEevErVI=;
        b=BkQgwoJWMdlosdt0EgIj4lxZuWavqUzoGffAqc1FxxyLN67dMFNLoVNpKmDEXIALzB
         ZpOjnYnKirKUpnZV6xeYR9CVUsou6mGPDBUmWjZ/UbvaRjphVspAj+ZMk4aRwfLK6YL5
         7R1CCKnMQwzzu+JOOSMS03WwZ5xKAs40so7SKGrKiTet+8BHUCipkmWZpCCRLOJz4nG9
         fGwpRRISlZxV+W+h9EWFjKzUm8lrfbK+NUOyeYzccWkXUIDd45WPIsq17j5M6rIXUUnI
         HIb6zz3R6uBDNcoIUFt5qwmwEzU/8GtnWwPmTLqxrDvjf94mBe1CnouAPd/eR8tEpj7d
         KmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730134496; x=1730739296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZP21e0Z3IkznqG0P9cusAkCDmmQCbriXcNiEevErVI=;
        b=gVrXPo7ct2XUw0w4fygC7rxEaluyXwSreJmN0sBDa80H96biCmEmt9oqfDLbhkpvjI
         JaY09Kob9ee5d1aiBgZqPFxfrvxdTd0dBX9uc7XNRKLpatwcyYNUgc2HdP1Q218Nr5my
         QFBy094EvHE0A5OUqvOqTks5TjjY48gZRPdKa88gYbFo8ekeZiSIKiZ2H4ii1V9YcB7u
         bY0hD8UTn3ihsjLJQ7UH1IvEPxptkq51jpEfp5uFoM2qCki87MlMv3ioUVcZXldCKw8N
         1VVY87JM4qb+c+2qMpHbW/x3sKlMP8wlYlJkRlYi8TWBFu5gi1J4+O0Eg6pG9u8QAjsT
         /NMA==
X-Gm-Message-State: AOJu0YzexBBb6x7qg0SBSuc6Mm0dO9Jiz+GgqCqBpuR90OlGFm3dLuBs
	ChhET/4+yXa279EXvDwpwzMcBJdezntHaaKQYEOh7GaneBFWjpFfaMU2M/fhTMc=
X-Google-Smtp-Source: AGHT+IHXcJKMqdrGERyAmXcNar8SjV6S6CapR73s/nIArB4zN21q7rQC1QgbEu5qHkUaksT512rGyQ==
X-Received: by 2002:a05:690c:3184:b0:6db:2604:ea6b with SMTP id 00721157ae682-6e9d8994e57mr66542267b3.25.1730134496656;
        Mon, 28 Oct 2024 09:54:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bdda19sm15145777b3.44.2024.10.28.09.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:54:56 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:54:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	shejialuo <shejialuo@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 1/2] worktree: add CLI/config options for relative path
 linking
Message-ID: <Zx/B3caIgAeAv6Kz@nand.local>
References: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me>
 <20241025-wt_relative_options-v1-1-c3005df76bf9@pm.me>
 <Zx7YFPE5tjr/bn2s@nand.local>
 <Zx7cKN9X56GrHrU/@nand.local>
 <D57L2P544W08.2MHA3Q38UBPEO@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D57L2P544W08.2MHA3Q38UBPEO@pm.me>

On Mon, Oct 28, 2024 at 04:35:22PM +0000, Caleb White wrote:
> On Sun Oct 27, 2024 at 7:34 PM CDT, Taylor Blau wrote:
> > Additionally, it appears that this patch breaks at least t0001-init.sh,
> > but others as well. The relevant portion of -vx from t0001.46 is:
> >
> >     --- 8< ---
> >     + git -C mainwt config worktree.useRelativePaths true
> >     + git -C mainwt worktree add --detach ../linkwt
> >     Preparing worktree (detached HEAD 89e2b84)
> >     HEAD is now at 89e2b84 gumby
> >     + git -C mainwt init --separate-git-dir ../seprepo
> >     Reinitialized existing Git repository in /home/ttaylorr/src/git/t/trash directory.t0001-init/seprepo/
> >     + git -C mainwt rev-parse --git-common-dir
> >     fatal: repo version is 0, but v1-only extension found:
> >       relativeworktrees
> >     --- >8 ---
> >
> > Let's please fix this breakage, and then decide what we are going to do
> > with the extension in the second patch relatively soon, as I worry that
> > putting the original topic on master may have been a mistake if it is
> > going to break worktree pruning on earlier Git versions.
>
> Thanks for catching this, the issue is that there's a bug in the
> `initialize_repository_version()` function when reinitializing a
> repository---the function doesn't check if there are other extensions
> in use before downgrading the repository version to 0.
>
> This is a rare edge case, but I'll work on a fix.

I am confused... are you saying t0001.46 is flaky? I don't think that
it is, as it fails consistently for me with your patches applied when
ran in a loop.

I am definitely guilty of having sent broken patches to the list before
that fail CI, usually when I have amended something I thought was
trivial after already running the test suite on all patches, only to
realize that it wasn't trivial after all and instead broken something.

But please do be careful to thoroughly vet your patches before sending
them to the list, as this sort of breakage can be disruptive.

Thanks,
Taylor
