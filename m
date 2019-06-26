Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87FBE1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 13:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfFZNes (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 09:34:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:36649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfFZNes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 09:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561556073;
        bh=syo41AqidJ/XpcdwQu3QC23CcVh5LnpRotmHGcM5GQg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aefBXWtYc1vhHbu6lYldDRbgwZnABGW38TPo/1D9AIf6kttgrmxhetkBDsLOvGfA/
         MCN3EgI/A7k9BZ6aqOlXaxm6MPWHLp/LFTKrvqjhgL/E7K4gA/iEsQIJXPKGH1qGG8
         SCnzCO+d8ahlC+RLWkFRpPiM2ikcM6mj39/qxurM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8NWM-1iS1vf22WQ-00vyVX; Wed, 26
 Jun 2019 15:34:33 +0200
Date:   Wed, 26 Jun 2019 15:34:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares <matheus.bernardino@usp.br>
cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH v7 06/10] dir-iterator: add flags parameter to
 dir_iterator_begin
In-Reply-To: <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br>
Message-ID: <nycvar.QRO.7.76.6.1906261528360.44@tvgsbejvaqbjf.bet>
References: <cover.1560898723.git.matheus.bernardino@usp.br> <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Tka7muaaj1MvMDmPuz9h7RFMZN9qnG+Q44NNf4pdZYKFSRcckTO
 qt1BFze3JUNYLa5rlOGZrRIOxx6d0A5uoaPGFGuONMyiTce6tqsEInckFY2uPp2pddbj3Gh
 PIOR/EWnYrsOcpccLd08Q9CYUTRuZp9r1XdslKL5bgDVv5lczAwboNTpenf/KOiUj8qMKqo
 xpXvhjWskO6I60+IAEhsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s7atgQmo7I8=:6vWq5rbVgMduw/5/75FcVV
 aoS1b+sbDCokYFbc4EHUOuPkkyYfcUitCEukv9VXg44CLt8rkkrDJRQ8ScGd+jq0ef9t3vEZZ
 TObXbKrbJNVFGsFqRDiEEDzzZaE4Zl1rfiunoWKeNybGH+3KYaJ37VU77LSOb+6jQdoqVMlI7
 oG1aHeCT6zny4uv1q4QIg2yb54Zv1b33jP3R1i8lfFmfDC72Dpn5WXPB2q0G3hBQDLv3BYNwe
 9VxDdb9NdaCL3z9LJBp6Swu9rb2panwC+EgbLmnNS7/vzSPEmfK107sdqRlu6CkbYV47K8BKd
 Ult/SIWRZdTbcnulK+nDxouWgxxDcZ1CYHMLbGSkqu7ac3swy6BEhfWOW/Wpr+0oMvxP486yf
 wHy+pqC/KGg5owE6uzy04tDhR2DbYAuPPCv5hT1h3qLrkoNjBrRlIJSHycjKkFgv7lhZWY6kd
 Xt4S78mqnpyq5nVo6jYPkEhPynNB9L0pM9e3Tf96D2OpFSlU+VgpB282TBEsY8SnDu66Yjkqf
 xi1p9ni8vAVVe1E7Sov+tldslxk1u7d44AyhQfbSTx5r++Xebaapk8qg3QK1WzkU8cUjtTvCx
 Iu+HtJE14uRYWt2uYcbUHUiYyEeEoQMa+mE7iAtDpFjs539Csxdg2saXWRY/UNfwZ1KFPidKU
 Z3j67Xg8ABt+/0wrSX0uHp3Sclmyal6OVfKLJjniVdvUnw37waPkRXwXgFCUkcUpfnmFdd/op
 QqV+QqGhI//qNw7IgS7ywJ4xud23U8Am1/7xhMVbL/32eqFfKk+8dWSj/vwxW0QDV1k3wzOjC
 Iwg5iBg3CDa0eFlmeInM+Q1DfN0x9NAowJ2Rathdz9uVDY7tCqIK47S0rh0ENRjvITbLN21EH
 CXrtosbwxqpVlZijaf4Lvj8lmjyLJ4gPBdJtNq+FwfaH3oZOTKShjiEOrvuFg+mUFxsXnBjUW
 yA6zlCUu13CvGAT8qnNmdXMdeUWL73xmdybnfPRtHtDLoAk8xBI3n
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Tue, 18 Jun 2019, Matheus Tavares wrote:

>[...]
> +/*
> + * Look for a recursive symlink at iter->base.path pointing to any dire=
ctory on
> + * the previous stack levels. If it is found, return 1. If not, return =
0.
> + */
> +static int find_recursive_symlinks(struct dir_iterator_int *iter)
> +{
> +	int i;
> +
> +	if (!(iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS) ||
> +	    !S_ISDIR(iter->base.st.st_mode))
> +		return 0;
>
> +	for (i =3D 0; i < iter->levels_nr; ++i)
> +		if (iter->base.st.st_ino =3D=3D iter->levels[i].ino)

This does not work on Windows. Remember, Git relies on (too) many areas
where Linux is strong, and the `lstat()` call is one of them. Therefore,
Git overuses that call.

In the Git for Windows project, we struggled a bit to emulate it in the
best way.

It is pretty expensive, for example, to find out the number of hard
links, the device ID, an equivalent of the inode, etc. Many `lstat()`
calls are really only interested in the `mtime`, though, meaning that we
would waste a ton of time if we tried to be more faithful in our `lstat()`
emulation.

Therefore, we simply assign `0` as inode.

Sure, this violates the POSIX standard, but imagine this: the FAT
filesystem (which is still in use!) does not have _anything_ resembling
inodes.

I fear, therefore, that we will require at least a workaround for the
situation where `st_ino` is always zero.

Ciao,
Johannes
