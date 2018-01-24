Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7FA1F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932685AbeAXJa6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:30:58 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40712 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932606AbeAXJa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:30:56 -0500
Received: by mail-pg0-f66.google.com with SMTP id g16so2296814pgn.7
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rLYt7j1wfWGV6XqcjWd4j2qIjMUk5eq77llsZDXaL88=;
        b=mmD4Oajbb0b6gOQRYxX6T7U4spJZdI2+z0B5+9dapkDoCCeXmfrrJefPvrRysJ98aN
         +sdb30IkECQTqTb6NhISkD11TGne7ubUPPobNJZk0BDxCgK4pD0MeQks3fny2Si5/XtA
         XtuAnZOeEt0ZXW/iIIaELmBA6yl2K2ldAxMd4a7CBIGJl2ML5FtLFVWWz34IoKB6mWqN
         v7UVkOrOLqwUS0MnMt0ozFCU9ZX9o/C518QNmg2YVdOfrF6cYjoxHcXWT3gdodOnM7Cz
         wqCSep7s6DSCU0mLbNdqTbb6mh5iFRKEhHaqvv+apJ1LYM5A6oSuX/JYXTF7PcynvgTM
         tSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLYt7j1wfWGV6XqcjWd4j2qIjMUk5eq77llsZDXaL88=;
        b=V3EHZ3tdh8aDqb8iCfbvB6gb+eMWiCmNlZ99v3D1YFkBKTceoVrvMr98eM6h0iREDu
         NffOx095hVNDMN9AgSZ/UqRc1ICoVGuKu24UnstMPLajLcz/rN/JbfxceIJ4g6R0ffe6
         TBoUoiWAa0PgfVCx2GGadlScD/v0mj5LBaHvC8B6DNF8ob38Tq419ETY+7+R2ro5VySW
         sxRoQoa8zkpe6PExiDCKjZ/bo+9gS48Ma38efptJRFDE0qFKYl5PhShYivq/cfdyDqCI
         N8bKid7nXLuwD7rLpVw6hb+09vAdGJRtxg+xRO6JGJ4bKhwsPcOJJFPr9tvjeIzKYB84
         XaJg==
X-Gm-Message-State: AKwxytfwqO3ofChzzIUKFCcgBvERpjui+Rpm+F8bvj9c4n5OeRCHJv+B
        H9WLykB1+m7IA8c1EsYAZIlpkw==
X-Google-Smtp-Source: AH8x227kYvg+n7Brgd6AWhuFCBTGc1iSm1WgdaPe3cSzmxE6hdJmX6+gd0Qptq1CXsUXSXNYeuXPJQ==
X-Received: by 2002:a17:902:d68e:: with SMTP id v14-v6mr7390316ply.241.1516786256321;
        Wed, 24 Jan 2018 01:30:56 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id e4sm7717869pff.116.2018.01.24.01.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:30:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:30:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] dir.c: stop ignoring opendir() error in open_cached_dir()
Date:   Wed, 24 Jan 2018 16:30:23 +0700
Message-Id: <20180124093023.9071-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180124093023.9071-1-pclouds@gmail.com>
References: <20180118095036.29422-1-pclouds@gmail.com>
 <20180124093023.9071-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A follow-up to the recently fixed bugs in the untracked
invalidation. If opendir() fails it should show a warning, perhaps
this should die, but if this ever happens the error is probably
recoverable for the user, and dying would just make things worse.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 44b4dd2ec8..55736d3e2a 100644
--- a/dir.c
+++ b/dir.c
@@ -1787,11 +1787,16 @@ static int open_cached_dir(struct cached_dir *cdir,
 			   struct strbuf *path,
 			   int check_only)
 {
+	const char *c_path;
+
 	memset(cdir, 0, sizeof(*cdir));
 	cdir->untracked = untracked;
 	if (valid_cached_dir(dir, untracked, istate, path, check_only))
 		return 0;
-	cdir->fdir = opendir(path->len ? path->buf : ".");
+	c_path = path->len ? path->buf : ".";
+	cdir->fdir = opendir(c_path);
+	if (!cdir->fdir)
+		warning_errno(_("could not open directory '%s'"), c_path);
 	if (dir->untracked) {
 		invalidate_directory(dir->untracked, untracked);
 		dir->untracked->dir_opened++;
-- 
2.16.0.47.g3d9b0fac3a

