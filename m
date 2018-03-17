Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29DBE1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 11:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbeCQLc7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 07:32:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34971 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeCQLc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 07:32:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id 5so7494038wmh.0
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ys1mhquoGNFuwem90j8xSlpTMd+Iy0FJudYTutnoXEY=;
        b=TFFHk5yUT8gMJVMRzROkdp5LjIxmCaBoLs+fW97ZKyhrY3zV2thWTjKtf0gBgDrYil
         pg3vVHgDIqOuahkP5N4e5U0S6DEqefpJTrnUBi4PGW4kNut9+uqNEjDpI4THlQWwQhba
         x1RDJEwithecpGvq4xwRLSw5NjmVQ7jr8Esf1vWL2yZ/m9XbmQiONrCtCETX1iVcr3+R
         8OIwT8EKKmg62zjQsqCSiO5Yh3VDIvd6D3w2DJkJK4zCIRfLH0VqVah0j4nWNh6TA+Uw
         9fj4XOT16SpOTXyH5g5gZks2X2L6K16+Uxa14jutw22HKEzc1+mqoBiH3mJkj+gLEvOD
         L1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ys1mhquoGNFuwem90j8xSlpTMd+Iy0FJudYTutnoXEY=;
        b=U5mu85uTTzoS/IPdBvumie2JHiILK7S0Pf0jVNEMMN/fbETVOZa6at3/vSSlJkChKP
         SqFSFEaFY2+owqC9OBNHhYz8CrSfhf9BTFQNU9VOttMzA6NokeeBnImoMmjLjXZ8EJDq
         5p1Qf6vxyLpUB50wJy7p7GMUh+YaoVGr1hd5ZAQDNF+Xks6oyyEkiSe+QpchzSBK20Dq
         D/v2VmHcC17K9mink/sjR39CQLho34PuIISR8xWuaQ1ybMqxqbzXezvyhCvVMm5QFbsa
         +t+i2XRFrnZRixVAEEHb0lCzyzqB4mPxN6p6J5E+QmweATcpykknAsFaQo1EZnqCnnvn
         Eyzg==
X-Gm-Message-State: AElRT7EhSS4TEqv/BocGcrm1dDXLBz6l9CQ8Q0nfCkIBwqupJ6e2soTx
        n1fIKDQPrm08dqPIJfLVuA4=
X-Google-Smtp-Source: AG47ELtRJ8a6oniC6hjWEdyIZjvrI+NqaHVRdF4s0+oO63tiRgENazRgoN3WBbG9sP6Ts8gmskkrMw==
X-Received: by 10.28.177.215 with SMTP id a206mr4051363wmf.142.1521286376976;
        Sat, 17 Mar 2018 04:32:56 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id a63sm13083014wrc.22.2018.03.17.04.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 04:32:56 -0700 (PDT)
Date:   Sat, 17 Mar 2018 11:36:12 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/3] stash push -u -- <pathspec> fixes
Message-ID: <20180317113612.GD2224@hank>
References: <20180316204306.862-1-t.gummerer@gmail.com>
 <20180316223715.108044-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316223715.108044-1-gitster@pobox.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/16, Junio C Hamano wrote:
> Here is a preliminary fix for an earlier copy-pasto, plus two
> patches from your v3.

Thanks for catching and fixing this!

> I tried to reduce the nesting level by swapping the order of if/elif
> chain; please double check the logic to ensure I didn't make stupid
> mistakes while doing so.

I looked over what you send, and the patches and the changes you made
look good to me.

> Junio C Hamano (1):
>   stash: fix nonsense pipeline
> 
> Thomas Gummerer (2):
>   stash push: avoid printing errors
>   stash push -u: don't create empty stash
> 
>  git-stash.sh     | 13 +++++++------
>  t/t3903-stash.sh | 22 ++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 6 deletions(-)
> 
> -- 
> 2.17.0-rc0
> 
