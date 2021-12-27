Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56102C433FE
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 23:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhL0XYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 18:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbhL0XYE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 18:24:04 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14855C061757
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:04 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso11760881wmd.2
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DXvU1WRND/1OxKy66Ot0PFFUbBLPRT2Ur5ESuVWIymY=;
        b=kBmNiiLDjjUC9/fjsuuAjvaXMCxsPeKn2PjW2G0Xa5T2iD1VilGD71li96ZW6hP/jf
         SPb2xfrDMR2yzQz6I3/7paBGrwLzBUiUAauDOcf8Y9b6pUCg0mXGI+Sv9poUfCD5PbTp
         o3dZVdDUeeCRliyX56blFgBEecZ2DJSKfLCc97BNmlUbi1/Y5JloQ1B+g8N4IaVyhxhc
         b3I1gffpdGuMKmDVaXbO7YqypUKB1QCkbpClHz6SxIpsCKMFnZgXCYEAOE77I1isieNj
         7LANbJagVjJUbKZPJONjt31432nRblYy6JuyvyICbNes0wam+ayMTlnRWHr1KXqGivm8
         5IxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=DXvU1WRND/1OxKy66Ot0PFFUbBLPRT2Ur5ESuVWIymY=;
        b=hpNOte4PIMfiHVBOVfCJPt8Fl9fGy48fnZEWjIrZFiUZgAUQBGR3lDw2r5fQzWDK/1
         zo89zr8JLp9lcHkezNkwT5Z8UcVV3JP+MVMMV5lZ20VbH7ymYjV935FytuzQN99qbQdd
         crCE64lX1qt9qzTLfsWz+o4NwXKQb0e0eOMrRpsUOrGUoT8LBANB9Imj0I4SioAssq8V
         N/CnpWHCOhs81cc9Te8kJw3PdzK/t+cjiyszz6en2DHoXsfZ3cnxmPHjU0p3/fQaNOZp
         eVtd+DE/KKjCKqXns53F6DrnIF5qKQ+G4+TApEWN+PFlGxVf7xAbxWd2u9CV/QbaiSfT
         iG1g==
X-Gm-Message-State: AOAM5330xK3GaJGCvrXMx4gTfJAqScb1DZkcmrju8hRPCXLQ3VFqy+BC
        osRR0zeycdUOywpgHcmIAkPuYYd0Sas=
X-Google-Smtp-Source: ABdhPJw1H87Av3a++kj56yy6hngLDHD2zIZOeNKpe2/swXLGIqRvOfrvQQREPIWMLAjcwHas+qdXog==
X-Received: by 2002:a1c:a98f:: with SMTP id s137mr14759118wme.5.1640647442514;
        Mon, 27 Dec 2021 15:24:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm19091559wra.9.2021.12.27.15.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 15:24:02 -0800 (PST)
Message-Id: <6d89c23a248d1c11db0e92c4f06392272f00c3a2.1640647438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
        <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 23:23:51 +0000
Subject: [PATCH v2 05/11] i18n: tag.c factorize i18n strings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/tag.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 6f7cd0e3ef5..a2ab2b15304 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -483,6 +483,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int ret = 0;
+	const char *only_in_list = NULL;
 
 	setup_ref_filter_porcelain_msg();
 
@@ -542,13 +543,15 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 	if (filter.lines != -1)
-		die(_("-n option is only allowed in list mode"));
+		only_in_list = "-n";
 	if (filter.with_commit)
-		die(_("--contains option is only allowed in list mode"));
+		only_in_list = "--contains";
 	if (filter.no_commit)
-		die(_("--no-contains option is only allowed in list mode"));
+		only_in_list = "--no-contains";
 	if (filter.points_at.nr)
-		die(_("--points-at option is only allowed in list mode"));
+		only_in_list = "--points-at";
+	if (only_in_list)
+		die("the '%s' option is only allowed in list mode", only_in_list);
 	if (filter.reachable_from || filter.unreachable_from)
 		die(_("--merged and --no-merged options are only allowed in list mode"));
 	if (cmdmode == 'd') {
-- 
gitgitgadget

