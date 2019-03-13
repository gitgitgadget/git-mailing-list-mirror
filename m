Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BF3E20248
	for <e@80x24.org>; Wed, 13 Mar 2019 18:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfCMS2N (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 14:28:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33951 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfCMS2K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 14:28:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so2587016wre.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=fKSUqyiBnzlMG3aHujxqg9/REET+rJvTr2ehKz41x2s=;
        b=a4Jq6Wta90YYk14fia23eqGmUPuUArUIVakMFJa8izReR5yAoJuEZGuGzUWhY1b53Y
         r2cqtzVjreJ+LkUbhiCUWMl1PNKqfQa0iaoMXoJmcoiiO6tLDIZsR7nDNKHw912MW/N/
         jAChUFREtBvpHDHrOi+U2Kb9XQMnlktPkN3CkJh3DD0mTOZjNMBUxKoIQUsYV/opq/KW
         +SLjRXUimNvO8PA1rTUxwXxXkDe8IW9o5lqmLQGINZsd1A5enzDnNXWxEMkcEQ+Ps3O4
         sdXVntj8hKIBoGww2KvPphPE3+WerP+wx95mGdLcrmFXZNz/GSrcSu5HqlBjpZhKnfXn
         h1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=fKSUqyiBnzlMG3aHujxqg9/REET+rJvTr2ehKz41x2s=;
        b=rJYo5HNnYEY9H/mJzoL38+xi+rPJXghUioyKzorGx1J5eT82G6yw4qR/HCrNlsvKsu
         2JXoEDARn0HOxh2gXx+aaBjla+TI9A4YZLq0HILH4C5tOkPFC8JdDqgj2CJdxohIgR+K
         GsznDmV8KUwJ3eL9xtuJVVxPKC4fM8Ua/yaQup1lvMmls1DNC3m2ANhnJ7JxJduSOFZm
         2hNdJhMESH0arluXXUYn6AhSjX81P+1O6mzaJdYKSF8Rk+83u8EzwiNv4gSDSwzSfZYN
         NH7kCoOqfLRJVr/efd6XtMvx8BSRntgfRcTMCsEaKgkFKoB0zLFgu42+/QRzd4sBmBgQ
         Wdbw==
X-Gm-Message-State: APjAAAUX8giEhAK6wc6jO8bZKT9dOAb3TanTWenybaMyZAolwnnDWZax
        jWhU02VyncAkTxIxTy6o04QpyeTIWIfzJQ==
X-Google-Smtp-Source: APXvYqys5WprD9NJ53VZk6zPpUjbBExxowc7zZ/rmzsscFj4b0BVRg9QdIvKYl1gzj9YGc2gYbcR5Q==
X-Received: by 2002:a5d:6948:: with SMTP id r8mr5777076wrw.255.1552501687763;
        Wed, 13 Mar 2019 11:28:07 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.gmail.com with ESMTPSA id b3sm2793929wmj.15.2019.03.13.11.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:28:07 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 4/4] merge: tweak --rerere-autoupdate documentation
Date:   Wed, 13 Mar 2019 18:27:56 +0000
Message-Id: <20190313182756.8076-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313182756.8076-1-phillip.wood123@gmail.com>
References: <20190313182756.8076-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Spell out --no-rerere-autoupdate explictly to make searching
easier. This matches the other --no options in the man page.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-merge.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4cc86469f3..6294dbc09d 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -83,7 +83,8 @@ invocations. The automated message can include the branch description.
 If `--log` is specified, a shortlog of the commits being merged
 will be appended to the specified message.
 
---[no-]rerere-autoupdate::
+--rerere-autoupdate::
+--no-rerere-autoupdate::
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
-- 
2.21.0

