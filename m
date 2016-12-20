Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957A51FF6D
	for <e@80x24.org>; Tue, 20 Dec 2016 09:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934300AbcLTJst (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 04:48:49 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32903 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933545AbcLTJsr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 04:48:47 -0500
Received: by mail-pg0-f65.google.com with SMTP id g1so9553112pgn.0
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 01:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f578fiBSSsHkj4T4fnjDppFUBQ9EIHMa5AutFRF+5Vc=;
        b=LSuafLBKm1bSJkjmvgPkv8x5WlVqIvqR2v9RUwF3AeDkB3WVu0D/YkS2vdBz5/ouIN
         EI2h3dvh3x5r/p+7FEKgpGI3nIxmkoQnnqbtAEkGbG4dddpq5AgHbkEk8lZFdFqwUqNk
         fg1muXD4dm4p0PMEsyiLS4JmHndUuVyBaL89gJ0ap5N26p8z25t6nEjAq5HaG2PI5gh4
         Vmco4NCwoc3dlrR/G9uY4+Jddr/+9tPMg7UKmySYhWwUstGUSSEkwX54jUvIcWgw6jIz
         7Z+CfgiFX7Fwj+90SvO3l8l1GWIjXLzrxxqEwFQk9uASUBsrgdvgWTzYdjECqTBTRDjp
         iphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f578fiBSSsHkj4T4fnjDppFUBQ9EIHMa5AutFRF+5Vc=;
        b=Y41xNATdxxecpySiKQlZgZyFyWrqTuNdpKU+tNv1VfFa2UxQjImmhl/VhndJr/JJVI
         BWCVFYBib28xTfUlOAXIRq9AVi2TO2RYpuB+lzQJ/4bXk9QUXuChe35TxVBekOClo2DY
         5Onj3PwnYtz/EYhbB6ZBLXh9C8QOSrBNLuu3AFcwsAMIUDSYY/lBTK9MyxqEvm0W/jHE
         sVoh2ZbngV5M03mFuETDfm6h94yt2FncOGirzrycqm4auAgyXAA+oPeeeqdCICQn6ATq
         smCiJzDhpONZeJXXHJ4EkHwg/CwNY6y8KbEbd5odhX+zILIDJB1Uw39sRLnVIymIoY8v
         ylPw==
X-Gm-Message-State: AKaTC025dhto/m6O9fUGZbyMhsMZIHHhX2rdKlR3eqhNkIn7WGtWgZH84dKNxs6EwMcGbQ==
X-Received: by 10.84.213.144 with SMTP id g16mr41665087pli.134.1482227326404;
        Tue, 20 Dec 2016 01:48:46 -0800 (PST)
Received: from ash ([115.73.171.119])
        by smtp.gmail.com with ESMTPSA id g27sm37602852pfk.58.2016.12.20.01.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Dec 2016 01:48:45 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 20 Dec 2016 16:48:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, josharian@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] config.c: rename label unlock_and_out
Date:   Tue, 20 Dec 2016 16:48:35 +0700
Message-Id: <20161220094836.4131-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161220094746.GA3917@ash>
References: <20161220094746.GA3917@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two ways to unlock a file: commit, or revert. Rename it to
commit_and_out to avoid confusion.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 4973256..505e0d0 100644
--- a/config.c
+++ b/config.c
@@ -2416,7 +2416,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 
 	if (!(config_file = fopen(config_filename, "rb"))) {
 		/* no config file means nothing to rename, no error */
-		goto unlock_and_out;
+		goto commit_and_out;
 	}
 
 	if (fstat(fileno(config_file), &st) == -1) {
@@ -2478,7 +2478,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 		}
 	}
 	fclose(config_file);
-unlock_and_out:
+commit_and_out:
 	if (commit_lock_file(lock) < 0)
 		ret = error_errno("could not write config file %s",
 				  config_filename);
-- 
2.8.2.524.g6ff3d78

