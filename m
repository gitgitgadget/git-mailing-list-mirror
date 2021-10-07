Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E4EC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 06:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491AD61215
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 06:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbhJGGxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 02:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbhJGGw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 02:52:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A08C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 23:51:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o20so15722474wro.3
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 23:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FXBmf7nYv0JJpqWnB/H36sHnSVaNnk8tIyAHSCh+KNQ=;
        b=QEPxmTx/vFronEsNG6UiZpVK2m6NDkwecflk4XacdZT6XCW5q+vLQgVmEcuE2IiSiE
         CpJ1jqDmiw2PdTCHNhmB3oVC7D6UZRvAOEKZIgiZr/86zgTSeZbwXJWCDNwoGWRas8yn
         vyT0M9E5jCH/7i25SouoHw2EP/R/SJ3R2B0uUsMUTQ0krK4RDc8yIEsgHlqyi9jazTuQ
         eXjMtqRCUHzbPBWxSb3i7U/C9vrpN/fkz6oP82/jtETDQ3pm50plBvzY9rfOB/IxKxsU
         EUj6ZqIDsebD2dTolVV9DTYDXLGP6PCmuQ9AlSy6oykSw8X79cTqihDfgRV6WBILvWAK
         lWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FXBmf7nYv0JJpqWnB/H36sHnSVaNnk8tIyAHSCh+KNQ=;
        b=ayUOlrEVqAEgTtkwFdSUWhSFLE0NpxgY5KVRVHKEf7hd7NqUE7cd3a9wnsmlm+XV6R
         HRq6+UbLSku3rStInkD7N2xwC6I0uX8ap/ufF2khhEcqWe0U0bY8kR5giDLiffAtrY5p
         s5c54sqeLPQUqRbGnMK6Z4yd9hXyH6dWw7Z3GC+iESPUudUE5Kk2ETcNvlIid2CpBkSD
         IKYY69NrPl+Tkphb6My1GClM9bcQWg+984E7+qiGVpp87mmbEnm461k+6jHyJTZLONs9
         vxVQ780FS/9DH4Jr3A/FJm1Ud0vnuNEjkBlXrkz7U0LAXtZnmznVArHimm0806N8sakM
         WG0w==
X-Gm-Message-State: AOAM533AbOXZF14c05bhI7b7Vwy/6IADPtoMLle3o83UzTUf4GICrW11
        9PsXQVC6iXYaCFwsBCRU5+OP3oepBLk=
X-Google-Smtp-Source: ABdhPJyf2vB/ZlzNdg9JD/ujd8/c5jcpdXRgQtEUn3XtmDTKVUS93/OGbZQvRysI8bZpLy0lb9bfkg==
X-Received: by 2002:a05:600c:1c8e:: with SMTP id k14mr6555717wms.27.1633589464184;
        Wed, 06 Oct 2021 23:51:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3sm7059207wmc.25.2021.10.06.23.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 23:51:03 -0700 (PDT)
Message-Id: <df66485e7f019dd81f53f73fd3772bf0b678059d.1633589461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
References: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 06:51:00 +0000
Subject: [PATCH 3/3] userdiff: learn the C++ spaceship operator
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>, Johannes Sixt <j6t@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Sixt <j6t@kdbg.org>

Since C++20, the language has a generalized comparison operator. Teach
the cpp driver not to separate it into <= and > tokens.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 userdiff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index 1b640c7df79..13cec0b48db 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -62,7 +62,7 @@ PATTERNS("cpp",
 	 "|0[xXbB][0-9a-fA-F']+[lLuU]*"
 	 /* floatingpoint numbers that begin with a decimal point */
 	 "|\\.[0-9']+([Ee][-+]?[0-9]+)?[fFlL]?"
-	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
+	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*|<=>"),
 PATTERNS("csharp",
 	 /* Keywords */
 	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
-- 
gitgitgadget
