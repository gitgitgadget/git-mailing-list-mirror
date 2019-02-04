Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAED51F453
	for <e@80x24.org>; Mon,  4 Feb 2019 10:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfBDKgc (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 05:36:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53051 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfBDKgc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 05:36:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so12574613wml.2
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 02:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppxFAjs+inN7ugv4TF41bxlGMg78CjeaX7XlxJYwcHU=;
        b=hJEiuImURQwtgXIgmv76ae3AT6fq3W6FvNcrVOl0irDM2lSJud5KtMh70Vjk0nX39Q
         PGSfNVRQEgH2K1/KxLgXHwpVjjb4b5ttTRF5SQmoNg4i9+aD57/E+DZTMKc6yxUhrsW/
         OzFTjhLi+bt+B73A/Ij9lfaaFP2oOPXNdu0kqvgyS91E1eiPAAOZEZKXyzcpoLTY92T4
         qI6W4677hiW6vasT7ePqswc8WrNux8WxLTA/lnlbSRh98+R0dwxY5gLGBqJOZckt26jB
         Pi8hRWBEKE5CkmMpArfrCFxutdKTZ/lARNo9lo7RGZ0mZxfXD4Bf0pxRCAr6eOEC7V8C
         Oshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppxFAjs+inN7ugv4TF41bxlGMg78CjeaX7XlxJYwcHU=;
        b=RLdjXC5VUn2ARblrtAs3YcOaC5pNQNePLFhpODgxAdEBLCj2QAAU9x8qG/gAvFG02E
         lM4oGUhjBpI590z8vU4nwD4f2uOaIJq/TGgfffCe8M6rxIjVvAYXfFhuXubojj1VA0rK
         ZBOgAmoOm93vFiwstMBTiwb1Wg9QtEOkbGHj7DiZXQ1+LKTECkzS//zfMb7PL2dsEB6P
         41LHojGh91abwFYVKX1Y6CKiiE3NqeiQ8YRVVz2mBoD0cVxYWGJ46lp2jV6N05mr6e5O
         uL4dCVGfHXyrUt2L+qYguj3YVXPYUyBlu03PtgjKhZ+dmcb+HhLKM24iWALInxYvPHtp
         kJLw==
X-Gm-Message-State: AHQUAuYbX5sLRS0H2UEmO4MkHCsuwXbqosUDNbe1zfkr6J2zMur29mje
        CAblwboYwa0FTrBWN/+AA0conpK3vyA=
X-Google-Smtp-Source: AHgI3IbbnbR7Ti4L1O7EhgcA7xjYF9JLhxThiBVjGgKcZpN9gz83/96pKUKoH3IkrT9cPA0Ef44qJw==
X-Received: by 2002:a1c:e488:: with SMTP id b130mr13118990wmh.124.1549276587830;
        Mon, 04 Feb 2019 02:36:27 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o9sm7472639wmh.3.2019.02.04.02.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 02:36:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] diff-tree doc: correct & remove wrong documentation
Date:   Mon,  4 Feb 2019 11:36:18 +0100
Message-Id: <20190204103618.17992-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1
In-Reply-To: <1292425376-14550-12-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-12-git-send-email-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation saying that diff-tree didn't support anything except
literal prefixes hasn't been true since
d38f28093e ("tree_entry_interesting(): support wildcard matching",
2010-12-15), but this documentation was not updated at the time.

Since this command uses pathspecs like most other commands, there's no
need to show examples of how the various "cmd <revs> <paths>"
invocations work.

Furthermore, the "git diff-tree --abbrev 5319e4" example shown here
never worked. We'd ended up with that through a combination of
62b42d3487 ("docs: fix some antique example output", 2011-05-26) and
ac4e086929 ("Adjust core-git documentation to more recent Linus GIT.",
2005-05-05), but "git diff-tree <tree>" was always invalid.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-diff-tree.txt | 51 +--------------------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 2319b2b192..43daa7c046 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -31,10 +31,7 @@ include::diff-options.txt[]
 
 <path>...::
 	If provided, the results are limited to a subset of files
-	matching one of these prefix strings.
-	i.e., file matches `/^<pattern1>|<pattern2>|.../`
-	Note that this parameter does not provide any wildcard or regexp
-	features.
+	matching one of the provided pathspecs.
 
 -r::
         recurse into sub-trees
@@ -114,52 +111,6 @@ include::pretty-options.txt[]
 
 
 include::pretty-formats.txt[]
-
-
-LIMITING OUTPUT
----------------
-If you're only interested in differences in a subset of files, for
-example some architecture-specific files, you might do:
-
-	git diff-tree -r <tree-ish> <tree-ish> arch/ia64 include/asm-ia64
-
-and it will only show you what changed in those two directories.
-
-Or if you are searching for what changed in just `kernel/sched.c`, just do
-
-	git diff-tree -r <tree-ish> <tree-ish> kernel/sched.c
-
-and it will ignore all differences to other files.
-
-The pattern is always the prefix, and is matched exactly.  There are no
-wildcards.  Even stricter, it has to match a complete path component.
-I.e. "foo" does not pick up `foobar.h`.  "foo" does match `foo/bar.h`
-so it can be used to name subdirectories.
-
-An example of normal usage is:
-
-  torvalds@ppc970:~/git> git diff-tree --abbrev 5319e4
-  :100664 100664 ac348b... a01513...	git-fsck-objects.c
-
-which tells you that the last commit changed just one file (it's from
-this one:
-
------------------------------------------------------------------------------
-commit 3c6f7ca19ad4043e9e72fa94106f352897e651a8
-tree 5319e4d609cdd282069cc4dce33c1db559539b03
-parent b4e628ea30d5ab3606119d2ea5caeab141d38df7
-author Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005
-committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005
-
-Make "git-fsck-objects" print out all the root commits it finds.
-
-Once I do the reference tracking, I'll also make it print out all the
-HEAD commits it finds, which is even more interesting.
------------------------------------------------------------------------------
-
-in case you care).
-
-
 include::diff-format.txt[]
 
 GIT
-- 
2.20.1.611.gfbb209baf1

