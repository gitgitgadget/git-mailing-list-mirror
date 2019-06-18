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
	by dcvr.yhbt.net (Postfix) with ESMTP id 036B01F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfFRMYQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43649 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbfFRMYG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:24:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so21384463edr.10
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DSglU3HprV3qOQP85ARxY9TDB5rasZXGc/9TjR3K0J8=;
        b=AH283W/BZzP598GAcarrU46mU6cVppGpRezkueFCy/T9femC/ptAzeWgO4IS2K/N5w
         sFslIbyRCLjA8g2U8lfRoCHtfmUY9tXjQoeYKffRGeOGkmOfEY1DzqsHoF6mIesFlWEs
         wK9RlgtA/NTWNfdICKvx3F1HZG3Jge8y+QOCH5FNofhMzsylrRAIihfZ8mBW3zUSmRvF
         dKr0C9dBOccmum7rOXYwKCGMxoLhGH5Wl6785CFYAjQMhJ92GYCbQWPqvMbo+FHaky8B
         PP1Tf2EUuarD71sQxvnCnxiB53vEwWcMda2VpW/L1DC5/0prteoLEZGYUB431XtaDpnY
         NugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DSglU3HprV3qOQP85ARxY9TDB5rasZXGc/9TjR3K0J8=;
        b=BHfVEKYIkpiEto3BvhMzFm23Unif88xYM/hlo7VID5rl6Dwgd8vMuQwecz+M7Os4UR
         XQzfixj09IxRmd/mpDDr3EU3owJbahzBKx8aRheCeGEjwwq9w0Ut3+ypnWtL+mAmYoi2
         nq6cRdedA83F2LUbrIt5FcSbaNCQT5XtKHtyy9xZvXyaOouie7uWMf0a/NIXM3A5A1oO
         c3UEtXWShDlGNebrZP5nb3z2if6BjKXR/8ruGXghRfrW2cusxg+6fKw5adjrTKI1T+VK
         tdXz+L4COuNNI3zdPJjqy56LTjwIQPqrXNGD3Ac6uUGGy5xZr0uZDmCWFRmvxuN5wmRp
         lI5Q==
X-Gm-Message-State: APjAAAU1NuQIyqEz1n8PzaB2IkJbvPjtfsE3FvMMYXgRza+/+Fegz82b
        +Va9qT+VG89mqcpVEqQRhLBQYJuI
X-Google-Smtp-Source: APXvYqw8Nj0BpKjeCmtUZd5TFfFEJkNYBlqXCh0O56yuMrXJI2OHNRVgWCivSmD96guwKET6NvGIMA==
X-Received: by 2002:a50:ad01:: with SMTP id y1mr101990074edc.180.1560860644320;
        Tue, 18 Jun 2019 05:24:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o22sm4711259edc.37.2019.06.18.05.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:24:03 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:24:03 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:49 GMT
Message-Id: <073dc01b1431b62255a2c258c479c8408123fc90.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 12/17] msvc: fix detect_msys_tty()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

The ntstatus.h header is only available in MINGW.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/compat/winansi.c b/compat/winansi.c
index f4f08237f9..11cd9b82cc 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -544,7 +544,20 @@ static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
 #ifdef DETECT_MSYS_TTY
 
 #include <winternl.h>
+
+#if defined(_MSC_VER)
+
+typedef struct _OBJECT_NAME_INFORMATION
+{
+	UNICODE_STRING Name;
+	WCHAR NameBuffer[0];
+} OBJECT_NAME_INFORMATION, *POBJECT_NAME_INFORMATION;
+
+#define ObjectNameInformation 1
+
+#else
 #include <ntstatus.h>
+#endif
 
 static void detect_msys_tty(int fd)
 {
-- 
gitgitgadget

