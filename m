Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9D11F453
	for <e@80x24.org>; Sat,  2 Feb 2019 01:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfBBBWV (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 20:22:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37990 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfBBBWV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 20:22:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so3746230pgc.5
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 17:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4V5EPBXVXAMsupwVjOO3l7uDc7LwS5NC4WA5WBQtuUY=;
        b=V4CUPEhyPYHjUdPhVR8uSjKmFJPTBZbrUj26ErqAocSv8q+3YvLfuPVSfJ7FeSffWS
         3RXIkqHScQ+zz7183Nf6aAbPCMNUW0yKCNJBbmyltYHmBXkgXIImMLzzogMgSnfPozI2
         FJGuAqcX9BZ9ixvO8U5Tlcan5Vsz4Sl9NEXJwgIq6n+IHfJFydueXvoNWqcqfYXev+19
         5urhb8jWfYQdz2G0tHTGb9FSqdpYnQEjYNCBbzKmRwxR3C3jA+jGbTUFDgMLQCgPgb/1
         OSwIoVE3PdZoFS31IAnkfwkMo23WKG+JDuoo3cKAQknNmZ0wFzK2IVE3T4UVqACcPAln
         Xa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4V5EPBXVXAMsupwVjOO3l7uDc7LwS5NC4WA5WBQtuUY=;
        b=jaup4TBuoosXDVvhqYCP7gN59fCumtvTcAy63jNgjbO83j78arppTiPpkmoQy3ydRn
         cX4XdCDNOvbeMYV6Cgo9eAGmfU7Y6nhPduoNIe1b/p4gMa5e0EoBLSxu6FaHGrt4VyGN
         1xBVX1NlpFkMU/eRvoG+nCV3MluV0Zl1jJZwIWP+vVurE62vELoUKvN3OtsEiB5+E3fg
         LSdvsNhC1NC41cYI9jV9ieDJ2TF/NYHQg5Pp2LekqAJj19WcrGfXRUox88LudBpic2xh
         6e1Trl9pdkKbwB5UzIFSjzRvREq/62VCPRkhmgxzrJpc3CrxoiTUAtX8L2Rb4goBxtp7
         7o8g==
X-Gm-Message-State: AJcUuketXzE7R2DSCE73HEb+MekLy/K/B5ln1LntS+zw5D7oQ4exooBu
        FAZQ7yFmSOG7MN6AnAfxmbIGup+Jh4w=
X-Google-Smtp-Source: ALg8bN6fgu6IMPCgcXSlMzyOBqaxSRTHY133XEhvw/uZqdZEyo8oA7ANGtfhoAU3URzLBoYTrmqKAg==
X-Received: by 2002:a63:b94c:: with SMTP id v12mr37822916pgo.221.1549070539982;
        Fri, 01 Feb 2019 17:22:19 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id w6sm28474584pga.72.2019.02.01.17.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 17:22:19 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [RFC] Sample of test for git branch -vv
Date:   Fri,  1 Feb 2019 17:22:10 -0800
Message-Id: <20190202012210.46950-1-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <CAC05386O=9CxkgUNGoYbwEOXiPPcAD7H5Kn97iCqPc1X7kAh6w@mail.gmail.com>
References: <CAC05386O=9CxkgUNGoYbwEOXiPPcAD7H5Kn97iCqPc1X7kAh6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

I remember now why I didn't add a test for this one earlier.

Testing git branch -vv is a little tricky for a couple reasons.

For one thing, the output contains commit hashes, so the 'expect' file cannot be simply static.

For another, the output doesn't have clear delimiters for all columns, so trying to extract only
the commit hashes is tough.

I took the approach of stripping all information before and including the commit hashes.

You can see below how I did this. For the patch with worktreepath information, the worktreepath would
appear before the commit message on just one of those lines, but I crafted this patch so that it can be applied
to master.

This works, but it's rather awkward and ugly. Does anyone have better suggestions either for how to test or
how to implement?

---
 t/t3203-branch-output.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 94ab05ad59..b836ca21fa 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -285,4 +284,22 @@ test_expect_success '--color overrides auto-color' '
 	test_cmp expect.color actual
 '
 
+test_expect_success 'test verbose verbose output' '
+	cat >expect <<-EOF &&
+	one
+	one
+	two
+	one
+	two
+	two
+	two
+	EOF
+	git branch -vv >tmp &&
+	head -1 tmp >tmp2 &&
+	SUBSTRLENGTH=$(awk "{print index(\$0, \"one\")}" <tmp2) &&
+	awk -v len="$SUBSTRLENGTH" "{print substr(\$0,len,length(\$0))}" <tmp >actual &&
+	test_cmp expect actual
+'
+
+
 test_done
-- 
2.14.2

