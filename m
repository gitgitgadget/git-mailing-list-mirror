Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499BD1F790
	for <e@80x24.org>; Tue,  2 May 2017 14:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751084AbdEBOh0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 10:37:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:61909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbdEBOhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 10:37:25 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHH6Z-1dJbYB2LrP-00E9BC; Tue, 02
 May 2017 16:37:20 +0200
Date:   Tue, 2 May 2017 16:37:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 1/6] rebase -i: add abbreviated command-names
 handling
In-Reply-To: <20170502040048.9065-2-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.20.1705021634210.3480@virtualbox>
References: <20170502040048.9065-1-liambeguin@gmail.com> <20170502040048.9065-2-liambeguin@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:w+BZLEzrtSrypbJTOnI26LIKpDpUIowwgZEJZTxjVlpNGOnCcNH
 BT7TkquwpQTMJ5CEjRBaUMyVavDd4OwSQSwJQDayN0tu0mLjsAmIS+bKaK5oZyIQIpDB56j
 MPs3yV0u17+p3mAZCIlH7SpRw0VntHwAG8zFqOgCMT59/WuoBEe8nst6iEt20c+EaE2RIkb
 HuGgPecbsNDAav220xtXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YScZQx/+s6k=:4BzPd3UdehRHtWXD+o4ztg
 8DwDPOldBpw6CKM/h+vjndyLHat1tr9eUMpZDeVijlDFKxJVULO0kQAVYNmih6Tgd1/RaX6ff
 DOV7yYcQFChXa21VvTbIwbklH69m2iosURi9wdPOcXhwVx1R9QW3fUzr5b0hc1nINyrxu7b1C
 Or3MBIZQ4DpJqBDt1fTOoymBOYq4rm8eNe0IL0G7GKScNn9xEB/ap5fSzfXVY97y2omVYVf9i
 dcDbf5zRW4bLVPjbygdPNKzL4a0QMUnRc0ZycGsXO6THsTgAZlGLrjzE+3FFStEHqFZNy8Ryv
 yZ7uMLC4EiwMdoRfynLPRzVqXlGXt5xencgCh5N9jPmLAz+K8xdjbb3n921YSUBrAfvDafEp7
 q/knxlG2FV8CVLYsQQiMgaLF8tvctx18pymPa2C8gsCkgBwTrc5gnKhO534ru30AnsFH55dZG
 iVApfLvRvu5W5iWnrxC+IVTK6Ibf8Doh4aPfXEGZWqUIZB7UxvE8qZF0+ms/1SR8uYW/JXYaM
 uojdMik3by5KCPpi1BxzfNlaRkL6nzcf9btJtdDIIJsmJst+6s5WaPmEf0e/2HxxgNV6sdryZ
 dO91FxAX0+Owja3R3eTWsfiKLzs1gSRTGP8MwD9Qot50Oq8CuLCRbWSvzWJddq3+/oxR8q+Bp
 cNo/CheNyGIsRGTtIUk5hmyMyimpdt7uWYCSJwFzxMhDGjQsE/5iFX1CgFAY2d2805PcrRP1M
 EpOWmc72MU9KPVGHqg/JNNRqGvaUVg+RzzsA2WK/ULNvSOctxVlPUgR3fki2kov7RamBtL+pW
 QP9DShj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,


On Tue, 2 May 2017, Liam Beguin wrote:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 2c9c0165b5ab..9b8a030ff045 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -754,7 +754,7 @@ transform_todo_ids () {
>  	while read -r command rest
>  	do
>  		case "$command" in
> -		"$comment_char"* | exec)
> +		"$comment_char"* |x|exec)

While the existing line has spaces around the pipe symbol, I think you can
safely remove them in this patch, as the style of the remainder of the
script seems to be disagreeing with that style. But please remove also the
space between the `*` and the `|`.

The functional part of the patch is correct, as far as I can see.

Ciao,
Johannes
