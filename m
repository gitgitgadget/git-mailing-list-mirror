Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53D7C43467
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A3820B1F
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Yx+zacpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgJHIFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 04:05:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:49903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgJHIFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 04:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602144342;
        bh=H9a8yzQcfhBazRC/yfqc5SxviFBxzJZ9KDUB1kBYkZ8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Yx+zacpvmVWqCo3mgu+lLgjvoMQ8x+/DRSKNQUDzo+DxECORT4YZFxiWH6E860/7B
         aAIoY5HF5e2EEN19lQVffm2yu8j3dxeQL3EuJrLnuH1Uhb0kuh9vuHcQP17hRno+9t
         zjQDtgMJuH9pZr8FH0bzQHQR1ErzfX+lG6tV0Fvo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma20q-1juWRe0P8W-00VxsE; Thu, 08
 Oct 2020 10:05:42 +0200
Date:   Thu, 8 Oct 2020 10:05:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/2] tests: avoid using the branch name `main`
In-Reply-To: <20201005095930.GO1166820@google.com>
Message-ID: <nycvar.QRO.7.76.6.2010080957100.50@tvgsbejvaqbjf.bet>
References: <pull.743.git.1601888196.gitgitgadget@gmail.com> <6045ceb938836355b7d43bc2088ca2504b05dde4.1601888196.git.gitgitgadget@gmail.com> <20201005095930.GO1166820@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YQQ07aqB8D+C2yFkEjMBwgEU84cJ6xUE+PhawFR0kGXuu+wY9E1
 kiFsg7azOfOaeXlAG1sIdv/EiebxMAh2iwlRgmnu0qsyKqY05+ezu85RdsG3HWtlc/cfCGn
 OqC6Wvmyuz7R8PblHHAarGBYxfeC9ibQsuiKu4gSnyBUi+Er84FDp+jOByRcqhjrUtnnu98
 KMru/8BewZIf/7xJqJHuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mPPTBEW1VKA=:c0Fb4l5n1ajrh0bNOB6DEP
 V/zEeLVKinHtLWcvCVGHjR45p8vJS1HAM615Sc+cbsTYb55a1WhiceWVC/FykHuLb+eOF5snd
 V0UwTvZ3DC0FeiniaXPejyHqIpKLT/CAoID7Xr8QgFK74ioXAd0kYojTYtSnm8wuIfhDKHwxp
 vvD+VUHI3Vo6RO1qy2eK+9S4uzTWy5olTGFXDanupDxfOBFKUWmtFLkvjSXbJlyGSLYsWpiHC
 z6sRTSRhL+ujL6NoLpzLOlvBJ0YG/NtLZ2526PK687hoJ9L3sBX/b27vxTsJDQnMoy+CyPwOu
 abL0Xuk/mx2G7y2hbc9cpYpNTZxISI/QJq3eDtvxTiTrBxLiQuMoYjri57vwxehzMhph5z2zr
 yeZItuJ6zPVoKAN/53Mop1vVKwvUcb2zCNdOrOE7iCRUUYFLJgrU8FPoEORsHdRMi/hqvOk7r
 vFdfIsNMtu9PqwRG3PzYQYp0fdgpa6iBO7vf+9tWZSz3qgDPXCzz0y+AUc6ZDSJ3H3wsoN2HB
 b4G6PznN/ETiOMci7K0/IMgYR1QEZDTA0OnWS2EjSNACRRoVoIRb32JaAq1NV3iO0Szec/Div
 shzOypJ9W3iXfH3PbrPXZLWItAxs0MQ/rwaA7dtKAjlrmn6jpuFGsHyh6+ODpJHv+g9zrHqEf
 UaszszgZZb9VyE/cKWgyh1AFeyc1cWAFz2eXDdwd7jAMz8/lL2UXxTk4tpPBgNVd6ZFgIZcDj
 cYoLTQmLrq2acLuc3Za+lfutQA1A/lMZBKPP7obLPICEFBhLGIjzrZCjrHYqA0yV1npb+kQDc
 HJkCj/yFcCXJvsksOH+VjeuIOck+z0zK8lWVXg7JF9cKDacmX7ar8/c0dGEZ7AxwR7b9xuZYW
 Zy/j6q9t+5IP2o6jLgf88nKm89wGVV8VZ7oqBuKZzoTJI0TBlPCDtB9BEhchNp2P9PmfmrZ7H
 ihNdZ74xcQs8Prqbefe8E59sPvYWpCZ1CCMwFgHwh1d0ZEEsaiQGOqNw1dPCs443FyXVUvuff
 LcpwNw0dQSanEx+7Nbd0kKYbExDmiZEeIT+pDWxe63t8II6+jeW+/IyaLS4dKAZYy2LVYQttH
 LbSVhvsc36kalW147mwcf7HJ3yyyGXocmWlg7JcA4RKuohS1o6LGepH13lkYrPL62BGqe4tEn
 igdq96MBYvKW8JyDN/OUSANIeO6ITXT3cvCEyoPAWnelJhBBDYfLlmEnTfcKi8paE+GftOrvf
 K8AZLptAfZXyxyu1AYKNHL6ERagBrM4yZGa7E8Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Mon, 5 Oct 2020, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
>
> > In the near future, we want to change Git's default branch name to
> > `main`. In preparation for that, stop using it as a branch name in the
> > test suite. Replace that branch name by `primary`.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t6012-rev-list-simplify.sh |  8 ++++----
> >  t/t6400-merge-df.sh          |  8 ++++----
> >  t/t6409-merge-subtree.sh     | 12 ++++++------
> >  t/t6430-merge-recursive.sh   |  4 ++--
> >  4 files changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.=
sh
> > index b6fa43ace0..f1296c29e6 100755
> > --- a/t/t6012-rev-list-simplify.sh
> > +++ b/t/t6012-rev-list-simplify.sh
> > @@ -171,7 +171,7 @@ test_expect_success '--full-diff is not affected b=
y --parents' '
> >  test_expect_success 'rebuild repo' '
> >  	rm -rf .git * &&
> >  	git init &&
> > -	git switch -c main &&
> > +	git switch -c primary &&
>
> Is there a secondary corresponding to this primary?

Nope, of course not ;-)

> I guess the idea is that this is the trunk that other branches branch
> from?  Looking at the history, it seems that this test was added
> relatively recently and it may have had the upcoming branch name change
> in mind (or in other words if it were an older test it might be expected
> to use "master").

I guess that Stolee (Cc:ed) had something like that in mind.

When I look at 8d049e182e2 (revision: --show-pulls adds helpful
merges, 2020-04-10), I get the impression that does not _really_ care
about the name of the main branch, it just wants to know the name so it
can switch back and forth.

If I had had the presence of mind when reviewing that patch back in April,
I would probably have advocated for the use of `git switch -`...

In any case, I would like to keep this consistent with the remainder of
the test scripts modified by this patch, and use the relatively neutral
`topic` here.

Ciao,
Dscho

> That suggests an alternative that is agnostic to init.defaultBranch:
> what if this uses "git switch -C main"?
>
> Thanks,
> Jonathan
>
