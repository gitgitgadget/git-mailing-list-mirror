Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FF461F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbeHIAzL (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:55:11 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:51970 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbeHIAzL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:55:11 -0400
Received: by mail-io0-f201.google.com with SMTP id w23-v6so2805380iob.18
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OpE47SeUyDtgCvBbnTNyUzr5pUikWpV98dIUhcFaE68=;
        b=ZugAdK6DDxzr9vcVjs1MsrcEZnLq0FXAmnN3MpDVHNwJb2TJWw/yv8OJKMx2QPOEUX
         eAe36oQ+uzIt5k+B2xl2HGEjo+T5Gr4ntXDDcoYP2Dha1QIT3UhGKbmtLlaQvMfJkNCU
         CwMd+W/AOnPjC9NqqS6y1Q6/rKfc/sNerADPS2Im0mE9cu0qUzlLR8WKpm65CgR5puB9
         OFwm4ZF4aNKaac7E5e+t23UMXc19yWFr0aH3YZure1dy0NLlOU11xzy2/WYwUck6QQYH
         qe/IwmQFeTpXmAnnEXXMhXWw8M8//b9Ni46k2hSkqg36I2/XNx/5LFrjGhfnlxKV5lUT
         eyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OpE47SeUyDtgCvBbnTNyUzr5pUikWpV98dIUhcFaE68=;
        b=CzP0myBEaJJvahx+5fJJ8oWE3k0uws/y7bkcFDnsY9y8Tn1sT6k8PxiQC4YUN7WglH
         NHN0DlDWrulsToA+bmpbeVK3A/aIV+g6I2nIGpgXxzHl2qPI1F7siFsnbPfiboNQGdnJ
         7lGdpDSWNOkHH1u4xXn+EerSqppDqpOFpjaJEiARysxf720gvXEKslWL2TANLLBmmpfu
         qXy3Q2szi1zXSITu8yaAenFIwZHLl5BJaJdpNC0kTTBv2aJPtB98kkqoU9u7/ulLaw1/
         u+SqrxW2H0hJOXvErCoVwuokIZvSneu/4GdioKfGuAMO+LvYBYCwJzJmG/oYrJV7LvTD
         GFbA==
X-Gm-Message-State: AOUpUlHV5hkyuQBSGUnrRzQxyZoaAXSeHYIhtDNYfHv78Yj88/ppcTDG
        nHFfEuFNUO7C3zmrX0xp5jeG1L4H/Uy2RsCE/s8lHorV5KLhFZ/BjlVWZ7BlOWrORq/w7eWoSc6
        dxsV5DBaiMa3Iy5ZkLWZi4ZuEAcMqkYSnDlZxhnKSeVJCUuI67XDOFV08PQ==
X-Google-Smtp-Source: AA+uWPxE6iXUJsfZNfRZ+VzcxbJGPyItRawZG1mggAf7qV5ILHLPa2VqIXHlye9/sssfuiVioL5idhZlPcw=
X-Received: by 2002:a24:700a:: with SMTP id f10-v6mr10329itc.40.1533767606843;
 Wed, 08 Aug 2018 15:33:26 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:33:21 -0700
In-Reply-To: <20180807230637.247200-1-bmwill@google.com>
Message-Id: <20180808223323.79989-1-bmwill@google.com>
Mime-Version: 1.0
References: <20180807230637.247200-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 0/2] munge submodule names
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a more polished series taking into account some of the feedback
on the RFC.  As Junio pointed out URL encoding makes the directories
much more human readable, but I'm open to other ideas if we don't think
URL encoding is the right thing to do.

Brandon Williams (2):
  submodule: create helper to build paths to submodule gitdirs
  submodule: munge paths to submodule git directories

 builtin/submodule--helper.c      | 28 +++++++++++--
 dir.c                            |  2 +-
 git-submodule.sh                 |  7 ++--
 repository.c                     |  3 +-
 submodule.c                      | 67 ++++++++++++++++++++++----------
 submodule.h                      |  7 ++++
 t/t7400-submodule-basic.sh       | 32 ++++++++++++++-
 t/t7406-submodule-update.sh      | 21 +++-------
 t/t7410-submodule-checkout-to.sh |  6 ++-
 9 files changed, 126 insertions(+), 47 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog

