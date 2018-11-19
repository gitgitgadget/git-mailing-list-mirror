Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-13.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D81A11F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 03:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeKSN4C (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 08:56:02 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:43689 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeKSN4B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 08:56:01 -0500
Received: by mail-lj1-f172.google.com with SMTP id 83-v6so1502691ljf.10
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 19:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JEozW/htW5y6RikiPFCtZ84fTtCXkPXQdNiFymvZ+7s=;
        b=nHWwQZnr35omBQi1vvIQXL+57BeXhWQoWN9bFJwjppxpDzlBRi83vCAwFRQq73sbHY
         tzGTm6mhZFWfMOOU1TGvs0TzuwnNmh/rnF4vMTxG0JTVPE+tJ+ucYffI+o4/+fMdkmq2
         HQ1MKHtWryeYngmT3pmu0wkpURtVo1vfszCdj0iQZRa2bcCjLfwxglWBSTewi/2WyuLd
         ZJlal83fzXD7fh97+xWgv4A5VHWSxdOlCwLcUIDy9227gM89Z67gwsIw2mczyo7XWDFj
         sKUyjCl7ZFKvY0+0kPMLWq28mJhJOZCKWYdMZfFA9yzX8Fu32JcVEWTmlLwmBoctJAmm
         4hmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEozW/htW5y6RikiPFCtZ84fTtCXkPXQdNiFymvZ+7s=;
        b=SmhQz/PlV/mxoVhGamPtAOzYXcWfGD9KEOH0sbyOs4kNQ/WEZtR5PpYdlS5u+eCm0q
         kXo809oUJ3Pccu2r/3CY8oh6D9YQeOAt3jt010bQ0R3yb/L8ByKrvgQNmVw6B8QkUb4T
         zwRk6XRcdGGhJ4idtqEgBnRydzw+mz8jjUk4p+Z9jy9yqZvo6laAllQ1PAb4gOOiu1Nt
         IZx2119FKLW06rF24q0gQI/pb3hgiZnLgTB87Jf6WgPMGUWR2Vg7468Du4puYnXcxyWj
         QpRqykPBa4ZucI6wvH4Ewc6kkCJcp+wh+XSLldhNOhOaKZnnodUxmVA3NoxMDF+/YbmJ
         wn7g==
X-Gm-Message-State: AGRZ1gJ9K+slrIizQ57ybzax5mp3UTL5OMuPoghXmKrFapxSdvaaS3iU
        Abc789yKNYRWMAsP2zkMx5z7fjxS92qV/3ZCgDOF6A==
X-Google-Smtp-Source: AJdET5e5vMllOI0GXDxJS9qSWbjY7JAbGFE85ke0WciJpDpAcm3sxCujDxQGZNsmrvT6ec8BpIvHS62QqvHYv8VvVUc=
X-Received: by 2002:a2e:568b:: with SMTP id k11-v6mr10605372lje.105.1542598425862;
 Sun, 18 Nov 2018 19:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20181115005546.212538-1-sxenos@google.com> <xmqqd0r4i29w.fsf@gitster-ct.c.googlers.com>
 <CAPL8Zisv-Q04Y_jQzMN7G9fG9rkWwxh4travnSw6cG0ZUFivkA@mail.gmail.com> <xmqqftvxertd.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftvxertd.fsf@gitster-ct.c.googlers.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Sun, 18 Nov 2018 19:33:33 -0800
Message-ID: <CAPL8ZisfhNqN3gh0E_=mwXuBPGRZ9fKgyQ=HWNFx_9m2job-=g@mail.gmail.com>
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

> I meant the project's history, not the meta-graph thing.

In that case, we agree. The proposal suggests that "origin" should be
reachable from the meta-graph for the cherry-picked commit, NOT the
cherry-picked commit itself. Does that resolve our disagreement, or is
reachability from the meta-graph also undesirable for you?

> By having a "this was cherry-picked from that commit" in a commit
> that is not GC'ed, the original commit that has no longer have any
> relevance (because the newer one that is the result of the
> cherry-pick is the surviving version people will be building on) is
> kept reachable.  It is very much delierate that "cherry-pick -x"
> does not make the "origin" reachable and merely notes it in the
> human readable form that is ignored by the reachablity machinery.

Hmm. It sounds like you may be arguing against reachability from the
cherry-picked commit (which we agree on). I'm arguing for reachability
ONLY from the meta-graph. From your reply it's not completely clear to
me whether you also disapprove of reachability from the meta-graph or
if you thought the origin edges would be present on the cherry-picked
commit itself. Could you clarify? I suspect it may be the latter,
which suggests ambiguity in the proposal. If you could point to the
text that gave the impression origin parents would be present in the
cherry-picked commits themselves, I'll fix it.

> This is where we differ.  If commit X was rewritten (perhaps with
> help from change cherry-picked from commit Z, or without any) to
> produce Y, I do agree that it would be logical to keep X around
> until every dependent commit on it are migrated to be on top of Y.

The scenario you describe would not produce an origin edge in the
metacommit graph. If the user amended X, there would be no origin
edges - just a replacement. If you cherry-picked Z you'd get no
replacements and just an origin. In neither case would you get both
types of parent. I'd suggest we focus on the cherry-pick scenario
since it's the simplest real-world use case that produces origin
parents. All the more complex scenarios involving both parent types
only occur if you start from that simple case, so if you convince me
that the origin-only use case is unnecessary or undesirable, it would
also follow that the more complex origin-plus-obsolete-parent use case
is unnecessary.

So, if you don't mind - let me simplify that use-case: "If commit Z is
cherry-picked to produce Y, is there any need to keep Z around?". I
don't think we need X in the example to answer that question.

> But we do not need Z to transplant what used to be on X on top of Y,
> do we?

That's correct. The origin parent would be used to incorporate amended
versions of Z into Y, not to transplant things. It would also be used
to locate ancestors when merging code based on Z with code based on Y.

> So I do agree that in such a situation they want the
> relevant parts of the history retained, but I do not agree that
> "origin" is among them.

You may be entirely right, but at this point I'm not certain whether
we're disagreeing or miscommunicating. :-(
