Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28A3C3D
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="uT2+PhLv"
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA3B121
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 08:21:19 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b5e6301a19so3023980b3a.0
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698506478; x=1699111278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2eoS3Yn6tHoX8CZwjZhTjVp2MvD8OOi8ss4TkRQwSA=;
        b=uT2+PhLvBOkUIM3QePT7D91BdQX3t03uBWV/NZHCs+j/fnczBb96Fy1JuTL8VEaxXt
         VijcYMj1zhHV8kLTHkttDtLULTK7GsK0IFgGQuanqcU78sRLYEgfwJmDW86PtOXMWMI5
         Eix7iMNrE2uE2VWdq1NpbUFzoIZUSDXqUrMWnWhapkNUlvJU+Rxz7906EGRKGpxpYmgs
         ZRbLTZLrKRmEP7WGpsEOzrHECpks1b3oiyB6Cgy1s8jWMGJYO+lwwBqsyM9fqvyaa+AY
         WMS0wynYKQgO2gXW0gJmafLQD2LelcPo1j57gfAGXtII2NgudCONl2jUjl2DhOyNjOZP
         gsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698506478; x=1699111278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2eoS3Yn6tHoX8CZwjZhTjVp2MvD8OOi8ss4TkRQwSA=;
        b=KydMEoWsmzsATsc02XXd7+CF18Y0oJGe9X8HgyNUTIf9HJ4A37NFzsEnhP4pLI3JZn
         CXLHUvP9Az3R82TY0zArplwjkuzP0KUJrPxhPUE8Do2wg3RLX2fGtCj0ZgDqz3CDOMOG
         NuUInLRF3i0Pk2AZs1PJIFcLADjqHQgncy7lII5qiND8hUJ7rH6dI71936omovhjxJKk
         yZxJeBbMUv6DRh4G8EPY21h05eR0U3X0jZz/ybX8ZM2IiIz6VWk+ICr/b8hN2pci7yge
         vyJ5lcH+MiFfRYNfbF/LdLcL3NvaDSna8ZukMhmmk2SVeMlTh0nWcHXWvirzoh/Ufcub
         z3XA==
X-Gm-Message-State: AOJu0YyhbdliDEp9II55vqf9hTBBLIDRw/h7sW7Np3PPEXh+TnfNlXxe
	b70798TvXjnAJep4j8gOEop/QlmIWkvY6x71MUs=
X-Google-Smtp-Source: AGHT+IG/q6r/APtMZtFpdRie3o1v8cVSRug0jMqi0EeU+EzzDJpbSEbH6YiFOHM5hZHF6ZFqFI6wQw==
X-Received: by 2002:a05:6a00:148c:b0:6ba:8478:b99f with SMTP id v12-20020a056a00148c00b006ba8478b99fmr7014432pfu.28.1698506478361;
        Sat, 28 Oct 2023 08:21:18 -0700 (PDT)
Received: from initialcommit.io (ip68-7-58-180.sd.sd.cox.net. [68.7.58.180])
        by smtp.gmail.com with ESMTPSA id i2-20020aa787c2000000b006be2f4105d0sm3181235pfo.175.2023.10.28.08.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 08:21:17 -0700 (PDT)
Date: Sat, 28 Oct 2023 08:21:15 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH v2 0/6] Noobify format for status, add, restore
Message-ID: <ZT0m68HWZS/tDGtH.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <20231026224615.675172-1-jacob@initialcommit.io>
 <ca47d328c280e4b4c13bfa6dd9958a57@manjaro.org>
 <ZTvvz6/GFdwagVa+.jacob@initialcommit.io>
 <9b93115810ca269c87ec08f72fdc9c12@manjaro.org>
 <ZTx3fIGpdGl4JpaV.jacob@initialcommit.io>
 <2a0ba4c8e96cb7d2ea66dd1e78cdd39c@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0ba4c8e96cb7d2ea66dd1e78cdd39c@manjaro.org>

On Sat, Oct 28, 2023 at 07:55:31AM +0200, Dragan Simic wrote:
> > So I assume an "add.verbose" config option would just always print that
> > without having to specify the -v, --verbose flag when running the
> > command?
> 
> Yes, that's how I see it.  Setting "add.verbose" to "true", to be precise,
> or to "basic", which I'll explain a bit further later in my response.

Ok, gotcha!

> > Basically what I'm asking is if commands that already have a --verbose
> > flag
> > would just get a config setting that does the existing thing by default?
> 
> Well, not by default.  The default values would remain "false", so nothing
> jumps out of nowhere.

Right, sorry, I worded that poorly.

> > > > So it seems like currently "verbose" is used for various things among
> > > > the command set...
> > > 
> > > Yes, that's the basic verbosity, as I named it above.

Ok.

> > Would it make sense to try to define a more consistent type of output or
> > format style for "verbosity" across different commands? As it stands it
> > seems each command treats verbosity in its own way which makes it hard
> > to interpret exactly what it will do each time...
> 
> We'd have to follow the already established behavior of the commands, and
> there are the man pages to describe what's going on with the verbosity for
> each command.  In other words, nothing would get changed, just some more
> knobs would be added, for those who prefer to have the additional verbosity
> enabled.

Ok I see.

> > Ok so it sounds like you prefer to use "verbose" as the setting key?
> > I guess at this point that might make more sense since commit.verbose
> > already exists, and existing options could be packed into it like you
> > said instead of just true or false.
> 
> It looks like a logical choice to me.
> 

Ok.

> > And then my thing here would just be called "command.verbose =
> > extended"?
> 
> Yes, that's what I propose.  It also looks like a logical choice to me, and
> it would leave space for some possible later changes to the
> "<command>.verbose = extended" verbosity, without tying it to the tables.
> We'd also leave some space that way for even maybe an additional level of
> verbosity, be it "<command>.verbose = simple", "<command>.verbose =
> graphical" or whatever.
> 
> Perhaps this scheme should also support "<command>.verbose = basic", which
> would be an alias for "<command>.verbose = true", for additional clarity.
> 

Sounds good!

> 
> Perhaps it would also be good to nudge the newbies a bit by requesting them
> to enable the extended verbosity for each command by hand.  That way they
> would both learn a bit about the way git configuration works, which they
> ultimately can't escape from, and they would be excited to learn new git
> commands.  Or I at least hope so. :)
> 

Hehe ok, maybe there is room in some hints to notify users of the
extended option...

> > And it's true that some users might only want the extended (or any
> > format) for specific commands. I think a happy medium then is to have
> > the command-specific settings like you mention, plus one toplevel
> > option that enables a specific type of output format among all commands
> > (and overrides the command-specific settings), so that the user can
> > choose which they prefer.
> 
> That's something we can consider as an additional configuration option.
> That way, users could also enable the basic verbosity for all commands,
> which may also be usable.
> 

Cool!

> > Any thoughts on what the section in the config for a more general
> > setting like this might be named?
> 
> Maybe "core.verbose"?  We already have "core.pager", which kind of affects
> the way all command outputs look like.

Ok! The idea of using "core" came to mind but I wasn't sure if that was
more for lower-level settings or more general things.

Great. Thanks a lot for all the feedback. Let me doctor up the patch
series to take these things into account and submit an RFC v3 :D
