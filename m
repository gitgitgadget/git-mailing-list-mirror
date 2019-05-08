Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A3B41F45F
	for <e@80x24.org>; Wed,  8 May 2019 19:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfEHTQq (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 15:16:46 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50624 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEHTQp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 15:16:45 -0400
Received: by mail-it1-f196.google.com with SMTP id r17so3451148ita.0
        for <git@vger.kernel.org>; Wed, 08 May 2019 12:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lZRfH7EosBIyJfcJaW3TdgeWV/aOp5Y0akr/5E/4cWU=;
        b=JFEGF3hwSdwBjzgv6wxnAnrFP5Jee3XPmgAIYx0S++YDROwPchZllr73j6ZqqlgUYO
         k9THSbVK7Ka6CjrhyCmMk5xOpSqxl8+KOYE4JYMu3pCsJZI8P4TZpClEnEVJMsy04UQo
         g2iEV/7A6W9usqhWoADLG6Hr53urUlXBoBeyw+wkGCxwNT8uXkHCc05hm9K4rj91WnhA
         JSwKLIwJ6sTNM9uC9aiquAATh+f4p1OfF7/ynuT24rOsEjWaMEW/Gmm/y2AriIBJNT4v
         0hEPuPZQNv0oyuYrEm+GiYvdOk0Nc/+uhkOVo6FKCWl12gWfXYyhNNJFq4NUfeBnPit4
         HFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lZRfH7EosBIyJfcJaW3TdgeWV/aOp5Y0akr/5E/4cWU=;
        b=oZ5kcR1moh67Obb9sm1s6dOUQjuinQ/ZfR27XySZ4pEau1PMSYRfwtpynp6wqq9KPk
         GVc0qOrMq8m0Lr8Zob9UxQf3Ty0AsOef5Qj98tk9398QkFTBGj44j8LDfy+yA+2iGGvf
         0hu770kACEB/bjBmrPCqHOzA3Ohl8XGJgv74tyFX3Cl9Vx2ozAVtvOx5tcGdu9s8PPHL
         N4NhjC4f+nkkJJabcp9ZUEprnizPb3ncSWBGbC5Sbjqyrjy/olqC6CUIWUup3uASHL6+
         HMcD1IzdHYl+6Wn4WchA+6I4ac6UY7FLc6adak6vUXWdRiHqHhKRX4TP1r4ggoh89f3I
         hY0Q==
X-Gm-Message-State: APjAAAUJcTC2xOxmb6YdymbWD+zXqz33gAJ2JnDAHI7uSEynmgwURTiu
        IQ7O/MS+1oCMxnPycoqK08pf0HO4
X-Google-Smtp-Source: APXvYqyV6Xz9gRxD+BMNHc3dAwp25iIPcve7PsSlu4Y/FuZVIICF7a4iizSXgtVtDp+x8bZr9F7Lug==
X-Received: by 2002:a24:7211:: with SMTP id x17mr5007410itc.150.1557343004279;
        Wed, 08 May 2019 12:16:44 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id p78sm1657861itp.35.2019.05.08.12.16.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 12:16:43 -0700 (PDT)
Date:   Wed, 8 May 2019 15:16:41 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] tag: fix typo in nested tagging hint
Message-ID: <4213b04b1f7262bc53c83dffc82956951dfe869f.1557342925.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In eea9c1e78f (tag: advise on nested tags, 2019-04-04), tag was taught
to hint at the user if a nested tag is made. However, this message had a
typo and it said "The object referred to by your new is...", which was
missing a "tag" after "new". Fix this message by adding the "tag".

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Hi Junio, sorry we didn't catch this before it got merged into master.
Just a small typofix.

 builtin/tag.c  | 2 +-
 t/t7004-tag.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 1debd3a11c..ef37dccf86 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -207,7 +207,7 @@ struct create_tag_options {
 };
 
 static const char message_advice_nested_tag[] =
-	N_("You have created a nested tag. The object referred to by your new is\n"
+	N_("You have created a nested tag. The object referred to by your new tag is\n"
 	   "already a tag. If you meant to tag the object that it points to, use:\n"
 	   "\n"
 	   "\tgit tag -f %s %s^{}");
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e285686662..6aeeb279a0 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1702,7 +1702,7 @@ test_expect_success '--points-at finds annotated tags of tags' '
 
 test_expect_success 'recursive tagging should give advice' '
 	sed -e "s/|$//" <<-EOF >expect &&
-	hint: You have created a nested tag. The object referred to by your new is
+	hint: You have created a nested tag. The object referred to by your new tag is
 	hint: already a tag. If you meant to tag the object that it points to, use:
 	hint: |
 	hint: 	git tag -f nested annotated-v4.0^{}
-- 
2.21.0.1049.geb646f7864

