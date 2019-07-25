Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D81EB1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 09:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389878AbfGYJBU (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 05:01:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:35583 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388100AbfGYJBU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 05:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564045268;
        bh=vgK6voWI7pUvBP4l6dpAh/mmMAWL2bOGlsHAxlIYO2Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GgpUWshp1xVDLPelD0Wf7n/zxXR3CaL7ThC6hgbub8rLLIInTk0nRosM/4vbZy8Q0
         bNIJaEDinY0HpLybLDyPhi7Ya1F7Yi0XuKvdnXYT+9ojkn0EExjtGoHkWRhqNbD/yJ
         qlNtwuOOvCz2YKTf3fjne+RB88AkwwD0wO8RVVgE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiHc7-1iCxoV1vFr-00nRgC; Thu, 25
 Jul 2019 11:01:08 +0200
Date:   Thu, 25 Jul 2019 11:01:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] rebase -i: extend rebase.missingCommitsCheck to
 `--edit-todo' and co.
In-Reply-To: <ce6bdffd-0a04-803c-4a1e-0959342db01f@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907251058120.21907@tvgsbejvaqbjf.bet>
References: <20190717143918.7406-1-alban.gruin@gmail.com> <ce6bdffd-0a04-803c-4a1e-0959342db01f@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GJSiPFsqGSi3q3+J+G2gDZdeROjGnMi4VH1A212BiXC+Ssr+pem
 QB3imKeNDjUNKUbR5tBEO8LdKleob/0cPXLujHRqjXZK9ydk5ULTelu6GGGOD3+LTgDPoCt
 s90H6l1tg42AH3Le6wUduURzL1+UpqX7tntRFaPynaV4/kJ4us56NNV6U90YcMjhSikHEwV
 JsD4Gj+NYPH/avQLGOa6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CTbioQ4tWJQ=:eliRItFeOLt+7EYMXc1zSy
 KYeU929Hf4fFMdAEuCPjPFqghEFgURPQRhtz0wc1e9Lg6ViYcA8pLHYRIcy/h6D3zKvIZ27OE
 Rh9op5tbzmKmvy3pGy5m3/U+93LdSAz8jplZgpPdRSFfpOXRkRuS1D2Z0TMXZRlzUNMZNdgdN
 EYuJou34eidYmbbTuV8S0x5v6oQZBXeeBLz2bhf1yc/IfAGv8eiFarluq1JZ5N7BsBxgqGxJV
 3IHOrqMROM7Exmz4nPbtY0hgBbV2J+CGXozbks2PptU1kg93U2ry6kotKxjvUlwaaMCOiRK7y
 fqQjrR5RK9yPiyewsT1upFSSpqJP0+/n2YJ5NsXcb0j+vs/RXj0VFD+OcwP0iPxPo7GzCUHrF
 odhQLYlXO84/ozL5OU/+y084ew4QF5QX4raEGPIQJxxM/3+h+XxQ3gF6S8PZ+KfI/zdrkFhxe
 qcAZlZBuRwfqKBctVQJWO7a/pLoKBn1+diy5Pv16N++q6ekabkknm7X2++xniDavXyU5DyDQg
 LsSoeHR6JYFcs3EaDlB+m56lBfTUokFvm52+7xFugxBvyaXMq5Y+GHyvQWmYV3TsSTQeB2YQR
 XC3fgrVfbEboDDOlyP4l4SFcScvkElhSaRqRpQXyCUJ8hqGpgVCTk5z3YYBIHMxm4R+EMMNCh
 SPNv2lTxIME7CaypbdUg2xWvGsRsN9gc3VUuJWmtCC3hCq2azdd2/1vnIYaov3Tmz+7+m2Ij6
 HL4obOhmjtMNmdyWbkn9g3izuxYNVZyJmtTJvlDol70sA2UTe7HsgvJK1+dRuigNswOioDPNz
 Fa4TODYn7w77Jwa3+Up912Fep1HOdMSWTg5YInn5B5/+IdKMV+1QbEbTVlaNhQR415IfyT6OC
 hrjy9yokMnhtexGggQjtVleSwMxnFzmJt7le/Awqnlo0sqIHlW9Jjy4iI0CzcuaWzOdjr0pBB
 QMyibBTXqOQzKpMHAR3Y+sF+Dn8R9WOCDSYO/FtaYfNI1FpHHFauLq06AMecdGwmcWU6KtbGY
 8kegz/O4WE5f6XMdBqdiJVDj59Ic74b/nb1aSAWp9HKdWxO2A6e1eIrnGrx9DRAVge1dcUBxt
 /YuamIi2bR3OCgdBhrPehcjBeIQ6I1c7G1h
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 24 Jul 2019, Phillip Wood wrote:

> On 17/07/2019 15:39, Alban Gruin wrote:
>
> > To prevent mistakes when editing a branch, rebase features a knob,
> > rebase.missingCommitsCheck, to warn the user if a commit was
> > dropped.  Unfortunately, this check is only effective for the
> > initial edit, which means that if you edit the todo list at a later
> > point of the rebase and dropped a commit, no warnings or errors
> > would be issued.
> >
> > This adds the ability to check if commits were dropped when resuming
> > a rebase (with `rebase --continue'), when editing the todo list
> > (with `rebase --edit-todo'), or when reloading the todo list after
> > an `exec' command.
>
> I'm not sure if we really need to check the todo list when continuing or=
 after
> an exec command. The official way to edit the todo list is to run 'git r=
ebase
> --edit-todo' and I'm not sure if we support scripts writing to
> .git/rebase-merge/git-rebase-todo directly. If we only support the check=
 after
> --edit-todo then I think the implementation can be simplified as we can =
just
> write a copy of the file before it is edited and don't need to check
> .git/rebase-merge/done. Additionally that would catch commits that are a=
dded
> by the user and then deleted in a later edit. They wont be in the origin=
al
> list so I don't think this series will detect their deletion.
>
> At the extreme I have a script around rebase that runs 'rebase -i HEAD' =
and
> then fills in the todo list with a fake editor that adds 'reset ...' as =
the
> first line to set the starting point of the rebase. I think dscho's
> garden-shears script does something similar. Under the proposed scheme i=
f I
> subsequently edit the todo list it will not catch any deleted commits as=
 the
> original list is empty.

Indeed, and in the meantime there is also an ever-green.sh script that
not only uses that trick to custom-populate the todo list, but also
_extends_ it via an `exec` command at the end of the first rebase run,
essentially allowing for a nested rebase.

Ciao,
Dscho
