Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AC121F453
	for <e@80x24.org>; Thu, 25 Apr 2019 22:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfDYWJS (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 18:09:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39822 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDYWJS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 18:09:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id k45so1423153edb.6
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=MoCjR0aWVJpb6alHe2spQwtvCKssPCImbJKSSG72n8M=;
        b=WVnD/BWUyDnMhv7YnN1lOe/9wf+0dlPOFP3jtI1SM2rug2yZTR/mHEJkJElbx/UUHO
         h572QyI39uwcydhepENUpPEG13NR4zKO3AM1hEeaOgPBsbk8ezM8ig6N60fFA1x6mIvN
         uWZ6mSTP5oBMTYbgXoWJrOrYWetDHBK/FcA3UTBKg0H9kaEVq8kvCFvVHremDDHE3dwf
         zLTOT4F9/hoKlVa1I+M+J1ywVnmrs23CicVH7OZdnM0h9f1j+/OChJ+MYiBhX89HebOK
         gTFWoMmO7YoIaXZH5F9NE4LPnFG9dklKI68ztUMRMX5HUelUA0jfhPKAfO9faNwj87If
         N5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=MoCjR0aWVJpb6alHe2spQwtvCKssPCImbJKSSG72n8M=;
        b=c/uL3YPLDtpMuOcvuI6LK7zTneHmBigmN/8PVrhzTQK8JCRLl/isojfswTzUVcxzfa
         bB6c5IvRF6fuqtNn49aDTtCtpkogVuAof7PRW/ULwl/x25WA/fxgrt9UTqBpYALqstwy
         ESD9DDdMzeLQ/Gj1SPKCX7Clqw18c6HoUuL4F6yjPIoM/VsGqfyZUf6dTOZcfbwme9Mj
         MgMrlLzhG85JNUKhTlr2//CgyoaPxMqTzjFuQ1SFqRZZQETP1gRhxWAC6RRsCO3RTfYr
         UWVw2iJP42WqjcbvEznduWLEWIMYxQL5IB+8i4e685ZzwZRLUHsBSUq18zhpPoRM568v
         G6EA==
X-Gm-Message-State: APjAAAWw8pDiY3ElhJulRPhBtx5GlzHksW92HD0607ypyQUGd7Ag6/3J
        4Rk5eqDtj7t3K+vlrZjVNNg=
X-Google-Smtp-Source: APXvYqx/kpFEzfFLmWMEBbut4JAt0juh4N2IlG5xBkZAnq/Dp+spD+41WYpHItBCtEQf7L0WVwhP6A==
X-Received: by 2002:a50:b4b4:: with SMTP id w49mr26153267edd.174.1556230156781;
        Thu, 25 Apr 2019 15:09:16 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id n16sm4260041ejb.28.2019.04.25.15.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 15:09:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Create commit-graph file format v2
References: <pull.112.git.gitgitgadget@gmail.com> <pull.112.v2.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <pull.112.v2.git.gitgitgadget@gmail.com>
Date:   Fri, 26 Apr 2019 00:09:15 +0200
Message-ID: <87a7gdspo4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 24 2019, Derrick Stolee via GitGitGadget wrote:

> NOTE: this series was rebased onto ab/commit-graph-fixes, as the conflicts
> were significant and subtle.

Sorry, hopefully it helped more than it harmed :)

A few unrelated things:

1)

First, before that series of mine applying this and writing a v2 file
would make most things (e.g. "status") hard error on e.g. v2.21.0:


    $ git status
    error: graph version 2 does not match version 1
    $

Now as noted in my series we now on 'master' downgrade that to a warning
(along with the rest of the errors):

    $ ~/g/git/git --exec-path=$PWD status
    error: commit-graph version 2 does not match version 1
    On branch master
    [...]

...and this series sets the default version for all new graphs to v2.

I think this is *way* too aggressive of an upgrade path. If these
patches go into v2.22.0 then git clients on all older versions that grok
the commit graph (IIRC v2.18 and above) will have their git completely
broken if they're in a mixed-git-version environment.

Is it really so important to move to v2 right away that we need to risk
those breakages? I think even with my ab/commit-graph-fixes it's still
too annoying (I was mostly trying to fix other stuff...). If only we
could detect "we should make a new graph now" ....

2)

...speaking of which, digging up outstanding stuff I have on the
commit-graph I was reminded to finish up my "commit graph on clone"
patch in:
https://public-inbox.org/git/87in2hgzin.fsf@evledraar.gmail.com/

And re #1 above: I guess we could also do that "let's make a graph" and
call "gc --auto" if a) we have gc.writeCommitGraph b) we see it's not
the "right" version. As long as older versions always write a "old" one
if they can't grok the "new" one, and newer versions leave existing
graphs alone even if they're older versions, so we don't flip-flop.

One of the things that would make that "graph on clone/fetch/whatever"
easier is having the graph store the total number of objects while it
was at it, you indicated in
https://public-inbox.org/git/934fa00e-f6df-c333-4968-3e9acffab22d@gmail.com/
that you already have an internal MSFT implementation of it that does
it.

Any reason not to make it part of v2 while we're at it? We already find
out how many (packed) objects we have in "add_packed_commits", we just
don't do anything with that information now.

3)

Also (but mostly unrelated). I see that "Future Work" in
Documentation/technical/commit-graph.txt now appears to entirely
describe "Past Work" instead :)

4)

The third point in "Design Details" also says that the format doesn't
need a change for a future hash algo change, yet here we are at v2
making a (small) change for that purpose :)
