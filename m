Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2366208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 14:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeHFQml (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 12:42:41 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:48981 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbeHFQml (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 12:42:41 -0400
Received: by mail-qt0-f202.google.com with SMTP id a15-v6so1447735qtj.15
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ei8f1iU5+lqUelJcJo6m1GYSZF6Zef38pCDgbRb6J7M=;
        b=ZXXkDLnedAu7o1m4ViR95sTIzIg7URy88k6pUh9/7GENHwWW61qptzg5C8Dc/c+g2M
         KG3ojWNcyxuZGW/6gcVxB1KSjBFS6Oxn9W21oWibLPE7+OLRg25sK+aKqBddqtbPbPX3
         nuVZ95Vs2NIjUdbtlP9Ari6Wco/tUJrjfhqSCMfp3a0wSQBxxeVwFAR54U8oKFB2pS+x
         FlnBijLRHpee/89yf90GpRQGrgpimgg8PLHkX7Hkh8ku3KoVun2gH8fMSiLofATO3jq8
         xR3SFFeqFjsn2joPsovXPUJ6mIuTXYuX1wCRh9UoeprkMwLjKyzp08nP6pVIVaRQX34B
         sLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ei8f1iU5+lqUelJcJo6m1GYSZF6Zef38pCDgbRb6J7M=;
        b=YfWle47pxqAx5+sS2wguAghTOjWCLopwtXxQnld3f20U6OglbNRcHK1nuZE49vQ1Ba
         iYmNLvIgg/WdTyLP++gLOSVdMv/eRSwDZBB0ugQTf3h01fNhjGuM4WegEh4Lto6pwhOW
         1iOzTgENW/VUKKzF/zPqEV9xZdQbt4W4NcYrS9UcyjXzu2pe04P1kzeZkxjwtchWxWd8
         lP1i55Ejfgk/OsyzTDDDiB2GBxMMkCMxB7fZ4uko1DutQSy7fba9fJx44ZBZU5tnSyYS
         rp5X62wCQfkCZTRZ3+dbsMpnAT4zeMLsGQGwWzW6z47Ac6TmELUP5GahIY2rlsSl0ms+
         MaSg==
X-Gm-Message-State: AOUpUlFe8olH5OHA34GlWDTdHjyWz6qJJnq/JAfOoTPj286sBXsLfpM4
        iTMcDfTrcfxdnvtD11SPfgYGJiVKu2A=
X-Google-Smtp-Source: AAOMgpc80fU/xOg5the+PMB1izZstMhWDThkuJeaJLB2mf1fMHptOKongarM0kyiiRX7V54y2ZmJHesUt04=
X-Received: by 2002:ac8:3fe8:: with SMTP id v37-v6mr10242491qtk.59.1533565997696;
 Mon, 06 Aug 2018 07:33:17 -0700 (PDT)
Date:   Mon,  6 Aug 2018 16:33:11 +0200
Message-Id: <20180806143313.104495-1-hanwen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v5 0/2] sideband: highlight keywords in remote sideband output
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     gitster@pobox.com, sunshine@sunshineco.com, jrn@google.com
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Address Jun's & Jrn's comments.

Han-Wen Nienhuys (2):
  config: document git config getter return value
  sideband: highlight keywords in remote sideband output

 Documentation/config.txt            |  12 +++
 config.h                            |   7 +-
 help.c                              |   1 +
 help.h                              |   1 +
 sideband.c                          | 126 +++++++++++++++++++++++++---
 t/t5409-colorize-remote-messages.sh |  80 ++++++++++++++++++
 6 files changed, 216 insertions(+), 11 deletions(-)
 create mode 100755 t/t5409-colorize-remote-messages.sh

--
2.18.0.597.ga71716f1ad-goog
