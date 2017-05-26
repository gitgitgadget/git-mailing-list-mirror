Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C213E1FA14
	for <e@80x24.org>; Sat, 27 May 2017 01:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756252AbdE0BLo (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 21:11:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36376 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944945AbdEZU5J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 16:57:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id k15so5900801wmh.3
        for <git@vger.kernel.org>; Fri, 26 May 2017 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sLEuxWgr31RXtQC2xRsBGcCFtJH4TKsIAaIbX2sRu9o=;
        b=e1FVoMuaty2lGNXHcTl4hhZO2kzdXV2okXxx5w6l6BfHogWYt0cXNhmnAzyICuy68Z
         xQIdL7ybcuJrCpQMpv0rM/M3oXdq4Pt+qk3S0+KYUOpZGATDNdjwWNJugO3Za6OIPo2o
         jWQg0ebGamvcaXBe4363q6RHMBXDES283YQQIU/0rdsmVEFmbqGvT0f8biI0yDh7yDHZ
         IdsUAqTjZkqaEBh1u0Vtf9grKPwJXexaehEkpalaUnLnb5e/cLAroZpiN8JKGAAngHGn
         GVtR4IIQkPRErZwtOy50vziexV7mlTEBajVcV1wyzHLe8A2r3QDDPyG6NmG4VhTzo3F0
         ljDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sLEuxWgr31RXtQC2xRsBGcCFtJH4TKsIAaIbX2sRu9o=;
        b=cPF4pjIZcgVSu6Y+Ft37L92UfNN77dOr0IG8Hp6tiHVp8caOXd3fE3KJDNrTyM5bGR
         rRwr13PbAbAow+5UBVcGEdm798ZncE/TOav6vkvRRO68BXxUx+WaEU/FXZTKGBdrw7MH
         YooL9FHiNXMhRanIDhEjVvTY7SwoLUTRbFMjsM1M1cV7nVpc5+YF1huc66ze+3AXFxwB
         XILzAdJJWK+rN8sXThiK65AIMkQcdsZnuaSlzCR3d85U9TcZzOoakq4UqmzG9bqH6Zon
         X+VjLRLrGGNFu7LOBRqfFeakzKPyUBtn0c5jGwIkP9P+LtJDKFMlKDu507irzfB0jiIz
         AZhQ==
X-Gm-Message-State: AODbwcDQNMV9hvIMCs6mJgFvnz7SMFLYzXCGszUiWdJMPAr1tCMj60mL
        wAXAyEu8IWyWT5uvmq8=
X-Received: by 10.28.88.3 with SMTP id m3mr14746698wmb.28.1495832227797;
        Fri, 26 May 2017 13:57:07 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w68sm2675240wrb.49.2017.05.26.13.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 May 2017 13:57:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] wildmatch test: remove redundant duplicate test
Date:   Fri, 26 May 2017 20:56:57 +0000
Message-Id: <20170526205657.15006-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a test line that's exactly the same as the preceding
line.

This was brought in in commit feabcc173b ("Integrate wildmatch to
git", 2012-10-15), these tests are originally copied from rsync.git,
but the duplicate line was never present there, so must have just
snuck in during integration with git by accident.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index ef509df351..7ca69f4bed 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -135,7 +135,6 @@ match 1 x '5' '[[:xdigit:]]'
 match 1 x 'f' '[[:xdigit:]]'
 match 1 x 'D' '[[:xdigit:]]'
 match 1 x '_' '[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]'
-match 1 x '_' '[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]'
 match 1 x '.' '[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:lower:][:space:][:upper:][:xdigit:]]'
 match 1 x '5' '[a-c[:digit:]x-z]'
 match 1 x 'b' '[a-c[:digit:]x-z]'
-- 
2.13.0.303.g4ebf302169

