Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D28A20248
	for <e@80x24.org>; Wed, 27 Mar 2019 00:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbfC0AeB (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 20:34:01 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42550 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731873AbfC0AeB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 20:34:01 -0400
Received: by mail-vk1-f193.google.com with SMTP id j195so3266793vkj.9
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 17:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXkQDO2vTVikciuDjeAZWHZCIXK9R1eRl/iREH/u/mQ=;
        b=VhC28rJmpd+/Y0iCE95jReQnqIcidnSnkwR+ksv/srNWz1pH7OsbHuLtcMu38FMT3x
         pQbTmXWMXhw5upwZz239OF4gUEu8158+EzsTcEm36MzQnA71BAWVlUgB4Md7eYLo2hJp
         wXlcRMWa+lKiQxI8lPcgZ7aV3NhcPCjpsHK5MlghRs98O/LZ5RFz0OaMLJd4nFg61aIp
         BFLQZZ2bgyaqsnUWFCuXtmNKsCTnj0INn1/B2f2kaYiaj/xywwpQT7GhU3OqdLfwQuve
         LS/8H2uxNNERR+j/8tkzA/KugshZeeT3hFWkSiFEzVDDPLYasBJhXEt6JgXcac5MYHuo
         1b/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXkQDO2vTVikciuDjeAZWHZCIXK9R1eRl/iREH/u/mQ=;
        b=dakhMzXcG7xDkv2IIJBBzUR8qx4qye2Wjl4ao9FAhUPjRyxWL/oBQx/9NoFyTRLZhx
         gz5mRdYTGP5dG8UqXGgX2BSk1FQiVY/O0DYJLY12dRfIx3Xnr4JTllv8adspIrvjh12/
         cstbbM7YuEaT3ITCQp61On4llG54+pMLi7gRBR5ymccpZUrHdArfGxsts/CyzHWnX4t7
         A8YOIFflf2yFidersG4UkOGGHKD1M+DUiej5FLtZmLH8Owt6LDcJJwW+rKYTJ1lwDLx/
         FtcARQtbNC4rpegv4kfY6UlU4U6rgtO8TkqgQ/xh+t+Ij2hlGW/+ZF0Aeicuyt7cjH4l
         2prQ==
X-Gm-Message-State: APjAAAWzTct8NnEwTbVTFnIanIHHJ6pwfp185K76KUNBTfcSGYX+BRfV
        LkgyDPpv3fiqP6BS0UkN4kD73gh68Q2VRkwz36g=
X-Google-Smtp-Source: APXvYqy8SRhvNmrWleQpOJ5GRG9r8pZg8I86GCvxeNEGPUI+ZN8xuZFfaOaNp8Y00GvT+ZehIkLkp/wQvrXRpymujUk=
X-Received: by 2002:a1f:d8c1:: with SMTP id p184mr20006470vkg.1.1553646839725;
 Tue, 26 Mar 2019 17:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <87efh0pdln.fsf@javad.com> <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
 <8736nj2jcl.fsf@javad.com> <xmqqbm26xtum.fsf@gitster-ct.c.googlers.com>
 <87h8bra1z6.fsf@javad.com> <20190326163204.GC29627@sigill.intra.peff.net>
 <CABPp-BF7cd2+4jr=zGVP8x_QLdFbyOoGRWUgMtgiGDCdqZdjFA@mail.gmail.com> <20190326222052.GD1445@sigill.intra.peff.net>
In-Reply-To: <20190326222052.GD1445@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Mar 2019 17:33:47 -0700
Message-ID: <CABPp-BGoH3qE0VqMyov-3YTSFSgDBy6xTKKgrckabnAt2pz05A@mail.gmail.com>
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m
 1' is specified
To:     Jeff King <peff@peff.net>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 3:20 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Mar 26, 2019 at 03:07:42PM -0700, Elijah Newren wrote:
>
> > On Tue, Mar 26, 2019 at 9:35 AM Jeff King <peff@peff.net> wrote:
> > >
> > > On Mon, Mar 25, 2019 at 09:43:09AM +0300, Sergey Organov wrote:
> > >
> > > > How about changing "git show -p M" to output "diff -p M^ M" rather than
> > > > "diff-tree --cc M" for merge commits? It's really surprising specifying
> > > > -p has no visible effect.
> > >
> > > That's because "-p" is already the default, and the format selection is
> > > orthogonal to the handling of merge commits. Providing "-m" would
> > > actually override the "--cc" default (though "--first-parent -m" is
> > > likely to be less noisy, per this discussion).
> > >
> > > As far as defaults go, I dunno. The idea is that "--cc" would give you a
> > > nice summary of what the merge _itself_ had to touch. I think that's
> > > valuable, too. If we were starting from scratch, I think there could be
> > > a discussion about whether one default is better than the other. But at
> > > this point I have a hard time finding one so much obviously better than
> > > the other to merit changing the behavior.
> >
> > Indeed, some of us would view a first parent diff default for merges
> > as problematic.  However, I'd like to point out (or remind) that these
> > two options aren't the only ways you could view a merge.  Thomas
> > Rast's --remerge-diff[1] is another (even if not yet part of git.git).
> > Gerrit uses something similar-ish for its default way of showing a
> > merge.
>
> Heh, I almost mentioned remerge-diff, but since it's not actually part
> of Git, I didn't want to get into a tangent. But since you mention it,
> yes, I actually find it quite a useful way of looking at the diff,
> especially when I want to see what the person resolving the conflicts
> actually _did_. The --cc combined diff is too eager to throw away hunks
> that resolved purely to one side (which _most_ of the time is what you
> want, but when you're hunting a possible error in the merge, it's quite
> confusing).
>
> How close is merge-recursive.c to actually doing a pure in-memory merge?
>
> I seem to recall that was a (the?) sticking point for the original
> remerge-diff.

Doing a pure in-memory merge is tied up with my overall
merge-recursive rewrite, but I haven't touched merge stuff in quite a
while now other than the recent
make-directory-rename-detection-be-a-conflict-by-default stuff.  I'm
hoping I can finish that soon (though I've struggled a bit to find the
time to do so), and finish out the filter-repo stuff, then I plan to
get back to merge stuff again.  A pure in-memory merge is near the top
of my priorities for the rewrite, so we'll get it...eventually.
(Maybe a Christmas present?)

I do think there's more than just that sticking point for the
remerge-diff, but the other things are on my radar too (a few slots
later on my todo list).
