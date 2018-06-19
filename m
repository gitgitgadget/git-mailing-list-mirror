Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B46561F403
	for <e@80x24.org>; Tue, 19 Jun 2018 17:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966939AbeFSRcy (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 13:32:54 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41887 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966368AbeFSRcx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 13:32:53 -0400
Received: by mail-pg0-f67.google.com with SMTP id l65-v6so179906pgl.8
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 10:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wU0Q1uCpZVwmvkUo5lrxEOdLIm3vfNmbvJ0vfxIJXxE=;
        b=L+m9GVqA/ytHeeeqdVofiWbS7i4zdTrU3A955A1wjUrR0MUFVz7bbOIXZDyddu9GtI
         CgEHUnB3t5yqrjntiL6gT5yknK7NXB2F1dKZEBp4Y6A756Z8WOWQhx7CFNNkFiBhSe/d
         W4t5BuTQq0G+SbXQEtcygLjTuJPGV8/mfGcJLUn6IL9ran6vlJZZ007LNIrpiFcddhQS
         wSMcI4/apBHVkXuyfsinOJH7tyRhecoFnrIUpwZsTYTWKIOSoUIQT2Ae7/UzBGaBWn28
         +Zrpigz+5WUu4OjU0+EkTWF8+U8LlBVj/mOH+bDQG/SkBRLqPJMMYn42ddmZh3h6fpDA
         zRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wU0Q1uCpZVwmvkUo5lrxEOdLIm3vfNmbvJ0vfxIJXxE=;
        b=MHS1rnAF9TpmUdWZrecPqeaZkst1I4KDjRDI9JKOHqrZAnsZol6QbUGeuYsjWrgYP6
         VTGB0IxWro6qt4OyTG+zRtJLdwG8TJNPMe7PJHgxNpeWYTkJV1r1G5VJ5Y/D9H7pHHIv
         12cveikSBQESUPkO+eSHYVJ5SEABVT7k8OT9WKo8LC9YB2oaabAYDG8etDnyJpNs71Ad
         b3brfiKvyIoMgE7ycdhRrhwdIsIobYxMzdsxkiuzRgV3QdH0y2JSq3oJk4gyny4ivObN
         P/xcOqjxv7kFzma/6qfnpHYjuClTBH2D0xk2+IToIK2ZjEQrRqSZdlXGJbC0jaFxFaGK
         xpOQ==
X-Gm-Message-State: APt69E2K6m/0XSJCDRVpu/GPlwGKymEH/AoGi12raIVHsyH2OoZe47rW
        GtWVOgNKUdFVwOVs51gw9g1kGg==
X-Google-Smtp-Source: ADUXVKIrIc9CGM3ONBkgywGGnzsnje12ShPblnlQ8UYLpdU60i7FhYyhKcpFyFx7Vct85tEO26D0Kw==
X-Received: by 2002:a65:614e:: with SMTP id o14-v6mr15954635pgv.308.1529429572910;
        Tue, 19 Jun 2018 10:32:52 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id c27-v6sm426272pfl.63.2018.06.19.10.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 10:32:51 -0700 (PDT)
Date:   Tue, 19 Jun 2018 10:32:50 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/8] ref-in-want
Message-ID: <20180619173250.GA199585@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
 <20180615190458.147775-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615190458.147775-1-jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/15, Jonathan Tan wrote:
> (replying to the original since my e-mail is about design)
> 
> > This version of ref-in-want is a bit more restrictive than what Jonathan
> > originally proposed (only full ref names are allowed instead of globs
> > and OIDs), but it is meant to accomplish the same goal (solve the issues
> > of refs changing during negotiation).
> 
> One question remains: are we planning to expand this feature (e.g. to
> support patterns ending in *, or to support any pattern that can appear
> on the LHS of a refspec), and if yes, are we OK with having 2 or more
> versions of the service in the wild, each having different pattern
> support?
> 
> Supporting patterns would mean that we would possibly be able to
> eliminate the ls-refs step, thus saving at least a RTT. (Originally I
> thought that supporting patterns would also allow us to tolerate refs
> being removed during the fetch process, but I see that this is already
> handled by the server ignoring "want-ref <ref>" wherein <ref> doesn't
> exist on the server.)
> 
> However, after some in-office discussion, I see that eliminating the
> ls-refs step means that we lose some optimizations that can only be done
> when we see that we already have a sought remote ref. For example, in a
> repo like this:
> 
>  A
>  |
>  O
>  |
>  O B C
>  |/ /
>  O O
>  |/
>  O
> 
> in which we have rarely-updated branches that we still want to fetch
> (e.g. an annotated tag when we fetch refs/tags/* or a Gerrit
> refs/changes/* branch), having the ref advertisement first means that we
> can omit them from our "want" or "want-ref" list. But not having them
> means that we send "want-ref refs/tags/*" to the server, and during
> negotiation inform the server of our master branch (A), and since the
> server knows of a common ancestor of all our wants (A, B, C), it will
> terminate the negotiation and send the objects specific to branches B
> and C even though it didn't need to.
> 
> So maybe we still need to keep the ls-refs step around, and thus, this
> design of only accepting exact refs is perhaps good enough for now.

I think that taking a smaller step first it probably better.  This is
something that we've done in the past with the shallow features and
later capabilities were added to add different ways to request shallow
fetches.

That being said, if we find that this feature doesn't work as-is and
needs the extra complexity of patterns from the start then they should
be added.  But it doesn't seem like there's a concrete reason at the
moment.

-- 
Brandon Williams
