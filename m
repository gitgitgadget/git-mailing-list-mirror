Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D99381F453
	for <e@80x24.org>; Thu,  1 Nov 2018 18:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbeKBEB4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 00:01:56 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37058 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeKBEB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 00:01:56 -0400
Received: by mail-vk1-f195.google.com with SMTP id 197so3473724vkf.4
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 11:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MFwXC4aOD+9+K4QgHUN6WlziHRhNW3ZAYOYoz5UjhA=;
        b=k/QW3Z85R0Z2ko0/W9iPKU3N9Axka02/V2E9SLXmtr2ecS7ICcBCE81eZ7Uk8TLVoT
         MG6kdVUlAZB+MljfKCgn63f3HHfBKPbgo1bc+a1oK+w3EkGj0PZR2XIJ9+QzS8fskl2z
         8qVxFUCmiTMsk8sz2DWZlYpAcUc2AyolbPdPFhm8rXcUU/UDqpGlzmFNe5bfrcjw1avX
         yM++cVRjLqRK0r/srxUcCExcfNFjp/tHmTxX8gFdepoEkF2TX7AabC5186eHMvKKu0Rl
         kZPaNWOdj4FxTbcPYfTFswR4uPj0Z3CCUgGSbLGh8h5RKTi61OlHFYIdFTX8xK7ASAaP
         osGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MFwXC4aOD+9+K4QgHUN6WlziHRhNW3ZAYOYoz5UjhA=;
        b=elJpX3d5XP1Dn2/7dRTbD5PaFvNSjEPvXAf3IrY0yqQc0Lo/qrLCYh/8HMN4G6nzYw
         NAiYL8al0YeWj2Ss1Dtw56OIBjtfsnmXLcHwqb4Ks6Y7yEo9C8lLzNxR7qREid0RbuFl
         omRhBcPzhW2PMjJob7aBSZre+Pzlg73yfF34DgahcUlNWDGOXxh7JCxalGXP3vG3baS5
         hKjV36RxzA/hXGd8v6zEBljY6SJ3KLNORMMEYh6tEQlS5uWwLFlpu7zLSthporhUggl5
         7JzKX7E5VbC5AGtMQujembQsMGAkppx/Ha6m+YnZRf5B8eYXeAftRyL1+GLXv+lhn+xY
         5k5w==
X-Gm-Message-State: AGRZ1gLtJiUFrCl4UySnBB+uV/WYu4tvAHofDD+f7kZ4E1Q6yiYqtUy0
        5F4ACWT8mh++yed6nlh74FGd+wvkRWo+K5Reb+8=
X-Google-Smtp-Source: AJdET5dXBtQxtDsK/u6Ee/phC4PoqZ0TNc680uNjOaYvB7bJc8iEZt1Fenb1l9BNK782/Du/ccxkgfn6fYjHmi5VCxQ=
X-Received: by 2002:a1f:a352:: with SMTP id m79mr3700677vke.27.1541098662551;
 Thu, 01 Nov 2018 11:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BFzwphzaMjCWrNxU2V+YeYvRiBOzSV--b13wa7r16dvMQ@mail.gmail.com>
 <20181031120505.237235-1-dstolee@microsoft.com> <CABPp-BHHG9K0869=4CYkqjN6rwLCzRBiF_Z94KFevSo3_FvYAw@mail.gmail.com>
 <ad4ab388-6244-1811-ec1b-6f8143df620e@gmail.com>
In-Reply-To: <ad4ab388-6244-1811-ec1b-6f8143df620e@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 1 Nov 2018 11:57:29 -0700
Message-ID: <CABPp-BG6+3F+FY0JP2mj0OCLjp17xQXTe54mBCN+RifQd4Aj2A@mail.gmail.com>
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

On Thu, Nov 1, 2018 at 5:32 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 11/1/2018 2:52 AM, Elijah Newren wrote:
> > On Wed, Oct 31, 2018 at 5:05 AM Derrick Stolee <stolee@gmail.com> wrote:
> >> On 10/31/2018 2:04 AM, Elijah Newren wrote:
> >>>
> >>> On the original repo where the topic was brought up, with commit-graph
> >>> NOT turned on and using origin/master, I see:
> >>>
> >>> $ time git push --dry-run --follow-tags /home/newren/repo-mirror
> >>> To /home/newren/repo-mirror
> >>>   * [new branch]       test5 -> test5
> >>>
> >>> real 1m20.081s
> >>> user 1m19.688s
> >>> sys 0m0.292s
> >>>
> >>> Merging this series in, I now get:
> >>>
> >>> $ time git push --dry-run --follow-tags /home/newren/repo-mirror
> >>> To /home/newren/repo-mirror
> >>>   * [new branch]       test5 -> test5
> >>>
> >>> real 0m2.857s
> >>> user 0m2.580s
> >>> sys 0m0.328s
> >>>
> >>> which provides a very nice speedup.
> >>>
> >>> Oddly enough, if I _also_ do the following:
> >>> $ git config core.commitgraph true
> >>> $ git config gc.writecommitgraph true
> >>> $ git gc
> >>>
> >>> then my timing actually slows down just slightly:
> >>> $ time git push --follow-tags --dry-run /home/newren/repo-mirror
> >>> To /home/newren/repo-mirror
> >>>   * [new branch]          test5 -> test5
> >>>
> >>> real 0m3.027s
> >>> user 0m2.696s
> >>> sys 0m0.400s
> >> So you say that the commit-graph is off in the 2.8s case, but not here
> >> in the 3.1s case? I would expect _at minimum_ that the cost of parsing
> >> commits would have a speedup in the commit-graph case.  There may be
> >> something else going on here, since you are timing a `push` event that
> >> is doing more than the current walk.
> >>
> >>> (run-to-run variation seems pretty consistent, < .1s variation, so
> >>> this difference is just enough to notice.)  I wouldn't be that
> >>> surprised if that means there's some really old tags with very small
> >>> generation numbers, meaning it's not gaining anything in this special
> >>> case from the commit-graph, but it does pay the cost of loading the
> >>> commit-graph.
> >> While you have this test environment, do you mind applying the diff
> >> below and re-running the tests? It will output a count for how many
> >> commits are walked by the algorithm. This should help us determine if
> >> this is another case where generation numbers are worse than commit-date,
> >> or if there is something else going on. Thanks!
> > I can do that, but wouldn't you want a similar patch for the old
> > get_merge_bases_many() in order to compare?  Does an absolute number
> > help by itself?
> > It's going to have to be tomorrow, though; not enough time tonight.
>
> No rush. I'd just like to understand how removing the commit-graph file
> can make the new algorithm faster. Putting a similar count in the old
> algorithm would involve giving a count for every call to
> in_merge_bases_many(), which would be very noisy.

$ time git push --dry-run --follow-tags /home/newren/repo-mirror
count: 92912
To /home/newren/repo-mirror
 * [new branch]              test5 -> test5

real    0m3.024s
user    0m2.752s
sys    0m0.320s


Also:
$ git rev-list --count HEAD
55764
$ git rev-list --count --all
91820

Seems a little odd to me that count is greater than `git rev-list
--count --all`.  However, the fact that they are close in magnitude
isn't surprising since I went digging for the commit with smallest
generation number not found in the upstream repo, and found:
$ git ls-remote /home/newren/repo-mirror/ | grep refs/tags/v0.2.0; echo $?
1
$ git rev-list --count refs/tags/v0.2.0
4
$ git rev-list --count refs/tags/v0.2.0 ^HEAD
4


So, the commit-graph can only help us avoid parsing 3 or so commits,
but we have to parse the 5M .git/objects/info/commit-graph file, and
then for every parse_commit() call we need to bsearch_graph() for the
commit.    My theory is that parsing the commit-graph file and binary
searching it for commits is relatively fast, but that the time is just
big enough to measure and notice, while avoiding parsing 3 more
commits is a negligible time savings.

To me, I'm thinking this is one of those bizarre corner cases where
the commit-graph is almost imperceptibly slower than without the
commit-graph.  (And it is a very weird repo; someone repeatedly
filter-branched lots of small independent repos into a monorepo, but
didn't always push everything and didn't clean out all old stuff.)
But if you still see weird stuff you want to dig into further (maybe
the 92912 > 91820 bit?), I'm happy to try out other stuff.
