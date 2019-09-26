Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CD191F463
	for <e@80x24.org>; Thu, 26 Sep 2019 08:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfIZIaP (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 04:30:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44377 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfIZIaO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 04:30:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so1207128ljj.11
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 01:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YnMTIPjZvbP+6ylmBnfB+NxC7dfryopwFIX8J+o4KjU=;
        b=rWgoM/LD8vjGTiddb696DVrw5/nQYpjo+3yi04IYagyqhtnZAZMnz4deP1dzkSzfzb
         dqdO1DuRST7i6KVdaqHsy71khpSyou3CKFdSnHUaKudAq8S47Zhy38xdp/CKPe3TQeU2
         8fHeqFMNF4ssJl578xURXxl3fznesz9CCzbF31lKHYihaOYTt/UF7Q/M8ZNaFcRFvwKp
         oyG/su0wWL80xBHVrQrD8oRf+934CeO5e7kyQO/OnUSvAiiDqnFb51gcZ7S3fNFSTU9Q
         CQrOLh1bO9yMytiT8ejNSbk93P0uUT/SxlDKDjPYaeh4YfGXTd+iaRfgrXQb9yxkuVmN
         CfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YnMTIPjZvbP+6ylmBnfB+NxC7dfryopwFIX8J+o4KjU=;
        b=WpwVRbwF9a4i2Amf4/OipWOpe/HhYkXcNccoxbA3MJq4C6w5WSuU9sWvjLsqc98U+J
         cZ3zqqTpAwV2AqygnwwKaNv/XPs57XPa/0eKrTCUrKVThi6CoIXle88TDjgr/RqvqMnU
         vYxUpxJWXNcRdLNM4TGpeSlYi5e9I9BPfoqll+gjEka6ix18/aIR9vrahnnN+5gEWzIo
         cdS/sKr76fBenWsnNNd9DBF9OFL30m2RI6nbPIeazLHxMNUUPMq29W1y0+zO5x5FIqi+
         x8ta9lPYrtT0bna9j8NRvgafspEDrmaMnJyiRX0X059Y2oFMd+9t6mCV7PANfyW9mGJe
         qpVA==
X-Gm-Message-State: APjAAAWK64ie1Z6HT6Qj80AB+LbHHbXP2/L8HGL0RcqjKM95VsV4Rm/f
        AKmEuawInks+cm84tprDmb7OJGZd
X-Google-Smtp-Source: APXvYqwEuZwSJZR8sq8v4rqx1ikzQNj7UP5F9xZeZGDcZhc8wb2r9zzo9kU6W9Tl0W8BJgKxpTHLSg==
X-Received: by 2002:a2e:b0f4:: with SMTP id h20mr1746414ljl.10.1569486612524;
        Thu, 26 Sep 2019 01:30:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm347287ljj.59.2019.09.26.01.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:30:12 -0700 (PDT)
Date:   Thu, 26 Sep 2019 01:30:12 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 08:29:56 GMT
Message-Id: <dbd9022ad540561f4401d43c3a6b7870f025ac27.1569486607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 03/13] winansi: use FLEX_ARRAY to avoid compiler warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

MSVC would complain thusly:

    C4200: nonstandard extension used: zero-sized array in struct/union

Let's just use the `FLEX_ARRAY` constant that we introduced for exactly
this type of scenario.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index cacd82c833..54fd701cbf 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -546,7 +546,7 @@ static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
 typedef struct _OBJECT_NAME_INFORMATION
 {
 	UNICODE_STRING Name;
-	WCHAR NameBuffer[0];
+	WCHAR NameBuffer[FLEX_ARRAY];
 } OBJECT_NAME_INFORMATION, *POBJECT_NAME_INFORMATION;
 
 #define ObjectNameInformation 1
-- 
gitgitgadget

