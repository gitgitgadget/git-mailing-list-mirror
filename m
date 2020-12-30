Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2684BC433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 22:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0297207A1
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 22:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgL3WPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 17:15:00 -0500
Received: from mout.gmx.net ([212.227.15.18]:47141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgL3WPA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 17:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609366376;
        bh=c4B122fZG7leroj8snZr54DMg/OQdj115TXaLFw3PnE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fIohIaQ4jr3704+0y4SGRuWYm3sQAjBpnyhbuU35uDy8L3IIoG6IxFIGs1kasDCrm
         WhYVMXoqi5ailob5WPlQzITAGeXafbghtXVhCkDd3CejWh9rV2yzfbpdugQQLjlv3G
         KP1wHKTlGp3Nh9EQSQ1J2PSoDnllvGXOFSkOqJzk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwfai-1k6SJO0974-00yCZk; Wed, 30
 Dec 2020 23:12:56 +0100
Date:   Wed, 30 Dec 2020 06:47:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Seth House <seth@eseth.com>
Subject: Re: [PATCH v5 0/1] mergetool: remove unconflicted lines
In-Reply-To: <xmqqim8r36ba.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012300645400.56@tvgsbejvaqbjf.bet>
References: <20201223045358.100754-1-felipe.contreras@gmail.com> <xmqqim8r36ba.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:U5n6JE+MLhKpQzoAV3BIbyhne1w2dmCDieJz5eSjpLeF3EDwo/b
 hlabWSn8wU8QuBB8iuIDpFyJiJ9Defs62ey6i/e5QjxH8+OpOog2TdjMu6Ku6pUPQzb4net
 IXzmqoJKjqFHbjls15IrKb/QetW9LpEag4h6dDsm3d/1l1+OZYAUV2G0E8K3BWJLsDnJntS
 p43TergeLShKxLY62SKQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e12u8LfpnIk=:HHNHPsjHiR/N3tTIbgJEdJ
 thaAuGZeI1JNFH6erd1sAHnBjgXEMJCqEhOnY8QJvMiLMEZ8tYWlGlOLaaeK0fXiLhyzWNiDX
 tslDp3l4LFmTxNEhR/yQfCEZTqj5uuv/BGaIxvaShmMf04tt+zxtz28wvqcWACCa2nLxcWku+
 RFozvss+4HE8chePTrGDBvi5m6XhCiy1NEtFqkglMcWmknXZPILDT6NaXdpzlAQzjOYXF4VEY
 oQ5xUWCYv2WovL8DrDhvSIBSClDTvzkVgS1ly7e3j5ahctqsAkPvYv/vX7hrHNcFDKK7PgLiZ
 jlkiYj1YiBilEcB8Fw/atk+ivlTXHhd3fEhZA1OuyBEtsInuo9OK6ypo9JwoTEJiiQRDKyOw4
 UDM7dAhc/r90USOQ4VULHBC7p1XyxoM+ZQAMTL/bDL3uTPZGkgNGMUH6vMF08wfEdvZ4nkSCO
 SaVt5CpbE2qzIE+Eg5iHXcP5x/aifGewT+ZFXqnJ2bUBDK1i7SQ+j999b20lPw3N/uRku71pM
 KTU0fhyRhYUhnTmvlcM+xkdIWjmLzH3NomqnP6AVC5tu+eK1uBWuGg/RWKvIDMiTIYHSoFRcE
 bTr2K8nxGtijgQjlqEBnvjfiqwYmz+9Af5/7wKcluKXy4yJWuWTKVc0St9VTsgPUlwZV3U+yO
 Lb/9hI2WPGQkp7akBbcG8lEVSlYyhctgy1lMMHb9oA/q4guaXcgRAWfvilZN9x9HymKVvSsw5
 DjquZTPEzTDXHX93bFHLPrrXGFxivH3r/6RwwxUNkUToe/CXJp8QxCQLlIWckjTlCsnT/DiVk
 0ZSw2lPvDfdFr5CD5/hixBejqz7M1UpuXBHlg5yCNUl2Bkj8T7/73fkvk2pFHihTJs3pCA1R9
 YKmMrL7STuVowKvyz+qE/vseW4a6EToowXrmCycu4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 24 Dec 2020, Junio C Hamano wrote:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > There's not much to say other that what the commit message of the patc=
h says.
> >
> > Note: no feedback has been ignored; I replied to all the feedback, I d=
idn't hear anything back.
> >
> > Changes since v4:
> >
> >  * Improved commit message with suggestions from Phillip Wood.
> >
> > Felipe Contreras (1):
> >   mergetool: add automerge configuration
>
> This breakage is possibly a fallout from either this patch or
> 1e2ae142 (t7[5-9]*: adjust the references to the default branch name
> "main", 2020-11-18).
>
>   https://github.com/git/git/runs/1602803804#step:7:10358
>
> I cannot quite tell how the two strings compared with 'test' on
> output line 10355 are different in the output, though.

I spent more time than I cared to spend on this, and still have not quite
figured out what is the fault, but I can state with conviction that the
problem is not even introduced by any merge into `seen`. The
`fc/mergetool-automerge` branch itself is already broken:
https://github.com/gitgitgadget/git/actions/runs/441233234

Ciao,
Dscho
