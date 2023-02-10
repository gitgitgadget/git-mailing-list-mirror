Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4948CC636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 07:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjBJH7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 02:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjBJH7y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 02:59:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D3E36690
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 23:59:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86117B82394
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 07:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC4DC433D2;
        Fri, 10 Feb 2023 07:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676015991;
        bh=1DLXdMGNWMeApVWFqZcQ9XmmetLs3tipBEH4KBv2jEI=;
        h=From:To:Cc:Subject:Date:From;
        b=qHAQkA9qgULfX4y5BLvrFPjlOq2C/OImVz3L3hWoqyOn7168H7NF/mH1qW3rUsXc1
         0YUXFG16k2EDzuXnGnrJ8FrUZNL4v8K0ez3bfqx6DBBu9wN2/UZUddYIGvZMTqqbjg
         9WAR2Eq5pBdgCDG3Y8P9y5wPVs6v94RHViZtPs1ZTnW5vFWtUUYGM+Bsvnoaji1wap
         cosP9l/qOZ2BOb4V4ah6WO74zaInyRUlGDJYbXbReXb6/XoAPwsF5g79h7Bch6yrd+
         9bI65A/hvVAIYVN/+dhsNutyhtwwOBc+ICS9VV+PVQkc2hkeEkCzCowv8GMEBYTHTf
         eI1R3YvaF+48Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/5] Clean up wildmatch.c
Date:   Fri, 10 Feb 2023 16:59:34 +0900
Message-Id: <20230210075939.44949-1-masahiroy@kernel.org>
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
  wildmatch: remove NEGATE_CLASS and NEGATE_CLASS2 macros
  wildmatch: use char instead of uchar
  wildmatch: more cleanups after killing uchar

 git-compat-util.h |   4 ++
 wildmatch.c       | 108 +++++++++++++---------------------------------
 2 files changed, 35 insertions(+), 77 deletions(-)

-- 
2.34.1

