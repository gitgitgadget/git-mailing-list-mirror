Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EBA31F404
	for <e@80x24.org>; Fri,  9 Feb 2018 21:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeBIVFY (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 16:05:24 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37537 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBIVFV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 16:05:21 -0500
Received: by mail-wr0-f194.google.com with SMTP id k32so3036460wrk.4
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 13:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NFrr5dyoSysDQpwl/q0yiY+avalW7M7N0PH0yisgopE=;
        b=AaBJEQHp51yscOUXElCARM/+ybXNDGiLVIdWiMorjGf5obRJAtC8D3Va7ZiSfdL0l2
         zB6ego+lm73qn3RFUk/mIFKJ6UiA7jKwGymh5nYje2D+9KUuQwPIVP2dsmziAg3nQl3Y
         +siUXrljLQwh8swrULPyScD+sUPtGxH/wUEkrWb5hOHGLVP8ELqHB1g+CmYuwTFDCK7V
         oeR2AnCNlTlQvDdRO1QCp4Xmyya0AWM5XBXMQtyVCdHS+eN8FGa5dfdG6k1tG5J+OyuN
         F9wrMLFG9Y5uuO1mBgAdBKXe76ovfZbYtrSlsLuceCwLjBdwBL2gE5bCV3akQK0B/WL0
         Yx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NFrr5dyoSysDQpwl/q0yiY+avalW7M7N0PH0yisgopE=;
        b=uUW1Sc2CvBVCotdisAzCmgdg+4nnxiEy8pnLzTuIUMb81xq3j35YL4HcWOspdsXQjc
         gBFtrHnheVuCtj4Q2JTdbLb2M2Nqp1Yd8XZ6I3ZxtsK+e+9C+9mQyKaf3myRp0iMdM4F
         bZFWlvuBfLwO1VCA2hnEna7A+DlCvUouRO4r7UFAqEK0ZMyWbssBnL00wSJwae28f94P
         QP6jIW6CnqLD6oMLwBbab3OyARoa/5R2awtMfclZsbiM5xBDH+0xCP74aErQ0WpdqddO
         caBcoIeTVT8TovbNNn5l3RxlWHTfsL5N/vCsJLVJuElKNa9uVIjhDzqKkFsyNVWt7Srv
         /HRQ==
X-Gm-Message-State: APf1xPC1xTIj0vrAfs+s+Mj22XsbrT/7/uW7p2uhbAtjhTzMn1mSwZj1
        4/DoppHbDaEZQQHbTmPjyYzL7DdL
X-Google-Smtp-Source: AH8x226Hry2O/eDIwAmjfz61U7CpxYZNYs2B4BDZpknLVlIFg1yj6txqOmDevVl03C1RybMRsmMY5A==
X-Received: by 10.223.176.28 with SMTP id f28mr2866722wra.75.1518210319928;
        Fri, 09 Feb 2018 13:05:19 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b54sm5800259wrg.27.2018.02.09.13.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 13:05:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] update-index doc: note a fixed bug in the untracked cache
Date:   Fri,  9 Feb 2018 21:04:30 +0000
Message-Id: <20180209210431.409-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180209210431.409-1-avarab@gmail.com>
References: <20180209210431.409-1-avarab@gmail.com>
In-Reply-To: <xmqq6076xabo.fsf@gitster-ct.c.googlers.com>
References: <xmqq6076xabo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the bug tested for in my "status: add a failing test showing
a core.untrackedCache bug" and fixed in Duy's "dir.c: fix missing dir
invalidation in untracked code".

Since this is very likely something others will encounter in the
future on older versions, and it's not obvious how to fix it let's
document both that it exists, and how to "fix" it with a one-off
command.

As noted in that commit, even though this bug gets the untracked cache
into a bad state, we have not yet found a case where this is user
visible, and thus it makes sense for these docs to focus on the
symlink case only.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-update-index.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index bdb0342593..e30b185918 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -464,6 +464,22 @@ command reads the index; while when `--[no-|force-]untracked-cache`
 are used, the untracked cache is immediately added to or removed from
 the index.
 
+Before 2.17, the untracked cache had a bug where replacing a directory
+with a symlink to another directory could cause it to incorrectly show
+files tracked by git as untracked. See the "status: add a failing test
+showing a core.untrackedCache bug" commit to git.git. A workaround for
+that was (and this might work for other undiscoverd bugs in the
+future):
+
+----------------
+$ git -c core.untrackedCache=false status
+----------------
+
+This bug has also been shown to affect non-symlink cases of replacing
+a directory with a file when it comes to the internal structures of
+the untracked cache, but no case has been found where this resulted in
+wrong "git status" output.
+
 File System Monitor
 -------------------
 
-- 
2.15.1.424.g9478a66081

