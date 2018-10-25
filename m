Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0901F453
	for <e@80x24.org>; Thu, 25 Oct 2018 01:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeJYK3t (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 06:29:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40125 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeJYK3t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 06:29:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id r1-v6so6887344edd.7
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 18:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JbbjFC1guBwyZUBQ/a86LcaoDSg4DxCgEBXKHtUOSdg=;
        b=ALBbAQSb8eKg2CjyAknSQHjXW9fHl79ZDpSuwfUk8PidH+NagCHuC0NNHoCm4ZC9nf
         lqVAeouNbFdyAXeDqLQ5mZp+74jecNNhNlCD/xE/ognDiwujTrre1xyCCf0IJkBQCAtL
         xdGQH3gZJgpPc8IPnBlVOMGbPAhkTNsqLIta5aWLmSt0wnKhdpWX7KdYmHamFDXxubCE
         anUAaZcVfx0ImZcl5GVVDsCHgKw3udyeN9VmCmlq72DHKBjaOhEM57p1Zp+BAmWb3Wfr
         p44PyiVuFOD0jcMLNcDbvM0Zs4SWfXziYkS1fnaRw9lJkdl18ocH8UHHdsG9ufByX3Av
         d5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JbbjFC1guBwyZUBQ/a86LcaoDSg4DxCgEBXKHtUOSdg=;
        b=m5fxGlnfy1PkPczAknUx5x8LOqHm2Qw0GvEe2ofqYWJZnewSb7kHw/UJiN4krESnay
         dh3FYVBjSc6lh8kIhzv8cZr2W+RSGYa8TwRbU5JSZr8ytn0cbSPlpiKgJxYhhO4TOfGR
         hVmIF97/umk7yP87ack3YSloOVcDCEsHb2SO4rjL5GMfT5jq1aQsEadOBWponPrFmE20
         MEen7vgn+ikF/DApt4I/kdHDQn8jPxLZeJeCLPI0c4r8XzPUN818KJ4lJef1AUbuKfGw
         dqpK3NKmRJBcAvkivY+ph+OxPiK58ZDsp4meFllGFHZCyF9b416oLmaYhEelGrvoIbit
         dB4g==
X-Gm-Message-State: AGRZ1gI+ZXD12rsmTnWmz07jLv6JXI5I7wRcWMju4MmBUipizQtcOmW6
        Gv5h28bz0+Sekg8RvZ/AEzA=
X-Google-Smtp-Source: AJdET5flmsxA6GvB5cV4QjlAU0bxggW7YVMfccVDtoFwNFz8FCAeoqaKLLcOFvYLBB5KBUFh0hfRCg==
X-Received: by 2002:a17:906:4b0f:: with SMTP id y15-v6mr15310eju.64.1540432753917;
        Wed, 24 Oct 2018 18:59:13 -0700 (PDT)
Received: from szeder.dev (x4db14d30.dyn.telefonica.de. [77.177.77.48])
        by smtp.gmail.com with ESMTPSA id c50-v6sm2188404edc.4.2018.10.24.18.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 18:59:12 -0700 (PDT)
Date:   Thu, 25 Oct 2018 03:59:10 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: New semantic patches vs. in-flight topics [was: Re: [PATCH
 00/19] Bring more repository handles into our code base]
Message-ID: <20181025015910.GJ30222@szeder.dev>
References: <20181016233550.251311-1-sbeller@google.com>
 <20181022173935.GG30222@szeder.dev>
 <CAGZ79kboyakR=dARH60ZJmyN=kT+-X0SSDjgz3aswpkUd+bZmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kboyakR=dARH60ZJmyN=kT+-X0SSDjgz3aswpkUd+bZmg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 11:54:06AM -0700, Stefan Beller wrote:

> For the sake of a good history, I would think running 'make coccicheck'
> and applying the resulting patches would be best as part of the (dirty)
> merge of any topic that proposes new semantic patches, but that would
> add load to Junio as it would be an extra step during the merge.
> 
> One could argue that the step of applying such transformations into
> the dirty merge is cheaper than resolving merge conflicts that are
> had when the topic includes the transformation.

Please consider that merge commits' have uglier diffs than regular
commits, and that merge commits cause additional complications when
'git bisect' points the finger at them, both of which are exacerbated
by additional changes squeezed into evil merges.

> >     Consequently, 'make coccicheck' won't run clean and the
> >     static analysis build job will fail until all those topics reach
> >     'master', and the remaining transformations are applied on top.
> >
> >     This was (and still is!) an issue with the hasheq()/oideq() series
> >     as well: that series was added on 2018-08-28, and the static
> >     analysis build job is red on 'pu' ever since.  See the follow-up
> >     patch e43d2dcce1 (more oideq/hasheq conversions, 2018-10-02), and
> >     one more follow-up will be necessary after the builtin stash topic
> >     is merged to 'master'.
> 
> In my understanding this follow up is a feature, as it helps to avoid
> merge conflicts with other topics in flight.

I don't see how such a follow up patch helps to avoid merge conflicts.

There were topics that branched off before the introduction of oideq()
into 'master', therefore they couldn't make use of this new function
until they were merged to 'master' as well, so they added their own
!oidcmp() calls.  That follow up patch was necessary to transform
these new !oidcmp() calls after those topics reached 'master'.  Merge
conflicts had nothing to do with it.

So this follow up patch is not a feature, but rather an inherent
consequence of the project's branching model, with lots of parallel
running topics branching off at different points and progressing at
different speeds.

> >     This makes it harder to review other patch series.
> 
> as 'make coccicheck' is an integral part of your review?

Erm, right, "review" was not the right word here.  Anyway, as it is,
'make coccicheck' is an integral part of our automated tests, not only
on Travis CI but on the upcoming Azure thing as well.  I just try to
pay attention to its results and the results of a bunch of my
additional builds, and complain or even send a fix when something goes
reproducibly wrong.  This has certainly became more cumbersome with
the permanently failing static analysis build job in the last couple
of weeks.

> > How about introducing the concept of "pending" semantic patches,
> > stored in 'contrib/coccinelle/<name>.pending.cocci' files, modifying
> > 'make coccicheck' to skip them, and adding the new 'make
> > coccicheck-pending' target to make it convenient to apply them, e.g.
> > something like the simple patch at the end.
> >
> > So the process would go something like this:
> >
> >   - A new semantic patch should be added as "pending", e.g. to the
> >     file 'the_repository.pending.cocci', together with the resulting
> >     transformations in the same commit.
> >
> >     This way neither 'make coccicheck' nor the static analysis build
> >     job would complain in the topic branch or in the two integration
> >     branches.  And if they do complain, then we would know right away
> >     that they complain because of a well-established semantic patch.
> >     Yet, anyone interested could run 'make coccicheck-pending' to see
> >     where are we heading.
> >
> >   - The author of the "pending" semanting patch should then keep an
> >     eye on already cooking topics: whether any of them contain new
> >     code that should be transformed, and how they progress to
> >     'master', and sending followup patch(es) with the remaining
> >     transformations when applicable.
> >
> >     Futhermore, the author should also pay attention to any new topics
> >     that branch off after the "pending" semantic patch, and whether
> >     any of them introduce code to be transformed, warning their
> >     authors as necessary.
> >
> >   - Finally, after all the dust settled, the dev should follow up with
> >     a patch to:
> >
> >       - promote the "penging" patch to '<name>.cocci', if its purpose
> >         is to avoid undesirable code patterns in the future, or
> >
> >       - remove the semantic patch, if it was used in a one-off
> >         transformation.
> >
> > Thoughts?
> 
> I like the approach of having separate classes of semantic patches:
> (a) the regular "we need to keep checking these" as they address
>     undesirable code patterns, which is what we currently have,
>     and what 'make coccicheck' would complain about.
> (b) The pending patches as you propose. However I would
>     argue that we'd not want to include the transformation into
>     the same patch as then the patch will have merge conflicts.

Since we have a lot of parallel running topics, merge conflicts are
basically unavoidable anyway.  If the conflicts from the
transformation are really that severe, then perhaps the whole series
should be postponed to a calmer, more suitable time.

In the case of 'the_repository.cocci', merging its transformations
into 'pu' resulted in only four conflicts, and I found all four on the
easy side to resolve.  I don't think it's worth waiting with the
transformations in this particular case.

>     Ideally we'd have an automated process/bot that would apply
>     all pending semantic patches onto master and then checks for
>     conflicts in HEAD..pu, and only sends off the non-conflicting
>     diffs as a topic.

New semantic patches didn't pop up all that frequently in the past, so
I'm not sure it's worth investing in such an automation.  Of course
they can become more frequent in the future, and in that case we might
want to reconsider it.  Unfortunately, however, Coccinelle's results
can't be completely trusted, either because our semantic patches or
because Coccinelle itself are buggy...

>     Then after a couple integration cycles we'd have all pending
>     changes in, with no conflicts on Junios side.
> 
> So I think we should add a patch like you post, but we would
> need to discuss the exact approach how to deal with pending
> patches. Is it the original dev who should push forward on their
> own pending patches, or does it become a pooled effort?

Well, it makes sense to me that whoever proposes a change with an
accompanying new semantic patch should also deal with the necessary
followups.  However, it doesn't really matter who deals with them, as
long as somebody deals with them.  I don't think it's much different
from e.g. sending a followup bugfix to someone else's patch series.


