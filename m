Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D4A1FAE2
	for <e@80x24.org>; Sat, 10 Mar 2018 11:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeCJLwb (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 06:52:31 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33682 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeCJLwa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 06:52:30 -0500
Received: by mail-wr0-f193.google.com with SMTP id v18so11346395wrv.0
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 03:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CldFb105PqW2ftMNXsRW5dhAH27eMR+0S0l9p8Egms0=;
        b=L02ZEBEKiyuPEgC00pokhuf7JLhWcGw3Zeepe9zPAUtUgHQ7IUlyB0WU8qwPakI4Sx
         X2Mmq86dIlBwPqIsQe5B029qG5lz+jtVw5NOHyr+YbHGji32GgcZzlpBbAwQmfTBlUSZ
         5WYRgLTickU1EaYFI0NCiknjy7yCYvIdPyGOs621nMMsTOgNsE50WQa7ip6eo8dREWVB
         OXsWudvjXuAIH4Sr5jU/PC4A4UsFYowqj6/X1oFmOC7BYPOcF21gG50aL4+M9bKYXEoB
         uK/XuBhrEUrw9fwnGQ8zZmf+RuRZe8DweXBXfCMDGvjHeDpWqVIZko3qKgPWg1kTrQhg
         aajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CldFb105PqW2ftMNXsRW5dhAH27eMR+0S0l9p8Egms0=;
        b=hAx3ktgSSX0XrnGouLdgJOARXIk9bwcxVD3tFN8MIlxtSQrTZRorGuOaFfnb3yVjgu
         SHbyTvwhAC2UENbXHndRok5/+bdeVLIz3RONpt7No20B/rOeW8Am0I39GnbDvc5eyTTT
         ellAE00pbSRk7/LLQh87jxF2PcdFD+ePvnbigDk4ZANWFHGiwIBgwjbZNLs8Nl4zNJ4i
         KZ8DhKuuoRA8t4r7a5NKMl3AXvX+h9Zy02uYRHO8bM2RZRXHmlsddSrhxo26JCyanDPl
         1GYutUPszXXogc06F7k5gtmAKo3fYheQ6tSHeZUS2tsNqOo8p3iW6zKnJ8sI+N5vjcZJ
         edew==
X-Gm-Message-State: AElRT7E8EG87aaN9TE27ub7YCMaYaDoB2DD1GhWIuu0DTt9HCE20qE2O
        Ol8YN5niSLyYAmetFf1KAkpQdKca
X-Google-Smtp-Source: AG47ELsSkEomTxsZFDV6DuGnKyhTIQjCEE0lDdW4u9gH792cK+mJSY26BbLzkDQmbV05hUVv+zTRyA==
X-Received: by 10.223.186.66 with SMTP id t2mr1518542wrg.155.1520682748556;
        Sat, 10 Mar 2018 03:52:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id s21sm2802147wra.45.2018.03.10.03.52.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Mar 2018 03:52:27 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] shortlog: add usage-string for stdin-reading
Date:   Sat, 10 Mar 2018 12:52:11 +0100
Message-Id: <e5f4720c077ee613518ee91f814dab82265ea981.1520680894.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1520680894.git.martin.agren@gmail.com>
References: <cover.1520680894.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This has been missing since we learned to print usage, way back in
4e27fb06f (add commit count options to git-shortlog, 2006-10-06).

While at it, drop the [] around "<path>...". This matches `git log -h`
and Documentation/git-{short}log.txt. It formally makes it look like we
do not allow `git shortlog --`, but we gain readability and consistency.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/shortlog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index e29875b84..dc4af03fc 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -11,7 +11,8 @@
 #include "parse-options.h"
 
 static char const * const shortlog_usage[] = {
-	N_("git shortlog [<options>] [<revision-range>] [[--] [<path>...]]"),
+	N_("git shortlog [<options>] [<revision-range>] [[--] <path>...]"),
+	N_("git log --pretty=short | git shortlog [<options>]"),
 	NULL
 };
 
-- 
2.16.2.246.ga4ee44448f

