Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB68208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 20:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeHGW2m (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 18:28:42 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:35119 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeHGW2m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 18:28:42 -0400
Received: by mail-qk0-f201.google.com with SMTP id w14-v6so17984293qkw.2
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lNtKLN5b/4r0Asc366v2AYeC9WlBHnNDJdzAhflD+6Q=;
        b=Uj9cacCdYQaiOOGsbaq/+08PzkqeSQsrdVEu53xqtIrhEoQwKMJvPf0g+bX1SPw/8A
         9bzAP5GlzyhsRgO5FJ2JAk6uHrf6Z6F7S2PAjp0JqR2/lTQK3h+HMJJbvi5b9jPsN5yw
         TzCg4zekjl8+mYAiq+kYE5Db6Wpm74ZbqGT7W2sMkgqDBDXLv74SXo0/fQ7Wde8ZR6RD
         Md0BtZRyNKDOB+XnIdM3Q6CWqFeKrxhnI76HwcMD0LeO95/HmZSGAqxGPsRzn380Mafo
         uEbH4hZSYt3S4LOvxkFCgbbYd+ICgSJElM0avlP+dtmH3nX5EjZH+Kgda4CaGmD64Uw1
         er8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lNtKLN5b/4r0Asc366v2AYeC9WlBHnNDJdzAhflD+6Q=;
        b=XR+apxjwNVgZdacQjDPsoRtLOlSwcDOIH2vEgybadCUSE956w6GyP3vD8UO4PDhXpL
         dV4g8wMIyJN9actq1aftGVF7lgzJs5Q4YZsSTEVvNX8KLQhJWWY6dOWGa0DG4wiunvNt
         0rNs42vnKgwDzsD1kx9GiX5Bx5v48pknbFJS58wvjBj+phyUDalL/aQPEyrRT1r3/ECY
         zlDCKuHPiz4mMPFi+Xnn+pujczNpPuw7l5d87lxgUR7dOt4uWn+r65xKb9wNq+rqTHDX
         gV5p6Wi1YuYSAd30bqPOkNcTa5k+39qlEFFweesBRakPBsMHyAf2F+NvWkdGVGSQrjLr
         th9g==
X-Gm-Message-State: AOUpUlGiTpjdibEQOIvkZCk3oqC1gVZsLqeMU+6ak5ZlHWqcFVlux+Dc
        Qfc61aBfauUfdWWSsQ6TVVDaxmbq1fKBWfZbDyycqlGDu1up5snMqtx6M5G31kkN2EbJJ6im98j
        bsArQtbDBdMW6kCVwQhkznWBC8cs5e4GDYk/c3rX1oZlj+OuMWeRP3hNO5o4tOpWzoGwNR20AQq
        Y+
X-Google-Smtp-Source: AAOMgpdp4nvcqMqAk7BpligL7TFTeKs9u+sKdawQvl3JpwI5ZFW/DjErr589HCj9oFL3ws9DK9optHzotNn4nbbOXXQu
X-Received: by 2002:ac8:2ffd:: with SMTP id m58-v6mr4113345qta.39.1533672757061;
 Tue, 07 Aug 2018 13:12:37 -0700 (PDT)
Date:   Tue,  7 Aug 2018 13:12:30 -0700
Message-Id: <cover.1533672584.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 0/2] Repacking of promisor packfiles
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches teach Git to also repack promisor packfiles upon GC, which
reduces one of the pain points of current partial clone usage (many
promisor packfiles in the objects/pack/ directory, generated upon each
fetch).

In the t/ tests, I strived to verify that repack doesn't accidentally
delete any objects. Let me know if you can think of better ways to do
that.

Jonathan Tan (2):
  repack: refactor setup of pack-objects cmd
  repack: repack promisor objects if -a or -A is set

 Documentation/git-repack.txt |   5 ++
 builtin/repack.c             | 163 ++++++++++++++++++++++++-----------
 t/t0410-partial-clone.sh     |  71 ++++++++++++---
 3 files changed, 180 insertions(+), 59 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog

