Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17402C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D8E22244
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="g1BrYLh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409957AbgJTVds (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409948AbgJTVdr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 17:33:47 -0400
Received: from pine.sfconservancy.org (pine.sfconservancy.org [IPv6:2001:4801:7822:103:be76:4eff:fe10:7c55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECF5C0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 14:33:47 -0700 (PDT)
Received: from localhost (unknown [216.161.86.19])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id 2D74FE280;
        Tue, 20 Oct 2020 21:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1603229626;
        bh=59cn2aOiaHD2mynuIlhDmHbffYjLKI2JBwBlbFv3/cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g1BrYLh2GghOPrH8JPex57hnEd8UU4M2kCXThf6g6sPPl9Eie9SnaLEGC8lMguAoB
         Hfl9rYHnGoSwgXlS6185LNkThE+PevGzPA4vGoU/WAa6GPNypLYUzeOlZH8skNZxGl
         fjC4fxRQZX2rdkT0iGaMzNKXGN9oin0S+HFki3tywSgBju63QtxG+s0IWSW7W5zj4Y
         lag0BIm0uDuOcoI7iZAjuwD1WX+1CF6GLM7CdRwcjg8zC9bppeZRl6RmcWIcrnYkWF
         EtpI7wBbAzaaBVgWf2AelmCHRRV5sVQsaLXveU++pcxviBGGJIKHyiP2Q5MudF6LMZ
         OjMA7RDgWtHUg==
Date:   Tue, 20 Oct 2020 14:28:20 -0700
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clarify meaning of --signoff & related doc
 improvements in describing Signed-off-by
Message-ID: <20201020212820.GA1368742@ebb.org>
References: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com>
 <20201018233136.GA4204@nand.local>
 <20201018194912.2716372-1-gitster@pobox.com>
 <xmqqmu0it6ls.fsf@gitster.c.googlers.com>
 <cover.1603142543.git.bkuhn@sfconservancy.org>
 <37a4932d48c1d36c3c512e9f8c0bcac878de6b76.1603142543.git.bkuhn@sfconservancy.org>
 <20201019220214.GB49623@nand.local>
 <cover.1603155607.git.bkuhn@sfconservancy.org>
 <20201020023407.GB54484@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020023407.GB54484@nand.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> Thanks; I think some of our emails crossed over one another, but this
> version looks good to me.

Yes, I was preparing the patch when you wrote that you disagreed with Junio
and preferred the ":".

FWIW, I left the ":" anywhere headers were being discussed and those headers
were described with ":"s on them.  I only changed places where
"Signed-off-by:" stood alone.

Before my v3 patchset, usage was inconsistent about (roughly half/half), so
the decision is mostly a coin toss.  I didn't have a strong opinion when I
was first writing the v3 patchset, but having thought about it overnight, I
now think leaving the ":" *out* is better because a reader new to Git is more
likely to think a ":" is punctuation, rather than being part of a moniker.
Thus, IMO, leaving out the ":" in most cases probably improves readability.


The remainder of this email is purely an edification question that may help
serve to improve Documentation/SubmittingPatches:

> I'd be happy to discard what's currently in seen (integrated as 1b98087e0f
> (Merge branch 'bk/sob-dco' into jch, 2020-10-19 at the time of writing) in
> favor of what's here.

I wasn't sure what I should be doing with the patch set once it was already
in 'seen'.  The only two references in SubmittingPatches I could find were:

From Documentation/SubmittingPatches:
>> In any time between the (2)-(3) cycle, the maintainer may pick it up from
>> the list and queue it to `seen`, in order to make it easier for people
>> play with it without having to pick up and apply the patch to their trees
>> themselves.

and

>> `git pull --rebase` will automatically skip already-applied patches, and
>> will let you know. This works only if you rebase on top of the branch in
>> which your patch has been merged (i.e. it will not tell you if your patch
>> is merged in `seen` if you rebase on top of master).

The former hints that you *shouldn't* change the workflow if some of your
patchset is in `seen`, and the latter hints that maybe you should, but
neither section tells you what to do differently, if anything, once your
patches are in `seen`.

I'm curious to know if I went wrong somewhere and the workflow and would be
glad to propose another patch to improve SubmittingPatches with a section of
what to do when patches show up in `seen`, but since I'm a n00b (at least as
an upstream Git contributor :), I'd need to know how to DTRT in this case to
do that.
--
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter
