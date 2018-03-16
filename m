Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 786831F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeCPUBt (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:01:49 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34849 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbeCPUBq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:01:46 -0400
Received: by mail-wr0-f169.google.com with SMTP id n12so12778706wra.2
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=lJhWfZSM82qcIj4gDtUWuOcrlsmZA768+khVNHc67CE=;
        b=fvMiMXAfBmh1FklEeNVEbCitBTMYEZIj6ZxzKqHGGineWe44Tcnd4AW4cggoxcFmTO
         T9wNpSWThZM/LRrLYdpgbHp7HU4aWd6zWa++3VrFr+DOvUeg2AOyAa9JrJyPfTx2R9o3
         HMk1uryLYgr/4YiQbtpuSVdWLQUAEf4nSxJ0JacMS+/sACgck09NwplMIWSdJrrJSs52
         yd1TZgHMs7xLJsPFlkEflJRPxix6gIsnP99LFo1BT08wKKWH85OQczCbq34Wdi2meIEW
         bPmACJTKcBA94o6YPIPVQXuYfiRLAqPrDeRBKYdjXRtKMFcyy4aeFtE94E8oYHulkMuw
         W2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=lJhWfZSM82qcIj4gDtUWuOcrlsmZA768+khVNHc67CE=;
        b=cCPvqH9xF7NjvcXnhvu113UBedeV/js2eyOmU5ngFDvaR79xzlQXC5Qm7Wy45OlJln
         o5JSIh9Z+J7RxNu/jlnhod1hpdiv2bTEseFTLcsyKxk1GtTXNQzuhI2B2YIlVbtksnlr
         QHFbsORRLGJNLLhakKjpmTx3ufSTZI6t/0a1ctJFTM1qq8HjkQhA21LCMAFIjgRe1r1f
         NRHNDycyeK/6g4TDT6TFcpqGR7mzz4T72uBngLAsklV2l2eYpJ7wbT1s9Gn0gQZjYsqk
         9At2JQtLVg11lIOHNIUmIKyLPglnDJjYAGABgYxMdvcsnTMOPI3HCJuUrDMN9LLw3TVZ
         JRLw==
X-Gm-Message-State: AElRT7FCm2iDpn8iE+Q0qkKPdiULN6OStLOExLhBRDuqMH9EdAc8khNl
        6r71JId09gcsV4omSgpk5rg=
X-Google-Smtp-Source: AG47ELslLPnwHlOvLvS1rhjvNnQlMHeAZCJDElxGl3r93ShAfiWFHuhZGcTdyux0nrTW1LjyJHapIg==
X-Received: by 10.223.200.144 with SMTP id k16mr2866271wrh.282.1521230504826;
        Fri, 16 Mar 2018 13:01:44 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id d4sm7178537wmh.42.2018.03.16.13.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 13:01:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     mhagger@alum.mit.edu
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [ANNOUNCE] git-sizer: compute various size-related metrics for your Git repository
References: <CAMy9T_FaOdLP482YZcMX16mpy_EgM0ok1GKg45rE=X+HTGxSiQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAMy9T_FaOdLP482YZcMX16mpy_EgM0ok1GKg45rE=X+HTGxSiQ@mail.gmail.com>
Date:   Fri, 16 Mar 2018 21:01:42 +0100
Message-ID: <87370zeqmx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 16 2018, Michael Haggerty jotted:

> What makes a Git repository unwieldy to work with and host? It turns
> out that the respository's on-disk size in gigabytes is only part of
> the story. From our experience at GitHub, repositories cause problems
> because of poor internal layout at least as often as because of their
> overall size. For example,
>
> * blobs or trees that are too large
> * large blobs that are modified frequently (e.g., database dumps)
> * large trees that are modified frequently
> * trees that expand to unreasonable size when checked out (e.g., "Git
> bombs" [2])
> * too many tiny Git objects
> * too many references
> * other oddities, such as giant octopus merges, super long reference
> names or file paths, huge commit messages, etc.
>
> `git-sizer` [1] is a new open-source tool that computes various
> size-related statistics for a Git repository and points out those that
> are likely to cause problems or inconvenience to its users.

This is a very useful tool. I've been using it to get insight into some
bad repositories.

Suggestion for a thing to add to it, I don't have the time on the Go
tuits:

One thing that can make repositories very pathological is if the ratio
of trees to commits is too low.

I was dealing with a repo the other day that had several thousand files
all in the same root directory, and no subdirectories.

This meant that doing `git log -- <file>` was very expensive. I wrote a
bit about this on this related ticket the other day:
https://gitlab.com/gitlab-org/gitlab-ce/issues/42104#note_54933512

But it's not something where you can just say having more trees is
better, because on the other end of the spectrume we can imagine a repo
like linux.git where each file like COPYING instead exists at
C/O/P/Y/I/N/G, that would also be pathological.

It would be very interesting to do some tests to see what the optimal
value would be.

I also suspect it's not really about the commit / tree ratio, but that
you have some reasonable amount of nested trees per file, *and* that
changes to them are reasonably spread out. I.e. it doesn't help if you
have a doc/ and a src/ directory if 99% of your commits change src/, and
if you're doing 'git log -- src/something.c'.

Which is all a very long-winded way of saying that I don't know what the
general rule is, but I have some suspicions, but having all your files
in the root is definitely bad.
