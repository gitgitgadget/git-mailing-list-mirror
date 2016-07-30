Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560361F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbcG3R1t (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34359 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so20053633wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0JK/kGoflSVHRaHa7Lp43Usu3Jt7ZzbH9TxhwUttJbU=;
        b=Aa2cv9wzyL0u5v1ktU7gdbI6v26I2QmH50/RYzAHia/X7WyrLX6tTY/JBZfHgxynJV
         rhg46DmJUwYBHp0kB8LSHba7tsTON+N4krtuEoduYey5szDVb/l0K3VPbkiwg9eEKCHX
         qZQd1gykNSgo8bVhAbE7HTh+3gsB76QpBJlMSs2moZ/VJFJzDEJ0iAxdfd8U8/7BDKFh
         hBjFsbg5pZuPZyB4q12LStCraiW67p0xPlRLHwOGg+MffJu8Cw02N/tSsrZCPySlLyde
         jcXY6zI/xFn+YUwMVW/h0gDDN9U0nUPpP1PuG8sfH87BfAWXo/P4kRYaq0rZk4f7xU5k
         DR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0JK/kGoflSVHRaHa7Lp43Usu3Jt7ZzbH9TxhwUttJbU=;
        b=gPeKFc9vW4WwMi6kkhrSbNncqW0vVfqEgWMVjM509D99piGjkLIbNI2lu5aN+ezckI
         0cz3c/eVX/elOK1DkKwPzk5ipi/Ga6N+W3eGpLmEO6QMpdpbC6iTg0SnIbZXcwhLBfuy
         lhyRJjZzsovz1awtH3+bcnBTzPbKRa95kCGnXUO3j6ldKwSBIFx1/VC6d2pl9GpKqqTY
         UxLhQauu9w2/+/30Nd7CRUxGkCkbBVXC4UTd7PbpqLS/9gOpcvYsuMp+xm4Mx7lmEUAy
         ApmxLnz4FCUPnhxvfmcNLtqJ2LkHiMvA7NFPdcw2cFBewNuAbq8iH+4NqiSurZY2BAwS
         dGLA==
X-Gm-Message-State: AEkoousbSdc+w0mSHYVy0BHHLbp8n6fkFE3cZq8b1vMHZXKuLe7aEu/SXU63Yz38p5+I/g==
X-Received: by 10.194.143.17 with SMTP id sa17mr41091788wjb.97.1469899586280;
        Sat, 30 Jul 2016 10:26:26 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:25 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v9 34/41] write_or_die: use warning() instead of fprintf(stderr, ...)
Date:	Sat, 30 Jul 2016 19:25:02 +0200
Message-Id: <20160730172509.22939-35-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In write_or_whine_pipe() and write_or_whine() when write_in_full()
returns an error, let's print the errno related error message using
warning() instead of fprintf(stderr, ...).

This makes it possible to change the way it is handled by changing
the current warn routine in usage.c.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 write_or_die.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/write_or_die.c b/write_or_die.c
index 9816879..26eeec8 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -87,8 +87,7 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 {
 	if (write_in_full(fd, buf, count) < 0) {
 		check_pipe(errno);
-		fprintf(stderr, "%s: write error (%s)\n",
-			msg, strerror(errno));
+		warning("%s: write error (%s)\n", msg, strerror(errno));
 		return 0;
 	}
 
-- 
2.9.2.558.gf53e569

