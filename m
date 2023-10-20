Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050FE2FE09
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="CZn2fgWN"
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DA2D52
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 14:48:52 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ca052ec63bso10719525ad.1
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 14:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697838532; x=1698443332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4VjvBB5o90HUzZvlE64lFil3RoduyRat34HvLWXQYx0=;
        b=CZn2fgWNNIftQmLTi2TubGYyuXGRqGVDyif/KSNDhK082Zjg81lMgLMb8z0ddIpDol
         x5iAKcvwbLaeC9pCip3wjrn6p9rMjDbIxWNo3t/QOVZgJn3KTRzuF/W67UyKrZNrOyKT
         e48ForLl70yHeR1D6mPGI1krJF8KalYKlwyR+BZ5DnMsvnHFdSNkX9l5M+xC/OUkMary
         fIOOqccMFiu0B7/m3IVNDPoFiS++wAm/zpyQBDdHOkXirZvDcnQ48HjhGWZFYTxytwlZ
         CeBxBnyIVo5vKx+qnuozi2ADraNHAAXSG6ryzA1xfY+CxqQtEVp7aOTOXC8e+G6XVGEL
         //KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697838532; x=1698443332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VjvBB5o90HUzZvlE64lFil3RoduyRat34HvLWXQYx0=;
        b=elTji8FN6FVsingkqLDeGUvozjySROVCWgNyNX56EjPC/IPZawuPrCzPIB74jG5Q4f
         XTlnANfUhYem+K1K4bypBLg5YV/XvpouTMcnhw1UCfkQygtzZz0raHMbAIYEbT0TtimW
         KZnVJ3o0W76BBcZJuFFL8Tr690LLM6w7LE3cMvtsPfD2WumJ+l7jMsixAkzOwuSXouPK
         CBQyNzzI5blsRyAu4kG8lcUv2SLkFjyt+ff24staEHa5N6HPs+BcSJsxxEX1zkb6UJcW
         O4FqMcW2ICCCnku55LuGb+UY/rDLwD21te+zc+9/3uRAJv6kca6bIi4wB+E5ncrDOP3X
         6eZg==
X-Gm-Message-State: AOJu0YzMmnQh2UhGMBx97JiAHMRrHHoiWw6OuuoKZjQTa1QNVTOEISAF
	Gc/jv42wh6zdtVJn8NiR1iL6kQ==
X-Google-Smtp-Source: AGHT+IHTzOsQiZa0bODSJk6RBw+CO3fNVY6Y/cVmeMLNN3uuI7u/XiQ3QTERul+Cw++vHfEZLGGCCA==
X-Received: by 2002:a17:903:268a:b0:1c3:4b24:d89d with SMTP id jf10-20020a170903268a00b001c34b24d89dmr3088237plb.40.1697838532099;
        Fri, 20 Oct 2023 14:48:52 -0700 (PDT)
Received: from initialcommit.io (mobile-166-170-47-2.mycingular.net. [166.170.47.2])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902ecc800b001c88f77a156sm1964391plh.153.2023.10.20.14.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:48:51 -0700 (PDT)
Date: Fri, 20 Oct 2023 14:48:48 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <fd26df85661d554ced9d8e0445f75952@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd26df85661d554ced9d8e0445f75952@manjaro.org>

On Fri, Oct 20, 2023 at 08:48:12PM +0200, Dragan Simic wrote:
> On 2023-10-20 20:39, Jacob Stopak wrote:
> > This is a proposal / proof-of-concept for a new table-based output
> > format for the git status command, and for dry runs (-n) of the git add
> > command. This could be extended to create visual dry runs for other
> > other commands like rm, mv, restore, stash, commit, and clean.
> 
> Huh, please don't get me wrong, but based on the examples provided below, I
> really think that's only wasted screen estate, providing little or no help
> in understanding the performed operations.
> 
> I appreciate your effort, but IMHO it makes little sense from the usability
> standpoint.
> 

Thanks for the quick (and honest ;) reply - I appreciate it and no offense
taken! But let me try to expand on my reasoning a bit.

I agree with you that Git users who are already comfortable with Git,
the command-line, and their workflows would be unlikely to use this in
their day to day work.

The main benefits of this format are for beginners and folks who
are still learning Git to use it as needed:

  * To beginners, the concepts of working directory and "staging area"
    can be very abstract. By representing these concepts as table columns
    on the screen, (a format that 99% of humans are used to interpreting),
    they become more tangible and intuitive to new users.

  * In Git, changes fly around all over the place, in all sorts of
    directions. Even small hints at this movement can be very helpful to
    understand what the heck is going on. The table format (esp with
    arrows used in the 'git add' version) highlights the "flow" of
    changes through the workflow in a way that the current default format
    doesn't. The current dry runs just show the filenames being added
    without context of _where_ they come from and where they are going.
    Not to mention many commands don't even have dry runs. This might
    sound like a small thing, but to a newbie having that extra level of
    confirmation and understanding can make a big difference.

  * Git doesn't exactly have a reputation as a user-friendly tool, and
    much of that stems from the difficulty of learning Git. So we should
    try to make it more approachable to normal humans. This format
    (esp if applied to a wide variety of commands as dry runs) would
    provide a rudimentary visual output that is more intuitive to users.

  * This flag doesn't change any default behavior, it can easily be
    tossed on for newbie use (either when teaching a newbie or when the
    newbie is practicing on their own). Given this usage, the screen
    realestate is not really a concern. I.e. this would be used
    specifically when needed for the extra info/clarity it provides,
    not to be efficient with the terminal space.

That's my perspective anyway, but of course the point of this is to
propose it to the community and hear the response, so even if it's
not included it's still a good experience :D.
