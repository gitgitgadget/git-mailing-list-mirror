Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F551F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 12:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbeGKMmU (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 08:42:20 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33794 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387568AbeGKMmT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 08:42:19 -0400
Received: by mail-pf0-f194.google.com with SMTP id e10-v6so18343890pfn.1
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 05:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=PxPymw2JYmh8EHGXwdsNl3AHrPMBBhBBOQRyyHq7+Ys=;
        b=kpW4r12aC+/DdG0cWK8ypO1tVN3/kOp8qbyw8RqjMnqsUgn5DX59A5mEVLPD7jEsZw
         e+5p/xb7JekxbKPYxr7iHrTIfibTiW3CWs4KrU5Gq76L6vdpvHCzvWa16Oe8MNj8YwTs
         Hzr28HvFm3mGAud5TwgNK6OSMdBSJalB2y1LCfJ2wmpPVuc1kfNVA93zATfvWGXGCbLt
         5TW+N03Homq5vqvEiRNK4PKOpmeK2nJPPa91LqZ5BwReMVTKlAY5cL0LIFcRw8n239ga
         HtTKV0P+Y/QXPCZ0g3BDhC0z3jkQQq5exo6zr0ngt/86Fm0OKmom03wsddBGA0jDjGtn
         kPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PxPymw2JYmh8EHGXwdsNl3AHrPMBBhBBOQRyyHq7+Ys=;
        b=Q0BNbunY29Uo/LGZvEhyO0pPentKwNQTU9XVA7eJFkjlbpEGn9yud5XdWbNi5J+1zD
         85xjDnj0xEFWBLCx574G+WNPOGAhSVSuSUPdnQsqXbE21rrd2SS0BlAZsF39xgPnTOb4
         Z6ziAInFy7mWQdwsA5zDqWeYe35VsrFWXAMdOi5D/xSU1nUVVpWgYSPTV8Rt6MMq24oE
         po2wwoiIeRgR14KoRmnG9fywl7KWgtjStDzppgwYZuphRFptiSpQNHVSYhqft2d7wLmJ
         hqAA4nHtiP/4tXCvV7kElyMW3Qi7hFyM2pgEjsivKBvX7viIzwUmiEEQWzNH+e9Vxlws
         kfrQ==
X-Gm-Message-State: APt69E3pXcyz7xpG+owuUcnbiyDSXbtlTLngdu50+LmLdx0kEYL4f7c6
        /cZguOpxJRZzKUHZM7PFMuAqHA==
X-Google-Smtp-Source: AAOMgpciE925ztscIPJclbyb3h/txKN/9jPuyCdGT1F1qHmq3APWRG2zIZWWHZq54O7ojIRVLrivyg==
X-Received: by 2002:a63:a502:: with SMTP id n2-v6mr26900895pgf.263.1531312691572;
        Wed, 11 Jul 2018 05:38:11 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id a17-v6sm12596649pfg.106.2018.07.11.05.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 05:38:10 -0700 (PDT)
Message-Id: <pull.8.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Jul 2018 12:38:09 +0000
Subject: [PATCH 0/3] rebase -r: support octopus merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `--rebase-merges` option of `git rebase` generates todo lists that include the merge commits that are to be rebased.

To keep things simpler to review, I decided to support only regular, 2-parent merge commits first.

With this patch series, support is extended to cover also octopus merges.

Johannes Schindelin (3):
  merge: allow reading the merge commit message from a file
  rebase --rebase-merges: add support for octopus merges
  rebase --rebase-merges: adjust man page for octopus support

 Documentation/git-merge.txt  |  10 ++-
 Documentation/git-rebase.txt |   7 +-
 builtin/merge.c              |  32 +++++++
 sequencer.c                  | 168 ++++++++++++++++++++++++++---------
 t/t3430-rebase-merges.sh     |  34 +++++++
 5 files changed, 204 insertions(+), 47 deletions(-)


base-commit: e3331758f12da22f4103eec7efe1b5304a9be5e9
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-8%2Fdscho%2Fsequencer-and-octopus-merges-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-8/dscho/sequencer-and-octopus-merges-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/8
-- 
gitgitgadget
