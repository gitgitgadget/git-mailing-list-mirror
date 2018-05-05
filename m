Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5406B1F42E
	for <e@80x24.org>; Sat,  5 May 2018 06:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeEEGv4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 02:51:56 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46936 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeEEGvy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 02:51:54 -0400
Received: by mail-lf0-f67.google.com with SMTP id v85-v6so33820159lfa.13
        for <git@vger.kernel.org>; Fri, 04 May 2018 23:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y+Kli1AuXfmH7vxyQaOICpKcUAH84g+bKbDHaTUyEhc=;
        b=bmGvWPdC2Y97JGTO6g62Quzo7CKNsmIb1aRXJuN904uBbAmPVkBbMqMzBJ7L4pAuK8
         uj7mOLKnFQSLi5wUF1CQDHTtI72sqSde18YChoThNgIwBsafV6f5EhH2IbpMoO5niU/Z
         PpO2JVKRK4h5OGpPIrNmHoyp8sijw9F3Ll28JtDdRdggYyb/4bdbTPRmWXjjJHXmy++B
         p7Ibo1168C5PV2kEaDZXKk9bjInRsbgC/7uooRHHxROcpXLGH4jH2gDeQrA13QJeMNjW
         qhghP6Er31iWPsFAml0En24w68TfxNM+4F/JHOgUUbtxm1ZXsSC0HvMKogA9YvGF0FvD
         l5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y+Kli1AuXfmH7vxyQaOICpKcUAH84g+bKbDHaTUyEhc=;
        b=lsO+cVmhpMMVnbMZia4pT2Z8+EeXnfivdG40EYD9wUuDTPj+1iKOgbvy8BESu0rDui
         kyHnO/i5gS1yLonnJSwHikgNKj0iQM4aiCCBg4rQq7Emj6vbZwT4fBJA4efuQhzjxbDX
         qjJ3puSMdC8lIoTipFiXA3aeMAOl78DHtZfVWop2lf8CK69mqGHkDZotC4MPjQkd+/GY
         9phY10dsjKlOMSURbPTZmdPGpxOKz0vn4i2FhJO0UOw6X5dMN29ndMYqBIB5ut4VH38e
         mOXsujH7J1iIGHXuLBEeUXkWK5lEx0UpIVDcq6KdpEb/Oy/xCnyCYsHNtCXthC/257wW
         dsXQ==
X-Gm-Message-State: ALQs6tBZbyHrmsBJkaXosGA32HqM+XSlnJ47JILXiRoHbE6MJwwqP5Mx
        6Q8fcnbE/qwdgC0s9hYYVZyLYA==
X-Google-Smtp-Source: AB8JxZp2NU+tBdwzcPFDvDYWQ5UzIF5awYvvkqltm0yO1Zntktb3XnHXF5tmOE2PjuJF8MS3jmaNWw==
X-Received: by 2002:a2e:9689:: with SMTP id q9-v6mr19891375lji.35.1525503110899;
        Fri, 04 May 2018 23:51:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c89-v6sm3643564lfb.57.2018.05.04.23.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 23:51:50 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] completion: fix misspelled config key aliasesfiletype
Date:   Sat,  5 May 2018 08:51:44 +0200
Message-Id: <20180505065144.4954-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The correct name in git-send-email.perl is aliasfiletype [1]. There are
actually two instances of this misspelling. The other was found and
fixed in 6068ac8848 (completion: add missing configuration variables -
2010-12-20)

[1] 994d6c66d3 (send-email: address expansion for common mailers - 2006-05-14)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 01dd9ff07a..bc8ce24a89 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2172,7 +2172,7 @@ _git_config ()
 		__gitcomp "$__git_log_date_formats"
 		return
 		;;
-	sendemail.aliasesfiletype)
+	sendemail.aliasfiletype)
 		__gitcomp "mutt mailrc pine elm gnus"
 		return
 		;;
-- 
2.17.0.705.g3525833791

