Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13FB11F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeBILFz (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:05:55 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41771 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeBILFy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:05:54 -0500
Received: by mail-pl0-f68.google.com with SMTP id k8so1314634pli.8
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6d1uMZuR4hCtfl/otdVx9VitZOK8+XoH87N7aXuXSFk=;
        b=sgB3nkLiDkeR9ONCyGrzZOkmSj5y0sAIbgjfgZtDSQO8v31va0DH52n6HpEgNpuxqK
         lqUdAYhFAQMIsjZSl2QcU2dAILTYjhONjfUaJB65Haq6a/UtWEWsMm9hJrXIDhgOvqVI
         qF2zj/o2at11IRT2R7p1Nw9VReFgiejS/fKWPbHm5cld8x+pgLFsOrIj3zDjZRrKmK7a
         Q8RatKi94gtYqXcWBAw8LHsy+C58JDZDBSymR8aDHpxxiZfE0KZjyGZtQ/RXpxsvxkN0
         2w832hRfUy1J1SzmmNOuCAUpJO/6jTnyEE1IfUmaQLjEmY68bPpLDs9OSk0f9LlcfMUg
         0AwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6d1uMZuR4hCtfl/otdVx9VitZOK8+XoH87N7aXuXSFk=;
        b=rQYJc7w1Ri/0gnXddb3IJxTi1nH90CIXZ2Y9Y+DT0utDcPPTq5LyXMTowGEgjkotQ2
         DCpUdzjT0PjeI7CFTw9NkeDapYbMN2CAtSdljPj43idJrDb1djR6+kiKYkle3qy2NQ/4
         cwa+C1lu4ROvMcGgHwChDmuS5nmKBXreoJMRtSnmYfUVs8xpUPgYCA7LI17tSB4Ztf+n
         lwG7hiKwj5UYLzn+jliJ3eP8DD9lLn6QQ+0cA1S3HfKXvDfGn2mFzwP8n39Xj+tXlMV1
         zTLUR9H7MZOiUNLV7HdOosqBlp4Rhku9bdrTWUrE8fK68VcXm1AQQCS4j8y8az9h+YVV
         EVSA==
X-Gm-Message-State: APf1xPBx9xBhz3vq+WZC3zhXaepu6Q6HWE8Z9wTBI0jaWlE/Y5SEabFe
        YmP5joZTKhLzWEZwlsPUuZE1rQ==
X-Google-Smtp-Source: AH8x225zybMXgGE3iO4h7Tv66TDRBOHFovM6GWND3a5Bol3izziN5aAv46pyt4Lx3r53cJw+NW8TTQ==
X-Received: by 2002:a17:902:5a4a:: with SMTP id f10-v6mr2233886plm.308.1518174353670;
        Fri, 09 Feb 2018 03:05:53 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id z17sm5458798pfi.60.2018.02.09.03.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:05:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:05:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 37/42] completion: use __gitcomp_builtin in _git_rm
Date:   Fri,  9 Feb 2018 18:02:16 +0700
Message-Id: <20180209110221.27224-38-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No new completable options!

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/rm.c                           | 2 +-
 contrib/completion/git-completion.bash | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 6e0c7f5ac6..a818efe230 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -242,7 +242,7 @@ static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__QUIET(&quiet, N_("do not list removed files")),
 	OPT_BOOL( 0 , "cached",         &index_only, N_("only remove from the index")),
-	OPT__FORCE(&force, N_("override the up-to-date check"), 0),
+	OPT__FORCE(&force, N_("override the up-to-date check"), PARSE_OPT_NOCOMPLETE),
 	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
 				N_("exit with a zero status even if nothing matched")),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e63f2f2741..30a51c5015 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2715,7 +2715,7 @@ _git_rm ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
+		__gitcomp_builtin rm
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

