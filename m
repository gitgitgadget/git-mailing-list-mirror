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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5B51F461
	for <e@80x24.org>; Tue, 16 Jul 2019 00:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbfGPAGg (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 20:06:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44497 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbfGPAGg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 20:06:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so8475724pgl.11
        for <git@vger.kernel.org>; Mon, 15 Jul 2019 17:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D1En+1OdugUQ780h5JJIudTHOUY3WHuXTEKDxzvLkwY=;
        b=ciIlktSfV1oCQNLB2emBCXHWq9KQwzaSGzzkIF9vapJ3WaajygRfkfTUUZnVvT3p9v
         tZ2FlQF8lT1MWy6nBMBYzDE+fnYPJ8Y3G7vApY02ZRK+9WwXdOw8zD24V99NdvTyxFs8
         s/qWX8dXKKdMpJPH7SngvATTXGMYIQtGsG3IHoiQ0RuVskMesAySusw13DhTxDPvZrCD
         0/lxKSHNEQ4pd4nZJO+sbXLTpT7AWlJLwjikXm8KOQ3J63vtgsphvDXE7sQ7aWKMJTRm
         dXQy9wWcjp6RaVGpbsRksToonLn2n/GjOIkPPCGxU/+je/MwygoKW2M2F+DF3hU1G5Dz
         mEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D1En+1OdugUQ780h5JJIudTHOUY3WHuXTEKDxzvLkwY=;
        b=h3rk+IPWAfe/TsUhjhWmBbphRsnB/oQ90Vwkb3JHu7bik0iVWcqXn9sw56ak+2i8lk
         4Y9kmcc9gjOaviWxfGLNRW+fXSZq8Fqim+VY+RNKC97RXBCRDSGmB/NVGMbmP9trD8Fn
         J0Ya21uX4rcgYWw+tRvZVVtMPn22nl8pdfqvOWAtSoNlscDwuP1urjxtla+LWlK74oFx
         hS1x2xOLdCKN9at1tX+aKyt9Xmtc/nE0+qfRMkfwkWutLW7YN1kSTNlGNyzr2v+qKX8R
         bhgS0hwwACMNzbbyoKt8yQtFvsl8aTpUygRs1sp6gzBQAIR5s/bReSWNJFsdkr1ZZb8L
         S04A==
X-Gm-Message-State: APjAAAV3SQHuDPhDCuIfH9K1Ysp6tom1MP0cLY2jEqk7wGeB97/6Z7Cp
        jSbbGlZx+1OZrTyBe5C3tGpi/w==
X-Google-Smtp-Source: APXvYqxwFOpesQ2esEB6voZSVZ6U/7yfqoAHmdkmcg0gza0/4gxkeg/B61E8yZcxwHmIy5G35QdXgA==
X-Received: by 2002:a63:ea50:: with SMTP id l16mr30276264pgk.160.1563235594223;
        Mon, 15 Jul 2019 17:06:34 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id s24sm19404449pfh.133.2019.07.15.17.06.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 17:06:32 -0700 (PDT)
Date:   Mon, 15 Jul 2019 17:06:28 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] documentation: add tutorial for revision walking
Message-ID: <20190716000628.GF113966@google.com>
References: <20190607010708.46654-1-emilyshaffer@google.com>
 <xmqqef41mbmd.fsf@gitster-ct.c.googlers.com>
 <20190617235053.GD100487@google.com>
 <xmqq4l4lr4dy.fsf@gitster-ct.c.googlers.com>
 <20190620210649.GA87385@google.com>
 <20190713003948.GA43313@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713003948.GA43313@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 12, 2019 at 05:39:48PM -0700, Josh Steadmon wrote:
> On 2019.06.20 14:06, Emily Shaffer wrote:
> > On Wed, Jun 19, 2019 at 08:17:29AM -0700, Junio C Hamano wrote:
> > > Emily Shaffer <emilyshaffer@google.com> writes:
> > > 
> > > > Maybe there's a case for storing them as a set of patch files that are
> > > > revision-controlled somewhere within Documentation/? There was some
> > > > discussion on the IRC a few weeks ago about trying to organize these
> > > > tutorials into their own directory to form a sort of "Git Contribution
> > > > 101" course, maybe it makes sense to store there?
> > > >
> > > >   Documentation/contributing/myfirstcontrib/MyFirstContrib.txt
> > > >   Documentation/contributing/myfirstcontrib/sample/*.patch
> > > >   Documentation/contributing/myfirstrevwalk/MyFirstRevWalk.txt
> > > >   Documentation/contributing/myfirstrevwalk/sample/*.patch
> > > >
> > > > I don't love the idea of maintaining text patches with the expectation
> > > > that they should cleanly apply always,...
> > > 
> > > Well, I actually think the above organization does match the intent
> > > of the "My first contribution codelab" perfectly.  When the codebase,
> > > the workflow used by the project, and/or the coding or documentation
> > > guideline gets updated, the text that documents how to contribute to
> > > the project as well as the sample patches must be updated to match
> > > the updated reality.
> > > 
> > > I agree with you that maintaining the *.patch files to always
> > > cleanly apply is less than ideal.  A topic to update the sample
> > > patches and tutorial text may be competing with another topic that
> > > updates the very API the tutorials are teaching, and the sample
> > > patches may not apply cleanly when two topics are merged together,
> > > even if the "update sample patches and tutorial text" topic does
> > > update them to match the API at the tip of the topic branch itself.
> > > One thing we _could_ do is to pin the target version of the codebase
> > > for the sake of tutorial.  IOW, the sample/*.patch may not apply
> > > cleanly to the version of the tree these patches were taken from,
> > > but would always apply cleanly to the most recent released version
> > > before the last update to the tutorial, or something like that.
> > > 
> > > Also having to review the patch to sample/*.patch files will be
> > > unpleasant.
> > 
> > I wonder if we can ease some pain for both of the above issues by
> > including some scripts to "inflate" the patch files into a topic branch,
> > or figure out some more easily-reviewed (but more complicated, I
> > suppose) method for sending updates to the sample/*.patch files.
> > 
> > Imagining workflows like this:
> > 
> > Doing the tutorial:
> >  - In worktree a/.
> >  - Run a magic script which creates a worktree with the sample code, b/.
> >  - Read through a/Documentation/MyFirstContribution.txt and generate
> >    a/builtins/psuh.c, referring to b/builtins/psuh.c if confused.
> > 
> > Rebasing the tutorial patches:
> >  - In worktree a/.
> >  - Run a magic script which checks out a new branch at the last known
> >    good base for the patchset, then applies all the patches.
> >  - Now faced with, likely, a topic branch based on v<n-1> (where n is
> >    latest release).
> >  - `git rebase v<n> -x (make && ./bin-wrappers/git psuh)`
> >  - Interactively fix conflicts
> >  - Run a script to generate a magic interdiff from the old version of
> >    patches
> >  - Mail out magic interdiff to list and get approval
> >  - (Maybe maintainer does this when interdiff is happy? Maybe updater
> >    does this when review looks good?) Run a magic script to regenerate
> >    patches from rebased branch, and note somewhere they are based on
> >    v<n>
> >  - Mail sample/*.patch (based on v<n>) to list (if maintainer rolled the
> >    patches after interdiff approval, this step can be skipped)
> > 
> > (This seems to still be a lot of steps, even with the magic script..)
> > 
> > Alternatively, for the same process:
> >  Updater: Run a magic script to create topic branch based on v<n-1>
> >    (like before)
> >  U: `git rebase v<n> -x (make && ./bin-wrappers/git psuh)`
> >  U: Interactively fix conflicts
> >  U: Run a script to turn topic branch back into sample/*.patch
> >  U: Send email with changes to sample/*.patch (this will be ugly and
> >     unreadable) - message ID <M1>
> >  Reviewer: Run a magic script, providing <M1> argument, which grabs the
> >     diff-of-.patch and generates an interdiff, or a topic branch based
> >     on v<n>
> >  R: Send comments explaining where issue is (tricky to find where to
> >     inline in the diff-of-.patch)
> >  U: Reroll diff-of-.patch email
> >  R: Accepts
> >  Maintainer: Applies diff-of-.patch email normally
> > 
> >  I suppose for the first suggestion, there ends up being quite a lot of
> >  onus on the maintainer, and a lot of trust that there is no difference
> >  between the RFC easy-to-read interdiff patchset. For the second
> >  suggestion, there ends up being onus on the reviewers to run some
> >  magical script. Maybe we can split the difference by expecting Updater
> >  to provide the interdiff below the --- line? Maybe in practice the
> >  diff-of-.patch isn't so unreadable, if it's only minor changes needed
> >  to bring the tutorial up to latest?
> > 
> >  I'm not sure there's a way to make this totally painless using email
> >  tools.
> 
> Random thought about the "magic scripts": if we keep an mbox instead of
> a directory of *.patch files, then it seems like git-format-patch and
> git-am would solve the bulk of this. I don't think dealing with
> diffs-of-patches-in-mbox is much worse than dealing with
> diffs-of-patches-in-multiple-files. And for the "Doing the tutorial"
> workflow, it nudges the new contributor to learn git-am.
> 
> But I guess the hard part here is the reviewing diffs-of-diffs part.
> I'm leaning towards the second option here; I personally would not feel
> too troubled as a reviewer by having to run an extra script. And as you
> say, diff-of-diffs may not be so bad in practice. Reviewers already see
> these whenever someone includes a range-diff in their v>=2 emails.

There was also some suggestion of instead checking in ed scripts or
similar to populate the changes. On one hand, it might be nicer, as
there aren't diff markers on the front of all the code... but on the
other hand, I'm not sure how many folks are familiar with ed (I know I'm
not) and it might be complex to indicate where to insert changes.

I have been in a position of reviewing diff-of-.patch in a past life,
albeit via Gerrit, and it's not the worst when the code is simple (as we
should always hope this example tutorial code would be).

 - Emily
