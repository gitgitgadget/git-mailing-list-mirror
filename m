Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838351F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfFUWbU (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38138 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfFUWbS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:18 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so7813004oth.5
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V7B5wUIOydFQBWwS7yWUcuF1hXZLRQjmoz4+Qv/xbdE=;
        b=u5/2zv6+0BhHBcfd3DyG2ODZrOz3zq564v+sn3Y7AIVVNJXS34pnHbc06hYpeKLBPV
         ETfTiUoB19YEO69C5psUVL6+LFgGW6Fks9LOfsBrbmvAcDIUXn98wzWR6/j4IzhR3Tp7
         kZ+TAEdrcw9q8KamGHt8Ut2JYniLWo0QF8l0mbOGS2Z/JyJQRCoZzMD8/27ntzqR6AFG
         fZdrPuW4WtGPRrmBKHFsg9OEY0dsLESaAHlA3e1EnRnqJegZR5e+/A+NMWBuc24N4CKz
         K1NqdjOU9aL/zHPlIohJqhIocYyofeins31ork106+ew45jGfO/5ZOG6r5JO0ikthmLk
         7Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V7B5wUIOydFQBWwS7yWUcuF1hXZLRQjmoz4+Qv/xbdE=;
        b=pqhp2XFkficyKvNGGEWD0xhBY3JlD0BbrPHYSq74IsHtTwE65OcpxfFvtG0k+Xtqrt
         p8RobvicmJCGj5Ow+8x3BUVrHTF5Z5UWN2M7XYdxDmwfCqUCMlILZe7PLkLjiVgKPGYA
         foOdwUtQL9jVV78qnnyN7V8o+HjBKwGaNt3gnxuF1dbW3X1fDBixnKqcK1RqRBKrJk1X
         3LLrmr1DcHv9CeU1K7PYdrb+PRyvsd0Z1EwwzGzTe5WJM9noIhy1vPSMYHkEJhcXjPiH
         Tkn8K30GiAkQmEfkIQp3Sh6fjUKPHE2uMz7jg8Qfd6Ht3XpOfY0HsseUuneLn7Hv8EFb
         3KoQ==
X-Gm-Message-State: APjAAAWWEvlxvuzHIyWCatJxL13S8KNGux39D5a/7sy9mVcnWljWW8F1
        uDPag3oTFHcrP6/rTX22GX+lUicfzU8=
X-Google-Smtp-Source: APXvYqzSxTZ3xaU6n2ZMUUlaxUgnu2LcJEqogqr8sm3lo5yRrDUa3RdDGt82dj99Gvs8TSAxZvW4Ig==
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr19709611oto.207.1561156277448;
        Fri, 21 Jun 2019 15:31:17 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id s2sm1619590oif.46.2019.06.21.15.31.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/14] completion: bash: cleanup cygwin check
Date:   Fri, 21 Jun 2019 17:30:59 -0500
Message-Id: <20190621223107.8022-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid Yoda conditions, and use $OSTYPE.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 676b19a983..dba822d0e7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3092,6 +3092,6 @@ __git_complete gitk __gitk_main
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
-if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
-__git_complete git.exe __git_main
+if [ "$OSTYPE" = "Cygwin" ]; then
+	__git_complete git.exe __git_main
 fi
-- 
2.22.0

