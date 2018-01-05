Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4948B1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbeAEUVX (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:21:23 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:41415 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeAEUVW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:21:22 -0500
Received: by mail-io0-f196.google.com with SMTP id f6so6952683ioh.8
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=llZxzPhOJp12CbdrJxNIM70i9y+KJW27p/lR6EFb+ZE=;
        b=e0B+I5+qEtOyWRiH+EMCxh9WtDLUJvXCERcz0fSJD6b9I0IDhp2A9LChjKO1AzN+Et
         dbMLqHIlFMAuyde5GbwS/0JBGvPeknIl+sVBNMlG9GiKjzRgLHqsnoU60GBmzF1WUcdG
         MBMAzkPX5zbIYu6P+0QJfMt7siM1S38xBCX1hAvbfIqlJ3QcrzEKUOBdz8XrGlsn/RWg
         0NxkjFK1th40jJx7AafXYWJuR4t90o2Pr+irgqEudmVlGK1XYd/iKJB4vkfUYMxdQqI0
         pyMItCWHa6eKdL8pIQwr1Xo5t1MwMD2YIFNZh9/Y1pKoyKeXJfwu3L/vswZEynVUZ9ol
         2qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=llZxzPhOJp12CbdrJxNIM70i9y+KJW27p/lR6EFb+ZE=;
        b=En/29LRh2vv7iK2+YGhCxdK6zfvXcGY35hGdQAM91TQDPTGZwTYkILLXIYKNtD1NrT
         QNjxiBaxDuU55+cu0oCeFrr4ctWCRO0KA4jxW3R2pwfjWc7XtohZRS46mcLFMOaud7FV
         jg5pZ8dOwMeS2oUyJ6l4F1Jz+V7fGlKj1TbF0IW5HTG8x8yXCuzjcewR64VyMOsNMoUM
         Opkm8bWqICYnMjFlvzroPKezZJhQEh1QWIIcqOs6eTpahfY3ReNDv3CB7r97Q3hTMq5K
         VIDGZijSe/m/SQJMXmtZU0I5F77E3CFHYrx4MujQK3d6BfUD9csioTJ0bfDIVXwD1GhD
         otsQ==
X-Gm-Message-State: AKGB3mK7/B1JZ6sBqNyWd0JFChdr4BrRt88AXsl/csGtQbnNPPExWDcY
        EiVA8Vi21UQshI8PCWhRnGw=
X-Google-Smtp-Source: ACJfBovQcaWHmN6TxfeMw8sWqYu484VW3BbmYVfPlgSH1N7FTJP2YrM9XsT5nv5ufQtGmrl9wC7CzQ==
X-Received: by 10.107.83.12 with SMTP id h12mr661261iob.18.1515183681856;
        Fri, 05 Jan 2018 12:21:21 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id p68sm3876894itc.26.2018.01.05.12.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:21:21 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/3] Some small fixes to merge-recursive and tests
Date:   Fri,  5 Jan 2018 12:19:58 -0800
Message-Id: <20180105202001.24218-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These three patches were the first three from
en/rename-directory-detection[1], but as Stefan suggested[2], I'm submitting
them separately as they are independent fixes.

Change from PATCHv5-rename-directory-detection:
  * Split from the rest of the series.
  * Added Stefan's Reviewed-By.

[1] https://public-inbox.org/git/20171228041352.27880-1-newren@gmail.com/
[2] https://public-inbox.org/git/CAGZ79kapuEKLO4RUUPVS6_-aeBERDhjpBAtmK=gycT8GaK2bFg@mail.gmail.com/

Elijah Newren (3):
  Tighten and correct a few testcases for merging and cherry-picking
  merge-recursive: fix logic ordering issue
  merge-recursive: add explanation for src_entry and dst_entry

 merge-recursive.c             | 21 ++++++++++++++++++++-
 t/t3501-revert-cherry-pick.sh |  7 +++++--
 t/t7607-merge-overwrite.sh    |  5 ++++-
 3 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.14.2
