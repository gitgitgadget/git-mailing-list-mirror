Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D3720229
	for <e@80x24.org>; Tue,  1 Nov 2016 20:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbcKAUZw (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 16:25:52 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36513 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbcKAUZv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 16:25:51 -0400
Received: by mail-pf0-f178.google.com with SMTP id 189so47101341pfz.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LsqjkvAPd1g8EffGpI+TDvRgdp1Gl6CLy9oAGk0BF5k=;
        b=TojVFabhmzX/VsLuhCAnPyjBDmKxFkEWHh2DWm569AkfPo4GPhxjzLEx3/j9cwtW4l
         1ZaHO5zJ2xFjrmoQSwgdLc3MczqNwHA9aB7qeFKNy8Pfk5r7U3klcHTCHqb7FHABrg1Y
         wjRFSnaJLLhoM1F/reBmU6i1/L7l2QIY1zctN/bOvX5rN5NWOSrTwweN+SnP3VygH2uy
         fPvVSaZBW11KrMTrZPlygoiVubipIGCAwCQqgkS9C+7pJAOaHGY5ESUdX3HuGJduPWWh
         W9p9VynDggZ8/kx+QFD+m52Jcs5QFrHnSvyVzmbnmsK/w0mRs/7/BkVxijsttQlkSNS2
         /jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LsqjkvAPd1g8EffGpI+TDvRgdp1Gl6CLy9oAGk0BF5k=;
        b=GNzgHOzZ6POwtUBJU8lvObaaVqMyqQ8FVFODyJ2Rk9L38yfd0ynFSsTGwY7K6bmF+1
         4Hil2AlkU1WP2m/am5dZ8eRt69vAfsIxtx2562bWdB3bGdIoi3OU5biFWQXIQ6i85T2A
         NhE2C2UmL7GS4YzgxPFcjsb8V7OonF9ZkFDztjk60XXgDZYPfUUaGXhnE/PllIF7ZwlP
         EAVOM3ozjCVSYbq9YR2TtTl4mXJqa/DQgbdCke9wP+6BUwLrSA+h9+j3eFTdl69yC0ps
         LkJHuPNuIS2rrj2M5AYsJthuC2rHNbTC4KVKxsmTv9s9jPgpTaCy1N5MDLFBt2coqJcO
         ky8A==
X-Gm-Message-State: ABUngvdzVjikqwqKsCJJfnGaueohMROnEsp5bCXN4u5lZDbE8OfYe1G8ROjaF+xPdSxuIxow
X-Received: by 10.99.148.26 with SMTP id m26mr51488489pge.8.1478031951018;
        Tue, 01 Nov 2016 13:25:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:3408:feb:5098:461b])
        by smtp.gmail.com with ESMTPSA id hv3sm14222415pad.30.2016.11.01.13.25.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Nov 2016 13:25:49 -0700 (PDT)
Date:   Tue, 1 Nov 2016 13:25:48 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] grep: optionally recurse into submodules
Message-ID: <20161101202548.GA39720@google.com>
References: <20161027223834.35312-1-bmwill@google.com>
 <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1477953496-103596-5-git-send-email-bmwill@google.com>
 <CAGZ79kaPSCJo4jBh5pha6_u4pe-7zXoYQi3bD1L14nwUmdD-Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaPSCJo4jBh5pha6_u4pe-7zXoYQi3bD1L14nwUmdD-Hg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/01, Stefan Beller wrote:
> On Mon, Oct 31, 2016 at 3:38 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> >
> > +--recurse-submodules::
> > +       Recursively search in each submodule that has been initialized and
> > +       checked out in the repository.
> > +
> 
> and warn otherwise.

I've been going back and forth on whether to warn the user...maybe
`grep` isn't really the right place for the warning?

> > +
> > +       /*
> > +        * Capture output to output buffer and check the return code from the
> > +        * child process.  A '0' indicates a hit, a '1' indicates no hit and
> > +        * anything else is an error.
> > +        */
> > +       status = capture_command(&cp, &w->out, 0);
> > +       if (status && (status != 1))
> 
> Does the user have enough information what went wrong?
> Is the child verbose enough, such that we do not need to give a
> die[_errno]("submodule processs failed") ?
good point...the output from the child is stored in a buffer and won't
actually get printed if this fails out.  Perhaps we should flush the
buffer and then die?

> > +               if (S_ISREG(ce->ce_mode) &&
> > +                   match_pathspec(pathspec, name.buf, name.len, 0, NULL,
> > +                                  S_ISDIR(ce->ce_mode) ||
> > +                                  S_ISGITLINK(ce->ce_mode))) {
> 
> Why do we have to pass the ISDIR and ISGITLINK here for the regular file
> case? ce_path_match and match_pathspec are doing the same thing?

I was simply doing what ce_path_match was doing.  And I needed to switch
to using match_pathspec instead because ce_path_match doesn't allow for
checking the super_prefix as part of the pathspec logic...Perhaps a
refactor (in the future) in the pathspec logic could do that via a flag?

> > +                          submodule_path_match(pathspec, name.buf, NULL)) {
> > +                       hit |= grep_submodule(opt, NULL, ce->name, ce->name);
> 
> What is the difference between the last two parameters?

Path and file name, in the cached case they are the same.

> > + * filename: name of the submodule including tree name of parent
> > + * path: location of the submodule
> 
> That sounds the same to me.
So they are similar.  path should be used as the directory to
chdir for the child process and it doesn't have the tree name prefixed
to it.

-- 
Brandon Williams
