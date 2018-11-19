Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-13.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87ED41F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 20:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbeKTGjj (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 01:39:39 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:46954 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbeKTGjj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 01:39:39 -0500
Received: by mail-lj1-f176.google.com with SMTP id v15-v6so27252985ljh.13
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 12:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDvhS4mPUmWhRnBFShvGngvlqVNWrmq6CnHAGbM08E4=;
        b=fI4Q4tLnIyKWdSvq8khaISPnkKUFkeElb1GJvCrWKeNzLWzMGhHIGChHGr6kACdKmk
         UVSIJ4Xx2QpzbVVNyGLG9CQzS/HDi8ohcNEBraEYOUNOUDyQLd14LGgBDMZ0kF6+x5cS
         uMaeyqsSNae4GVNmibTGql9bZ6Rq2v/0+9EgojQWOtz6QYozGF1hH5E2EIs2P6t6/EVE
         2m5HjKR29ueBoGNRQArHPQSvGy/aizUy5n2DJpvsvlwf+I3fqn0yADE11E470IVksbYA
         3ZGW893He2YXpvlXBh7ThPk5cnR65tSwyXJSGd+ejiy2atcsJUvYp6m59EL/Jg+b0vbp
         y28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDvhS4mPUmWhRnBFShvGngvlqVNWrmq6CnHAGbM08E4=;
        b=VgI6DKId+eCLHWPGXwEKO3eRH/INzsXljF7RoQMDL9olSBz8BC4SRJlVCixzDETHpM
         YODiC5wDTqtaFk/ecDKG92LDbMESgLizO7vQL+1vPPe7sn3A42VologJsNQs5k9kECOR
         CAWxvnSy7cdqbrAG58zXxPnYd9ZXQ0KDKyvU9I1vcpva2NrX6BJa9ogcFyhr4awvbMu2
         xULf8p+ntXPr0fgdFu9AX9YicVxOVFvMi87Zwjg6Il6gsN9a+2xIYGklztH3/E0y2Kjx
         eauW7wbgo9XIBJ1Crs4T5NwffUggT21ghUVEhSuJUYqRWnbGeKhis3tKZFIjShGbFTPe
         OtRA==
X-Gm-Message-State: AGRZ1gKvkKJi2A4ibcWgvRX72ysc3Br5lFlcIknGV2+EmZt/A8b1xufw
        M/boEw0COi9sXa9SHvnn0qSCstFqIY80DJmsqqHEN1i5xMY=
X-Google-Smtp-Source: AJdET5eL+hdHFW7yGVMrzThNn7e+7n5upv5mfM49NIHN2xpE4C6yG0HNeciD4LR3y7M+7/g91guho7ENK+Y6RUr1m7E=
X-Received: by 2002:a2e:5654:: with SMTP id k81-v6mr11953750ljb.48.1542658461866;
 Mon, 19 Nov 2018 12:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20181115005546.212538-1-sxenos@google.com> <xmqqd0r4i29w.fsf@gitster-ct.c.googlers.com>
 <CAPL8Zisv-Q04Y_jQzMN7G9fG9rkWwxh4travnSw6cG0ZUFivkA@mail.gmail.com>
 <xmqqftvxertd.fsf@gitster-ct.c.googlers.com> <CAPL8ZisfhNqN3gh0E_=mwXuBPGRZ9fKgyQ=HWNFx_9m2job-=g@mail.gmail.com>
 <xmqqwop9d7oq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwop9d7oq.fsf@gitster-ct.c.googlers.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Mon, 19 Nov 2018 12:14:09 -0800
Message-ID: <CAPL8ZisOH7vAPGSCv-RGZdYf56AjgvxXU6CQ9U7rir76u2ga0w@mail.gmail.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> But it is not immediately obvious to me how it would help to have "Z was cherry-picked from W" in "evolve".

The evolve command would use it for handling the
obsolescence-over-cherry-pick (OOCP) feature. If someone cherry-picks
a commit and then amends the original, the evolve command would give
you the option of applying the same amendment to the cherry-picked
version.

Are you claiming that this is undesirable, or are you claiming that
this could be accomplished without origin parents?

> the developer wanted to use the change between W^ and W in a context that is quite different from

I guess that depends on the reason for doing the cherry-pick. A very
common scenario I see for cherry-picks is cherry-picking a bugfix from
a development branch to a maintenance branch. In that situation, if
there was a better version of the original bugfix you'd also want to
update the cherry-pick on the maintenance branch to use the better
version of the fix. That's what OOCP does.

> make no sense to "evolve" anything that was built on top of W on top of Z.

Agreed. But that's not what evolve would do with the origin edges. It
would be looking for amendments of W, not children of W.

> It is of course OK to build a different feature that can take advantage of the cherry-pick information on top of the same meta commit concept in later steps

All valid points - we could build a useful "evolve" command without
origin edges (and without OOCP), we could easily add origin parents
later to a design that just supported obsolete and content parents,
and the decision about /when/ to add origin parents is orthogonal to
the decision about /if/ to add them.

Lets explore the "when" question. I think there's a compelling reason
to add them as soon as possible - namely, gerrit. If and when we come
to some sort of agreement on this proposal, gerrit could start adding
tooling to understand change graphs as an alternative to change-id
footers. That work could proceed in parallel with the work in git-core
once we know what the data structures look like, but it can't start
until the data structures are sufficient to address all the use cases
that were previously covered by change-id. At the moment, meta-commits
without origin parents would not cover all of gerrit's use-cases so
this would block adoption in gerrit.

  - Stefan
On Sun, Nov 18, 2018 at 8:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Xenos <sxenos@google.com> writes:
>
> > The scenario you describe would not produce an origin edge in the
> > metacommit graph. If the user amended X, there would be no origin
> > edges - just a replacement. If you cherry-picked Z you'd get no
> > replacements and just an origin. In neither case would you get both
> > types of parent.
>
> OK, that makes things a lot simpler.
>
> I can see why we want to record "commit X obsoletes commit Y" to
> help the "evolve" feature, which was the original motivation this
> started the whole discussion.  But it is not immediately obvious to
> me how it would help to have "Z was cherry-picked from W" in
> "evolve".
>
> The whole point of cherry-picking an old commit W to produce a new
> commit Z is because the developer wanted to use the change between
> W^ and W in a context that is quite different from W^, so it would
> make no sense to "evolve" anything that was built on top of W on top
> of Z.
>
> It is of course OK to build a different feature that can take
> advantage of the cherry-pick information on top of the same meta
> commit concept in later steps, and to ensure that is doable, the
> initial meta commit design must be done in a way that is flexible
> enough to be extended, but it is not clear to me if this "origin"
> thing is "while this does not have much to do with 'evolve', let's
> throw in fields that would help another feature while we are at it"
> or "in addition to 'X obsoletes Y', we need the cherry-pick
> information for 'evolve' feature because..." (and because it is not
> clear, I am assuming that it is the former).  If we can design the
> "evolve" thing with only the "contents" and "obsoletes", that would
> allow us to limit the scope of discussion we need to have around
> meta commit and have something that works earlier, wouldn't it?
>
> Thanks.
