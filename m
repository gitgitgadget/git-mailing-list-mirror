Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ECAE2042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933908AbcLMPjx (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:39:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:52404 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932493AbcLMPjw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:39:52 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSduu-1c9Dvj1oJA-00Rcq5; Tue, 13
 Dec 2016 16:39:47 +0100
Date:   Tue, 13 Dec 2016 16:39:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2016, #02; Mon, 12)
In-Reply-To: <xmqqoa0g96o3.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612131638290.23160@virtualbox>
References: <xmqqoa0g96o3.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cfvw5cNw2iNz1y5QImoQxFGsUx9vn0eA4Ao6j2YtIE8r7vTlgsG
 mKHH9UVwXKF7pRah5hUNtn6Nv3fcyLnJlngXYrbfRhnrtu2oc0HxKaIpeVJBO1u3zDCblO8
 KEvZJp12z8ph6AfX/ofay68atDeUN7lq0KWhQPqMwPmi1oweFGsd8Hy/4fsmEJ11d5ryJhl
 0ayAdDgCA1D14021Gp2XQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZXkx+9CkRTY=:r9+p2TVGdUoWb/f54FAPtt
 2Vx58RBRzuKWvVs9jo8mBArTesmuAOELWe1hUhH6sUiLf59JslkKv1fi4zT9Un+u8JkLkAoD2
 eF1qUlSgEEVt9TyPA6uNhf63LO5niyMU3op5rFkP0Uk/UuAJEGDNr6G+RDu+WPkmjyn1JvaGN
 9dKrjHH8+k7CVKJrF9rNA7ylbzx3e26q87L15CObteuyor4GvURqdapefWdUBR7X1hTNzyhcl
 E7uaAyPfKcSoslDDXtYIuKBIT3VcOzknVXi4cT3cUCscaqcxu6DWHfP8vOCP4XxUjWFqTdkT3
 +ZohZwlXdChTmyJ6qyBWjZd1mb3Qq//Wg9bZ1Yw4qMWh4B+OtSFvJ4fxMkKAmM1/ci+PXlgGv
 MI8FrmjeRh1ujcTo4X2i/ttuDP5iBzI4CAtji4DjAdMzzhOT8R8la+Iz9y5eGBausccRsST4Y
 AQbmYn4Ad2yOgpT+BSupRLfySmGk6Z4utefiKdqzWxzwR4Ec4mU/DZljN0/y/MjB4GP5bRof4
 miZTMdK0lY5ESx88R2b+ZuJDX83PH1XlmUtZj1xjX/VeBzhACZUUPnGEzdPPTKvdkQfFy4/aD
 EZfYNP+HsJvoEqkEvUI3+JXbVysOky2vAxQLwWIpoGF6hqT6V/AC3OoXmEovrqIBDk7gLS8Iy
 oarR63p5+mkrZLXF2elR1dexMb9a9nJWaDhVbY1JD+dNQ2uwDMYCuAsKa8BIsMlwugWQKFCwN
 UHXOLnyLWZROLeRrMGBcnawRAktezYVWm9dvA7EcPKoHFlKwC3jKMMo56pGb1eZT+YmYwaTbJ
 BeiVecV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 12 Dec 2016, Junio C Hamano wrote:

> * js/mingw-isatty (2016-12-11) 1 commit
>   (merged to 'next' on 2016-12-12 at 60c1da6676)
>  + mingw: intercept isatty() to handle /dev/null as Git expects it
> 
>  We often decide if a session is interactive by checking if the
>  standard I/O streams are connected to a TTY, but isatty() emulation
>  on Windows incorrectly returned true if it is used on NUL (i.e. an
>  equivalent to /dev/null). This has been fixed.

I'd like to suggest a reword: we did not use an isatty() emulation, but
Windows' own _isatty() function that simply has different semantics than
what Git expected. *Now* we have an isatty() emulation that wraps
_isatty() and emulates the behavior expected by Git.

Thanks,
Dscho
