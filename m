Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EC3020A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 15:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbeLMP6g (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 10:58:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35902 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbeLMP6g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 10:58:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id a18so2937066wmj.1
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 07:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GbXPTXct/pMPQWS+fbnb/n4LqVVWvB76ciftr0TjSQ=;
        b=P9lctXLas4cygr7zxmkHBR22/Lr8r3s7eqyZeZnayiAXGnf5SULnrqrbDqEAM4YIfw
         vOfAoP9sTH9+irug+F3NGzvik0V36jdzfrkK8E+u4V2D6/iJPU7CqGAnl+HqHqgKk9pA
         /WO4TvxtCgEhwIWAkx35ePbPFN/FwCQ4u0qxSFwIg+XC/xErmWC8mH2uubthrlbVbBiZ
         7eWZedatxC9Y3XxwAcNE7fNCSItvnSFUgHEpGCBezNml5GyRxdxGNrTHLBUkcZzZK1pq
         0N47ZC6arE+oWQDrCQcZ42hsXMyKYRXFmBbsBY1MxhyY9YMekD3y2rVkgIsIS2WXkOS/
         oLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GbXPTXct/pMPQWS+fbnb/n4LqVVWvB76ciftr0TjSQ=;
        b=qGw/kgkCn5mW3rzqqiryBkw2ptg+E1bleOGNflxtL03f1JqtUbrJ0evmHN83tH00je
         jPrLbifXfHciTTRzT1EAw/x+Alys9fpYnlE/c/1xEhVi8wAb7d2N+k4AsFwkSajRnLpw
         92O23UdvMx2WiQy1e7cvKYC1gKAxBvfSNyPFHsOWlZaGGV7i+I8RCf5yhqWg2roHxG6r
         rXs6MKwFI602USITIaM7nVjAXQKm84YcFiRQoS9SRPv32uKrgblnWwud9EjEnIsERrEh
         txYChN8Jzewz2k8zINCDzWYDSWjDoN5816XaY84QSjI8DEjZdpWVcr2Jtd73ox490kp+
         M1QQ==
X-Gm-Message-State: AA+aEWZkCqZb3BoceWVeIeN5yxOQAJ6ttkpXo0sabDywN/P+NP13futJ
        eJ607X4q6P0W7SNavcyE4BNPCj17SZQ=
X-Google-Smtp-Source: AFSGD/Xc8LAH63vkioW/smymJbxrHnVcilBXsN4hfg5YO/uJuQTqFVVCNimyRffIPaQQ5/xINmYhJA==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr10407719wmb.98.1544716713874;
        Thu, 13 Dec 2018 07:58:33 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r69sm4047821wmd.4.2018.12.13.07.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 07:58:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/8] tests: add a check for unportable env --unset
Date:   Thu, 13 Dec 2018 16:58:13 +0100
Message-Id: <20181213155817.27666-5-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "env --unset=*" argument isn't portable. Neither Solaris or AIX
have it, and probably not a bunch of other POSIX-like OS's.

Using this was suggested on-list[1]. Let's add a check for it so it
doesn't sneak into the codebase in the future.

1. https://public-inbox.org/git/cover.1544573604.git.jonathantanmy@google.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/check-non-portable-shell.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index b45bdac688..1cfb4608ee 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -35,6 +35,7 @@ sub err {
 		chomp;
 	}
 
+	/\benv (?:-u|--unset)\b/ and err 'env [-u|--unset] is not portable';
 	/\bsed\s+-i/ and err 'sed -i is not portable';
 	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
-- 
2.20.0.405.gbc1bbc6f85

