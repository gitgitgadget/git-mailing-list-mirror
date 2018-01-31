Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6BF71F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbeAaLIE (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:08:04 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40665 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753845AbeAaLIA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:08:00 -0500
Received: by mail-pf0-f194.google.com with SMTP id i66so12240065pfd.7
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=luHT5v1LrqfIIw/TEQxTlqzrNdwDAp5dr2vsPLfIHCY=;
        b=U5ohVQUAhMFlu1/HEs5pZRK4XQmsW9ev0f5FHOIP/DwOgUZytWsOzu81Oy9FF49EkT
         JllZzJWKhd2e2mlJrJfOITwXnboCzZl/Hewh0z4wNdQtfisC6x2bq5tcwn4VTJneGuHk
         S9xW4NW9iRpA5n/gywapSuNh/D6gG44LZzTZ/a+iHrupHt+NtlSv0pbyTrYxhwvBtaqs
         1wphO/lXrwSSndAxGamL40O8H2hARh/Qw/rK8bMHH1Cnjd1VJS0L7xJD3IclWWcFOrz0
         VEO8GxguOxwS8tDsx8c9bhNWCWTi7dkHGXH+dZI+q9t6allvqwIRLPzKyBT4eIBGC/R1
         RxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=luHT5v1LrqfIIw/TEQxTlqzrNdwDAp5dr2vsPLfIHCY=;
        b=i1s2HRolYUuPcRfwyYNrJo0/RxZmrTvU8Zgsm4pQzEoR1sEhK2JZA5p8hVr9ELxw88
         X2+5oUFyDDHS3k2y4ZQPe92FkAj3adRrZNaX/tQ6oV00KZy5YpXRKEh4wudQ9G02+r9t
         bbP708Vrj8/ubhostLHRbA97ElH7lehPwUn9CeBUhAp1iKzB+jNsOLlK3YpuNuNOOvKf
         d23NXKhdS9XiMb8qsfpKWFjRAMsvvYzoBf79IqaclFe6cGe2cPsCpSmrlJkBaCSvMXjX
         mjpeB0vDQiiWbIAAeRvmZEqlkq+H6Lcnr3OPXdAikomdwDFXx84LWHkCm4zScCFDIVnR
         COjg==
X-Gm-Message-State: AKwxytdjSsQZeH6Uk+nG08XQtEPz67WwVfGuf7fvBF2jzNEM6Va05Zc5
        8K6yk3eJUZHKxrrUkcahegqMsw==
X-Google-Smtp-Source: AH8x224GXrpq24uMCGpNkNV7ceouzWHux3OiRhJgolGf5M+MVA5p3cCXroeKYYaWyxM6FLGISCzOQQ==
X-Received: by 2002:a17:902:4083:: with SMTP id c3-v6mr24934335pld.90.1517396880084;
        Wed, 31 Jan 2018 03:08:00 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id k1sm25327380pfa.8.2018.01.31.03.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:07:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:07:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 27/41] completion: use __gitcomp_builtin in _git_mv
Date:   Wed, 31 Jan 2018 18:05:33 +0700
Message-Id: <20180131110547.20577-28-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable option is --verbose.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/mv.c                           | 3 ++-
 contrib/completion/git-completion.bash | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index b88023a733..e3e308d282 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -122,7 +122,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct option builtin_mv_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT__DRY_RUN(&show_only, N_("dry run")),
-		OPT__FORCE(&force, N_("force move/rename even if target exists"), 0),
+		OPT__FORCE(&force, N_("force move/rename even if target exists"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('k', NULL, &ignore_errors, N_("skip move/rename errors")),
 		OPT_END(),
 	};
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1bf1728b95..0e36190a19 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1795,7 +1795,7 @@ _git_mv ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--dry-run"
+		__gitcomp_builtin mv
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

