Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68F5F201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753084AbdBRNd5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:33:57 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35039 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752912AbdBRNd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:33:56 -0500
Received: by mail-pg0-f65.google.com with SMTP id 1so158385pgz.2
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eiq4esCiKcSmzikA9N8ZKuQ37WAnD0JI83PboXgRTg8=;
        b=nVC2aknJx0lrrP3ythh/sA7kzJRnoenhRYnl//zAEZFjOoEOE2oKl26rCbadMoehhH
         DYQWdzohHGpWRqyQyVh1109pWhcN3KuTDAjJ4TYfNg3kLRCQPBqX9pNOmF7sB0YLvJ8m
         Pw+b8GR/u2sCIDTQKYyWwd8rksqoZSwrwaAPdvLHvn1L14h6PGymQkKBnfnnYwYC4Yt+
         TRdIhtKR8VbQjrTx7551Sc1XYZg7osj79TncMoQxTRNogy2DR76wfdK3zPyLj/m7DjJS
         O2t+6zD40lDLxuY6P1l2LyP5lgn2JDAPCslXE1HlZd8H0ZacwrZAfnwcgyafiqVKrym0
         UrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eiq4esCiKcSmzikA9N8ZKuQ37WAnD0JI83PboXgRTg8=;
        b=NcSkGNjZOTFO+olKbLjQGkOeaoGvOhxC0Op2DIB3W2vWhbT+FkIzpKPdcBxL6+XVlL
         gDBAEH+i4vaxrtVVmhPfU0MQU7c0Hr+7SwwkTF8jTXWtGdb9DEgF4znxiyIzpJaRhC0S
         uxNAY8s4gMJ11DKTFAtgFP/IRg3KyvlX+1/Yt2FPPHcVSP/qGarrPL3OK4zMboTlCSTg
         PsatZMceXCQUCWDUuS243cQjhiTj/js5weIValaUv3h9lBfbucYexD+5ZP5SjMtNoU2H
         uopbJSWZlJvqX287yoY3Y+mcRjxVFn0An1+tXayIKNenB1fGCXSaZpxpwUXHacFgNXp0
         44hg==
X-Gm-Message-State: AMke39kyloNALABo8g2QcErIDecgL+zvP22SkFe7M8PbNX6vxNhAmJmHQ0Xnx/tQ8/qiVg==
X-Received: by 10.98.198.199 with SMTP id x68mr15063109pfk.87.1487424835764;
        Sat, 18 Feb 2017 05:33:55 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id d124sm25616173pga.30.2017.02.18.05.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:33:54 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:33:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 05/15] refs.c: share is_per_worktree_ref() to files-backend.c
Date:   Sat, 18 Feb 2017 20:32:53 +0700
Message-Id: <20170218133303.3682-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170218133303.3682-1-pclouds@gmail.com>
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 6 ------
 refs/refs-internal.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 81b64b4ed..c6af84357 100644
--- a/refs.c
+++ b/refs.c
@@ -489,12 +489,6 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
-static int is_per_worktree_ref(const char *refname)
-{
-	return !strcmp(refname, "HEAD") ||
-		starts_with(refname, "refs/bisect/");
-}
-
 static int is_pseudoref_syntax(const char *refname)
 {
 	const char *c;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f732473e1..8c5febf54 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -657,4 +657,10 @@ const char *resolve_ref_recursively(struct ref_store *refs,
 				    int resolve_flags,
 				    unsigned char *sha1, int *flags);
 
+static inline int is_per_worktree_ref(const char *refname)
+{
+	return !strcmp(refname, "HEAD") ||
+		starts_with(refname, "refs/bisect/");
+}
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.11.0.157.gd943d85

