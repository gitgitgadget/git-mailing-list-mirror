Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E93D1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 12:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbeDPM3H (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 08:29:07 -0400
Received: from mail.javad.com ([54.86.164.124]:54436 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753697AbeDPM3G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 08:29:06 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 17B763E8B8;
        Mon, 16 Apr 2018 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523881745;
        bh=6cybMc+SKNLRR/+7jI6xC2xX4L7ho5x7GO0nZVha9pc=; l=3190;
        h=Received:From:To:Subject;
        b=LPgVt0SFntTE4Al46SPxqg2XS9Sf6y6DgQsrgO90ZZC05antuXicQjOCdqrDTLgi8
         bw2mTGguHnGc6YUp0DzcTVdjTTSfc1ZyF1vocz4Hz0sxgBwCUtrGyE+pw/s9Rd/WBM
         c2sJCfPHVKQ9BOWCh1E4iBKlwN3qDiuaF+eYAvQY=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f83Fm-0006tC-RF; Mon, 16 Apr 2018 15:29:02 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: Draft of Git Rev News edition 38
References: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
        <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com>
Date:   Mon, 16 Apr 2018 15:29:02 +0300
In-Reply-To: <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com>
        (Christian Couder's message of "Mon, 16 Apr 2018 10:55:12 +0200")
Message-ID: <87in8rz65t.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

Christian Couder <christian.couder@gmail.com> writes:
> On Mon, Apr 16, 2018 at 12:11 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> A draft of a new Git Rev News edition is available here:
>>
>>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-38.md
>
> The draft has just been updated with 2 articles contributed by Jake
> about rebasing merges, so I am cc'ing more people involved in those
> discussions.

I find this section of the draft pretty close to my own vision of what
and how has been discussed, except for a few issues.

[all quotations below are taken from the draft]

> Some discussion about --preserve-merges and compatibility with scripts
> (i.e. should we change or fix it? or should we deprecate it?)
> followed.
>
>    Rebasing merges: a jorney to the ultimate solution (Road Clear)
>    (written by Jacob Keller)

What article by Jacob is actually meant here I have no idea, please
check, as this one, and the RFC this refers to, was written by me, not
by Jacob, and it is the outline of potential method of actually rebasing
merges that is discussed in the next paragraph, so it likely belongs
right after the next paragraph:

> After the discussions in the above article Sergey posted an outline of a
> potential method for actually rebasing a merge (as opposed to recreating
> it from scratch) which used a process of git cherry-pick -mN of the
> merge onto each topic branch being merged, and then merging the result. 

The reference to:

    Rebasing merges: a jorney to the ultimate solution (Road Clear)
    (written by Sergey Organov)

belongs here, if at all.

In addition, I'd like to see a minor edition to the following:

> Sergey replied that he thinks the solution produces the same result as
> his updated strategy.

This has been said in the context that assumed lack of conflicts during
application of both strategies. Something like this, maybe:

"Sergey replied that he thinks the solution produces the same result as
his updated strategy, at least when none of the strategies produce any
conflicts."

Next, this is very close, but not exactly right:

> Further suggestions to the strategy were proposed and tested, ultimately
> resulting in Sergey proposing the addition of using the original merge
> commit as a merge base during the final step.

This was not an addition, this was a fix of particular mistake in the
original RFC that has been revealed during testing. I didn't get it
right at first that it's original merge commit that must be used as
merge base, so my original proposal ended up implicitly using wrong
merge base, that is the one computed by "git merge-base U1' U2'".

Something along these lines may fit better:

"Further suggestions to the strategy were proposed and tested,
ultimately resulting in Sergey proposing the fix to his method,
specifically using the original merge commit as a merge base during the
final step."

I'd also like a reference to the final fixed [RFC v2] be added right
here. The reference is:

https://public-inbox.org/git/87r2oxe3o1.fsf@javad.com/

Thanks a lot!

-- Sergey
