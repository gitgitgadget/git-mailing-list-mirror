Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3221FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 17:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761440AbcLUR7x (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 12:59:53 -0500
Received: from mout.gmx.net ([212.227.17.21]:60311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761214AbcLUR7w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 12:59:52 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lg1QN-1cunpM1RYR-00pbkt; Wed, 21
 Dec 2016 18:59:43 +0100
Date:   Wed, 21 Dec 2016 18:59:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] winansi_isatty(): fix when Git is used from CMD
In-Reply-To: <xmqqtw9yleop.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612211857480.155951@virtualbox>
References: <cover.1481454992.git.johannes.schindelin@gmx.de>        <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de>        <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org>        <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
        <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org>        <ffc6a7a0-4ae4-b755-0b09-5bcd7114a2e6@kdbg.org>        <alpine.DEB.2.20.1612201732160.54750@virtualbox> <xmqqtw9yleop.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vY1bKwxpbPeHz+qXXbb64ZFBOEIWyGFwZJkqSHeLlsSp8XT6AAM
 GHs/7R/FIAFhmt1A7FrbvqjzszZWgGQoNvLc2jkrOMybJl5iHC5cM10awh/puiEIGjf9dKi
 vCDwvUkgvU7y1fToLjDeBzPWR9EkSUfH58BHV/jMujNuseOLgTvyDMpJNf7qmMjXTkOWXF+
 mbFvyFyt8QdGzYv3FFs9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3EBuYGsOKms=:OhP4S6q1b2dxffH67VLm9a
 0Nyx9G7LhzAlo+almaT2VVPXB79sMtU2flvhPcJwSDTYzV6QElOdgalW1WCXvMcGFbU7eS9wQ
 aP/lD/b0BgzzeG+GrrO5NnX+1i4YdYt9899xgV+oQaJHBfOA6fDBTAqIx/NMFPBSS27bl/YMw
 z8J6Ez5PAXArTBHPIihDsbhRkaDbGJ08XNphip21CegsMwY8RZaWhJ+v9E4wvo3I1IN1lYZxR
 5YAf+2lPOggvi8LXc2KrgwwGsY2sMCIMvN7sn08gOZPylaoEUcV7/Od7HI3mEO306OrqejPQh
 xbotAdzx4ADjGjqNcLqNMeJgm13NJEUzrrlyTh9VBwmsrcqP3cAmh930G7Ly9sBxCs4H1aNQE
 pm7YgB6EqFemnzQ2OQOpuRhXbbncbZV5nZB0MK1LsE4+npHQ/uBW9KCAPQn1KH+0b9Yslyrai
 d4/9uZpGpk+8BLV3q2UwnURDFfGRnOLptqeAVK6E+KpznEheggQYdzv5/fwRvietgRS2wib6k
 mHPuwo0Se+vAN33doHlxV+iNUZEc9mmzruQnhAV5uIgiuPzUiEtC5qdF9gQpRvZqLE+erMWDC
 KifMJi87GWs2LMOdejD7yUlFzuvAHormYNl8TxX7ZW8l0UDFMLX1ZGL0F9GNt1qiBSxZSf5eT
 Qlsis1gxygVOH9HWfAMD52k3Te3ocxYyEKgMnERJt2/ob9T/tLn4f9A7iRBpioVzOF0/VQ6Li
 NtSJyNqIJ3Q0eTNgg0gKIESy6Z+sGFeU8py4MSbxIcGoCI9boeaFueMTSPMMWe9kgHj1DA6TA
 4tr5wDrn7XmJB61wNFK2ExnhfHb7zfG4aHcKA/r1QA50QNugFTgOKx0hhkiKm0Fhi/NdhRTMY
 Nkxp2wuhs7GzXYrhcgFuwzBWE6RWCD7gLLbZa7p6FnBd2XB2vxW7ggu6wmXcDu2W4ii7pd86B
 s9Bvkzw1+PExSpwVfzWROd1PJ9NmhPkGYFMA1cY755eY6JzP0mso4FcTICJBovc0OAri1AAsi
 d3yviPFu8FuqpY2xJAaPEG8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 20 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > That code works because winansi_get_osfhandle() is in winansi.c, where its
> > call to isatty() is *not* redirected to winansi_isatty(). Good.
> > ...
> > My plan was actually ...
> > ...
> > Let's just clean up all of this in one go.
> 
> I take this to mean that I should hold off applying/merging j6t's
> one liner and wait for your counterproposal tested by j6t.  If I
> misread you please let me know.
> 
> Thanks for working well together, as always.

I prepared a patch series based on `pu`, on top of Hannes' patch, and I
also prepared a branch that is based on `master`, obviously without
Hannes' patch.

I am indifferent whether to include it or not, as long as we have
something robust in the end that everybody is happy with.

Ciao,
Dscho
