Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9528E215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756401AbeEASko (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:40:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34005 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756374AbeEASkk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:40:40 -0400
Received: by mail-wr0-f195.google.com with SMTP id p18-v6so11572385wrm.1
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7UaMSPWkT0NZNb2feq3siI+rHDazC2OtFQnBUQ2p2z4=;
        b=d9GQBjYN8JHROrcw45Kvt2IChYQF6kaEbgvewdRWwt7l9TbOecR5nVKgjSE7O0dQ4t
         peHGWkl3oQhvlW0W+RiqHUgPQYycnec9AVxAFWufPH1mkHhOu5sjKp60zfHPjLEDbz8k
         BFkEpFCmxi0tkt7JmSLwWd4c7Wd8vbottRjJxKa4f2Mrbme/F+X/pY+I1CC23XSkLsya
         uV1wTb9d/t7lrzR4d26cTezmPpJIUdhu9plc0AqhUdWdAPflc1ozc1NyLEycFbOwH9Da
         Sahci5StUAMV5CeeEv2mDo78Jj+L/UKst55PR7xT5KBsl6+9V5PbzjcptAyfSXvlRvpV
         Gdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7UaMSPWkT0NZNb2feq3siI+rHDazC2OtFQnBUQ2p2z4=;
        b=Im6hSAASMJaIzY6OGmWswRbBs7LM4dF33IqAG9cExpe+E8X0b/PsYQLRzH3tBHfELg
         9ZVv539rzVudWn96HXBfBsNfmMAuGyoHeVh/d8SsRA+KUBp7/l0sp5KYTxm+9frITjaW
         iFeiiIJn7aKTuMkhnSsgGUiAivUj3Z1CCoRZ5kaew80QAM2DauZO2zQJPQP4p0wKllPh
         JmkhO42uFcPaNk7kZCzzAjfRu2sw5cuDsYoT0FiXBY6kZpJA9BKS40R8wRzdMzi0aYHC
         HN7XT2YvVlZ5UlmPGNt1j3EqkV3vbcBMNyLsTgDt7wJbLXKOkbiiexj3YeW4KO7dtOnz
         qkXQ==
X-Gm-Message-State: ALQs6tAXel4h3Jwb8lFsIsnJzo749pr3046RZCmPwG5FKe5NdCKUBocb
        kU89Ljg5jgWWBHYwO+kPtshcCbka
X-Google-Smtp-Source: AB8JxZoOOJfQo3PoKz2iN3Wyo+DedCmvCukcopHGqr7RPZ0qElwr+upM0Lb/gNpMGyCDJmAzvqGiQA==
X-Received: by 2002:adf:9615:: with SMTP id b21-v6mr12527098wra.253.1525200039080;
        Tue, 01 May 2018 11:40:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b57-v6sm15366920wra.9.2018.05.01.11.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 11:40:38 -0700 (PDT)
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
Subject: [PATCH v3 03/12] git-p4: change "commitish" typo to "committish"
Date:   Tue,  1 May 2018 18:40:07 +0000
Message-Id: <20180501184016.15061-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501184016.15061-1-avarab@gmail.com>
References: <20180501184016.15061-1-avarab@gmail.com>
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
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

