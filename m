Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B351F404
	for <e@80x24.org>; Sat, 14 Apr 2018 16:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbeDNQxE (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 12:53:04 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33564 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeDNQxD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 12:53:03 -0400
Received: by mail-wr0-f180.google.com with SMTP id z73so15335158wrb.0
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 09:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=aaRyJfDMsyLw1YFcpcEA4tDPxXNaFYCQWdzAXipu2HU=;
        b=FSon54O8tge6DupvmzhPL6mKH4iiVjPKCJFHHqyzpC0yD8JIO9K51lPTo0YMJd34PG
         K7Q5u/g8YOiAft8BKkl1dwh5HXTza7k2Cy7gsvwLaTCfE23tfaaEdXPDk8NX2cw+9o9f
         xpwKVxIZvwxzvENSA2MZpfFnQLZ9XCEzD4KdhG2v6QjtV6V8CK+IsZeXJagu2ytJiieR
         YK/ry9l2x+wvPlwuWdeh1vZ4DezVRjmbm0KCbJgBoL6U3h62UKcex4IG3cd8mg5M5u6V
         fKoQ6uEIixVS5PMyfWI36HdTkhlDBN+WJEhXitPvGdWT+J7Ckr9EqWCXJTScTOOyBOzO
         7fOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=aaRyJfDMsyLw1YFcpcEA4tDPxXNaFYCQWdzAXipu2HU=;
        b=cY9L5VD+Zk6tucTxrNpRRl56WQsHzwUg92SfMZJEXal+DC9/ksKPZOCJWmNB/Yas+e
         czSFLkrKLnhdJfL/1D1v4wi2yLwYnWATWZ3nzxan3t1GT5qZpu7nkpFYq9kHg4xUB5Wa
         cj248adA63TVssdO+9yL+e/44bth0B1R5jW8vLGxyUdvQGZtJFj/dWdbCLBRJuqvywzY
         inSPy8AIVUBKqGfpJ93J+akzgSq35/1E66uH4LZ9n4wgHiaimnwzha40DbhWynuxEDP4
         J34k873MW7YqU/+0dej/zBE1WDTWipSiVz6Y1PGlHVZ4L0pNSDe6CqXEOYSAh7bNGCU8
         gkUg==
X-Gm-Message-State: ALQs6tAh0TgsesN/anZPHWQSSfD8Kv90pSbUeDopFleZM1LiYoxQO4vc
        A8yC4GeTb77pqeU8hdHOmyE=
X-Google-Smtp-Source: AIpwx48O7DlWKGGUk8uLDGzYnQvp3KNcMRECsHqXDpGGi6XIsmifMWTb/ao39rQ1KrxYNm6+goUUZA==
X-Received: by 10.223.225.198 with SMTP id l6mr6561471wri.111.1523724781896;
        Sat, 14 Apr 2018 09:53:01 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egm16.neoplus.adsl.tpnet.pl. [83.21.76.16])
        by smtp.gmail.com with ESMTPSA id u196sm3688948wmf.30.2018.04.14.09.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Apr 2018 09:53:00 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] Compute and consume generation numbers
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <867epjez1n.fsf@gmail.com>
        <07abd2ce-e042-fe3c-b2db-3d2f2aa44de8@gmail.com>
        <868t9t5yjz.fsf@gmail.com>
        <45320265-9fec-cee1-e82c-3ff719bb0435@gmail.com>
Date:   Sat, 14 Apr 2018 18:52:56 +0200
In-Reply-To: <45320265-9fec-cee1-e82c-3ff719bb0435@gmail.com> (Derrick
        Stolee's message of "Wed, 11 Apr 2018 15:58:27 -0400")
Message-ID: <86lgdplogn.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 4/11/2018 3:32 PM, Jakub Narebski wrote:

>> What would you suggest as a good test that could imply performance? The
>> Google Colab notebook linked to above includes a function to count
>> number of commits (nodes / vertices in the commit graph) walked,
>> currently in the worst case scenario.
>
> The two main questions to consider are:
>
> 1. Can X reach Y?

That is easy to do.  The function generic_is_reachable() does
that... though using direct translation of the pseudocode for
"Algorithm 3: Reachable" from FELINE paper, which is recursive and
doesn't check if vertex was already visited was not good idea for large
graphs such as Linux kernel commit graph, oops.  That is why
generic_is_reachable_large() was created.

> 2. What is the set of merge-bases between X and Y?

I don't have an algorithm for that in the Google Colaboratory notebook.
Though I see that there exist algorithms for calculating lowest common
ancestors in DAGs...

I'll have to take a look how Git does that.

>
> And the thing to measure is a commit count. If possible, it would be
> good to count commits walked (commits whose parent list is enumerated)
> and commits inspected (commits that were listed as a parent of some
> walked commit). Walked commits require a commit parse -- albeit from
> the commit-graph instead of the ODB now -- while inspected commits
> only check the in-memory cache.

I don't quite see the distinction.  Whether we access generation number
of a commit (information about level of vertex in graph), or a parent
list (vertex successors / neighbours), it both needs accessing
commit-graph; well, accessing parents may be more costly for octopus
merges (due to having to go through EDGE chunk).

I can easily return the set of visited commits (vertices), or just size
of said set.

>
> For git.git and Linux, I like to use the release tags as tests. They
> provide a realistic view of the linear history, and maintenance
> releases have their own history from the major releases.

Hmmm... testing for v4.9-rc5..v4.9 in Linux kernel commit graphs, the
FELINE index does not bring any improvements over using just level
(generation number) filter.  But that may be caused by narrowing od
commit DAG around releases.

I try do do the same between commits in wide part, with many commits
with the same level (same generation number) both for source and for
target commit.  Though this may be unfair to level filter, though...


Note however that FELINE index is not unabiguous, like generation
numbers are (modulo decision whether to start at 0 or at 1); it depends
on the topological ordering chosen for the X elements.

>> I have tried finding number of false positives for level (generation
>> number) filter and for FELINE index, and number of false negatives for
>> min-post intervals in the spanning tree (for DFS tree) for 10000
>> randomly selected pairs of commits... but I don't think this is a good
>> benchmark.
>
> What is a false-positive? A case where gen(X) < gen(Y) but Y cannot
> reach X?

Yes.  (And equivalent for FELINE index, which is a pair of integers).

> I do not think that is a great benchmark, but I guess it is
> something to measure.

I have simply used it to have something to compare.

>> I Linux kernel sources (https://git.kernel.org/pub/scm/linux/kernel/git/=
torvalds/linux.git)
>> that has 750832 nodes and 811733 edges, and 563747941392 possible
>> directed pairs, we have for 10000 randomly selected pairs of commits:
>>
>>    level-filter has    91 =3D  0.91% [all] false positives
>>    FELINE index has    78 =3D  0.78% [all] false positives
>>    FELINE index has 1.16667 less false positives than level filter
>>
>>    min-post spanning-tree intervals has  3641 =3D 36.41% [all] false
>>    negatives
>
> Perhaps something you can do instead of sampling from N^2 commits in
> total is to select a pair of generations (say, G =3D 20000, G' =3D 20100)
> or regions of generations ( 20000 <=3D G <=3D 20050, 20100 <=3D G' <=3D 2=
0150)
> and see how many false positives you see by testing all pairs (one
> from each level). The delta between the generations may need to be
> smaller to actually have a large proportion of unreachable pairs. Try
> different levels, since major version releases tend to "pinch" the
> commit graph to a common history.

That's a good idea.

>> For git.git repository (https://github.com/git/git.git) that has 52950
>> nodes and 65887 edges the numbers are slighly more in FELINE index
>> favor (also out of 10000 random pairs):
>>
>>    level-filter has   504 =3D  9.11% false positives
>>    FELINE index has   125 =3D  2.26% false positives
>>    FELINE index has 4.032 less false positives than level filter
>>
>> This is for FELINE which does not use level / generatio-numbers filter.

Best,
--=20
Jakub Nar=C4=99bski
