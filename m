Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4281FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750862AbdAMABj (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:01:39 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34955 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdAMABi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:01:38 -0500
Received: by mail-pf0-f169.google.com with SMTP id f144so20666548pfa.2
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WHY884biXCGwbgqUIrjqleh7uzJtyKOnUQp5FncELwQ=;
        b=dJ5YtSVBpT0KuQOkNB+BLFmOZ9Fiv6rEWEXkqEbYOb0udOI1dHLiM2D0Hm5q0sXjJ9
         h8JL7zwjpu13HLFZI477en3sMJl8CZ7JrM3BWw1jKIqiAeEnvtm3d33wobQJfBAOz+Jz
         gcp99P+kF2BpBwyEQ77v5GedhVjEzkyA/fLfU8sDkvwpNfaKisdng2FDSJRvxNTx5e3e
         4ZUceI/9UrSFSyfsUtOGHQ38HIj/qEz2aAvrPBfhmb2OVVRbf5kLD8j+9HRDXryruQ0x
         yh/9P8xHKZcBtSVT5tA/4I/3OYEV1gfOTYCUjmsACRPLA80NTSAaUXM16MSVTQ213JFU
         +shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WHY884biXCGwbgqUIrjqleh7uzJtyKOnUQp5FncELwQ=;
        b=DmlF5QcLVbVofIeqwRRksnGvNX2LCeGBMozIz1ae0lti10LW3Mbm0//3kKMosuzkFk
         RImJ4VOVFxwxtpaycjdxa0sgygorZbjD0R8TmKggUJgWSAnjnTMmx27oPIeVZa+U/EYY
         WG/osxrZhs75h/uvCkKIpLK3qbtovvMH7WioLGnRtknEINntv39V994g6Nl/KsIxmq+U
         w43BtxdItwoYv3jwMe0DDCIvsy8mqfquTvBzD7JPTSYXBsa6X+/CdkqCq3FNYJkrSCdR
         f3unRHRRBCy4lDLc24DiODyxwVBDmZc1meJSyhPviNk5nqZwj3bI4ZW8eST/zFrw1v06
         JWqg==
X-Gm-Message-State: AIkVDXIVOgd7aufAqvYS4tpkfDbbsPfBJfnw2ZDQA6TFp/J1ibnW45gpRTCdbdMdAChIy/Mo
X-Received: by 10.98.212.23 with SMTP id a23mr19244700pfh.94.1484265250970;
        Thu, 12 Jan 2017 15:54:10 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:10 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 06/27] attr.c: mark where #if DEBUG ends more clearly
Date:   Thu, 12 Jan 2017 15:53:33 -0800
Message-Id: <20170112235354.153403-7-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 9bdf87a6f..17297fffe 100644
--- a/attr.c
+++ b/attr.c
@@ -469,7 +469,7 @@ static void debug_set(const char *what, const char *match, struct git_attr *attr
 #define debug_push(a) do { ; } while (0)
 #define debug_pop(a) do { ; } while (0)
 #define debug_set(a,b,c,d) do { ; } while (0)
-#endif
+#endif /* DEBUG_ATTR */
 
 static void drop_attr_stack(void)
 {
-- 
2.11.0.390.gc69c2f50cf-goog

