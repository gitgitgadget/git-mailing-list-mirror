Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A03C6FA8E
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 11:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBZLuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 06:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZLuy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 06:50:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A48E06C
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 03:50:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE7B460BA0
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 11:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C55C433EF;
        Sun, 26 Feb 2023 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677412252;
        bh=pQrB8fvIhR/9Z3pZCt8vgohicBXXd30/0GzyQzo9dM0=;
        h=From:To:Cc:Subject:Date:From;
        b=H5xLWJRo3i2jMWU81mv45qMnoGmpECytbiYUB8XXVFGkft3+Ii2DaywYPt3ncNuM7
         iSpZhvQU8lWi475yrS1J/oi+117ZoVKCzRmOSZ9h+2Mla3yqBtERJ9RfQi5ulreyJP
         424pks5omSV9egc5aK50pklHelPvLfZpNTjTRSqW584a2ir/FANMJNxjJjH6CCiQMj
         u+q5Kp3pwE3c5J5TqP89SkSwS3sFtmdq5va0kbUc/ggACE5v8910n16Phj3qTa6xxE
         9gA1o77u4dpXZ9Hf2qYAOV+XtSUgCtwCPVFBkoKvWm7l/hXdghMFxbfUg6jDVgWjpy
         KI753nwFS3Sbw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 0/5] Clean up wildmatch.c
Date:   Sun, 26 Feb 2023 20:50:16 +0900
Message-Id: <20230226115021.1681834-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This file was imported from rsysc, but it was already largely modified
for GIT. Why not further cleanups? I see a lot of unneeded stubs.


Masahiro Yamada (5):
  git-compat-util: add isblank() and isgraph()
  wildmatch: remove IS*() macros
  wildmatch: remove NEGATE_CLASS(2) macros with trivial refactoring
  wildmatch: use char instead of uchar
  wildmatch: more cleanups after killing uchar

 git-compat-util.h |  14 ++++++
 wildmatch.c       | 108 +++++++++++++---------------------------------
 2 files changed, 45 insertions(+), 77 deletions(-)

-- 
2.34.1

