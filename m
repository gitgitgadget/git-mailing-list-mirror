Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BAB81F453
	for <e@80x24.org>; Thu,  7 Feb 2019 11:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfBGLUu (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 06:20:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39025 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfBGLUu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 06:20:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id f132so2341206pfa.6
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 03:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kHBC3gocJatMBg2P74CzejFe/z4RCNC6A2OhcWwmlUo=;
        b=ouknrptogW+EGbb5GEHUmSV+dvxKaDJV973xFF56G3HPfy3S/EcW4hPuXfRll9A6rj
         gUj3k7Mqrr6f/eIBDLBTcvQZpXjrCU475H5t7QerpxXR+SCXXgzUOuoXUQVb/Rb19wxg
         T/B4obKrilupPBkjFngiCyAzzp/DvuXIIM6OaEAOKfhVC5vjJy9YycVJ/CkRFRec1PWg
         vuOxgs/nEL+7K5B6x26LnevgM5GHYOZEiJh7BP7hbwbUADnoFDazhLPhjPxqi1/s7v2z
         GXMTjQ7yHzknYZnQb0MMsOmlz7+bnGWlKezW74USJrxWV1kflJ4fylWz7rdx2aO941vC
         96Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kHBC3gocJatMBg2P74CzejFe/z4RCNC6A2OhcWwmlUo=;
        b=mozZsyENFr6H5/elXTgdrhOcPIC42WBdC4zHoDP/pP0PZg/z3lqvPoikKwxJJvhLCs
         +ZodianFL+S8UJeGU2uJmasA5qEmGkOpYTJPKnu3qF6xMBzf/rkZutZ1MgXfOjmfAhVb
         5V2GvZac0w9Lv0U//IW1XRKKvIhwFvgEGPjKw2bH0PYQsxMQNKmYoSWbO76VGphExYLy
         +aGOxllLsnP5//VBK+CuWSDHOOl6QkIk0tYlV0gc+xlz3vzOUJmo8noLnRDDSlvmN0ZI
         X96YhbTn2oKEjNIECOmm6b7i8gYawPlTTgdVdXy8N/cHltmFSRtbFyTH1QIire2rebGn
         g0Eg==
X-Gm-Message-State: AHQUAubjUZiMa1yY9mAByvZlBRuXLLpHjshdywUpxE9UqAtcU5hkPqSP
        6BlCBf37f18kYIz/+klrVoI=
X-Google-Smtp-Source: AHgI3IY0F0NhFIelwLavsdoyPGxkNce0XqgZ7x9MXDiB4jSb4eyu4JKfOkeCTKMCO5o9HOThalTi2g==
X-Received: by 2002:a62:ca9c:: with SMTP id y28mr15591053pfk.236.1549538449349;
        Thu, 07 Feb 2019 03:20:49 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id e2sm12417558pga.92.2019.02.07.03.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 03:20:48 -0800 (PST)
Date:   Thu, 7 Feb 2019 03:20:46 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     apenwarr@gmail.com
Cc:     git@vger.kernel.org
Subject: [PATCH] contrib/subtree: ensure only one rev is provided
Message-ID: <cfd86853cce8a2cd5fae9e6fb9a84f1e3d6daaf4.1549538392.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While looking at the inline help for git-subtree.sh, I noticed that

	git subtree split --prefix=<prefix> <commit...>

was given as an option. However, it only really makes sense to provide
one revision because of the way the commits are forwarded to rev-parse
so this commit changes "<commit...>" to "<commit>" to reflect this. In
addition, it checks the arguments to ensure that only one rev is
provided for all subcommands that accept a commit.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/subtree/git-subtree.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 147201dc6c..868e18b9a1 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -14,7 +14,7 @@ git subtree add   --prefix=<prefix> <repository> <ref>
 git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <ref>
 git subtree push  --prefix=<prefix> <repository> <ref>
-git subtree split --prefix=<prefix> <commit...>
+git subtree split --prefix=<prefix> <commit>
 --
 h,help        show the help
 q             quiet
@@ -77,6 +77,12 @@ assert () {
 	fi
 }
 
+ensure_single_rev () {
+	if test $# -ne 1
+	then
+		die "You must provide exactly one revision.  Got: '$@'"
+	fi
+}
 
 while test $# -gt 0
 do
@@ -185,6 +191,7 @@ if test "$command" != "pull" &&
 then
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	dirs=$(git rev-parse --no-revs --no-flags "$@") || exit $?
+	ensure_single_rev $revs
 	if test -n "$dirs"
 	then
 		die "Error: Use --prefix instead of bare filenames."
@@ -716,9 +723,8 @@ cmd_add_repository () {
 }
 
 cmd_add_commit () {
-	revs=$(git rev-parse $default --revs-only "$@") || exit $?
-	set -- $revs
-	rev="$1"
+	rev=$(git rev-parse $default --revs-only "$@") || exit $?
+	ensure_single_rev $rev
 
 	debug "Adding $dir as '$rev'..."
 	git read-tree --prefix="$dir" $rev || exit $?
@@ -817,16 +823,10 @@ cmd_split () {
 }
 
 cmd_merge () {
-	revs=$(git rev-parse $default --revs-only "$@") || exit $?
+	rev=$(git rev-parse $default --revs-only "$@") || exit $?
+	ensure_single_rev $rev
 	ensure_clean
 
-	set -- $revs
-	if test $# -ne 1
-	then
-		die "You must provide exactly one revision.  Got: '$revs'"
-	fi
-	rev="$1"
-
 	if test -n "$squash"
 	then
 		first_split="$(find_latest_squash "$dir")"
-- 
2.20.1.522.g5f42c252e9

