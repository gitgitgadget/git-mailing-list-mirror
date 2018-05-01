Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A78D215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754960AbeEAMH3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:07:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45800 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754930AbeEAMH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:07:27 -0400
Received: by mail-wr0-f193.google.com with SMTP id p5-v6so10632641wre.12
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7UaMSPWkT0NZNb2feq3siI+rHDazC2OtFQnBUQ2p2z4=;
        b=KVYFwjNcN7bIAzY6NwQKd7P9k674b0Zvydjv8yh6CZXRs6nWCRpjhB71Yc0xs+FMUp
         QSrBEqcIsbDbS18xuGO7wYCkMTXEb7Fwh8IsGfrkpaRO4i55mOyez8v36AgIZ2AJ4yJd
         knf5UwgPbbyTlgprylXW64pwClqTpDgjLEIzBtwWqLF90se9weypXAXpltyqiytFX4sH
         6ggsSmu+cw7uj+r64/WOOwu0j5mPfTpfsBrDwTR3CLeGV3igxTKOtvxLXqYkuQ/VVFtB
         7GOyR30OJrN3dslU9h+b2rurGWwWWFLC35D3y17RsjBuR4BhFU47mA3KggxmyqjyYX2J
         DMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7UaMSPWkT0NZNb2feq3siI+rHDazC2OtFQnBUQ2p2z4=;
        b=miDR+8TuRjhxFcV1WelDpduHijwhJOj9ZV9gvooXHtywivR38ADDGsGKXg0S8aOm9O
         L9i5rvc2s5Up1rq1KCVDnjnZziqmfjrJkYctID9ghFE8o6Lt8yQ8jnV9rYdB3pCBGuY7
         z2i+qKze+BtmyS9ihKIwUW1Ypb8LaD4kImGB4qh4qRml0t89fnR0DE8IXkOYLC60OS9j
         2pPX5L54MoeB39SK93DgtXIumKNvfeLfEu0C1NoxlqlcalPOUC1K7av0mhIEGBsMH8lf
         BXTpQTX+5o7GfyTOHste59qps3MSKHXBI6WQPu6vzkGLXsdK/CmXgYHqew8Mf6GVvuWk
         E55w==
X-Gm-Message-State: ALQs6tAWldC3pwWViHlE6O3KLz6Cpsztp/pagvqUgYMXTVuJ0luRTBY3
        xXNUX8INLl53EVK7LuT9WrymW1IB
X-Google-Smtp-Source: AB8JxZq6LT2i59mVU0Ol3wAeWtoy9JjGMBJ7JZV3wBP1X+Yg6Us3BFzwPxsp2jEuc+++ZvXhS3omdg==
X-Received: by 2002:adf:8827:: with SMTP id d36-v6mr11163514wrd.41.1525176446235;
        Tue, 01 May 2018 05:07:26 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m134sm11738710wmg.4.2018.05.01.05.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:07:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/12] git-p4: change "commitish" typo to "committish"
Date:   Tue,  1 May 2018 12:06:42 +0000
Message-Id: <20180501120651.15886-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
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
2.17.0.290.gded63e768a

