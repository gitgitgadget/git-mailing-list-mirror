Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB9D1F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 18:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfHNSdh (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 14:33:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34385 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNSdg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 14:33:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so13231pgc.1
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vcjkM+50nosEkGRhRRMYpSxUcAnWOMAaE+CG1A4LkyU=;
        b=Ix+NMokontkrtcY9gIe6/wYiOVWFZXCUSJaBZGTrQBSqoPiA9MVEhvfwYuFgB6I9eY
         NnIEr9DiosHFLpRbgsYEsxmOg1qZd4uW8vrsroDky3oMxRM4Iebv3CKr1pPcTUJtM7FL
         bXj4QVYPHR0NiW2/XXz4eR4FA7A7EGH96EKXlOZFZMI50HqkwNfnQUGTyyt9rSxLSVbn
         hc8RzIXya8YGSJEEYdGRY7R8TXvyP/C6LILJdunePtaEJ9S2e83pQQ871H+xWKqftizH
         hwvBzWVyj1CmytnULM7wosLaEatAVyePttSvRW+9VwC3DOyNbNAwzQxKtu1AElNDeyC0
         06dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vcjkM+50nosEkGRhRRMYpSxUcAnWOMAaE+CG1A4LkyU=;
        b=tE3cJCAYD8E0T7SjqYeTMvTe4JkSgTn0tWQM5HF5/3ok8lNtln2X7hXoebhaDkwE0N
         bh/dPw8URfD9UOb/NI/egLzZgrVqI3EH0lq3bSsIP8IUaa5PqQvM4yvx+TOSkyjNwUTf
         bp0VKZG9Ql2BzLtWRrp1JtUAD0/bBTiCSc0Bi1LqPejRNBfARiHLd/LM2zdMeXplOQWt
         aWD42bTrxhwpmNBBiXRysHCSIA9uyU2NgzEOYDYw1rqRxmYGzZksqVqx+fZ9zOK6JSmx
         cA8IXjIbjBkGS1JDKRpojxgDmvWvdFH3yuV3hrL/m79HazE14dNCmWAuv5Yxxajrs8Tc
         YyUw==
X-Gm-Message-State: APjAAAUqg6cYtTbOzO8XrHKQl5RvokUdrXvlo1fG8lPzmE1NxzOG8Zdf
        u01GLtIYwRSsTtC3AzQyLGZ8Hg==
X-Google-Smtp-Source: APXvYqx26cLsgfCH8AZkcgReV//GSdMFNgxAf+JCp8usmTnkwt9WEn4tgM4Nd0kKS/H5rvxZd3WLFw==
X-Received: by 2002:a17:90a:ff04:: with SMTP id ce4mr1017055pjb.77.1565807615054;
        Wed, 14 Aug 2019 11:33:35 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id m9sm498815pfh.84.2019.08.14.11.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:33:34 -0700 (PDT)
Date:   Wed, 14 Aug 2019 11:33:28 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v4] documentation: add tutorial for revision walking
Message-ID: <20190814183328.GA40797@google.com>
References: <20190806231952.39155-1-emilyshaffer@google.com>
 <xmqqwofohjgv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwofohjgv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 07, 2019 at 12:19:12PM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Since v3, only a couple of minor changes from Jonathan Tan - thanks.
> >
> > I'm dropping the updates for the RFC set, since they're incremental from
> > now. Next time you all see them they will be in a form which we would
> > hope to maintain over a long period of time, checked into source -
> > likely in the form of an mbox or dir of .patch file.
> 
> Sure.
> 
> > I think the tutorial itself is pretty much ready...
> 
> A few comments after skimming this round; none of them may be a show
> stopper, but others may have different opinions.
> 
>  - There is still a leftover "TODO: checking CLI options"; is that
>    something we postpone teaching?

Yeah, I think it would make more sense to include it into the other one
(my first contribution) instead.

> 
>  - This is an offtopic tangent, but "my first contribution" being an
>    addition of an entire command probably mistakenly raised the bar
>    to contributors a bit too much.  A typical first contribution is
>    a typofix, fix to a small (e.g. off-by-one) bug, etc.

Sure, I agree with that; but I think the larger (though less common)
project of new command allowed me to explain more about the architecture
of the project overall than a typo fix would. Maybe there's a clearer
name to use?

> 
>  - For a revision walk tutorial, not seeing any mention of pathspec
>    filtering and associated history simplification is somewhat
>    unsatisfying.  On the other hand, I expect that enumeration of
>    objects contained within commits is (hence various --filter
>    options are) totally uninteresting for end users who run the
>    command interactively and view the output of the command on
>    screen.
> 
>  - Enumeration of objects is useful at least in three places in Git:
>    (1) enumerate objects to be packed, with some filtering based on
>    various criteria; (2) enumerate objects that are reachable from
>    anchor points like refs, index, reflog, etc., to discover what
>    are not reachable and can be discarded; (3) enumerate objects
>    that still matter (i.e. the opposite of (2)) so that they can be
>    fed to validation mechanisms (e.g. "cat-file --batch-check").  If
>    this were titled "My first object enumeration", the reaction led
>    to the latter half of the previous point may not have occurred
>    (pathspec filtering would still be relevant, but not as
>    much---for packing to create a narrow clone, you do not want to
>    use pathspec with history simplification, but you would want to
>    use something more like "root and intermediate trees that are
>    necessary to cover these paths" filter in the
>    list--objects-filter layer).
> 
> And from the point of view of the last item, I would think the new
> document is covering a need that is different from what we
> traditionally would call "revision walk", which is more about "git
> log", not the upstream of "git pack-objects", which this new
> document is more geared towards.

Hmmm. It sounds like you're saying:

- This object covers walking objects, which is surprising since it's
  titled about "revision walks". Revision walks are more about commits
  ("git log").
- Using grep on objects doesn't make any sense.
- Other filters (like pathspecs) which do make sense for object walks
  aren't covered.

> 
> Unless "git walken" is an exercise of how to write code that does
> random thing, use of --grep filter however may be out of place,
> though.  I do not offhand think of a use case where --grep would be
> useful in the revision walk/object enumeration that is placed
> upstream of "pack-objects".

In this case, it might make sense to do one of these things:

- Apply the grep filter to the commit walk, and apply a more interesting
  object filter to the object walk.

Or,

- Choose a different kind of filter which is interesting when applied to
  commits alone _and_ all objects.

In the interest of covering more ground with this kind of tutorial, I'd
lean more towards the former.


It's possible that the added scope will make the document large enough
that we'd rather split it into two (one for "git log"-ish, one for "git
pack-objects"-ish). I think that's fine if we end up there.

Thanks. I hope to get back to this soon...

 - Emily
