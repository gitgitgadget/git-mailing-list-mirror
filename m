Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,URIBL_DBL_ABUSE_BOTCC shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EB1F201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964892AbdBQX2f (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:28:35 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34948 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964829AbdBQX2f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:28:35 -0500
Received: by mail-wr0-f195.google.com with SMTP id q39so6647290wrb.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 15:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oLGL8ZIkMdGCTyHpYiaGINU6N62uUFgnPsu7Im9AAsU=;
        b=sYVmpX9+CjNVSIn6nW5csapZSGwsMQE9hGRXfdDzYOPa8SLTGtd2T1eeHF4g5r9Srv
         RB2inWsF89sguJHkUJykL6/pbd5gJhWqoLX1xBJtLorOZGR87a79w5ubG9BEZjoVcsXD
         8khPkIl0RJ/NRPbUzmhSyYNG8ba6rNm5eID6FIEAi70pEGWxYUgOxAzJnzdQa0GeBUUe
         7/Zr7WPHO7jfcn7RC7cMSBl5xXuQf9UmRlH/zPGx2TaJdeMaEtpU0vLFd6vNozk2WXg8
         8dJwHhlj7Kp56kLQgbwBJJA0XsKPKB7bRbgsNAnisCmy/NwIB+o7qkr+tU936kBAkxDD
         iGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oLGL8ZIkMdGCTyHpYiaGINU6N62uUFgnPsu7Im9AAsU=;
        b=lenPzdXwe0wqgXcc+kjhbFWRJZ5vtH3BR91blO3FHbFhBnuSGsyiur1emMHQJZqMHx
         abuvsIG8Qf9gN6Xow9A2rlZu4EO2xxyWwyoWD1HAjj2r3fBcv7KPj3QjtgWcILj+4lF5
         /VmI9vzsAjiuPfykxdGl6XPP48+IgrEBzWKvpOOvOV6g0QgwZNPhUnAC3gTYGNMysaEG
         8temQgq880E3ohcYeY4HKvoHzxqmugwyChgr/EJ8M+rrJcXxoQACSzH4YWHs0fAZHu+I
         fF31IKLnR9zzkMm+WuMAD0Ncin7o2bMBMsX4FYfYjNpxTeNdpQaz27cx6854xc3QFD91
         DTAw==
X-Gm-Message-State: AMke39lm/zCqOm5bjOLTTqhAobpDFfDrPzEwmOxEUewUCaY5Ly+ru2O0dn3HlDLxU25Q+g==
X-Received: by 10.223.150.238 with SMTP id u101mr7729926wrb.175.1487374113437;
        Fri, 17 Feb 2017 15:28:33 -0800 (PST)
Received: from localhost.localdomain (2a02-8420-6e4a-3c00-8e4d-cd7f-8556-25c4.rev.sfr.net. [2a02:8420:6e4a:3c00:8e4d:cd7f:8556:25c4])
        by smtp.gmail.com with ESMTPSA id t103sm14721295wrc.43.2017.02.17.15.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 15:28:32 -0800 (PST)
From:   "=?UTF-8?q?Gr=C3=A9goire=20Paris?=" 
        <gregoire.paris.greg0ire@gmail.com>
X-Google-Original-From: =?UTF-8?q?Gr=C3=A9goire=20Paris?= <postmaster@greg0ire.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Gr=C3=A9goire=20Paris?= <postmaster@greg0ire.fr>
Subject: [PATCH] Document dotfiles exclusion on template copy
Date:   Sat, 18 Feb 2017 00:27:48 +0100
Message-Id: <20170217232748.13164-1-postmaster@greg0ire.fr>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since there is no dotfile in the default template directory, there was
no point in making the check for . or .. more accurate when copying. Now
that you can customize the template directory, it would make sense, but
it's actually a good thing to at this because you would not want to have
your git directory copied in every git directory that is created should
you decide to put your template directory under version control. Plus, it
might be used as a feature by people who would want to exclude some
files.

Signed-off-by: Grégoire Paris <postmaster@greg0ire.fr>
---
I hope I'm getting it right, this is my first time using format-patch and
send-email…
 Documentation/git-init.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 9d27197..7605742 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -116,8 +116,8 @@ does not exist, it will be created.
 TEMPLATE DIRECTORY
 ------------------
 
-The template directory contains files and directories that will be copied to
-the `$GIT_DIR` after it is created.
+The template directory contains files and directories whose name do not start
+with a dot will be copied to the `$GIT_DIR` after it is created.
 
 The template directory will be one of the following (in order):
 
-- 
2.9.3

