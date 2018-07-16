Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19A111F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbeGPVi5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:38:57 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35617 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbeGPVi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:38:56 -0400
Received: by mail-ua0-f194.google.com with SMTP id q12-v6so25775763ual.2
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ux+vjwZHPLjyuQYB+4hgP1/gcpLjtqXF6z4v839KXqE=;
        b=m1L/jDSL5sAgcI/cD9oERqUDGxHyi6f9MWT1gy7Ru2QoJFUmLBRk7Hiuh5Ak8+ynH3
         7VHEY2WK7Om7JtldpgYRxjpZ52a6DTwf8Ll/Ds4mfSG1JLh9tqOww2Dviy42IlIKmOgZ
         y0CQ17HpthtusOumVslkptz7s40v2x/5+qa9Jf3T7lJBwUolRE2zUF3wc98tc7JQKLCm
         70L4p7ahksMeJZQ/Vmsd1GUJCuk9ju+1EpsYVFjnJucl+6fzu7X2G/qp4dbOezWldu7P
         mZhcCR5F4dnw8tc6TrBe3x87vpbLRPf6Y+X0KZ4r/61BeOpHDVku5W8zopUgJLF9eTXa
         hzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ux+vjwZHPLjyuQYB+4hgP1/gcpLjtqXF6z4v839KXqE=;
        b=cMoxQu9mLJJ7SzdrhUvzUuKqVmnWaaMJspVPOcwRMpbV5nPwkLNxicZYusOmxb5MUd
         GSFLy+c5qB5baa/RnE+Z7uqkUX/vR+qEANNXebkeBWt39ieHfZnJqrker2eghb7MZAT3
         cXl48KRdlSqwqQ3QFOUE0BSed+ezkkMfo2JksDuT0Xzc3YZNaAyco3piR3AR5GVTwFXi
         KSEAQROUOWUP+xGOruMzamykqkJdK9JbWxzxm6cET1ULpWCx2WEYlEJKpBUW4Uyhtt/2
         QdiRKWWDb6xeHDU5SWDtaoGuiXsL0RRnNKRarC2SxmhzafvPfymIcn5ehFANAIhufrNH
         jJzw==
X-Gm-Message-State: AOUpUlH10xnKE31te2LH9lYczEut0RycDddJOdN5P2tOqR9Vg28xzssi
        AlOHDp++M3vXuPGzV6cXDzfB3AxoSMV0mkIsors=
X-Google-Smtp-Source: AAOMgpe6pgSezTMLFRl61M6JkGisFaY50eBa9IcccDexjOhvSg4kX1jgIf4cjTPuSX3X3ZjLP4ancwUr/op0j0yR/mw=
X-Received: by 2002:ab0:12e2:: with SMTP id o34-v6mr12286129uac.154.1531775384378;
 Mon, 16 Jul 2018 14:09:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 14:09:43
 -0700 (PDT)
In-Reply-To: <20180716203847.GE25189@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716191505.857-1-newren@gmail.com> <20180716195226.GB25189@sigill.intra.peff.net>
 <CABPp-BGdzyhPkFYyocqArtMX8=cDKFuV88q3mboeaTDjt275Tw@mail.gmail.com> <20180716203847.GE25189@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Jul 2018 14:09:43 -0700
Message-ID: <CABPp-BEpCF9FE7eJwZWjY+bMsjDQnnDaSrHO+e3DtDDsR-=7Hg@mail.gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 1:38 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 16, 2018 at 01:16:45PM -0700, Elijah Newren wrote:
>
>> >> The basic problem here, at least for us, is that gc has enough
>> >> information to know it could expunge some objects, but because of how
>> >> it is structured in terms of several substeps (reflog expiration,
>> >> repack, prune), the information is lost between the steps and it
>> >> instead writes them out as unreachable objects.  If we could prune (or
>> >> avoid exploding) loose objects that are only reachable from reflog
>> >> entries that we are expiring, then the problem goes away for us.  (I
>> >> totally understand that other repos may have enough unreachable
>> >> objects for other reasons that Peff's suggestion to just pack up
>> >> unreachable objects is still a really good idea.  But on its own, it
>> >> seems like a waste since it's packing stuff that we know we could just
>> >> expunge.)
>> >
>> > No, we should have expunged everything that could be during the "repack"
>> > and "prune" steps. We feed the expiration time to repack, so that it
>> > knows to drop objects entirely instead of exploding them loose.
>>
>> Um, except it doesn't actually do that.  The testcase I provided shows
>> that it leaves around 10000 objects that are totally deletable and
>> were only previously referenced by reflog entries -- entries that gc
>> removed without removing the corresponding objects.
>
> What's your definition of "totally deletable"?

The point of gc is to: expire reflogs, repack referenced objects, and
delete loose objects that (1) are no longer referenced and (2) are
"old enough".

The "old enough" bit is the special part here.  Before the gc, those
objects were referenced (only by old reflog entries) and were found in
a pack.  git currently writes those objects out to disk and gives them
the age of the packfile they are contained in, which I think is the
source of the bug.  We have a reference for those objects from the
reflogs, know they aren't referenced anywhere else, so those objects
to me are the age of those reflog entries: 90 days.  As such, they are
"old enough" and should be deleted.

With big repos, it's easy to get into situations where there are well
more than 10000 objects satisfying these conditions.  In fact, it's
not all that rare that the repo has far more loose objects after a git
gc than before.

I never got around to fixing it properly, though, because 'git prune'
is such a handy workaround that for now.  Having people nuke all their
loose objects is a bit risky, but the only other workaround people had
was to re-clone (waiting the requisite 20+ minutes for the repo to
download) and throw away their old clone.  (Though some people even
went that route, IIRC.)

> If the pack they were in is less than 2 weeks old, then they are
> unreachable but "fresh", and are intentionally retained. If it was older
> than 2 weeks, they should have been deleted.

That's what's currently implemented, yes, but as above I think that
logic is bad.

> If you don't like that policy, you can set gc.pruneExpire to something
> lower (including "now", but watch out, as that can race with other
> operations!). But I don't think that's an implementation short-coming.
> It's intentional to keep those objects. It's just that the format
> they're in is inefficient and confuses later gc runs.

I'm aware of pruneExpire, but I think it's the wrong way to handle this.

I totally agree with your general plan to put unreferenced loose
objects into a pack.  However, I don't think these objects should be
part of that pack; they should just be deleted instead.
