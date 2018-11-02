Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FFA51F453
	for <e@80x24.org>; Fri,  2 Nov 2018 14:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeKCAF4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 20:05:56 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38443 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeKCAF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 20:05:56 -0400
Received: by mail-vs1-f66.google.com with SMTP id x64so1227509vsa.5
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIDJlNurNf+XF1Y1y5VU9Q+1NDGGbX5xLUWltGcQmxE=;
        b=W2b2ynXzH71Jde2C5eyae6LeQJBLVtRUtNGMP9utfcMEmekAUcifgLgZXJvP3obYwx
         Phh1SSojbRD4F7o4G4Va9S204pAKBxjgd5LsBDU0BTvp/3WK2AITmd2GxfXtTA9vaB/x
         6A9vQDQA2bjGTRZPaM4AXPMqjJ9AWQA0H6dGM26tcfa+MnkdykDYtA6VkcmwOhH+JKi9
         lxjejATmhj5WD4gbbjFecMPTq0SOneMhUuj7ze57pnvtypdbbreZkFoUSGo3tynsLD9a
         +4TZpHamapS+mAVaAztOdGrJDxgNYpT9PI7T9xrpno1qhA3QdLcjvzoXoKF5sVi6ed6+
         EBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIDJlNurNf+XF1Y1y5VU9Q+1NDGGbX5xLUWltGcQmxE=;
        b=BGSLl/VZeiuLKRNm9l4FAkSa7nWS1gSfNc8Q/QLS0ZJ+y0E9Bs99PiDnzihbyc17lA
         WRuKfyw282zIJTtiTQC62Rx0YfRTeXmI4iNEnYv62Ra+dSND7iTObMJSH7g99HBBc+F2
         Hi9jJY5y4q/zApdYSn3+j9zSf0R21BV2ep2SfxqaP/fiI/OUham46hkXkMuPq2flS2Vy
         sMoOtPQe7B8EC0xnnVFkB058b8HtTUR9rN6cqT525G8XaivXJq4iBShaZsdqfWMFX9e0
         i1SXKgXF5RYnDARMIeINz+TYhZLLUV5SxClqca312RcXM57stoWIpn8/iBgK676YcrqT
         dkTw==
X-Gm-Message-State: AGRZ1gIkDhEI5hS5YBWdKjwizvKe474Rb1l4/Dp6olaLBpnBLrncgmfT
        MxsqoEf316fQGhANUWaDI/k7NCOOUIv6jHBqTT0=
X-Google-Smtp-Source: AJdET5dkjOK304ckBffb8eE2iswGUkJnkHdwuRVgOuizUUoPQJtAGnKfjfScvLaRJ8wChYu7Uuys85IHjig1NzURROw=
X-Received: by 2002:a67:7648:: with SMTP id r69mr5299488vsc.175.1541170713262;
 Fri, 02 Nov 2018 07:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BFzwphzaMjCWrNxU2V+YeYvRiBOzSV--b13wa7r16dvMQ@mail.gmail.com>
 <20181031120505.237235-1-dstolee@microsoft.com> <CABPp-BHHG9K0869=4CYkqjN6rwLCzRBiF_Z94KFevSo3_FvYAw@mail.gmail.com>
 <ad4ab388-6244-1811-ec1b-6f8143df620e@gmail.com> <CABPp-BG6+3F+FY0JP2mj0OCLjp17xQXTe54mBCN+RifQd4Aj2A@mail.gmail.com>
 <3aadf261-9ed7-6ded-4482-ab01d74802aa@gmail.com>
In-Reply-To: <3aadf261-9ed7-6ded-4482-ab01d74802aa@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Nov 2018 07:58:21 -0700
Message-ID: <CABPp-BEa3U6m8jWrHJXjFo77T32LqEKkdDs7H89m0y_gjHgOWw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Make add_missing_tags() linear
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 1, 2018 at 12:02 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/1/2018 2:57 PM, Elijah Newren wrote:
> > On Thu, Nov 1, 2018 at 5:32 AM Derrick Stolee <stolee@gmail.com> wrote:
> >> No rush. I'd just like to understand how removing the commit-graph file
> >> can make the new algorithm faster. Putting a similar count in the old
> >> algorithm would involve giving a count for every call to
> >> in_merge_bases_many(), which would be very noisy.
> > $ time git push --dry-run --follow-tags /home/newren/repo-mirror
> > count: 92912
> > To /home/newren/repo-mirror
> >   * [new branch]              test5 -> test5
> >
> > real    0m3.024s
> > user    0m2.752s
> > sys    0m0.320s
>
> Is the above test with or without the commit-graph file? Can you run it
> in the other mode, too? I'd like to see if the "count" value changes
> when the only difference is the presence of a commit-graph file.

I apologize for providing misleading information earlier; this was an
apples to oranges comparison.  Here's what I did:

<build a version of git with your fixes>
git clone coworker.bundle coworker-repo
cd coworker-repo
time git push --dry-run --follow-tags /home/newren/repo-mirror
git config core.commitgraph true
git config gc.writecommitgraph true
git gc
time git push --dry-run --follow-tags /home/newren/nucleus-mirror


I figured I had just done a fresh clone, so surely the gc wouldn't do
anything other than write the .git/objects/info/commit-graph file.
However, the original bundle contained many references outside of
refs/heads/ and refs/tags/:

$ git bundle list-heads ../coworker.bundle | grep -v -e refs/heads/ -e
refs/tags/ -e HEAD | wc -l
2396

These other refs apparently referred to objects not otherwise
referenced in refs/heads/ and refs/tags/, and caused the gc to explode
lots of loose objects:
$ git count-objects -v
count: 147604
size: 856416
in-pack: 1180692
packs: 1
size-pack: 796143
prune-packable: 0
garbage: 0
size-garbage: 0


The slowdown with commit-graph was entirely due to there being lots of
loose objects (147K of them).  If I add a git-prune before doing the
timing with commit-graph, then the timing with commit-graph is faster
than the run without a commit-graph.

Sorry for the wild goose chase.

And thanks for the fixes; get_reachable_subset() makes things much
faster even without a commit-graph, and the commit-graph just improves
it more.  :-)
