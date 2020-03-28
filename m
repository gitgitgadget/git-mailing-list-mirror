Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25440C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 02:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3FB206F6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 02:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvMM5deJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgC1C5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 22:57:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37594 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgC1C5h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 22:57:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id z24so9167087qtu.4
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 19:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WaBKb6RwCE9m3/ulhn9gviT8qK2pjeLutBFDL1686MA=;
        b=YvMM5deJFSBMyHHoAw0/ptXgBIMJK+LXJAdgB8qzkLZm8LFzL9dklUbIG9zrLhfmic
         iEer/TCf4YJ/5vX7Pnu04meV3GJqPJ4/MCMpAkHmzVbo3uA46qxCyTYDYQrsHrhctuR8
         bwfUci5GGYEgEZmBsbjAko/6aWVjKcpFMZB5BbL1pCUK5Rzo56V1oUcNcKX1tJaoflyE
         MzYtBF6oLMUQWYulMjIafvwCNFcCh1kChcjr671FV6ItYdDlvmCOTh7RiJvWUlOd6lHe
         pJh8jmSJxo8CQjrsSdtzOghdwVK5lz5RqiEElgyD8qDE+M0YJaPduyYsjKpU7U3hxVTy
         tObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WaBKb6RwCE9m3/ulhn9gviT8qK2pjeLutBFDL1686MA=;
        b=P61Yq2OLaZIGyFdRfL/yJNie2NOI5Jg35PYgR8y2n+KECQrVWxN3z0gbWaK3s3JfdZ
         wPSzmByCppGa99mxbmbKBfDMwpDrITKBqhB0Lhugf7ZfCEppWj9GbmNVJ+yIFmTpTkUt
         4hEzYesJ3QJIcf1ljNlWWk+CMmpyUwocRK0+hLPRHr1aUuy5xu0FOYjfqn+3znui6La1
         Sihk5Gom5aulo71ORu8c0UDNdh9Q5nhARfKekO3BiRhXoN/lbvnKOPrUYKY4AGq3w/ir
         5tAM7+ZNLTeXxbbvMaAnaISNz0eF7BFRto9QdgSOgLvCtWevUPdt1h6eO1YB2cwUWJce
         KIIg==
X-Gm-Message-State: ANhLgQ36yoOjEsGTiNoPE0TyQgWSZyWYgUHoO6agp9LZf+IllRUnu2/z
        86/6jTl2FJNcbjGp9AK6Y1C/c1Ph
X-Google-Smtp-Source: ADFU+vsxO1F7jnYp4kvhdxS9CzHFOhGL2B7jW8rEydlYhD27M4lgVc9rI8iVGRQIKiH5taNopFdK3g==
X-Received: by 2002:ac8:550b:: with SMTP id j11mr2388157qtq.157.1585364256009;
        Fri, 27 Mar 2020 19:57:36 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id p35sm5558223qtk.2.2020.03.27.19.57.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 19:57:35 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] wrapper: indent with tabs
Date:   Fri, 27 Mar 2020 22:57:34 -0400
Message-Id: <9575aaacc500edd9ccf4416f79f1bc75ce9caf58.1585364237.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The codebase uses tabs for indentation. Convert an erroneous space
indent into a tab indent.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 wrapper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index e1eaef2e16..3a1c0e0526 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -218,7 +218,7 @@ ssize_t xread(int fd, void *buf, size_t len)
 {
 	ssize_t nr;
 	if (len > MAX_IO_SIZE)
-	    len = MAX_IO_SIZE;
+		len = MAX_IO_SIZE;
 	while (1) {
 		nr = read(fd, buf, len);
 		if (nr < 0) {
@@ -240,7 +240,7 @@ ssize_t xwrite(int fd, const void *buf, size_t len)
 {
 	ssize_t nr;
 	if (len > MAX_IO_SIZE)
-	    len = MAX_IO_SIZE;
+		len = MAX_IO_SIZE;
 	while (1) {
 		nr = write(fd, buf, len);
 		if (nr < 0) {
-- 
2.26.0.159.g23e2136ad0

