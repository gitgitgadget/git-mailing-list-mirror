Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 104711F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeFBEdY (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:24 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:39144 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeFBEdE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:33:04 -0400
Received: by mail-lf0-f52.google.com with SMTP id t134-v6so17597379lff.6
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RG56t+BKlP3R2TFaQj4RrTlWOBneVFYUU+bm3JP2tXE=;
        b=uWFYKGeMsy1BrMsUBqXhesFdBksR3ng+A9mDVHEdn0u1hbTsYkIP9C32ofSy/K/LnW
         JhwpHfqB89irmJbOzGOdZH4XGNBg55+lAtlRHOVsTgbKPM//f0CuW12/TvFZI6ZQLzyW
         B7gPkTCSe4P4iOOZVPDqWYZoxBrIUjkLZ8Y/wchXA58Yr6ixUr4ulHFszQUjqNTZf7yB
         Sgw6O+II3T8WqyyuESnnqTMz9I/EYSDVN3UXABnqVDG6i9cDhu6szajnIaV9oH8sqeB3
         LjKkhaQDDNXjBsSxE8CN59uGl0crlqn/oLskH4t+vtx4y1T2L739OtsMFt6/KrTWrnIp
         2YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RG56t+BKlP3R2TFaQj4RrTlWOBneVFYUU+bm3JP2tXE=;
        b=r+vAn5rYLI6++kFwtUe+/FMdRXu6TmsWB0VPvCXxrDq7bIXzALmwWrCxO36xnmVStB
         JWehpgruhSLgGL93mtshfEyGOsvGpyV3UeDbhZhtAf4dDh0ZHlspJZPdksouY59ZxMIo
         nreD5wXlxnStocpeGE1EAwWzYdHwnMIRq70Z2Uf2BXVBHf+emkrUGVk5aIGJBBl8uUoH
         jNtBSV7qkVyOTbvBQL0tByZba8oq08xEC4+BiYWmAesoW2ZN3w2rhgurKgE5nF3ETOnI
         +sxlewsYLzSqBUNtIFvqHYqa7zz4cofEQEaAI/5tbmSlEj/rNNjAOw9Az3S2uXlYLsfW
         JL7Q==
X-Gm-Message-State: ALKqPwfSxhYwjLwAdkX8102Yb7MW5sVLw6EYg8ucD1ifeBj+CtaWz+SA
        nuGY7FvN4VXpUkEUaa+gSWd0uA==
X-Google-Smtp-Source: ADUXVKIhvoJizznkxwTwWGvLsNh5onEeFkjohrmX52u9NjIJFzbXVs5htKAQmFHoTXkpe71DLLSo0Q==
X-Received: by 2002:a2e:5019:: with SMTP id e25-v6mr10314042ljb.122.1527913982588;
        Fri, 01 Jun 2018 21:33:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:33:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/22] environment.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:31 +0200
Message-Id: <20180602043241.9941-13-pclouds@gmail.com>
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
 environment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/environment.c b/environment.c
index 2a6de2330b..d129c4adc5 100644
--- a/environment.c
+++ b/environment.c
@@ -147,7 +147,7 @@ static char *expand_namespace(const char *raw_namespace)
 			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
 	strbuf_list_free(components);
 	if (check_refname_format(buf.buf, 0))
-		die("bad git namespace path \"%s\"", raw_namespace);
+		die(_("bad git namespace path \"%s\""), raw_namespace);
 	strbuf_addch(&buf, '/');
 	return strbuf_detach(&buf, NULL);
 }
@@ -329,7 +329,7 @@ char *get_graft_file(void)
 static void set_git_dir_1(const char *path)
 {
 	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
-		die("could not set GIT_DIR to '%s'", path);
+		die(_("could not set GIT_DIR to '%s'"), path);
 	setup_git_env(path);
 }
 
-- 
2.18.0.rc0.309.g77c7720784

