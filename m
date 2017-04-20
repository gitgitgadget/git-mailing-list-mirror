Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C95A1FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 19:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947136AbdDTTlg (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 15:41:36 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:32871 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947119AbdDTTle (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 15:41:34 -0400
Received: by mail-yb0-f171.google.com with SMTP id 81so36169477ybp.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OI5QHIpOQj6IPIsGYPXPNiqCWxU2hH2EqIpeL8lsLmI=;
        b=KM5dG/2LEV9FH+DY2A7WCHusPNlZVEstE1bHyA3ln52UkUQHyHMHFlxCjalXVs5M9L
         JMwCZ5J1GW3ZuS3yzI/w9mbYe5BEhdPhLhn3I0O2LtAn1EUxfnDiZ3NAY9cbOoJcSdwh
         FqFShQdXnyHf7L8wpPrPsg4Lj165q2PT0dLhl5lyH8M9RQ7hORjCktuVmOSS8nzXwHB/
         cxLGFeM/tmWQfWpHuKAOpN+3uPiDazY5c94bKEQp8GKs2S1tHl49XygM7PDGuuDhxxoP
         CywDR5C1uMGpJi/+swH8xG37S8V4ZIiv4MjwdxEzLqlU4VZD+HWxTlBgnKjzwnzJOUra
         nWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OI5QHIpOQj6IPIsGYPXPNiqCWxU2hH2EqIpeL8lsLmI=;
        b=DuFY2kwt0RNR1/02j6w2OXvpbyRNqobtlp57V0n2NAaO/D/cPb4gNsIuMOPu5NC2a0
         x8xXkeRVPPZbdWOWDmIFwpHSch/ZRN2MLIT5xThMpiyYt8VtkSVqsHXzCPXQ38n7dNK5
         lvsXf/SsFdG3iWSosbmJHOCxM7DMgJ5/dDA4l3886OQzg5MkxNx7vMUd5LX8lksIN3kf
         A34g/ENg0e5zymuo0EbxbI6PJcYA11Np72viwyZo/3Cky4FQHMUbkw4HxInw9kigVab1
         TbbWUfBltYroJIw49acRyt2Et4kvSMKg/dEysqUv2A/zXwNapqnxmWeIC5kEC4MmCNhM
         tDEw==
X-Gm-Message-State: AN3rC/5qVKiZdKkUMxFTjTTH1wACHXK21GI+yJJz63uDt7nmtR6Th88U
        S7Voss2r2vsX92q0
X-Received: by 10.98.16.6 with SMTP id y6mr9320332pfi.210.1492717293126;
        Thu, 20 Apr 2017 12:41:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:90d3:adf:57a8:ebdc])
        by smtp.gmail.com with ESMTPSA id q1sm11954765pfl.89.2017.04.20.12.41.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Apr 2017 12:41:31 -0700 (PDT)
Date:   Thu, 20 Apr 2017 12:41:30 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, philipoakley@iee.org
Subject: Re: [PATCHv2 0/4] recursive submodules: git-reset!
Message-ID: <20170420194130.GF142567@google.com>
References: <20170418213725.7901-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170418213725.7901-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/18, Stefan Beller wrote:
> v2:
> * improved commit message to be proper English (Thanks, Philip!)
> * clarified why the patch 2 is so short (i.e. it doesn't matter if the submodule
>   is initialized in the preparation repo, we care about the actual testing repo!
>   Thanks, Brandon)

That was the only thing I was unsure about in v1. v2 lgtm.

> * reworded patch 1 (Thanks Jonathan)
> 
> Thanks,
> Stefan
> 
> v1: https://public-inbox.org/git/20170411234923.1860-1-sbeller@google.com/
> 
> Now that the BIG one has landed, e394fa01d6 (Merge branch
> 'sb/checkout-recurse-submodules', 2017-03-28), you would expect that
> teaching to recurse into submodules is easy for all the remaining 
> working tree manipulations?
> 
> It turns out it is. See the last patch how we teach git-reset to recurse
> into submodules.
> 
> However when thinking more about what git-reset is expected to do,
> I added tests and some fixes for them (patch 2+3).
> 
> patch 1 is a correctness thing, required for patch 3.
> 
> Thanks,
> Stefan
> 
> Stefan Beller (4):
>   entry.c: submodule recursing: respect force flag correctly
>   submodule.c: uninitialized submodules are ignored in recursive
>     commands
>   submodule.c: submodule_move_head works with broken submodules
>   builtin/reset: add --recurse-submodules switch
> 
>  builtin/reset.c            | 30 ++++++++++++++++++++++++++++++
>  entry.c                    |  8 ++++----
>  submodule.c                | 31 +++++++++++++++++++++++++++----
>  t/lib-submodule-update.sh  | 24 +++++++++++++++++++++---
>  t/t7112-reset-submodule.sh |  8 ++++++++
>  unpack-trees.c             |  7 ++++++-
>  6 files changed, 96 insertions(+), 12 deletions(-)
> 
> 

-- 
Brandon Williams
