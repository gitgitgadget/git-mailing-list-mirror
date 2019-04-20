Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URI_HEX shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5249E20248
	for <e@80x24.org>; Sat, 20 Apr 2019 06:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfDTGwj (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Apr 2019 02:52:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36409 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfDTGwi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Apr 2019 02:52:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so6237746ljg.3
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 23:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYiyiFzY51et4pfb9nxjvlQ78ISx0tm3IaaDEALzwko=;
        b=rgT9ZCuH45UA7vLemiolIfMmrqSw8t+jLSyhFusDaMEYFd+5l4zUoTNgiw2/bVWLhk
         8POJ1d19eQPYMsykVvzSxOODCyzcC0lirEhNT8a9wvfZRA0YdtkUqWL7fv2TCjY2FMdD
         BzzugyrRZThNV2Tzc7T4WvnXHTGzbguYG4AzG/3vZ8AX6INdeEe6dyMv+JN5nkBXpkDJ
         7niIMGkHrWQr2WtqqWfvROATQQKWPosGe3ttkxO1KkhoBx+rlCUHiMdymbG0Xay3AO76
         tIin8S3FnZLw1COyE2tJoa+gC8DGWgnIJYWJ7kRza6L7hM6csx4GvmXu2xc6AZBJbucZ
         CjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYiyiFzY51et4pfb9nxjvlQ78ISx0tm3IaaDEALzwko=;
        b=TNStQ7Nd3y3ZzCvt3GTTWcRPOZt2RAsw+lpQka9VJBHOhGBLzZ+/XnWUWLT14bLfPQ
         1p38Ut21rQ0iEwkiOBPLqbjTKHFNxt7sT7PW3N+Aek/xWQAJoXjFPJH15S+D+Krg8SZu
         8a5YcXmIlFI7YZnc83RIugIR7t2O1sJXrSXp53lN6CEpD05IaARbONr1PXhrLEF6576V
         v2g53ewRVx/rNqARonuHQW9TC+ArldkhX39GcdDXDvq5i0XXoH11Wioyt8sVUFwFY2KK
         pOwkjSb/E73mWdFcxaxOhBDlckWR6K2uP1zyoitXQJMgwKSqku7sQqU5CP7nO8D0DfAL
         RMaQ==
X-Gm-Message-State: APjAAAWz32H/UmWG2k02gCvlE6vldBzmMARArDqDSLcZ95P6pvuEKS24
        ocRIPp7V2Tx+xSnvtW1JDvJXbt7xwdXiprAz3AAqVg==
X-Google-Smtp-Source: APXvYqzwVQW7/eGgUPYWUoyN6+EkE5SA0FTjqvxU/y/MbCIub2NbndO1gF/QPu6amky4i+ukAH6NKf/SNpVsKjcDgP4=
X-Received: by 2002:a2e:8618:: with SMTP id a24mr4290633lji.192.1555743156579;
 Fri, 19 Apr 2019 23:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <CABURp0p6RmwjW4BN4qPv5iBKC_kzZFGyKJxuWw=+pEpjZGtV_A@mail.gmail.com>
 <20190419194649.GB28277@sigill.intra.peff.net>
In-Reply-To: <20190419194649.GB28277@sigill.intra.peff.net>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Fri, 19 Apr 2019 23:52:25 -0700
Message-ID: <CABURp0rnca4+nxipNGSU-h9miAmAvhzxO9U-T-sgPCyHeu+Xjw@mail.gmail.com>
Subject: Re: Exposing the states of sequencer, etc.
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah, yes.  Thanks for the reminder, Peff.  Found my original patch:

http://git.661346.n2.nabble.com/PATCHv2-git-status-show-short-sequencer-state-tc7569767.html#a7570756

I seem to recall that my next iteration of it ran into many conflicts
in wt_status.c, and that file seemed like it might be heading in this
API direction anyway, so I put it on a shelf.  I guess I'm just
surprised the state checking is still so manual.  I'll explore more.

On Fri, Apr 19, 2019 at 12:46 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Apr 19, 2019 at 10:57:33AM -0700, Phil Hord wrote:
>
> > "Junio C Hamano via vger.kernel.org" writes:
> >
> > > > When cherry-picking or reverting a sequence of commits and if the final
> > > > pick/revert has conflicts and the user uses `git commit` to commit the
> > > > conflict resolution and does not run `git cherry-pick --continue` then
> > > > the sequencer state is left behind. This can cause problems later.
> > > > ...
> > > I've certainly seen this myself.  Do you use command line prompt
> > > support to remind you of the operation in progress?  I do, and I
> > > have a suspicion that it did not help me in this situation by
> > > ceasing to tell me that I have leftover state files after a manual
> > > commit of the final step that conflicted and gave control back to
> > > me.
> >
> > Is there some place today that we explain the many rules Git uses to
> > determine the operations in progress?  I once had a patch to do this
> > in code, but I think I let it die in committee.  It was something
> > like:
> >
> >      $ git status --show-progress-state
> >      cherry-pick, conflicts, untracked
> >
> > It would be helpful first to have an API for this, of course, though I
> > think that's where I got mired before.
> >
> > I'm willing to take it on again, if there's not already some alternative.
>
> Grep for get_state and print_state in wt-status.c. I think we only do so
> for the "long" status output, but it should be possible to define a
> machine-readable version for the porcelain output.
>
> -Peff
