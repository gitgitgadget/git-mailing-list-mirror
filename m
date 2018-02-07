Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A64D1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 17:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754813AbeBGRZo (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 12:25:44 -0500
Received: from mail-ua0-f177.google.com ([209.85.217.177]:44564 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754582AbeBGRZn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 12:25:43 -0500
Received: by mail-ua0-f177.google.com with SMTP id x4so1048200uaj.11
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 09:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=egSnN4izahiI++aJyzp+hNk35yA+tc2d2aNRCBrN7YI=;
        b=FpcRSstf4W3XlDerIZZoYZNQKMsdEW0XzPk7nCrRJ5lwocv/ftrfrT3gGyNlRl2eAp
         +3GDmy9PbjW4rOKaVRtyT93RGGGvRJIYZg5t2XIykUDlP7YGfG//nMUv4TjOQlu2//Py
         CoKlYJRjUs3cRkq4Hrhtu17TXiVCw6MFq3NJ6JWei4KO2ZsIH1ZeyG2xx3+gc82rW3/r
         v0EpUjcrFBjJimCqZuUbWBX1K9IfDo3OIBM2I4p4wbtYus85fB7PWKpOpEfs0oIrSVe0
         S+mhIaYvTMtHRB0wD+BqMcvJIDM1s3zKpXftOnM5YUP8BtdEGYa1LQDHiBqDQOX1txh6
         UVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=egSnN4izahiI++aJyzp+hNk35yA+tc2d2aNRCBrN7YI=;
        b=EAdUmR0m5393w01McJGKNlFuo14f+21+VtKx8QGN4MpLSnecrZWKQ72Kvy0I6b6x3N
         Wsl1KhBp5iKgclUgH5o8ngsHCuom+2DbObYe3f+okTWDzQJlR1AcnvE/JYuIll/iilwR
         nVvAQQh1ztoAyFm8mPm1HtV1qPBdSt2vn5/D1+MhRCpdesnAgxPx2oWE2ncTG1XqgHuL
         mmsJCxnZRunObZ6kC4Pzgvve+fKQsZptAjflN+2tRH60al56Oc/ytVijDXD7kwD8kOmL
         sH2D5w2nkBk0LQ+nJPoILAJjl+bDYVoGzPYcMVZ4nT3OMmDAzJJ2fxN9w9xa1LBgC66/
         viuA==
X-Gm-Message-State: APf1xPAOvwSe4z6E70+9G7gyzVmlQjPXHWl9kW3ohAPg7iYIehbh+3Tx
        bJTQON+aL7OJkINEx5F47UFcwzdR98ikjX3XNYo=
X-Google-Smtp-Source: AH8x225bHOH6uflbCgvtqPV45UbaK/rlbWJEcbVTzGLPbsDhANKMksn+ir6d/SHO+mab4Fxx1Y/M1OlKuB6MNePVqm8=
X-Received: by 10.159.48.141 with SMTP id j13mr6066815uab.147.1518024342563;
 Wed, 07 Feb 2018 09:25:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.33 with HTTP; Wed, 7 Feb 2018 09:25:42 -0800 (PST)
In-Reply-To: <20180207132157.GB16018@sigill.intra.peff.net>
References: <CABPp-BHVD19ZoAmWhQd9aN-v+qB7Ryq9Z-wobLYtJf_b6RWgzQ@mail.gmail.com>
 <CAGZ79kYstN9ATPGKZjnk-hJ6jRsx9Oz0b2hQ5cTiqVqMNDCsyA@mail.gmail.com>
 <CABPp-BHkLLrJDTQwHTYpqC0Cg7Wv_wDr14Fq_LXneg+OzzRngg@mail.gmail.com> <20180207132157.GB16018@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 7 Feb 2018 09:25:42 -0800
Message-ID: <CABPp-BH0rSELVJV11MJM=KFU2jAEuhVTzUUBskghgku+y_ozDQ@mail.gmail.com>
Subject: Re: BUG: fetch in certain repo always gives "did not send all
 necessary objects"
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 5:21 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 06, 2018 at 04:00:32PM -0800, Elijah Newren wrote:
>
>> It took me hours to figure it out, after users ran out of ideas and
>> came and asked me for help.  (Maybe if I was familiar with worktree,
>> and knew they had been using it, then I might have guessed that "HEAD"
>> meant "not your actual HEAD but the HEAD of the vestige of some other
>> worktree").
>
> Yeah, this is the obvious thing that seems like it ought to be improved.
<snip>
> Unfortunately fixing that is a little tricky. In this case the stack
> looks like:
>
>   parse_object_or_die (oid=0x7fffffffd690, name=0x555555792880 "HEAD") at object.c:239
>   add_one_ref (path=0x555555792880 "HEAD", oid=0x7fffffffd690, flag=0, cb_data=0x7fffffffd8e0) at reachable.c:38
>   refs_head_ref (refs=0x555555a65430, fn=0x5555556b6ef5 <add_one_ref>, cb_data=0x7fffffffd8e0) at refs.c:1316
>   other_head_refs (fn=0x5555556b6ef5 <add_one_ref>, cb_data=0x7fffffffd8e0) at worktree.c:404
>
> So other_head_refs knows that it's looking at the worktrees. And it
> passes the alternate ref-store to refs_head_ref(), with "add_one_ref" as
> the callback. But the knowledge that we're not talking about the real
> "HEAD" is lost as we cross that callback boundary. We'd need to either
> add another parameter to the callback, or have some way of talking about
> "HEAD in this worktree" as a refname (which AFAIK we don't have).

Can we use "worktrees/${WORKTREE}/HEAD"?  It already satisfies all the
necessary rev-parse rules...

(And on a slight tangent...do we want to start disallowing the
creation of branches/tags whose name starts with "worktrees/",
"refs/", "hooks/", or other paths that exists under gitdir?  Making a
branch named "refs/heads/foo" so that it fully-qualifies as
"refs/heads/refs/heads/foo" is always fun)
