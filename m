Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795DF2047F
	for <e@80x24.org>; Mon, 18 Sep 2017 23:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750882AbdIRXR2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 19:17:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35336 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdIRXR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 19:17:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id i23so765968pfi.2
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 16:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NKq4BmJcjVmi/lrENNydGXYiRHqnrc/9GxqYRvX/gUM=;
        b=X0+Tv75peQWPIFuGZcSOXSOBbM6d5QcPWIk49RdovYH0forrbSKQLG+1r2xMXci7U3
         VNEFMdc8/cyDuLJicDvKRrm+NjElRvW9xxgqQxef2N+VSQm0ODI+bAXzSRBwR0BYrTcG
         AYtCmg5D3PLjez6xAybEm6F8na51B2s+yDDbejHTs2TN+imx0lgxd7YTO4995yUysxFG
         2DhCM0FldYqWRAbNbwlfjLwRRgWUcd/JFllUZUgfFHPGnpRXAZrOFaRUkCsxOGZTLAU0
         7F9YluFzB2Zze8uTkjdc0Fp0TOzBNYKeXwSW4xEGv9fucgilhRBaTPlK9GBgUtYdaxNV
         sXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NKq4BmJcjVmi/lrENNydGXYiRHqnrc/9GxqYRvX/gUM=;
        b=qMNDn1Z/xmZzRLMrJ4cBTEdOPc1HYbTAEw8+acRNEoumLSUDu32LxX3vYeSe+qn93E
         ZC3I2cph86GB9i0vcmMa8Zn4iXZBO989+tBNyWQsAQqoECsWqTNv5cyz5UYP7zWKp1MK
         Qe3i03Gem6rqV1xSDGnW5fLWHNczXXgx/fLu69jPlwz5kpLi0mNoD6k2RyFy7/4hf9O9
         AFtawrui6QXuNpRIlleuLgJlBYj0y/1dxjJCQXr2V6Jnd/QfJfYUVVA/zjSvJyPD6cx4
         nNRV5qrr3TpSVwjqBNGyGViCwKwIpTTraTcb9YAho3Ittdas4vsdtPPZCM0NMIUQy9s9
         90qQ==
X-Gm-Message-State: AHPjjUii+R12q6B1vpFM/LMstJBnd+FzjQzkXwioqsKfnZT5Fks3p6Hp
        pPxzwTBy7s7fqg==
X-Google-Smtp-Source: AOwi7QCPANYmA391WJLSqgmQnLk7y5gSSRDvz/2vpzyx2qiq1KXlAToTeYDldJH/twwZb5/A4AXM+Q==
X-Received: by 10.99.126.87 with SMTP id o23mr172831pgn.277.1505776646606;
        Mon, 18 Sep 2017 16:17:26 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:288c:7217:eb8c:bacc])
        by smtp.gmail.com with ESMTPSA id w134sm567824pfd.186.2017.09.18.16.17.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 16:17:26 -0700 (PDT)
Date:   Mon, 18 Sep 2017 16:17:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     phionah bugosi <bugosip@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [OUTREACHY] pack: make packed_git_mru global a value instead of
 a pointer
Message-ID: <20170918231724.GY27425@aiede.mtv.corp.google.com>
References: <1505755303-5583-1-git-send-email-bugosip@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505755303-5583-1-git-send-email-bugosip@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

phionah bugosi wrote:

> Just to reecho a previous change requested before in one of the mail
> threads, we currently have two global variables declared:
>
> struct mru packed_git_mru_storage;
> struct mru *packed_git_mru = &packed_git_mru_storage;
>
> We normally use pointers in C to point or refer to the same location
> or space in memory from multiple places. That means in situations
> where we will have the pointer be assigned to in many places in our
> code. But in this case, we do not have any other logic refering or
> assigning to the pointer packed_git_mru. In simple words we actually
> dont need a pointer in this case.
>
> Therefore this patch makes packed_git_mru global a value instead of
> a pointer and makes use of list.h
>
> Signed-off-by: phionah bugosi <bugosip@gmail.com>
> ---
>  builtin/pack-objects.c |  5 +++--
>  cache.h                |  7 -------
>  list.h                 |  6 ++++++
>  packfile.c             | 12 ++++++------
>  4 files changed, 15 insertions(+), 15 deletions(-)

*puzzled* This appears to already be in "pu", with a different author.
Did you independently make the same change?  Or are you asking for a
progress report on that change, and just phrasing it in a confusing
way?

Confused,
Jonathan
