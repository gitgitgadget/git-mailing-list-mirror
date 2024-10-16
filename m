Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D91212EF1
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101000; cv=none; b=Aw1Dhf3Nrih58aMPYjn7FO7VrEDY4dl030cQFzPKFxAqWG5rTVfY18BOqoPP0Mkbk6999kYE/NuqWv2ZVonTwkakS6FWtltPgCbJ4wIAv657mrQ3uxoOum+hc/sAZhRQDMbM1VSWmDmbprKxvOEEanhcEiNSqE6EghS16mqsUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101000; c=relaxed/simple;
	bh=WyqF82jGvdl2Bti+pE1rl86xyQ8XU1HsD/Kef9THpNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0vEREHX65EsXzc731+zlz55UvHdzQ0GvPPmaVotWQKEQVg5Uas71mAda0wqgLusT3p+c4dZiJ5acn7YKyY5ePZOhwR6+ldzrSjqHfItTenaBaHbrS+MTqYZ7Hn49RuaguBKz4lOtWu6ZG8m0gR69F1YWD4j27YTf7lxVirwmTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGgbe1Na; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGgbe1Na"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20caea61132so565365ad.2
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729100998; x=1729705798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFPru5gw2HSHOyP8JaDk9zlv+foNhMgpkfv8Q4Tg89w=;
        b=YGgbe1NaNEuA7SISdsqiPiUZjS4usHbfTnK2UHY8QJNyiVsGiAGS5P5uwZLjruGJat
         +lXy5t180fy4uQYQY8Wn8brk6ooxkoLLDiAWNnDYxfP1NcSdFgS6rUlZRiY7n7cm/RFG
         CQzhftqRRifqq3uHItcmSISez3w7utNPi6PLzHfYzGss8pw2o7USGaSjqSNamTwEA6Y6
         mWd49ruQK3UWgbbkNO7sJJQGJbQEFxiozq4SAhuvULCUUET/kGRVi5VFLJMCWncdR7H4
         YXcZibME98uj33LdtVBoB44kOjLJeHeAacf539rZw02RSLM/8OvnuYLtld3Z11FdwOFa
         oYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729100998; x=1729705798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFPru5gw2HSHOyP8JaDk9zlv+foNhMgpkfv8Q4Tg89w=;
        b=DbrQ7JAv5LGoOc5SQTujqrzZHW4Upl6lD5xbDR2HiB+VVPMJTnnOngqrDJ6KSG2cSq
         ZYz8h4mw9XBcCNGaTPtb2aREwJ3igdY+SMJ7x8pjezeH2kuTc8R+FJONffrWFEuxNTpw
         ZHCE4WZrNd7eQuZVkeqK9709mfrS6T6Jl8TfHu3LXTEQLZYDV8uu/SRbaQ80wI21qDXK
         5XEI4X97HhZWT0eGMDLAtV/zSwFFxfLXDxfunTbNCpbUFxRSlt2FyjYT+QqO2/21f0yC
         f0r0gxr5i6CflRKOS9TVvPYHR5XabtjlYVWWltu05GoEDaz5ublztu/Qsu0BvSW6vMgb
         Cz1w==
X-Gm-Message-State: AOJu0Yz8HEhees93aUu2p5PANkgF2nE16EcnMQrgIcjJustti6cI3iMK
	ML6m5pOgb7iNoQl/8V5d3YvaN82k5HJio+9plNywKrzHdhSGP0nGQrL5MTQU
X-Google-Smtp-Source: AGHT+IExDTee3TT/RSJWgFJdz6KpBMngK203uxf+l4sOHECW2Da0WJb8XbXGmEPTtxQ9oPNJM8bzNA==
X-Received: by 2002:a17:902:ce87:b0:20c:8b10:9660 with SMTP id d9443c01a7336-20cbb2845dcmr266883735ad.44.1729100997405;
        Wed, 16 Oct 2024 10:49:57 -0700 (PDT)
Received: from five231003 ([2405:201:c006:3236:dcc1:5355:4129:c7c3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e09280bdsm44967a91.45.2024.10.16.10.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 10:49:56 -0700 (PDT)
Date: Wed, 16 Oct 2024 23:19:53 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] pretty, builtin/mailinfo: don't rely on
 the_repository
Message-ID: <Zw/8wYmsPsmynYh0@five231003>
References: <20241015144935.4059-1-five231003@gmail.com>
 <Zw7Hy12qHhd5BhGh@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zw7Hy12qHhd5BhGh@nand.local>

On Tue, Oct 15, 2024 at 03:51:39PM -0400, Taylor Blau wrote:
> On Tue, Oct 15, 2024 at 08:01:21PM +0530, Kousik Sanagavarapu wrote:
> > Hi,
> > Just a brief summary -
> >
> > 1/3 - the main changes are in environment.[ch] and repository.[ch], all
> >       the others are just changes due to this change.
> >
> > 2/3 - the main changes are in pretty.[ch], all the other changes are due
> >       to this change.
> >
> > 3/3 - This is pretty straight-forward.
> >
> > One may notice that there are more "the_repository" occurences now than
> > before this change - which is good since it means that we have now made
> > the respective dependencies explicit (these were previously implicit).
> >
> > The change in 1/3 is marked RFC since I was kind of skeptical about the
> > "repo" check in the repo_*() functions being done at _that_ level.
> > Since every other change in this series depends on this, I've marked all
> > the other RFC as well.
> 
> I share the concern that others have raised in this thread about not
> having the_repository when one of the affected commands is ran outside
> of the repository.
> 
> I'll bring these patches into my tree, but let's hold off on queueing
> them into 'seen' for now.
> 
> In the meantime, as a style suggestion, it might be nice to provide a
> wrapper for function foo() -> repo_foo(), where the former still exists,
> but is a wrapper for repo_foo(the_repository) like we have done in
> other similar transitions.

Noted.  I'm thinking of waiting a bit more before re-rolling though -
I'll include this change there as well.

Thanks!
