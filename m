Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1755FC4332F
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 17:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiABRQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jan 2022 12:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiABRPy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jan 2022 12:15:54 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE09C061785
        for <git@vger.kernel.org>; Sun,  2 Jan 2022 09:15:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so17267205wmb.0
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 09:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=dIrCKVVzRiAOKMSwfvZ+IUNVZURkizaVoO9uiaN5RHQ=;
        b=iMJ6tn5hYLWHIRyKF6N7GppYpJMogTHYeCi3f7EaB1Y+JHpYl6CuZykVYPCRVErv/F
         Luuodkloql6AT6f8GJbb605UufBv6LidVts+bGd59JLiPXFEGSyFnq3WpTTvPG7F47HR
         qSczvYNbTLsMo34JEm8bqdSRwaxgVxEgYYA13nItRhAyZrZKy/Bsq9rTftXqjKE2L9Or
         1Bgms5X8rgkBOou0d8cUIzDQGo+djuBw3FBxzBCJJNhhQjjjJQwl3DYdTSN+dMyDwbdM
         MxuiXy+wXhvcQvfjNMvsQ7IkpezYIhW+/ropAF0shUD9W4JSLf3YnNd8YVS8ndUZmAHg
         Lq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=dIrCKVVzRiAOKMSwfvZ+IUNVZURkizaVoO9uiaN5RHQ=;
        b=s8HTY/8xk7fR/+m2R8085WCLAQkee+Pms9jlSlufvl/dAtdGPkOlOwhYF3tTHpVCab
         GM5gsVxmFStxKCc9Q2rQFgoXg52RAHQe9VXFi28+83IhzwqSaxYixlKDCInu0m8az+Sl
         nDAJK54+HqOBpR9xN9zb/d1LH+2tfYVTU1Hm0AhQG8l4WC4/4OQXs6B8bXpH2VJcaUL1
         B2FNdTr2paO1KcdyNhhbrfYKuLvvlgiFpN0SG2LWk83ygjhR1UjXveGiIspDjOi1ZvZS
         FBdv53WwsSJ4cDILsIXJ5Y8Ttn2eJGvr6DEqH1LGJizYe8IRXKsHFZofJonipkxpZpD4
         d7Nw==
X-Gm-Message-State: AOAM531uFEDOMQry0RpHvC64HdKrwiKHGQJ00gtuEnra3gLBwpi9DfJ4
        II/kj2QxQ3TQQjFSGEOf5W3B2WxNUDQ=
X-Google-Smtp-Source: ABdhPJzfpfApcQV1TZrkej3XmHlg25nHeboaeOeiICtc+9gaNsPpfVtHjVmhzQTBpRN6w94ryNU4Hg==
X-Received: by 2002:a05:600c:24e:: with SMTP id 14mr35470081wmj.67.1641143752573;
        Sun, 02 Jan 2022 09:15:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w21sm27664680wmi.19.2022.01.02.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 09:15:52 -0800 (PST)
Message-Id: <a9d8a50d66676ea10292e8319e3eacbf7bcd83f5.1641143746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
References: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
        <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 02 Jan 2022 17:15:39 +0000
Subject: [PATCH v4 05/11] i18n: tag.c factorize i18n strings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/tag.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index dfdcfd37956..82e09c1b83d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -483,6 +483,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int ret = 0;
+	const char *only_in_list = NULL;
 
 	setup_ref_filter_porcelain_msg();
 
@@ -542,15 +543,17 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 	if (filter.lines != -1)
-		die(_("-n option is only allowed in list mode"));
-	if (filter.with_commit)
-		die(_("--contains option is only allowed in list mode"));
-	if (filter.no_commit)
-		die(_("--no-contains option is only allowed in list mode"));
-	if (filter.points_at.nr)
-		die(_("--points-at option is only allowed in list mode"));
+		only_in_list = "-n";
+	else if (filter.with_commit)
+		only_in_list = "--contains";
+	else if (filter.no_commit)
+		only_in_list = "--no-contains";
+	else if (filter.points_at.nr)
+		only_in_list = "--points-at";
+	if (only_in_list)
+		die(_("the '%s' option is only allowed in list mode"), only_in_list);
 	if (filter.reachable_from || filter.unreachable_from)
-		die(_("--merged and --no-merged options are only allowed in list mode"));
+		die(_("'--merged' and '--no-merged' options are only allowed in list mode"));
 	if (cmdmode == 'd') {
 		ret = delete_tags(argv);
 		goto cleanup;
-- 
gitgitgadget

