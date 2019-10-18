Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EA931F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 23:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390559AbfJRX4B (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 19:56:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45397 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbfJRX4B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 19:56:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id u12so3573537pls.12
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ix7uSxVWilVhkd7qYxVbGW5wlrsuOd9psoB8Ue4pTb4=;
        b=mg4RaiDi0+dqxYIztDFmijMPtfjIOzOA051Q91D/lXYxEbugQUBYHTmzgnXYDboxXg
         KsdBrczZIVmdDBjxfteRhg+beoYZ5OzZmtLBEEs5WKptIKeHApsdAvDu1fbTvlZsiq3c
         EGp0kijkFgjoluuneLGbbPlE3Ok7Fqom55NOSHxooouxRiqM8CQP5wX2DxBY+4vsTmHr
         AGMhA6x/c5hkfxPvwXwGVPGGjbz7pmJtJ538/6eWWSuDor9GiFbk5EeG1wrSqUC5MkM9
         GoXXIWVrtKQKhwP9wt6beTilZ1pufiopPYIU4ExiLYzQJULjcvvhdRbHrmcEAhcy6S8O
         h4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ix7uSxVWilVhkd7qYxVbGW5wlrsuOd9psoB8Ue4pTb4=;
        b=kAXSqCzpEdMhYAOZMyW7Q/ziNiGF7PpkumUeURi63PQzM3C89XDcRkJWiweQktjNHe
         X1eDMv0RQOhuOtUy3l/ZBn30oKihaXMX55klJFFdIlDv/4kQaBfewuw5F7CglDpTQ8Rf
         F9kV4wWMhJuzVZe0uNuFicHcgSdwUiA7M/WgE6jyUh56Mfr+yrHsrHE8hlc7F2tswoSF
         aurt6jARUNjPnIk0Na4lZr50k1rMoDqg3t8hauHUFVoUwrS9FmB5iVZWEJrxBPxw1F9b
         uQXTgpteQRoA4mJZcG7MgKGaIb8bZ858Tnw1YpBWh1HGZWI4kTfIGkRgYNi0nxRWxsNH
         oRSg==
X-Gm-Message-State: APjAAAUt7ZK3c8bizJL0YX4stpRVY/67IrRwwCxJSAdO+fJcnx75Ot9d
        6u5Kf8B62YpzT4RHR9FkquAXQdAi
X-Google-Smtp-Source: APXvYqzbLtzKNDomX8t1mJb8cTn24YgCM6cB8J3cSFmNESfbyemJuUFZGO+4qadwoJYAxynulEPj+g==
X-Received: by 2002:a17:902:403:: with SMTP id 3mr12067359ple.206.1571442958813;
        Fri, 18 Oct 2019 16:55:58 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id c14sm8937911pfm.179.2019.10.18.16.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 16:55:57 -0700 (PDT)
Date:   Fri, 18 Oct 2019 16:55:56 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase: hide --preserve-merges option
Message-ID: <47bc4470e22c349082ae45b1e4b5c2547d30d4d2.1571442786.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since --preserve-merges has been deprecated in favour of
--rebase-merges, mark this option as hidden so it no longer shows up in
the usage and completions.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
This patch continues the deprecation effort and can be based on top of
`js/rebase-deprecate-preserve-merges`.

 builtin/rebase.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 21ac10f739..0d63651d95 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1099,9 +1099,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			N_("let the user edit the list of commits to rebase"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			parse_opt_interactive },
-		OPT_SET_INT('p', "preserve-merges", &options.type,
-			    N_("(DEPRECATED) try to recreate merges instead of "
-			       "ignoring them"), REBASE_PRESERVE_MERGES),
+		OPT_SET_INT_F('p', "preserve-merges", &options.type,
+			      N_("(DEPRECATED) try to recreate merges instead of "
+				 "ignoring them"),
+			      REBASE_PRESERVE_MERGES, PARSE_OPT_HIDDEN),
 		OPT_BOOL(0, "rerere-autoupdate",
 			 &options.allow_rerere_autoupdate,
 			 N_("allow rerere to update index with resolved "
-- 
2.23.0

