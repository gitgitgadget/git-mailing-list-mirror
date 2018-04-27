Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AE391F424
	for <e@80x24.org>; Fri, 27 Apr 2018 17:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758822AbeD0RFc (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:05:32 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39996 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758554AbeD0RFa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:05:30 -0400
Received: by mail-wr0-f193.google.com with SMTP id v60-v6so2424176wrc.7
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nXEFKobuv7qPrA3JyaWzYbCr6a0onOuxb0KzVU84qrQ=;
        b=LMR3aSMiec/iI8uqTICNV0LP23DAANUDCkc3QTgvX+8LKqVAETlfSFs1O6sA1KsOh+
         zlQ9Xxdzpp4dv4/8yJboav2bfwOiJcmytF3EEzSkseZZkeQO43geOcOhY6rMcn+OQIZA
         5mbgMHdigsWQ9DEfqwcPS/g62K5ZSpsejBTmVeSh6knGM9LWsFjRcVJYkmB6DD0jKQuU
         hbPVLZbZ4wxECjJPtG/rhLMuVrcHM04Y1uy6KI8jOk4pENBX89i0Esx2dKftuc5eDELK
         hrUh+k8tC+24ckJRWLV145ob6PgC2QC6nTVMKpl3XBnaq4FD2bJx3SYhrrRhENKk3aSq
         1mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nXEFKobuv7qPrA3JyaWzYbCr6a0onOuxb0KzVU84qrQ=;
        b=TZKmUwwEj6E2OWnTLsXGBbleZmYOlQYhTEdFwbvsCt5CzOFpgKVTbRR7uRB9j6Jp0e
         AZLL1kJSIrM0AWoCisM01m7gkaZsq2os+B2ClOZwG8mSbb/vCFSYQHumhPfhf97t+kEe
         D1wl3gn9nMwxYQCeT9Gx0eyw3vJjH/wYBHLXrWkTNj50eoZbRyYe53NBeMpaAqkYs9Y3
         Z8Eib7n17mlfIHM6FWQt87Ca4oJH1i1CrEPtF60kbNBAs85LyIIcZLRznqsDgYnC3q88
         Bd2zujSj2WbytlxxFVc058C1r3d51lqYyFhJYML30nJRJnFPaGF8RoEFfFEK5zHvz0cA
         KGVA==
X-Gm-Message-State: ALQs6tD6LUZj9GkmFpQj/qYFtfkV8Owlg3O1RQsXj/5PBT0YWm5FpxHl
        +lqapOrtZeQpeSvZL3NhLG9SrS7O
X-Google-Smtp-Source: AB8JxZrNOquQ3z+6OPmYzQwUIhMBoQsLEc2KI0t1ctI+EQIyVAukPuIqt/YkE3+s+QEMj7iY2CkvVA==
X-Received: by 2002:adf:da4b:: with SMTP id r11-v6mr2410481wrl.154.1524848728613;
        Fri, 27 Apr 2018 10:05:28 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:dd1e:a7ac:6cfc:1274])
        by smtp.gmail.com with ESMTPSA id o10-v6sm1765745wrg.90.2018.04.27.10.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 10:05:28 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 4/6] doc: add '-d' and '-o' for 'git push'
Date:   Fri, 27 Apr 2018 19:04:38 +0200
Message-Id: <20180427170440.30418-5-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180427170440.30418-1-asheiduk@gmail.com>
References: <20180427170440.30418-1-asheiduk@gmail.com>
In-Reply-To: <20180410183224.10780-1-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
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

