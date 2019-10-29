Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF391F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 08:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfJ2IPf (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 04:15:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:39085 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfJ2IPf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 04:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572336927;
        bh=RfN6X8HHhP+288VxMP2kaIUjqdDRPVSq7v+xvc8c7yQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZRyeSOFUfA8rVZbhvIDpJ6HXfDnCevXYsSbAML3jpefhVmp/mvlktVhCjjyUetFv0
         MTcjIqNHvkmgKyXeYdvxKh+NimINvcwk1Kb4BF8svQOwERJH0Yr+vYE8sRnzns/hd3
         qauv2YfNhGznFiNg9LFVFQKFR1sr3c7FQDaVvmpQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf4S-1hgeFx2pzW-00ikns; Tue, 29
 Oct 2019 09:15:27 +0100
Date:   Tue, 29 Oct 2019 09:15:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix git stash with skip-worktree entries
In-Reply-To: <xmqqzhhk70fd.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910290913110.46@tvgsbejvaqbjf.bet>
References: <pull.355.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910272203360.46@tvgsbejvaqbjf.bet> <xmqqpniha9a8.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910282152080.46@tvgsbejvaqbjf.bet> <xmqqzhhk70fd.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:stuO+yXVRt1WY5Boo0jC4cL6IgCUG+2iQcxeOD0tM//U7lLBmms
 Zhrk/aOf2Vai4wjQJQROJ9ECqM467XyJBwBFzCQV2t88e53qarHFG4ZRuhZcGWEpMsInnLz
 grDc9I60I8UWdAi86fzAIBeA22Ls1QaFXPVXM4d49SGlKPgwDw2waWNi0STgtaHFvui9fo8
 g1Sj3LpB1bOxJQZrmDj7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Md3PpyjfHzQ=:SbYS3cqHyfncsFD9px30P8
 jQWig60nzBULKIDt2PqP/FS4c7YaA571yU/vhoeHnwac6/qbgHobSxYsnHsh8wwgqYwW6z0ky
 +RELFO+6WUDHR5tpzYyHtTetNEqUOCRr6O5UB6UsiBC5xjonyGESv52jlRkBoJhaLjP91eIFu
 NYIqa2HUc5drfcca2DXtjhck4Q4ea+7wg8xAK6pl5Nfg3AjCqewkRlHqoJ+9I+fNVEW3vcGFq
 n+MWo/o19HdhYef5ZZ4MMqqvNAQ5cnvAdZJWQPB9SexJjmY1gdkrjbGt5Z1YLMGNy0Fd7B1dx
 OuqvOLrBvN2QWJR/u5ETKtKbFEW/BRqgn9stRqs25hs2ASWh2jA8DAji5ekArosAmzjdzROWg
 vRipqjc83NpilFMHiQbs3ZTtAMgi1ccx4333RCf5e28jCdLuyotB6di+DX2SKFNIejaSnjyIH
 LvBPW6tAQwChdGfCRJzD3ZLpJJV3QfaSheMd5rPfDvKfdNEf0eOg83bPzkJJWg7lbSdy9kdt6
 mqm/c8Y5nYg1RHtN0VMyvGEw7TiGbi6mQhLkyQEXMcYvcf20Be1ViehDKNf2Bh4Z4nJRe7b4F
 D5bLXoWSqRBwc5ulwnUSgTx4xzBuzpAhxgucDX2k7vfzmDSaaUBVDR7GzuRosa05/rm2Hi8gq
 snwXmuZHDZNA88BCYhRRggAVsLVpdAaCr5SEQ7JfT5DHqm0TS3jOiwVWAJ7CNEvaH+a2v8+fn
 YnEtBZnrjHR3jTGmyg/u9wJS0b+MvywpWgKGSOMnHn2CG2CQYyNnglDYVbchh7SCYTtXt5pH1
 XV9RDNoijuC6mR68VxvSM+oMuIO1zA0xJuiQE+qbqo5ZKSOREQvXTYPCKT5K20vvSL4dItEVh
 1udSJKLoo4fHf3/IeIAdSW2O9/sDeEUMrSyX8qGjmvdEXGpB89gY4WVTqXLNPBDLuT3ZTWM8J
 qD1O3IP9ukKNdBcZl8D6FHwzF5b9v1CE7UyIMWSWJ47KmvJrlaD0i2vmzaO8/mpVa0No0XneS
 Ijzf9LF3O1L2o5EUdRr3kOt5IABLUdF7XPxuePwQvbGGCdRPh2ude+Z9vHQTXHuYa0W8v+Ulv
 K2YVqCiM3mIVEmHsyl9IKXy/czXJ/y46iNT+m7Ns4B7lFIeHEhOmjFQ9R9tv9k34cmhg5bHcC
 QcngRjmyWyIpk+hRlVj5YHvsmvVtAR4B4HVONkQPqldAd7NtiGSYpx3W0TO93uFDdUQWmoLDJ
 DY//oFcbtpJw7oHZALY0in10JJSU7mdPL4f3E6zxVo5mmAzRiv/M4KqqU+pw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 29 Oct 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> Yeah, I do not recall seeing any of the patches in the topic (nor
> >> the cover letter).  It is not clear to me what "lose" above means,
> >> which is an indication that I didn't read the topic a month ago X-<.
> >
> > Sorry, in this context, "to lose a file" means that a `git stash` woul=
d
> > record such a file as deleted. A subsequent `git stash apply` _would_
> > then delete it.
>
> That would be a good thing to explain in the log message.

I thought that this paragraph in the commit message was describing this
issue appropriately?

    When calling `git stash` while changes were staged for files that are
    marked with the `skip-worktree` bit (e.g. files that are excluded in a
    sparse checkout), the files are recorded as _deleted_ instead.

Do you agree that this is good enough?

Ciao,
Dscho
