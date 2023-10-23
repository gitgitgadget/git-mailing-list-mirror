Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DD6224C9
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="eQIvZKNR"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9E283
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:29:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9fa869a63so21402795ad.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698089355; x=1698694155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lCZd3alylrAtb+a7qoJ8+WOxtM8TR/FXuDDHZy5Vta0=;
        b=eQIvZKNRmEnOI5gNvhPYBWBtvKwGn/0mgL4GWFi+KlyxGcw8JI3tBRnE5SG+UhWF8i
         asfmHf6U1iHzW9Y1EkN16ommSWo21BT0UR+tIV5iHEKeNjcqomo1pdfKtxXbGwJ03Z8W
         b/JIknTAIsUNClFUrFQAKbmdFS6+0beMaItHj3+8fk643IGQW3/0iu64kYunp8yEP51Y
         YyWRHPlQBRhKFjpkwTPTVTyINmrJKE4EYqT93MaaKtxI3u2BgznOAOXrqHVO47PCM+2p
         xXHCVyHp5TUjQ9AS6R02IbnaDITJHEFKFj/tAr7gxc8AN8r5CooNSnYT6APJkvmbsrzX
         uyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698089355; x=1698694155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCZd3alylrAtb+a7qoJ8+WOxtM8TR/FXuDDHZy5Vta0=;
        b=xGn5KhDSCwUrbwn47BdQKZ/i5cqpiXVcGhGvcO+U/ZHv+nEd+XSbwgj5YDqqDXPEUy
         3E8unSYVvledqxN6swLZqCZWHy5RsVgIeBMTzxJl00Pbo9jlpUyr+pK7sVN9YomNpjDo
         KEdEKQAjrah5Ga+FbV/TpAJAr6m0bNWWEITTWhIP1J7f5RCSyJzt3Ysv50YvdosHRu0A
         DhRayErwhGbYvV+9NsmfvoYUECOqQAZ5IpYxJ1JTpoEt9QV1Bi4JB9i0KeQAT6//DL0c
         JtOIxdB0+RNv/B9glzKL6m3fEkd1Q7DC883wjnAsZgRMKPU1mLifsf+cOai46JbGs7ri
         qbBA==
X-Gm-Message-State: AOJu0YzanoDTNcefAKP9PscYXtIRhNwHIkxq8h+HISEX4DRaK6WAGIpQ
	rzMYS0CFTwlmVzy372uX7O65bObtm8QIHsGlioo=
X-Google-Smtp-Source: AGHT+IEcFbC1gRnvMqc2RfSRjAPW8HjrDbsw1t4XF0C5ONd5WbdQYJbSvrrKsgC6oa5VYdKIZwljIA==
X-Received: by 2002:a17:902:e749:b0:1c9:da1a:8b14 with SMTP id p9-20020a170902e74900b001c9da1a8b14mr9545197plf.1.1698089355527;
        Mon, 23 Oct 2023 12:29:15 -0700 (PDT)
Received: from initialcommit.io (mobile-166-170-44-139.mycingular.net. [166.170.44.139])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902ced200b001c5f0fe64c2sm6259661plg.56.2023.10.23.12.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:29:15 -0700 (PDT)
Date: Mon, 23 Oct 2023 12:29:12 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTbJiIkIyXwWK8JP.jacob@initialcommit.io>
References: <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
 <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org>
 <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io>
 <ZTa4iqe0lqn/Yg5L@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTa4iqe0lqn/Yg5L@ugly>

On Mon, Oct 23, 2023 at 08:16:42PM +0200, Oswald Buddenhagen wrote:
> On Mon, Oct 23, 2023 at 10:30:54AM -0700, Jacob Stopak wrote:
> > On Mon, Oct 23, 2023 at 04:34:15PM +0200, Dragan Simic wrote:
> > > On 2023-10-23 12:52, Oswald Buddenhagen wrote:
> > > > i for one think that it would be a perfectly valid experiment to go
> > > > all-in and beyond with jacob's proposal - _and make it the default_
> > > 
> > > I'd never support that, FWIW.
> > 
> > FWIW, I'd _never suggest_ that.
> > 
> why, though?
> doing that would extend the feature's reach about two orders of magnitude
> among newbies, which is where it matters most.

To be honest it never even popped into my head to contemplate that and
how the user experience might be impacted by making it the default. I
assume the big distinction is "would it help more users than it would
annoy"?

I always saw this feature as a helper to be invoked when the user is in need
as opposed to a default, similar to the -n dry run option on some commands.

For brand new users, I can see what you mean since they would likely not
know the --table format exists unless being instructed by someone else.
It would be kindof a shame for this capability to exist but not be taken
advantage of by the folks who need it most - the newbies running "git
status" literally for the very first time.

But the main drawback is that although the --table for status does provide
some visual clarity and tangibility, the status command doesn't actually
_do_ anything, so the arrows showing how changes move around don't apply.

Those arrows showing how things move only really apply to "simulating"
(dry runs) for specific commands like add, restore, rm, commit, stash,
etc, so making the --table proposal a default status output would still
miss those scenarios.

However, now that I'm thinking about it maybe it could somehow be included
in the Hints feature? I honestly don't know exactly when the hints are
currently invoked or how much detail they go into, but what just popped
into my head is kindof a "universal dry run" option, which would show the
user the --table format hint when they invoke an applicable command, and
prompt them if they actually want to run it.

> 
> > I very much value Git's current usage and wouldn't dream to make this
> > the default.
> > 
> making the default output format somewhat more verbose wouldn't really
> "change the usage", though. and being able to permanently get rid of it with
> a single command should alleviate any _reasonable_ concerns about habit
> disruption.
> 
> regards

It's a good point too that people surprised or annoyed or disgusted by the
change of a longstanding status output format could just disable the
configuration with a single config command...
