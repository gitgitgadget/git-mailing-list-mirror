Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 333A52047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbdHGSVX (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:21:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34572 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbdHGSVV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:21:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id x64so1929853wmg.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hqKxJ5G+XwMjvAk9uHdE1sSvi5K2GgJetlrdnTMc1s=;
        b=Cu7jtNOTc4zG7NiInaEwCVA4WPhxWE1E0PUgU6QiQFFn3L9V50sHMII1514sFJCFyV
         p0jBQSwX9DsO6BiHJMoaV0tkFt+62fOeTqAejGNulxryCwK2IcgMRq7rocUmcuhRSlfN
         PYkNhXiYibPdhEisJ+NrtkU0y/0MAei+8sBe/xoyUOCmsSL5tlxnnsJTL6CJSqM9WWZF
         CVqu8y0nDELiPR+3FUdHCNYk9G2LmLAj7Becn0p6shF+OfszrDS8ReGxYeSJfvAmNiQo
         PVJtBx80TJPaqiVbAsipZtMv4aJ403uWx6+U9FJhwG+9ltQ6WXi79Gty0mP1P1/g5IsR
         6mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hqKxJ5G+XwMjvAk9uHdE1sSvi5K2GgJetlrdnTMc1s=;
        b=QxhFt17FtNT7/36+cDsBJzTiDBd+7xSLYv4lalfwmuBmpJMR8zFf+ayYnVgLadU82W
         3SrgozbJH1rn566d2+01Tse+8+WxrzLDaXljELr8RFDfSVd9uqGz5rXt3/HJ6kFpuy+y
         O7KgTgZnP0PqOf3UO3XE2VoNS839Q0cOI7QB4PQ09586jwjpVR2JzknpA81neDrkoyzw
         3HGLfJSj0nxAhr0p5e5NJp4H2qJujXvmlpDgMMFwTt7ehDzDqpqeRL8Bfz5RMjtLbdVJ
         WEJ6tCjUWzaSSYHybPZhl7+z921N6D16PbX7MOAQm9nvVeRpagHUil60NDG6V8t7UDPX
         FW2w==
X-Gm-Message-State: AHYfb5gesxZGQhfpClNactlNrHnfxnJ8eI9ZyPL9VzHjoffUtsOkzm4a
        zIf7u9c8xwhmseSd
X-Received: by 10.28.215.206 with SMTP id o197mr1243288wmg.40.1502130079606;
        Mon, 07 Aug 2017 11:21:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id e27sm11519422wra.25.2017.08.07.11.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 11:21:18 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Dave Borowitz <dborowitz@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/6] t5334: document that git push --signed=1 does not work
Date:   Mon,  7 Aug 2017 20:20:46 +0200
Message-Id: <4ac17762106cde543c4c60968946b68263830d61.1502128418.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.5.g0f7b1ed27
In-Reply-To: <cover.1502128418.git.martin.agren@gmail.com>
References: <cover.1502128418.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When accepting booleans as command-line or config options throughout
Git, there are several documented synonyms for true and false.
However, one particular user is slightly broken: `git push --signed=..`
does not understand the integer synonyms for true and false.

This is hardly wanted. The --signed option has a different notion of
boolean than all other arguments and config options, including the
config option corresponding to it, push.gpgSign.

Add a test documenting the failure to handle --signed=1.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t5534-push-signed.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 464ffdd14..5dce55e1d 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -71,6 +71,13 @@ test_expect_success 'push --signed fails with a receiver without push certificat
 	test_i18ngrep "the receiving end does not support" err
 '
 
+test_expect_failure 'push --signed=1 is accepted' '
+	prepare_dst &&
+	mkdir -p dst/.git/hooks &&
+	test_must_fail git push --signed=1 dst noop ff +noff 2>err &&
+	test_i18ngrep "the receiving end does not support" err
+'
+
 test_expect_success GPG 'no certificate for a signed push with no update' '
 	prepare_dst &&
 	mkdir -p dst/.git/hooks &&
-- 
2.14.0.5.g0f7b1ed27

