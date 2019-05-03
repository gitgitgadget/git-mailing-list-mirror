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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8541E1F453
	for <e@80x24.org>; Fri,  3 May 2019 13:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfECNll (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 09:41:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37174 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfECNll (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 09:41:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so6060336edw.4
        for <git@vger.kernel.org>; Fri, 03 May 2019 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ovA8Lf4JjPW0AcslVt5iJbhZlXPobT8YJK2xRLFeLrk=;
        b=VCpTQ8OyQ4lK63Xg3npw0+L+Wkh1BpoyuJh/zeCE9SOJexIMNVybenYqJrXj8EpJm7
         W2rHoAtOd2+1cqpsKpv314xF+/SZ5pqNedi21RSo4ra2XNNEAKMzA6FPtenhRyqWG53O
         9JtVHr+aSru+9uY+RbV3yX5K4YmyWApJ52/vQcI8lgsWFnONCosnq5u/ZY3qDq3DQsTI
         S/kd5FecmjVjarziDUcp7tCQN792z6belvJ0lzJE7n2MRbvVSlemz/f1drvu0TOLstev
         vokCh6+UmZGBaXu74YlQZV8URzOAN9TCW95VNPcpHJWfX7ykH5hdW6Si5HhuJbj+NglY
         0Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ovA8Lf4JjPW0AcslVt5iJbhZlXPobT8YJK2xRLFeLrk=;
        b=KXsNjtLWNv9YfpDPb24gK5TFrX4YnXvuN+tyBF30flWjriiIy3j9g1zV6QpJ9yODEG
         buiR4XbPeX7vcExMqLVT0v09lKvLc8bcAn7B+ZIXnxhjQczYg6tE0jAyfmKOrYJZHnVG
         qpPpG/sHa/OdqEjifD3iGBTq9vjST+63r3x/3vthDLrCK1kxT9VLCnT+upxZNz9omfUW
         nG6p7Ut4RpjMUEXzCsYQ+vJ69+0hZHKiLXnOEyLRNttMbw9lAwV9/LOFZlo51sEMo4UC
         xt/DiuQppnEJuhjiZys75Pf60XARNt4ak7SAya3GvsizX4nmm3+AniyXLPRMgmGQ0Tgr
         PCIw==
X-Gm-Message-State: APjAAAWKHmqxPhgzmmhmXPeAv6g5L1Q3s141EF4avT6p2exaKj1GHITd
        eRRi7Iwp0jNlZK5IlEwYnhk=
X-Google-Smtp-Source: APXvYqy84Ycqa2S70uR6ojG0zslj/4DfrLnWGblnM4D0w38GBe427RUCGkh3TzOETJKgXL+R5UMwkw==
X-Received: by 2002:a50:b3a6:: with SMTP id s35mr6982077edd.220.1556890898976;
        Fri, 03 May 2019 06:41:38 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id s53sm592371edb.20.2019.05.03.06.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 06:41:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] Create commit-graph file format v2
References: <pull.112.v2.git.gitgitgadget@gmail.com> <pull.112.v3.git.gitgitgadget@gmail.com> <87lfzprkfc.fsf@evledraar.gmail.com> <bb0c22f9-9d0b-0fa6-e826-8e2ac146c6f9@gmail.com> <87h8acivkh.fsf@evledraar.gmail.com> <04ac97c5-ab2b-2b23-4c84-8ed8aab0e2f5@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <04ac97c5-ab2b-2b23-4c84-8ed8aab0e2f5@gmail.com>
Date:   Fri, 03 May 2019 15:41:36 +0200
Message-ID: <87bm0jirjj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 03 2019, Derrick Stolee wrote:

> On 5/2/2019 2:02 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> But those are separate from any back-compat concerns, which is what I
>> think makes sense to focus on now.
>
> Thinking more on this topic, I think I have a way to satisfy _all_ of
> your concerns by simplifying the plan for incremental commit-graph files.
>
> My initial plan was to have the "commit-graph" file always be the "tip"
> file, and it would point to some number of "graph-{hash}.graph" files.
> Then, we would have some set of strategies to decide when we create a new
> .graph file or when we compact the files down into the "commit-graph"
> file.
>
> This has several issues regarding race conditions that I had not yet
> resolved (and maybe would always have problems).
>
> It would be much simpler to restrict the model. Your idea of changing
> the file name is the inspiration here.

I still have some questions about SHA-256, how we'll eventually change
the format of these new files etc, but those can wait...

> * The "commit-graph" file is the base commit graph. It is always
>   closed under reachability (if a commit exists in this file, then
>   its parents are also in this file). We will also consider this to
>   be "commit-graph-0".
>
> * A commit-graph-<N> exists, then we check for the existence of
>   commit-graph-<N+1>. This file can contain commits whose parents
>   are in any smaller file.
>
> I think this resolves the issue of back-compat without updating
> the file format:
>
> 1. Old clients will never look at commit-graph-N, so they will
>    never complain about an "incomplete" file.
>
> 2. If we always open a read handle as we move up the list, then
>    a "merge and collapse" write to commit-graph-N will not
>    interrupt an existing process reading that file.
>
> I'll start hacking on this model.

Just on this, consider storing them in
.git/objects/info/commit-graphs/commit-graph-<THIS-FILE'S-CHECKSUM-SHA1>,
because:

1) We can stat() the "commit-graphs" directory to see if there's any
   new/deleted ones (dir mtime changed), similar to what we do for the
   untracked cache, and can (but I don't think we do...) do for packs/*
   and objects/??/.

   As opposed to ".git/objects/info" itself which e.g. has the "packs",
   "alternates" etc. files (can still do it, but more false positives)

2) If these things are "chained" supersets of one another anyway we have
   a big caveat that we don't have with repacking the *.pack
   files.

   Those you can do in any order, as long as you write a new one it
   doesn't matter if the data is already elsewhere stored. Just repack
   however many N at a time, then unlink() all the old ones later.

   If you have commit-graph-<N>, commit-graph-<N+1> you can only munge
   them in that sequence, and you get to do a much more careful fsync()
   dance around with both the directory entry and the file itself, which
   has a much higher chance of breaking things.

   I.e. the client might see a change to "N" before "N+1", and now we're
   screwed. Dealing with this is a giant but avoidable PITA. See
   https://public-inbox.org/git/20180117184828.31816-1-hch@lst.de/ and
   http://blog.httrack.com/blog/2013/11/15/everything-you-always-wanted-to-=
know-about-fsync/

   If instead you name the files commit-graph-<MY-OWN-SHA>, and add a
   new (v1 backwards-compatible) chunk for "and the next file's SHA-1
   is..."  we can more aggressively repack these.

   Worst case the directory entries will sync in the wrong order and the
   chain will be broken, but as long as we gracefully handle the chain
   abruptly ending that's OK.

   You can also do things like rewrite the middle "[]" of a "N, [N+1,
   N+2], N+3" sequence to have a single file for what was previously
   within those brackets (again, like "repack"). You'd just need to drop
   in a new "N" that points to the replacement for "[N+1, N+2]", but
   *don't* need to touch "N+3".

   Whereas if they're numbered you need to also move "N+3", and you're
   back to juggling both fsync() on files and directory entries.
