Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D288F1F462
	for <e@80x24.org>; Sun,  9 Jun 2019 09:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfFIJCj (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 05:02:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36745 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfFIJCj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 05:02:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so6168402wrs.3
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 02:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yK2LhG6YEmxgFwP7Qj7aeNJ4D+2x2xTneoIo87GTpC0=;
        b=mnuiU+wO3A8B8976tu2vI7qhPC6yRb/6NzTvJFfGmHrVuAXEcRsfx5Y15rzQLa4fSI
         IMeACxng6igCe26sixBnxBkYsSDBWuyHOPtZJ6k4qHfo2BMaUIRY6eWIrRrSb+JSenVZ
         YrIqYPkX66+my2R09mgqVcuSAjLcn2GbKcgQe563LUvWNbP9Rtszwd6oSVOe5Ox1XMNL
         gJ8HU4Kj52LG31GUEe/doMSDKfr5BvcsqA2FtWrdWsRf9l1NaKQM607+Ar28aO1cQuJF
         wme3zbn4ch9Zla+Vv0rjKFms/gcjQyCTBd4ybFfRyO5QVNAwRiQ5lWvdQ3oMGVEUBv9Q
         +7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yK2LhG6YEmxgFwP7Qj7aeNJ4D+2x2xTneoIo87GTpC0=;
        b=JIeqSr4GrmVPCFD2U73vli5iucCKRKYUhMqsp96iIedMYCHy5tm2aF8sANNDv958E/
         0iw92U6cqMqcYRJj8Up0KYWq3cGgV/kRQNmrFMApJeE1CjNj8Uo+9abcR8IX7unwvxaW
         BzmDpmn934alcyaTkVxknduj0oYSGhDyWpT50yWGQj1pQXIoVnp660qnoO7dMtp9c/B7
         WrM5QB1P392XGLA4dsDFTadqX+hz3zSEII5g6AQDD9H7/R3b2FdTCi2sLdtWUr2s2eZk
         IM/jpfzTuSfNIIwqDxF5JsQOpaRhvrYl1C8T9rscXFe00rlg/WW+Zf1N1R+mtyX1N5OB
         lSFw==
X-Gm-Message-State: APjAAAUvHP0bSIIprPsfxRykK4D+xXEcUHhBAM7swJ9VcHuTXSnXYhce
        g0h4E78bHlD6jAwb6yHldbYJ5uEiRQN9kw==
X-Google-Smtp-Source: APXvYqx2JXkmbIFxQNseqhH+hLPicZVLRWDeM0kuAfDuOOecVEcBH/lXukTEQgB5akToyHCC2nRACA==
X-Received: by 2002:a5d:5582:: with SMTP id i2mr5189311wrv.209.1560070957626;
        Sun, 09 Jun 2019 02:02:37 -0700 (PDT)
Received: from localhost (adsl-22.176.58.193.tellas.gr. [176.58.193.22])
        by smtp.gmail.com with ESMTPSA id o13sm11242272wra.92.2019.06.09.02.02.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 02:02:36 -0700 (PDT)
Date:   Sun, 9 Jun 2019 10:02:35 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [GSoC][PATCH 0/3] Teach cherry-pick/revert to skip commits
Message-ID: <20190609090235.GC28007@hank.intra.tgummerer.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/09, Rohit Ashiwal wrote:
> git am or rebase advice user to use git am --skip or git rebase --skip
> to skip the commit that has become empty or has risen conflicts. OTOH,
> cherry-pick advice user to use git reset HEAD which on the user’s part
> is annoying and sometimes confusing. This patch series will bring
> consistency between advices of these commands with introduction of
> `--skip` flag to cherry-pick and revert.

Thanks!  I found a few minor nits that I missed in my off-list review
on the PR.  We should give others some time to comment now before you
re-send it with the nits fixed (if you agree with them).

One thing that would be good to add to future cover letters is a
reminder of how this fits in to your GSoC project, where the overall
end goal is to improve the consistency of sequencer commands, and this
is one step along that way.

> Rohit Ashiwal (3):
>   sequencer: add advice for revert
>   cherry-pick/revert: add --skip option
>   cherry-pick/revert: update hints
> 
>  Documentation/git-cherry-pick.txt |  4 +-
>  Documentation/git-revert.txt      |  4 +-
>  Documentation/sequencer.txt       |  4 ++
>  builtin/commit.c                  | 13 ++++---
>  builtin/revert.c                  |  5 +++
>  sequencer.c                       | 26 ++++++++++++-
>  sequencer.h                       |  1 +
>  t/t3510-cherry-pick-sequence.sh   | 63 +++++++++++++++++++++++++++++++
>  8 files changed, 108 insertions(+), 12 deletions(-)
> 
> PR: https://github.com/r1walz/git/pull/1
> Reviewed-by: Elijah Newren <newren@gmail.com>
> Reviewed-by: Thomas Gummerer <t.gummerer@gmail.com>

Note that the 'Reviewed-by' footer is something that is "given" by the
reviewers, and should only be added after they have explicitly given
it for the patch/series in question.  Instead this should probably
mention that Elijah and me reviewed this off-list in the PR you linked
to above.

> -- 
> 2.21.0
> 
