Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B326C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB78D206D9
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="A2hUVsOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391801AbgJOTjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:39:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:58961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391799AbgJOTjj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602790773;
        bh=mbP0de/Cf06S8Q4xBnAuC4roNA9wrfMRhuxnLoXYNmY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=A2hUVsORNJkwKlEOZTR7/MxFEfUXXU3AZgg/yOaQSlS1hIIPc7n5qAT1mETWPwZzA
         njLn7UlWhK0RNxuz/ufTLbUJSVvdcWFdDaZ7CbCyPY9Yc5v5Nja61HAJMVnMh2Rq4T
         Okt9f9H0ecXGhJrvfVSoST8coQ5eLnYjZysXcQjU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.212.47]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1k0Nun1kfA-00kPyf; Thu, 15
 Oct 2020 21:39:33 +0200
Date:   Thu, 15 Oct 2020 21:39:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ci: skip GitHub workflow runs for already-tested
 commits/trees
In-Reply-To: <xmqq4kmvh0i1.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010152134590.56@tvgsbejvaqbjf.bet>
References: <pull.619.git.1587748660308.gitgitgadget@gmail.com> <pull.619.v2.git.1602170976.gitgitgadget@gmail.com> <914868d558b1aa8ebec6e9196c5ae83a2bd566bf.1602170976.git.gitgitgadget@gmail.com> <20201009072922.GC24813@szeder.dev>
 <nycvar.QRO.7.76.6.2010091254180.50@tvgsbejvaqbjf.bet> <20201010072508.GD24813@szeder.dev> <nycvar.QRO.7.76.6.2010111221350.50@tvgsbejvaqbjf.bet> <xmqqy2kbqv7b.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2010122044460.50@tvgsbejvaqbjf.bet>
 <xmqq4kmvh0i1.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cpBPzEeMijz6GA6Iv5WJJCrgL49w2Hna1MIYyF1iEFz9Cb9KNBC
 nwG2fYKYlWSKVFBQtAMS3G32UdiO8bIZdfXZs5L5d3ozm4XrzqFQvNpN2ttxxYXdPN2bIVk
 uiPV+8sjEdA6BbsCeBS3SxVpeevTMIogfheW+P5DffMbXIvFUnXy9NzJD1HzkX1BZeKptkU
 qvgK/OIUeM37dywKczl4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:198v3kr5xKA=:ymQPXHCP1adLO+K5eL7zvE
 ehDkdsdCEH6rj1HhstLeHUBi1CPuYTDYrUVK3NtnPzAKjuHoz+aWz8+19w2wXz2Os72MR4Ck8
 +2Kmlq9jDkpxJB/SSV+Mgllg4mp7eONXHDTzO5Gt/z7HTOmzck6kuvPIrhY4nfUrBq1AgqWtr
 LKGBVvKnEGGZLh0om3aauiar/uXpsoOksSehyjXx+bk/t42HLIRPZKEJgkoIwbcbNTOR9iVlA
 LfaVZt2+165O7YZ5i/kFQ8Le/XAIbPLTmCdLkIaoOiOoLrRJWwqlU5Y2mNUtq0AEX1yMbOmQY
 ntbq6lqxtS7G4P/BA0hLxjD2mf/HjSNqgwWAIH1bWKZ877iUuJrsqtILzrpIlNelrWp7Zsnd6
 aXtDr38GjGS/HJ9Tf0HhLazpqCxqgCW8ySZinWtjRu4WhPLSAt5B+evVvzrQSLdgGlzhOZXMn
 gKRpVhW8g61bkwWqsnd9lPVi0+n+CeqtfuUKOfTHUN1NhU7/WdhmdoX1vF5mzc1Bo1nSfrA2A
 JJR8EeXwMPQNRT2NAqfd91pp9QXsdSwhcXmY5umOnUY8wQ2Ez7EHpLNeNFgDDoOLqKKA/IWDT
 tKegge0gbcW+s/gwKVtK8H0vRXR8/h8f/QsQBBMeqnIRgBbCWJAKR0Kh/HtvQDEDnauJd8EYT
 TZNcCiH98PxhfoVZSJDP47Y4OpsL5Gr0s8ifWp8FyX6Z4yHb41vKgPB+9zQMMp6grSJFfARNp
 8yc/KS0F5MNXJ8bLGShL3ap8ww3mPf3xtLEx/ZsyANa3qZOc618AE1z/x9kXA5F/Oa9/vD+ro
 p0MAHnMxsrnNlWWzIMxnQzcsSMh55tjR2yuV+kU94pXMITwtPdrfgXfs4CLnVpQFnWsOFfV47
 Hxdk8c2QY8rpiTbH8hsk8/iD6K6HKvDELoOquJI7E=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 15 Oct 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Full disclosure: I am not even sure what to do with Travis support at =
this
> > stage (but then, I am not the one to decide over that).
>
> Are you talking about the migration to travis-ci.com and having to
> give them potentially more access to github.com/git/git/ repository?
>
> It does worry me, too.

I meant that, together with worries about the future of Travis CI given
that they've been acquired by Idera.

Ciao,
Dscho
