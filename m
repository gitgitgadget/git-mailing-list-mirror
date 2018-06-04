Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A9881F403
	for <e@80x24.org>; Mon,  4 Jun 2018 21:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeFDVvD (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 17:51:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52840 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbeFDVvC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 17:51:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so1069424wmb.2
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 14:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rm2wt/U9DDoFGcoB4sOWZ9aDVLshXdMq7pwoPtHLry4=;
        b=MmbC5+Oirf0T1FTnq96gEFVnFDIV3UYi/XeCNpMKwl2Ce5wEZEGxmkY/p8oteYR27+
         Xf1rY4BtUSO/WR7w0wJhR+RfSz/fHzCcVoXT1mafSpagzwK8Ml43+QV4ZM+26buWzjgA
         NO5XRgMLfZQv0FYulyzsxdK7IN9rwHPDPtNu/3XWnqKEqzzLDfjipuKz/w/X1EpHGvx+
         DQPYX82VhqM4lsNnevyslfPztDJRNfNuifKv81z8Yoi7iaUrg2rluWc9p0IAIAXukK8O
         c85gJSmq278EI84OUL4BSwBzZk18Y/P6Z/eui7gz16kZpU/za2pzfNTTG9bFkn5hHaH4
         Tt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rm2wt/U9DDoFGcoB4sOWZ9aDVLshXdMq7pwoPtHLry4=;
        b=kpJh/Hzfavr6TTpeTbGZGp47PVF+6mP+e/uSujJ5BUXnivJcNmPKDsusP0xiwCiKCF
         UzRHZ1Y4KgeCjvGTqSPVVE69GZR7tyYdAqa9/nXb6wwlIfL2UDSpnJzxGJRqfjWzpVZu
         UwBIaDbqbLnLP+1N8blHiTOAwuSU7J+ifcJjo3TpPmGcW0k4k/JMnx72/eUFX2ExUAjQ
         JWD/DBK5sRLqgtHuO9TY7APfWiuOP2AdfDW/t8+lbYOkBLDmb/+GwGr4mFqJLPJEvjNz
         J9wYJNahe/3xcIvGgGQMaKKPuJ9K7ytrtTUv9wqMXR2Q/ZMx3qluoAZjc2lb2KwWEz+q
         v9kw==
X-Gm-Message-State: APt69E3Cfm27dUpTi8gXiTF+MfmjDOJmtsvnIA/b/wJ2hBaUx6tDYWO6
        9zXlXQ3I3tIQmdeLET0XyTDqxKEeEic=
X-Google-Smtp-Source: ADUXVKLODgPIB6ZP6vDhTROm1twHDl/WYxexZyjP69RVvBoHF8riZEIb58dbsGq3dd8QnA4w5ME7iQ==
X-Received: by 2002:a1c:8590:: with SMTP id h138-v6mr4457028wmd.85.1528149060490;
        Mon, 04 Jun 2018 14:51:00 -0700 (PDT)
Received: from rigel.lan (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id b74-v6sm34978wmi.13.2018.06.04.14.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 14:50:59 -0700 (PDT)
From:   =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Marius Giurgi <marius.giurgi@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 2/2] pull: allow -e as a synonym for --edit
Date:   Mon,  4 Jun 2018 22:50:23 +0100
Message-Id: <20180604215023.20525-2-rafa.almas@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604215023.20525-1-rafa.almas@gmail.com>
References: <20180604215023.20525-1-rafa.almas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git pull`'s documentation mentions that `--edit` can be used with short
option `-e`. But `git pull` doesn't understand `-e`.

To make things consistent, teach `git pull` `-e` for `--edit`

Signed-off-by: Rafael Ascensão <rafa.almas@gmail.com>
---
 builtin/pull.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index e32d6cd5b..dd54f2e57 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -154,7 +154,7 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "commit", &opt_commit, NULL,
 		N_("perform a commit if the merge succeeds (default)"),
 		PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "edit", &opt_edit, NULL,
+	OPT_PASSTHRU('e', "edit", &opt_edit, NULL,
 		N_("edit message before committing"),
 		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
-- 
2.17.1

