Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5542FB6
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719626555; cv=none; b=Akma1IC/b7Dl3IqEeIKSj8KFTvZWZt12QlBj0trx95/r1yFGhBs3ImciCuYXPwiuJGnrNp/W7U1/YEpnhC/kbWQWkU1qkPLT0aJH1SaPli+VKBHba60cvUO+6z/bKdQuSyPG/uSU/vbg3250q1bHELS7rc34zxUUn0hUFA9tTeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719626555; c=relaxed/simple;
	bh=ThQcTiXKkNbnb/J9moX6GvzKd3yYRfcKIOhO8Pq2fSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvcibSj5U0EVKTrD0FDx4V0OG6Gy/xzFqfUcL9V14nY7vVeGod/Me91Hsqpb4peyXUvYaVoRJZARy1dY8l2kK0MhiLYDF12oGCvdSPJdSl2fYV99RTIBwJaKUqcIf8M7UCn8pyqOqc8sOAHzNFeUsI0NEh5F0oRWQumrgO6z21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4ulYfuG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4ulYfuG"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d15b85a34so1345964a12.3
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 19:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719626552; x=1720231352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vV3IXLJ+rp/mQQSIUSn6bNU9LfKWkd9AX7AOX+5g4ig=;
        b=Q4ulYfuGL8u1bvT4UuG830A9F83IOzj14/d/GSaMnFqQVIVM57jz1F0DswaoE3Xi0B
         FxWJm9G++dWXrLJni8tAO77MAcB23t1FsXZfX9zKmD7MSi1m+dHzeSYhhf+cA6ttVoLR
         H3MOB0Dp4htqMyAcPvcLs8pXjqJDwFTO5Zk0G6bT1Q3YgeWZA5DaZf6JH/PzaO9hQ95F
         +eARNFguSRDtTuur1+N20R6zXC+AkpUQu6G957+C9cJ7Lny1SWaHFZvqbKOqf3yk2ftg
         WjeEjjYV6vFyp4S1D5VkP7VsXUtQ0oOpfjCSVBGKpLKaUUsF/NDJBjTMPUvTiaeKKAPr
         AogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719626552; x=1720231352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV3IXLJ+rp/mQQSIUSn6bNU9LfKWkd9AX7AOX+5g4ig=;
        b=QHF9gj/HLLwpNJ9JKx/Qk7b4ngbb1cZPtwqOHhzickk2pSuy+9OYPGMjMY+PZTpcyF
         uFRzo8fWkNoLYeR7lA0iJRNlulUzgkcNlgexeSX2LUfZteHhl07XhGhlJCzZf8yMslTS
         eIWsm8hHqHWMW+cnVVs1dTmolk20lHJg9erUVfCnpUc4MFaz1h7zPFbOvVOdehGb/wr/
         PmnjIiRIYXiZFkdseRu4sFgl8+eIW4WPRGI0B9Z0r4CClgkH6KQx0depUuLqqnNlTDjW
         hDDQhh+N4T2sOIqK7F6SwRp+gQV+edsm2pxS/W7xW6Vi/ZjG0KZWUgKRHRVgH24Gvwev
         QlPg==
X-Forwarded-Encrypted: i=1; AJvYcCVVpB3/ygLut3z3wEG3LU6O6MjRb+1P6pi7bMddUS9yLlL9983ivt1WAdhli6ugk7h8X0QeBq77b5rcXHQUK7EX7WFw
X-Gm-Message-State: AOJu0YzoNQGjYQYHxT1uopq+U1eVuVLm9+oKtvoII6Zw+/qI0LvhBbdH
	ncUZ0JEBL0RamSfw/RR2Ql5GPKbIpJP3VUgIEceDHSgEGXuhORx/
X-Google-Smtp-Source: AGHT+IEDs0skzYjg31k29pSKQnP0x/GKFOAAsOH6UaHjjDhCdDktx8rYp/L1ZDy+j8l0H3jSP5r+7A==
X-Received: by 2002:a50:d6db:0:b0:57c:5996:cfc8 with SMTP id 4fb4d7f45d1cf-57d45780340mr12519357a12.5.1719626551997;
        Fri, 28 Jun 2024 19:02:31 -0700 (PDT)
Received: from sita-dell (static.133.162.46.78.clients.your-server.de. [78.46.162.133])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614d5042csm1732287a12.73.2024.06.28.19.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 19:02:31 -0700 (PDT)
Date: Sat, 29 Jun 2024 07:32:27 +0530
From: Sitaram Chamarty <sitaramc@gmail.com>
To: Jeff King <peff@peff.net>
Cc: matthew sporleder <msporleder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: bundles discovery and clones
Message-ID: <Zn9rMyvR6nev3rd9@sita-dell>
References: <CAHKF-AsoF10coLP=+MV-NfkEvWzp2Xbucs7OwtOoCBs3TVMg3A@mail.gmail.com>
 <20240611072144.GD3248245@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611072144.GD3248245@coredump.intra.peff.net>

On Tue, Jun 11, 2024 at 03:21:44AM -0400, Jeff King wrote:
> On Mon, Jun 10, 2024 at 02:25:19PM -0400, matthew sporleder wrote:
> 
> > I have recently been playing with git clone --bundle-uri and loving it
> > because I can clone with almost-*zero* resources being used on the
> > server!
> > 
> > I am a little confused by https://git-scm.com/docs/bundle-uri
> > mentioning "discovery" and things. Is this something being added to
> > the git cli, a special feature for other clients, or is it still too
> > early-days to talk about much?
> > 
> > I would love to produce bundles of common use cases and have them
> > auto-discovered by git clone *without* the --bundle-uri parameter, and
> > then let our CDN do the heavy lifting of satisfying things like:
> > git clone
> > git clone --depth=0
> > git clone --single-branch --branch main
> > 
> > I'm not sure I hold out as much hope for pre-bundling pulls/updates
> > but any movement towards offloading our big-ish repos to CDNs is a win
> > for us.
> 
> I don't think the server side is well documented, but peeking at the
> code, I think you want this on the server:
> 
>   git config uploadpack.advertiseBundleURIs true
>   git config bundle.version 1
>   git config bundle.mode any
>   git config bundle.foo.uri https://example.com/your.bundle
> 
> And then the clients need to tell Git that they allow bundle transfers:
> 
>   git config --global transfer.bundleURI true
> 
> I'm not sure if we'd eventually flip the client-side switch to "true" by
> default (which is what you'd need for this to happen without any user
> participation at all).
> 
> One gotcha there is that clients are now accessing an arbitrary URL
> provided by the server, so there are cross-site security implications.

Very sorry for jumping in so late.  I just posted in another
thread related to bundles and then I saw this thread.

Gitolite supports this out of the box, and more importantly to
the security aspect, it respects gitolite's rules for that repo
and that user.  Link for details is:

https://github.com/sitaramc/gitolite/blob/master/src/commands/rsync

> It might make more sense to allow only relative URLs without ".." (so if
> I fetched from https://example.com/foo.git, the server could use only
> the relative "bundles/bar.bundle", which would then be found at
> https://example.com/foo.git/bundles/bar.bundle").
> 
> -Peff
> 
