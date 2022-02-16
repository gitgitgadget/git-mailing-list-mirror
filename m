Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD85C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiBPKy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:54:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiBPKyx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:54:53 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199321C1ECD
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:54:37 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so2280023wmb.1
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lmu9dXWyaVSXUEW2eTqjDf3I57gw8OPeU0fyuDVdt+I=;
        b=OPN0frLPEjQFW24//AAMFYbxXFnoxZJvl0kkoTFLVhKTa0NfG9Tl1al+3lrbjRa8Vc
         Flgvmt3Z1EdMvtpGfWngGhSrlU2q7doAmeKkT61B7CSvTRQ7HAyw+ZNbvBZNK3aDWzCr
         8iaSJzLW0ia2aARDekqIbfSV1SOdewSBSx6V1ADKwn67bv86Qsc+lsx0nomj1uWYoWFZ
         SOSNKXK7ssMHoIav74tPN/GY2ZrRvhvLyGVEUjb4nGhb8g4JQ2GfMEly3+0oTDahDoBm
         DV7YXOaMTXdDGId/YgYPgW5sdBj1EioD4U5xUUBXL8sKhejpCTxdBFcm2yD2PuHHiUHU
         3i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lmu9dXWyaVSXUEW2eTqjDf3I57gw8OPeU0fyuDVdt+I=;
        b=3/0cXINVN3nICKRywVxdCIHHyNBISKsnNoM05BMl5gkql8e9YLynO3CTm8k/2IcYqX
         yN4/uc6oIMwAep4zdTKelWcTsHesGvHEoVHayUdfPtTkgHtJqtmDA6Q/X4Xv0s6yzkzV
         uYX+HFYQqnRXgrBpOG96AQ6n+qQKCGDEuM9vvxyZzf5/nYpFeWkrUn71FgCYQDKtyGKK
         QKAtWgnFA27gQgurBQMON38caPgb32Qgb/5eUn8HjHsK2xzals7uKh1AkuYbybs9NpI+
         eRVbr7sqpIuGTtGxNrZIwa0f8prDVqa0HaOWW2xazQsmKFrOrZuM8s6UbHGEFUz6xXaU
         T9gA==
X-Gm-Message-State: AOAM531XKDbLaGhkC9c1V+FryuzOH7UcrJxEYVMsD1aqsKZVMLVoPz2T
        0Vo1zc97OC2rfH4k3ADJ521+8D0+Xcg=
X-Google-Smtp-Source: ABdhPJwtlPqRl2TFJUpbsBwqn0kwfX5i5XftHQbDvv7xYKjCa8unMRe5S3ZWTR9TO5/eUiPD8sWaKg==
X-Received: by 2002:a7b:c057:0:b0:37b:ebad:c9c8 with SMTP id u23-20020a7bc057000000b0037bebadc9c8mr1024181wmc.61.1645008875546;
        Wed, 16 Feb 2022 02:54:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3sm32486751wrz.86.2022.02.16.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:54:35 -0800 (PST)
Message-Id: <02009172e081ab5c4de8e2476c1142f97b41698e.1645008873.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 10:54:31 +0000
Subject: [PATCH 2/3] terminal: set VMIN and VTIME in non-canonical mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If VMIN and VTIME are both set to zero then the terminal performs
non-blocking reads which means that read_key_without_echo() returns
EOF if there is no key press pending. This results in the user being
unable to select anything when running "git add -p".  Fix this by
explicitly setting VMIN and VTIME when enabling non-canonical mode.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 compat/terminal.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 20803badd03..d882dfa06e3 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -57,6 +57,10 @@ static int disable_bits(tcflag_t bits)
 	t = old_term;
 
 	t.c_lflag &= ~bits;
+	if (bits & ICANON) {
+		t.c_cc[VMIN] = 1;
+		t.c_cc[VTIME] = 0;
+	}
 	if (!tcsetattr(term_fd, TCSAFLUSH, &t))
 		return 0;
 
@@ -159,7 +163,11 @@ static int disable_bits(DWORD bits)
 
 		if (bits & ENABLE_LINE_INPUT) {
 			string_list_append(&stty_restore, "icanon");
-			strvec_push(&cp.args, "-icanon");
+			/*
+			 * POSIX allows VMIN and VTIME to overlap with VEOF and
+			 * VEOL - let's hope that is not the case on windows.
+			 */
+			strvec_pushl(&cp.args, "-icanon", "min", "1", "time", "0", NULL);
 		}
 
 		if (bits & ENABLE_ECHO_INPUT) {
-- 
gitgitgadget

