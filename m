Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24F51F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 05:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbeFAFJB (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 01:09:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39881 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbeFAFJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 01:09:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id f8-v6so440175wmc.4
        for <git@vger.kernel.org>; Thu, 31 May 2018 22:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8p6y2PNYu/ZMma0ewfigkH8vE3nD+inS+B8fVQS5hPI=;
        b=iE+3q7eticLn0jy+JBbXkaY0bLycL6Y9tv4dKF02rBcWfvzXjB6AC9dRnSO+termlb
         bzlgl+ZwzQVbtXrrcThriVYUMIndoW8T0iUI+9U/RbbD2RWyTg4tRHN/J+PhEblp//2E
         6yty82KVbtB+AEfcjEbS/QngTq2nw9s3dHwK6pmhn0HCn27WY/zVc44GLgYnYrcMUgJV
         AmCAG7gOrexmkvxyxN3OmKAKoU6GPMXCHbdRoNEEEAMKJ5P5bPB0DsHMQgS0MtfQ2gWk
         pd4ZGE9OU5Sg1YjulRs2nNZ+xDvs+B2K6EF+AbbfoIrX8qj9TreV5j2KrYK0oGz0F9be
         5Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8p6y2PNYu/ZMma0ewfigkH8vE3nD+inS+B8fVQS5hPI=;
        b=lXacuxeaHt1aMTMdh+5grhjUYiDdikxsMmDRXpLB1gHnEwApszJzItCEwy4ypSQmJx
         KuW9oU1UMxk/QLpuGf6ELGn9RbHJ4OveloQWCItolOHl7ACtLhCmg6/iUjyTOdvpY3JA
         uyqZQrOQJJr8TnEa7gkYE7GRxQ0yHdM9UvX14dasrqjotCHCOVFLvKT3kxTxj3UHD0tA
         jmX1QwI86oZ82JPQZX9B/vjtfs20UiXz/sFG+XdNY08rpbdlIRG7enkx/D5rx3YBHgkR
         hHnmOQF//Ae5LasC7eQKTmGnG7Pmn02Zm4irEsk2mITMPb8RID+FNDbgQIM4VgjFHPN8
         T1dA==
X-Gm-Message-State: APt69E2K9CTBjN6zakuoSD4+Qg50ek0eu5MqKNvD+QLf8u+wpM88ckwI
        AhpwzyIwUh2Q1SQHkR0In3g9IWmn
X-Google-Smtp-Source: ADUXVKIIMcrG6nuSrzQwnMsSDdYF8fAgdOAgYWoEU04+cg/eD0zYuCTo39Lx0ZpVHs2qYPMK7ZWamQ==
X-Received: by 2002:a1c:8c6:: with SMTP id 189-v6mr1492078wmi.19.1527829739198;
        Thu, 31 May 2018 22:08:59 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id 67-v6sm959664wmw.32.2018.05.31.22.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 22:08:58 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] t9104: kosherly remove remote refs
Date:   Fri,  1 Jun 2018 07:08:33 +0200
Message-Id: <20180601050833.27676-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.1035.g12039e008f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As there are plans to implement other ref storage systems,
let's use a way to remove remote refs that does not depend
on refs being files.

This makes it clear to readers that this test does not
depend on which ref backend is used.

Suggested-by: Michael Haggerty <mhagger@alum.mit.edu>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
This was suggested and discussed in:

https://public-inbox.org/git/20180525085906.GA2948@sigill.intra.peff.net/

 t/t9104-git-svn-follow-parent.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 9c49b6c1fe..5e0ad19177 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -215,7 +215,9 @@ test_expect_success "multi-fetch continues to work" "
 	"
 
 test_expect_success "multi-fetch works off a 'clean' repository" '
-	rm -rf "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" &&
+	rm -rf "$GIT_DIR/svn" &&
+	git for-each-ref --format="option no-deref%0adelete %(refname)" refs/remotes |
+	git update-ref --stdin &&
 	git reflog expire --all --expire=all &&
 	mkdir "$GIT_DIR/svn" &&
 	git svn multi-fetch
-- 
2.17.0.1035.g12039e008f

