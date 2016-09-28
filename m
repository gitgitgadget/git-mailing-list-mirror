Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2CEB1F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 17:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbcI1RCK (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 13:02:10 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34114 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932856AbcI1RCI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 13:02:08 -0400
Received: by mail-yb0-f195.google.com with SMTP id z8so378687ybh.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=peiVY62yeTmX0096P1QyBsGkTGapLOisSQwHrUl4Ha4=;
        b=CaRtFYIQ7NII578NRkxvHHOHuOqs0iQxrs93ugdl4vL4WWUm5f/P3See+nvCHGNQwo
         FljhMDDqXBb6LAQ+xBsQjrVcCXQIMHbqYZmlAL669JQjISFwFB8ZTyYuZFcbS3b7XZ1Z
         6pDZaFRHqpcxbtjyIHMO6A0563z/lCPIuBvf2fGV/HXoVdUth0QeskCK9xIc+BbNslpP
         O4oiqDJAeri4NFCuSSkwUDAQV8gxQVzABhN9fqJGN0SUnFgTokgz7y46GBUgPs2ru07q
         rgn878VwKPUVTY7JL1Wup0Y86CK2vV0RPXXCg2gcsd0p13zTPc3dX8R063E1uGx6OgNQ
         mg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=peiVY62yeTmX0096P1QyBsGkTGapLOisSQwHrUl4Ha4=;
        b=hqcjg2bJCq7mXbrSZpOCcVplpNfCwRZP7Oy67W2Bc3cbvMqXNX3cnEgQ15OP9itW/I
         FVMj0/rCes2rwMIF5MTJ3ZCJe5e3vmLypeByxOCG5EdsFsbgpAtwFgWCwNY4ghytuH39
         68j74FN2rHaIQ7lllSRqYxt4i7txlF0jTA1anqxuQ1HN592M3o3HxnMs+wjdMwOqg49r
         FLce2BACSem3t2NRVLA58h23Cg7Z/jpCrvRLU72Yb1wJwkvhyigPisT6yME7a75kDl8s
         bMBqSNfr74jyKmIpEn6/Yu6XxbyoOpnlAWvxO+DDJJZ9aQQXfJjrBoboQ+1J2aoped8/
         G4ug==
X-Gm-Message-State: AA6/9RkCn4iUIOAhBTQADy6RP1V5Ivd9eV/hxjUXOJgZuTa3mmTVIUP80PLSmsMIPImFYQ==
X-Received: by 10.37.98.68 with SMTP id w65mr13323222ybb.76.1475082127381;
        Wed, 28 Sep 2016 10:02:07 -0700 (PDT)
Received: from BenPeartHP ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id 204sm3470015yww.9.2016.09.28.10.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2016 10:02:06 -0700 (PDT)
From:   "Ben Peart" <peartben@gmail.com>
To:     <git@vger.kernel.org>
Cc:     "Ben Peart" <Ben.Peart@microsoft.com>, <pclouds@gmail.com>,
        "Jeff Hostetler" <jeffhost@microsoft.com>, <philipoakley@iee.org>,
        "'Junio C Hamano'" <gitster@pobox.com>
Subject: RE: [PATCH v3] checkout: eliminate unnecessary merge for trivial checkout
Date:   Wed, 28 Sep 2016 13:02:04 -0400
Message-ID: <004d01d219aa$0a941fa0$1fbc5ee0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEf8nParUbRS09bQmMJuzIoK5gVCA==
Content-Language: en-us
x-ms-exchange-organization-originalclientipaddress: 65.222.173.206
x-ms-exchange-organization-originalserveripaddress: 25.162.86.52
x-ms-exchange-organization-submissionquotaskipped: False
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Resending

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Philip Oakley
> Sent: Saturday, September 24, 2016 3:31 PM
> To: Junio C Hamano <gitster@pobox.com>
> Cc: Ben Peart <Ben.Peart@microsoft.com>; pclouds@gmail.com;
> git@vger.kernel.org
> Subject: Re: [PATCH v3] checkout: eliminate unnecessary merge for trivial
> checkout
> 
> Hi Junio,
> 
> From: "Junio C Hamano" <gitster@pobox.com>
> > "Philip Oakley" <philipoakley@iee.org> writes:
> >
> >>> > >"git checkout -b foo" (without -f -m or <start_point>) is defined
> >>> > >in the manual as being a shortcut for/equivalent to:
> >>> > >
> >>> > >        (1a) "git branch foo"
> >>> > >        (1b) "git checkout foo"
> >>> > >
> >>> > >However, it has been our experience in our observed use cases and
> >>> > >all the existing git tests, that it can be treated as equivalent
to:
> >>> > >
> >>> > >        (2a) "git branch foo"
> >>> > >        (2b) "git symbolic-ref HEAD refs/heads/foo"
> >>> > >...
> >>> > >
> >>> > I am still not sure if I like the change of what "checkout -b" is
> >>> > this late in the game, though.
> >>>
> >>> ...
> >>> That said, you're much more on the frontline of receiving negative
> >>> feedback about doing that than I am. :)  How would you like to
> >>> proceed?
> >>
> >> I didn't see an initial confirmation as to what the issue really was.
> >> You indicated the symptom ('a long checkout time'), but then we
> >> missed out on hard facts and example repos, so that the issue was
> >> replicable.
> >
> > I took it as a given, trivial and obvious optimization opportunity,
> > that it is wasteful having to traverse two trees to consolidate and
> > reflect their differences into the working tree when we know upfront
> > that these two trees are identical, no matter what the overhead for
> > doing so is.
> 
> I agree, and I believe Ben agrees.
> 

Correct.  In my original patch request I put more specific information on 
the impact this optimization has in our specific case (reducing the cost 
from 166 seconds to 16 seconds).

> >
> >> At the moment there is the simple workaround of an alias that
> >> executes that two step command dance to achieve what you needed, and
> >> Junio has outlined the issues he needed to be covered from his
> >> maintainer perspective (e.g. the detection of sparse checkouts).
> >> Confirming the root causes would help in setting a baseline.
> >>
> >> I hope that is of help - I'd seen that the discussion had gone quiet.
> >
> > Some of the problems I have are:
> >
> > (1) "git checkout -b NEW", "git checkout", "git checkout HEAD^0"
> >     and "git checkout HEAD" (no other parameters to any of them)
> >     ought to give identical index and working tree.  It is too
> >     confusing to leave subtly different results that will lead to
> >     hard to diagnose bugs for only one of them.
> >
> > (2) The proposed log message talks only about "performance
> >     optimization",
> 
> >                                while the purpose of the change is more
> > about
> >     changing the definition
> 
> Here I think is the misunderstanding. His purpose is NOT to change the
> definition (IIUC). As I read the message you reference below (and Ben's
other
> messages), I understood that he was trying to achieve what you said (i.e.
> optimise the trivial and obvious opportunity) of selecting for the common
> case (underlying conditions) where the two command sequences are
> identical. If the selected case / conditions is not identical then it is
defined
> wrongly...
> 
> I suspect that it was Ben's 'soft' explanation that allowed the discussion
to
> diverge.
> 

I'm unaccustomed to doing reviews like this via email so have been 
struggling with how to most effectively communicate about the proposed
change.  I appreciate any help and understanding as I go through this
for the first time.

My intention was not to change the users expected results which
I believe are to "create a new branch and switch to it."  We reinforce
that expectation with the output of the command which completes 
with the text "Switched to a new branch 'foo'"

> 
> >                                                 of what "git checkout -b
> > NEW" is from
> >     "git branch NEW && git checkout NEW" to "git branch NEW && git
> >     symbolic-ref HEAD refs/heads/NEW".  The explanation in a Ben's
> >     later message <007401d21278$445eba80$cd1c2f80$@gmail.com> does
> >     a much better job contrasting the two.
> >
> > (3) I identified only one difference as an example sufficient to
> >     point out why the patch provided is not a pure optimization but
> >     behaviour change.  Fixing that example alone to avoid change in
> >     the behaviour is trivial (see if the "info/sparse-checkout"
> >     file is present and refrain from skipping the proper checkout),
> 
> This is probably the point Ben needs to take on board to narrow the
> conditions down. There may be others.
> 

The fact that "git checkout -b NEW" updates the index and as a
result reflects any changes in the sparse-checkout and the issue 
Junio pointed out earlier about not calling show_local_changes 
at the end of merge_working_tree are the only difference in behavior
I am aware of.  Both of these are easily rectified.

That said, given we are skipping huge amounts of work by no longer 
merging the commit trees, generating a new index, and merging the 
local modifications in the working tree, it is possible that there are
other behavior changes I'm just not aware of.

> >     but a much larger problem is that I do not know (and Ben does
> >     not, I suspect) know what other behaviour changes the patch is
> >     introducing, and worse, the checks are sufficiently dense too
> >     detailed and intimate to the implementation of unpack_trees()
> >     that it is impossible for anybody to make sure the exceptions
> >     defined in this patch and updates to other parts of the system
> >     will be kept in sync.
> 
> I did not believe he was proposing such a change to behaviour, hence his
> difficulty in responding (or at least that is my perception). I.e. he was
> digging a hole in the wrong place.
> 
> It is possible that he had accidentally introduced a behavious change, and
> having failed to explictly say "This patch (should) produces no behavious
> change", which then continued to re-inforce the misunderstanding.
> 
> >
> > So my inclination at this point, unless we see somebody invents a
> > clever way to solve (3), is that any change that violates (1),
> > i.e. as long as the patch does "Are we doing '-b NEW'?  Then we do
> > something subtly different", is not acceptable, and solving (3) in a
> > maintainable way smells like quite a hard thing to do.  But it would
> > be ideal if (3) is solved cleanly, as we will then not have to worry
> > about changing behaviour at all and can apply the optimization for
> > all of the four cases equally.  As a side effect, that approach
> > would solve problem (2) above.
> >
> > If we were to punt on keeping the sanity (1) and introduce a subtly
> > different "create a new branch and point the HEAD at it", an easier
> > way out may be be one of
> >
> > 1. a totally new command, e.g. "git branch-switch NEW" that takes
> >    only a single argument and no other "checkout" options, or
> >
> > 2. a new option to "git checkout" that takes _ONLY_ a single
> >    argument and incompatible with any other option or command line
> >    argument, or
> >
> > 3. an alias that does "git branch" followed by "git symbolic-ref".
> >
> > Neither of the first two sounds palatable, though.
> 
> It will need Ben to come back and clarify, if he did, or did not, want any
> behaviour change (beyond speed of action;-)
> 

There is a subtlety here in what is meant by "any behavior change."
I did not want to change the users expectations of what this command
is used for.  The only noticeable behavior change should only be that it 
sped up by an order of magnitude.  

To get that speed up, there is a change in behavior from git's 
perspective as it is no longer doing a bunch of work it used to do 
which is what is saving the time.

I was aware that skipping the commit merge/new index/merge working 
tree meant that "git checkout NEW" would no longer update these to 
reflect any potential changes to the sparse-checkout file.  

To determine if this would change the results the user was *expecting*,  
I searched the web and found that all the instructions I could locate
that taught people how to update the index/working tree after
making changes to the sparse-checkout file instructed them to use
"git read-tree -mu HEAD."  I didn't find any that told people to use
"git checkout -b NEW"  

Finally, when I made the optimization to skip these steps I then
verified that the test suite still passed all tests.  I realize that 
there is not 100% coverage of tests but I thought it was a good
indication that none of them were impacted by this optimization.

I've tried to think of a way to solve (3) in a more maintainable way 
but have not been able to come up with anything.  Ultimately,
to ensure are only applying the optimization in this specific case,
we have to test to make sure other options don't require the extra
steps.  I'm open to suggestions!

I'm going to be out for the next 2 weeks so will be unable to respond 
to activity on the thread but a co-worker who has been involved will
be responsive to feedback and rolling any new versions of the patch.

Thanks,

Ben



