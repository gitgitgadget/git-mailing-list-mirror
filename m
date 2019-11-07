Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87BCF1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 10:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbfKGKbr (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 05:31:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44101 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388099AbfKGKbq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 05:31:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id az9so266985plb.11
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 02:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XeLqHEGBslDd3L5gKF5BW2aqNzqqZjb2MEUxYSvofW0=;
        b=oELPfTyumeGHr2Ga+uuMCdF9vvlCW4gKb0mqjg9t/ln7GLoLsmYM146hbfT6kyxayu
         FvVbncz6SGuxL52QIwWYFh7qgcBLeYxaeHr9oHabO1eYGB+XblP5pEFDWUXNP08wSkFa
         LFiDuXEDeiHz1l8R7Vdl+4fXMEy1PhBe4a9ixX/yJv3syAQ5XPgym5Ep8Ruc2sXIqgBT
         WX22uAWfY4sZON46ZXWutvCxz9FiI1N0hVIvLJfV3ZtvlhF/PAlv5wWOVgLtcfMb39St
         hiDZn6McaZyjwC53ZNjD/tgFGl9tmvWZf/pHmsbPPaLQ64wRSPQuZi6Brw2e45B4yXGj
         j6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XeLqHEGBslDd3L5gKF5BW2aqNzqqZjb2MEUxYSvofW0=;
        b=M0PzE8AG+j2SFQStmPZWmhanFEEFp3T4Ecn1pkxvO5i6EoNhKI7DWfPuMzGk5YNQXA
         1uOmyxZtLZv417fgH9l0gJzzcMwn0rSO6QObYFuqkX+bF6fF4s61I4gX2aPL9+W+fhYa
         91zilGUFfnL9YFf3NFh3N1OxWKxu5TInAxP6vpZKU/ZC6CMEMKsGFX1+jdQbIehdV/jj
         khAWhQ2A8oGMckUgloqp0O1C5Xh9XGKMbxvR6siExjuQ7h8tjp9S3FY7b74q+BWLXvE2
         UHZ242pCLnDqsVTkIxdiY5YVY1V5sIC77iFk8kX6wfnumsGdcKrm4dfagVmbvNXJJATO
         cGPQ==
X-Gm-Message-State: APjAAAXI5+EO14X6/UK8lqlYCM3In025lgnGxJ4cSqpemXqZTwD0vamd
        nrjvbj/bmOJKH1dgq5jIY1M=
X-Google-Smtp-Source: APXvYqxRWNrW8iT2oM3ZzSdsfIkGS8cJ5a9GSoSsKGUdWRi6qNxF4HyQ11i26CTu02/jYWCltbxbWA==
X-Received: by 2002:a17:902:d70b:: with SMTP id w11mr3035040ply.128.1573122705826;
        Thu, 07 Nov 2019 02:31:45 -0800 (PST)
Received: from helium ([125.252.103.164])
        by smtp.gmail.com with ESMTPSA id q199sm1868373pfq.147.2019.11.07.02.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 02:31:44 -0800 (PST)
Date:   Thu, 7 Nov 2019 18:31:41 +0800
From:   "Eric N. Vander Weele" <ericvw@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] status: teach "status --short" to respect "--show-stash"
Message-ID: <20191107103141.GA87008@helium>
References: <20191104100334.60537-1-ericvw@gmail.com>
 <xmqq36f1wx6h.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36f1wx6h.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 11:33:42AM +0900, Junio C Hamano wrote:
> "Eric N. Vander Weele" <ericvw@gmail.com> writes:
> 
> > Enable printing the entries currently stashed away in the short format.
> > This prints the stash information after the path status to be symmetric
> > with "status --long --show-stash".
> >
> > Signed-off-by: Eric N. Vander Weele <ericvw@gmail.com>
> > ---
> >  Documentation/git-status.txt |  4 ++++
> >  wt-status.c                  | 17 +++++++++++++++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> > index 7731b45f07..c1afc3282c 100644
> > --- a/Documentation/git-status.txt
> > +++ b/Documentation/git-status.txt
> > @@ -244,6 +244,10 @@ If -b is used the short-format status is preceded by a line
> >  
> >      ## branchname tracking info
> >  
> > +If --show-stash is used the short-format status is followed by a line
> > +
> > +    ## stash: <n> (entry|entries)
> > +
> 
> Hmmmm.  Would readers misinterpret we are talking about a branch
> whose name is stash something?  I am not suggesting to change ##
> introducer to some random letters, which would break scripts even
> worse.

I could see where readers may misinterpret this as a branch name.  I
struggled coming up with something short while not being confusing and
thought the presence ':' followed by a space would be clear enough.

> Doesn't the Porcelain Format v1 call the same codepath as
> shortstatus?  We promise that its output never changes to support
> existing scripts, but now they will start seeing "## stash:" that
> they do not understand and barf?

I wasn't aware of the Porcelain formats in detail when originally
creating the patch - oops!  Naively I was following the same behavior as
'--branch' in the shortstatus code path.

Diving into this further, the Porcelain Format v1 does call the same
code path as shortstatus.  I see there is some handling in
builtin/commit.c for tweaking the behavior of the branch being showed.

The documentation indicates that the behavior never changes between Git
versions or based on user configuration.  'git status --porcelain=1'
will react to '--branch' but not when 'status.branch' is set to 'true',
which is congruent with the documentation.

> Isn't this information available to scripts that want to read from
> porcelain v2 output format (which is meant to be extensible by
> allowing easy-to-parse optional headers, which this stash thing
> exactly is).

It is not available in Porcelain Format v2... yet :).


I'm happy making '--show-stash' congruent with '--branch' in v1', which
is would be in line with documented behavior, displaying something in
v2 only, or both.  Let me know how you would like to proceed and I'll
rework the patch accordingly.
