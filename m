Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDD8B1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeFBEdV (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:21 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:37175 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeFBEdF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:33:05 -0400
Received: by mail-lf0-f47.google.com with SMTP id r2-v6so17592962lff.4
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDvjId1QJxlyrxmKHKAS94MMBPJhtBSPwgbx71n59HQ=;
        b=NMkVlV2r5ZiOprgW9WncNa0uat3Emb4JGDJ2LY3NHPGfrQX3Vi2B7FBxxfdgNb/w/f
         YvuOpXhcbu+jHUyqx2U92XF4g0dnd5zuuzHKvLiwdEcAMIW3+d9iKB3CICzAdZT1WvgZ
         PYFyCe+iMQFDlH4gB70TyfFS8lF5FBsJNJp42KZKQJQdCIAfvm8NlOq3pAjgc80nDHA/
         kiLg+pya0YpTvlwBHCeHLPkS78GZk1KFUaaept2OcVSyNiPxqWEm/AW7Mi2zx1EpXYpk
         jOS8WXgXAY9GKdbWzdT5n0MRrWHDrOE95RC/LUZlJyXAad9PTfMKK6Spkjbyzx9vAMlb
         tVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDvjId1QJxlyrxmKHKAS94MMBPJhtBSPwgbx71n59HQ=;
        b=diphgyvI+nUcrlq+PX45Yt/12GzLjB2X9OM0EzwmRE0l8KP6e4QsX6tHEcdzwraEDk
         4Aadtd6S669UvwYsD6LUPlFN5d0UhWAabkcm6wXmxbcr9Hn9M+fJgczEEf6hOJpZwD6G
         cl8I6B8TJMQqhjpFkMlQW5IGPPWq9BwwpLfCEPv+T/9BleKKDnF5EXYSqsRwzUWrtojH
         JkU+bAItSxxGVYGyOYiRKOdoR8glOAVFZhVAufLBlU5r3NHK9j0Z8yZdn4OpZb3mw6BV
         wRekT6wdmkmhoG+YmOBynH/ou4UgxUhyUSb98F1Q8UZqaZW2YdJfu/9t6aXhYiS0ce0c
         AdqA==
X-Gm-Message-State: ALKqPwcuZq7sziNKyFsS57ta9n5Ul5P7HzNRlIrvstiof6IdK5G/gic9
        1Bvp6QeRbylCgQqslIH0JLA+Hg==
X-Google-Smtp-Source: ADUXVKI5LLYaQzOp/R0w+kbIlwribeBoSj+HYB6HJfKlC28XdB9De+yssy74V33jUhCTaWn819Z8FQ==
X-Received: by 2002:a2e:1414:: with SMTP id u20-v6mr10167246ljd.134.1527913983995;
        Fri, 01 Jun 2018 21:33:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:33:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/22] exec-cmd.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:32 +0200
Message-Id: <20180602043241.9941-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 exec-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec-cmd.c b/exec-cmd.c
index 02d31ee897..4f81f44310 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -358,7 +358,7 @@ int execl_git_cmd(const char *cmd, ...)
 	}
 	va_end(param);
 	if (MAX_ARGS <= argc)
-		return error("too many args to run %s", cmd);
+		return error(_("too many args to run %s"), cmd);
 
 	argv[argc] = NULL;
 	return execv_git_cmd(argv);
-- 
2.18.0.rc0.309.g77c7720784

