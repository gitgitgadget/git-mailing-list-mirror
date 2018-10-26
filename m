Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BF681F453
	for <e@80x24.org>; Fri, 26 Oct 2018 20:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeJ0Fep (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 01:34:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54278 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeJ0Fep (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 01:34:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so2684694wma.4
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y5BfTRoOFiNmczztG/IjWzVkkdF69F3Yp9pNGN7HPtA=;
        b=Ino5N0u0/fGPaOfwqIYcqgpcBrlqrCbWk/Ru5S0xRJdDRVmeGwDXxI/9tKXnwsQfPa
         CM0Cct3svld7BeDCJT6Ewjef4BYyswY4oNc0XEwn5jL4u2/6SfGpvIL7J+nGzb1+s8G7
         vdX/6/P8QZ2fKZkk0T8fmNqiTlhG5ks5zjNdCN+E9OCIaEnpogg/6X7doG6l0B49kBZQ
         Hf/Vjj67uG28Ae7myfEU/8h1JkfkC5TJ0PHOWmSe9MAAbpri7k3ShQ8KfRDfV8ISRj9/
         QTjhl8YMTpRk0y/Pdhpp3zLx5Ue1NKXdjQXGXiEWs9rEfK2mbYUuyJzzE/tYM6Whg0cv
         wW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Y5BfTRoOFiNmczztG/IjWzVkkdF69F3Yp9pNGN7HPtA=;
        b=cM72Wd5hE5KSKr58uYQOSZ3W9wt3K0f4Eh/J5MTt+QVe6/l6TpVpRETZHo+/JdUOB6
         uovXEPBudG6eROrRQGPl38d+DzSBJovYttiIDHciFNmW5vVE1L0zC1uEh7an6Cd55/wi
         5cZlucNIOPOgxiSglv8lhLkvkHX20U3PiAS9QtWgr1GYCzS38LnRItXZNDjtK3MO9GrO
         JwypufnTNZW3r1rROtdvVOlbwj4ktEsJLncPl2aBRxivr22KOQ5Bb1MzRwHsd4UU4xd2
         PQ00fAc+77hDZDcmdO+f+jJSZ9jnTgjAYHulJGmTW+5vRNzB6D+BRBcGU4zk69UIrYPG
         3VKA==
X-Gm-Message-State: AGRZ1gJfRgzuzF8dnqOUX4ay0JgnG0XGD2xidwDa2dL8gYPtDTgC9S8f
        toNryCn6Om3w0rK7A+izWk/Tz0q3
X-Google-Smtp-Source: AJdET5dW/T/v7phiIXq0JFABhgLrNxW77PBqSaI6TvDdRdtDYUmbFv9YsH4zawplxCxHWxzIbmXnJg==
X-Received: by 2002:a1c:8bcc:: with SMTP id n195-v6mr7089085wmd.118.1540587371199;
        Fri, 26 Oct 2018 13:56:11 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egq108.neoplus.adsl.tpnet.pl. [83.21.80.108])
        by smtp.gmail.com with ESMTPSA id y195-v6sm6183283wme.22.2018.10.26.13.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 13:56:10 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 4/7] revision.c: begin refactoring --topo-order logic
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
        <cd9eef96885a811196ab0b851a98de4455b950ab.1539729393.git.gitgitgadget@gmail.com>
        <86h8hfguqc.fsf@gmail.com>
        <xmqqa7n6zswl.fsf@gitster-ct.c.googlers.com>
        <bb91d5bb-4220-97b9-dd78-5aed39033e58@gmail.com>
        <xmqqk1m6ig52.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 26 Oct 2018 22:56:09 +0200
In-Reply-To: <xmqqk1m6ig52.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 25 Oct 2018 17:28:57 +0900")
Message-ID: <8636ss5swm.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <stolee@gmail.com> writes:
>
>> =C2=A0=C2=A0=C2=A0 time git log --topo-order -10 master >/dev/null
>>
>> =C2=A0=C2=A0=C2=A0 time git log --topo-order -10 maint..master >/dev/null
>>
>> I get 0.39s for the first call and 0.01s for the second. (Note: I
>> specified "-10" to ensure we are only writing 10 commits and the
>> output size does not factor into the time.) This is because the first
>> walks the entire history, while the second uses the heuristic walk to
>> identify a much smaller subgraph that the topo-order algorithm uses.
>
> The algorithm can be fooled by skewed timestamps (i.e. that SLOP
> thing tries to work around), but is helped by being able to leave
> early, and it will give us the correct answer as long as there is no
> timestamp inversion.
>
> But monotonically increasing "timestamp" without inversion is what
> we invented "generation numbers" for, no?  When there is no
> timestamp inversion, would a walk based on commit timestamps walk
> smaller set than a walk based on commit generation numbers?

The problem, as far as I understand it, is in B..A case, to be more
exact with the walk from the exclusion set.  There can be cases when
there are two paths from the commit in the exclusion set, and sorting by
generation number will always walk the longer one, while date-order
based heuristic walk traverses smaller subgraph.

This problem was described in "[PATCH 1/1] commit: don't use generation
numbers if not needed" [1]; relevant fragment cited below:

DS> For instance, computing the merge-base between consecutive versions of
DS> the Linux kernel has no effect for versions after v4.9, but 'git
DS> merge-base v4.8 v4.9' presents a performance regression [...]
DS>=20
DS> The topology of this case can be described in a simplified way
DS> here:
DS>=20
DS>   v4.9
DS>    |  \
DS>    |   \
DS>   v4.8  \
DS>    | \   \
DS>    |  \   |
DS>   ...  A  B
DS>    |  /  /
DS>    | /  /
DS>    |/__/
DS>    C
DS>=20
DS> Here, the "..." means "a very long line of commits". By generation
DS> number, A and B have generation one more than C. However, A and B
DS> have commit date higher than most of the commits reachable from
DS> v4.8. When the walk reaches v4.8, we realize that it has PARENT1
DS> and PARENT2 flags, so everything it can reach is marked as STALE,
DS> including A. B has only the PARENT1 flag, so is not STALE.
DS>=20
DS> When paint_down_to_common() is run using
DS> compare_commits_by_commit_date, A and B are removed from the queue
DS> early and C is inserted into the queue. At this point, C and the
DS> rest of the queue entries are marked as STALE. The loop then
DS> terminates.
DS>=20
DS> When paint_down_to_common() is run using
DS> compare_commits_by_gen_then_commit_date, B is removed from the
DS> queue only after the many commits reachable from v4.8 are explored.
DS> This causes the loop to run longer. The reason for this regression
DS> is simple: the queue order is intended to not explore a commit
DS> until everything that _could_ reach that commit is explored. From
DS> the information gathered by the original ordering, we have no
DS> guarantee that there is not a commit D reachable from v4.8 that
DS> can also reach B. We gained absolute correctness in exchange for
DS> a performance regression.

[1]: https://public-inbox.org/git/efa3720fb40638e5d61c6130b55e3348d8e4339e.=
1535633886.git.gitgitgadget@gmail.com/T/#u

>> Just as before, by using this algorithm for the B..A case, we are
>> adding an extra restriction on the algorithm: always be correct. This
>> results in us walking a larger set (everything reachable from B or A
>> with generation number at least the smallest generation of a commit
>> reachable from only one).
>>
>> I believe this can be handled by using a smarter generation number
>> (one that relies on commit date as a heuristic, but still have enough
>> information to guarantee topological relationships), and I've already
>> started testing a few of these directions.
>
> Good to hear.

I'm not sure if you can enhance generation numbers, or rather using /
sorting of generation numbers in such way.

With generation numbers, if you have two possible paths to the merge
commit, and one is much longer than the other, then the commits on this
longer path will have larger generation numbers.


        0     1     2     3     4     5     6     7       =3D gen(c) - gen(=
B)
    --- B<----*<----*<----*<----*<----*<----*<----M ---
        ^                                        /
         \--------------------------x<--------x</         =3D gen(c) - gen(=
B)
                                    1         2

    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D commit =
date =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>

Using priority-queue which selects max generation number would then
always walk the longer path (or walk longer path first).

This does not matter for the walk from the inclusive set (A in B..A), as
we want to walk all commits anyway; we walk both paths, it does not
matter which we walk first (it may change the unimportant parts of
topological sort, though).

For the walk from the exclusive set (B in B..A), any path is good; we
don't need and do not want to walk all paths.  Sorting by generation
numbers will always choose the longer path, while sorting by commit date
may walk the "shortcut" first, thus marking commits reachable from the
inclusive subset (from A) STALE earlier, thus earlier notice of
all-stale, and end of walk.

I think that in the case of walking from the exclusion subset, using
positive-cut reachbility index would be more useful than trying to come
up with "smarter generation number" (though I am not saying that it
would be impossible).  For example using reachability bitmap indices, or
post-order in spanning tree (the latter descibed in [2]) to mark more
commits stale than just parents, may help more.

Actually, this is something independent from "smarter generation
numbers", and can only help...

[2]: "[RFC] Other chunks for commit-graph, part 2 - reachability indexes"
     https://public-inbox.org/git/86muxcuyod.fsf@gmail.com/

--=20
Jakub Nar=C4=99bski
