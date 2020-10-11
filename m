Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6BEC433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 09:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035E02080D
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 09:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QCHbbfu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgJLJi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 05:38:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:38795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLJi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 05:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602495507;
        bh=vZTQYLay7cHGYpqPgLxO6RhEyd8auk6zOkzpUv3Bl4c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QCHbbfu9AD+4Lm1jcaViGMoYrIo5+OemIVvDztUhC8OgHkCbw8LrE7k/xiZunLQra
         ZJMe/ZIPfYqs1l06LjgZC4ge8weLKki/NFUrmYoxkn3/KHd+qe4enmwdXCenjdFmyX
         fvU4cJNwZC4cIcROwAT8XwWx9KN/fnbG9jqHnS9g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.215.146]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MO9zH-1kqTZz3geP-00OXmj; Mon, 12
 Oct 2020 11:38:26 +0200
Date:   Sun, 11 Oct 2020 12:28:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ci: skip GitHub workflow runs for already-tested
 commits/trees
In-Reply-To: <20201010072508.GD24813@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2010111221350.50@tvgsbejvaqbjf.bet>
References: <pull.619.git.1587748660308.gitgitgadget@gmail.com> <pull.619.v2.git.1602170976.gitgitgadget@gmail.com> <914868d558b1aa8ebec6e9196c5ae83a2bd566bf.1602170976.git.gitgitgadget@gmail.com> <20201009072922.GC24813@szeder.dev>
 <nycvar.QRO.7.76.6.2010091254180.50@tvgsbejvaqbjf.bet> <20201010072508.GD24813@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-305546987-1602412115=:50"
X-Provags-ID: V03:K1:ZnqFnaarUFfNfuicJBXMDdtBZQEpVcAD/8/VBvr97y8N2SqFT7R
 KFIWRKzJQiZq0aaMCbBE3dMcMgeWDrvddNF5nooZyyJYVrgMkL9M72/6MJ9zHOXVz9+Hlae
 RNEstmaQkez4Wnn6xpSezljfL1uPyIzNfWnNvwhkTm12J66ClhW2ThT5NM4GgxWvDqoGdbt
 IJ01QdGMvZKu0HF/wo51A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sZifHWlhDbM=:Fnf3MwaEr5m3a8nGDYzVUw
 3OnlODV8nYRNtQqWQvtd4evPzJBovnwTD7fnc0hFoKQRDw7hqMy52r8kpg2xnZeqNPrcZq55U
 LE+6daxL2Dd2tKSkp5IDUZIROrCAVglDgO6KBbpug97HXcB5a84WgqJspJF3irTAjYUvWgouX
 VUTxJ8yrAWRrlGE28YfZKh34q9A9ZBkF9LtOj6oWEfx9eKwWk/CktmnRKkJfrBpuSS4NjISCT
 1TuO3TYHMHV1wRxakjQgVgVA1g5DbH2wVQFCzAMyFqHA3tGT/rIHLSb1ZyrCoK//9nsvndgRq
 cUoRtcOdJpdQ6cwXLB1gtr5maBvRvB/pYdm5y9L+Niod+7C90wOWcRB5pIiObXKDAjVVKqozW
 7r2yjD/DHyN+k1i55wu5DjsJaTmhiHVqz3XvSHC8Q5EUmS3TW7Rr5Pz1BMBQ0pQG/prjTO0qw
 l3ZWyPBXEuMer12fwI4HH5JwZx85PW2vGQv0KUlIUq+5CimSowUyHTaYF0JJOKyGuwwRPlJ8x
 aKdpixRcqIvJotcLC+512gSEa+6fAUAIkhNKkH1JjapmFr42+OQ4Xwoxw3E+kOd/OZxsxupWA
 4vDZQscabpz+tPwJ7QkBsb27Zwlw1EhP3t3kamYZ0yNR395d1WH8TiwLa+X4obpR7POqKOPC5
 ikfxlz6VQI4ySbeXtqx/3MXDBfNwOY2G5Mr7WRArjQlK6/2mEcwTzf1KMZZrYApkO3+s3yFbH
 laxfUtXOjbhMfCdnT+l/VrL3d8So8/BnDQL4BT7cRAdzk/0udTUedwK1KAwPlkBDH/sOgP5oj
 GPdqO5ZXidVjIse34gYGXx9NS80khOBpZ5AXoxXpGzLhduh1BP7vwzHYfqEW7gB9Z2jcKySAW
 qHb5AZjEcOFeGGVBWz466SipG2e/jDa5xS/CBIvDrbmMq/BqJb6qmgtTNmHzTfK4fziWoACEO
 XUYf7dEAiwY4Ve7RAuoUKVz62/Ena1KKyHUmOve4R0UgHtVAvEH6NV4AnFZSj9NoHr4IQoci1
 wQQRMqV3bNKkQ1S4Ezoiqd2AFz2k5YIc2jklo54JzTC3eUApBPvYUSqyAGKpJM/KxcruTMp/G
 G8c7SK8HEUdbOk7BndKBv30ZYJAXZ5FqfQRVg733uCDoKovRVJ1AGkE184zsALRFrILOVc5w0
 8aplnttB37XDI5cg5NIAUokzkqqgkIjiMU5uTgN/XafpxRuJficz5n3LfjTRTIBsfIZjmumAr
 At5IS7T9tWYwGm9hcsr+Sg5hevMhPrB+HkkA31w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-305546987-1602412115=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Sat, 10 Oct 2020, SZEDER G=C3=A1bor wrote:

> On Fri, Oct 09, 2020 at 01:13:03PM +0200, Johannes Schindelin wrote:
>
> > Since this strategy relies on a Travis-only feature that does not work
> > on the three other CI services we use (Cirrus CI, Azure DevOps, GitHub
> > Actions), I see little point mentioning it in this commit message...
>
> This commit duplicates already existing functionality, so, yes, the
> commit message should definitely have explained why that already
> existing approach was not suitable for GitHub Actions.

No, this is not duplicating functionality.

The `skip_good_tree()` function requires a persistent directory into which
it writes a record of the trees it considers good, based on past runs. It
later recalls which trees are considers good and skips the current run if
there is a record for this tree.

The fact that it requires a persistent directory binds it to Travis CI. As
far as I can tell, no other CI service offers that feature (and from where
I sit, for good reason, because it is asking for all kinds of fun in
concurrent scenarios).

What my patch does might duplicate the intention, but absolutely not the
functionality. For one, there is no extra record required. It uses the API
to query the existing logs.

Also, the patch specifically adjusts the GitHub workflow itself.
Therefore, unlike the `skip_good_tree()` function, it does not pretend to
be generic (which `skip_good_tree()` really is not, as pointed out above).

Ciao,
Dscho

--8323328-305546987-1602412115=:50--
