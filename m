Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9C820281
	for <e@80x24.org>; Fri, 29 Sep 2017 18:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbdI2Skl (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 14:40:41 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:44032 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752468AbdI2Skf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 14:40:35 -0400
Received: by mail-pg0-f51.google.com with SMTP id j16so252324pga.1
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cQZ9LaauPjYruJ5kxR769+ZS3CZv9t1Hgn4eNgfESQY=;
        b=fK6GKla9WExb2SDO0duW0zvn4rNHyYifFpY99iPYBqW14xHVghAiRBCoxPY/WJz4Qz
         t4vDGqtO8WWTdPpbFNhHoBpcHqqCb2cd2othPyhAyHdWM/GBdy/TDgB7uFTLpwABXy8w
         wHjhvZ38VTjJviO0niHW39jrZ0Tc8lVQktF6yJ1kcT3usEwHbo7l/PQ9DZA94gOdTpq+
         TuFhoRVtp+YWcmdQP9LFA4V5OF9iKlchTrBmQ3aO13BImoQVng4HdIr2s50PYsDO6VK6
         YGfKEkIPWuNAL842Ns4JldNXL+zCbGwLUmyYGY/ALI+QKSFzBYAfcWm+t2WlfqJQwG1X
         hDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cQZ9LaauPjYruJ5kxR769+ZS3CZv9t1Hgn4eNgfESQY=;
        b=WJyQDRCUjiOYQMoBJBhdKSmAA+qPzF8fZR/PVxD79dqg0/MtqlUtvW8POQBw7cNG7O
         WGO1syfa7u2uXUdC/V78/sQVYWPn/A3vAcn95IB2bZ7QrvbWkEwEIYiPF5PDTgF+E9yL
         w8nlWKPwV0ir9zj4qFJBt+O7Bt6o+p705oa5cuIhKSk/Y9iE4n/SLJRLdIfSU1NLPvWq
         D56OGai+m9GX6V0EikD19fWsfxnzDrQdBGnvAopZUmBijYrIrUi+jNSMnoZB3nGcJdWR
         iSpXx4bDhSa9hr6t3tvK1fCHCFJSk0z2+qJqV4ufequ+hgCGhLcwjUAcB4X3TJ9+agRj
         IedA==
X-Gm-Message-State: AHPjjUhvmz+hlyn58xfe+zpNcM7UUVJ2YFueTtnLntD+C5T0PRTwr+16
        uW19BXcFjmV1OzYIy/LpNMI=
X-Google-Smtp-Source: AOwi7QB1bfm1ipSr0/OGM1eK0NlNQJndqJ+mFfQF9CsMEfC6/kZ9Og6DDnmwy3SSjvikpDQcuup62A==
X-Received: by 10.84.210.105 with SMTP id z96mr7969336plh.325.1506710434886;
        Fri, 29 Sep 2017 11:40:34 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c47c:760e:a02b:2eef])
        by smtp.gmail.com with ESMTPSA id f3sm8126509pfd.82.2017.09.29.11.40.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 11:40:34 -0700 (PDT)
Date:   Fri, 29 Sep 2017 11:40:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH] clang-format: adjust line break penalties
Message-ID: <20170929184032.GK19555@aiede.mtv.corp.google.com>
References: <073f00fa11930a3607e34828e7563e1b2dc27d2a.1506709551.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <073f00fa11930a3607e34828e7563e1b2dc27d2a.1506709551.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Johannes Schindelin wrote:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .clang-format | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Well executed and well explained. Thank you.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Going forward, is there an easy way to preview the effect of this kind
of change (e.g., to run "make style" on the entire codebase so as to be
able to compare the result with two different versions of
.clang-format)?

Thanks,
Jonathan
