Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704A394
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="zTM27+4P"
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F951AC
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 19:52:49 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-584a761b301so2182595a12.3
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 19:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698461568; x=1699066368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4tZGe5EoMWrG5ce0nuT9HPKMEYEw+3Ezsq8t6OOVKB4=;
        b=zTM27+4PIId6b21IkwX3PvONeMc3rsjvr45Giq0+4ANhkyxxjvvtfT9GsSShiDSF7Y
         6Hz9KPZ0GqnZ1oXqNCBfwoKkKDJLXFBHCW7ReqVhdS0+BjUjCh+4P24Cxy8pTFUEiV1C
         FERwLnxkaDTMO+XUGGKqeL4B1s1X8WincOh1pOApI+lsBlmWmvlVOoqIwyJnBrENsHoT
         kQp97MqwcY5SUcxWNdxjy2SbbL+b2n6hqJOX+cwnbrjrr7GuKScMfgBw1yhUurEMF7Ix
         dpr0R+Q0I9IJ4tYRRovuOsDh+uN+WtKKDvc17sGgsLWvzFumi9l/NSoE4/kStxJEQosp
         0s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698461568; x=1699066368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tZGe5EoMWrG5ce0nuT9HPKMEYEw+3Ezsq8t6OOVKB4=;
        b=ncOw9sLLY3UBV3l2VXHqdk+Gnv3OPFhgHCHyyd+cVTAobfg+nXd+Vewt388XMRURDf
         WCTXzTdvVQAqdABswhEeCYXm/54yTtXpn2ipd6a4inshmwbyP7zPn1FA99RPietOY+Gm
         MHIuLZ6EYVvronHxd9mVJ+a2/zxR2+RK9eX5D/lMbu/IirT1ms18Wz/ulKnMta4ZolZH
         Keuk0R1JNOboqxpOC+XydNIFNhaJfdqJY2cJUS5h71Xmp24UgsPpTcYtipDnieAe0LOM
         dj6aSkF6f7+jDlbXreg+PUuwUui+SSB/5EGeMpQ2WDvUYHuuRSpmz8IifzxkAUqNjM6C
         fMnQ==
X-Gm-Message-State: AOJu0Yz3eKNXTjvzObuWaHpPJ/Jqdf5YP8rXxOLHlizEPwv+/Ntp4HEZ
	VOUle31vTZaum8g/msNiojJaBA==
X-Google-Smtp-Source: AGHT+IG6fKoRssQgbkeTwHa8rY0/VC29KkAfazZ5WkEy43QQiko6pTdAk3L6KAhRBqU+qm1HWIHQPA==
X-Received: by 2002:a05:6a20:e11e:b0:12c:2dc7:74bc with SMTP id kr30-20020a056a20e11e00b0012c2dc774bcmr6363392pzb.46.1698461568392;
        Fri, 27 Oct 2023 19:52:48 -0700 (PDT)
Received: from initialcommit.io (ip68-7-58-180.sd.sd.cox.net. [68.7.58.180])
        by smtp.gmail.com with ESMTPSA id x21-20020a656ab5000000b0058a9621f583sm1362651pgu.44.2023.10.27.19.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 19:52:47 -0700 (PDT)
Date: Fri, 27 Oct 2023 19:52:44 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH v2 0/6] Noobify format for status, add, restore
Message-ID: <ZTx3fIGpdGl4JpaV.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
 <ca47d328c280e4b4c13bfa6dd9958a57@manjaro.org>
 <ZTvvz6/GFdwagVa+.jacob@initialcommit.io>
 <9b93115810ca269c87ec08f72fdc9c12@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b93115810ca269c87ec08f72fdc9c12@manjaro.org>

> They currently don't exist, but that's something I've planned to implement,
> e.g. to "add.verbose" as a new configuration option.  It should be usable,
> while not being messy or intrusive as a new feature.

"git add" already has the -v, --verbose flag available for the command
itself like:

$ git add -v foo.txt
add 'foo.txt'

But like you said the config option add.verbose doesn't seem to exist yet.

So I assume an "add.verbose" config option would just always print that
without having to specify the -v, --verbose flag when running the command?

Basically what I'm asking is if commands that already have a --verbose flag
would just get a config setting that does the existing thing by default?

> Yes, those are the basic per-command verbosity modes or levels, as I call
> them.  The way I see it, your patches would add new, extended per-command
> verbosity levels.

Ok, I see.

> > So it seems like currently "verbose" is used for various things among
> > the command set...
> Yes, that's the basic verbosity, as I named it above.

Would it make sense to try to define a more consistent type of output or
format style for "verbosity" across different commands? As it stands it
seems each command treats verbosity in its own way which makes it hard to
interpret exactly what it will do each time...

> > Another thing is that commands like status have multiple flags that can
> > be
> > used to specify the output format, such as --short, --long, --porcelain,
> > etc, but only --short seems to be configurable as a git config setting.
> > Is there a reason (besides backward compatibility I guess) that these
> > aren't rolled into a single thing like --format=<type>? This seems like
> > it would be the easiest way to future proof for new formats like
> > --format=verbose, --format=noob, --format=extended, etc.
> 
> That's a good question, but I'd need to go through the commit history to be
> able to provide some kind of an explanation.  It could also be all packed
> into "status.verbose" as a new configuration option.

Ok so it sounds like you prefer to use "verbose" as the setting key?
I guess at this point that might make more sense since commit.verbose
already exists, and existing options could be packed into it like you
said instead of just true or false.

And then my thing here would just be called "command.verbose = extended"?

> > From a noob's perspective though, does adding a config setting for each
> > command really make sense? I'm kindof envisioning this setting now as a
> > "mode" that is either enabled for all commands it affects or for none.
> > And it's highly unlikely a newish user would individually discover which
> > commands this "extended" format is available for, and run "git config
> > <command>.verbose = extended" for every one. I mean we could do that
> > in case there are folks who only want it for specific commands, but to
> > fulfill it's purpose I think there should definetely be some general way
> > to enable the setting for all commands that have it.
> 
> Quite frankly, we shouldn't expect that all users are noobs, and as a result
> dumb everything down just to make them as comfortable as possible.  On the
> other hand, perhaps not everyone would like to have extended verbosity
> enabled for all commands, just as not everyone uses "-v" for all commands.

I agree with this, and I think it's important to cater to both newbies and
experienced users alike. That's why I said I never dreamed of making this
new format the default.

And it's true that some users might only want the extended (or any format)
for specific commands. I think a happy medium then is to have the command-
specific settings like you mention, plus one toplevel option that enables a
specific type of output format among all commands (and overrides the
command-specific settings), so that the user can choose which they prefer.

Any thoughts on what the section in the config for a more general setting
like this might be named? If "status.verbose = extended" would already be
taken specifically for the status command, what terminology could we use
to mean something like "global.verbose = extended" or "global.extended =
true"? Although the former seems better to me since other format values
could be implemented, like "global.verbose = standard"...
