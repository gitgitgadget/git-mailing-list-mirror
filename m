Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F9A1FC44
	for <e@80x24.org>; Wed, 15 Feb 2017 11:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbdBOLda (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 06:33:30 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34481 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751846AbdBOLd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 06:33:28 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so7747332wmi.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 03:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VeZtg4qbmhO+HvesA9SqbDgGXC6z71JIMnDYs+WwgYU=;
        b=XPLQL3ir/eAR2PO3CijykOqp8ttSYP+ZWUAnvX/G5G/wi/YU7QDZhUyuywwRO2rbdi
         D0i2TquJYKLbzyYm2UWkc++YH4UwNx4DNCZCZpFy8Dhu6zDXTANqIWBMZlQXSYf6+gry
         YZZc1YqBSg3iyU3QiTPsbq2Fy1jFGFBsB+uPx5ydp9TbQlNFwh/cbrGWK2FWvdiqiVMV
         CDIrNO/cNcDkZd6HDc8Wgx/D18PHHCo/4AnF8REEZrrTdeeLg2ustSiGSEA+8CHFZZP9
         /fs09/Ep0lK2Tu6UL2DEyxizHpIf9stPzgkajRwc7jvb/keXS3kdZvdyxKwFiAKj8Gtv
         yfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VeZtg4qbmhO+HvesA9SqbDgGXC6z71JIMnDYs+WwgYU=;
        b=B0izcgVFqdDIFOjNTpwKOkeMd6JmvJC6qlnlm7SVAu3tyJ00GPxFkjMsmDJOdxP8A6
         8MFlUMeKIFGUqTRpK9eKIXz+XKRPL0T1fNpDtChRuU5qDMQ48CzHhy7asTSSSIp/+6lE
         QrhAsfShFMiRzfrcRl3iEDQ8lXHws8Nzb/2VdZnOtyEzD6FEkFJ5aXLm+T3pPZ/vRPM3
         JvQG0QnT2buDpFfy9QufJD6aIONMRtwhsQut75F1KVXx8CsDEvw/EMhDJaKMTIsrCkUK
         IIQar7MOsDf20u2gg39FLmpsjysK+e52Sqz3h1YpkxlAusn0iSK1dKtYUffJbIjboLyj
         Gbmw==
X-Gm-Message-State: AMke39kwRdMQKiDLasj4E2U9T+4PrxMemzai6OYy4IOc1dNNNm/bgMm3yCXnIrYcxaY9gg==
X-Received: by 10.28.94.2 with SMTP id s2mr7169207wmb.127.1487158407054;
        Wed, 15 Feb 2017 03:33:27 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id k44sm4512676wrk.59.2017.02.15.03.33.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 03:33:26 -0800 (PST)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com
Subject: [PATCH v1] t7400: cleanup "submodule add clone shallow submodule" test
Date:   Wed, 15 Feb 2017 12:33:25 +0100
Message-Id: <20170215113325.14393-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170215111704.78320-1-larsxschneider@gmail.com>
References: <20170215111704.78320-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test creates a "super" directory that is not removed after the
test finished. This directory is not used in any subsequent tests and
should therefore be removed.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

I just noticed that my bug report test does not run properly without this
patch: http://public-inbox.org/git/20170215111704.78320-1-larsxschneider@gmail.com/

@Junio: I think this patch should be applied regardless of the bug.

Thank,
Lars

Notes:
    Base Commit: 3b9e3c2ced (v2.11.1)
    Diff on Web: https://github.com/larsxschneider/git/commit/1699a6894e
    Checkout:    git fetch https://github.com/larsxschneider/git submodule/cleanup-test-v1 && git checkout 1699a6894e

 t/t7400-submodule-basic.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b77cce8e40..08df483280 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1078,6 +1078,7 @@ test_expect_success 'submodule with UTF-8 name' '
 '

 test_expect_success 'submodule add clone shallow submodule' '
+	test_when_finished "rm -rf super" &&
 	mkdir super &&
 	pwd=$(pwd) &&
 	(

base-commit: 3b9e3c2cede15057af3ff8076c45ad5f33829436
--
2.11.0

