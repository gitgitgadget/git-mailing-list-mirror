Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70111F453
	for <e@80x24.org>; Thu, 17 Jan 2019 17:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfAQR5V (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 12:57:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40465 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfAQR5V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 12:57:21 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so9053063edr.7
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 09:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKSQqF1eicxb5tXIbclhf69p6P5+AnHaDuNp45QwIw8=;
        b=agHKe3FxQkPveCm2D+Iqzqa4TOCS/KfLpikhjfZXV6/OGaLLY9Ajbwfla9hL4Pm/zQ
         Lu318F0q3fCYBQ4opI9lQdRIJE/R7tA+vBL0d0AGxpJUX3K+KeWSGcScrv9HTxiMh7Q6
         /A8e2EOQUn9UjD61Ho342KUBYEwzQoVoij8R0dIXSVHm9f9xU0+Jt6MKk9Wo0EeN1DDE
         EXd6pQ22IvqG6rH3jde2jvOuejKESORAc0Ani/JyLPEOwzUOgQRNugC7RKG4H/oN6QUe
         D1skjaJvdtPcTbI66Swz8mK9vzQRTKq2jjGfbViGMC39IgOqrURmxL29+k3OqeJad9RT
         tirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKSQqF1eicxb5tXIbclhf69p6P5+AnHaDuNp45QwIw8=;
        b=Ili1E3Rl+Et9BPm7TpHFts8GP3QyI4y1OxZiuIRpzgb6C39ds+G14KzcAKAD+3t2H/
         x13D33SwrhfZWt//X1AmJbrDAkmB7bJS2fAjP2ebqo5BMY7Hf3bCs/60in0CjDeMqS9M
         eyR6ATQsTaYb+wzIvTwoLfQMVUGNlwKDGBf01QiGnxqRvWkh3fTntzIyNU0vrgJZM7D5
         C7WpVrz0iO7jgFgmaDVcehi1IwJv6Nwg2VKRojyh7lVZ7fzGtpIER/LrZuEO5Cunr7BK
         +VB03USHbCJnnSBE4sXavp07ArN0ymDEFX+9erINaM3L5jvzlfwwWqRTHoEnPmqKVPkF
         2haA==
X-Gm-Message-State: AJcUukf3hgNawEfcKNumBK0dG2yI/gTPWH+YoSS6ULWqpR+Dfw4vHrkw
        +Dt3w6y3FGzY74FuNAGk0nbQVUKqNwZ+co9bJmvE9Q==
X-Google-Smtp-Source: ALg8bN4wFbZJnlM78odW/lCDM8KzYqkQg9jpoC+ieu3WXD8T0G8OrBamC0Wmv7UlYxxgcHiQMMBz5MsI4QNCt/8NRf0=
X-Received: by 2002:a50:8fe4:: with SMTP id y91mr12438684edy.231.1547747838868;
 Thu, 17 Jan 2019 09:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20180807230637.247200-1-bmwill@google.com> <20190115012507.GK162110@google.com>
 <20190117173216.GB27667@sigill.intra.peff.net>
In-Reply-To: <20190117173216.GB27667@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Jan 2019 09:57:07 -0800
Message-ID: <CAGZ79kbofESBSTHbDdPmeZgb2Pwz=8FVmtXG6x376utMyS0vqA@mail.gmail.com>
Subject: Re: [RFC] submodule: munge paths to submodule git directories
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Aaron Schrab <aaron@schrab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 17, 2019 at 9:32 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jan 14, 2019 at 05:25:07PM -0800, Jonathan Nieder wrote:
>
> > I've put a summary in https://crbug.com/git/28 to make this easier to
> > pick up where we left off.  Summary from there of the upstream review:
> >
> > 1. Using urlencoding to escape the slashes is fine, but what if we
> >    want to escape some other character (for example to handle
> >    case-insensitive filesystems)?
> >
> >    Proposal: Store the escaping mapping in config[1] so it can be
> >    modified it in the future:
> >
> >       [submodule "plugin/hooks"]
> >               gitdirname = plugins%2fhooks
>
> I think it might be worth dealing with case-sensitivity _now_, since we
> know it's a problem. That doesn't make the problem of "what if we want
> to change the mapping later" go away, but it does make it a lot less
> likely to come up.

Makes sense.

>
> > 2. The urlencoded name could conflict with a submodule that has % in
> >    its name in an existing clone created by an older version of Git.
> >
> >    Proposal: Put submodules in a new .git/submodules/ directory
> >    instead of .git/modules/.
>
> This proposal is orthogonal to (1), right? I.e., if we store the mapping
> then that is what tells us we're using the mapped name.

Technically true, but it allows for easier implementation:
now we have 2 distinct namespaces, such that we can avoid
double booking easier:

    Consider 2 submodules "a b" and "a%20b".

Without (2), (1) is hard to explain as the first might have been encoded
to a%20b or there might have been the second put in place from a
current (old) version of Git. So we'd have to reason about these corner cases.

With (2) in place, we'd only ever have the second in a place "a%2520b"
(if I am to trust https://www.urlencoder.org/)

> > 3. These gitdirname settings can clutter up .git/config.
> >
> >    Proposal: For the "easy" cases (e.g. submodule name consisting of
> >    [a-z]*), allow omitting the gitdirname setting.
>
> Not having thought about it too hard, I suspect that may open back up
> corner cases with respect to backwards compatibility and ambiguity.
>
> Are you worried about human-readable clutter? I.e., that .git/config
> becomes hard to read? If so, then:
>
>   - I doubt this is any worse than the existing tracking-branch config.
>
>   - it might be reasonable to store it in .git/submodule-config, and
>     make sure that .git/config contains a single "[include]path =
>     submodule-config" line. I've been tempted to do that for
>     tracking-branch config.
>
> Or are you worried about the cost of parsing those entries? Basically
> every git command parses config linearly at least once; this normally
> isn't noticeable, but at some size it becomes a problem. I have no idea
> what that size is.
>
> If so, then I think we'd want submodule config in its own file but
> _without_ an include from the normal config file. That would break
> compatibility with anything that tries to use "git config
> submodule.foo.path", etc.
>
> That's all just musing. I'm actually not really convinced it's a
> problem.

ok, we can deal with the problem once it arises.

>
> > Is that a fair summary?  Are there concerns from the review that I
> > forgot, or would a new version of the series that addresses those
> > three problems put us in good shape?
>
> I don't really have a strong opinion either way. I still think the
> one-way transformation that the patch uses is less elegant than a real
> encode/decode round-trip (i.e., what I discussed in [1]). But I admit to
> not having thought through all of the details of the encode/decode
> thing, and certainly have not written the code.

The suggestion of adding at least a test for url encoding (2. from your mail)
is sensible.

Stefan

>
> [1] http://public-inbox.org/git/20180809212602.GA11342@sigill.intra.peff.net/
