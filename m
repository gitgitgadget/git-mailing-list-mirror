Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F431F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeJWEne (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 00:43:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40623 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJWEne (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 00:43:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id r1-v6so39231370edd.7
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h8Rnf92giVsilwCazR1h6BjeSuQ5sDGeK8YqIJ9U7cg=;
        b=J2FxuqF1pNLnY8yY7uN7WXh6EAXn6OEC43paV6dlkuT39nXYbsaZmx4LnOUFHWKGyj
         SBsWCxjT3WmDeiuONzCXNmqqp30JjUPCZ8nVLZ8Tm0ga6LEqaYbh2TBPxc3F2rNxhd2b
         804nRSjOYk2m/7s6pmMBVUTudJp/IZGeEjNkqgWGTs0me8Z7PTOfP866tfnAQEBQHKMD
         ba6y30MY5YShRKTKR/mUzrZAVcLzzSN4r3N5I6uMdc7YWgr8k3LoRRiUZ2eBtie15/93
         U7Jio4CGaYNbVzwZRJzO7zxE9y7LfgMWDMYGL8KiEfJsx4E2ZZrmQPHtZSETHvTxI6TB
         OQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8Rnf92giVsilwCazR1h6BjeSuQ5sDGeK8YqIJ9U7cg=;
        b=GsvBd3hD8pFAKqYvrAt6FfXzsSowTcmD2IUa5ikH5i6IBZgY1WqpPfwDlbo3N9kypg
         WdGHrbK0B0Ekq/9m5ZwtrRvqkT2m4BbqoIqpOk9vqTjOsHyGEGE+3nQcBSTjVUfkZTip
         1BeFckJG5IElINPhkXI1EBYDARzP6bQp5hvI1n7ARXzYCQd9KCiR+o1wQ835GsCZc7zb
         GAnZBx4dnCMFs8qu4UBbXuP6x/Ow8r7PCCRBMdY9vyYLHduj2EcrteBcAT8d71hsSwKK
         DRy96qHwBM5PrtNXQPn7ZJpYOBgiglY7FLOqu2RZZlB7NDl9018ZUa1kiFLo8q3YA6W8
         na9A==
X-Gm-Message-State: ABuFfogiNq18HLsHiAzZsqoVF01xeSkajv1H2/NJjIo5jHIVz0FE5UOA
        mp9iz7pZNj2QpwC7zyxC81J3sZJj
X-Google-Smtp-Source: ACcGV60sB6HnBXZ5WnlGOTbIRnFznDHunkSZ8HzD/2gzVC5SN8R5JGBN2i+rEyfwBQAuo+TrXxKVZw==
X-Received: by 2002:aa7:d58a:: with SMTP id r10-v6mr14908252edq.161.1540239812841;
        Mon, 22 Oct 2018 13:23:32 -0700 (PDT)
Received: from localhost.localdomain (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id h21-v6sm16882228eda.23.2018.10.22.13.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 13:23:32 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/8] gettext: #ifdef away GETTEXT POISON-related code from _() and Q_()
Date:   Mon, 22 Oct 2018 22:22:37 +0200
Message-Id: <20181022202241.18629-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.681.g6bd79da3f5
In-Reply-To: <20181022202241.18629-1-szeder.dev@gmail.com>
References: <20181022153633.31757-1-pclouds@gmail.com>
 <20181022202241.18629-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The gettext wrapper functions _() and Q_() contain a GETTEXT
POISON-related conditional construct even in non-GETTEXT POISON
builds, though both of those conditions are #define-d to be false
already at compile time.  Both constructs will grow in a later patch,
using a GETTEXT POISON-specific enum type and calling another GETTEXT
POISON-specific function.

Prepare for those future changes and hide the GETTEXT POISON-related
parts of those functions behind an #ifdef.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 gettext.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/gettext.h b/gettext.h
index 7eee64a34f..c658942f7d 100644
--- a/gettext.h
+++ b/gettext.h
@@ -43,22 +43,26 @@ static inline int gettext_width(const char *s)
 
 #ifdef GETTEXT_POISON
 extern int use_gettext_poison(void);
-#else
-#define use_gettext_poison() 0
 #endif
 
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
 	if (!*msgid)
 		return "";
-	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
+#ifdef GETTEXT_POISON
+	if (use_gettext_poison())
+		return "# GETTEXT POISON #";
+#endif
+	return gettext(msgid);
 }
 
 static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
 const char *Q_(const char *msgid, const char *plu, unsigned long n)
 {
+#ifdef GETTEXT_POISON
 	if (use_gettext_poison())
 		return "# GETTEXT POISON #";
+#endif
 	return ngettext(msgid, plu, n);
 }
 
-- 
2.19.1.681.g6bd79da3f5

