Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C34420248
	for <e@80x24.org>; Wed, 13 Mar 2019 12:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfCMMY5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 08:24:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33548 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfCMMY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 08:24:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id c13so4334702wmb.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 05:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TcEjlYKPOZTOVATiI17XRSdKYXhU5r0SoVx/FV5ZTg0=;
        b=NSkXCQZnZNaqP/yNgipJKCf87bSXpCALBWcnMzNZG/aHd7mEj4xbA9S8jlU6i7S+ch
         YHzKnp25LpzqEa+Y0YF8iUDysLmf0w+aHxzSOzkAMXCGwJoh2KAg9yqBYu9wKWTMjX02
         FXb874kKOT1FI+3AGxYoWmoxczoq69djl7bTBs2rdasx4siWNR1RU4py0IMzkYmHLHFC
         LxDUNpdBmjmvC0pPnbAXg39RCQv+Fc7cZjXj7jZGaICCR+cc8ZdxfQ+0Z7Xid2L2X8lk
         iW1Wq1PA6GAQW0iYm/TEB0qQM0CJaFxm5c3TaWYoOlT7DUaTQsSaI8VpMDnyhjPzNEEL
         AEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TcEjlYKPOZTOVATiI17XRSdKYXhU5r0SoVx/FV5ZTg0=;
        b=b74DwWODSI5z32ymTiqHpBiVmZFIEqlMZQjatjqFX4/aryL9LdS1M5M7rfx1X8Tazf
         YaomlgRFjfgm6Cm59JlvxQoWPkZG+t1lXKXrTbGRYolouA6IMVlW5Sf3WU4uePIovqvj
         pceZs/UxYhdRgJAR0OKGJKTGuS7owCUQN69VRpjjWMTjtrNCxH61RqUr76XebyBaUQO1
         yYbYsMzf/2uq1jhv6Jy3/tQfmitngV6beyydaCFovd+wERcrwdJBs0s5rYcJ5KawqjyE
         15ueiHj+6gh1nSv2aVZ9qIB0YUg72GtCV+7IZNnlZda2r6SWsiSqV8057wBPGP6/xy/s
         Gv6Q==
X-Gm-Message-State: APjAAAUn+mnhswzRPKg7UfeMr0U1fZLPM7LkCWrQ1dpzQeskenpXOVxh
        XGc7kBFHPwozWeUSGboUshwhdSxk
X-Google-Smtp-Source: APXvYqyZCZHLkjPxnCIIgQjJySbI5eJqEZ1aeVxrPfpRFlA01DztIBnKQUjTn+Nu6uhOq1Wp1Qn9cw==
X-Received: by 2002:a1c:cb82:: with SMTP id b124mr2001800wmg.11.1552479894034;
        Wed, 13 Mar 2019 05:24:54 -0700 (PDT)
Received: from localhost.localdomain (x4d0c2b66.dyn.telefonica.de. [77.12.43.102])
        by smtp.gmail.com with ESMTPSA id t2sm8348287wra.9.2019.03.13.05.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 05:24:53 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 11/11] t9811-git-p4-label-import: fix pipeline negation
Date:   Wed, 13 Mar 2019 13:24:19 +0100
Message-Id: <20190313122419.2210-12-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.499.g4d310c7a8e.dirty
In-Reply-To: <20190313122419.2210-1-szeder.dev@gmail.com>
References: <20190313122419.2210-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 't9811-git-p4-label-import.sh' the test 'tag that cannot be
exported' runs

  !(p4 labels | grep GIT_TAG_ON_A_BRANCH)

to check that the given string is not printed by 'p4 labels'.  This is
problematic, because according to POSIX [1]:

  "If the pipeline begins with the reserved word ! and command1 is a
  subshell command, the application shall ensure that the ( operator
  at the beginning of command1 is separated from the ! by one or more
  <blank> characters. The behavior of the reserved word ! immediately
  followed by the ( operator is unspecified."

While most common shells still interpret this '!' as "negate the exit
code of the last command in the pipeline", 'mksh/lksh' don't and
interpret it as a negative file name pattern instead.  As a result
they attempt to run a command made up of the pathnames in the current
directory (it contains a single directory called 'main'), which, of
course, fails the test.

We could fix it simply by adding a space between the '!' and '(', but
instead let's fix it by removing the unnecessary subshell.

[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_02

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9811-git-p4-label-import.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index b70e81c3cd..c1446f26ab 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -191,7 +191,7 @@ test_expect_success 'tag that cannot be exported' '
 	(
 		cd "$cli" &&
 		p4 sync ... &&
-		!(p4 labels | grep GIT_TAG_ON_A_BRANCH)
+		! p4 labels | grep GIT_TAG_ON_A_BRANCH
 	)
 '
 
-- 
2.21.0.499.g4d310c7a8e.dirty

