Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_12_24,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49863C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 14:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2725320721
	for <git@archiver.kernel.org>; Fri, 29 May 2020 14:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lUiceDaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgE2Ono (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 10:43:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:53469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgE2Onn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 10:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590763406;
        bh=YBXIH+GiMgxh37wEPGmlA7eQAnzMoKD6ZoUvPp2oEPM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lUiceDaQWlu0qJrjrhqI/Aj3DImBTiLfuHpGv9gh19E2k5yE0+V8+HiMilKF5H/hk
         luJSssNhhjjLUeXTdLMt07koDpMazR1Z9r2T/P02fBZzwpYcH/+07Tq2gqeUwBvqNB
         xykQjTDMrrEx/4f06hq1s4vKl8oD0jwn2Y56hmiE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.207]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmUHj-1jEB391Bxp-00iViG; Fri, 29
 May 2020 16:43:26 +0200
Date:   Fri, 29 May 2020 00:09:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PoC PATCH 00/34] An alternative modified path Bloom filters
 implementation
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005282359060.56@tvgsbejvaqbjf.bet>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-533838093-1590703786=:56"
X-Provags-ID: V03:K1:n4c5tL025FF87XWeEFg1vJ+vaF9JYwCVyDOAkZK1ST/2mAV3zHk
 OOmKhG9il+2NxtIktyZ9K7Q227x5prowOmYC08kSEuRx1EsWL0xhBDBVsV/Nz9nUKI/o3fe
 5Q2MizgR4819BU2XcafG4jxbJoX9kgZc6+FWWnK/bKXal1r5wiqPcm0QAbVGB543qfvW3pu
 EZPWdKVngv6lTQvhCKi1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O9hZAQYYahI=:mtie1UTmYyXROGAuvTZt1n
 NI8tj4eQN5UXQZjJBkz1sdT5YbnsbJTjeN4jHsS5FmZ/U7mVFQcV37+md4Fc5ZK3le5jihYG8
 wAhSv0D1yPFBD0/WIAFIqzyJ6im/a1afvrooKDF6pst28K0iuQvkFUB8kuAbeAdPUbuSMsPq8
 G7hNmz+2MljfRvgYtVqGcLbFa1I3YT+KeaTkRDQgj6gY/F4GIV+50b/1xi+FcgnyWtjqDnxRm
 oWEEdyEFeBYuAFaKVeiYuN0qQ8DSCsfgLV6bWKjXUB9/e0JEqG06oIxLTPktvqWtxg/PdEC1f
 McaBDz2crocy1QWL2iDJ3f6pSX6Mvsracg+sEHmX9soYNZORdEsQ8unDDorkFGEcO2aUcl4qg
 WmU54PbAk0O20xBMezPwDRsqUjg4Sisa8ZeC0exaCXXfw+NRk7QdPmReTIlC/ez5UBnNBxryM
 nSYUC2I82PDHHk24hpk27dQzJ/4OPawsczOXn51Gf3ZwRmQ0kuJ53vvDxTSSFOPCcZRonIlqF
 qKMq56H4K/idWLI2uJ34rrsUspsUyID7kQjtlBzTxLox3O+/djF/l+lrIwng2LrJ0B+9JMqda
 DuQwm92czUsnlVkTiM94Plvu7E28XLSt1SYNkR2r2lgB1UuFZPyKELf8CzyVa5J50svLQHbIs
 jdKSub7P0g1ssl8/BbjWAF5YZ2Uo6iXQMr7BOE02CdLK2bN2JjOCqF/rBUl7aCFc36yFnqEPD
 uUoBGr8FbjxN1cFD3JiO/jzj11FEQoEZEc28cxLjkJEeWrOF8RMrqrStJDb8AItea4mdu6qwK
 0uV8rv6Le5wC8jlipXTFpdCcCuS20PiNpgAI3FCJdP1nvP5NvzIIw8csEuui8ybkelKG63J88
 bvKnMqFN0HlfYXXeTR8HyHYrfby/sa/DmpnFeEsYu0miQ8pEtGEoqUqCJg1p4sv5rwKdpSnQj
 IEFsI3ifEUjYBOjzS/frNzlKMl+FpNhAos5UaM0vgKPSWgZb/sHN4WbP7ddBU/NcqeDUAEEJN
 N6FXPe9jGfvMqxhkOEUc//XM0sV2XppAOq0zkCSWekkbBjb25NTzrhiwC6X9j5UfwqiYNnQ+M
 50MUrYFobNAgLGn3J0Knzxybcn2wRx4UuBhvW9jQF1ZOTvDmR/irleuKSaY8pL/hXxNy82D3j
 4DisQSCeE0D2cL0MeIvwk6Aw/YjoKdTIsDEVYJG9WlJXTyqP4otL+NwRHeB2Xhk0j04E5GlpX
 M0XAvhobnNU2bGE0y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-533838093-1590703786=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Fri, 29 May 2020, SZEDER G=C3=A1bor wrote:

> Sigh...  but better late than never, right?

Well, incremental patches on top of what is _already_ in Git are _even_
better.

> I experimented quite a bit with modified path Bloom filters a year and
> more ago, and got quite far...  but my disappointment in the
> inadequacy of all double hashing schemes, the arrival of split
> commit-graphs, and, well, life in general has put the whole thing on
> the back burner, and I haven't touched it for a couple of releases.
>
> Now I finally managed to take a closer look at the current changed
> paths Bloom filters implementation, and saw that it has some of the
> same issues that I had stumbled upon and that it missed some
> optimization opportunities.  Unfortunately, fixing those issues and
> performing those optimizations do require a thorough format change.

Thank you for this background information.

Your claim that there are opportunities to optimize, as well as your claim
that it requires a thorough format change, strike me as best backed up
with evidence by porting your optimizations on top of what is already in
`master` and which has been reviewed _already_ (as opposed to your new
patch series, which essentially threatens to throw away all the time
people spent on reviewing Garima's patches).

> So here is my proof of concept version, in all its incompleteness,
> with the following benefits:
>
>   - Better understanding of the problem it tries to optimize.
>   - Better understanding of the issues with many small Bloom filters.
>   - Better hashing scheme (though it should be better still).
>   - Orders of magnitude lower average false positive rate.
>   - Consequently, faster pathspec-limited revision walks.
>   - Faster processing of the tree-diff output and lower memory usage
>     while computing Bloom filters (from scratch...).
>   - Optional support for storing Bloom filters for all parents of
>     merge commits.
>   - Deduplicates Bloom filters.
>   - Supports multiple pathspecs right from the start.
>   - Supports some wildcards in pathspecs.
>   - Handles as many commits as the commit-graph format can.
>   - It has the right name :)  The diff machinery and all its frontends
>     report "modified" paths with the letter 'M', not "changed".
>   - More cleanups, more bugfixes.
>   - Consistent output with and without modified path Bloom filters for
>     over 80k random paths in 16 repositories, even with submodules in
>     them.  Well, at least on my machine, if nowhere else...

It strikes me as an obvious idea to make all those improvements in an
incremental manner.

> Alas, the drawbacks are significant:
>
>   - No tests whatsoever.
>   - Computes all modified path Bloom filters from scratch when
>     writing, no matter what.
>   - Doesn't work with split commit-graphs.
>   - Basically if anything works besides 'git commit-graph write
>     --reachable' it's a miracle.
>   - Not a single test.

You said that already in the first bullet point. But yes, I get it, there
are no tests.

>   - Many BUG()s, which should rather be graceful errors...  though I
>     have to admit that at this point they are indeed bugs.
>   - Many TODOs, both in commit messages and code, some incomplete
>     commit messages, crappy subject lines, even missing signoffs.
>   - Some ridiculously long variable, function, macro and config
>     variable names.
>   - It's based on v2.25.0 (no technical reason, but that's the version
>     I used to run the baseline benchmarks the last time, which takes
>     days...)
>   - I'm pretty sure that there are more...
>   - Oh, did I mention that there are no tests?

Ah, your patch series has no tests.

Please do understand that it can be perceived as quite frustrating that
an alternative is presented _this_ late, when already such a lot of effort
has gone into not only iterating several times on the patch series but
also into reviewing all of them.

I don't really think that I want to spend the time to review this
alternative (not that I am an expert in the space) because it would imply
that I help invalidating the effort that went into the current
implementation.

All this is to say: I appreciate your efforts to improve the path-based
Bloom filters, at the same time I wish that those efforts would happen in
a collaborative manner instead of simply dismissing other people's work.

Ciao,
Johannes

--8323328-533838093-1590703786=:56--
