Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFC271F453
	for <e@80x24.org>; Wed,  6 Feb 2019 10:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfBFK74 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 05:59:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45797 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfBFK7z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 05:59:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id j3so764666pfi.12
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 02:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U7FgL/y2qmXuw5zzWD7t3Y6oBH9U6y8z7ZMPEBV9Tls=;
        b=FnXgXzLYyny65UBqjh7npefpBP700NbG6/X/IDPl9mw30YAGiQTos+qoE3I58daoRL
         bYLB7hpl8/nu3ojZDwgXH2zDqfP5T+liHkp3jeU6yZ7CB2Xpbor6LESSzoJ5jW+sHVQR
         zQZ2our7b8jeDfiEKHByrBQO/k3jbTSKq/0jo16stdovnwsvUEczrc1wp3vAXAskaJlS
         S8MwdzaOwlzlS9gOqziS62Y28Je06zfHYmyBSjECPKDDmnXnNKDqj/RaEpLHXMeK3Uka
         shvc2QEfCYlgJ7K73tpymdvsXHrQeQ6pi4JeoP95XYB8tGz5cVpKBofKhxWUd4nOO3sB
         7/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U7FgL/y2qmXuw5zzWD7t3Y6oBH9U6y8z7ZMPEBV9Tls=;
        b=aGlIQzL/JHo9Wwcv7tSjhJpstwgecaRP4ShyV4W9/4Gg5uuKrqAmtVdoA0mOCspwt+
         cZOhSBEy/s35r41CgVtbZV6H5/4iS+MGUwbuE2+I/bW5d0F7qhWmlTio/5EKd1uNs6dy
         N1BJnWyp3VTaCbWjm5pEQhcN6gWvvrCZHbdmcCNkwLDUtoGEkGamkzCDeX52tpkwRb33
         URjrhZ00eyUFc666ydwGway1M8DglcXOCXTgEveDRl/nIhKRZvGXRYHmcww6RirjIHRj
         V9QiTMBQVSs92OE3L7vwOs2Rvkfscc3xqHMgfqpsTjszIDoSiSRM59ylpNeGrE4uN+Lt
         OxFQ==
X-Gm-Message-State: AHQUAuatvS0mer20jP5hbgKNkWoZab8TgQiwIp5ZbQglr5hiMfgiX0VX
        Xk0xVzTyHrYaDDvwQeKwrT4MR1jr
X-Google-Smtp-Source: AHgI3IarHB59p9AeCZonHfjn1m15ZpPXSQudKUzGNFCdBgUbdb6t2y7+fQU64BRqD3Ll8I708FnUdw==
X-Received: by 2002:a63:920a:: with SMTP id o10mr8826391pgd.141.1549450794516;
        Wed, 06 Feb 2019 02:59:54 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id y9sm8345770pfi.74.2019.02.06.02.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 02:59:53 -0800 (PST)
Date:   Wed, 6 Feb 2019 02:59:52 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 1/3] git-submodule.txt: document default behavior without
 --branch
Message-ID: <cf6e0d16ac0c0d521da98f5d9a53532b923a621c.1549450636.git.liu.denton@gmail.com>
References: <cover.1549450636.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549450636.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This behavior is mentioned in gitmodules.txt but not in
git-submodule.txt so we copy the information over so that it is not
missed.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-submodule.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ba3c4df550..9951c68744 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -261,7 +261,8 @@ OPTIONS
 	The name of the branch is recorded as `submodule.<name>.branch` in
 	`.gitmodules` for `update --remote`.  A special value of `.` is used to
 	indicate that the name of the branch in the submodule should be the
-	same name as the current branch in the current repository.
+	same name as the current branch in the current repository.  If the
+	option is not specified, it defaults to 'master'.
 
 -f::
 --force::
-- 
2.20.1.522.g5f42c252e9

