Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355C2207B3
	for <e@80x24.org>; Wed,  3 May 2017 03:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbdECD34 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 23:29:56 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34437 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752004AbdECD3u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 23:29:50 -0400
Received: by mail-yw0-f196.google.com with SMTP id u70so13433428ywe.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 20:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Ztn3vT8RtUzy5JPyN+b2t2ZFCpYXFPMQZfoX6pEkYs=;
        b=rugG+KSwPKwlUEPuBojIc4yD9AhjyZyiA/sZjiy652wdqVtHEUKthrMbf16N3b+GGa
         dLPhhu/kKUEW71LjndYiawHBB8cx9wIAJacVMDmv2ex7il0IJvTPcBgmdmUyffamhUKq
         /O4j7dBkYpnR8dKXHw97eO/D/ZXXIVhP8JdR84A96RJ6CTPd9uTEiM7vY3wFNUFBK023
         VOJLSHw4iEts+M8e/sJCngq5NbJ9id30dptS80RMPtPPI8IWU58fiYCPakxmkBbebJAB
         YplObd4vA5+O+7uXs+RUek2lYfAEa7WPl3BX0+WqOKKOW8VHDUrbLL3dIQv2nP81Bvvw
         xd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Ztn3vT8RtUzy5JPyN+b2t2ZFCpYXFPMQZfoX6pEkYs=;
        b=LiywBLFn/nlyQhrLHsWtb88RhzM/Z2usRG1Oa+dLDryFX8j/Sv9b/7lgD77QiQOJ6y
         uRvsS0NUcFOnWGRxgHs8pCTHNiW1BNs/SbaSmkvGyRXs4hWkOEIWeqh9XzET7zYF+xtU
         6Zc35YYZno0GBpXk+LhrRtQ/uJS9yNAZhmvg3JqczsKdKrkoT4RjpF8dwVv6zpvXjwCC
         HlglurHjCcUp3Dj7jS7RDZ/KrTLo7OlrmS/7iLnKgm/PQh688UsqQDIXwSclEXITjEVE
         6XAuS+1lk9s0yF1K/ouGq6Dq+ZzuIinyqNOIwy29UYv2fB3i4H66jdJ5uEvQfpgm3H3y
         9v9w==
X-Gm-Message-State: AN3rC/6Xi9khSfZCDVB4TXSANw1l97hQRSfn6FqpaJNtj5mM2PBGg1e2
        JkkdKjqTzLMbFA==
X-Received: by 10.13.223.196 with SMTP id i187mr1493577ywe.185.1493782189153;
        Tue, 02 May 2017 20:29:49 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.23])
        by smtp.gmail.com with ESMTPSA id v3sm11329586ywi.79.2017.05.02.20.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 May 2017 20:29:48 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH 7/7] t7061: check for ignored file in untracked dir
Date:   Tue,  2 May 2017 22:29:32 -0500
Message-Id: <20170503032932.16043-8-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <xmqqshkof6jd.fsf@gitster.mtv.corp.google.com>
 <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 t/t7061-wtstatus-ignore.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index cdc0747bf..fc6013ba3 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -9,6 +9,7 @@ cat >expected <<\EOF
 ?? actual
 ?? expected
 ?? untracked/
+!! untracked/ignored
 EOF
 
 test_expect_success 'status untracked directory with --ignored' '
-- 
2.12.2

