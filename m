Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475F11F461
	for <e@80x24.org>; Wed, 15 May 2019 20:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfEOUUH (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 16:20:07 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:37822 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfEOUUH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 16:20:07 -0400
Received: by mail-ed1-f44.google.com with SMTP id w37so1617932edw.4
        for <git@vger.kernel.org>; Wed, 15 May 2019 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=1p7x2IJPUyh2/DplMQ1FN5StKwyj4yhtSmQA4L7HwfU=;
        b=b9XEKzG5egt2LOMGhaDm1FIfz/ksWbeGIdU2T1hL1V0We/ECLczotaWLXxVqEaexSb
         6pZgPfv7t7L/MIpmVmRZj0NwhorPCLrYl6zQ1ITn8XSQxuVkJjGfiP4yTqAq9I18ihg4
         rIMh2mz4v7fzctSD9iMYuyRkq3VjN+aQ8LLf+Ffu1Ly17uQ9dikC67r7VTzs4goRPPt7
         06GElAp37o32KpMtQwnqg7AFYrqOf0475SZN5bJdQ7ssZLOcGrXQ7HHcehlUNfJrrEMy
         ux2k5Pw+T9dsoi9BHC1SSegWSF8kJ7EH1dKdJEtpyznpE1IJInWb8TAWAu/OsZMRYTDb
         fn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=1p7x2IJPUyh2/DplMQ1FN5StKwyj4yhtSmQA4L7HwfU=;
        b=H9IObzHmR3vhUp18c0zYy7SoOnMoit4l0XxKOo5FBoBR265ZYyyQ3gfmkBbhfxBfp8
         Si2eN2EQd9OjnfYmCa+cpur9Vdu6D3kJgVEPrkdrjjqg3DYjgCKxb7CNg9db18g617Ax
         hvmPQxTPEznuYtwJz7IH3s2jVCviAJk6djRrHIiYTjRWD1PlRsWh5WzHrXDhRp1961EL
         7TeDHxpgdGGKXOKuVwnmJOsbZftj1sf7NERWjv+H2YEx80ECiA10XdPTCap165RDHb89
         +Bj35a9NK/E1EJblXSWn07mp+y5V+QHwPojHTuJADLyy0LDu2ir92BxoKLzNlo06pSDm
         nh2Q==
X-Gm-Message-State: APjAAAVvJc2A5JwRC+5pY4JlkA+icQKQbBuxkcs4yhqW+xw2H/tflXMq
        3FgGpNkW++f3jTEEYHbzBjqwRzTe
X-Google-Smtp-Source: APXvYqxXbCboa1qio7lwGUPrEquU54NUeDAtEIeaEwBgDYYgvENZ/U38IFhekqiLNpO3M6+HtAlxZg==
X-Received: by 2002:a17:906:2acf:: with SMTP id m15mr20016819eje.31.1557951604681;
        Wed, 15 May 2019 13:20:04 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b4sm1089643edf.7.2019.05.15.13.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 13:20:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Eric S. Raymond" <esr@thyrsus.com>
Cc:     git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
References: <20190515191605.21D394703049@snark.thyrsus.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190515191605.21D394703049@snark.thyrsus.com>
Date:   Wed, 15 May 2019 22:20:03 +0200
Message-ID: <871s0zwjv0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 15 2019, Eric S. Raymond wrote:

> The recent increase in vulnerability in SHA-1 means, I hope, that you
> are planning for the day when git needs to change to something like
> an elliptic-curve hash.  This means you're going to have a major
> format break. Such is life.

Note that most users of Git (default build options) won't be vulnerable
to the latest attack (or SHAttered), see
https://public-inbox.org/git/875zqbx5yz.fsf@evledraar.gmail.com/T/#u

But yes the plan is to move to SHA-256. See
https://github.com/git/git/blob/next/Documentation/technical/hash-function-transition.txt

> Since this is going to have to happen anyway

The SHA-1 <-> SHA-256 transition is planned to happen, but there's some
strong opinions that this should be *only* for munging the content for
hashing, not adding new stuff while we're at it (even if optional). See
: https://public-inbox.org/git/87ftyyedqd.fsf@evledraar.gmail.com/

> let me request two
> functional changes in git. Neither will be at all difficult, but the
> first one is also a thing that cannot be done without a format break,
> which is why I have not suggested them before.  They come from lots of
> (often painful) experience with repository conversions via
> reposurgeon.
>
> 1. Finer granularity on commit timestamps.

If you wanted milli/micro/nano-second timestamps for commit objects or
whatever other new info then it doesn't need to break the commit header
format.

You put it key-values in the commit message and read it back out via
git-interpret-trailers.

Or even put it in the header itself, e.g.:

author <name> <epoch> <tz>
committer <name> <epoch> <tz>
x-author-ns <nanosecond part of author>
x-committer-ns <nanosecond part of committer>

Of course nobody would understand that new thing from day one, but
that's nothing compared to breaking the existing header format.

> 2. Timestamps unique per repository
>
> The coarse resolution of git timestamps, and the lack of uniqueness,
> are at the bottom of several problems that are persistently irritating
> when I do repository conversions and surgery.
>
> The most obvious issue, though a relatively superficial one, is that I have
> to thow away information whenever I convert a repository from a system with
> finer-grained time.  Notably this is the case with Subversion, which keeps
> time to milliseconds. This is probably the only respect in which its data
> model remains superior to git's. :-)

Should be solved by putting it in the commit as noted above, just not in
the very narrow part of the object that's reserved and not going to
change.

More generally plenty of *->git importers write some extra data in the
commits, usually in the commit message. Try e.g. cloning a SVN repo with
"git svn clone" and see what it does.

> The deeper problem is that I want something from Git that I cannot
> have with 1-second granularity. That is: a unique timestamp on each
> commit in a repository. The only way to be certain of this is for git
> to delay accepting integration of a patch until it can issue a unique
> time mark for it - obviously impractical if the quantum is one second,
> but not if it's a millisecond or microsecond.
>
> Why do I want this? There are number of reasons, all related to a
> mathematical concept called "total ordering".  At present, commits in
> a Git repository only have partial ordering. One consequence is that
> action stamps - the committer/date pairs I use as VCS-independent commit
> identifications in reposurgeon - are not unique.  When a patch sequence
> is applied, it can easily happen fast enough to give several successive
> commits the same committer-ID and timestamp.
>
> Of course the commit hash remains a unique commit ID.  But it can't
> easily be parsed and followed by a human, which is a UX problem when
> it's used as a commit stamp in change comments.

You cannot get a guaranteed "total order" of any sort in anything like
git's current object model without taking a global lock on all write
operations.

Otherwise how would two concurrent ref updates / object writes be
guaranteed not to get the timestamp? Unlikely with nanosecond accuracy,
but not impossible.

Even if you solve that, take two such repositories and "git merge
--allow-unrelated-histories" them together. Now what's the order?

These issues are solved by defining ordering in terms of the graph, and
writing this information after-the-fact. That's already part of git. See
https://github.com/git/git/blob/next/Documentation/technical/commit-graph.txt
and
https://devblogs.microsoft.com/devops/supercharging-the-git-commit-graph-ii-file-format/

> More deeply, the lack of total ordering means that repository graphs
> don't have a single canonical serialized form.  This sounds abstract
> but it means there are surgical operations I can't regression-test
> properly.  My colleague Edward Cree has found cases where git fast-export
> can issue a stream dump for which git fast-import won't necessarily
> re-color certain interior nodes the same way when it's read back in
> and I'm pretty sure the absence of total ordering on the branch tips
> is at the bottom of that.

Can you clarify what you mean by this? You run fast-import twice and get
different results, is that it? If so that sounds like a bug.

> I'm willing to write patches if this direction is accepted.  I've figured
> out how to make fast-import streams upward-compatible with finer-grained
> timestamps.
