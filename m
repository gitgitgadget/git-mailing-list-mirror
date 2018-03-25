Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5693D1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 17:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeCYRfz (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 13:35:55 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38136 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753739AbeCYRfy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 13:35:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id m13so3315364wrj.5
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1iCDTnAjYnJOTk2dZ7L7rZCggFotiMg+V6fEvIbuz10=;
        b=X5uJ5EOV1ON+spLqC9t76+VECvPnHWUBZK5nai0At0C7TTaPl0DuID2nOgVRgc0LGy
         O0p3tXsA7YDaqZJ8doaJCc6w9xgeFmeWhJK0t6eDYtXIw+Gu3or9MhUaq6TxbZulRK/T
         XaU2YAtiqNtx4tj+ZRMpam5WJMYdNymcIw8N3mQuDtWjX66kyBHhVvFdFVRJlruiFdZP
         hlB2P3MWFNgeR4ZqVB+xkF7zGxMTtNfjsXTd7iQXB3W32olrQS8DIkPOGTTd8vU7Dfvb
         vWKE/+s6KYKzYLpTCSrctQmpCS9XB2wh4b6d+7Vk4D9p9B+j8D2L/l4Vgq4nWRBLw9x2
         /tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1iCDTnAjYnJOTk2dZ7L7rZCggFotiMg+V6fEvIbuz10=;
        b=ajbB1Sfxs7tYmHm8KoOODhSiuXWBbMShoaT/yuzM/mXMpfPXLVb+6oP1uVkrwGthp4
         NNgce6CoWyvoNyx21XwVSdW0IQaRGtqcJkquG9MkPmXegfzihqp5F3KjerAflMl8iImK
         O5lwr4n8JCAvTwvRoJmWYvBmVPrhb0GSkIaVXtbHy6A/r2fWwmLc06mlDbLZljEoBs/I
         BBgvoOtWIw4t37EUVHUmlgtYijxYa5llSWM/yMbTyrWNgxcl2rNL1u2DUD/7t9OVJzVD
         eW6jWGO1DcIkefdI6OecEDdpv+5eLQtQSgx4esGSJJoC+hBoWdTCqjUd5hbBgPw9ke39
         atgg==
X-Gm-Message-State: AElRT7FIw4g7HtTvoOs+/NXSD11tdCJmMbmkSBX5JKGBWl58lQUitN9s
        efFWo+axReLxIKC2VWgggJs=
X-Google-Smtp-Source: AG47ELvpjgGWqeuJMCHh3V1/0MosJIJaRtD2TC56YexxNxEP6s2gkkNulE/dA9+/DdjeMMSeIy9+eQ==
X-Received: by 10.223.184.56 with SMTP id h53mr28151284wrf.87.1521999353335;
        Sun, 25 Mar 2018 10:35:53 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id n64sm13610474wmd.11.2018.03.25.10.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 10:35:52 -0700 (PDT)
Date:   Sun, 25 Mar 2018 18:39:16 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Convert some stash functionality to a builtin
Message-ID: <20180325173916.GE10909@hank>
References: <20180324173707.17699-1-joel@teichroeb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180324173707.17699-1-joel@teichroeb.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/24, Joel Teichroeb wrote:
> I've been working on converting all of git stash to be a
> builtin, however it's hard to get it all working at once with
> limited time, so I've moved around half of it to a new
> stash--helper builtin and called these functions from the shell
> script. Once this is stabalized, it should be easier to convert
> the rest of the commands one at a time without breaking
> anything.
> 
> I've sent most of this code before, but that was targetting a
> full replacement of stash. The code is overall the same, but
> with some code review changes and updates for internal api
> changes.

Thanks for splitting this up into multiple patches, I found that much
more pleasant to review, and thanks for your continued work on this :)

> Since there seems to be interest from GSOC students who want to
> work on converting builtins, I figured I should finish what I
> have that works now so they could build on top of it.
> 
> Joel Teichroeb (4):
>   stash: convert apply to builtin
>   stash: convert branch to builtin
>   stash: convert drop and clear to builtin
>   stash: convert pop to builtin
> 
>  .gitignore              |   1 +
>  Makefile                |   1 +
>  builtin.h               |   1 +
>  builtin/stash--helper.c | 514 ++++++++++++++++++++++++++++++++++++++++++++++++
>  git-stash.sh            |  13 +-
>  git.c                   |   1 +
>  6 files changed, 526 insertions(+), 5 deletions(-)
>  create mode 100644 builtin/stash--helper.c
> 
> -- 
> 2.16.2
> 
