Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E16AC433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 18:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41F161B39
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 18:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhJBSqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 14:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbhJBSqD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 14:46:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BA1C0613EF
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 11:44:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e12so1030991wra.4
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=r2BOhgMuigtDKIORNMRbVFH4WkrffwDReHnw2Xi622s=;
        b=G+AMXgJSURluLAMDE1jlynrDcITafJ9tBQweU0FJt5o4vhn3FBIrXVAE9nCGiWGoGr
         zOFT0ZHoeZ92/Sv0fbnbXJjAsiSFAwMj4tuFa4wwK5kcfvSudZn8kKVagfB6gExwESff
         /FYZCzldnpIUqDWMeVV7z6fhoiaJ4YcMhML/BTPiT9B82nPNAAkyqwWmEGo56qxAOdFL
         gxj2l0TiLJ+aRSIY/Lk0NM/UG6bJBVUfi2QZBp526dBC5i36g7bnWap+xsoOhPdr/s9Q
         QwdSxE6taNU46GSw9gYtaeBNMLkWf95IO1V5DC2zewvP3Utl0T1dUbme9/RhzDSXrV0e
         irDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r2BOhgMuigtDKIORNMRbVFH4WkrffwDReHnw2Xi622s=;
        b=Qw8lQUz0Xx063h9CCPWM9OP1yUX7gJJ7JUrtXHQHVq7g1xxWLYdSUZCEINj0a9WZXn
         s/g7uJGZg4fhIJFmZBKjSKOwI5T57rR9ZE14sIJoELMgq1KmNF0orU/+1jorYiI7AwLp
         yP+AdlKvdsN4Q6xynmJQUdUr+WqM11WTactBxpzzYgbW74O+/Lwt7ypzZ9yTL38dopZd
         5rdpGirBTApEdAoYCTC7ZjT/NEYHt9t27tXkmPQPeclqWcaN02+KoZKSpblpN7A+rEKG
         lsLhxdYeIGn49nM3smR+5q6G1ghI0RAc3FrBY+/XuSKje4nc7uDP6pIoTuB0aRHUl6vE
         QmoA==
X-Gm-Message-State: AOAM530XKMc17hW6BTlgIETHkI1a7KcknAyvy5Sq/7BYPMOggw7vvDN9
        2hED/VhpM2alMOwO11ivyoZZrawLcJ3feA==
X-Google-Smtp-Source: ABdhPJwAJkdtDgapkmkEEIPjBwQnftl7z5OEBSJPEzgwy24okc1HhBks1lMSjnHJHhassCRbyIr0XA==
X-Received: by 2002:adf:9147:: with SMTP id j65mr4645489wrj.163.1633200254298;
        Sat, 02 Oct 2021 11:44:14 -0700 (PDT)
Received: from localhost.localdomain ([154.13.1.35])
        by smtp.gmail.com with ESMTPSA id o1sm10379552wmq.26.2021.10.02.11.44.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 11:44:13 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v1 3/3] difftool: add space after full stop in comments
Date:   Sat,  2 Oct 2021 20:44:07 +0200
Message-Id: <20211002184407.117282-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211002184407.117282-1-rybak.a.v@gmail.com>
References: <20211002184407.117282-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These punctuation typos were found using:

    git grep -P ' [a-z0-9A-Z-]+[.][A-Z][A-Za-z-]+ '

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

I've also looked for similar typos around commas and semicolons and didn't find
any.

 builtin/difftool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index bb9fe7245a..d9a4e55caf 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -529,7 +529,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		goto finish;
 
 	/*
-	 * Changes to submodules require special treatment.This loop writes a
+	 * Changes to submodules require special treatment. This loop writes a
 	 * temporary file to both the left and right directories to show the
 	 * change in the recorded SHA1 for the submodule.
 	 */
@@ -548,7 +548,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	}
 
 	/*
-	 * Symbolic links require special treatment.The standard "git diff"
+	 * Symbolic links require special treatment. The standard "git diff"
 	 * shows only the link itself, not the contents of the link target.
 	 * This loop replicates that behavior.
 	 */
-- 
2.33.0

