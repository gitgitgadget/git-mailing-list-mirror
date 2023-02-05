Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7D2C636D4
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 14:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBEOxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 09:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjBEOxf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 09:53:35 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8491E1E6
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 06:53:32 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id l15so3873991ilj.5
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 06:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsqtvnjYGlUrbVahZBNDZdRowScj5agh1FFZtqg/CtM=;
        b=HMlTgtGQiF5Gkuhah7QwtT8ox4bPmrkh6eOnjfKp5Y7SmrjvhR1e1bpKj8tOLmJlZb
         Lc1BcCuxvVCmhEIaXiapVb6Xi0TtYUKPQyWSjtcr6G4TwOxB4gaGYL3k/rYmKEZcuSaO
         OMES/0yZXR1/WkWlW3HgNZ2LV5r5kMFRXoEWOaHDXTYWsrWfq7ibzijVhvOrfNO70AjU
         ItYR8KXwK44nUmCvCP6UwJmc1HPbco/sg3dmPcIAcTxjdoYjCAReAC2nDD1RP3dGHRDv
         o3ueB0y241F3dY5FzzMaCI42MvihwGj1D7eh/VV1YAnNaNIMrP4pHFjBdxPQvz3+JL3u
         98Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsqtvnjYGlUrbVahZBNDZdRowScj5agh1FFZtqg/CtM=;
        b=BbToUKU3vL8W+KgfdCmx3vpL2DJm48WEHS7Xv0SMIOgNrMsVOu5Wwh073shmeQHdYn
         xPydORzBZTQiAZAmrTlkWJi5Kj68DsGMEyAq4AnFRdOBAuL3HkqoOTucuKnie4en9PQT
         UcC5lWZZOkxb29PCJ7h292UX3NtjYsYoyoOTWLmmdRgDH+MxaNezWOK79oeranSEFTgr
         UmtD6BroAF4XxaqRLOdNVOhbMrkYLU/UPBH+jE1YFRWKdn8cd3W+GtB27zEQqNEBsGa4
         yKXim2BkXkxo1QsPn5tiMPcDFzwMqnDkboSbcXW8IgcwaPlCYA5XVGb79ehZ1GwcjXP3
         EgFA==
X-Gm-Message-State: AO0yUKXCfysp0K8FamtWIyJBRjgqOtKAzVWvsDYcsckx3iXDvgiXmYOk
        gFblFW+M57W943zUhDEGsKjtqBGemT5m7Q==
X-Google-Smtp-Source: AK7set+i0WeGp/MPcaxcLXgBlJU3qPWn8i+ZcoAnPJ85VKECTgb7iTYNEx7pNUr4ED5jUSbpggNUGg==
X-Received: by 2002:a05:6e02:1d14:b0:311:1bc9:b46a with SMTP id i20-20020a056e021d1400b003111bc9b46amr14997511ila.8.1675608811355;
        Sun, 05 Feb 2023 06:53:31 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id q18-20020a056e02097200b00310a5b8504asm2518227ilt.36.2023.02.05.06.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 06:53:30 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v3 3/3] t4113: indent with space
Date:   Sun,  5 Feb 2023 09:52:45 -0500
Message-Id: <20230205145245.11078-4-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230205145245.11078-1-cheskaqiqi@gmail.com>
References: <20230202171821.10508-1-cheskaqiqi@gmail.com>
 <20230205145245.11078-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Documentation/CodingGuidelines says, the shell scripts
are to use tabs for indentation, but this script
uses 4-column indent with space. Fix it in use tabs for indentation.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t4113-apply-ending.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index e0a52a12c4..ab5ecaab7f 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -22,11 +22,11 @@ test_expect_success setup '
 	echo 'a' >file
 	echo 'b' >>file
 	echo 'c' >>file
-    git update-index --add file
+	git update-index --add file
 '
 
 test_expect_success 'apply at the end' '
-    test_must_fail git apply --index test-patch
+	test_must_fail git apply --index test-patch
 '
 
 test_expect_success 'apply at the beginning' '
@@ -44,7 +44,7 @@ test_expect_success 'apply at the beginning' '
 	b
 	c'
 	git update-index file
-    test_must_fail git apply --index test-patch
+	test_must_fail git apply --index test-patch
 '
 
 test_done
-- 
2.39.0

