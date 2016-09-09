Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DEEC1F859
	for <e@80x24.org>; Fri,  9 Sep 2016 09:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbcIIJxN (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 05:53:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:61132 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbcIIJxM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 05:53:12 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LsCAp-1b3IHT1gsx-013t9n; Fri, 09 Sep 2016 11:52:52
 +0200
Date:   Fri, 9 Sep 2016 11:52:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] Use the newly-introduced regexec_buf() function
In-Reply-To: <xmqq1t0ujp2f.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609091151510.129229@virtualbox>
References: <cover.1473319844.git.johannes.schindelin@gmx.de>        <cover.1473321437.git.johannes.schindelin@gmx.de>        <d0537819a3676fda6928e7ad3282aa71643f0755.1473321437.git.johannes.schindelin@gmx.de>
 <xmqq1t0ujp2f.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:u9GqzwWFJuA3jJBlgP4rtuWdJDUX5TBWCYCthN6dxizanQM83ne
 MIx3cYHaVh30AGhT5UmMh0D9wKkTKPI/kMBFnaIM+eMTTkc3n9zz7d+Qee1xPbmuizG8IpS
 fY1on1M0nhcaVxrgRHn7PTHwdLqzN7tT/AM61Du6D6EK6LgrxBh682aW8egyyQ7kj4m1Qoq
 aT8u+BbZWoiTYai1I8q+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z3uaSddUs/s=:cf8QUb4f/PE5baP2C5FTjF
 u2Gzf5GlbbHpPAvCXH3dvx92nF9ce804+pofKZVkvLz5qinHNOCWRvnDRBSIZDqDGc3p8Phfu
 mNGSvyU1HvEkN9IbqDXDMHsJBaQYl5nQNbR93IertuJKIGJTmx6zOndYpd63uUATPFe8/6FM3
 j+fTgtQ33Phmm8WSmnhme8H6UeORpnR0Vg86bOViDcrZdk/wRM6SqLOU/19RiO+mbQRBirWbv
 vWUBoDFUX43lu9mWifn4EsZ596+2iFQdEQi8zZGPyD6F2FR0EqZ/0ayFh3uqRK9fPigY9ctWe
 xgTVSXDswSCAuJLEj8Qg6TCJynP4GStkC7NFZlrR7mo7V0T/e9LZnUo2+iGZ66+fMLz5xo2iy
 vauV/iJTFL2yu+bfQkW0USCPk0E9eH/AzMzxxfWmZlJ/7WE7l4DRLkV7ePZTuo+KUX/JmFUxW
 b/SA8vY6bjXGg41SCdHxQ5a18E+mdWEmKDIfLKRZdNdZQDbORkqE/fDndX7AqIUJEvFMZOpcv
 q7y5sRsaR0pDTHml77GJg7QU6XxWY0P/jToeYY060qWUhlbZQGoK1iD2DLrk0r3bTbPNhl1eq
 m7JuczLTHL9jvr2Ck9/+tp1p1NrkQdvBp0W+AnjjzYZ1jfclHPtTtaq5kCoZpF+EY3sW+FFSj
 hP/FQPorP6L0rhYOfdZ/vXYrP8ICx1Ha5qbCuqByLg3q9Jo+cIHNF225A2CTmrD4/EOLLIAF2
 DwkJgvH6x/tMzHvS8etAtTdKfnOgy1ay6KxT4DzWzQzr44vlBplJIIzHRwFqWBZCWJ0QZ0sIW
 g3uolYZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 8 Sep 2016, Junio C Hamano wrote:

> Please give these three patches a common prefix, e.g.
> 
> 	regex: -G<pattern> feeds a non NUL-terminated string to	regexec() and fails
>         regex: add regexec_buf() that can work on a non NUL-terminated string
> 	regex: use regexec_buf()
> 
> or something like that.

Done.

> Also I agree with Peff that a test with an embedded NUL would be a
> good thing.

This is something I will leave to somebody else, as it was not my
intention to fix this and I *really* have more pressing things to do right
now... Sorry!

Ciao,
Dscho
