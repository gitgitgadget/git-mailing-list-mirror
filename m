Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D021F404
	for <e@80x24.org>; Wed, 14 Mar 2018 21:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeCNVet (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 17:34:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33768 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeCNVes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 17:34:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id s206so20352922wme.0
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hBnuu0370X1wx8+ZobYdwnJPxya5VZeLj1PZ6N9gjIo=;
        b=QPsU096V57TuvXD3bgajv3+abBr3wi8FQ0S9ReeLndbEcg571Se7T5Hnc0Q3zkScqL
         UyqMpycORTzAB0m+4nTAKIrhAnQVwlHZOk2esYlkV3LEQ71bZ66oRqEizq5wjJJ7t8kL
         5HfY2SAWlrvK3RXnckl4XMLwkspxsaogRglIIMLbu+J+fRMJxNw14vrm8lFQ28mvKKtK
         sYB8UaIwVOMNVgz/rDRkE9Xu0rjNBM04wF/JfAux62E6t3C5LjVNVNwPY13NzI4vT0CR
         BlPFT4wuqBYUhkok6ZBt6z+tHwf70Gi1nY6zd2qCcOM3uXU7kPpe7XlyFRqb6xW+aGv5
         w12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hBnuu0370X1wx8+ZobYdwnJPxya5VZeLj1PZ6N9gjIo=;
        b=MbAFPszo4Vj7rqf8XBEaGoSAMEpFb8MR5SHALha2hGx9A2sVMmtdfMUy6f3HFAS4EU
         rL7ScxAL6GD/gJYIdBFmwgaPpBgfqvIsC3Z8cr4J7+F3xE+X8TcMWDzXMAz5XQDMpafZ
         4biRhSkHelLijXumM2+juePkbtFXJLEQNs5+MEeMw0jlanV/tM+XAJ+mR0hFTKWtx1i8
         Llg584SKh5+oWk7XlRp9E2tZNa+nY47/yf2PfhS3i02iR55usz0IER/ZcnTOsBlHFeZ3
         4/7LCSwd8n+qXwKfROxhCWS2g2E/vOEPPlXqrpOcWv+1JcAMN50/SsNYw+CIRp9GAmWu
         H2VA==
X-Gm-Message-State: AElRT7GauSDmlAE+ed4PHHTSkkwZljjl7gDnJZhp7URClhCsRvyyz4B6
        zf+SGToEOT37rpz4smUI4g3YkNvc
X-Google-Smtp-Source: AG47ELviktElkHo8E+8wvdbiG3FXGFKIj3Yrm78nNqaY7CsxQQHlUAt+WCA2fm9qiiEXfczSun+Ydg==
X-Received: by 10.28.58.199 with SMTP id h190mr2874202wma.119.1521063287018;
        Wed, 14 Mar 2018 14:34:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 55sm5049688wrw.87.2018.03.14.14.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Mar 2018 14:34:46 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] git-shortlog.txt: reorder usages
Date:   Wed, 14 Mar 2018 22:34:17 +0100
Message-Id: <a8210328f4db27cc119178b33e9512f8fcbba35c.1521062188.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1521062188.git.martin.agren@gmail.com>
References: <cover.1520680894.git.martin.agren@gmail.com> <cover.1521062188.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first usage we give is the original one where, e.g., `git log` is
piped through `git shortlog`. The description that follows reads the
other way round, by first focusing on the general behavior, then ending
with the behavior when reading from stdin.

It is also a tiny bit odd that what is probably the most common usage
and the one a reader is probably looking for is not at the top of the
list. Of course, it is only a two-item list, so it is not _that_ hard to
find... The next commit will add the original usage to the usage string
in builtin/shortlog.c, and it feels more natural to do so below the
most common usage. To avoid being inconsistent, reorder these two
usages here first.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-shortlog.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index ee6c5476c1..5e35ea18ac 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -8,8 +8,8 @@ git-shortlog - Summarize 'git log' output
 SYNOPSIS
 --------
 [verse]
-git log --pretty=short | 'git shortlog' [<options>]
 'git shortlog' [<options>] [<revision range>] [[\--] <path>...]
+git log --pretty=short | 'git shortlog' [<options>]
 
 DESCRIPTION
 -----------
-- 
2.16.2.246.ga4ee44448f

