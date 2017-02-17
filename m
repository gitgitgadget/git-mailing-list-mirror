Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 853CC20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934137AbdBQOFe (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:05:34 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34568 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934070AbdBQOFa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:05:30 -0500
Received: by mail-pg0-f65.google.com with SMTP id v184so5047864pgv.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wiD/H4Nufnbe0cOIQ7LP8avhtOxNo4kDIIKtkQGAKKA=;
        b=Z+aWXOO0czeVcFFu3abkM/oIExJIJVTnEJHKY79uAeT3czlggkNkZAFITLa1ZHMkPX
         XY6BYChNY9bmY7VAO9pL4Ew8/MzafaOtNfw3x8RSQOhkLC+XphYxsmEmDk6zJ4OCFB2z
         /1DrdEos6gT7lci2HAjJ0ILjj7H2i6PApNJ6Ak9Ll9Q/UfmEEeU3pdBOZWy5daw16Uz9
         3iDFFoPcBRaRAErafAFGF7hJTu6629bAbijDgRW/3vOGG4WD8CbAVsL3BIcls8SMo6gG
         Wc0lwG8tJzcC5Gsf/EickQmfgs8WEEmuN9N/mO/hH3/hJdESfppzTiCcXhX+V4jaSW7n
         xppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wiD/H4Nufnbe0cOIQ7LP8avhtOxNo4kDIIKtkQGAKKA=;
        b=hzoEBSMKlH3j+j8tKWreSNuOwDR4e5AzdcOyWJHpHL88td0Nn6w3lbj0BNR5JLQHK8
         XXtrDdQ3j5G4WabmfSCp8TXlq/iJlqYMREKAFAMwGsULO19Z1PUFCna88RC4WLMrV17Q
         aUtAyqn/DDmlQteVKPUcZgEEIOtYfbEOOg5XGSS/ZJaKBV3qVWgIwhMYd4aFrjK4+3Fp
         ZGwEf/UVlhwd3yqbf/9OWwM5vHDogCH/ozdvQtVD+eWcKSCioOd3uJdE0QgNrbFDJETG
         wRp8gl+cNDMT+/E/mPhorW/Z6TTOE+bEgzC7KNpCBo5+gnEnbN8pttoToYdkYx8lw4gE
         5hEg==
X-Gm-Message-State: AMke39ngjvzuPxNg/M6UHfb++2wwFZ7WP4noczclrnWJZa6foUTw2tIp6K3Qj3L2elJjag==
X-Received: by 10.99.5.15 with SMTP id 15mr10176467pgf.109.1487340329910;
        Fri, 17 Feb 2017 06:05:29 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id y21sm20081475pgh.52.2017.02.17.06.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:05:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:05:24 +0700
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
Subject: [PATCH v3 06/16] refs-internal.h: correct is_per_worktree_ref()
Date:   Fri, 17 Feb 2017 21:04:26 +0700
Message-Id: <20170217140436.17336-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217140436.17336-1-pclouds@gmail.com>
References: <20170216114818.6080-1-pclouds@gmail.com>
 <20170217140436.17336-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All refs outside refs/ directory is per-worktree, not just HEAD.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/refs-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f4aed49f5..69d02b6ba 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -653,7 +653,7 @@ const char *resolve_ref_recursively(struct ref_store *refs,
 
 static inline int is_per_worktree_ref(const char *refname)
 {
-	return !strcmp(refname, "HEAD") ||
+	return !starts_with(refname, "refs/") ||
 		starts_with(refname, "refs/bisect/");
 }
 
-- 
2.11.0.157.gd943d85

