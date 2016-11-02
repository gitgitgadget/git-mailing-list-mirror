Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2972021E
	for <e@80x24.org>; Wed,  2 Nov 2016 09:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbcKBJ52 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 05:57:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:53691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750762AbcKBJ51 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 05:57:27 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M2XkX-1ctQt21Bdl-00sKUB; Wed, 02 Nov 2016 10:57:21
 +0100
Date:   Wed, 2 Nov 2016 10:57:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #09; Mon, 31)
In-Reply-To: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1611021054030.3264@virtualbox>
References: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Y3sqAhDFqGZZ/jkkNEZX/ddpZRjRoV7e5x6XgTR9A3sV6iHESXX
 CuGIIcpILXVOAehPFQJ7ZaKoQ5lRi6DQltKIkwmVO5B/qKJSzXjphPqYlYQhYJ5bZIHGn7p
 Yytthe7R30bkRrSB4xwqK0hcG1MntjzsiEa8BLn0NNp+EOpLEmUeto7Ou7xNtTOMLdPopNG
 iXBYnGnnNh1Rb4Piurc5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/pX39nelSL0=:3ALeP2JSGaALBIWludG704
 HBkule6Md/XEhuXRTTQgL9pn/4kDmKqyObjCpXORCryJ5/4MR1Cnj9oGhuWAzX0dLtTo61JDo
 KCR08aKSZS9YvF5/vMcFAT7qtkFfAx5ROWf4NIQCGVGZP5wDbmyC5AljmnaE0JPvuTg9AR8bQ
 RXH8v5t0wT0EiPgaEmQ2YEFEZop2YfDSLmJTK1lqrY5KCs4UXKCQILEoD8tEB9oZhSY4KHN3r
 2KJ/KbU5sCr/Ly2kia8xrjnHHqj93qBc3GrVjPf2hgvd//8dGxblAxSSE+QRqJlSiVFBMICYR
 s6iLUfo54dT0xdcjHYeTbnZTfHu2iRLdhEEHNlTw613uw/n4OcKXORO5AvLgru8DP70jpCZfx
 yWZ7B3O43OHH5Kb8u8o9mQLSXfD6QFsmAsal24rpa6oKKX7hBOhbjnwenbw4J/eFxuKKgw7Fj
 2Z24fYZAWBwEe+8BKdzH5qnHINo/FeYCzYOy+r/d1DI7H9xUCUGnjnUQTOh0NsWhGAJRnqLCX
 xU+oeAMUgv8AFZmgv5nYK2lxK5kDmNFRQJZZ7vwtvfL9IxyA6u9KDc9nRkvMDrZnOIOWrxMcm
 ZRanaOFONB7DCKXo3+mYsWzXk1dXpNK3eePCGVRpQWJw+7xIgkgWlHlg6/Ej87oT1eH/f5RNN
 arXVyA4LmS2MfFuv0uh34nWgVgvS1kInFFk+IqB10tLU0kvE1WeuPKcbXA7vS0HMxq0VVJWpx
 NRKoWDRCKLMsI2gA2pUedkprvnLEyFCae3xWtoIL0/E5F8+DJyOntdIuDyAfSawaH0uG1dE4f
 1hzWAaB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 31 Oct 2016, Junio C Hamano wrote:

> * jc/git-open-cloexec (2016-10-31) 3 commits
>  - sha1_file: stop opening files with O_NOATIME
>  - git_open_cloexec(): use fcntl(2) w/ FD_CLOEXEC fallback
>  - git_open(): untangle possible NOATIME and CLOEXEC interactions
> 
>  The codeflow of setting NOATIME and CLOEXEC on file descriptors Git
>  opens has been simplified.

This branch (in particular, the "use fcntl(2)" one) breaks the build on
Windows. Until this breakage is resolved, I won't be able to see (nor
report) any test breakages in `pu`.

Ciao,
Dscho
