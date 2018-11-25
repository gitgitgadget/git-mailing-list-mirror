Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878B41F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 11:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbeKYV55 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 16:57:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41025 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeKYV55 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 16:57:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so4828227pgh.8
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xKxD5019rYTKE2wO+JKIqo0izFL/fqFO8ePawiJlNwE=;
        b=Yxuw0r353/uJTDJmWRjF9gm7GrOcQyV/TVIkT1axdgTMPY9CL0JljpWDpB/claXMJ4
         yXoyFyPaLXbK6fT8giMVF5v9pSOAcZO7552M1m28LgdF6mRyXhKGMJdRJrHvt+yHq+ZC
         twjWCKH/Zst2gGw8EJtLPf/BkXDBWD/yJf9H0gIQe8klrLYug793mT/8XiSY7OlGaYDz
         EhJQvFPcl1TeL/vdnafzmaxtcy4ljZ/PHKsM83ilNjHraPHz0pIObK+nSTl/NPbkRdPg
         NddKVbSSA+8kNzuYs8eZUdYsWLF4fGgizRtI9QMnNmMW7iG8MVUibt/nezxz0DFCCbiM
         caDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xKxD5019rYTKE2wO+JKIqo0izFL/fqFO8ePawiJlNwE=;
        b=hclE7p7tM2YnIUTgRiAeg/rVVuooNpfbn0/WecRCdIuD9p66bJkenuKvBzUU81jeMx
         246HYmzV1nY3uq4jt28yeozXk0z14xi9eFp6l+TSX/+7Ver1OAhaRVeIEauZEa6kBRFm
         GGfFcdSrCHz/aDoG5KJ0QVYZdAsKOfShWuHbIv/FZ5ZPyxO7EcxqRdvfJEbJWaTrRQCS
         fn6+CeO+6BV56T/MWRFRJuEusO+aAz7TnBvY3Wg85aDuA2ekoyrz9NjfQcmAbDiwLido
         DVvHz6TUM4567TA0Xt36aEqvPZ8440At0LUmbOSQP1AYaWr0LztVsO/mcddZYcEdEn/9
         yeqg==
X-Gm-Message-State: AGRZ1gLOJU3eJPR/e7WnG3Peug0pU41jYAk5hqe2C0K4gIoy0SlDtG2N
        ViZGcXTT1PJaf9fHNjx8oUQEt6FY
X-Google-Smtp-Source: AJdET5dftj9PHmPPR4X3nEwy/J9n3X7QgeA7GqET/A0uOAhVzHL37uleMtqYrpBpkzDrhGaFJOMRXA==
X-Received: by 2002:a62:15c3:: with SMTP id 186mr23967516pfv.240.1543144027455;
        Sun, 25 Nov 2018 03:07:07 -0800 (PST)
Received: from localhost.localdomain ([136.179.21.64])
        by smtp.gmail.com with ESMTPSA id h15sm21154301pgl.43.2018.11.25.03.07.06
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Nov 2018 03:07:07 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 3/7] config.mak.uname: NetBSD uses BSD semantics with fread for directories
Date:   Sun, 25 Nov 2018 03:06:46 -0800
Message-Id: <80755d37b29d351b7d5a8fa5d9a22b09ba7e1d0a.1543143503.git.carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <cover.1543143503.git.carenas@gmail.com>
References: <cover.1543143503.git.carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this "fixes" test 23 (proper error on directory "files") from t1308

other BSD (OpenBSD, MirBSD) likely also affected but they will be
fixed in a different series

the optional 'configure' sets this automatically and is probably what
most users from this platform had been doing as a workaround

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 3ee7da0e23..36c973c7e6 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -253,6 +253,7 @@ ifeq ($(uname_S),NetBSD)
 	HAVE_BSD_SYSCTL = YesPlease
 	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
 	PROCFS_EXECUTABLE_PATH = /proc/curproc/exe
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),AIX)
 	DEFAULT_PAGER = more
-- 
2.20.0.rc1

