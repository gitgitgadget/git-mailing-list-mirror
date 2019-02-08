Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFCB41F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfBHJEa (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:04:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39333 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHJEa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:04:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so1308669pgp.6
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBk5a69TGV6LtsCwXdBSZ6V23iSvTPo6GaA6IpkcwYk=;
        b=a6XKE0PaueJ789P2kKQH788U3hP/gCow+dkvVqFtGudumNJ4XGHm0npX5gQlGcaaNl
         5sBfdibs/fCTpWMHCcMIBWTe0HHsuQ9Oyr8EpD1UQ8EDAqRp/uQohMV186nFhNOyzs6X
         qyxE0yxzPt52JUWu+AFMlui+SNG/QL0+GxQ6RJm7JCF9lvs7TIfjHTXm7ouz0t4O5YnG
         v/jJpQ17r9n4YDvwu4CgANnJXESJ6wnCpjCdyUgOX6c5p2jY9qLQblkdVHOfsUNqCzOc
         8oW7Sfmy/kqzwSpmzzwSPoIfGowtep6YT5W6Je9FW4/FFlyylP2BqzaY9bEkBG9xP7+P
         bkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBk5a69TGV6LtsCwXdBSZ6V23iSvTPo6GaA6IpkcwYk=;
        b=CWIaLYhpDu0l0t4HcgsiefSKcMkmysE5Jo+ZZFqnv9GzW03X7ulimlMO3VQtiHkRs9
         bBdIMESywy75uXlpn80YE4Jmcw0r2HfFEq6kI8tnBR8z9wqRYsiUBCMs+IhAvgJhb0Qb
         6cXDs03ERneFAjI4AeTJ5hLMpnEnUZKzP2RxPmty+WiBm/IfjsZKRYv/fDr7lXl/gIgR
         kU8E98Nbd9qkk2p9it1WSOru8Mo4+RQiSVCqYGpRKmqwin62rYsjIdx85VY7ju2j5Iq+
         wH4Kr32nDIlfi+qTbj5OzWIcgVffo2VMCS8M8+6Kt/iaL3ILDRetJn6iCsC4Z6p8AGNT
         tFsA==
X-Gm-Message-State: AHQUAubTPK8vYZTKnYoTzf47b9+FPXdwLiqe0Ee49EVC5S2srOUr8MSO
        w6YW4cPjsjyQQMZAsOUxBoI=
X-Google-Smtp-Source: AHgI3IaVSiSdzEEAdR5Xyhax3pA3scCr0n8mNjiEK2F6NMZX8Zaie3sBKX2PsJ6inTgCYfv5qwL2cg==
X-Received: by 2002:a63:d301:: with SMTP id b1mr19381498pgg.61.1549616669579;
        Fri, 08 Feb 2019 01:04:29 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id z62sm3003854pfi.4.2019.02.08.01.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:04:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:04:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/19] git-checkout.txt: fix one syntax line
Date:   Fri,  8 Feb 2019 16:03:43 +0700
Message-Id: <20190208090401.14793-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<branch> can be omitted in this syntax, and it's actually documented a
few paragraphs down:

  You could omit <branch>, in which case the command degenerates to
  "check out the current branch", which is a glorified no-op with
  rather expensive side-effects to show only the tracking information,
  if exists, for the current branch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ce7d38b8b7..bc7fbdb8d2 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -23,7 +23,7 @@ or the specified tree.  If no paths are given, 'git checkout' will
 also update `HEAD` to set the specified branch as the current
 branch.
 
-'git checkout' <branch>::
+'git checkout' [<branch>]::
 	To prepare for working on <branch>, switch to it by updating
 	the index and the files in the working tree, and by pointing
 	HEAD at the branch. Local modifications to the files in the
-- 
2.20.1.682.gd5861c6d90

