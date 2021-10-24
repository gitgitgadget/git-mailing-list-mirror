Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F50C433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C932E60FDA
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhJXRMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhJXRM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 13:12:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9C0C061243
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:10:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id s1so6600287edd.3
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bxer6BQksOe79PDqJsxMk4+fs+6eYUURRsgJJGzFQeM=;
        b=LK75dzfA8K9jcL0HG+MpEDGvhheyrXa1iDxVfhMiYEcO5e05Vf9f1nQrv1Wr3KBFL7
         D45DuXrVO9D5FE4ukXqIDBxhBQ3yukGTebD5WNAPPSr9LjndrBL3rHFL2AbuJBPta+xW
         VdT+Y/Ra02R6A9LTnmHy+3akrcqj5VEy+TSu71VhEdjxxOUkLMNVNsmaPs3RND/sBNXN
         /LC6LxLmR7fKpkFIlEk/awd2CvljXklSo8kQwaiJ2Tnf7WYRRsRpbyM4OtZy6wWFtzjA
         +jLCDiG4pqEsiGBnFsP2W1U3ltY2W4FD93rP9cPt1v+xdb2GR4O9ft154Ul0+QgRKMP7
         zgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bxer6BQksOe79PDqJsxMk4+fs+6eYUURRsgJJGzFQeM=;
        b=M68JvZ/1+5XVZioL9M1j+uw74p2A/4LfUfSCNEdIoHJhiS2kIeUFxs/wCslmCE57N5
         962+pR+OIf/SYCJLsjtTMe4zh+2uNxZ+cEUS2TGZfQjcyofV5UGN6/5m6UAhJXp4jz0L
         ZWzU26WSOqs+FFEJc8ubkQEOa7sch+7G+pir5jndzyudSUdEKd+wmznN0eeQTf0keyJb
         9XfnDiZDk+UWfxN7cW1a34pJIsWGzmMBvcPabG8OsptDdSDuCBwhyMm1t/HPZU/4YFPk
         ug45PeiV0FBN/ZREi7SG3VtnKGNkeK6Qf8FmInjhU4WIPshqcNtpd56eN9CT/8F5u1Oa
         G42A==
X-Gm-Message-State: AOAM533twG2aAt8R7I2JJy8oU/Jc+rt6ubfV8HQ/XyTkknkefUA2d76n
        oFKK1FGrycldjshjyRCFrVDQPOEGmn3axw==
X-Google-Smtp-Source: ABdhPJw4rONgiktUns3LPETw91n47USdkMl4exnhgLlyu8kSL6+2tj69SDRjwGDjUOVp8td4GadT9w==
X-Received: by 2002:a17:907:6297:: with SMTP id nd23mr16662513ejc.62.1635095403667;
        Sun, 24 Oct 2021 10:10:03 -0700 (PDT)
Received: from lena.c.hoisthospitality.com ([194.209.187.34])
        by smtp.gmail.com with ESMTPSA id j11sm6313670ejt.114.2021.10.24.10.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 10:10:03 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb.txt: change "folder" to "directory"
Date:   Sun, 24 Oct 2021 19:09:17 +0200
Message-Id: <e95118e70788485ed1172d9a6dc7962c632a8d26.1635094161.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.33.1.711.g9d530dc002
In-Reply-To: <cover.1635094161.git.martin.agren@gmail.com>
References: <cover.1635094161.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We prefer "directory" over "folder" when discussing the file system
concept. Change this instance for consistency.

After this, the only hits for '\<folder\>' in Documentation/ relate to
IMAP folders.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/gitweb.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 3cc9b034c4..7cee9d3689 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -547,7 +547,7 @@ like this:
     # make the front page an internal rewrite to the gitweb script
     RewriteRule ^/$  /cgi-bin/gitweb.cgi  [QSA,L,PT]
 
-    # look for a public_git folder in unix users' home
+    # look for a public_git directory in unix users' home
     # http://git.example.org/~<user>/
     RewriteRule ^/\~([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi \
 		[QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
-- 
2.33.1.711.g9d530dc002

