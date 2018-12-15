Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B1D1F405
	for <e@80x24.org>; Sat, 15 Dec 2018 11:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbeLOL2G (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 06:28:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36517 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbeLOL2G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 06:28:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so6175561lfg.3
        for <git@vger.kernel.org>; Sat, 15 Dec 2018 03:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qwDLPaHk/a08xuM81ceQobPF7e0Ic+D3A1phOdtbsN0=;
        b=b05cdo14MxLxsWPkba9hBUxT9r2bBSTrtdd10dNMarP7alXX8/GYDMlB6/Jwn6D3hM
         PTjugyXiTUqJBMvTPOJBe2v2z3/4SGPwlk75PtngRpbc/yIeAKbh1I30+iIzFFWfjt65
         Yr7oPWZb3U2Dm+Ddfx3Fm2P+SmPQgxj2J/zzRoWh9ncAMOIC7/lTy75Ex6bcFz2vf5Yd
         KD1Y+0Qo+PD/A+qVK/xJahqWixbQwVf2iMTs+TXc3hr0AvBPBqBLjcVKGORdkySr06ud
         2GIxjX6YmNWTqOXhN+fQ9ra57CgCAEQS1/XfObSNJZch+AO+lzjfSp5eQPrhK+4fQAoV
         cxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwDLPaHk/a08xuM81ceQobPF7e0Ic+D3A1phOdtbsN0=;
        b=RqE0PGYa1Q2WcAv4k+yznN5pv0iL+wxhqyuNs5U8Oq2ADJp44R9/cDoJeulx9fHYHm
         X4rYOsZvQAdln8YtkVsIIyX/GQKYS8ZDKbbqeTXG48HuxFb12d0ZFzXyuJgtJDzaYmS0
         RMjTfl5Gzd0ZeeUUIt9HSFwbCroaG0wQjgzQxVWVju6N46UbWmpJuxSXzQVbkJWA5fi6
         lvPfZMEQ9aaC1G87beBEIA7DyjEpfnpeua85cy4GErbKZYL1jgdnStlsFYfAHf7LBtFA
         Ad0lrDifitpKor0PyXjewgO2RVu0Npku3ivj9gaOVoPZD+te7OQUxyi0Oi2yFwYuzNVo
         0KHQ==
X-Gm-Message-State: AA+aEWYSqHpxulmMR/dwXsvEZbBY4VADx4oElFlkCr7EAJGVz9VGScek
        MHWXXX8ARwa/D+WA/wKUEx6F7ZJD
X-Google-Smtp-Source: AFSGD/UF2bjxBsqrsbJRPnBlldlYF6jhYnTTYu7aockyIrHkB/rRARNl8DveG5Guu9zIC8h3REGurg==
X-Received: by 2002:a19:a84e:: with SMTP id r75mr3919085lfe.45.1544873281938;
        Sat, 15 Dec 2018 03:28:01 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id t18sm1439174lft.93.2018.12.15.03.28.00
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 03:28:01 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/4] git-init.txt: do not nest open blocks
Date:   Sat, 15 Dec 2018 12:27:40 +0100
Message-Id: <20181215112742.1475882-3-martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181215112742.1475882-1-martin.agren@gmail.com>
References: <20181215112742.1475882-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It appears we try to nest open blocks, but that does not work well with
Asciidoctor, which fails to indent the inner block. This causes the
inner block to be set as if it had nothing to do with `--shared`. Drop
the outer one. Asciidoc renders identically before and after this patch,
both man-page and html.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 See https://git-scm.com/docs/git-init#git-init---sharedfalsetrueumaskgroupallworldeverybody0xxx

 Documentation/git-init.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 3c5a67fb96..057076ca38 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -38,8 +38,6 @@ the repository to another place if --separate-git-dir is given).
 OPTIONS
 -------
 
---
-
 -q::
 --quiet::
 
@@ -111,8 +109,6 @@ into it.
 If you provide a 'directory', the command is run inside it. If this directory
 does not exist, it will be created.
 
---
-
 TEMPLATE DIRECTORY
 ------------------
 
-- 
2.20.1

