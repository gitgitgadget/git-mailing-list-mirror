Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F195D1F462
	for <e@80x24.org>; Wed, 29 May 2019 20:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfE2UJ4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 16:09:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34116 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2UJz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 16:09:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id w7so1522767plz.1
        for <git@vger.kernel.org>; Wed, 29 May 2019 13:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9KYjvSfHiPQEVPCia0CaY52A1UOMT4AV6EMgaGjWGVY=;
        b=RMEo8J6dTJEMIOLcqwOaqmWRKabCoOEUtfcMAWyFqvJWHtR6aHKfIBlnIjQcdp7ttw
         pzQzJyOpQ+GrI5DvHJQszn6yLh+joH4jTUFw6/IL1oMQWZ29TzpT5N6PHBDz5akBRQo6
         EQMEtlNctmMkCbvjtvD1XWZYNCRvDicsfH+F5xwt6Ys7EHrPMhQPzN4KcfqUlncWmR32
         8LaIjMqxuSY9hrKSAMNMuTskj8v789FeXifdeQO5b7KlhCYZrNd+CMs2cDtFaV/wxqpE
         Gp4Vtms8CG0EREAIVnYrHrb+s/o7Pb1C7uMkEPLxJRZ9pUJ8FS60stTeii8qMKvG8Uw7
         wH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9KYjvSfHiPQEVPCia0CaY52A1UOMT4AV6EMgaGjWGVY=;
        b=Ns0JTBJMmmk8GpKStu9Io9L9RFD7mr7mKJEaREqXsa344J/Y5tv84/zEM5eMpk3SNA
         KDQNAIjQhQSYc7hw9c6+E/UtvDLEbrMd4SFik7HY+Gvqge+ojOsuP0B6+bcjQylT0xVP
         W/XHdqf1TDH2mt8g30N6ZWBNLkK5DgORol2cY8f9PaTksTQn3ZLIh0hWxExp9e/1W5fg
         CoLEFNYXGbDfpcOruSZt5X+vtzC0FpFSodAThSWRmT4LUHJEjPHb9ybxiNPjkXsOiCJ4
         HN1Bqcxp4/FiK9UZsW/NNSLsB4HufSZTcsvhDEFmEIvHrTqwpyG0uDCDIhhv7Bmypmih
         57+w==
X-Gm-Message-State: APjAAAXumYo+O5JQgehvnGap7JZ/e2CXEyBScXvKafYsA7zxLTPVEtVP
        8ZspvLhuCgmKmt9lcYqZSptT3A==
X-Google-Smtp-Source: APXvYqwbkF//4eZR04c8lNunC/EuImKCdft2F9WDC7oezwDJGkskNxemvz2S1B7bkvnOrU8q9I1Cag==
X-Received: by 2002:a17:902:122:: with SMTP id 31mr3825831plb.217.1559160591454;
        Wed, 29 May 2019 13:09:51 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id r9sm478486pfc.173.2019.05.29.13.09.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 13:09:49 -0700 (PDT)
Date:   Wed, 29 May 2019 13:09:44 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 1/2] documentation: add tutorial for first contribution
Message-ID: <20190529200944.GA52337@google.com>
References: <20190517190359.21676-1-emilyshaffer@google.com>
 <20190517190701.49722-2-emilyshaffer@google.com>
 <CAP8UFD2YH50Br4BNmTqEVeUknxi1X39JCRB4XMwK8rx3DWx=KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD2YH50Br4BNmTqEVeUknxi1X39JCRB4XMwK8rx3DWx=KA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 26, 2019 at 09:48:26AM +0200, Christian Couder wrote:
> On Fri, May 17, 2019 at 11:48 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> >
> > This tutorial covers how to add a new command to Git and, in the
> > process, everything from cloning git/git to getting reviewed on the
> > mailing list. It's meant for new contributors to go through
> > interactively, learning the techniques generally used by the git/git
> > development community.
> 
> Very nice, thanks! I tried it and I liked it very much.
> 
> I noted a few nits that might help improve it a bit.
> 
> > +----
> > +$ git clone https://github.com/git/git git
> 
> Nit: maybe add "$ cd git" after that.

Sure, done.

> 
> > +Check it out! You've got a command! Nice work! Let's commit this.
> > +
> > +----
> > +$ git add Makefile builtin.h builtin/psuh.c git.c
> > +$ git commit -s
> > +----
> 
> Nit: when building a "git-psuh" binary is created at the root of the
> repo which will pollute the `git status` output. The usual way we deal
> with that is by adding "/git-psuh" to the ".gitignore" at the root of
> the repo.

Right you are - good catch. I'll add a paragraph about adding to the
gitignore.
> 
> > +=== Implementation
> > +
> > +It's probably useful to do at least something besides printing out a string.
> > +Let's start by having a look at everything we get.
> > +
> > +Modify your `cmd_psuh` implementation to dump the args you're passed:
> 
> Nit: maybe it could be a bit more clear that the previous printf()
> call should be kept as is, otherwise the test added later will fail.

Done.

> 
> > +----
> > +       const char *cfg_name;
> > +
> > +...
> > +
> > +       git_config(git_default_config, NULL)
> 
> Nit: a ";" is missing at the end of the above line.

Yikes, done.

> 
> > +Let's commit this as well.
> > +
> > +----
> > +$ git commit -sm "psuh: print the current branch"
> 
> Nit: maybe add "builtin/psuh.c" at the end of the above line, so that
> a `git add builtin/psuh.c` is not needed.

This is purely personal preference, but I prefer manually adding files
first. I didn't add any indication about staging the changes to psuh.c
though, so I'm adding a line to `git add builtin/psuh.c`. I found one
other place where the commit line was shown without the add line, so I
included the add there too.

> 
> > +....
> > +git-psuh(1)
> > +===========
> > +
> > +NAME
> > +----
> > +git-psuh - Delight users' typo with a shy horse
> > +
> > +
> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'git-psuh'
> > +
> > +DESCRIPTION
> > +-----------
> > +...
> > +
> > +OPTIONS[[OPTIONS]]
> > +------------------
> > +...
> > +
> > +OUTPUT
> > +------
> > +...
> > +
> > +
> 
> Nit: it seems that the above newline could be removed.


Sure, why not.

> 
> Thanks,
> Christian.

Thanks for trying it out and for your thorough review, Christian. I
appreciate it! Since this is checked into next already, I'll be sending
a follow-on patch in reply to my last version in this thread which is
based on the tip of next.

 - Emily
