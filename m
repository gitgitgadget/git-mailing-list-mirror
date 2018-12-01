Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D76F5211B3
	for <e@80x24.org>; Sat,  1 Dec 2018 17:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeLBEtv (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 23:49:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46374 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeLBEtv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 23:49:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so4348419ply.13
        for <git@vger.kernel.org>; Sat, 01 Dec 2018 09:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sItHiviwOirJ7T9cY0vk0+xUgL+0sSfIZH+2od6A2p0=;
        b=L0PHTPDnfZXtWzyI56p9c9Cu1nFlBzFEgWGOuqEp9ACjQMe9ffLBvkTLbEU3IiLZV8
         7l9fcwrvsGgpUafYY9Ye4y7904Gg5p0k4yW7dFe4ZgpeuB6hzNMmMDlDa9nhl3tlo48O
         9SKF3UCxd2jV5gTQDVOmoLMiZzha456FXcRBq0N0WIkm12brZXoDlEbb7z3MdrQ+PYFf
         VdCTI3pyzDEdQCeOXll6O/LKUpNpRDnJkVPhBo7xIOOG/JkIxJqE63yEJHiV62nm4Wwr
         Fe1qCkoGPAcPpa6PIvitEQv7ugL1+2wnoY9mSxvnN3+25k9+fKrQQru4JLYLRghRqWVr
         oC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sItHiviwOirJ7T9cY0vk0+xUgL+0sSfIZH+2od6A2p0=;
        b=gQ5Bgjo9WnuFc5Kz6NxyJ1FOu077ZT2B/Th1b3l7vkYpv8JT8+SJtZftQYaNxNlMos
         h6T9JCLBvkzanCbMXlV07pJUWFDCrEYBiQOsVi3w823W3aVjONXzt+qAQpgmQAxhPpDK
         /jQ/UqGRQW4yIWj2o6gVF8QEiml2NLrklaHe9MaSuyihTkfrMk2udTdlNNApP0oiFZxu
         odivx5y1jiYrBb2tspcap0a6S4nZ1iBT3c7VlgnbX1Q5SfckWPztcSU6O95Yh4qRQ+Fu
         YmSWa54YpG2hULDWo95lDMV5lgBnDw+QeEdLvZirdYc1TvGMJgWZGHbmrMWBBSg/Grn5
         OCng==
X-Gm-Message-State: AA+aEWbtQHbr7pLHUuBS1bvBK3e5Jsd6iUiCELFb399mmVJUHUU/Ss79
        ipZGHFfOyhi1KfBQnT0e/ZuGoNiS
X-Google-Smtp-Source: AFSGD/XgCtnWnwpR//GPxhepS+f1eKFBo8v4tzw/TLgM6MKihMg4PVPxjrF2g4a8hl5zh7vTvOkm7w==
X-Received: by 2002:a17:902:b78b:: with SMTP id e11mr10058014pls.90.1543685809226;
        Sat, 01 Dec 2018 09:36:49 -0800 (PST)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 202sm15827134pfy.87.2018.12.01.09.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Dec 2018 09:36:48 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
Subject: Re: [PATCH] t6036: avoid "cp -a"
Date:   Sat,  1 Dec 2018 09:36:45 -0800
Message-Id: <20181201173645.63430-1-carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2
In-Reply-To: <xmqqk1ktjvyr.fsf@gitster-ct.c.googlers.com>
References: <xmqqk1ktjvyr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks both. Agree with Junio it would be better if squashed; apologize
for not catching it earlier, but the following might help to make it
visible for anyone that care to run the linter:

  $ make test-lint-shell-syntax

Carlo
-- >8 --
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH] tests: add lint for non portable cp -a

cp -a, while a common flag isn't in POSIX and will therefore fail
on systems that don't have GNUish tools (like OpenBSD, AIX or Solaris)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/check-non-portable-shell.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index b45bdac688..8037eef777 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -35,6 +35,7 @@ sub err {
 		chomp;
 	}
 
+	/\bcp\s+-a/ and err 'cp -a is not portable';
 	/\bsed\s+-i/ and err 'sed -i is not portable';
 	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
-- 
2.20.0.rc2

