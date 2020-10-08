Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A131CC433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 07:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F7721927
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 07:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="g3RTAB1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgJHH5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 03:57:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:60727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbgJHH5C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 03:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602143820;
        bh=cqKmOyPKGuEBDLZiRATl0PG5qJ+mXEn8RsZkpG1zQGY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=g3RTAB1PEKPZ2SW8nd9QGukKT9pvDTjG157qWet7mbHx5Oob8hrgy4qZ9oBFaKldK
         oLPrsA+8K6W6poaoumecLsHZDmRwJM18QTHGl12/tP2h5rnZRMpVRo5uk6JYaOfM4n
         U0YZOb1m5jrvBSD4HzFe2IXQU36iz4bSM65GNj8s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hZJ-1kMKCL28nZ-004laK; Thu, 08
 Oct 2020 09:57:00 +0200
Date:   Thu, 8 Oct 2020 09:56:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] t1415: avoid using `main` as ref name
In-Reply-To: <20201005095448.GN1166820@google.com>
Message-ID: <nycvar.QRO.7.76.6.2010080923010.50@tvgsbejvaqbjf.bet>
References: <pull.743.git.1601888196.gitgitgadget@gmail.com> <d3f7b39a2f11f4b05195f62190f75c84475c237d.1601888196.git.gitgitgadget@gmail.com> <20201005095448.GN1166820@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FusiYF+yoRfCyzois+cGNLMMHTLRcQ78FvfUYE3vj9/fE2NENo2
 gfuZFNEVx5zIy38cTzMLIHmrD/mZDfkHjYoW1pjkKAkawPVGYNgSgFunJsr4R2Odvr5H8Dd
 MALR+ZY+KyKGORdmE7MoXJm4B/4fhF0qkn5MChGawaT8L/Bwxw9pFgOxm9CK/wJdEnG2MjH
 3Qh0pnSfbjjVAEj80rvIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9UPAwcYACFY=:wZRoReaAvcpJbP2MoUHizK
 QUa6bHeO+BrMH/a6ivGIbpVwCrU1iSb6f2jz63acGA5dGTaP5OdiIJ9mHcwbHBs72jcWERDDz
 AAHgRQPXrNrGjY1gqXjOER/AO3KHtGrSNjkIQ8B/zGXCmBQ5fvYbrWO4Mme99sKUWRD53D6eZ
 /QMckPpo7q0+zE+wqdWlbqbxTQysufN751fAlSkjQvhC7g3wUqm77EY3w6K/1xQ/s04lqLEJO
 WByRQCTiG1vy92GhXZJzcb+wNDWExGgC6xvvrj8vpDpGIfXoHle+nLgsWCCO6zd84eLxe6BgB
 jkBXo0j5noWPfFfR6CxAV8RHBJ6ToE8zCHbS/roPnhiLhGhEYpEi90/kdcs2HkZA9HVCSjulp
 Mw8PEqdlrRfidNa55zMMCJLPVG2sx6xjjtTJqXiq33X3cOzgS3pBfBPMoD4C5Gqj5mvzvPa+1
 pBDLAR1UKZvEcJjYpSVQ0Zqf5R+aazhQZaQU7f56aeyO9PcoN+VPhoHwluKyUmVyrIo5bfCPc
 RVjR8PsGFjJRscqEfk5Zdw4eyWOSk6NsQ6GDOSquqChPd8g2jysAAV4R5+CGkWuq+05E+6b4h
 QiagK2gQAS9Y/hVD26y6KywDmX3wkxCi1alhe2pU0Avvmku7LjqFffSLY1desCUmS1wABZEvb
 2EwIw3kx/eGzo7xns73ZYr7gLt62VR4OSumndnlJDVuhAuO3tcbjrsySmzvMRv92Ql9vyAYhx
 DyjeuqGjGp/G9FQMxqCFEzP1EK5NaNlJz2Y725OyEMJ7UyDIOuE3xvw+SpqY8W7eq2hGFmcAd
 9jW2hUZ0fka5HCnyv7kQzasLT5+gxhFslBW8JNXSlvDOJc9v29iqRRkkyjiJcW3uEXtdy27Zx
 1hEG5yNxmb6sRh3xidDLZ313fjlvGyXV6AazSfgxMR1k8XDuMDzSkamNbUL+CPZmV7hOMEUtX
 zcMFYwhQeS2DA3CtBaiISE4bnIIr+j+kAjpUjeVYKx9oSLkXrl5CdiWDO3uWHcxqz2fmCUteP
 h/OrpR9b756O1Q6VDAnkTRdBpY8Borhk1D6WSswgt4ArHdj0phtRvV9oplUIXX4wgBqQJMewG
 DfTvZ+tp3x1vvR1y7z2UDNqh2gCZH+O0UZGNCRRODCc+5dDB6ZlcBMmuKK/xWA81iBQMAWvNM
 r3U3/F95R9DWjwC+Ip7gnw8Tx42m3YhFJmQCo3jR5Y7j0Zkc0cDslKvxReq2AjjCdFINTYsCY
 xVLJFNZM6cYOgrLAhigtfCGoylQ7/xkHTMtHVjw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Mon, 5 Oct 2020, Jonathan Nieder wrote:

>
> Johannes Schindelin wrote:
>
> > In preparation for a patch series that will change the fall-back for
> > `init.defaultBranch` to `main`, let's not use `main` as ref name in
> > this test script.
>
> Interesting.  I assume the issue is this line?
>
> 	-	git -C fer1/repo for-each-ref --format=3D"%(refname)" | grep main >ac=
tual &&
>
> I.e., it's not actually that naming a worktree "main" will break
> anything, but just that the test catches refs/heads/main in the same
> net when it does grepping?

Right.

> If the commit message explains that, then this patch looks good to me.
> Without such an explanation, it would make me fear that we have some
> underlying bug in "git worktree".

Indeed. This is my current revision of the commit message:

    t1415: avoid using `main` as ref name

    In preparation for a patch series that will change the fall-back for
    `init.defaultBranch` to `main`, let's not use `main` as ref name in th=
is
    test script.

    Otherwise, the `git for-each-ref ... | grep main` which wants to catch
    those refs would also unexpectedly catch `refs/heads/main`.

    Since the refs in question are worktree-local ones (i.e. each worktree
    has their own, just like `HEAD`), and since the test case already uses=
 a
    secondary worktree called "second", let's use the name "first" for tho=
se
    refs instead.

    While at it, adjust the test titles that talk about a "repo" when they
    meant a "worktree" instead.

Ciao,
Dscho
