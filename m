Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D531F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeFCQfC (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:35:02 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33166 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeFCQe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:34:57 -0400
Received: by mail-lf0-f65.google.com with SMTP id y20-v6so21574949lfy.0
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGHODYfbdTlddTEtD46oEAgE4dgNX3fuJyE1CFIYNsY=;
        b=nPc5V6xB7cAIlsYSW2HHrzXJbEvXtzi+DST16WMrsr8G88fIJ5S0qubElLmzVVB5OV
         aUISdWLrHsDCbqnqJB1/Zbib5PWz0lhk498UHLSsM/cFWysFeZAuhkZPJ+BzQM/V2IUG
         0FqCA4nLI08sO7nbOz1RHwwGYBZyU42Qt/ONiExdepX3N8I1EoNbScRDCR//+TAoaFiy
         9RPq9EqjJBIqsWZttuMZKh6dZkt45kV+LwmGkYs2ezy1fa0U0huhxDo+2PTs7YnM6g/V
         NRBRFkH3iwUeCl90syEQwSzuuEVtBjAKRIKpsq7//2psJF8TKs4GK9X9REIVA2f/l1Ek
         emzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGHODYfbdTlddTEtD46oEAgE4dgNX3fuJyE1CFIYNsY=;
        b=FM7r++lMaTQVaZjfqjk2I5VH8cK46222lMNCndM/zJBzXEGRRSbhM72HtMvkj0Qqrx
         vYAURsA9DizNgzAqvHJoBD187UxK6LGkEpzj8eZ26ln15qbg8HtNqbsDtl4oRbxhb/Vy
         IUFvqrlCb05nUFvgkB9uY+8oLAp6bOz6K1IPxWfTNg9AtCHqxlYy/vAyJ6YFS/LVRcr8
         xs0Nuv9P/a7zoPlzHn9ZAogod6lpY7S25LU0w7EtKipb98mmTXeE1ns/euUwZBSdl+LL
         lXxd0CxIOXt+9TaHKhY1+JZUPA/M+KY1Pp/CA/T+z1qFbvvfT2HzFQtY/+dPtiHtk5bV
         5Krw==
X-Gm-Message-State: APt69E0uifZHcNsJpg79uVnZUriBtkHENucW5mXqaNvmVYfjkBsWXfYC
        1HlHu8MwWNleU2BS8PpD3D0=
X-Google-Smtp-Source: ADUXVKKOUgLMgfq/IJDJ5PkI2gYTDr1mlxCpQwZOoIGHDA4l1kmX5GlOiDb8M+zryjXxx7d1LCalwg==
X-Received: by 2002:a2e:8151:: with SMTP id t17-v6mr5557889ljg.32.1528043695903;
        Sun, 03 Jun 2018 09:34:55 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:34:55 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 13/23] environment.c: mark more strings for translation
Date:   Sun,  3 Jun 2018 18:34:10 +0200
Message-Id: <20180603163420.13702-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180603163420.13702-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
 <20180603163420.13702-1-pclouds@gmail.com>
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
2.18.0.rc0.333.g22e6ee6cdf

