Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3901A20756
	for <e@80x24.org>; Fri, 20 Jan 2017 22:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbdATWBi (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 17:01:38 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36188 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751217AbdATWAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 17:00:25 -0500
Received: by mail-lf0-f47.google.com with SMTP id z134so65760098lff.3
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 14:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zZp9RPVK0RHP42/JpF1DUs2q+CPEr3grOOwBN2Sa028=;
        b=UysUePIAINXUhvTEuZ8KcyV9s2pnYJq79ya6+LqsNy/hgs8tnbC0D9psRuJMkV16M8
         eLUzjC72MVr+RJtZiMIRiztSkxD48NkAKMn8cGGRkfoXmib5s/cK+1a7V2i9gDhWIpxA
         WrUnUsRcVc8ipb+XPl/g3ZRlr/p1vRj5Awd3/JY7rkpi9L73qZ0eMfu37/0jMHVR7iTe
         7855eG4MxupntxbGMIgNq8ltKr7ZgZVMGxgDZkRMDjSiZTZwGHwbqbL6E5TnOXfwiCCK
         7rI5ygHtwD/bKCJr+7hfKsPFdk8IrsQip5LAZCZvUlAGhYC2x0jN8BskuxalgOZYhnr1
         iC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zZp9RPVK0RHP42/JpF1DUs2q+CPEr3grOOwBN2Sa028=;
        b=U4iQBJ4r6ZZkuAoDjn7kR+TuOiTrluvR/aalXZkm+a/s9tIyVXj3/Bs+pJpARH2X7a
         5R1+v19WHQrrwyWd+uP4l+om/XXt39DnxndG/oyjQr9cd7TaBVeL2rlGcHCOQ5p0mFH1
         l2sWhHUwxm2Phv7qDGsk/iFjJWfIXtrgjZuP/9dSbLaDxmE+hXIfP3bRf2l20Deg7iq0
         fcnXWYSPd0836aXvJAAoTOnMyIvIjySgAopLTPxwY6KtaFikk46Yidp1l07CFwM0+ce1
         FT/MAweGuBfAFhJFNZWRkVLwr2jKvSU9ReDB0v5r58EhCqp12KqT+tWihMfUef9q0mnz
         kfgg==
X-Gm-Message-State: AIkVDXIYyMoodZks4zo6ID50na9MB9zYjeK83MU0PH9dL7L6UAExEdlulw2zxbBKX9QUV0B1zt+o+78pkcKokg==
X-Received: by 10.25.10.6 with SMTP id 6mr5958718lfk.88.1484949623615; Fri, 20
 Jan 2017 14:00:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Fri, 20 Jan 2017 14:00:03 -0800 (PST)
In-Reply-To: <20170120143031.p2mux5uxxzniovkx@sigill.intra.peff.net>
References: <20170119122630.27645-1-pclouds@gmail.com> <20170119172310.6meuj6ksxloeee2t@sigill.intra.peff.net>
 <CACsJy8A_LkRMZYfoJuYEUok4r7Tw0VuMwVkG_Kr1o1hFcAUWNw@mail.gmail.com> <20170120143031.p2mux5uxxzniovkx@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 20 Jan 2017 14:00:03 -0800
Message-ID: <CA+P7+xqgyUW-Wt2oUSCc86HG-MfL-itAu2yVrZ219LNwqQnwKw@mail.gmail.com>
Subject: Re: [PATCH] log: new option decorate reflog of remote refs
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 6:30 AM, Jeff King <peff@peff.net> wrote:
>> Imposing order between options could cause confusion, I think, if you
>> remove --decorate-reflog leaving --remotes on by accident, now you get
>> --remotes with a new meaning. We could go with something like
>> --decodate-reflog=remote, but that clashes with the number of reflog
>> entries and we may need a separator, like --decorate-reflog=remote,3.
>> Or we could add something to --decorate= in addition to
>> short|full|auto|no. Something like --decorate=full,reflog or
>> --decorate=full,reflog=remote,entries=3 if I want 3 reflog entries.
>
> I agree that making option-order important is potentially confusing. But
> it does already exist with --exclude. It's necessary to specify some
> sets of refs (e.g., all of A, except for those that match B, and then
> all of C, including those that match B).
>
> Having --decorate-reflog=remote would be similarly constrained. You
> couldn't do "decorate all remotes except for these ones". For that
> matter, I'm not sure how you would do "decorate just the refs from
> origin".
>
> I'll grant that those are going to be a lot less common than just "all
> the remotes" (or all the tags, or whatever). I'd just hate to see us
> revisiting this in a year to generalize it, and being stuck with
> historical baggage.
>
>> My hesitant to go that far is because I suspect decorating reflog
>> won't be helpful for non-remotes. But I'm willing to make more changes
>> if it opens door to master.
>
> Forgetting reflogs for a moment, I'd actually find it useful to just
> decorate tags and local branches, but not remotes. But right now there
> isn't any way to select which refs are worthy of decoration (reflog or
> not).
>
> That's why I'm thinking so much about a general ref-selection system. I
> agree the "--exclude=... --remotes" thing is complicated, but it's also
> the ref-selection system we _already_ have, which to me is a slight
> point in its favor.
>
> -Peff

I agree that the interaction between --exclude and --remotes/etc is
confusing, but I think it's reasonable enough because we already
support it, so it makes sense to extend it with this. I also think its
better to extend here than it is to hard-code it. We could provide a
single short-option that does the longer variant if it's that common.

Thanks,
Jake
