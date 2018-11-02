Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 561E11F453
	for <e@80x24.org>; Fri,  2 Nov 2018 13:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeKBWkR (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 18:40:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46698 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBWkR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 18:40:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id 74-v6so1981567wrb.13
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 06:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5xiJfEFzjW+snB60js6pnnSUrjtBvFYmQ5RPl6Fn4pk=;
        b=PXwZNbG4pxGhcNCDRSj3Or2gBurE3HiaBN1eUYG2AVgy1RfTs5Ornvj5hto5yufLtP
         kXlWolnWBULa8flLCQksO7M9oYlRZmvsqehPl1Z/V/TcKM/XibofBeHfCI5smHe68IFX
         5a38Z3P0E4xeP9aK9jjuL45kqHB+58zNJjAMvjeJfhG+C3SX82JqvFaPWgjkyiB4itmp
         LNOCWphAfA3Q2S6W1rgmg4p8j9SMennZSC/tLBbGsveaOjJT6Asl9If/yE8TgTZdXivS
         93JEE+z/Jwz0zJP7POP0SZi8s0NGsidi4/byjdmv4+21xR6YOVmbHn4aRIYB7LlBJugz
         UA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=5xiJfEFzjW+snB60js6pnnSUrjtBvFYmQ5RPl6Fn4pk=;
        b=t4RdYMLQxhb1qcL/naGm5+orItzOCIy1+vh9Ql7Lxb/Dqhoz2Gx2RMcgBc4fq241He
         KiXxovkAeb5PtHvAAq74qGUuQnW3p2n2itN8lfrz8vGF1xrkoDbs3ykWSBvWdRQ6CGdm
         TKrQUqBf3UmcEGW68uBtot8oJk5VVIxoTZjhKaNPa/XGgiFkd5Pta0MDRVBYHhPmqiSl
         5tIXChnuPa0W8/5J25ZKHZgr090eC39X7knFKO3bj76aLB7EFkN7tJDAinofs9OCXd0x
         60bbgNwxyB/hERw3jo/ulXvRa0vfOznqKjq5MeijNRdtRBQNMrbV0uwlaL0LaTBQF1SS
         bUgg==
X-Gm-Message-State: AGRZ1gKlfJc0yC4lq1Ahd+PT311pPpxIPMyC/z7puNYbhH8emjCcdaAE
        DYhQ0wuD1P4uuGKx0MsEmrk=
X-Google-Smtp-Source: AJdET5fnNbxo3P4yCq5Y3a8uAyQeED1Kvr2nINcpMKJODtNZz/ZH4E3/d7Z13ZCv9WlG2v59+vcmZg==
X-Received: by 2002:adf:b453:: with SMTP id v19-v6mr9320208wrd.47.1541165585842;
        Fri, 02 Nov 2018 06:33:05 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ekn166.neoplus.adsl.tpnet.pl. [83.21.181.166])
        by smtp.gmail.com with ESMTPSA id j72-v6sm23617088wrj.7.2018.11.02.06.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 06:33:05 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Generation Number v2
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
        <xmqqy3ag13us.fsf@gitster-ct.c.googlers.com>
        <61a829ce-0d29-81c9-880e-7aef1bec916e@gmail.com>
Date:   Fri, 02 Nov 2018 14:33:03 +0100
In-Reply-To: <61a829ce-0d29-81c9-880e-7aef1bec916e@gmail.com> (Derrick
        Stolee's message of "Wed, 31 Oct 2018 08:30:29 -0400")
Message-ID: <86tvkzy580.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 10/29/2018 11:59 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
[...]
>>> * **Compatible?** In our test implementation, we use a previously unused
>>>    byte of data in the commit-graph format to indicate which reachabili=
ty
>>>    index version we are using. Existing clients ignore this value, so we
>>>    will want to consider if these new indexes are _backwards compatible=
_.
>>>    That is, will they still report correct values if they ignore this b=
yte
>>>    and use the generation number column from the commit-graph file assu=
ming
>>>    the values are minimum generation numbers?
>>
>> I personally consider that the current commit-graph with generation
>> numbers experimental, so I am not sure how much we care about this.
>>
>> Having said that.
>>
>> By the above definition, any new index that is wider than the
>> current generation number cannot be compatible (can we even tell the
>> existing clients how wide each elements in the ix array is?)
>>
>> In any case, perhaps the first thing to do is to update the clients
>> so that they stop ignoring the version number field, and instead
>> work without generation number when there is no version of reach.ix
>> available in the file?  That way, a better reachablility index can
>> be chosen freely without having to worry about the compatibility.
>
> I can work on that. It should be as simple as setting commit->generation =
to
> GENERATION_NUMBER_ZERO in fill_commit_in_graph when the graph
> has a different version.

That is a very good idea, but we have here a chicken-and-egg problem.
The only way to denote that the generation numbers / reachability index
have changed (for reading/using: that it changed in backwards
incompatibile way; for update: that it changed at all) is to change the
format version:

  1-byte version number:
      Currently, the only valid version is 1.

But if we assume that different commit-graph format version simply means
that commit->generation is to be set to GENERATION_NUMBER_ZERO, then we
block possible changes to the structure of the commit-graph file.

[Reads further in thread]

Ah, I see that's why you want to introduce [1]:

DS>
DS> 3. Reachability Index versioning

[1]: https://public-inbox.org/git/6902dbff-d9f6-e897-2c20-d0cb47a50795@gmai=
l.com/

>>> * **Immutable?** Git objects are _immutable_. If you change an object y=
ou
>>>    actually create a new object with a new object ID. Are the values we=
 store
>>>    for these reachability indexes also immutable?
>>
>> Even if we do not embed the reachability ix in commit objects,
>> having an immutable value is probably a must if we want to make them
>> incrementally computable, so this is a very good property to have.
>> Unless there is a clever idea to incrementally compute a mutable
>> reach.ix, my gut instinct says that this property is a must.

I think that the reachability index can be mutable and non-local, but
still being able to be incrementally updated, though perhaps it would
require not only calculations for new commits, but recalculations for
some limited subset of commits existing in the commit-graph file.

I'm trying to modify exact definition of maximal generation numbers to
check if I can find out a version that exhibits nearly-incremental
updates property.

>> Another thing, perhaps related to "local" below, is if exactly the
>> same reach.ix is computed by anybody, given an identical commit
>> history graph (perhaps "reproducibility"?).  I think most of the
>> candidates you listed are reproducible without a fixed tie-breaker,
>> but I am not sure about felineY() thing.

felineY() is deterministic (or can be made deterministic) for given
felineX() (i.e. given [reverse] topological order).

>>> * **Local?** Are these values **locally computable**? That is, do we on=
ly
>>>    need to look at the parents of a commit (assuming those parents have
>>>    computed values) in order to determine the value at that commit?
>>
>> A subset of non-local reachability ix, for example, the ones that
>> need to know what each commit's children are, cannot be immutable,
>> as adding new objects to the graph (either with locally committing,
>> or transferring objects from other repositories) would affect the
>> ix; is this true for all non-local reachability ix, I wonder?
>
> As a thought experiment, we could define a function size(C) to be the
> number of commits reachable from C.

Let's call it reach(C), instead ;-)

>                                    This is not locally-computable
> from the size values at C's parents due to the inclusion-exclusion
> principle. We would need to compute it by walking the reachable set
> and counting (resulting in quadratic performance overall) but is
> immutable. Since the performance cost is so expensive (unlike the
> linear costs in the other non-local versions) I didn't include it
> in my comparison.

Let's define Reach(C) as set of all commits reachable from commit C.
Then reach(C) =3D ||Reach(C)||, where ||S|| is number of elements in the
set S.

If commit A can reach commit B, then B =E2=88=88 Reach(A), but also Reach(B=
) =E2=8A=82
Reach(A), thus reach(B) < reach(A).  Therefore if reach(A) <=3D reach(B)
then A cannot reach commit B -- reach(C) can be used as reachability
index.

However the performance cost of calculating reach(C), i.e. full
traversal of the commit graph without ability for incremental update
(well, you can do incremental update starting from the commits that have
reachability bitmap [2]) is prohibitive.  Never mind the fact that this
index would have, I think, the same performance problems as (minimum)
generaton numbers.

[2]: https://githubengineering.com/counting-objects/


SIDENOTE 1: as gen(C) can be thought of as the lower boundary on
reach(C), similarly sumgen(C) defined as being 1 for parent-less
commits, and being (sum_{P =E2=88=88 parents(C)} sumgen(P)) + 1 otherwise b=
eing
the upper boundary on reach(C).  This sumgen(C) can also be used as
generation number / reachability index.

   gen(C) <=3D reach(C) <=3D sumgen(C)


SIDENOTE 2: The idea of using a proxy for Reach(B) =E2=8A=86 Reach(A) as a
negative-cut filter (negative-cut reachability index) is used in two
types of reachability indices: one is Independent Permutation Labelling
(IP+) [3] approach, the other is Bloom Filter Labelling (BFL) [4].  Both
algorithms are local, and with given permutation (which can be replaced
by object ID, I think) for IP+ and given set of hash functions etc. for
BFL they are both immutable.

[3] Hao Wei, Jeffrey Xu Yu, Can Lu, Ruoming Jin "Reachability Querying:
    An Independent Permutation Labeling Approach", Proceedings of the
    VLDB Endowment, Vol. 7, No. 12 (2014)

[4] Jiao Su, Qing Zhu, Hao Wei, Jeffrey Xu Yu "Reachability Querying:
    Can It Be Even Faster?", IEEE Transactions on Knowledge and Data
    Engineering (2016)


Best,
--=20
Jakub Nar=C4=99bski
