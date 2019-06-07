Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 352F81F462
	for <e@80x24.org>; Fri,  7 Jun 2019 21:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbfFGVKI (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 17:10:08 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:35224 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730251AbfFGVKI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 17:10:08 -0400
Received: by mail-pg1-f173.google.com with SMTP id s27so1783774pgl.2
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+y3hjRiIaWPxngGbjnDl1XbNjgdm+gPt8VCm40Quva4=;
        b=EPlclUkm6RR3MAu0HQrha2wF6nlxX2VGxPOk2SRwo1RYUQdG/aD/4dVhDtplqCdLCY
         KjztoXT1m92iqYDSOXIEHBPnaNt1FCKwknMvRuHuE97zAMFZzxhPhkZ6tA7S9uG+d29o
         dyRCcORoe2cb6T5fbLT8a2eKzV4vUuRWH+ng7GY3O0PBa041lFXDm8wyhlnlBLOAELCP
         j0T/7t0DrB0aIu28bmDd4hiwKpSmP21HUy5b+7PWLKdgXy5fWMJRKJaNqzA5X2J74n14
         ilrgu60X+618A4HQX6KR3epks7EzKWPp1UmVc9vyjNY2/cjDolUukzPGCx8JfFbGUNAb
         EOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+y3hjRiIaWPxngGbjnDl1XbNjgdm+gPt8VCm40Quva4=;
        b=hA1MKbU98Of+sOywVRgWeSs38JzCuZU1TrTNac1YBCAiJ6z7pbP5bp/SHbo01RdPaB
         88VmL/ckczo7MBwmsDXTKCvUEahXlPyIV5SNPM8qPESuTIS1UiUx2VXGaaMf70ngnaqq
         8srUErgBzBSztSdN3yJ1ZrAeJQH9lzl6cglFcGuPNUHYg4lyvUj18sUc3XyI7fQPcENp
         4AZ6n8SqdOlafz40BryM8BXyA6IPaCAduIFqs+E5aUnq+1wIOCHyDkBbEtfoUfrJwiAp
         ZN22Utrg/1x9pftm0o+32sAmoQ1lVXjRSGlkbjDEGWzVprOlxDnZc2KerB8VAo6E0sOe
         akOg==
X-Gm-Message-State: APjAAAV6AO8o8RU8F1ps3KyF37HgmgGOS0UoginvehU/A+htGCf6HQsA
        7gQC5wXRs5T6yCyOhSiXzXDPhk3FsU7AIg==
X-Google-Smtp-Source: APXvYqwjQ5/Vhx5wFeharbq0MufX/04uWY8jjlvL+s7l3q2scnTXx3urheMzghzdI10WkR29fQnUbw==
X-Received: by 2002:a63:6142:: with SMTP id v63mr4874832pgb.309.1559941806591;
        Fri, 07 Jun 2019 14:10:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id x127sm3163471pfb.107.2019.06.07.14.10.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 14:10:05 -0700 (PDT)
Date:   Fri, 7 Jun 2019 14:10:01 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Is --filter-print-omitted correct/used/needed?
Message-ID: <20190607211001.GA197548@google.com>
References: <CAJoAoZktk-w40MEsRZesvkX23Xn2uMUPiO_cMHa=-xfdyVHCWg@mail.gmail.com>
 <CAP8UFD2Kyq9nrAnoj3AxQyLgiGHycLEdJbJOQx_stsepsqmX4g@mail.gmail.com>
 <e9017ba5-5b52-9e50-96ff-743d7e2ff4df@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9017ba5-5b52-9e50-96ff-743d7e2ff4df@jeffhostetler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 07, 2019 at 02:57:01PM -0400, Jeff Hostetler wrote:
> 
> 
> On 6/7/2019 2:38 AM, Christian Couder wrote:
> > On Thu, Jun 6, 2019 at 10:18 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > 
> > 
> > 
> > > I grepped the Git source and found that we only provide a non-NULL
> > > "omitted" when someone calls "git rev-list --filter-print-omitted",
> > > which we verify with a simple test case for "blobs:none", in which
> > > case the "border" objects which were omitted must be the same as all
> > > objects which were omitted (since blobs aren't pointing to anything
> > > else). I think if we had written a similar test case with some trees
> > > we expect to omit we might have noticed sooner.
> > 
> > It seems that --filter-print-omitted was introduced in caf3827e2f
> > (rev-list: add list-objects filtering support, 2017-11-21) so I cc'ed
> > Jeff.
> > 
> > [...]
> 
> The --filter-print-omitted was intended to print the complete list
> of omitted objects.  For example, a packfile built from a filtered
> command and a packfile build from the unfiltered command would differ
> by exactly that set of objects.
> 
> So the discrepancy reported by the tree:1 example is incorrect.
> The omitted set is the full set, not the frontier.  So when
> --filter-print-omitted is used, we still have to do the full tree walk.
> When not specified, we do get the perf boost because we can terminate
> the tree walk early.
> 
> 
> > > So, what do we use --filter-print-omitted for? Is anybody needing it?
> > > Or do we just use it to verify this one test case? Should we fix it,
> > > or get rid of it, or neither?
> > 
> > In caf3827e2f there is:
> > 
> >      This patch introduces handling of missing objects to help
> >      debugging and development of the "partial clone" mechanism,
> >      and once the mechanism is implemented, for a power user to
> >      perform operations that are missing-object aware without
> >      incurring the cost of checking if a missing link is expected.
> > 
> > So I would say that if you think that --filter-print-omitted doesn't
> > help in debugging or development, and can even be confusing, and that
> > it also doesn't help performance for power users or anyone else, then
> > it would make sense to remove it, unless you find a way to make it
> > fulfill its original goals, or maybe other worthwhile goals.
> 
> I don't currently have a use for that (other than the existing test
> cases), but we could use that in the future as a guide for the server
> to put the omitted objects on a CDN, for example.
> 
> So I'd say let's leave it as is for now.

Thanks for the input, Jeff. I wasn't sure from looking at it whether it
was intended behavior with a plan for use; looks like it is. I'll leave
it alone.

> 
> 
> Jeff
> 
> 
> 
