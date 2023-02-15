Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712D6C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 10:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjBOKnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 05:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjBOKnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 05:43:09 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CE644A5
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 02:43:08 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1183290wms.4
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 02:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iwe6hmtHXDCTqWNOrHp8622S6BTyRr4vlHfONu/mUqU=;
        b=atTBx3msrRkeOg6ZQPiRZYMTo0mJISTtJykKvzLxMkmJJOMqKNK7F+iTqC6ljUn9vK
         C/YkHUsfar2oAdbCbbGinY0Clz66skyM1Vr2bVyJ7LYWVdb7+UQh9YaaAmsv6xnXmYK/
         L44LkfFddqP8xgB1RBnXOg1BIq6L86ie4zUQdlJ4pihD2OhV48jntSVFCc3DK3rAhHfL
         C4oYaymLBIP7JruOAvQ8XBcY2ZRf3Syz5nwxV01qU3hpAyjSjyKHqX400W2zTdPbLYwy
         1resr7Y+qeRLCXLg6DLvOKYsWwzv20efLLqnJb42UEPU+rUDRnDwvOmopWnjevui9kCK
         SNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwe6hmtHXDCTqWNOrHp8622S6BTyRr4vlHfONu/mUqU=;
        b=iBXo60YRy9dNtPsyTl+Y4lHSkDyMdo3HthI51BKKnzAiqD85DXGV/7igZxoYc38rrR
         KAAZE49SIy7M7E+ztJdL2giZVYmbmfMAjlb6uoY115VbNHkarfUEHPx8vz+lgYMorpz5
         jdrq2SVXMIm4oS8/616Tv1rra6rJbEnHrMJCsYU0EfIQe3Y2DEnpowRZyviMomelvCBY
         qO6lIYwBjlisEMOiVOzlIYh4tFiD09+fWcSxjRzNJ7mSBKR7bSH0NegGEUtg4usm8UKe
         yqgxXVRalRQ646O5GseSH/gtvxgZZ8kbhoGlaFt35MM27xfQlRonAvaazP5QZ/lm5cNl
         kF5Q==
X-Gm-Message-State: AO0yUKUF8fXjgAo+sfH0xfFfoizxJiQIeWEdPjKZ++P905hfNXml7zDs
        vUrDOD9//MwPc+0LVhN9RIsie7vA+AA=
X-Google-Smtp-Source: AK7set+Kpe7sdyDCV1XF0IHHakfIo7PndyVjdRdPbuDSUQG6Kze8+/q3beuygrJXVzZ89mvIDYXjvA==
X-Received: by 2002:a05:600c:329d:b0:3dd:a4ad:ae45 with SMTP id t29-20020a05600c329d00b003dda4adae45mr1709182wmp.12.1676457786745;
        Wed, 15 Feb 2023 02:43:06 -0800 (PST)
Received: from localhost.localdomain ([41.109.93.231])
        by smtp.gmail.com with ESMTPSA id p7-20020a7bcc87000000b003e11f280b8bsm1645030wma.44.2023.02.15.02.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 02:43:06 -0800 (PST)
From:   Idriss Fekir <mcsm224@gmail.com>
To:     git@vger.kernel.org
Cc:     Idriss Fekir <mcsm224@gmail.com>
Subject: [PATCH 0/1] [gsoc][patch] trace.c, git.c: removed unnecessary parameter to trace_repo_setup
Date:   Wed, 15 Feb 2023 11:42:45 +0100
Message-Id: <20230215104246.8919-1-mcsm224@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, this is my first ever contribution to git.
This is about the #FIXME in trace_repo_setup, which had prefix as a parameter before prefix was added to startup_info


idriss fekir (1):
  remove parameter (prefix) from trace_repo_setup

 git.c   | 2 +-
 trace.c | 6 +++---
 trace.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)


base-commit: c867e4fa180bec4750e9b54eb10f459030dbebfd
-- 
2.39.1

