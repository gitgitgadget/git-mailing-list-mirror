Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1DAD20401
	for <e@80x24.org>; Thu, 15 Jun 2017 19:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbdFOTpS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 15:45:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:55574 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbdFOTpR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 15:45:17 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4Gup-1dchmA2yn5-00rqI7; Thu, 15
 Jun 2017 21:44:54 +0200
Date:   Thu, 15 Jun 2017 21:44:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v4 6/6] Use the early config machinery to expand
 aliases
In-Reply-To: <xmqqd1a511rr.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706152144390.4200@virtualbox>
References: <cover.1497440104.git.johannes.schindelin@gmx.de> <b75481173390d70a64a1156421aaa0ec5aa4abc2.1497440104.git.johannes.schindelin@gmx.de> <xmqqd1a511rr.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/Wh5VeYrhlUhNZAAzt6CUL6lPPsH61C91n9xbNHBGxZAat54PFP
 1kFMUkbw08hy1h3WEgZHaPDmH9TcW96RfBYAoSCjDEHuE7lNK5vLOY+O3AmKM8aKPhvir7P
 neo23OHDXpsmYTC3HXXkcT1NDyoPWCV3Z9+VOX7O5V7UmvtzoRvJjZ0FLNrz2ZIa1Wc4p8X
 W5CAzh2EbKEIkdPz4iTuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RGUFL5rPMz0=:0+T1gUsoHyw0Oo67Kwg9vM
 s3fkIXG7RBbmqYMcR9iAM6VUFEL7hl26c/o2paBa0oBruH6hNBcCj86twVQ/FpiLaj327issw
 BB0SWsW319DsjKSlGtIhnSpFXUY5YGXWRqTLyjA/Wj0ZO/uZuLcFhrGwFp0J9kW9eeNL96m7m
 HW0IRS9hVIsQD+iGNBQ9tQ9Dt+DPxrBDvqe8K8l8uZtoH1s6R8f4zbIy6EzWIQ32ZM7RSgVoh
 NuvqDLtQdogCFpRGjYEQzSNy5y6fkMAp1O2bXjWRF5DuebexMmpQbsHxTQTwSEdwNigl4iibr
 9mrAGnJmdiAhdRa1jBBodvfSF+yvybnWqS+gp2afxNc3G1O11QhQBS+zqYVqQRPnhtBgkfgk2
 ZZl+KYMPG3tc+AuJqLeqXHkMGY25qvvG+yqx5LAParYxElLXtOZ1e2NYxTY/BmcB6D7G8nnt0
 GrxCeOVVtJnEfV7hk6/nSstJ5qqtzYR55Mp+HzirTwtWKoZELPUKgKPpaykfSzJ8IsNvuG+/7
 W5jXUXcNeEriU/Z925QeBPmZjUJIxr0XsINAFS3+v1UJhhRaDVM852Q08j4qE2Q7rYIvto4ca
 IBID1ECpaMZ1LFg/VWAT22gYMuT0EL1tmgePQEwZmk4ZMv1SIEkQ4mL2hjhiw2kZuNb0CwPh4
 HdkerJCGbCf4GpXHf+SbdI9Tf1hwtwWkXJ6AzVLGBFoiwj6E5HCmcajUuITDgCjprjjWvDCnT
 Vvksq1i8BwD8D5LH5Xz+dGJ4wyTabbSRJBNKf3r9m+6fhtRg78uTnddY8qZYTjOm6Pvg4xuhS
 1DqroYM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 15 Jun 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +struct config_alias_data
> > +{
> 
> Style: "struct config_alias_data {"
> 
> which I can tweak while applying.

Please do.

> Other than that, everything looks good.

Thanks,
Dscho
