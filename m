Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91CA920286
	for <e@80x24.org>; Fri, 15 Sep 2017 10:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdIOKXm (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 06:23:42 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54446 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOKXl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 06:23:41 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MDpjK-1ddvfl2R7m-00H53T; Fri, 15 Sep 2017 12:23:35 +0200
Subject: Re: [PATCH 2/3] merge-base: return fork-point outside reflog
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Jeff King <peff@peff.net>
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
 <cover.1505394278.git.git@grubix.eu>
 <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
 <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <cd97bb1b-13f3-0856-a250-8f4921b9f6d8@grubix.eu>
Date:   Fri, 15 Sep 2017 12:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:aGyv8yEh0orfe6npsg6ogNe5WtxV+hKn/rguJHQN1Is2SXr2czs
 ECWM22G3gNjDstfCvVNhOnKKbLe3oLzfH+2tFGtuNDCEyTlU0tWaIbkQKu019DY7UViGNEM
 PvteDMmn6o8lCx96ZWzvM7OTJqHs2FzV28R0Ju3spJy2xa2YHo4yjlePBnWMmfekYoy5goO
 ZEt88dCyK2yfK3ltcS5lw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VaGCXTRoIc8=:0/YvRpeBjI/ABeyqnnfqbb
 noc1q2Ye69qrOt2+Mtem8BQ6yPdLp4OTM68DU5dbO0JE0HDRP1rXk58IDLX+TWekwWvyHgjcy
 QtRhpagWLpip0ppemrDx0vmznYKfeqnGLVsLV/xUrKCnzcnDeMupVKdJuFl52AV1Z2XjHTzze
 tBwwkl/dSGcUrC9ds4t9L0swBksPW1IpKEx68vqAkhzhadGmCic+vZkWgdleveuBOj8VEqoSw
 DwguAE+sl0K+yFzR3XUsScnKbCjgrc5hSJFI3uSLWsp1eeGQcUuY8zeQnJlVxlqXGIqVcSm2S
 Odo4HllePdcEDPqXljSLDHN7Z8VtfeB8lyuXWF3KfIOG6Ae2du9Es57hxVdgiIxwvHa3AD15F
 TmYiD3yIi0EBc/BQx7awKzKSJHFvK6J4Je7XqjROSK6QCLl4msRIyPA6Fsc5du5VOOA0rsHpj
 w3EEVwYEC6tbUI+lp3SrqOsWMbT5dABQVifIOeg1yqOZlNejAO6GPtMfwA8mibI4b/m+OonQ8
 1AtmvBuJTskDIW3D4JBJ/7Q6qIO0bH0+/4zD2hSQMJL0h8y8bFgtAHlxbWLthieZ0BqT23XBq
 1GPnsc44H4Wu/wU4RoQdhx2ITaUQL51XBmfKPuSnDqQFoZO3kywNb8nelPBC0n/S2MBHIhR/I
 XSKZmSyKO79WGHTmj1nm2VQDliFC0DHGGKrjC0bkaXj76eh7DoKya3M3LyTxXIjtESweq0EFx
 gGUYkdYHU5IEGu8Ul4t3PJO4FgiJTgjUZpmI4mp5QBAZ9ubkiV+0VtKtrRA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 15.09.2017 04:48:
> Michael J Gruber <git@grubix.eu> writes:
> 
>> In fact, per documentation "--fork-point" looks at the reflog in
>> addition to doing the usual walk from the tip. The original design
>> description in d96855ff51 ("merge-base: teach "--fork-point" mode",
>> 2013-10-23) describes this as computing from a virtual merge-base of all
>> the historical tips of refname. They may or may not all be present in
>> the reflog (think pruning, non-ff fetching, fast forwarding etc.),
>> so filtering by the current contents of the reflog is potentially
>> harmful, and it does not seem to fulfill any purpose in the original
>> design.
> 
> Let me think aloud, using the picture from the log message from that
> commit.
> 
>                          o---B1
>                         /
>         ---o---o---B2--o---o---o---Base
>                 \
>                  B3
>                   \
>                    Derived
>     
>     where the current tip of the "base" branch is at Base, but earlier
>     fetch observed that its tip used to be B3 and then B2 and then B1
>     before getting to the current commit, and the branch being rebased
>     on top of the latest "base" is based on commit B3.
> 
> So the logic tries to find a merge base between "Derived" and a
> virtual merge commit across Base, B1, B2 and B3.  And it finds B3.
> 
> If for some reason we didn't have B3 in the reflog, then wouldn't
> the merge base computation between Derived and a virtual merge
> commit across Base, B2 and B2 (but not B3 because we no longer know
> about it due to its lack in the reflog) find 'o' that is the parent
> of B2 and B3? 

Yes.

> Wouldn't that lead to both B3 and Derived replayed
> when the user of the fork-point potion rebases the history of
> Derived?

Replayed, yes. What that means would depend on how B3 ended up being
"off base" (reset or rebase, e.g.): the replay could lead to a reapply
without conflict, or with conflict, or an empty (discarded) commit,
depending on "how much of B3" is still "on base".

> Perhaps that is the best we could do with a pruned reflog that lacks
> B3, but if that is the case, I wonder if it may be better to fail
> the request saying that we cannot find the fork-point (because,
> well, your reflog no longer has sufficient information), than
> silently give a wrong result, and in this case, we can tell between
> a correct result (i.e. the merge base is one of the commits we still
> know was at the tip) and a wrong one (i.e. the merge base is not any
> of the commits in the reflog).
> 
> If we declare --fork-point is the best effort option and may give an
> answer that is not better than without the option, then I think this
> patch is OK, but that diminishes the value of the option as a
> building block, I am afraid.
> 
> Callers that are more careful could ask merge-base with --fork-point
> (and happily use it knowing that the result is indeed a commit that
> used to be at the tip), or fall back to the result merge-base
> without --fork-point gives (because you could do no better) and deal
> with duplicates that may happen due to the imprecise determination.
> With this change, these callers will get result from a call to
> "merge-base --fork-point" that may or may not be definite, and they
> cannot tell.  For lazy users, making the option itself to fall back
> may be simpler to use, and certainly is a valid stance to take when
> implementing a convenience option to a Porcelain command, but I do
> not know if it is a good idea to throw "merge-base --fork-point"
> into that category.

Simply put, "git merge-base ref commit" looks at the (graph) history of
ref and considers merge-base candidates that are also in the graph
history of commit. This is the "graph notion" of merge-base, and the
result is immanently determined by the DAG.

There is also the "reflog notion" where you look at the "reflog history"
of ref. The result depends on the reflog, which itself is "volatile"
(think prune), and such is the result.

Now, the original documentation of merge-base says that "merge-base
--fork-point" looks at the reflog of ref "also" (*in addition to*) the
DAG. That is, the merge-base candidates for "merge-base --fork-point"
are a super-set of those for the plain mode, enhanced by the reflog.
(graph notion plus reflog notion)

The original implementation makes sure that "merge-base --fork-point"
looks *only* at candidates from the reflog. (strict reflog notion)

That is a discrepancy that we should resolve in any case.

Note that with a "complete reflog", the set of reflog merge-base
candidates is a superset of the one from the DAG.

I did not look up the discussion preceeding 4f21454b55 ("merge-base:
handle --fork-point without reflog", 2016-10-12), but if "merge-base
--fork-point" were about a "strict reflog" notion then there was nothing
to fix back then - no reflog, no merge-base candidates. Period.

I don't mind having two modes, say "--reflog" (strict reflog notion) and
"--fork-point" (reflog plus DAG), but the current implementation is
neither, and the current documentation clearly is the latter, which is
what I'm trying to bring the implementaion in line with. Strict mode
would need a revert of 4f21454b55 (which adds the tip of ref if the
reflog is empty) for that mode.

Michael
