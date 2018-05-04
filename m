Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0B5200B9
	for <e@80x24.org>; Fri,  4 May 2018 14:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeEDOnD (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 10:43:03 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:46650 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeEDOnC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 10:43:02 -0400
Received: by mail-ua0-f172.google.com with SMTP id e8so11950924uam.13
        for <git@vger.kernel.org>; Fri, 04 May 2018 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0sr72WTwR0hnZVC/wkR24enPp+RXUQdPvtpGCjejjuk=;
        b=BenT4wfbuSYw5knsMvQ/N+iuzlWIeqp1c2OgNTbklYK5oEVRT0Jl0RE78yAMqC8gVn
         8ruvEfd0rzGzA39ob7rm8KUAhfzCqROMrIJAOzVricG4r4t1v4XIL6098V415wy7KVLJ
         6JoWTOeTdYkZrwtEt0krMwlLAVlEH5Mq9nZnO4E49FhrMeDxuo4Mzin7x0zcaOIXicWJ
         jF4ktRFQtVxPl/47TqANxwNtgly8EM2oSwWrxPY3kmewznb7PvuNb+NBtKKbdT7EgjdF
         XBUN8CqYSBazm8/ANtU7fGYUxtMfnbv1do9pxk/0CaycJ6iu6Eg+Jsj+f4jqViVitV8m
         m/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0sr72WTwR0hnZVC/wkR24enPp+RXUQdPvtpGCjejjuk=;
        b=jSE2fdftxjvYRJgzy3nD7QKmE3u5whavRp9Q8oGDqQ6IKK8xqsJ9vBLk68J6FOIW7N
         lFINTqbzD4Lw7DqA8IRPqwMwYKGw6aCa57YZhsswFBT3JBAHf08vcMMf5O2/sSbqz4yx
         RI+vxUgTwMekzDem1y1657sUZ5ajw/2fJkbg3vMGOVC4Gd02Q7oyP2yLbXhijsX1xVfB
         OpmGhAKavY82LDOrNy2IahYNneYdZNLywgiPDaMPn+xmOa7Bkd1Bm2FzzoiiE//AiQgz
         ICewEEKnD/9MVJlL1F+EybjFcqE/tvtirVMuRv0uW+3kNBrjbwSoTP2efy1UxcriZihV
         3Bnw==
X-Gm-Message-State: ALQs6tBnvFUgNoLQ1hCwF5BGPqVdVyqp85vO/TisEpTuPQMhp0defLx4
        ef9Or1O2uzB83JzbF0kTvg7z/qmc5XqHXZNpdOE=
X-Google-Smtp-Source: AB8JxZrRuKaoZWxYrDwCnH64H3BfCERc04ZTs1pSngPhTeOGcKvsdyTYYcYX/LKUFvOU9Ta8VGnaNjV/6umjqWhXLFY=
X-Received: by 10.176.90.48 with SMTP id l45mr24874715uad.79.1525444981515;
 Fri, 04 May 2018 07:43:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 4 May 2018 07:43:00 -0700 (PDT)
In-Reply-To: <20180504101854.GA29828@book.hvoigt.net>
References: <1524739599.20251.17.camel@klsmartin.com> <CAGZ79kZA_R-5bA6mPdoHkVW-C21pNn_0x6FayhuuXqnOTrmjWw@mail.gmail.com>
 <CA+P7+xrUwq0G2YySC3SLKqyihhPnFPCiQnQpoVVa89+=W9O9+w@mail.gmail.com>
 <CAGZ79kaub2k-q-Mcj3H5o6ekyZ8ZZzG7+r5sHt5Ne25Nc3_nPQ@mail.gmail.com>
 <20180430170229.GA775@book.hvoigt.net> <1525246025.2176.12.camel@klsmartin.com>
 <20180503164226.GB23564@book.hvoigt.net> <1525422571.2175.52.camel@klsmartin.com>
 <20180504101854.GA29828@book.hvoigt.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 May 2018 07:43:00 -0700
Message-ID: <CABPp-BGaibCPWuCnaX5Af=sv-2zvyhNcupT+-PkxHDfJBg_Vbw@mail.gmail.com>
Subject: Re: git merge banch w/ different submodule revision
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 4, 2018 at 3:18 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Hi,
>
> On Fri, May 04, 2018 at 08:29:32AM +0000, Middelschulte, Leif wrote:
>> Am Donnerstag, den 03.05.2018, 18:42 +0200 schrieb Heiko Voigt:
<snip>
>> > It seems to me that you do not want to mix integration testing and
>> > testing of the feature itself.
>> That's on point. That's why it would be nice if git *at least* warned
>> about the different revisions wrt submodules.

There's a good point here...

> Well a submodule version is pinned down as long a you do not change it
> and commit it. The same as files and the goal is to make submodules
> behave as close to normal files as possible. And git "warns" about
> changed submodules by displaying them in the diff.

Actually, submodules do behave differently than normal files in an
important way, which we may be able to fix and may help Leif here:

When merging two regular files that have been modified on both sides
of history, git always prints a message, "Auto-merging $FILE".  We
could omit that and depend on the user to check the diffstat or run
diff afterwards or something, but we don't just rely on that; we also
warn them with a simple message that we are doing something to resolve
this both-sides-changed-this-path (namely employing the well known
three-way-file-merge algorithm to come up with something).

Inside merge_submodule(), the equivalent would be printing a message
whenever we decide that one branch is a fast-forward of the other
("Case #1", as it's called in the code), yet currently it prints
nothing.  Perhaps it should.


Leif, would you like to try your hand at creating a patch for this?
