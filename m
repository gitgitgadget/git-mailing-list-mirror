Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288F11F955
	for <e@80x24.org>; Fri, 29 Jul 2016 00:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbcG2Ao3 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:44:29 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35734 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbcG2AoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:44:25 -0400
Received: by mail-pf0-f181.google.com with SMTP id x72so26877597pfd.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 17:44:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KDKGWJVH3HAgop5leJNoZZKcThlXnEInieVwJQSZ4S4=;
        b=jUxoTJhBxoP4vfL3+j7BwQNNGy/MIm+cyBKDFbPK67cpOo62sSlZ9eD0jIFI43M/Zy
         dj/gfuNDUkPGV25CLgHjFmRc4f/c4sMvCj7LxOyAUOt9oOs7/W2wnJbfr3MVLlN3hhr/
         x9wpvWTCVxFgUZ58QHo0PHeOWSW4teAzWWQEODLJAgmoZA4jhI4i4IvAXN7WpsoUunR5
         2JUhYzAsmIyYJKok18cMCdEXbCd3BPnbGqk7nnSeEb/3hE+7TuM+OlkVfJ29xlSaMIRg
         4Yv9JATvvg63dPNFpPYaQhX2cJwBYziJnrLX4DsSDKunHjvqaIa/0aksEjNDLXbjGlHZ
         FKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KDKGWJVH3HAgop5leJNoZZKcThlXnEInieVwJQSZ4S4=;
        b=Di228ZeWLKVDdvNJkjS+KApcZn6iVp78snVGedEDCkAzJmZz/mru9pLMu6jsvrolsE
         2wNlZASIMC57FCqeeDl54b+cji8vHCVMMDlz46XLxOkxdj1xsP0ddQ8Kqm2mWQXQ6HDm
         Ky8fXhk6OOQ7Kj3SA7IPkGVsqZxrb8uXKaNQQAllwlEU5XYqD02NKJc6ilL4KrgsOflX
         UY+1DB196R4YR+dft+BdEoBDJl8JhjhxGmDndYbZgjmBlZmHPIT+yhkl5LbZZR0KXj9L
         5HXtsI4NW51YCDbKnOjiN6wkvMBg8tPOXy4tgYWXQPjzwbeujT8zh/zmpYhup0JKshxh
         4W8w==
X-Gm-Message-State: AEkoousUOgmXOU2PqbiY0PaxnETITqBgQnxFrd1p2xMevv+n1VLHMIPTZc4ThwlUB5meddYV
X-Received: by 10.98.13.84 with SMTP id v81mr64791937pfi.108.1469753059921;
        Thu, 28 Jul 2016 17:44:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6dbf:17d9:7b5c:47ec])
        by smtp.gmail.com with ESMTPSA id uc1sm19841883pac.24.2016.07.28.17.44.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 17:44:19 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, apenwarr@gmail.com,
	jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 3/7] submodule update: narrow scope of local variable
Date:	Thu, 28 Jul 2016 17:44:05 -0700
Message-Id: <20160729004409.2072-4-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.472.g1ffb07c.dirty
In-Reply-To: <20160729004409.2072-1-sbeller@google.com>
References: <20160729004409.2072-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 174f4ea..0d4021f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -591,7 +591,6 @@ cmd_update()
 
 		name=$(git submodule--helper name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
-		branch=$(get_submodule_config "$name" branch master)
 		if ! test -z "$update"
 		then
 			update_module=$update
@@ -617,6 +616,7 @@ cmd_update()
 
 		if test -n "$remote"
 		then
+			branch=$(get_submodule_config "$name" branch master)
 			if test -z "$nofetch"
 			then
 				# Fetch remote before determining tracking $sha1
-- 
2.9.2.472.g1ffb07c.dirty

