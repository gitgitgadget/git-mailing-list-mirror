Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60A5A1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbeHKBGi (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:06:38 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:42840 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHKBGi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:06:38 -0400
Received: by mail-ua1-f73.google.com with SMTP id g10-v6so2334517uap.9
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=snebSF/Nv2tSH0Fm6pI/D+qJfZscdX/3eEeOj16HP/M=;
        b=awelVANywaAwz1bJmYY8Rv3x1d92dI0u22YIYxAH6mZoZ8u3QpARxfdRQi+Fo7ao9O
         dbIS1ZekDZ5Qaa1l3YvvmlCQffEOl/P8z/NweYm5rxdRlvo49ppbqqWBl/jTjIBy/fBr
         ydaUtH56ecch94LEEhZpiWPxT8JQ4JV7zDpGdqpPesbeOvbELMlV5myF2UDCdJUakZid
         fhXENSzDsVr+4iZ5AmtZdZCvOp/VEgbQw/q+BZGDG5UJ5qS7uTgGon+b8UpUu1i7NJYY
         CYZiNMbANy8y30ILEJNn2qce3J7Za8ngfBpX9JBWNkKd9usO4qxPiyraPMj/fbbNXNTZ
         cMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=snebSF/Nv2tSH0Fm6pI/D+qJfZscdX/3eEeOj16HP/M=;
        b=a05GuScguIg9VOBAXIqITTHA0H5BLmaN2Qv5tMNUWh5Adqr30Jwt4+u3QnQLgB+1T8
         IwDAnHau+37AsGdFVCqkk4u0esyRV/cRzelOsC6MFONuYY9yjtjL0Rr9JvYnjnoraSD6
         KxS36JDW7Hlke/IIkkLAikSJKhhxJzsMfqd0eIBhhfooCFcLEx6CdWpSENkpkWI8wZ5o
         StXu3VgQ7u3sMGeMK+L5BF4oXaVL3pdTsFMzU0hmbuPOH9yPD1oX9KoSCsqHyT0AWoNQ
         aAgzqGh6/+UM3CnhzdN7O+Hj/YFMc+Gzunwezomnw/+t9wT4seqYKXF0vbY9tdFmM2cY
         +kUQ==
X-Gm-Message-State: AOUpUlGHAX+jfH72NKKqhPwVXDRTYs2XtBqq4XSblRoaPXOS93odBUmr
        GBHk+xKrdsfMBcKzBOzHgwrgpdIVsib4
X-Google-Smtp-Source: AA+uWPwWENl82+fMAn6NpodsDgAiAPVgfwtxA4ubn99o6zBuvTChImLE0CEg4n7RJCTP2V2tJcP/DPfkbosP
X-Received: by 2002:ab0:4e5:: with SMTP id 92-v6mr3821926uaw.49.1533940487891;
 Fri, 10 Aug 2018 15:34:47 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:34:34 -0700
In-Reply-To: <20180810223441.30428-1-sbeller@google.com>
Message-Id: <20180810223441.30428-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 1/8] test_decode_color: understand FAINT and ITALIC
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib-functions.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2b2181dca09..be8244c47b5 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -42,6 +42,8 @@ test_decode_color () {
 		function name(n) {
 			if (n == 0) return "RESET";
 			if (n == 1) return "BOLD";
+			if (n == 2) return "FAINT";
+			if (n == 3) return "ITALIC";
 			if (n == 7) return "REVERSE";
 			if (n == 30) return "BLACK";
 			if (n == 31) return "RED";
-- 
2.18.0.865.gffc8e1a3cd6-goog

