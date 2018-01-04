Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B80A1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeADWkM (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:40:12 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43212 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeADWkL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:40:11 -0500
Received: by mail-pf0-f195.google.com with SMTP id e3so1383417pfi.10
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 14:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BvboDrLvqgI5l/HD4EP/qUyJyo94+uYhJgWUDDaa6JE=;
        b=Ei4HfvhrY6j6nTvm1sOzjbGigL6dpuqfn7JqlB0M75RIB9IKgAfvVUHom/uvh72yKU
         ZPa1LZpG1WJ+TfFeVn9fAVOrVuLFs5GTXsjPMxmYarroNbPZ84rp8BHMci6B8I7B/XGo
         UnpuEiQy2VfXarTZl4lln0Mo8mtTev0QDMtA58c2BBtQ06zWwCF0Sur11/fwohCIAs3a
         bVR3hpzUtXl7efrTmU9gyD6H0b1c0/4Zd1y1w+Rksut6QAgOn8sUMdIJYLeD2HuXiMel
         OyD6Pn5XWNR0iW7yEK5n+9vw9vP183UJ0ysvtXlGUWg+ch7SS1WIT3pqMM9YlDSuNK7M
         xDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BvboDrLvqgI5l/HD4EP/qUyJyo94+uYhJgWUDDaa6JE=;
        b=NvWcLR2YGXmorbozyKNeWP6PtEReHyukW0BsJVaIxhoGDC8VpT7iCgIJPi88YeNMOL
         pSONaMmePHgV2oBQ/8AC2EoCMQlQJ15CM+IdIg72XlrU9rg1VbdSQ/uFblTeVFagHDJ4
         IxyudIuyb7X2UXCbE4r9TIKYKbMAAuZLxrxBp9suVoQWm1qm8ZhC7uyWEfYQvhKXTOc4
         KZE+BvlfZh8FdgEDCPXdXjlQEc4ER++QxBkFm9i05VFD+TY4BvnEISFYr+4lhwli6L5N
         EHmcp+EUpg8VsyypIlZ/CC/PiWQ2+tPYiDDBtmmkelH21g5Pjb1EM0qe7RmQj4LnfBG1
         O1qg==
X-Gm-Message-State: AKGB3mLJTl4I7IOiidioSra3NzXfhxxuPTOguaauj/2D1Jp+RbfFfQGe
        jhy550fFhFUhyrODf5JDYzYdJZ6EBRE=
X-Google-Smtp-Source: ACJfBosJg0JCmZDFp+l0f8cHH5gfSoIlPDc/1U4yXYJdwNDLqUvWfNyPF8Jbsco6OU+1wmqlew3nvA==
X-Received: by 10.101.77.195 with SMTP id q3mr826073pgt.436.1515105610722;
        Thu, 04 Jan 2018 14:40:10 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e87sm10385259pfd.165.2018.01.04.14.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 14:40:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, sunshine@sunshineco.com
Cc:     git@vger.kernel.org
Subject: [PATCHv3 0/4] blame: (dim rep. metadata lines or fields, decay date coloring)
Date:   Thu,  4 Jan 2018 14:40:03 -0800
Message-Id: <20180104224007.214548-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20171110011002.10179-1-sbeller@google.com>
References: <20171110011002.10179-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3:

Thanks Eric for feedback, I implemented all of the suggestions.
Specifically I dropped the abstractions in patch2 but keep around a similar
abstraction in patch 3 as that still looks like it benefits (the condition
is just growing large).

Thanks,
Stefan

v2:
This is picking up [1], but presenting it in another approach,
as I realized these are orthogonal features:
* dimming repeated lines/fields of information
* giving a quick visual information how old (as a proxy for 'well tested')
  a line of code is.

Both features are configurable.

Changes from sending it out in November:
* better commit messages
* rebased on master

Any feedback welcome.

Thanks,
Stefan

[1] https://public-inbox.org/git/20171110011002.10179-1-sbeller@google.com/

Stefan Beller (4):
  color.h: document and modernize header
  builtin/blame: dim uninteresting metadata
  builtin/blame: add option to color metadata fields separately
  builtin/blame: highlight recently changed lines

 Documentation/config.txt |  23 ++++++
 builtin/blame.c          | 201 ++++++++++++++++++++++++++++++++++++++++++-----
 color.c                  |   2 -
 color.h                  |  59 ++++++++++----
 t/t8012-blame-colors.sh  |  56 +++++++++++++
 5 files changed, 305 insertions(+), 36 deletions(-)
 create mode 100755 t/t8012-blame-colors.sh

-- 
2.16.0.rc0.223.g4a4ac83678-goog

