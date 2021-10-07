Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320A7C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 06:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2EC61245
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 06:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbhJGGw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 02:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhJGGw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 02:52:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7531CC061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 23:51:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o20so15722329wro.3
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 23:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1ONOga22QuyanLN85An/eWTp8qTqIq9SnebvZhdJxTw=;
        b=Zo2Ized6wluilF3LqlN0j4HxWdztRGKNp9IxMkEkZ0pUb8k0x0RYwapzsyR/UXEqm5
         7AFTWQnCd7nnguwb8RrmHDZYfS9ACByaUebqs8NA2X9kt98Rf4R6franI8l++eyQNRBM
         JJdRYvUsMolwwqruHbtupTeTOaaOVLgPjZmRb76ilBEptfnzs6CrswDtwdxlLuXxRTh2
         fx/7yH2Rv2S9PRDQ3zbP99etXrJ3VXsU9NhJwSyLn0pucNyIKYzViX0i3xcnvPZUQQtm
         bCDOr2iN+Y/xqLKR5PsRpsy8KrVnMNDpxK4EAaMMk3nj/afXX+KAGLclgUmW6ozm/JrK
         k1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1ONOga22QuyanLN85An/eWTp8qTqIq9SnebvZhdJxTw=;
        b=CNKePohfw5JCb2l5nTHXXwfDi9w55M5kgnIxkjEk6F57v2nxSY0OvgqJy57kSisIj4
         XYH2NTjDUzOVyffi4mDb0xEJGS1ynU10AzM2O1eOnpDYkshg3b/lx4Ew4l2Oy7G5TEEj
         SLAKPSR8m13aw6te+QRc8kx9rkt7Acea+LVC/FWM8KRXjKHhQtGL52PqBPT2zOnyv0Z4
         OeLBElEFcdvhXOHa7336zFdnA5O95EXYPx8ZHYvtA1Fe63bkcKXb+HQzsp59lmptLtMa
         dUORFPHVc4JjzXRoEd2n83AefJAo1eRRoKMsp5X43Yuw8Aa1AN5g0IuZtv7/Frt8+XX5
         DnFQ==
X-Gm-Message-State: AOAM531368piGSBPuua6WMWdKmn9AtKgaWJEXmyRRAb60iZfORirGl/f
        AOf1tE99riq1Nvd/n6xIBJZjtBDJ40c=
X-Google-Smtp-Source: ABdhPJw4cC+tC1nCohvYMJRvv7LGrwsi3PboD7i9NBHMXqWZ2/GkXKxylAZM9utAXNBb8J8KAW7LvQ==
X-Received: by 2002:adf:aa88:: with SMTP id h8mr3158710wrc.360.1633589463048;
        Wed, 06 Oct 2021 23:51:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm7762907wmi.1.2021.10.06.23.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 23:51:02 -0700 (PDT)
Message-Id: <a47ab9ba20ec931a9d7a844633319c486dd699a1.1633589461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
References: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 06:50:58 +0000
Subject: [PATCH 1/3] userdiff: tighten cpp word regex
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

Generally, word regex can be written such that they match tokens
liberally and need not model the actual syntax because it can be assumed
that the regex will only be applied to syntactically correct text.

The regex for cpp (C/C++) is too liberal, though. It regards these
sequences as single tokens:

   1+2
   1.5-e+2+f

and the following amalgams as one token:

   .l      as in str.length
   .f      as in str.find

Tighten the regex in the following way:

- Accept + and - only in one position in the exponent. + and - are no
  longer regarded as the sign of a number and are treated by the
  catcher-all that is not visible in the driver's regex.

- Accept a leading decimal point only when it is followed by a digit.

For readability, factor hex- and binary numbers into an own term.

As a drive-by, this fixes that floatingpoint numbers such as 12E5
(with upper-case E) were split into two tokens.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 userdiff.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index d9b2ba752f0..ce2a9230703 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -54,8 +54,14 @@ PATTERNS("cpp",
 	 /* functions/methods, variables, and compounds at top level */
 	 "^((::[[:space:]]*)?[A-Za-z_].*)$",
 	 /* -- */
+	 /* identifiers and keywords */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lLuU]*"
+	 /* decimal and octal integers as well as floatingpoint numbers */
+	 "|[0-9][0-9.]*([Ee][-+]?[0-9]+)?[fFlLuU]*"
+	 /* hexadecimal and binary integers */
+	 "|0[xXbB][0-9a-fA-F]+[lLuU]*"
+	 /* floatingpoint numbers that begin with a decimal point */
+	 "|\\.[0-9]+([Ee][-+]?[0-9]+)?[fFlL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
 PATTERNS("csharp",
 	 /* Keywords */
-- 
gitgitgadget

