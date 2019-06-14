Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94C851F462
	for <e@80x24.org>; Fri, 14 Jun 2019 22:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfFNW5C (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 18:57:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35087 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfFNW5C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 18:57:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so2256051pfd.2
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 15:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9e1S555FkwOkuXrHRwNc0/KSzrwwAgM4HbryRihW25g=;
        b=s5PbbHTAadY/d/I9uFnf3Ga+rCMS9ssKmkp9j93Njo0pI1LpgXK6vIP0QFo2qpdJp3
         OUFgI1X2XHpSYTPHInms7eryO4YhsKvkkxA36cDWG5Sg2SmSoW9S5qAwVii74s8Re7PC
         UeD1KfMFGyQW8fVueopTOHZQy84JL9MfgzN97SKATTszL/KVNhlsnU7mogHRkM34oKAY
         VeJbv9o/cGEFhBJxaQEuDwDiBFb6W8UFUcx+fx/ErvIqEaQe5tbS59/fmOtZh+qq5Rdd
         soF4nrfn+K6JuWCtLfe+XWliAStYZOpB279ef1vAUVLAbxfIRiU6D1aGddodsRmtAK/T
         UPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9e1S555FkwOkuXrHRwNc0/KSzrwwAgM4HbryRihW25g=;
        b=On1cTzVBGqoEj4cBc07Ca06nP6Um2Pe7QQNgj2BZveizkqx9JD3vyYdwEyYab3RE1n
         WPjevwZW4H5b9JYJHEmf3OkR5i1IcAFMW16xSvXs7lCucWuTOOwX9uTLBSR8mhkJjuja
         kHeD71LXiIemW4D0YRPZ4P/6S4U3eL5YrKv1tGQKGdkU2WVoFUnYezUqSXvmBohm224v
         m1H7Em16bmT4WpVITqi8pRPoT/uredBbomsazr/VbfmBuXO3ELp0cT8PqbOUGQr+ptsV
         gRubyzZTZ8RW8k+G26KN1GB3GWvxwjE8A9Vzd5yt/bu7RJwAGv8GJYnPczww4QVRSrLY
         FUMg==
X-Gm-Message-State: APjAAAUUUQ2mL6EoMKa59WtC4HOKkB3OT4IqWj8u1EsiOzTIrjP5yQiX
        pVr+l56IaivqzYfp40VaWntfS5E248s=
X-Google-Smtp-Source: APXvYqyJ3D+VuUXs9WPS2AC6gT8XA0CWE+B2j6pDYEO7yfqAZ/ZlbJRdhpzRcCZWqGZIYjfL3WH7FA==
X-Received: by 2002:a62:58c4:: with SMTP id m187mr43454382pfb.147.1560553020929;
        Fri, 14 Jun 2019 15:57:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id a22sm4734950pfn.173.2019.06.14.15.56.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 15:56:59 -0700 (PDT)
Date:   Fri, 14 Jun 2019 15:56:54 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] rev-list: clarify --abbrev and --abbrev-commit usage
Message-ID: <20190614225654.GD233791@google.com>
References: <20190613221541.10007-1-emilyshaffer@google.com>
 <20190614161841.GB30083@sigill.intra.peff.net>
 <20190614205950.GC233791@google.com>
 <20190614212714.GA15798@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614212714.GA15798@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 05:27:14PM -0400, Jeff King wrote:
> On Fri, Jun 14, 2019 at 01:59:50PM -0700, Emily Shaffer wrote:
> 
> > > So no, I cannot see a way in which "rev-list --abbrev" is useful without
> > > "--abbrev-commit". Which means that perhaps the former should imply the
> > > latter.
> > 
> > Maybe it should; maybe this patch is a good excuse to do so, and enforce
> > mutual exclusion of --abbrev-commit/--abbrev and --no-abbrev. Maybe it's
> > also a good time to add --abbrev-commit=<length>?
> 
> Hmm, yeah, I think that would reduce confusion quite a bit. If it were
> "--abbrev-commit=<length>", then "--abbrev" would not be useful for
> anything in rev-list. It would still work as a historical item, but we
> would not need or want to advertise it in the usage at all. Good
> suggestion.

Given your comments below, I think rather than enforcing mutual
exclusion it makes more sense to enforce last-one-wins. But the thinking
is essentially the same.

> 
> > > is not right. Possibly:
> > > 
> > >   --abbrev-commit [--abbrev=<n>] | --no-abbrev
> > > 
> > > would show the interaction more clearly, but I don't have a strong
> > > opinion.
> > 
> > I did consider demonstrating it this way, but when both --abbrev-commit
> > and --no-abbrev are used together, we don't complain or reject the
> > invocation - which I would expect if the usage states the two options
> > are mutually exclusive.
> 
> Ah, I see. I don't consider "|" to indicate an exclusion to the point
> that the options are rejected. Only that you wouldn't want to use both,
> because one counteracts the other. So every "--no-foo" is mutually
> exclusive with "--foo" in the sense that one override the other. But the
> outcome is "last one wins", and not "whoops, we cannot figure out what
> you meant". And that's what the original:
> 
>       --abbrev=<n> | --no-abbrev
> 
> before your patch was trying to say (and I suspect there are many other
> cases of "|" with this kind of last-one-wins behavior).

For what it's worth, in this case it's not last-one-wins - --no-abbrev
always wins:

  emilyshaffer@podkayne:~/git [master]$ g rev-list --abbrev-commit
  --no-abbrev --max-count=5 --pretty=oneline HEAD
  b697d92f56511e804b8ba20ccbe7bdc85dc66810 Git 2.22
  6ee1eaca3e996e69691f515742129645f453e0e8 Merge tag 'l10n-2.22.0-rnd3' of
    git://github.com/git-l10n/git-po
  0cdb8d2db2f39d1a29636975168c457d2dc0d466 Merge branch 'fr_review' of
    git://github.com/jnavila/git
  d0149200792f579151166a4a5bfae7e66c5d998b Merge branch 'master' of
    git://github.com/alshopov/git-po
  82eb147dbbbd0221980883e87ca7efd16a939a6f l10n: fr.po: Review French
    translation
  emilyshaffer@podkayne:~/git [master]$ g rev-list --no-abbrev
  --abbrev-commit --max-count=5 --pretty=oneline HEAD
  b697d92f56511e804b8ba20ccbe7bdc85dc66810 Git 2.22
  6ee1eaca3e996e69691f515742129645f453e0e8 Merge tag 'l10n-2.22.0-rnd3' of
    git://github.com/git-l10n/git-po
  0cdb8d2db2f39d1a29636975168c457d2dc0d466 Merge branch 'fr_review' of
    git://github.com/jnavila/git
  d0149200792f579151166a4a5bfae7e66c5d998b Merge branch 'master' of
    git://github.com/alshopov/git-po
  82eb147dbbbd0221980883e87ca7efd16a939a6f l10n: fr.po: Review French
    translation
  emilyshaffer@podkayne:~/git [master]$ g rev-list --abbrev-commit
  --max-count=5 --pretty=oneline HEAD
  b697d92f56 Git 2.22
  6ee1eaca3e Merge tag 'l10n-2.22.0-rnd3' of
    git://github.com/git-l10n/git-po
  0cdb8d2db2 Merge branch 'fr_review' of git://github.com/jnavila/git
  d014920079 Merge branch 'master' of git://github.com/alshopov/git-po
  82eb147dbb l10n: fr.po: Review French translation

> 
> > I've been trying to think of good reasons not to enforce their mutual
> > exclusion, and the one I keep coming back to is that --no-abbrev might
> > be desired to override a git config'd abbreviation length - although I
> > didn't check to see whether we have one, maybe we would want one later.
> > And even in that case, I suppose that --abbrev-commit would not be
> > explicitly added to the call (because we'd infer from the config), or
> > that if it did need to be explicitly added (like if we need the user to
> > say they want abbreviation, but we want to use their configured
> > preferred length) then we could still reject the addition of
> > --no-abbrev.
> >
> > So maybe it makes even more sense to take this patch as an opportunity
> > to make these options mutually exclusive... although that checking I
> > think would wind up in revision.c, and therefore widen the impact of
> > the change significantly.
> 
> You can configure core.abbrev, though I'm not sure if it ever requests
> abbreviation itself, or if it simply sets the length when we do happen
> to abbreviate based on command-line options.
> 
> But forgetting config for a moment, last-one-wins is useful even among
> command line options. E.g., imagine an alias like this:
> 
>   [alias]
>   mylog = git rev-list --abbrev-commit --pretty=oneline
> 
> It's nice if you can run "git mylog --no-abbrev" and have it do what you
> expect, instead of complaining "you cannot use --abbrev-commit and
> --no-abbrev together".
> 
> That's a toy example, but you can imagine more elaborate scripts that
> set some default options, and allow arbitrary per-invocation options to
> be appended.

This makes a lot more sense than the scenarios I was imagining. Thanks.

I think a good solution here is to go and add --abbrev-commit=<n>
without breaking support for --abbrev=<n>; I'm a little more worried
about changing --no-abbrev to last-one-wins but I'll take a crack at it
and see what the test suite says. While I'm at it, I'll check for
last-one-wins with multiple instances of --abbrev[-commit]=<n>.

Having done so, I'll also change the documentation here in rev-list to:
 --abbrev-commit[=<n>] [--abbrev=<n>] | --no-abbrev

Sounds like a fun bit of low hanging fruit to me. Hoping to have a short
turnaround. :)

 - Emily
