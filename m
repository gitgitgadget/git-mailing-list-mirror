Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29001F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeJ0PFC (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44847 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbeJ0PFC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id v6-v6so3085400ljc.11
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=faUd2EKebhR4/6zeqqvyukphGj7aLt9iTUmZn3rDvPQ=;
        b=JO7mh6NnTHEd0LGHunHQcQpLDqVbGEcTVLgmGyuTP+gRdd8PJLBIxN0yu8/tiJOhxX
         2lB5cQPRaJ4qJHyJHejQau1CzZ6fDgectB8hjzTlsyNRkEZiL+EgbQvk/ZKsJgE3QFYz
         XVBPtEcBf4IeZxXgB22VFpchKjW+0UkFR+Dx5PZOauEqLEkkmySwA8EMyL7vXH22oiHE
         RN/ekmAlyrwcl2eBbSjUwjdgF4OrLDUJaDGd+LMWrLpjUJrvPCszpefWqRl+lQg9qG7Q
         UzEhBAR1/7PnHoOy2QUlmGJ6KoTqNoftSdspFUGUOlvIFWsXCoLDDZG17fvv2qI1Wj2e
         vYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=faUd2EKebhR4/6zeqqvyukphGj7aLt9iTUmZn3rDvPQ=;
        b=cMX/Ekoyi3MU6DZ51HXx11+Lr08ML1Wx1KvzlL3XyywxmxMI6eVku9JOFgXf4nq+EI
         cxzV7/iClFkwq7jO7uPuyvCpFlI2YyTR/8z4fAxvF3kaygVySEyh+/UXMrIWvsIhvvdt
         haewpJfMQw/cQsg9iOBknqcAqjhC/Kt71fBTkeblV/Ebi1xDudNY7f9Wt8gArxBd759x
         dBX0MakD7+rAvi5228clOHqW1CDulJoBUmtNhIEvBADfwD3xr1mBgp8IJqeH5Ip31KDk
         QB27tWBMuCSGVNears+SNqvSiZWcCN8IqdLIb7XAjdh2v8WnE02V79oIVyxMf28cgvuT
         sShw==
X-Gm-Message-State: AGRZ1gLBcV++YcEMydqJt/dgziCmxKLkqTpxlURhS7yldyR39j9ATN0H
        ztw0yEhYYz6hM6718C/Pz+gXBCCm
X-Google-Smtp-Source: AJdET5eyh5ONm8/frOLCJxGO5pjp1COiXCyDhWlFjOqdEaojza/cJS6XELDYH/tX+rRais06tnrQ8Q==
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr4642614ljj.6.1540621506473;
        Fri, 26 Oct 2018 23:25:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 61/78] config.txt: move reset.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:34 +0200
Message-Id: <20181027062351.30446-62-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt       | 3 +--
 Documentation/config/reset.txt | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/config/reset.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 71bab1f3b8..a6ce22a6d9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -401,8 +401,7 @@ include::config/repack.txt[]
 
 include::config/rerere.txt[]
 
-reset.quiet::
-	When set to true, 'git reset' will default to the '--quiet' option.
+include::config/reset.txt[]
 
 include::sendemail-config.txt[]
 
diff --git a/Documentation/config/reset.txt b/Documentation/config/reset.txt
new file mode 100644
index 0000000000..63b7c45aac
--- /dev/null
+++ b/Documentation/config/reset.txt
@@ -0,0 +1,2 @@
+reset.quiet::
+	When set to true, 'git reset' will default to the '--quiet' option.
-- 
2.19.1.647.g708186aaf9

