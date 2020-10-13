Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5301C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7072488E
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lX6A8LVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388981AbgJMOpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:45:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:44761 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388975AbgJMOpm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 10:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602600339;
        bh=AN1ACMJ94ixFOR1L4/1kwJ6cUy+XXxY431f8mE8Dc4Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lX6A8LVp/1Cn5VUxbGLlDG170RHGb1NKWctOjedATf1/3E7U2RHn4ZnKPzbxWtQmw
         eA0+XC61PaiaYJBEc1PLgRticV8nbOIU6Ta1nUR112x7NiytrwdTzE7sLbE9ikTFLY
         OzyOWUa78apCLoW51wQ8uA6QweD1+wCDTj8X1da4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.188]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Wuq-1kVcoB3A8K-005atb; Tue, 13
 Oct 2020 16:45:39 +0200
Date:   Tue, 13 Oct 2020 16:45:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5500: count objects through stderr, not trace
In-Reply-To: <20200506220741.71021-1-jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.2010131644310.50@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2005062304410.56@tvgsbejvaqbjf.bet> <20200506220741.71021-1-jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qNiXw0B67w5TFykgLGJ5DMlV+FH46wmmjs+hpuqky7cfr85qQ7Z
 tCP4qO/wCxz1CLCv4c9ZvYeq5O1iAFUvIr59mPJLSuEUZ2Y+wa0+72C8kKJtBou5RRVC/+X
 YDA7U6fZwsKEnEuuUj0cMKcKdzD0B1I1j3dbNhGI6eClnMaSbj8LtiCQx9akOlvSu9A+PSL
 z3QIGuLDyZpYcF0yan1LA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:roaEFW9WFzo=:lRln0LwF7ZGKGaTTaolSvi
 kU/Rmj6cyEx6qqcfai/LbI5YzyJYWKrqaM6HyC+yaDwvXvhGWigevjk64VHfsDZftJ0CWTQrx
 t95W0E7V42+gFTxvb2rkYhJtX1Z6u2q5cT1x2UOM14xUn/49Oawqfd6rc7hoUSMeJHu6Peg2T
 oWQNMCRj9RFSyGM8FX8ajt+AtZH8xe4i5zRxln/0IludVnpgfIRLSX/hj1aK9NlFOt57pL9CW
 IlWu1rKwDb6lYnzb3jqVhXKd9foh2bgJGmdwrcadygp/SyrsghZQMunI/eH686m8E0L7OqLCD
 IZy9Remo2dAVH+tF3KbfOerHChabjfiW3PAQCdJ/b4xyrJrNxL7b4RAZNVASDq8MM3QdDhgcy
 ijY4ZjN3M7ys/5+LzFi28P3u1NXsqCPScfMvPiRdqUYpSC8LKatdKmNtqivq4VC27NYQcFm2T
 uP1Z6VsGND086RvVSecH/8StAuZEuiLxqapGmc4ZLhCe4EZ4hoUSVWS6mZQhWsWKXKV4Lp5xr
 qnWNkUtRGl8gnT1FzRWdIbIM4rZFyeAbhnvBynUQP1qH40MCPt2MrZf0LP4/xJHzJ2Fz2/isu
 d/YwNRw41t5BftWCuVF4o9X2a/8HCl4MhtsXEGi63xnfDk5UJti32/4Otn9EiSfgGH5gHtyYi
 gg3rT54cmwufW2/OA9rX61JhWdXxHuj+iB9XGklbf1iwHvpBghb5iefizPkgieYOrTfMXamQ8
 R8D44yLeOBBot88l0LjZxI0ZeKxLgmUMOct66cqc5M0wosycjMSzKClDHcxmEvMiUqvlQ71b0
 MH3EFbgBz+If2scqDiqAq9xh3SMM/gnYbrQXraFZ3QunS7XtBhumXMYAD1L6kP6NIDhACr4M0
 cyJ9aSCkEhanfJbL63xXePYtzm+de9PdgPao+ieBd6D52mTrS0YXL3Z7AqqyobyC2+fqT7uWP
 qseiwF/uP4NhdrZ5a50gGfe9Px6tfZKdALDVIsPzDjsn/TZIkuEKoOKkNunPqh2JvhZxlay6t
 VnY493QKSn2RtQobQVfwAYH9A3e/P4HN7Lgq3PdAjcOj8d8jA7WkFxiSojtyrlCTXnAmDmSfO
 4fd7lGq+MuMR1YUFqmogj960xq6fyyr4iEiHaPjCT+NthhIrquBLjgQahcxqn9rx76yr6kUJa
 2YKuq3jrb5UMWhRz1N8wNRuyTQFKXysmJAtqsF5SFwarPloSIioUUqcKUAyPrO9HJvMfNteCs
 xe6b5r+lApZFbcmc4GykUBYvUf/6bwkWPIySV5a7Oi+MWnSlW3P71aumlutfzMrz/wPTGYaL7
 RqwhvEvE
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, 6 May 2020, Jonathan Tan wrote:

> In two tests introduced by 4fa3f00abb ("fetch-pack: in protocol v2,
> in_vain only after ACK", 2020-04-28) and 2f0a093dd6 ("fetch-pack: in
> protocol v2, reset in_vain upon ACK", 2020-04-28), the count of objects
> downloaded is checked by grepping for a specific message in the packet
> trace. However, this is flaky as that specific message may be delivered
> over 2 or more packet lines.
>
> Instead, grep over stderr, just like the "fetch creating new shallow
> root" test in the same file.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Thanks, Dscho. The commits introducing the flakiness have made it to
> master, so this commit is on master.

Sorry for the blast from the past. Apparently, even with this fix, the
first test is still flaky.

I submitted a patch to work around the bug via
https://github.com/gitgitgadget/git/pull/753; Please review when you have
some time.

Thanks,
Dscho
