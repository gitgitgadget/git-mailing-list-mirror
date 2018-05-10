Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D9A1F406
	for <e@80x24.org>; Thu, 10 May 2018 12:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935504AbeEJMn2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 08:43:28 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33171 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935042AbeEJMnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 08:43:25 -0400
Received: by mail-wr0-f194.google.com with SMTP id o4-v6so1894607wrm.0
        for <git@vger.kernel.org>; Thu, 10 May 2018 05:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XtyT5d07r7CCeDeIvBy+ufD+jNWZWFuk0iefTy9nJvo=;
        b=bSjzXCduOCOJ0N6hBuLhKzXq6W2PK7DUl5HuxE4cnK8VnEuFKC2hhuQSfd3Y/0v9wP
         dskcBX+7zvTJ8G8TCgtsMq4Q8V40KiIXPalIsq2C86E3pKDUq5xYcrfGElnGRR9sIFIj
         b29nLi+B+gHUX28r0ht3i/cOwn9/HN0CNji/NThSkrwHH/pMiywxBq1EtTe2hoT6WkyB
         TQgriMGnlZWYRga0H4Pd9ay84FfhbzTg1+AusLYmsYP2s7r+511DtUk5z2LHEhMsUn7d
         D2IXGsfzj1N3fTzSVpKB9aVt2Wh8eLfT6Za8hvfO7RQOHGZredlOePss6p5LTwH9KtI2
         fVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XtyT5d07r7CCeDeIvBy+ufD+jNWZWFuk0iefTy9nJvo=;
        b=Ro+aALQrKpPMa81zGHQkZ62gfxdIQOPDxq95kMbzR0mw1E4rsZ3wOoWD+Tvx25FOjK
         9uF3yWcCZ79ym3VT5Vyz3PIO0XFGcx/lLR49BxbouuWPJAzUWuoYBw886u0GhxsNWWPl
         1WyMTPgR4c5ZwIDou45Nxrbq2ORN5xU6REbfrwu/JkDlWn5nBbYmbi2lZU1pLXKjMQbJ
         cREgF9fAIXt4dO3TpPU6onRHxWX+zCSZgw7nl414FBBCFJDmXxt2LK9AzWLCUq7v28U0
         JP4PtWtoOZgqxoYs+7M916+cjX+ZqMTV/gXsEAZ/spapcFDtgEj5QvMsuLZsvWJ3l+tC
         4L8g==
X-Gm-Message-State: ALKqPwdi3ZcUzuqE1W4bgKvR7fwLlXd1l6dRh8usAE5z5g7wJH4iD2dW
        FaZIgiLs/SoI0UbnQWC7C9tJSAYl
X-Google-Smtp-Source: AB8JxZop2DYtr5s/m6+W0qpf/wIqH+dyYhldRhCqZw6RQoTDn9Kv5atRwgpDSYP68kmGcdapbGHATg==
X-Received: by 2002:adf:c18a:: with SMTP id x10-v6mr1294174wre.84.1525956203649;
        Thu, 10 May 2018 05:43:23 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q7-v6sm1203303wrf.49.2018.05.10.05.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 05:43:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/6] git-p4: change "commitish" typo to "committish"
Date:   Thu, 10 May 2018 12:43:00 +0000
Message-Id: <20180510124303.6020-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g4ac3413cc8
In-Reply-To: <20180510124303.6020-1-avarab@gmail.com>
References: <20180510124303.6020-1-avarab@gmail.com>
In-Reply-To: <20180501184016.15061-10-avarab@gmail.com>
References: <20180501184016.15061-10-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was the only occurrence of "commitish" in the tree, but as the
log will reveal we've had others in the past. Fixes up code added in
00ad6e3182 ("git-p4: work with a detached head", 2015-11-21).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-p4.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 7bb9cadc69..1afa87cd9d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2099,11 +2099,11 @@ class P4Submit(Command, P4UserMap):
 
         commits = []
         if self.master:
-            commitish = self.master
+            committish = self.master
         else:
-            commitish = 'HEAD'
+            committish = 'HEAD'
 
-        for line in read_pipe_lines(["git", "rev-list", "--no-merges", "%s..%s" % (self.origin, commitish)]):
+        for line in read_pipe_lines(["git", "rev-list", "--no-merges", "%s..%s" % (self.origin, committish)]):
             commits.append(line.strip())
         commits.reverse()
 
-- 
2.17.0.410.g4ac3413cc8

