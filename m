Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA4CB1F461
	for <e@80x24.org>; Sat, 24 Aug 2019 22:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfHXWIB (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 18:08:01 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:53844 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfHXWIB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 18:08:01 -0400
Received: by mail-wm1-f45.google.com with SMTP id 10so11997978wmp.3
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=ZJQvMDxcKphTYFzkK6oGELuyXROEri6JJHcvLsTJ1B4=;
        b=Z/R9iN5eb1sIZm5Fctjod0NCK91mluLzUDaQQ/iKQaxwS/IWDM4oYmM55I4QOWRt4s
         MJyF96PqRRH79f5dZvh2MobPWdQ81ezPaAvA8z9TjllaFEsppYNbllC3Agi60m7XpZrW
         62VCmiXn1BNvMhbIK8WzHZnXHNTObVUqxQgUKqREqLSsa5OpzCZi+nOz5TZOSJlcxFkP
         lgtJ22yZ1OPWY/GoBqSc9v+tTn6oEHlbLCPThiKwW46NMH05Z/xTI5bXyZXs2YZl/QZi
         EVyFeK+IOEfmioummlOer2Wf4/eMMU1pMdxZ+Md3dhxaCFwrb2CRGBMpYfzS3Xt+aEih
         8mMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ZJQvMDxcKphTYFzkK6oGELuyXROEri6JJHcvLsTJ1B4=;
        b=j1sjJfmSxlT2e15ozOJyF1cOSU4G4xY4cncqZwN4dii+5fdIBzvTICI/u6OousdHrQ
         e7uxntjYl4Kx1F3iueKQgOAhLTi/9l9C42fH6KEUML39tB6WPr2kR4tN1UmkyzemW44d
         YYrGAjq+zxC3ToVi6H+5pym2ul9tSS6zr8klvP00nmfGMLh6QLTdHIXyWJxFmokzwQQE
         Gu9kORF7kfLFrxCskY+4QcMUdjwXjQ/bUbNynjvbdiwB7mw477vRaPp7qXpyEuQP5SF5
         GhA3MqBmdwr7tyuDe9WxJjUlINvafdUwcRCB5EPwPoX7hTNhEqHaRqxRCON4z+yBGZcl
         WW1A==
X-Gm-Message-State: APjAAAU/nv+avk6/U1O8USNQmKMk1w6/lP+cRjyG6xGOtlma1j0i0umt
        EI/5B8lUXgAZT1gmMd0lViNSS/v5
X-Google-Smtp-Source: APXvYqzuKjalwwsdbsQWWkqV2KNB0EweivpkHHkYSj+92sbwnJZ4Ok/r67pnzyVURr3c3Ml4Tk/G8w==
X-Received: by 2002:a7b:cd17:: with SMTP id f23mr13001295wmj.177.1566684479265;
        Sat, 24 Aug 2019 15:07:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 74sm14269576wma.15.2019.08.24.15.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 15:07:58 -0700 (PDT)
Date:   Sat, 24 Aug 2019 15:07:58 -0700 (PDT)
X-Google-Original-Date: Sat, 24 Aug 2019 22:07:57 GMT
Message-Id: <pull.93.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] mingw: support UNC as file://server/share/repo
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Windows users might think that the common file:/// protocol also works for
network shares. This patch makes it so.

Torsten Bögershausen (1):
  mingw: support UNC in git clone file://server/share/repo

 connect.c             |  4 ++++
 t/t5500-fetch-pack.sh | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)


base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-93%2Fdscho%2Ffile-url-to-unc-path-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-93/dscho/file-url-to-unc-path-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/93
-- 
gitgitgadget
