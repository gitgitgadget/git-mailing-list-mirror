Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86B5A1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 00:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfAVA0l (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 19:26:41 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:39505 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAVA0l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 19:26:41 -0500
Received: by mail-pf1-f178.google.com with SMTP id r136so10855445pfc.6
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 16:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=njOumbU2qf7Vi/kwUmPtFgA05sFxqU3r2WXYwSyGn+A=;
        b=tnttgsghypHhTrMnbY2gfWiblDvMcIRJvck/nja1/zGQBYlGNLstdpGGNycwYu2nOJ
         x4E8FsozJKVD8qsGZXsJxV6JxQ+7thzLOI/fQSOwbv5BlZNMk22NRzqHVRsdF/DY+f6/
         9ocgnDFAa0TDugBxB4LUS/BvPCCpOzMhHP+1AzSGkjSaKRnBuwXKpvu0krgcFlx6G2cd
         B4OCaPrFh2fnkkfYo3bkpSsU54DtuqLU/V/RXQAtTxzK9WzrjfzMUjRrUDPdRUFW+WVn
         5L/Ez2SjjipTGuDRqRWTWrLcl8V6kDUkdIoru3/1ieJc4bwBuIVK25G4wempheBjm05V
         j0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=njOumbU2qf7Vi/kwUmPtFgA05sFxqU3r2WXYwSyGn+A=;
        b=penSH+iRdzJ17RVEsIVeIRMrY9pTNsjYUiDSTC/SKJQNPYjr07bd7mCrlmH6Rbf5xs
         kLBpcS/bK7ly8X2eh/5v+ZNGor15NIuFBSb1G3VJivUj1sKIM5ldOmJCQ849Hv8SneFh
         xg/MM2yg307UvVNzfwLZiky3exQ+70+KOw/K4tPTgkF8wI6n256uPRG7YBSnhhX0M6Sb
         s58UNlA7hp5TWVZpyWkgQ8vkeWaLBThty4ImYp+BnWYi6t0Xkc0OpRLPHTNYGJd33tEc
         y77BYNEh/UlIMH1RZDHJQA2v66X8jQvvixKInqyWS+d1HANuNehGDLt5VsogUMuGuutY
         Tc0Q==
X-Gm-Message-State: AJcUuke48Ta8q1L5vw6/oTK9OQP/LQaNATHlXzeagYptCjBWITQ/5tkW
        3fclpfkO5VWW46ZClph6GycH8v5l
X-Google-Smtp-Source: ALg8bN4j4HfRI+s2hX9kyvxxojMXDz6kU49SVz16h+YGeT2ZRNe1ow53rn1mWca7i72Wjs6v/lV7Xw==
X-Received: by 2002:a62:cf02:: with SMTP id b2mr32620170pfg.183.1548116800361;
        Mon, 21 Jan 2019 16:26:40 -0800 (PST)
Received: from dektop.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id u123sm21306640pfb.1.2019.01.21.16.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 16:26:39 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/3] nd/diff-parseopt fixups
Date:   Tue, 22 Jan 2019 07:26:32 +0700
Message-Id: <20190122002635.9411-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let me see if I could just fix up this series on top like this.
Failing this, I'll break it down and resend in small chunks.

This redoes a85e5a0108 (parse-options: allow keep-unknown +
stop-at-non-opt combination - 2019-01-17), deletes dead functions and
rewrites b9b760ed1c (diff.c: convert -B|--break-rewrites - 2019-01-17) a
bit.

Nguyễn Thái Ngọc Duy (3):
  Revert "parse-options: allow keep-unknown + stop-at-non-opt
    combination"
  diff.c: delete unused functions
  diff.c: simplify diff_opt_break_rewrites()

 diff.c          | 74 ++-----------------------------------------------
 parse-options.c |  4 +++
 2 files changed, 6 insertions(+), 72 deletions(-)

-- 
2.20.1.560.g70ca8b83ee

