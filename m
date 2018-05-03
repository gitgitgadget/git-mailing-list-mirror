Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 416AE200B9
	for <e@80x24.org>; Thu,  3 May 2018 18:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeECStN (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 14:49:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33890 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeECStK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 14:49:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id a137-v6so4077029wme.1
        for <git@vger.kernel.org>; Thu, 03 May 2018 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pptuh+2ZE3WNc4UDPqChInOgJiydyz9NvD6qYZ96j2Y=;
        b=nkBWL7X2/xo12n07CpCFvw+4s1bT8J0JK8oeewiEU/2BqNW6LeefwbrPQIlnCfbaOk
         +8vmCcyDAtDUSIXp86/xl2Y0qHa8JzyzI2wrj7kNHj15Dtyii/r3BjhEowHlBdFpHLyb
         izGouBhek9YLLogL1eP3UaD0jabSVmoKY+4SgatPbrqwYqEzJ34z2H3S+XUstzo+nexp
         L9SYsTEIn8vjk83RgigmcLBjhDmVKhs022qgri3/8kLrOjnF4tHQHyHGScOe6luaJ4uG
         8VS2gJBH6c6/lDs1tc90I+NqzDSgJRVK5IgaWqj5JlSEOlWOQTmyHE10ud2q7BkFiuk4
         1LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pptuh+2ZE3WNc4UDPqChInOgJiydyz9NvD6qYZ96j2Y=;
        b=SZAWnph9uJ/ZusAzP77LfOc3GNoD5xkbUJi1G+m28Xn44E1U/r4/vMYRFn37Em6/Rn
         6J24fSYq6TYk1JchUqDrAm29RtN6U1vv7j5KIPLwlyCA0sCWHbhYKCCWsuiXy8OeAa5+
         W9Wwcr3fNlmHe380X4lhj+8fbtAQuosmileqKxuSAyBZ+/YeuQZC3jrNNV2Zlpu8zmLk
         8yFQ31b0BI7yW8VAGrhD9/DySCBKpeYvN+0mArVKdpZnbo4cYbx7Qo/IgjO7xkR664Xm
         ul9VlZAVDsayWD9VNhQoa/QP1q++KMRea34gsHB3/b8PuL1U7mB7msyxb/MBgq9sLj4n
         8gwQ==
X-Gm-Message-State: ALQs6tDz/nse5aMQdF3L+tdlWxd43rJnetZ7bKt7z8arDo5x+AWY0fH/
        qIUlSUERXalEo9GzBCD2XaQNM7qv
X-Google-Smtp-Source: AB8JxZp2zMLBfnGsfFVetM/0xHz9FJMMOmQ6Uqukc24ohSTpwqX66hGUVmNWURtN0iQEazJr10Uwsg==
X-Received: by 10.28.24.11 with SMTP id 11mr16792031wmy.21.1525373348999;
        Thu, 03 May 2018 11:49:08 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:a521:6b31:5c87:9e4b])
        by smtp.gmail.com with ESMTPSA id f83-v6sm198322wmh.32.2018.05.03.11.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 May 2018 11:49:08 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 7/7] doc: normalize [--options] to [options] in git-diff
Date:   Thu,  3 May 2018 20:48:30 +0200
Message-Id: <20180503184830.11889-8-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180503184830.11889-1-asheiduk@gmail.com>
References: <20180427170440.30418-1-asheiduk@gmail.com>
 <20180503184830.11889-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SYNOPSIS and other manuals use [options] but DESCRIPTION
used [--options].

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-diff.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 6593b58299..7c2c442700 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -21,7 +21,7 @@ Show changes between the working tree and the index or a tree, changes
 between the index and a tree, changes between two trees, changes between
 two blob objects, or changes between two files on disk.
 
-'git diff' [--options] [--] [<path>...]::
+'git diff' [options] [--] [<path>...]::
 
 	This form is to view the changes you made relative to
 	the index (staging area for the next commit).  In other
@@ -29,7 +29,7 @@ two blob objects, or changes between two files on disk.
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
 
-'git diff' [--options] --no-index [--] <path> <path>::
+'git diff' [options] --no-index [--] <path> <path>::
 
 	This form is to compare the given two paths on the
 	filesystem.  You can omit the `--no-index` option when
@@ -38,7 +38,7 @@ two blob objects, or changes between two files on disk.
 	or when running the command outside a working tree
 	controlled by Git.
 
-'git diff' [--options] --cached [<commit>] [--] [<path>...]::
+'git diff' [options] --cached [<commit>] [--] [<path>...]::
 
 	This form is to view the changes you staged for the next
 	commit relative to the named <commit>.  Typically you
@@ -48,7 +48,7 @@ two blob objects, or changes between two files on disk.
 	<commit> is not given, it shows all staged changes.
 	--staged is a synonym of --cached.
 
-'git diff' [--options] <commit> [--] [<path>...]::
+'git diff' [options] <commit> [--] [<path>...]::
 
 	This form is to view the changes you have in your
 	working tree relative to the named <commit>.  You can
@@ -56,18 +56,18 @@ two blob objects, or changes between two files on disk.
 	branch name to compare with the tip of a different
 	branch.
 
-'git diff' [--options] <commit> <commit> [--] [<path>...]::
+'git diff' [options] <commit> <commit> [--] [<path>...]::
 
 	This is to view the changes between two arbitrary
 	<commit>.
 
-'git diff' [--options] <commit>..<commit> [--] [<path>...]::
+'git diff' [options] <commit>..<commit> [--] [<path>...]::
 
 	This is synonymous to the previous form.  If <commit> on
 	one side is omitted, it will have the same effect as
 	using HEAD instead.
 
-'git diff' [--options] <commit>\...<commit> [--] [<path>...]::
+'git diff' [options] <commit>\...<commit> [--] [<path>...]::
 
 	This form is to view the changes on the branch containing
 	and up to the second <commit>, starting at a common ancestor
-- 
2.16.2

