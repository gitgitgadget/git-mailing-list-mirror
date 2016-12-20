Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03E31FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 15:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933905AbcLTPQf (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 10:16:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:60045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932631AbcLTPQd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 10:16:33 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0PdN-1cZe0s2XUL-00ubs5; Tue, 20
 Dec 2016 16:16:03 +0100
Date:   Tue, 20 Dec 2016 16:16:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Max Kirillov <max@max630.net>
cc:     Junio C Hamano <gitster@pobox.com>, Karsten Blees <blees@dcon.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] mingw: consider that UNICODE_STRING::Length counts
 bytes
In-Reply-To: <1482183120-21592-1-git-send-email-max@max630.net>
Message-ID: <alpine.DEB.2.20.1612201610270.54750@virtualbox>
References: <1482183120-21592-1-git-send-email-max@max630.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:k+TxRBb4K5RAadXJp/3j6DOh11r7B1nAqUOyjG1w4XR5Q8oPULy
 rcoOKY5Vzi/i5KvusqfQeipTy7gNmHfy42wKxyb6hOGrIfwpRZEjP1DlQWY+tg+GysPGCGZ
 Wxt4JAFRQC3xoSo6uwX+ZY3PbI5S1zArp0/MiuobsVHL+ZQIPAX6of6PN/Xo9ledwhZmuM/
 7rg+/aXHosW2X+VALUqqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:67HETSB9q8E=:VxxCBdU3yyatDdPvcZa4YS
 /lvzkon/F8I47LJm2/TfNerKHh6MTvzqI8jBaIBb1XnyWKEiIotwEeAd3l3YgQ0i7NCTwiAFR
 PgR5+FAPz+bYoJO/AmPFRmlbI4Z9yADg0RuqQbGuHJrkB7jp/NRCicWrJt5BC7Y9mp4KIepuI
 rG1fj1fTcXn2khVofOHXIh/5f04B9R2yAgQI0aFHBzC8iZmjGqBOsuCXfFK30ILRpM5MNWsjZ
 Kv05UUDitxmumLKLaY1Ji3C+xLjVB9WMv4kMuc3xv7CxGfFzjK3fwU/VkB+EdTZi9ssbUEY03
 Z5gcDSkKmQ2ky7UZqdxwvgDH1Ay3mUt6t8pNTAvw02XwqT04XbvbknBcn0pcWqNM/zqgVWBg8
 /EF+knpeTg8jmFXrjxSfh4eLxFVen/pDtz2XDlGX21DWm7a6O1ZgsPkvIyh/kGdm4XfV6fuRk
 R0tebmsKWnAiFw0PlyiHr9STEBqsCMXDmVhuMYnMv+VB8H4SiWdXLmSrfA7Ghg4VEgtYcWoLd
 rkP8sH2Mtb46Z4FpEYP2k1LA+rINJJi3WYOVo2e2EPAuWf6bFuq1iBIpoVyCFyVUU6nIXlsyF
 uy5CD6t1q0QGY+hWZGyeuiXFEBWxSYhkb+eBQDQZQs2nL6eU1QuTAUqWjJy+0p71gNkGXp2WP
 pUMM3nA+AphM6cuPqhJjhB4imrU/oooktX9BP0jMuEuOl1SnmdRrZ26wvQWhkhhCga/d/z9ha
 1vX79WazWKJB+N8j6Q2VVypFw3y6Bvtnja10WbUiCu3yK90i6oQeRkRYewDv8VWFgp2nMhOeZ
 rB3Sg1G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Max,

On Mon, 19 Dec 2016, Max Kirillov wrote:

> UNICODE_STRING::Length field means size of buffer in bytes[1], despite
> of buffer itself being array of wchar_t. Because of that terminating
> zero is placed twice as far. Fix it.

This commit message needs to be wrapped at <= 76 columns per row.

> [1] https://msdn.microsoft.com/en-us/library/windows/desktop/aa380518.aspx
> 
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> Access outside of buffer was very unlikely (for that user needed to redirect
> standard fd to a file with path longer than ~250 symbols), it still did not
> seem to do any harm, and otherwise it did not break because only substring is
> checked, but it was still incorrect.

Very good, thank you for fixing my mistake! I verified locally that it
does exactly the right thing with your patch.

ACK,
Dscho
