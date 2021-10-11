Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C74C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 11:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E79C60EB1
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 11:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbhJKL0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 07:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbhJKL0a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 07:26:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDADEC061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 04:24:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i65so11638755pfe.12
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 04:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EOgROmgBcScSe9Yd5LONdBa29BBykopLeRTuGGf7rwI=;
        b=Ve5MfohlHyEzMORQTFYrKTkZ42vnm5CrQEttWO2OepE7TdKbjnDajJMEkJ4omg5dU4
         LWgjioS2ebmyuTbiNBDeazvD2A3E//hDWBYYHwOcAip+LjzsS5/Kn2obVo7bmaXcEGLL
         bweUKlqE8ylNjji+rX/aIqaspQJnyUBRIUGwZUa44Zj2JXpcgivTfkGNffq1LHAaRMC6
         Iv69ALmcMgTheUqqr6HU72lLV7/QaR3GEQd0WMdKkuzOdBv/TwlbKxPP6e5HTNyfKQ5Z
         wNyCuWA7Hhmk9F0GJtW4t6vSSs1up9uUD0Ri3At9bq7XffZJc40m7hdBEKd9+xrvD/TF
         bN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EOgROmgBcScSe9Yd5LONdBa29BBykopLeRTuGGf7rwI=;
        b=e5jPj7lDHODRHPd3jLC9jAYF89zanu1yfmZK5j9+LJM/zTndI2QWzRNbnJ+xgeDIIX
         63S3RpTeLs7GpsbL0vMMDwtL1Gw9+XQrdNn1H3Sfs3x9623nF2eIMn2IJs63cITrcx33
         pL31tnFXOc7559bLla0U+PcPY87kVvtxe+nf+kH++v4VWkvmadQUD8M9y4F6JZfSesJz
         2SgZEYgahyHnoHVwzQ1yRc7PuBfThVWE27VUZTBnejrYpnA0wr2jXVw7ot4wvFCe7+f5
         GbcZX+loE7DugE6Wdjtg1G509yRfqiL/p9O7ToNHMMmZaUAuTFH0XamOmb3Z7m9EYjIN
         G3fw==
X-Gm-Message-State: AOAM532JfsMEleA0f9d7xh4s2C6I7ZkfJt0vbYRNl+Qecr+rQ1nhWVJv
        y908bkDIJDHJbXjkimNgDau259TTj2fzlrMQ
X-Google-Smtp-Source: ABdhPJxwzxKLD3gQxbn4VPZ8b9oIetbONfJe5Q5xTzPTmOVpSUSDm5dED0vVSKhXe1zjFB1EDOJ5vg==
X-Received: by 2002:a63:e945:: with SMTP id q5mr17291606pgj.342.1633951470088;
        Mon, 11 Oct 2021 04:24:30 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-3.three.co.id. [180.214.233.3])
        by smtp.gmail.com with ESMTPSA id x16sm4196816pfu.137.2021.10.11.04.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 04:24:29 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     vagabon.xyz@gmail.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] archive: rewrite description for compression level option
Date:   Mon, 11 Oct 2021 18:24:21 +0700
Message-Id: <20211011112421.474915-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the description of compression level option (`-<number>` or
`-#`) only specifies two level (`-0` and `-9`), giving the impression
that only both levels are accepted, although other level number can be
specified. Rewrite the description.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/git-archive.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 9f8172828d..097b999bbd 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -93,12 +93,11 @@ BACKEND EXTRA OPTIONS
 
 zip
 ~~~
--0::
-	Store the files instead of deflating them.
--9::
-	Highest and slowest compression level.  You can specify any
-	number from 1 to 9 to adjust compression speed and ratio.
-
+-<number>::
+	Select the compression level. Higher number indicates better
+	compression at the expense of longer time to compress. Valid
+	values are from 0 to 9. If 0 is selected, the files will be
+	stored without compressing.
 
 CONFIGURATION
 -------------

base-commit: 106298f7f9cca4158a980de149ef217751e1f943
-- 
An old man doll... just what I always wanted! - Clara

