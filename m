Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24901F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932912AbcHaIUz (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:20:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:64390 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757955AbcHaIUw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:20:52 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M8NBi-1arycx3ZI2-00vwza; Wed, 31 Aug 2016 10:19:17
 +0200
Date:   Wed, 31 Aug 2016 10:19:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 14/22] sequencer: prepare for rebase -i's commit
 functionality
In-Reply-To: <xmqqinuh3mx1.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608311018020.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <1d83fa095c03eac9abfd1038ff7791bae8ace984.1472457609.git.johannes.schindelin@gmx.de> <xmqq8tvf8dmz.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608300836030.129229@virtualbox>
 <xmqqfupm5fix.fsf@gitster.mtv.corp.google.com> <xmqqinuh3mx1.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0mVp+B1jiIUK2MhD7QsvVt/x5lAzPNmAANllr+IWMwP2nnSqn+V
 M8R8IXYiHwc3VSS96CLoGMnIhJcDGXg/KxsZJktMkVycclQR17X+7bDMmrcln17Ec0bqA9v
 CYW86lSQ1tGuJ2D3aT7SDVUhKvyqJixpspmjXH9bQAXNcWXBNqrV1RW6R/+bZk+pGs70Tz9
 2gkr3Vz2q95nrv1UbUouQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K+WoqYfDox0=:dgK0prfvbjyUCpyL20HsvY
 ojwV64QX5LPOSGKHig98wSEI1HumwQTVFqVQXFJSPAlYt3Tk6FZeDp+lkmyhuzbpVw8aX++wI
 YdLbXGcrHxFvFAJ/LYesGcog7flQKkSpaMbMkEyTwAjaAERsUVkLt+E4J5pSgNBQdSJPXBldf
 M3MPR/wInL3OqZD5pCDDnegM6wY0GDeRsqgnyQiaMT1U4ERY5LuWyUgkwd8HJyNEJ4fFTvk5A
 HdZLxJs7FQfKmGWawtuIrLYNWPN+B5j99UAWaimE9LJ+WpjlUvAkUywNkNe4d1eGorkmyLQP+
 BAaEVErWSemGKP3stZU5XFWE2rzRFix2+WFQx178E14NcrH09wEThYAVOzT4PxNzbZwAeIYcp
 YJfoaYoSOU+xlGHpYLg8Xj39q4DFGxLIsBxWv426lCfxLIFimg0ZcDdOothLP1tCfhiPMbH8+
 aAv9HikIphUjlLrq1Q6jFt4nps9gsfO7l9QhDMPvDM69MJtoyasrXhXVupXHhasdGoQ8IBbWK
 GUZlr3u0K8H1pHxBxHzc1wK/55fNN+PFRc/g557GxeBSoomagJf1nlXBiYpkP7NkdaMaKh5b8
 9vpWH4ZXdtN7oQUxdnfw1uAFFxO9IuheBCaRLhohn6qpxCALIW5uQ6Rcgojk9I4qGZWV567n3
 TRcIhsSgzIKdrOljbdztXwjT/K66AwgVcbXFWsPIC+7oMdEw6TggXPqn9LGHpVU7RS623vkCu
 3hfrInOQATSL6QSTkxmK+NNxS/UVeu+lan23bhgSyTR/UXTjz+9IlOGcHnY0KlxTzH0NQyAmS
 K79h6AM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 30 Aug 2016, Junio C Hamano wrote:

> From: Junio C Hamano <gitster@pobox.com>
> Date: Tue, 30 Aug 2016 12:36:42 -0700
> Subject: [PATCH] am: refactor read_author_script()
> 
> [...]

Thank you so much for that! I will use that as a starting point to
refactor the two read_author_script() functions into one.

Just don't look surprised when you see this patch as part of my patch
series, Signed-off-by me...

Ciao,
Dscho
