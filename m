Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E07C207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 23:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1952979AbdDYXtD (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 19:49:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34238 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1952747AbdDYXtB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 19:49:01 -0400
Received: by mail-pf0-f194.google.com with SMTP id g23so12995580pfj.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 16:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=abYIXvTh3mfABc0e0j+zjSKOrP1uIA+HI6TOUbEZvRA=;
        b=c5ey2JVy7+eIPuay7wGmvPmE+7ewoV/abiJrrqsXI9C+arepp48fQfB2hcHUIW1EV3
         1hvpCgRZJezGkIKBGG4JYLwE9yPe52NZ5NYIIkNxNgMiPtLVjfDofL23SvzcZolaXTfp
         VZWm7ULY958O+l0XsfS7y6Q88ifwONV10upVEXVLFncPu24oyy+5WphSNRuGhGZx0KpQ
         6Om2Yds5kxzzGhB0MOXp70eaB8brEGRKx5E9/AiJfolfr+qw4H6mV6dnrvHw8lZssut3
         FziVCT0F4d5OSkwC1uX47JNsndds2bydrW9AaZJbB4BlshxNhyN/3T9FM70M7fWnQIFs
         v+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=abYIXvTh3mfABc0e0j+zjSKOrP1uIA+HI6TOUbEZvRA=;
        b=RR1sWelkIZAdXkhnkGDvaOkAxb3Dv3coQRdGKJT11N7EXb64VCjw+S0bgIb2iTb41g
         N0up5ci5J9eSHCdgA4Bze+aVX4fSi8zcfa4PWzYXZy24Q3wbCKC+eXIlEl0eUdyaEBGz
         Zr2AnijKDVwg2/hkLmY5p3F+3eA8ApNql5tJ6vzqPYQBKceCc+SEEJTWqmely+5Cknj/
         ftwE1WhwRWK3Qo1CEFz7ucvxMr3w/DdRIaU7XzkJghBMIBFKb58Sp2gXcU9FCxHgh1fL
         LMVIOosRyNtXVOnPEN3ja67Y8Tq90JxJdsuedbnJaXiCbMzmBT4hg5bVM/eqw8XVFyZx
         hi0Q==
X-Gm-Message-State: AN3rC/4RtCJzLyunlUuQce3L5IXAKQOpp9M6KOTig27PZP6wwsFC6wt3
        YPKZQdl4XDLDtg==
X-Received: by 10.98.138.150 with SMTP id o22mr29835349pfk.69.1493164129473;
        Tue, 25 Apr 2017 16:48:49 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:c0ea:3a03:d3a7:cb53])
        by smtp.gmail.com with ESMTPSA id o5sm1992075pga.64.2017.04.25.16.48.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 16:48:48 -0700 (PDT)
Date:   Tue, 25 Apr 2017 16:48:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org, peff@peff.net
Subject: Re: [PATCH v8 1/2] run-command: expose is_executable function
Message-ID: <20170425234846.GQ28740@aiede.svl.corp.google.com>
References: <20170425175446.113553-1-bmwill@google.com>
 <20170425234700.194277-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425234700.194277-1-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Move the logic for 'is_executable()' from help.c to run_command.c and
> expose it so that callers from outside help.c can access the function.
> This is to enable run-command to be able to query if a file is
> executable in a future patch.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  help.c        | 43 +------------------------------------------
>  run-command.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  run-command.h |  1 +
>  3 files changed, 44 insertions(+), 42 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
