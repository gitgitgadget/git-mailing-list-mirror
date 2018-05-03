Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F822023F
	for <e@80x24.org>; Thu,  3 May 2018 18:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeECStA (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 14:49:00 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37608 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeECSs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 14:48:59 -0400
Received: by mail-wr0-f195.google.com with SMTP id c14-v6so18645819wrd.4
        for <git@vger.kernel.org>; Thu, 03 May 2018 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aJkSANGI7eH8aPq+NI/tVQWq6CX6Nsb20m7LVtycTAk=;
        b=cAWEOy8d3jebxC97p/AxlSaVjZZ85UiKpu3FgZrnGsQFnk9sKoMDMtU/tCAvAodOPX
         /YxhHF2q60EPKVwtPpvNg9Unr7iVbjcH71fInjW9EZvcZFpf+WVFQQIQd2qlnq/uScLS
         9rTpu3fQCQLa7up3XLLBtKlOACnpeXEcbuGvCaChwoEHuYcybo75WgzpUks8raX/bDmA
         vRSLjL6h2yjfeQKcepxD4GpiU02faBnbfYk0KLQ2CX5o/DR/Lh5aHyKIItm6tIPSLHQ3
         l2S+BKo/C/AoilIlm13a8sw4Y3bqnq1sP7w6TCQ5WsCMmkWelxjfZj6ONiCtmQP8tnBg
         QcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJkSANGI7eH8aPq+NI/tVQWq6CX6Nsb20m7LVtycTAk=;
        b=QHiciOFfvD63ZhPmpjKsUCGzAHQMZ7GbXpl5rdBrBM9hdsoK16XVftVLPeXwA5RYQy
         j7Z8cEn0EXz76X5ZVZvGwxXOc6n19s4CXZaM1tWCr6Z2R5ljMoCTiwEzzQstoms4JFJb
         khqvsH4e812w94dmRs0HBSMU6GcnY/v5Gk2E3225BCQvKtej2/j4Xb/avjq1wpcMVwqz
         MCBJLdnMjA2rdqAWD2f7TvJoldfo6cJsSoGXpiF1+fS/oMoTnsMGfIVSZK+hTK1Wfg8+
         +DPiyhkNPkbjUoc7friHxSjyx/qMySyVZ2HcAKxkYGNVI3T/K0QWBuHiI2L1Z/9Sf+d3
         j31A==
X-Gm-Message-State: ALQs6tAtyz5WzJ5t7jo6vmbWes9POMlz0XepsXiJyREmnia+P0YLuTxJ
        tfoJuvjKHVc400w04LhTgiapOg5G
X-Google-Smtp-Source: AB8JxZr2cmNSx9/HxufUUzy7LMatPOXNBnIAsyMEP0QTlSsa/J5kC39hRPSYZeYUxY2TqEWOlSh7QA==
X-Received: by 2002:adf:96c2:: with SMTP id u60-v6mr19760137wrb.204.1525373338126;
        Thu, 03 May 2018 11:48:58 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:a521:6b31:5c87:9e4b])
        by smtp.gmail.com with ESMTPSA id f83-v6sm198322wmh.32.2018.05.03.11.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 May 2018 11:48:57 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 2/7] doc: align 'diff --no-index' in text and synopsis
Date:   Thu,  3 May 2018 20:48:25 +0200
Message-Id: <20180503184830.11889-3-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180503184830.11889-1-asheiduk@gmail.com>
References: <20180427170440.30418-1-asheiduk@gmail.com>
 <20180503184830.11889-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the two '<path>' parameters in DESCRIPTION mandatory and
move the `--options` part to the same place where the other
variants show them. And finally make `--no-index` in SYNOPSIS
as mandatory as in DESCRIPTION.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
Reviewed-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-diff.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index b0c1bb95c8..6593b58299 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git diff' [options] --cached [<commit>] [--] [<path>...]
 'git diff' [options] <commit> <commit> [--] [<path>...]
 'git diff' [options] <blob> <blob>
-'git diff' [options] [--no-index] [--] <path> <path>
+'git diff' [options] --no-index [--] <path> <path>
 
 DESCRIPTION
 -----------
@@ -29,7 +29,7 @@ two blob objects, or changes between two files on disk.
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
 
-'git diff' --no-index [--options] [--] [<path>...]::
+'git diff' [--options] --no-index [--] <path> <path>::
 
 	This form is to compare the given two paths on the
 	filesystem.  You can omit the `--no-index` option when
-- 
2.16.2

