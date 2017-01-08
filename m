Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8E520756
	for <e@80x24.org>; Sun,  8 Jan 2017 06:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030315AbdAHGNQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 01:13:16 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36737 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030261AbdAHGNO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 01:13:14 -0500
Received: by mail-oi0-f68.google.com with SMTP id u143so11848529oif.3
        for <git@vger.kernel.org>; Sat, 07 Jan 2017 22:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/MFB5SHwCKBBJfWjmfkPoqeWGg+dty8TbXH7EGy0gBQ=;
        b=h3Vt+jFdoyksVv+oC+YjkMxp8tyukjVYxCAYGVYWHy9LrNIS1KXAkQHQjFqId6EZ7t
         ykWE9rCygLVyb9aPA9usUn+7Eb0Wan7FZ535uXS8nQZcIFlAqBC6Blz7TrTDSO4oY3I2
         zBwKrNHDIloEr+WMEIYFFzx/KdgLXl84D9gLNHhoDnPnB5QDM5EumHCiokUVKrW5BrWX
         rioE3i1Lrn/dPoTtUaJki00X8alhmJVV2wFNTuaiEy9ukYpVuLrd+hGy1hSCIqqU/7iC
         G/pOkc2Ty0ROMg4AIieYqFF//qQRX/xwsFdmDBQibi2zr7UTdE6sMqJWYCWt7fK1h4MW
         0i6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/MFB5SHwCKBBJfWjmfkPoqeWGg+dty8TbXH7EGy0gBQ=;
        b=OVZL0vgI8ILJ9X/Pjh7srfNlwjDMKAx+cN6L70Dn5lEyFV3i1zk7Uqdfrtn0g7ceBt
         GymRklN6EJ6mE0p5dWwix8O8e0LV7C1VotZVMh20T0tOjyQsrXjQT+EyRXUcQyg5bHOk
         2EXxnSkZA4d27HNSxqnTQGq9yS7haFlvWfM5O6x1dM0EqAiF8wMhy1EpS6QodBnRJ1jX
         tze9e8htPTOGOz91SImvB9H4LUcqGa/mQjOwXjdQq+Qezc8xv31+MzAvw/IAQL/EsFT4
         g9zVyOagrttgS+C2VXct0TQAiLsMKlEGdqb4dU9aV3Auo+VtTJRBOL8q8WHJ+xPNe+rG
         x8Uw==
X-Gm-Message-State: AIkVDXIz2YRY9fXP4fc7TLmhW3skZTxc8QSrC9/41NfzxlOQIjzxkxw02PH9c2Spd4E8Gw==
X-Received: by 10.202.185.198 with SMTP id j189mr36380173oif.32.1483855993970;
        Sat, 07 Jan 2017 22:13:13 -0800 (PST)
Received: from localhost.localdomain ([2605:6000:9fc0:56:811:343f:f904:d318])
        by smtp.gmail.com with ESMTPSA id e63sm40706695oih.23.2017.01.07.22.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jan 2017 22:13:13 -0800 (PST)
From:   Steven Penny <svnpenn@gmail.com>
To:     git@vger.kernel.org
Cc:     Steven Penny <svnpenn@gmail.com>
Subject: [PATCH] Makefile: put LIBS after LDFLAGS for imap-send
Date:   Sun,  8 Jan 2017 00:12:38 -0600
Message-Id: <20170108061238.2604-1-svnpenn@gmail.com>
X-Mailer: git-send-email 2.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This matches up with the targets git-%, git-http-fetch, git-http-push and
git-remote-testsvn. It must be done this way on Windows else lcrypto cannot find
lgdi32 and lws2_32

Signed-off-by: Steven Penny <svnpenn@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d861bd9..f0f65ea 100644
--- a/Makefile
+++ b/Makefile
@@ -2046,7 +2046,7 @@ git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
 
 git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(IMAP_SEND_LDFLAGS)
+		$(IMAP_SEND_LDFLAGS) $(LIBS)
 
 git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-- 
2.8.3

