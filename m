Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A535CC433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2B3604AC
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhKBPtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbhKBPsy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:48:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC23C06120A
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 08:46:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d27so16040637wrb.6
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V3UJ7kXSNpQVGVtTGUng6sI3LTiP2EGs8G33fVBLwWI=;
        b=hXz+sL6pWNdNKIcZt9dKnGYRZZjkNdQBZ+7/wt7RwmAqLIxgplNRagksCnSuhy2Z87
         OGGSyezypzFDkY/9zUAq5YEs/dGK42VciMUb7MNj5b+uhzHoJ+bJQu3FvyiQ+O/A/7Hv
         oHX2fR8oPcVO4N0D8gJjm36gPuJT4p5hNXtsWY/UbrhLaW7xhu2vlXZ9JGE7QFiqIxqO
         d23ppD44tO3A5WiBMkIYK//nwuhqGSpUpneBT6o0nJQ+INnU0/59m8cWmLTDqK4ZCAOl
         1yJkkRUDY///R6TtmmREgsXNxNSbNYXuCMhRMwVgCFUEgEdhgCkYpswbZ1/cct4AjpHF
         WV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V3UJ7kXSNpQVGVtTGUng6sI3LTiP2EGs8G33fVBLwWI=;
        b=ymBzrHFY2CgVoGB7Bu73Jc5nfNEbtU4wEmhQIS6X08pHea/fZ1xFTu9pQRTn1iHR5C
         aQt7ZUloNK8R5ILXUfqPICzKBO2K4nZ3zFSsL0DZO34+L8mFGynUbrMDp0LsQYgszI6Y
         rfAdQtWb+0MaQOT4RXmZaVhy/7JjNJbkmLJwRD0Lb54BvWJHyai9yMLTxjqm1J8Ebmt8
         spYR6BzA+2uwnDNJdmiTWPHLQmxWok0KFzriYPnLiMFspkaJ2qS1zl37etavlsgmHC6/
         kQawnWZ7ud47yFY7l42dJD08aPUeytNBwUrZmB9wYIDBiSh8triQt/4ZXFoUTt154sVI
         cFfg==
X-Gm-Message-State: AOAM530t2ez0pMtPuNdzocZ71aGTd3m6aartDi75GaXDfLh0KgFYhIxR
        UjiVGiOo5GUs+Th9k4IF/qS2aGCRwcg=
X-Google-Smtp-Source: ABdhPJwocY3agmk9edwQLkxvDlcPIjImAvHiiLfbCyyi85dzH5LOWkiiHGiJdP94fYgvoAHku+O1Dg==
X-Received: by 2002:a5d:4143:: with SMTP id c3mr28489349wrq.254.1635867977320;
        Tue, 02 Nov 2021 08:46:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k10sm2859942wmr.32.2021.11.02.08.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:46:16 -0700 (PDT)
Message-Id: <65bc291b680a30a63cf62a1dc5411ab47e67ae09.1635867971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Nov 2021 15:46:09 +0000
Subject: [PATCH v4 6/8] git-compat-util: introduce more size_t helpers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We will use them in the next commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index a508dbe5a35..1f41e5611a1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -113,6 +113,14 @@
 #define unsigned_mult_overflows(a, b) \
     ((a) && (b) > maximum_unsigned_value_of_type(a) / (a))
 
+/*
+ * Returns true if the left shift of "a" by "shift" bits will
+ * overflow. The type of "a" must be unsigned.
+ */
+#define unsigned_left_shift_overflows(a, shift) \
+    ((shift) < bitsizeof(a) && \
+     (a) > maximum_unsigned_value_of_type(a) >> (shift))
+
 #ifdef __GNUC__
 #define TYPEOF(x) (__typeof__(x))
 #else
@@ -859,6 +867,23 @@ static inline size_t st_sub(size_t a, size_t b)
 	return a - b;
 }
 
+static inline size_t st_left_shift(size_t a, unsigned shift)
+{
+	if (unsigned_left_shift_overflows(a, shift))
+		die("size_t overflow: %"PRIuMAX" << %u",
+		    (uintmax_t)a, shift);
+	return a << shift;
+}
+
+static inline unsigned long cast_size_t_to_ulong(size_t a)
+{
+	if (a != (unsigned long)a)
+		die("object too large to read on this platform: %"
+		    PRIuMAX" is cut off to %lu",
+		    (uintmax_t)a, (unsigned long)a);
+	return (unsigned long)a;
+}
+
 #ifdef HAVE_ALLOCA_H
 # include <alloca.h>
 # define xalloca(size)      (alloca(size))
-- 
gitgitgadget

