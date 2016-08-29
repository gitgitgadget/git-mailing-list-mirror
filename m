Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4E311F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 11:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbcH2LJy (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 07:09:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:54947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756927AbcH2LJx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 07:09:53 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MFR2O-1bqRNu34Ts-00EKn9; Mon, 29 Aug 2016 13:09:38
 +0200
Date:   Mon, 29 Aug 2016 13:09:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 20/22] sequencer: remember do_recursive_merge()'s return
 value
In-Reply-To: <1472464293.4265.28.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1608291309280.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>  <1f79d41e3417a0b1f0cffccc40e97f1a2c5ef987.1472457609.git.johannes.schindelin@gmx.de> <1472464293.4265.28.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IelYD5tel8jVMBZ8vK5uKsvP2qikTYjwMZJvzjxnZLQyupLmbxT
 yXHEov31fKL1oloMN6vB0Dhre7wwvodJZAALmMzp2qL5j0dXIoYONGAhITeJGF/HVaI6AOq
 iMBesrSxr+TcHHKVSEodF0pa8GVZmwN9eax2nDNG1IcDBfM17OmTcbJYfztXwQ/nzEG7y1x
 0hInimzOfJdPD5j1IgtBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L30XzZjMlUQ=:PvKCMqw4owOC7MkUbVRSZl
 /gG6rWERQ53OFDy/lzwe2kSrOKpJs0bfsmzDDIM14eDXu3XLYNPqx7MwW817zaY6qn4AQaB37
 VwClVFivoMA+8gPfNAZj9RcIDLnL/tBAz242oScbxharoeXPDwtgV2qnU/W7wx+k/NcGgvMwT
 2o4paiVaa2D6aECn16HNuCYgXuNfxgRBiZf+BqbcaKwutn415r29n3fOukTNENVcz65dvzCUI
 6jUIjKbf23MQaIVboftT+Jqi7GEVDgbpoM4TbZuKnjD5NC2P4nDqpO0WIhF8gO8BlEm9CZ8ef
 hh/Fe3Y6uJhZk1FQ6L7ynjnyqGxaVdriHrEHJ1K89oTu13Tbp/hhLldzjQ0fgnWuhZ7xpn1pt
 XnPipdTet2f+cpW+EwoTRA9WfGuWKCclW6X15L8G3PwF019ebWWCNW2u2JCz10KqupRqQlr+J
 3XEN+sUy2gmg9FjConIndlTfO/scaqZxTQ5Ub2Eluc/LOqbaBgu1lshc/luk0DnJDW+YMo4aJ
 IIPdf9eA1XAXZqQij4KC1oqO7Ql4frXVczeWvyFZD/bSoVaURIXrDvi52jL4XsCh1BhosL8/F
 rqHNW7oSh7Taw4wqAuCSSVWMfzF237iSHkMShPfFC4idt5bxsZdAMO/nzljBTg+Rx5qsRFHcz
 gw76wEXe/DUrYHCfa8zDRn4VINq/Xdak3CbtyrO3tjzIvW2FskmTFyOZP+tp2AHi9z6XA49m4
 yl5tPO9FfLeN5Zs1M/9HdkVBn3j4SfPX2qDf3WKHOKeJOk2KizkTx0gpfKnOVIXPFtKfMq5oO
 ZxfUkwS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dennis,

On Mon, 29 Aug 2016, Dennis Kaarsemaker wrote:

> On ma, 2016-08-29 at 10:06 +0200, Johannes Schindelin wrote:
> 
> > The return value of do_recursive_merge() may be positive (indicating merge
> > conflicts), se let's OR later error conditions so as not to overwrite them
> > with 0.
> 
> s/se/so/?

Good eyes.

Fixed,
Dscho
