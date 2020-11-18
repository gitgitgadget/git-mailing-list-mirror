Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E370C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 324972467A
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="L7VXYabp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgKRU7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 15:59:04 -0500
Received: from mout.gmx.net ([212.227.17.21]:48605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbgKRU7D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 15:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605733138;
        bh=dtzXOrAAeYI4/0lPAWD0OF+EZPOBjp5neRvJY2w4ecs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=L7VXYabpC0uRF4jtF0iVGY+2fAzzYRFoBVrsWH0aaZkFwlDHMeO3Np3IYvjx64E7M
         BilIwoKXglhzwXaqzxjv7yfzPddiouhm2S6LCKxSh7TEYic/xz0KiN3aiJ2ztREAmi
         ypvqByqVkKNo4OUcxU6e2FTAJJ4IBDFT8ieRnR/0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf078-1k4VtT3abi-00gWfz; Wed, 18
 Nov 2020 21:58:57 +0100
Date:   Wed, 18 Nov 2020 21:58:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/28] Use main as default branch name
In-Reply-To: <xmqqpn4b6bru.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011182156560.56@tvgsbejvaqbjf.bet>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com> <xmqq361ccvot.fsf@gitster.c.googlers.com> <xmqqr1ot84fr.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2011171651130.18437@tvgsbejvaqbjf.bet> <xmqqpn4b6bru.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I6kFGIICZNAErJHDQSUOOTOcFXJ0WFqmERzgY30PEGXmD9U+uqa
 TbBdLtxjvImJPD4uYXfYgLhrX12rLbEfdYISAcmnuxCPG9nfA06kwcV0rQXzWzIGRmYDt+4
 FqjbkPCPRKPE3TtEtjPKVBA3m84Chgkfla+K/m8iXAAMu9guoM51WzdvB7VZ5bhlR1h2JsF
 wLPoEdHp4ITYx/8l64JBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aq9uj/3CYbU=:GJhD+AIRiGMlwUhSmpFlXL
 K0Qye0B0G+9v9962H5o5pM8EyfCyWVMjoPKq2xji1whEmtYHLlgfBUcEWPbYdNFJUjDUKifu4
 i5mj319BWUVzPkHw60SrvyfyzYjHw9E80M84n3i9puDYNlmhUo9XJ9sWtYcUV6pgZ/CgWTzc1
 dzyQslEHelHBu6BJbGU1OHlXr62kWVInY4o7aHU+XV84LJvs+ge7kK91DdaEZf25kaA3bMDLM
 wuotRfA58XA/JM82A03kY+sXwqpfhEyhHT1O/JZ6Nrf3MgbpPfo0JqywgLa9Qql5vFKH9sa4o
 1RrdEaPCMzYsXv7OYTiBy6rJdRibKulsC6aS0qXUYcSa+OV7utpIsuQv95sw2ckDuG9NVtiQH
 QSsWAEYjzl++9xowfz0iqu2TXg4t+2IhOoESOUB3VcWe937Nbgs9wKEYLCKMj1Vv9uhz4QorT
 5V3pT0cIxSHDaKYb4E5P30VlBfH5FRaMgypzN/gK6KNL+otvWwLzLcf5xf1FZ7cLwgZX7gb7Q
 fnh5sGoEfOj4qNoLAZ65HOqBURepJi75AL3EoI3vWVFqikigO9ps+l9GHztPj5JT4+465FsHs
 RMk6ylm7+NwM29E5/zZ8Lk2lBTTWM6EV5WpKkLbpxErxswkI0OXW9wjvv0hGcmibXnmEOb6IW
 /+Q15ZMjiB+dwQKksnAebfL/IIIqr8uSd6+eP/dY+wOZvDx+v9Ywyv9ipqpwElmK4yHYwPcm1
 ye4/O9PhM2MOPlY5joSMtSNVYl7VebLdI/EU0I/yp9dRhtI8Ak4pgd+flHwoNvwKht+D78B6E
 FdGa23DUbaIX1/sOuTsEM5oZ1Gkxp7rFkf5eEwDkZUxs1GnkENy8mm6Mihu1NskkrmGMbTwcC
 ygMhuoXi/mUKQmmpZ/3vyBV7THsuD21nL8n+CYOeM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 17 Nov 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > 	case "$TEST_NUMBER" in
> > 	3404|4013|5310|5526|6300|7064|7817|9902)
> > 		# Avoid conflicts with patch series that are cooking at the same
> > 		# time
> > 		# as the patch series changing the default of
> > 		# `init.defaultBranch`.
> > 		GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
> > 		export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > 		;;
> > 	*)
> > 		GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> > 		export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > 		;;
> > 	esac
>
> I actually am not a big fan of the centralized table of "these want
> to run with main".  My ideal would be to have an explicit assignment
> of either master or main for tests that absolutely require the
> default to be one of these names at the top of these script, and any
> test scripts that do not care what the initial branch is called
> (perhaps because they begin by switching to a branch whose name is
> picked by them immediately after they start and use that name
> throughout) won't have GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME in them.

I will make it so in v3.

It does make sense, too: the four patch series I sent out in the past
hours address some issues that I would have otherwise missed in the
transition (in particular, two test cases with `test_must_fail` in them
would have continued to pass, but for the wrong reason, during the
transition to `main`.

Ciao,
Dscho
