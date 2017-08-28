Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5CE208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 20:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbdH1UG0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 16:06:26 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36530 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdH1UGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 16:06:25 -0400
Received: by mail-pf0-f181.google.com with SMTP id z87so4114980pfi.3
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VmruFECQc3BjpYnKnKQW4fP60fqraTdnMuumE0Erfs4=;
        b=rYiPCDveb5kPioQtpUVYspDpjaIyNobTWtCVUjx1wxPlgG4XgXLeyqmwxeIwBb/9PZ
         Rx7SIu/SXqMpChxj99S+dZe29RBdFVKyLbVanRiKg/ya5Yxup201X8dgL0391qh7m0WI
         LOUSdLdxjhTC7uZm8ZrnTOs0XT/JiUX5XNrM+M5oC9TT8TFmrlw+nZtSG1atExF4Yfv2
         bIGfT3fvVMopUCqU/0ejmnf3PXyfUnBrb1iRDgkFQT80L1+WadlRhmRp6tF5WKAA19tv
         iQWtd4r5piydEkNqPMhMMA3lbWhKlUmZhpLbqj1fh1pZB7femVBgUz9nE8FaTBUr0Cw9
         Uf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VmruFECQc3BjpYnKnKQW4fP60fqraTdnMuumE0Erfs4=;
        b=ErWzuRtuLzdH2PAGdCErzPcx7zeEf2WNPQJzl+nfGX4hDfaop3bMyRpARqz+0kF4q5
         BNhpBEbPyxUAWrinuq2qnRpfSLcNh/R8pXvx+3YKmkA3AGgn72EILoqddnZSXc1WyPQb
         FeJkBiliANuFP+D3pdONSt7m1RqpM1GvwEuXHu/OU3tiXK0M/0SfaF2mK5JmILvFjdYa
         WursoUv3BGyQ0VU+GFKtJ8QrTLHgmXt9xMMI3x6Tu0JaY6v+OUEBXk02VIk+4lvGj1pk
         mpGT/flyl5HGdSlT2FfjdOSZpq1KSyYVscO5PGmzpADekNaM165TdE9NLZWrD91qBJpw
         v7Nw==
X-Gm-Message-State: AHYfb5hO3IbfCyKMNP2iAeTHFiwVfa8IXpdDsu7boo94VcBdx/OhYqHQ
        7gLrw5aQtqLd3GT9Q28Ghw==
X-Google-Smtp-Source: ADKCNb7zUM+6QQJ4GxjgCLlcIN/rpB9xNiHR5VAmxWapdazisoAMWy3Ijw7/hdAETc5l2LuPo5j+Kw==
X-Received: by 10.84.224.207 with SMTP id k15mr2059089pln.91.1503950785021;
        Mon, 28 Aug 2017 13:06:25 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id l3sm1772834pfj.137.2017.08.28.13.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Aug 2017 13:06:23 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, kewillf@microsoft.com
Subject: [PATCH] Add t/helper/test-write-cache to .gitignore
Date:   Mon, 28 Aug 2017 13:06:18 -0700
Message-Id: <20170828200618.27569-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.581.gf28d330327-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new binary was introduced in commit 3921a0b ("perf: add test for
writing the index", 2017-08-21), but a .gitignore entry was not added
for it. Add that entry.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/helper/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 721650256..7c9d28a83 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -35,3 +35,4 @@
 /test-svn-fe
 /test-urlmatch-normalization
 /test-wildmatch
+/test-write-cache
-- 
2.14.1.581.gf28d330327-goog

