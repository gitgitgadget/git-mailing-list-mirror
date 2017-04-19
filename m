Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3A81FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 11:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762605AbdDSLDW (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 07:03:22 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35470 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762592AbdDSLDU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 07:03:20 -0400
Received: by mail-pf0-f196.google.com with SMTP id a188so3211341pfa.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 04:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0l7TdYpDCYYdE1HP8l3ti0jvGLmYLpAgb9JCg1umJU=;
        b=k9nDdWesVjcLdTIFIh21blf0a3f5lrst6EbRbwFPVskimaG57ia55/ZZlMo5siyksh
         crPB0khwd98sJ4WnQHVB1m3B97frwabtzshcxIsb9zozIwfbe2OhGFoHLOOGYoyDz1MA
         YABCA8/7CcJgE/cauaddQe+RSDTS6tz+MzMPiAFf3xfkrqI/f7vb4KE9AR7R+AW9E3z2
         2HFWjskOfH8hI9PDi4HgHOgy77aAdGGX/CgocjpWaYo+ADDgYn3FWLpiBHuT1CPvbyOl
         LmZxKGvmoWaAd/zVoUAc5yn5w/QvKYFeylVbA8ZWCWeWbdcr+/gBAt29VRl3o7hGALWl
         8RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0l7TdYpDCYYdE1HP8l3ti0jvGLmYLpAgb9JCg1umJU=;
        b=TMBPxPeeGu4kqSCRrve1pCyG6VhECaT46UlzfWG5qFDQ/EJ2k0Wp8QQJ/zH0/YY2XO
         Uaeoc3zw/xz33DrH5uGqUnbGzX9vWmJSqSyaaR5fvylJeX6+sl9lXzBDKSLJjABYnIdl
         jy4rQWtum91fN8SS0Fo+SPJyeWR6sHSGIeQ9fUzDD8xz141gxj9EnKvTSf96QZSUwM89
         9UePXNM0Grr+r+GKpVLodrod6+KSyhKSfNkgwSPJ7EYnZZTcKHjVy1/suOIC59aSBnnh
         G2NZBnzKTvCQK0sV/USnpqRS4fGSzH2AWnzdm9vVxtV2wPptP2KxNpxPkPQD1QfTJ2e8
         +8XQ==
X-Gm-Message-State: AN3rC/62zT4Bfbe6bocF+c2rvzatmummOMqv274UXTkSQZiqU4s2bYOI
        rtitsrL6lUCctA==
X-Received: by 10.98.113.74 with SMTP id m71mr2517555pfc.231.1492599789870;
        Wed, 19 Apr 2017 04:03:09 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id e13sm4007576pfb.30.2017.04.19.04.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 04:03:09 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 18:03:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 12/12] rev-list: expose and document --single-worktree
Date:   Wed, 19 Apr 2017 18:01:45 +0700
Message-Id: <20170419110145.5086-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170419110145.5086-1-pclouds@gmail.com>
References: <20170419110145.5086-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/rev-list-options.txt | 8 ++++++++
 revision.c                         | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a02f7324c0..c71e94b2d0 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -179,6 +179,14 @@ explicitly.
 	Pretend as if all objects mentioned by reflogs are listed on the
 	command line as `<commit>`.
 
+--single-worktree::
+	By default, all working trees will be examined by the
+	following options when there are more than one (see
+	linkgit:git-worktree[1]): `--all`, `--reflog` and
+	`--indexed-objects`.
+	This option forces them to examine the current working tree
+	only.
+
 --ignore-missing::
 	Upon seeing an invalid object name in the input, pretend as if
 	the bad input was not given.
diff --git a/revision.c b/revision.c
index f4bc9bc65c..79ce8a007f 100644
--- a/revision.c
+++ b/revision.c
@@ -2222,6 +2222,8 @@ static int handle_revision_pseudo_opt(const char *submodule,
 			return error("invalid argument to --no-walk");
 	} else if (!strcmp(arg, "--do-walk")) {
 		revs->no_walk = 0;
+	} else if (!strcmp(arg, "--single-worktree")) {
+		revs->single_worktree = 1;
 	} else {
 		return 0;
 	}
-- 
2.11.0.157.gd943d85

