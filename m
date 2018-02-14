Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20CA41F576
	for <e@80x24.org>; Wed, 14 Feb 2018 10:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967204AbeBNKwE (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 05:52:04 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34488 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967114AbeBNKwD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 05:52:03 -0500
Received: by mail-pl0-f65.google.com with SMTP id bd10so3482783plb.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 02:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sjh1TXvTpzBepfPa8qHHE/B72iVv4Q29VflgTpg235U=;
        b=qPqZLayvooYlmK81P5Ni0g6AL1NFqnPDzu2fTY3VG9+kmHKXVCVIqNoxtDhsyEVVs9
         6UxOLXKxYBN3tymFoeKEOVpYcHp3CfjX46SdBj+1+N409DoHIzYMjZX2qxBEKt7NugQW
         Q5ThI6FqGXtog8cwU3g9E3aW2Uf7b1v5c848ghwp6jWAt7T3/znsiVA6ptR7OE3BDD5k
         ff0BYDeFa9Czp935gDRshVxcWIqGDWMzYAestWtdGvodKxzw53VtTF45k23SyBuNbW4z
         2RuCQ9h56IbTJOoGLqmKdBQC85vDv9z4DXi8rl2KDWTCmmknEImXgTwZB61PI5D73C8E
         Fcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sjh1TXvTpzBepfPa8qHHE/B72iVv4Q29VflgTpg235U=;
        b=hE3se2AcjkctPSnSRfRARhE4p5sXOZmpbF1iGF3jpoSA26HbEgJew+FWenkO/cnUcT
         xDOs9DDSbyPJ3zRidG3/80ycb/RIxyPRNWHaa6R8hTZcemVWh2oHjq2ukKLXdpaalrND
         XvXuDle3RzWLXxyzNzGlfq5G1b2qY6HxgUEtk1BvY8T63mAd81HbLhoZ7E2CbnUdWQN+
         B3DTL7HNlM6Uc3yXsVbWNn31sHIfRKV2MBdj7bnmMmafURn012eLIlqBo88BONH8jqmh
         48+/E3pX9xW/Tsovk090UHsI6TWCiSzsyF55T5rl8Tbce9ZLOrrT7BGeVrEOAKQTHNhl
         rtwg==
X-Gm-Message-State: APf1xPBOqfNw8DoH9Z2vbnsccE+06TNLZMDpFLYi77j3KyPrQFMPEAvK
        LckOLZ25EuCDDqGDpxEPDi8a3Q==
X-Google-Smtp-Source: AH8x2270ISgKj7jJNYFUDP+2HSBMdU2wF+X7FMYvm10u0rAOVdrHS3gJZZMkhwGg7C81Z+1FlZKY8g==
X-Received: by 2002:a17:902:10d:: with SMTP id 13-v6mr4033941plb.266.1518605522546;
        Wed, 14 Feb 2018 02:52:02 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id m140sm9723142pfd.73.2018.02.14.02.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 02:52:01 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 14 Feb 2018 17:51:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     doron.behar@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] init-db: change --template type to OPTION_FILENAME
Date:   Wed, 14 Feb 2018 17:51:49 +0700
Message-Id: <20180214105149.28896-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180214105149.28896-1-pclouds@gmail.com>
References: <20180214101019.gaenosifgq3wx2nm@NUC.localdomain>
 <20180214105149.28896-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OPTION_FILENAME has some magic behind the scene, like prefixing which is
useless for init-db. The $HOME expansion though does come handy and
makes --template more consistent with the rest (both env and config var
get $HOME expansion).

Noticed-by: Doron Behar <doron.behar@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/init-db.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 68ff4ad75a..d6bd9f19cb 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -473,8 +473,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *template_dir = NULL;
 	unsigned int flags = 0;
 	const struct option init_db_options[] = {
-		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
-				N_("directory from which templates will be used")),
+		{ OPTION_FILENAME, 0, "template", &template_dir,
+			N_("template-directory"),
+			N_("directory from which templates will be used")},
 		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
 				N_("create a bare repository"), 1),
 		{ OPTION_CALLBACK, 0, "shared", &init_shared_repository,
-- 
2.16.1.435.g8f24da2e1a

