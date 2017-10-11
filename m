Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F0920445
	for <e@80x24.org>; Wed, 11 Oct 2017 20:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbdJKUw0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 16:52:26 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:53692 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdJKUwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 16:52:25 -0400
Received: by mail-qt0-f172.google.com with SMTP id n61so9241683qte.10
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nPKBKz0w7P1P3n9qnmq3C1K8ju1pp+X32eKRc8sWfVg=;
        b=KfWMAvEdLe27a6wJ6H+diq6ZH0YYz0A24q5HJDRswEwCsWOSRk/5Hi86TUK3QD0Po4
         QfFaCO3Yag5n4hcckBvh5YmJY18fni7+70gLEMpx8dDbEyfFAwOf9YYxEWyY3x3Ep8vZ
         CjHqdhhwUZvLPpeakeUqkqRVmo8haMlbLeJJWC3Xtgnj24dKQh9H99UNFoS9jQaAJS/S
         ekM2HEKfJAHqploKWEEoAMVJnTwqOz6J9bDKCKiHwe+B35uuYoK3hYBRbjLQD8SyKbqB
         rykLSub+cTW5n0HKrgG91VSj+aKKHAhUk6hp9nPc7GpsH/93saludrCW/ckHO7vapvGz
         gRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nPKBKz0w7P1P3n9qnmq3C1K8ju1pp+X32eKRc8sWfVg=;
        b=fsAvUX27bu1GWj38Ap5G7pLvjEKfodXGc5/0gfKwMCR7+UC4hJ1JXwspRZcKK6o5NG
         Su40czE6e5tlzfX8SSX1YC+DJ9glSkaCpi7LGZ+gwlIEg05XmGUqlk7x7T5F/gE2XjkO
         Pc/NgXZVstQS40E4eKj7YNR4uzpqtdr9lnponLftzwGGMmLxFVxPxF6OUKdG2QoGhIuA
         wk4vDRycUkNUzUrj9EEV8L21jeuuzzCPQk308gCn9/FcNkIRWZdMOr24O2KRd7yFTqWL
         rwUonOFOIovGdamixsjhlYkEyrTwXjCK2rrEs58p4OT7UWCJukPkQ8oY9na6265YKIQo
         KbZg==
X-Gm-Message-State: AMCzsaWxH00iTMFNt/7WP4NWgfZMWhF+SEV/d1jPqZy45bXVDSKlbdd0
        Bsa43/5H1RA8fUghXPzxKnuXxmVl3FnJoZBSrl1LDQ==
X-Google-Smtp-Source: AOwi7QAQK+P1c+DF8XhmtDWZqZD2NUuuOXB9tQEO2kIQIzB0AJvd6FnfjAXookA9OwNmxXhVqoP4UzaSC7FchHHkXVo=
X-Received: by 10.200.8.53 with SMTP id u50mr508034qth.260.1507755144427; Wed,
 11 Oct 2017 13:52:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Wed, 11 Oct 2017 13:52:23 -0700 (PDT)
In-Reply-To: <CAK7vU=0tRu=MAtBWHaQ6pGOGMfYdEorNd_930jq_3n_tLY2hsg@mail.gmail.com>
References: <CAK7vU=0ztEwMPsGO4Cd1A5JEnxmwkF57QPKjjvjD8rBUB79dRA@mail.gmail.com>
 <CAGZ79kaBJnXW=rSiKuHpds79mXVL0Aoo+PBa0a5V-C_bop=Kbg@mail.gmail.com>
 <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
 <CAK7vU=22W9mYdSnw_LP2uWYyKZuTzF0JgTVWCX+nMhUnLjQ_Cw@mail.gmail.com> <CAK7vU=0tRu=MAtBWHaQ6pGOGMfYdEorNd_930jq_3n_tLY2hsg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 11 Oct 2017 13:52:23 -0700
Message-ID: <CAGZ79kbBY0wAor6wS5gVNw95+ETkhxxeP3UeGoNwbA6g2ZbkkA@mail.gmail.com>
Subject: Re: Enhancement request: git-push: Allow (configurable) default push-option
To:     Marius Paliga <marius.paliga@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2017 at 2:18 AM, Marius Paliga <marius.paliga@gmail.com> wrote:
> Found one possible issue when looking for duplicates, we need to use
>   "unsorted_string_list_has_string" instead of "string_list_has_string"
>
> -                       if (!string_list_has_string(&push_options,
> item->string))
> +                       if
> (!unsorted_string_list_has_string(&push_options, item->string)) {
>
> New (fixed) patch follows...
>
>
> Signed-off-by: Marius Paliga <marius.paliga@gmail.com>

Yay, thanks for working on this!

Junio gave good advice to the patch itself (the code), another thing
is the commit message, which follows the formalities with the sign off,
but the content is not addressing the target audience.

The current commit message is written as an improvement compared
to the previous patch and for readers who are reviewing the patch
right now.

Commit messages are read by people later in time, also they do not
care about the different iterations of the patch, as only the final iteration
matters.

I think for the commit message you can borrow from the very first email
you sent to the list, maybe something like:

    builtin/push.c: add push.pushOption config

    Currently push options need to be given explicitly, via
    the command line as "git push --push-option".

    Some code review systems [which?] need specific push options
    nearly all the time, so the UX of Git would be enhanced if push
    options could be configured instead of given each time on the\
    command line.

    Add the config option push.pushOption, which is a multi
    string option, containing push options that are sent by default.

    When push options are set in the system wide config
    (/etc/gitconfig), they can be unset(?) later in the more specific
    repository config by setting the string to the empty string.

    Add tests and documentation as well.

    Signed-off-by ...
