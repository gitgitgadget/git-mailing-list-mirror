Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6F9C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 13:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiFBNwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiFBNww (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 09:52:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412CD29C
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 06:52:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso4818933wmh.3
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yun/+5/TJLiwGZK6Xx5stTbrp7pJpLTDZx8cGdfNMOo=;
        b=XtyAaBR0ZPZiM7Cg55z25K8NaJ7YqghnYhkl278D0rwrIZ/SYcdJP7f7JO8G3GC6XY
         ZcwlSHOdEIQwzjKSugsczvWMjOzCZS+s0fs0LbjqSZLeGncCthr9l/LVgR4MtoHwUySS
         98z/xg52TVcoTbZhIf/U8wMZvYbRJeTbnYPbcVqJvBTTngMxRRlhGS2QWm9JN+Xuiy9t
         guAc/3J7Gx+vIFMJXEImcAu4afSIHHsw3G22JB+4lA3p2wIrqEuYaHREORVzsFb6kMV5
         SOpPNkrSY4d4Vt/kpxwwUaCGH/28P2T7oUgFyOxmgklEPkqmNCSbLeEOgfEE1pzQiXEM
         tWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yun/+5/TJLiwGZK6Xx5stTbrp7pJpLTDZx8cGdfNMOo=;
        b=aVmsPX+1JnKCiQwZncKtyzmSaVFBEqHIn1J8OyFoTp/iCVFl2eOyGZYREhn5GkGl4B
         Vu60+6ZYQ/CXcNNBP7jVanucMsQMcnujkAVuUXceYnN/cf27+/+ZoxRRDrDUKkg0WCD1
         k54c8N/v9l+RKZ5oFKKnClmFvjaTUUtTTzXTcrPPyRgJVnA/AyWrtESTIGnW0MINo0US
         2Oxg1cilwuZ0pWeJBe1HQuYcvlNQlTb3Xou2korx47UnwaAkI0ctpdEXuVy+7FW/O3Ta
         JHrDBFxBC5WwA+OmFX92S+YQjf/Ob0qjCizaW1VuWZLPLGVYHG2F7Sd2wY4baIzoHQht
         ju9w==
X-Gm-Message-State: AOAM533DCdW5Xmx3MClW5hqKyHWV/k2kT6ONqKjNZ56afym8Y5jAkPNT
        TFv8eRhw1qHCZ5LYDiFMw6+npj7gLeJ9NogC
X-Google-Smtp-Source: ABdhPJz1vlq3tvDqxeMDO8auncmfPCjMEgH/2WORZUyn/6Vtckzk5qcjwCpxOWx7pA1IDOHTBqyNLw==
X-Received: by 2002:a05:600c:3595:b0:399:fd8f:2c00 with SMTP id p21-20020a05600c359500b00399fd8f2c00mr24369308wmq.97.1654177970601;
        Thu, 02 Jun 2022 06:52:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p33-20020a05600c1da100b003942a244ebesm5544045wms.3.2022.06.02.06.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:52:50 -0700 (PDT)
Message-Id: <ba534b5d4868b4451b377e74d1b554fb1d2e8ad2.1654177966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jun 2022 13:52:46 +0000
Subject: [PATCH 2/2] bitmap-format.txt: add information for trailing checksum
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Bitmap file has a trailing checksum at the end of the file. However
there is no information in the bitmap-format documentation about it.

Add a trailer section to include the trailing checksum info in the
`Documentation/technical/bitmap-format.txt` file.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/technical/bitmap-format.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 110d7ddf8ed..6846e7221a7 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -125,6 +125,10 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 
 			** The compressed bitmap itself, see Appendix A.
 
+	* TRAILER:
+
+		Index checksum of the above contents.
+
 == Appendix A: Serialization format for an EWAH bitmap
 
 Ewah bitmaps are serialized in the same protocol as the JAVAEWAH
-- 
gitgitgadget
