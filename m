Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958471FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 22:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753863AbdFMWP6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 18:15:58 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34887 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752615AbdFMWP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 18:15:57 -0400
Received: by mail-wr0-f193.google.com with SMTP id z45so3607824wrb.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 15:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bB4qY4bNWTo3+Z+YVpn8Pte+CtamRNoz0GQIzOwCQ+I=;
        b=pwX3T5QEPxOX2CxcKXrJ/Ugexp+7fbf+akz07G31eOfsLh2Ww0TJMLsmh841PlALVZ
         4+6Ns/t5kPw90w8aaA1bgjUCGEs2oI7qC6ahmK3X2hKIcW90SkP7KhARdgagQ8x+pRH+
         cNtjbxQSBsgxG0UQxkjMwBg34ZxSr+MviB5pQ2cJFx/u6pgBgU7XAZgRt7VzEMZBn+Tz
         PomjEMQwH+b3tYZLSfSn+JpjOIIYo2SD1403rBFzk6nAtneAruO3p3ix4VF3z46mMA0q
         9UgW7NQjf6ruHM6GTB7NJA07XGlIjJQmWyQHIMqT40TrNMe82wIP9vQ09dBiZ/qdplQN
         Lm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bB4qY4bNWTo3+Z+YVpn8Pte+CtamRNoz0GQIzOwCQ+I=;
        b=QFO4m8BGhpYhIhjlyJrPOOI62ytai5FBkPPuHa2+WPu1KnKbgWDZd/hZewKi2w2rdw
         e2XCo4P9ZuCGETh8Y/+a5n/UX0DleL+k9fypshThX2xMumy/NKKMFXPx8IgG2WbZ/w9E
         VoooqMEH7MXzGtigDQaDCcxAIJfk6+mtWJRyuRKz63R7ZV22PWutCq4YFjTcUcek8XY/
         YV4PxortIunqloDjdpM8y7OcSF/xsrffiWc9aqLj5wbGy913N/eMoD955KxBU0mXpRDv
         KkBMRZbGViSTlrkxYWoMi49fnatcVPk6Da8Ch0J6O8KmLeuHyB+UZZohgz1IPwMd2bvb
         FNnQ==
X-Gm-Message-State: AKS2vOzYBVajRw/H5tiiBHsnTQ2Zh2BOK5JkRhZUdIgxE8r/2laWDUG2
        D1GyJbB71cM2sbOg6rw=
X-Received: by 10.28.8.72 with SMTP id 69mr1412290wmi.102.1497392155913;
        Tue, 13 Jun 2017 15:15:55 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3406:1800:9037:6bc3:44c4:8640])
        by smtp.gmail.com with ESMTPSA id 62sm14250785wrs.18.2017.06.13.15.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 15:15:54 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     git@vger.kernel.org
Cc:     asheiduk@gmail.com, tboegi@web.de,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] doc: do not use `rm .git/index` when normalizing line endings
Date:   Wed, 14 Jun 2017 00:15:06 +0200
Message-Id: <20170613221506.32732-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170610090719.8429-1-asheiduk@gmail.com>
References: <20170610090719.8429-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When illustrating how to normalize the line endings, the
documentation in gitattributes tells the user to `rm .git/index`.

This is incorrect for two reasons:

 - Users shouldn't be instructed to mess around with the internal
   implementation of Git using raw file system tools like `rm`.

 - Within a submodule or an additional working tree `.git` is just a
   file containing a `gitdir: <path>` pointer into the real `.git`
   directory.  Therefore `rm .git/index` does not work.

The purpose or `rm .git/index` instruction is to remove all entries
from the index without touching the working tree.  The way to do this
with Git is to use `read-tree --empty`.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Torsten Bögershausen <tboegi@web.de>
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 473648386..2a2d7e2a4 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -229,7 +229,7 @@ From a clean working directory:
 
 -------------------------------------------------
 $ echo "* text=auto" >.gitattributes
-$ rm .git/index     # Remove the index to re-scan the working directory
+$ git read-tree --empty   # Clean index, force re-scan of working directory
 $ git add .
 $ git status        # Show files that will be normalized
 $ git commit -m "Introduce end-of-line normalization"
-- 
2.13.0

