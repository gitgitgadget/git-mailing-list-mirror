Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BEDF202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 22:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbdB1Wtl (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 17:49:41 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36134 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdB1WtX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 17:49:23 -0500
Received: by mail-lf0-f53.google.com with SMTP id y193so11881199lfd.3
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 14:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1vIFfjTOWTBnE7y+q2WeLPIGfuZ/J2uCpGwjPBstuSI=;
        b=Dbby57isVlcPn2Df1IPHpEtrbEQVU/kEecFmN1UjD/ARJFwyB6a5JacnftC8FiCBif
         b+Knj5rKyPZ/cAb0BTGFUIvGMUM55QRGXJ75HEdtCYy4w1HsNhRchCrEBlTdOjKpjEIe
         fiqfVBEUxhYkNGVAP8dqTDnY4rQVPlX7GplDeez85eW4gQYC8zIkvfgS9SWOMPPOEou8
         knUCsufY+fj56EmI0tTSTNmdPd1XpWNGjvJwocEIjgjDKPvVXxGh9P0Ii3CvaFlclbr+
         jrizMQ9VVB9bTi8wwTjB6w+Cx1nY1iN+Rj7sR60WWe8l+bB5cv5PwdhjUwCxASqDoKKh
         AH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1vIFfjTOWTBnE7y+q2WeLPIGfuZ/J2uCpGwjPBstuSI=;
        b=O541UYKDbkMO4uY4k4XtAvNob2ogXJhDgex2yyCaxLF+IYwpSJhv30x6uHBIOFmTY7
         hcYKLZopqWw8DTEf9ugj/dYtMqayT3cHIMbIedJMG4052Q52tkG19Q1okZ/b/UYrcipS
         WToFu7zGTH1zcdhvy0+QecwuVd1pBc2NSreWs9if94ZOshKy7O9zLSM3SH4vYYtZo73d
         rXyYjF9YdCtjzkjJPzqY2BGxuWU2aLFxXkM2L9mheh/Nqz5zZJMWm5lluUQIQzwS5EFU
         3pEIabLva/EdKOZZdhf/PNWU0s2pYcyQ+0yesFOWfa1tqyA9O9F8TFFX2VQLXfbjdHfv
         P4nA==
X-Gm-Message-State: AMke39k6kTaGZzD4I/W6clfKPTdTJJypbhG1AkCv6Wk5O67zzIqko6rvUlV3JhmmhbQyvqG8NEj6KAw/rDpKgw==
X-Received: by 10.25.24.193 with SMTP id 62mr1630821lfy.12.1488322110422; Tue,
 28 Feb 2017 14:48:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Tue, 28 Feb 2017 14:48:09 -0800 (PST)
In-Reply-To: <20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net>
References: <20170227045257.yazqlrqlnggosi5t@macbook.local>
 <CAOLa=ZSyQg9uoZWADOMYc90U-5AR9Lfii9mjLre0m0FQCSqfxg@mail.gmail.com>
 <20170227074915.xljfe5jox756rlyv@sigill.intra.peff.net> <20170227080158.de2xarctzscfdsp2@sigill.intra.peff.net>
 <20170227090233.uk7dfruggytgmuw2@sigill.intra.peff.net> <xmqq60jvnu9y.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xpVt6NtSajqMX8OQ_SKdC9tfHH40JgK=9DgBxo9nMaWLA@mail.gmail.com>
 <xmqqzih7kvbz.fsf@gitster.mtv.corp.google.com> <20170228005302.k6fyfinaxyl3ti76@sigill.intra.peff.net>
 <20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 28 Feb 2017 14:48:09 -0800
Message-ID: <CA+P7+xpfRjr4BKkLLcbCS-yXXYoiHeWr9Y9ubHA-Xxqa9c7q8w@mail.gmail.com>
Subject: Re: [BUG] branch renamed to 'HEAD'
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 4:06 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 27, 2017 at 07:53:02PM -0500, Jeff King wrote:
>
>> On Mon, Feb 27, 2017 at 04:33:36PM -0800, Junio C Hamano wrote:
>>
>> > A flag to affect the behaviour (as opposed to &flag as a secondary
>> > return value, like Peff's patch does) can be made to work.  Perhaps
>> > a flag that says "keep the input as is if the result is not a local
>> > branch name" would pass an input "@" intact and that may be
>> > sufficient to allow "git branch -m @" to rename the current branch
>> > to "@" (I do not think it is a sensible rename, though ;-).  But
>> > probably some callers need to keep the original input and compare
>> > with the result to see if we expanded anything if we go that route.
>> > At that point, I am not sure if there are much differences in the
>> > ease of use between the two approaches.
>>
>> I just went into more detail in my reply to Jacob, but I do think this
>> is a workable approach (and fortunately we seem to have banned bare "@"
>> as a name, along with anything containing "@{}", so I think we would end
>> up rejecting these nonsense names).
>>
>> I'll see if I can work up a patch. We'll still need to pass the flag
>> around through the various functions, but at least it will be a flag and
>> not a confusing negated out-parameter.
>
> OK, I have a series which fixes this (diffstat below). When I audited
> the other callers of interpret_branch_name() and strbuf_branchname(), it
> turned out to be even more complicated. The callers basically fall into
> a few buckets:
>
>   1. Callers like get_sha1() and merge_name() pass the result to
>      dwim_ref(), and are prepared to handle anything.
>
>   2. Some callers stick "refs/heads/" in front of the result, and
>      obviously only want local names. Most of git-branch and
>      git-checkout fall into this boat.
>
>   3. "git branch -d" can delete local _or_ remote branches, depending on
>      the "-r" flag. So the expansion it wants varies, and we need to
>      handle "just local" or "just remote".
>
> So I converted the "only_branch" flag to an "allowed" bit-field. No
> callers actually ask for more than a single type at once, but it was
> easy to do it that way. It serves all of the callers, and will easily
> adapt for the future (e.g., if "git branch -a -d" were ever allowed).
>
>   [1/8]: interpret_branch_name: move docstring to header file
>   [2/8]: strbuf_branchname: drop return value
>   [3/8]: strbuf_branchname: add docstring
>   [4/8]: interpret_branch_name: allow callers to restrict expansions
>   [5/8]: t3204: test git-branch @-expansion corner cases
>   [6/8]: branch: restrict @-expansions when deleting
>   [7/8]: strbuf_check_ref_format(): expand only local branches
>   [8/8]: checkout: restrict @-expansions when finding branch
>
>  builtin/branch.c                      |   5 +-
>  builtin/checkout.c                    |   2 +-
>  builtin/merge.c                       |   2 +-
>  cache.h                               |  32 ++++++++-
>  refs.c                                |   2 +-
>  revision.c                            |   2 +-
>  sha1_name.c                           |  76 ++++++++++-----------
>  strbuf.h                              |  21 +++++-
>  t/t3204-branch-name-interpretation.sh | 122 ++++++++++++++++++++++++++++++++++
>  9 files changed, 220 insertions(+), 44 deletions(-)
>  create mode 100755 t/t3204-branch-name-interpretation.sh
>
> -Peff

I didn't find any problems besides what you had already outlined
before I started reading the series. It looks pretty much like I
thought it would. I like the idea of saying "I want X" rather than the
command returning "This was a Y"
