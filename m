Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF582023F
	for <e@80x24.org>; Thu,  3 May 2018 18:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeECStH (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 14:49:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38202 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbeECStD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 14:49:03 -0400
Received: by mail-wr0-f196.google.com with SMTP id 94-v6so17332792wrf.5
        for <git@vger.kernel.org>; Thu, 03 May 2018 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nXEFKobuv7qPrA3JyaWzYbCr6a0onOuxb0KzVU84qrQ=;
        b=vHcq5hEEq97m9ilOaEa/5vDAp0wFQyYp52pIPGv2JvGCjBw9+PZRqYxBjAcglAw7fU
         Y2U5Ui4i8rbkQ81JmoNALTjCkcKGTP/FXjXL0Rv3InZ05Ez8Ugrl/VWkdkAJL2VILjbG
         cVlvK6RHq02E/2ZZn/zWURQvugsNH4YUDoNiu255BGR/VccEtzr+gi434HW9P7ppB7kv
         1BfKT+H43gfPTd/GDlG10PiWJZ3h4UsoUNKGV/a0G2rJuOJwMn++A7rdqeKsRaLg0/HJ
         oKqFqvswA6Z51WEMHc3i9AuTLW1t5ArHNmAchXQwvwe0DJBZ/xZb91GQSvB245k7s5KT
         qBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXEFKobuv7qPrA3JyaWzYbCr6a0onOuxb0KzVU84qrQ=;
        b=m9Er/z6W5uAnx0kDlbyBvRK10QldInm6IWHpo+42EdeM6BnZRygVZcIhvaUnleCn8Z
         kqLoUdnmqSRoi6De6AamfORiwNA2eQ12F7brPOrkQ12HjhG/gJ5zE8xdgDGlmzBTX7aw
         mSRI0vN0/MlQlaOnNG2q9qKc2tgavI78iKnTIYhp7eHERUMsTCAry4388cuNRWQViJ2X
         BnP4VrlxpF+nJwz+yxQZ9+OoQKYr3t2Yax1q96I1xq4NX93B9azYvJnITePkWkL7XHC8
         +DPcAd9bfI+S6edu0wGYqXKUYtkIm/AvaY9VWQpLbNpt36aZ0HSMK1fjODJTvtFA5lbA
         Dt0Q==
X-Gm-Message-State: ALQs6tBIeXagP6WQIjLXEGmQNFp59DyBPUlO3PDou5BYaW0/vh5E4a6c
        BZd3bXMiUz9cVgCTNVfKeeDL22Qe
X-Google-Smtp-Source: AB8JxZo+uMfBBMr5QrYeXuthIQhvGWdWfLKNxLWo0BRMgx6BpMAAxh+YTHHtPKLCP2TlXGBmNBcH1Q==
X-Received: by 2002:adf:ab0a:: with SMTP id q10-v6mr18709749wrc.239.1525373342411;
        Thu, 03 May 2018 11:49:02 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:a521:6b31:5c87:9e4b])
        by smtp.gmail.com with ESMTPSA id f83-v6sm198322wmh.32.2018.05.03.11.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 May 2018 11:49:01 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 4/7] doc: add '-d' and '-o' for 'git push'
Date:   Thu,  3 May 2018 20:48:27 +0200
Message-Id: <20180503184830.11889-5-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180503184830.11889-1-asheiduk@gmail.com>
References: <20180427170440.30418-1-asheiduk@gmail.com>
 <20180503184830.11889-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the missing `-o` shortcut for `--push-option` to the synopsis.
Add the missing `-d` shortcut for `--delete` in the main section.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
Reviewed-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-push.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 5b08302fc2..f2bbda6e32 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
-	   [-u | --set-upstream] [--push-option=<string>]
+	   [-u | --set-upstream] [-o <string> | --push-option=<string>]
 	   [--[no-]signed|--signed=(true|false|if-asked)]
 	   [--force-with-lease[=<refname>[:<expect>]]]
 	   [--no-verify] [<repository> [<refspec>...]]
@@ -123,6 +123,7 @@ already exists on the remote side.
 	will be tab-separated and sent to stdout instead of stderr.  The full
 	symbolic names of the refs will be given.
 
+-d::
 --delete::
 	All listed refs are deleted from the remote repository. This is
 	the same as prefixing all refs with a colon.
-- 
2.16.2

