Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 574B520248
	for <e@80x24.org>; Sat,  6 Apr 2019 05:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfDFFXZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 01:23:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34035 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfDFFXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 01:23:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so4165003pgq.1
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 22:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e81pohi3eYOa+k27YV3wVDhqlxvWlQ1GvIk8J1yQ4Uc=;
        b=SlDiSQo0y7ndWlu7ITltHV3DTLuksT6Z/mFCrQTcymrpSBoudoX1i81N4coAU5sUnf
         b5HH9qACVCOaUwvQ/ALRpi6FrUgc+k7kT88mDcbQJomvS1AZfDQhQl4F/N3hDNEnHVi+
         gf1ZDk2AbXxPSzV/3kkto3BBp9yP4QWBrDgcavrojgSFLqm2/Z2x3orMLemEfD9TiJ0V
         4PDa0vpzi9c5vWE041j5/YFAgWNqI7//uwSXKiQDhXJa4yMndYWqGzwgLTpIxPU1W5Bf
         BNih3VxjMAa5tL4PAmQr5sQ12VhX1TtdtxT1ZtpaAFnhxVhXsymGvO10zunaBS5TJBBm
         m9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e81pohi3eYOa+k27YV3wVDhqlxvWlQ1GvIk8J1yQ4Uc=;
        b=qyIlaDHNTET2+F5JEK6PiwlI3EkM7MrYPCH3sz3vAPb4xInCxgMYlKHfhxViwdMkgg
         HRJ+9lQjyGUpPoxahBvP9fZErVInRfBhtC7VCtHuV+itSa+B10PkP/7z1NK/r4sfRTwC
         Qauqom7Fm30oAACaOZkxnFjZ0f9PI51DX/NuxS9Mk4HbdH+fWVZde42OgyfVo9gYPt3Z
         48nNrACOZuiwdA1HcLFvufdp+PWQJ56QWyGIC3nfbvulgE0CmJGE1EwApHFJdgByKO2Y
         ZrU8frCm90Giew7cGqg37eeKgDIz5KK87Nj1af2auz2LJMKDP09wwPukXXOjy3YnGUCl
         zbPw==
X-Gm-Message-State: APjAAAVsuKQXeW6xbJXl3+ibNQwC49QvtxlF8ZzT0cWvMXQf/RlP5oUc
        gj5W43WaDBAwtmegA3mfrxLCBrP4wR2ubQ==
X-Google-Smtp-Source: APXvYqwGzRCD5DGZMenaiG6dp72VjAX+Eo3OFBL7uK1oX7LcIe5k0w+e8HjAdCmGnKusduxVajsY7A==
X-Received: by 2002:aa7:914d:: with SMTP id 13mr16912619pfi.149.1554528204409;
        Fri, 05 Apr 2019 22:23:24 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e077:74b2:7faa:e131])
        by smtp.gmail.com with ESMTPSA id c17sm33807184pfd.76.2019.04.05.22.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 22:23:23 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Fri, 5 Apr 2019 22:23:22 -0700
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <20190406052322.GA37216@Taylors-MBP.hsd1.wa.comcast.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405183142.GD2284@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405183142.GD2284@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, Apr 05, 2019 at 02:31:42PM -0400, Jeff King wrote:
> On Thu, Apr 04, 2019 at 08:37:44PM -0700, Taylor Blau wrote:
>
> > Let A be the object referenced with an unexpected type, and B be the
> > object doing the referencing. Do the following:
> >
> >   - test 'git rev-list --objects A B'. This causes A to be "cached", and
> >     presents the above scenario.
> >
> > Likewise, if we have a tree entry that claims to be a tree (for example)
> > but points to another object type (say, a blob), there are two ways we
> > might find out:
> >
> >   - when we call lookup_tree(), we might find that we've already seen
> >     the object referenced as another type, in which case we'd get NULL
> >
> >   - we call lookup_tree() successfully, but when we try to read the
> >     object, we find out it's something else.
> >
> > We should check that we behave sensibly in both cases (especially
> > because it is easy for a malicious actor to provoke one case or the
> > other).
>
> I think our pasting together of multiple commits adding the lone/seen
> cases ended up in some redundancy in the description. In particular, I'm
> not sure what the first paragraph/bullet quoted above is trying to say,
> as it corresponds to the second bullet in the later list.

I agree that this is at the very least redundant, and at the most,
confusing. I think that you're right that this is the result of
squashing the commits often enough that some of this cruft stuck around
and got combined in ways that it shouldn't have.

> Maybe collapse them together like:
>
>   We might hit an unexpected type in two different ways (imagine we have
>   a tree entry that claims to be a tree but actually points to a blob):
>
>     - when we call lookup_tree(), we might find that we've already seen
>       the object referenced as a blob, in which case we'd get NULL. We
>       can exercise this with "git rev-list --objects $blob $tree", which
>       guarantees that the blob will have been parsed before we look in
>       the tree. These tests are marked as "seen" in the test script.
>
>     - we call lookup_tree() successfully, but when we try to read the
>       object, we find out it's something else. We construct our tests
>       such that $blob is not otherwise mentioned in $tree. These tests
>       are marked as "lone" in the script.

Indeed, this is much cleaner (and thanks for writing it here, and saving
me the work). I think that I will take this as-is for 2/7 in v2.

> -Peff

Thanks,
Taylor
