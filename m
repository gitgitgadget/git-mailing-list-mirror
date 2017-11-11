Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFFF8201C8
	for <e@80x24.org>; Sat, 11 Nov 2017 12:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753514AbdKKMBp (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 07:01:45 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:55889 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbdKKMBo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 07:01:44 -0500
Received: by mail-io0-f175.google.com with SMTP id p186so16139485ioe.12
        for <git@vger.kernel.org>; Sat, 11 Nov 2017 04:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EiyTAF67k5M2ObcWi7m9RYX3TH2Ir1QlxV2PbJpV+eM=;
        b=eCzSVyPvkfvez/iwY8LoEUKkq5cDFFh78aYk/QxSQ9vWLQ1+H6Ay/sb1iIBHcjiUGi
         k/HluvkTHXLRkWpD4JdL8BFhDeqtfRVfQK7aI1tu9VraS/wihvmsK70JTAkBrB/ZsOjq
         E764baOS5c1DWCVqFIy8KgPz0OfubB+2g8rJqz7wCxlXo/J5EsUC0DuCXp6lJmrggz/8
         wzBXKqaXdnuAQRxZ7m2q7eGtBdTL7j9GiWzUu5VG6fodRBexKBLNRQIF1IhI1YXPIvbI
         3hqgk4HCdUbOilnPIPF3TXQCk62yZzmNEO6bdYdP0kbHsY72xmuW87gDkVHcLBD2TRPB
         9KxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EiyTAF67k5M2ObcWi7m9RYX3TH2Ir1QlxV2PbJpV+eM=;
        b=KjJiHnWb8BcfX6067U9ZsvXeqVgmsktWXsvs5hbt9YrkEnlRti9cW6hFrSjf5ARsaS
         3xJs23HRUoU58L6h0TW1uT0a5fc5HMb59RZywsyFUNNG1FUWIavMOoR9z16mpp2eF0ga
         dTLNXeQM0iBF1n8sx2Us7BtD4IgXXD/1qgbj1wxcz2xMGFnt6FHlmWn2Sqnu2d80zEZ+
         nsvl/hdG/z8jQQdqvtW2LpxyuBE7gUFkZVT/MYngl/aielzf8vxzBR3USYDNHwDiSx/T
         CGgOzHm/1d/FFmK2Qx78NvObV26OijnpfIdAC0g0acutET8e1qcBTqizhgLSxxp4ym0u
         TC5w==
X-Gm-Message-State: AJaThX6NwZUxhk0tgPE3U+PZtJwIOLYBOjwwy7qg8WLYud3Z1V5C7PWM
        Q7T2miBARLHAHxiGgQY33MTqH6M7dhgnIXZWgDI=
X-Google-Smtp-Source: AGs4zMbOvJRtCqe3DH+ddhPCypXWpLPXUTqANtmWtvfvq+fQDgMEaiATBu45ge4SmWh7t7OsdgRDoD9IOmBcS727ghc=
X-Received: by 10.107.47.17 with SMTP id j17mr3563984ioo.96.1510401703979;
 Sat, 11 Nov 2017 04:01:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sat, 11 Nov 2017 04:01:43 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1711110612290.5087@localhost.localdomain>
References: <alpine.LFD.2.21.1711110612290.5087@localhost.localdomain>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 11 Nov 2017 13:01:43 +0100
Message-ID: <CAP8UFD1=idL51XDzE_RKc_7z9NghTd7GHoZ-T61y0rQ8ZYXomw@mail.gmail.com>
Subject: Re: "git bisect" takes exactly one bad commit and one or more good?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 11, 2017 at 12:22 PM, Robert P. J. Day
<rpjday@crashcourse.ca> wrote:
>
>   more on "git bisect" ... the man page seems to make it clear that
> bisection takes *precisely* one "bad" commit, and one *or more* good
> commits, is that correct?

Yeah, that's true.

> seems that way, given the ellipses in the
> commands below:
>
>   git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
>                    [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
>   git bisect (bad|new|<term-new>) [<rev>]
>   git bisect (good|old|<term-old>) [<rev>...]

Yeah indeed.

> however, other parts of the man page seem less clear. just below
> that, a description that bisection takes "a" good commit:
>
> "You use it by first telling it a "bad" commit that is known to
> contain the bug, and a "good" commit that is known to be before the
> bug was introduced."

Yeah, 'and at least a "good" commit' would be better.

> and a bit lower, we read "at least one bad ...", which some people
> might interpret as one or more *bad* commits:
>
> "Once you have specified at least one bad and one good commit, git
> bisect selects a commit in the middle of that range of history, checks
> it out, and outputs something similar to the following:"

Yeah, 'Once you have specified one bad and at least one good commit'
would be better.

>   if the rules are exactly one bad commit and one or more good, i'll
> submit a patch to reword at least the above, and possibly more if
> necessary.

Sure, thanks,
Christian.
