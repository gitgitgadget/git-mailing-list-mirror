Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66A981F4B6
	for <e@80x24.org>; Thu, 16 May 2019 23:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfEPXNt (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 19:13:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52701 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfEPXNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 19:13:49 -0400
Received: by mail-it1-f194.google.com with SMTP id q65so9015520itg.2
        for <git@vger.kernel.org>; Thu, 16 May 2019 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cqBa/A8KQ9SQDHOYHmHjxeXA+N94N3CocdRQbsTHBzs=;
        b=F/xqypw9khFP+pBLoePagpXOocg7eTy6hYdqxLAgyQwckuQu1TJb7jSwEwIXjus4A9
         eOBqBIxk7nIqdK+dDek1rqjBU254d/s31xdC8N9V4kHUVkFw4OA1z38qN1Sbz+CLXETl
         Tlcg75FFtd1ORhHQr4MFpz3ufWSwmI5NR+ZDeX3onxuhklTP21W+KRWMaIyH7asZbbTb
         wvwTFLq1d7a6XONV8/dEAuPib1L2iJbr4KIxvG1viZnq0WDn1M712g6UqobgahSKS8bi
         Z7CAB6y97CKGwimLoGlj7fSEZ2ibtV6TCthbJJRyxpvefofnK4PSTLnRbZEugHZc3IP9
         Kyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cqBa/A8KQ9SQDHOYHmHjxeXA+N94N3CocdRQbsTHBzs=;
        b=JiBzM7sfnyOXL72vZj2rEPcyNH/TIawgpwxNZ1zCVGleFkXh/CIJPQNrvqIOf5o2PO
         yzlSS5C2b7mtHLw6VQwHfaTGrMB9KMM04GHr2g4T0d7KzGUJUmidXHNYtdRqdl5nwJgv
         A6iEgnPE8Dx2dWmZ1url31a9B7UTTcIIbJCGORTKdgSSMM8ty57Pe0wUmc83AaXy/VQ7
         SfUAePkjT4+hrXSBBA/A7v1ks3z1Zu9/kIEaKRu+bKX9+7vVoFX+Cb/LvjH4XePXclLH
         c3g2uVCjGBUYcYJzucQverhzDC39/xueo6DIMsIA1Lja+r3bysQWjDejokZ16H8PVNqO
         QRdQ==
X-Gm-Message-State: APjAAAUSeaGY8v/5KQJeSdrTewIZQryHCn/Xl47W+F5XkRdd8KT0sCPn
        wZS3zpyMjvo2TRhFDPSrVBKAfyY0
X-Google-Smtp-Source: APXvYqy0sgy4KvWojbtx5odmXpROLujCgW8N9KQrXnUihX1CSTa+mef5JNr9/2G/bWw3WoFSZq387w==
X-Received: by 2002:a05:6638:518:: with SMTP id i24mr1681814jar.3.1558048428867;
        Thu, 16 May 2019 16:13:48 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id o7sm2130279ioa.67.2019.05.16.16.13.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 16:13:48 -0700 (PDT)
Date:   Thu, 16 May 2019 19:13:47 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v4 1/2] git-format-patch.txt: document --no-notes option
Message-ID: <4c3535f25bdffc8d94617c74f7c078cce59a044f.1558048212.git.liu.denton@gmail.com>
References: <cover.1558048212.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558048212.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Internally, git-format-patch uses the `handle_revision_opt` parser. The
parser handles the `--no-notes` option to negate an earlier `--notes`
option, but it isn't documented. Document this option so that users are
aware of it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 1af85d404f..2c3971390e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -22,7 +22,8 @@ SYNOPSIS
 		   [--rfc] [--subject-prefix=Subject-Prefix]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
-		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
+		   [--[no-]cover-letter] [--quiet]
+		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
 		   [--range-diff=<previous> [--creation-factor=<percent>]]
 		   [--progress]
@@ -263,6 +264,7 @@ material (this may change in the future).
 	for details.
 
 --notes[=<ref>]::
+--no-notes::
 	Append the notes (see linkgit:git-notes[1]) for the commit
 	after the three-dash line.
 +
-- 
2.21.0.1049.geb646f7864

