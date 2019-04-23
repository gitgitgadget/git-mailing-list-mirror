Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D2A91F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 09:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfDWJUB (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 05:20:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41074 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfDWJUA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 05:20:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so7160930pfd.8
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcJnQvnglapqL3VwCQF5FVzIYiruvllkkju/ESpTUZo=;
        b=If2sEW4iMNd566Jfg/D0TxS/T0gbzBwLLucejRa6TC5Qa6jIbGvHl++JBF0xbBNpsi
         TGP56XkuA6Ep6KJdVbSKROo6f2meJB7xyQ66K0qvH8I792fJyWbpbMti3pMFAhA5WvaY
         pvj7zch3Xq7fdTPXtBsXuN2cv+WSORbhmIdDQ54rVQcpnyAnOWDjBzIh8uZHXQmnQ978
         jnFBnLXfMtT6QIIkkgEe8m8xlgZG1tE36VusWN2tuylzJvVk8Zau+jbhYokf3BgwOLgf
         iLJtfjv5vjWbq+y5xZvnwpVwViLe7odj+feSv2PEbCeQDf/8IPPfKOuRQRxUVEPfFLV0
         tTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcJnQvnglapqL3VwCQF5FVzIYiruvllkkju/ESpTUZo=;
        b=KLN0DC+DjCWTEzbckodc7F3GJJDnNDREHxM/oloRT+6/55vSBxpGPid1W8lDUkfZLi
         M3omsGpEY+ej1C0HnCidQ0jLZL0OxI1WF/68O9BlcekJ5AeHVXW3MuIH2wGq+ZO2m34f
         TuQJ5YkgPpraSzAcQAJpQQ5H4TqSl1fnoYNDWHPFVPeCEP+mIeNPNDcrGWX7upkn0es5
         I7IdGC1OfXYXZMtGBgUfhUA+u2wpYk5+ki5LuTE2U8jsDSFRBcsd9JdzCd5lrv66NH6G
         RT5e0mf8/Q2BZVZcF6TnUBCH03eGyeiIOyC4aNCvpHOKnmSLCTTcCRQMYBcg9fTaUq24
         yTKw==
X-Gm-Message-State: APjAAAVLFdrlmYZI5Brw0l3hrQtQfJFuIiEgYgpma0pR/6C0IWqeiLv+
        7Xhp9lm6IAviU9cFL6XXuaugRgQJ9xE=
X-Google-Smtp-Source: APXvYqz7Udx08h/KlFYiFK12VypqGcIV9M+3LwfpF0glRC67R0WdlKV06TN1yL35HsGZVpbigDGTFA==
X-Received: by 2002:a63:fd58:: with SMTP id m24mr221829pgj.298.1556011200001;
        Tue, 23 Apr 2019 02:20:00 -0700 (PDT)
Received: from localhost.localdomain (36-230-225-112.dynamic-ip.hinet.net. [36.230.225.112])
        by smtp.gmail.com with ESMTPSA id m16sm32785027pfi.29.2019.04.23.02.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 02:19:59 -0700 (PDT)
From:   John Lin <johnlinp@gmail.com>
To:     git@vger.kernel.org
Cc:     John Lin <johnlinp@gmail.com>
Subject: [PATCH] status: add an empty line when there is no hint
Date:   Tue, 23 Apr 2019 17:18:37 +0800
Message-Id: <20190423091837.50290-1-johnlinp@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When typing "git status", there is an empty line between
the "Changes not staged for commit:" block and the list
of changed files. However, when typing "git commit" with
no files added, there are no empty lines between them.

This patch adds empty lines in the above case and some
similar cases.

Signed-off-by: John Lin <johnlinp@gmail.com>
---
 wt-status.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 445a36204a..0766e3ee12 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -175,7 +175,7 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 	}
 
 	if (!s->hints)
-		return;
+		goto conclude;
 	if (s->whence != FROM_COMMIT)
 		;
 	else if (!s->is_initial)
@@ -193,6 +193,7 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 	} else {
 		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
 	}
+conclude:
 	status_printf_ln(s, c, "%s", "");
 }
 
@@ -202,13 +203,14 @@ static void wt_longstatus_print_cached_header(struct wt_status *s)
 
 	status_printf_ln(s, c, _("Changes to be committed:"));
 	if (!s->hints)
-		return;
+		goto conclude;
 	if (s->whence != FROM_COMMIT)
 		; /* NEEDSWORK: use "git reset --unresolve"??? */
 	else if (!s->is_initial)
 		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
 	else
 		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
+conclude:
 	status_printf_ln(s, c, "%s", "");
 }
 
@@ -220,7 +222,7 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
 
 	status_printf_ln(s, c, _("Changes not staged for commit:"));
 	if (!s->hints)
-		return;
+		goto conclude;
 	if (!has_deleted)
 		status_printf_ln(s, c, _("  (use \"git add <file>...\" to update what will be committed)"));
 	else
@@ -228,6 +230,7 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
 	status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to discard changes in working directory)"));
 	if (has_dirty_submodules)
 		status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
+conclude:
 	status_printf_ln(s, c, "%s", "");
 }
 
@@ -238,8 +241,9 @@ static void wt_longstatus_print_other_header(struct wt_status *s,
 	const char *c = color(WT_STATUS_HEADER, s);
 	status_printf_ln(s, c, "%s:", what);
 	if (!s->hints)
-		return;
+		goto conclude;
 	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
+conclude:
 	status_printf_ln(s, c, "%s", "");
 }
 
-- 
2.21.0

