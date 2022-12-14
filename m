Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45073C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 01:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiLNBiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 20:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiLNBiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 20:38:16 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AFA15FF8
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 17:38:15 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x2so493934plb.13
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 17:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlUlSlA2gWvKKYYfyMis53ay1l+md1H2ybY6EfSNtw0=;
        b=XFvTQKHiXQrbRBcgRUfmAj+ktHqLawyAj4BJTDl3bmw5AIv0b0neFUZG9UC/tgDrNG
         zg1NYA+SXgdfWBJUj/WGjN+kxjRYd2etiG5nQfivdVXPFORCOhE1ZpUd7uzUSwleD420
         fnXairFXjruNEKWnIDbIVPWMY7dp9KqQg4yIrkYnE+06X+5JjAAieuwqyyAp5qtbbcN6
         JJo1oD4z//9jnLHpldd9O7FVcmWi5bA+RQZGKC0lp+K3JcnAzd8+jEAyWViu2Nf4E4r0
         iUy+upWt95S4jmC1nDPz2VWxX6hG20Be+NLdPA5xCconLEa0MGfsZAWSuRbbJ9B8kL4b
         oYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mlUlSlA2gWvKKYYfyMis53ay1l+md1H2ybY6EfSNtw0=;
        b=sZGPe895DThBLHy29rjyxA6PEWOAgotbEs8fYMW/4dY3xoBsCD2EpGs5BA39tGZQSE
         Cp9LND9kGPCaVCRR019WsArTPC9nWzg/zAYW5VlBaaosC07ChDxEkIvxm5aX/A/YR6SD
         FpvMfuBvDaGxftQT+csNo1aKDGBGLiQsVRvLwCrYiV8ETsjHpEDI4XtVLSY0cpAWx+zM
         dLKHrSu04EitHOfqvluVZihQR11TMQqj6XLiRUhp5vPjlVLY50BksHmqZHdX/7SEmbtK
         yWfGCno3umz5lUFsqXl/3Oi+ZEw5NNjoXj94Zin7AGHSStEOzaYeEDVlf07k3JyvbrVu
         UgJA==
X-Gm-Message-State: ANoB5pn/YFBqH7sBQeEiUhmSIzCguhzsGQCN5hSSmtT6szeYfYSVl/Fq
        Ph5k7+t28yLOvdtmLYqIWNZvmc7Mb3lDLQ==
X-Google-Smtp-Source: AA0mqf50bm9EN3lWHDf0bfBSH5n5VrDCdA3BvZjj4lqEL4PwAhJ3ehYU68mDM9fHhf6QUACILlQJcA==
X-Received: by 2002:a17:903:2412:b0:188:82fc:e277 with SMTP id e18-20020a170903241200b0018882fce277mr23101656plo.12.1670981894660;
        Tue, 13 Dec 2022 17:38:14 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c21-20020a170902b69500b00186b549cdc2sm516898pls.157.2022.12.13.17.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 17:38:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/9] more -Wunused-parameter fixes/annotations
References: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
Date:   Wed, 14 Dec 2022 10:38:14 +0900
In-Reply-To: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 13 Dec 2022 06:10:54 -0500")
Message-ID: <xmqqv8meydbt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This was supposed to just be annotations, but after staring at a few of
> the cases, I think we're better off removing the unused parameters. I've
> floated those ones up to the top of the series.

All looked sensible.  Thanks.
>
>   [1/9]: ls-refs: use repository parameter to iterate refs
>   [2/9]: blob: drop unused parts of parse_blob_buffer()
>   [3/9]: list-objects: drop process_gitlink() function
>   [4/9]: ws: drop unused parameter from ws_blank_line()
>   [5/9]: xdiff: drop unused parameter in def_ff()
>   [6/9]: xdiff: mark unused parameter in xdl_call_hunk_func()
>   [7/9]: diff: mark unused parameters in callbacks
>   [8/9]: list-objects-filter: mark unused parameters in virtual functions
>   [9/9]: userdiff: mark unused parameter in internal callback
>
>  add-interactive.c           |  2 +-
>  apply.c                     |  4 ++--
>  blob.c                      |  3 +--
>  blob.h                      |  3 +--
>  builtin/add.c               |  2 +-
>  builtin/fast-export.c       |  2 +-
>  builtin/merge-tree.c        |  2 +-
>  builtin/merge.c             |  2 +-
>  builtin/rerere.c            |  2 +-
>  builtin/reset.c             |  3 ++-
>  builtin/submodule--helper.c |  2 +-
>  cache.h                     |  2 +-
>  combine-diff.c              |  2 +-
>  diff-lib.c                  |  2 +-
>  diff.c                      | 18 +++++++++---------
>  list-objects-filter.c       | 30 +++++++++++++++---------------
>  list-objects.c              | 33 +--------------------------------
>  ls-refs.c                   |  5 +++--
>  object.c                    |  5 ++---
>  range-diff.c                | 12 ++++++++----
>  ref-filter.c                |  5 +++--
>  refs.c                      |  9 +++++----
>  refs.h                      |  6 ++++--
>  revision.c                  | 25 +++++++++++++++----------
>  submodule.c                 |  2 +-
>  userdiff.c                  |  3 ++-
>  ws.c                        |  2 +-
>  wt-status.c                 |  4 ++--
>  xdiff/xdiffi.c              |  2 +-
>  xdiff/xemit.c               |  4 ++--
>  30 files changed, 90 insertions(+), 108 deletions(-)
>
> -Peff
