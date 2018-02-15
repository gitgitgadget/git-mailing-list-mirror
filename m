Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F301FAE2
	for <e@80x24.org>; Thu, 15 Feb 2018 22:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162981AbeBOWCQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 17:02:16 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37400 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162966AbeBOWCP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 17:02:15 -0500
Received: by mail-pl0-f66.google.com with SMTP id ay8so606795plb.4
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 14:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=as0JM0zdIxhhSr6JuxJr7dU03dqOqco5ZEnXC4p2Weg=;
        b=hVsX+xa5EIZkplFSw4FJcUffnF9yDOVg3BB6gkpYfXl6CNlEla5vLZ/1cEmI14mTaE
         1NraXx4DtxIYF2i6kdnyZ1xB6iPZOZ4MZ124hpWeP9vJabFiVH5ptoKdygUl6rsFKiQm
         7+l/iEeJTtkCeZl/VSDHZUmEuenSblX3HLped4LsWPLpSnpyze9JRMfzfmu0n0Lbi6/Q
         IPQQGAuufNIR4X1m65AWVDXAUmGJe5n5fyKmBHMLaJj3HU/14m+PGiQ3QWI6MlvORv2x
         G9MjCbZpFKyLDT/gyw8SpB/1zL6snaLiRkbNLScj0vWhJnwDogA2r3X0phcG8eMzHuwN
         MDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=as0JM0zdIxhhSr6JuxJr7dU03dqOqco5ZEnXC4p2Weg=;
        b=XRsFzFvakzUv3cc6B6L4fXYgCdozF/PsveDl3VIydTBzwVeMsBPpxeMXyzoX1c9wZq
         ASzGCT5uG7cS4drwx4wHsAxjUT3XpiHVpD5qCXopm0hUZZBak2u4MVs1xcn/4DW1L1IM
         Ly5oO3zK3uEinoDOOkhCVupOZOf/7EJ7ryCyVyuImBa6rPtd3Z+fJPWeIEANnzIaVXNz
         pYdrr4CDdJ7M+FxKsjN5bqHtkIB3vFdXGgWTH1Us9H01hYTf06MSRdzBlAfdcXFfNztf
         cYijf6m9wGtXUZlOjm1PDW89iCImjpM/7wgyi/Gt6jPcrKK5MZiHXBsNtDLWKRgD36k9
         nM8A==
X-Gm-Message-State: APf1xPCFFRbNDwdjf5F/JRfLp0ESKZx+eum0TK2O0manAXpRyCcnXXVZ
        OD3fuOU4fXdMCYBOynYmSORrkkVmg0I=
X-Google-Smtp-Source: AH8x226c/Jggq3AbEhsQ141CN+SOorMQLKQQXXthom/mHZpCL2B+hVoQLK83eReGXVktesmHsYSO3A==
X-Received: by 2002:a17:902:43e4:: with SMTP id j91-v6mr3764504pld.153.1518732134588;
        Thu, 15 Feb 2018 14:02:14 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id v19sm8607810pfa.137.2018.02.15.14.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 14:02:13 -0800 (PST)
Date:   Thu, 15 Feb 2018 14:02:12 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] a few grep patches
Message-ID: <20180215220212.GA123347@google.com>
References: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/15, Rasmus Villemoes wrote:
> I believe the first two should be ok, but I'm not sure what I myself
> think of the third one. Perhaps the saving is not worth the
> complexity, but it does annoy my optimization nerve to see all the
> unnecessary duplicated work being done.

I agree, the first two seem like good changes to me though I don't know
if i like the complexity that the third introduces.

> 
> Rasmus Villemoes (3):
>   grep: move grep_source_init outside critical section
>   grep: simplify grep_oid and grep_file
>   grep: avoid one strdup() per file
> 
>  builtin/grep.c | 25 ++++++++++++-------------
>  grep.c         |  8 ++++++--
>  2 files changed, 18 insertions(+), 15 deletions(-)
> 
> -- 
> 2.15.1
> 

-- 
Brandon Williams
