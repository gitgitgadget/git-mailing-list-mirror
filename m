Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C6B1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 20:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeDRUbq (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 16:31:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:54853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750872AbeDRUbp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 16:31:45 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVrQS-1exwSU0O0O-00X4ig; Wed, 18
 Apr 2018 22:31:42 +0200
Date:   Wed, 18 Apr 2018 22:31:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Harald Nordgren <haraldnordgren@gmail.com>
cc:     git@vger.kernel.org, tiago@gitlab.com, christian.couder@gmail.com,
        sbeller@google.com
Subject: Re: [PATCH v3] bisect: create 'bisect_flags' parameter in
 find_bisection()
In-Reply-To: <20180415134925.6203-1-haraldnordgren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804182228210.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180415085841.1269-1-haraldnordgren@gmail.com> <20180415134925.6203-1-haraldnordgren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vS+EgT2Ib0mS0TaUH5toW7m7yaQiqECXyXKbY+s7oBCEebWkyy3
 Z2rPuHhKyfCa5Zbh1BEhEOtsTfzkFDFnAO4ZN5GXkiB9FR1/9hzEfBV/yO0jhnpgeYHhP28
 9qS76YDMCj/iZlAcmXZmKZ4RjMZ8U8gwdSIV6BzNkWEazd7ISxt8U8RDgHTPQUNbDinUJ4t
 bAS2IIUVotvKmbORNZ58g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BlazNB0t5ME=:EC3hyFuog3QEAF8Y+wdFUD
 dtubnZ52z6mly6yhyNtd3cyohyTpekS1YoxmlZnazeTFcxCoS/J5p/+k3VLPwkfY44WFVaA36
 6htQPWfcopigMc9Nngd9dl2bDxxvLiGMAAS3xtpkcRvDlNTkI1VevG79BZoLy55YpfELGg8bX
 ltTiD1JZrz8zp1al8D5PSu+ZAYOHKZD9/HSNDdETmtQLR7MSgHB5jrfGG/DCyhqRBt65WcrvF
 dgVF5qV6OO2r+ez9WwnFA4K9NRwIyfRIIgkAEEVNDCIROkYwrsmsviqn235itxlnHhIxdqgMx
 VvanOaZi2n8sfXdByCRHErRbLMPFZ57jKnHD8qoMHTDCKRtFgjIN30YawNzW45H65UGM5wZr/
 wLfF4R7UsBfQ+/kXtbs1nFHq6gfkmveng+wjlYXt4rq04PS3Jb+yHG8XqYIxKP8+9DtwJaXLe
 LLbj16c8We/f5yHWz3ZQOVAFh8cqZeaRvu//oaS6W2AMSHitfQinIX9smF9hHM/HXAsgpDBsp
 v1JNGTr+puoao5BIweLLeALrXukJMnP20QTKkVNX2hl4f0ew6AA/PYxXI7ROxsOp8JuKg4mN1
 66iLX6AdV7gMbTm1WKoyS0KOMyUjr29vWVhMzHLsHfxh7qjLdfTJTmUWcCxfpS7e4Ep2PjIQd
 VJTvRiUtQJeBbcSeXVQidDenjZwQNeirD2QdTNj2HWDaZ4uXDlU0sbX1Z06Fi32jQiLFHF6ny
 CMinDwbbxQtDqsaRV+pLzxliDQbU+fap8hkzU3/eu8lZua2sem+ENzwMLbw6gQ58j7/QnIZrI
 5N9p9BAhWT3oYpvR8117h2Ci63jtE7P5ApD/996VQgBEYbYZAo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harald,

On Sun, 15 Apr 2018, Harald Nordgren wrote:

> Make it possible to implement bisecting only on first parents or on
> merge commits by passing flags to find_bisection(), instead of just
> a 'find_all' boolean.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>

Very nice. Just two little suggestions:

> diff --git a/bisect.c b/bisect.c
> index a579b50884..19dac7491d 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -254,7 +254,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
>   */
>  static struct commit_list *do_find_bisection(struct commit_list *list,
>  					     int nr, int *weights,
> -					     int find_all)
> +					     unsigned int bisect_flags)

For flags, we frequently seem to use the type `unsigned` (which is the
same as `unsigned int`, just shorter).

>  {
>  	int n, counted;
>  	struct commit_list *p;
> @@ -313,7 +313,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>  		clear_distance(list);
>  
>  		/* Does it happen to be at exactly half-way? */
> -		if (!find_all && halfway(p, nr))
> +		if (!(bisect_flags & BISECT_FIND_ALL) && halfway(p, nr))

Rather than expanding the short & sweet `find_all` to `(bisect_flags &
BISECT_FIND_ALL)` in three places in this function, I would rather just
define this local variable in the beginning:

	unsigned int find_all = bisect_flags & BISECT_FIND_ALL;

This would also reduce the size of the diff.

All in all, very nice!

Ciao,
Johannes

P.S.: I fully agree with Junio and eagerly await what comes next ;-)
