Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F19F31F42D
	for <e@80x24.org>; Wed, 30 May 2018 20:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932409AbeE3UwY (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 16:52:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34456 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932278AbeE3UwX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 16:52:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id q4-v6so370879wmq.1
        for <git@vger.kernel.org>; Wed, 30 May 2018 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KDrSyL+1VT8v5/b0x1t7hV1kOYRqLA20cXnJF0J3DeY=;
        b=l7gdboekXbZ2tCi9UhU2IcteXbvHpO4vXxrheC3K/2M4gwmCpdApTdo3lSLCl46eRA
         ebluPCwzPps0Oonx8YSaCXsTldMj0fC3dw/mvr8JnXhUv298fYBHtSgPhJ47KGNbvnkL
         EpYq+cPs2gZPtk8A3wu9PWHaMcCGs13ApkbM0qmBDCDaj3wiAATG4WsXSa1MINzHUlTc
         PgS2gXaOIy+R/CQOcS4U3QYFP1FMEbpmUUIhzd869TdZ0lGlxAKGEeEeVwrpgtGQK7Wh
         I4z2amj056uwwv5kbGMYELWwi04MGZkhxe7+XyL8lwsCxTYDrVwT0SJfI6bkDjfGJ8OC
         noOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KDrSyL+1VT8v5/b0x1t7hV1kOYRqLA20cXnJF0J3DeY=;
        b=HJMe+pTWIr3ShzZY5QaTNeL3ihYcHLckUS+2QA6xtt7sxoPOfFj+4/H2wW+G3fSK9y
         ll3nOA3C6pUSulccyPdmW0Hzk844/e0j+WGyTL9ew3YEhXuykGCxKZMEi3cDBg0T6TJK
         RlwuOmOzj8EqndbVJnA5vOakGlrslNXvnfpas+eDSlvrvdVVMNiG1d9C2ApGOY0Uh3BP
         cwR4Zx6D+q0MSWKBks0EJj9v9dY6gymj3Dupw7PZj4RPUzCr5YBkaYw5cY6eHO2lVMOP
         L9plbokXbcV/bcSm1Bz2DhpTS2hIDvcMnu/8VraKf2K4aJenmGoLXz4fGRlbZbN0p1Qk
         XqWg==
X-Gm-Message-State: ALKqPwdwQ1TJpApXrpJtlISLS/DOxoWi8Q4aPBJMg6p0YFyLN07b1Q0i
        JrwqIDgLzQ0NvFVBycB44wNqoLFO
X-Google-Smtp-Source: ADUXVKKmkQPeZgPkYSlo3VYsiX/jZiipAZibmK/+79jo2aFTtnSZIqdLqDChSOSCouFPJ+DlNUDa4A==
X-Received: by 2002:a1c:7507:: with SMTP id o7-v6mr2466457wmc.139.1527713542074;
        Wed, 30 May 2018 13:52:22 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id y42-v6sm65399255wry.21.2018.05.30.13.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 13:52:20 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/2] SubmittingPatches: replace numbered attributes with names
Date:   Wed, 30 May 2018 21:52:54 +0100
Message-Id: <20180530205255.13090-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.1181.g093e983b0
In-Reply-To: <20180527140433.32277-1-t.gummerer@gmail.com>
References: <20180527140433.32277-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use names instead of numbers for the AsciiDoc attributes that are used
for the footnotes.  We will add more footnotes in subsequent commits,
and attributes should ideally all be unique.  Having named attributes
will help ensure uniqueness, and we won't have to re-number the
attributes if we add a footnote earlier in the document.

In addition it also clarifies that the attribute name/number is not
related to the number the footnote will get in the output.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Thanks Junio, Jonathan and brian for the comments on the previous
round at <20180527140433.32277-1-t.gummerer@gmail.com>.  This round
squashes the two patches I sent previously adding the mentions of the
security mailing list into one, and adds this preparatory patch.

The security mailing list is now mentioned twice in SubmittingPatches,
to make sure people don't miss it, and the wording was adjusted to
match the document better.

 Documentation/SubmittingPatches | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 945f8edb46..27553128f5 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -264,12 +264,12 @@ people who are involved in the area you are touching (the `git
 contacts` command in `contrib/contacts/` can help to
 identify them), to solicit comments and reviews.
 
-:1: footnote:[The current maintainer: gitster@pobox.com]
-:2: footnote:[The mailing list: git@vger.kernel.org]
+:current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
+:git-ml: footnote:[The mailing list: git@vger.kernel.org]
 
 After the list reached a consensus that it is a good idea to apply the
-patch, re-send it with "To:" set to the maintainer{1} and "cc:" the
-list{2} for inclusion.
+patch, re-send it with "To:" set to the maintainer{current-maintainer} and "cc:" the
+list{git-ml} for inclusion.
 
 Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 `Tested-by:` lines as necessary to credit people who helped your
-- 
2.17.0.1181.g093e983b0

