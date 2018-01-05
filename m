Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78B4F1F404
	for <e@80x24.org>; Fri,  5 Jan 2018 04:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeAEEIj (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 23:08:39 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:38467 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeAEEIi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 23:08:38 -0500
Received: by mail-io0-f175.google.com with SMTP id 87so4461464ior.5
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 20:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nYPINcMh/aI2NWxsNVyKnnqsHtlNQNYuPBSAuGFekBI=;
        b=YHhht8N3kQ13wlpeogWCHk6g8OgYCyt+n3CexbjIQJ7HMCsLN8TR/ys34ybwUvqJOj
         /xgj2IYU+TB4WmoDo69XSIOY0MN2uq6GP2t+ESa4u6FtbzQ9IZ3zBz7A+rpnk9RYXG72
         GK69qAvX2NF6Ck9kC2MRAVhUxg9WAq9dnKvsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nYPINcMh/aI2NWxsNVyKnnqsHtlNQNYuPBSAuGFekBI=;
        b=kF6KiX9VNw05f5cLdA3ajlrrY3sii4e09oq/zatg6JXKXXn4bU07trA9A2ARY7ewnr
         VBj2Q53I8Ij4+5PvJgx/eeQu+jd6WNf3i7GUfbkyruevQjnF1CByG/attlmtx6mDtyOi
         lsI/+LvU82UKrGsdcvnT4jdewItC0NxVttXS7poCrQu9X3j0Cy/+Uyna0B1sXYRBqAXu
         /Etv67Us4l/FgDynAveOvj4kBxCUxVc3xMLHaDlcICTJGKDMgb/kWjv6HfzP6NdYXWlq
         srOdNFQgiBLrl0lRp76eQ0x2vvgwvrOBpxuPM0mVFneyrU/QD/eNTP/C6YdV4/rBcDbm
         U/jQ==
X-Gm-Message-State: AKwxytdlwcrEfhY0IM8uJttePj5vZ2zjVCSc9uxbJx0IML0nIoxZXF0k
        7IGr/jldmmMFu5KbYFW97kJbEQ==
X-Google-Smtp-Source: ACJfBou87z4Xm/xia1p/2oCinxx7IRIrTeQgxjS3br4tZn6oPNasHlbnU2v+NVjQzlpjuNSl7DNc7Q==
X-Received: by 10.107.46.223 with SMTP id u92mr1928949iou.269.1515125317285;
        Thu, 04 Jan 2018 20:08:37 -0800 (PST)
Received: from Carl-MBP.local ([2601:282:8001:ffba:f0d7:a5cd:e618:32a7])
        by smtp.gmail.com with ESMTPSA id z130sm3285854ioz.16.2018.01.04.20.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2018 20:08:36 -0800 (PST)
Date:   Thu, 4 Jan 2018 21:08:38 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20180105040837.GA12861@Carl-MBP.local>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171225035215.GC1257@thunk.org>
 <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
 <3447055.jsE6nH3DQt@mfick-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3447055.jsE6nH3DQt@mfick-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 04, 2018 at 12:54:00PM -0700, Martin Fick wrote:
> On Monday, December 25, 2017 06:16:40 PM Carl Baldwin wrote:
> > On Sun, Dec 24, 2017 at 10:52:15PM -0500, Theodore Ts'o 
> wrote:
> > Look at what happens in a rebase type workflow in any of
> > the following scenarios. All of these came up regularly
> > in my time with Gerrit.
> > 
> >     1. Make a quick edit through the web UI then later
> > work on the change again in your local clone. It is easy
> > to forget to pull down the change made through the UI
> > before starting to work on it again. If that happens, the
> > change made through the UI will almost certainly be
> > clobbered.
> > 
> >     2. You or someone else creates a second change that is
> > dependent on yours and works on it while yours is still
> > evolving. If the second change gets rebased with an older
> > copy of the base change and then posted back up for
> > review, newer work in the base change has just been
> > clobbered.
> > 
> >     3. As a reviewer, you decide the best way to explain
> > how you'd like to see something done differently is to
> > make the quick change yourself and push it up. If the
> > author fails to fetch what you pushed before continuing
> > onto something else, it gets clobbered.
> > 
> >     4. You want to collaborate on a single change with
> > someone else in any way and for whatever reason. As soon
> > as that change starts hitting multiple work spaces, there
> > are synchronization issues that currently take careful
> > manual intervention.
> 
> These scenarios seem to come up most for me at Gerrit hack-
> a-thons where we collaborate a lot in short time spans on 
> changes.  We (the Gerrit maintainers) too have wanted and 
> sometimes discussed ways to track the relation of "amended" 
> commits (which is generally what Gerrit patchsets are).  We 
> also concluded that some sort of parent commit pointer was 
> needed, although parent is somewhat the wrong term since 
> that already means something in git.  Rather, maybe some 
> "predecessor" type of term would be better, maybe 
> "antecedent", but "amended-commit" pointer might be best?

I like "replaces" as I have proposed or "supersedes". "predecessor" also
seems pretty good. I may add that to my list of favorites.

Carl
