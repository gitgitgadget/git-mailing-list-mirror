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
	by dcvr.yhbt.net (Postfix) with ESMTP id 11FD81F4BE
	for <e@80x24.org>; Sat,  5 Oct 2019 00:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfJEANN (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 20:13:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34827 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfJEANM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 20:13:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so4862825pfw.2
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 17:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wPZrTrC5WGMc61LMOqkQcbdt3IfMYQosjxpxNmq3VC4=;
        b=PBoSFEf2s/l8mMVsRXnqiGMFQi1Y1dI/Om/K/BZW0OUnzKkXlIjm9plFD+qvUA8dYH
         jz8QSa0Zw5XtnTjOjWtSMTPGcMTCykydFbd7Bi1nlXLQcVLCfFi+mCR9s51qVtvkLiYo
         kq9bCwsxKz1wvKdk3TsdQQuyR02XWX7Rw49vJfO8od3RTFHQ9dzoARd7l7KgfisNEi+3
         CyI9YL6FgCffvb5CVGZ5qy+ORLN/uHjzczSqix4Il7mZR5BjA2mCFmtW2D+n9fqx6Jts
         xwem/i57hZyaVZGepnv2JScqnkcuhRQ6MbevBNXz8oML0BIizy6aTuY0PdsE++8bmwkf
         77oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wPZrTrC5WGMc61LMOqkQcbdt3IfMYQosjxpxNmq3VC4=;
        b=UQrRFRjR4qOLYac8uCvjTTJ4F6NeB9TQs6FfhHMUeFVJXeLLCwYX1p75P0emxXgblm
         hkovub/s0Kzf73yQ9q4mttoHY40CZsuOo1rYerLPyYMrPVA91o09Ryt/R2aHkHU0P1p+
         DZCazGbBIDEyCmCXE3udQeiE89RYGGHl8OPC3nlIklc9O4GhL8MTUVGfsTdy7CUpZYrV
         Q7+nd8ewRhesiGrltb8+hKOk11CoYdWS3OejY8shgal5eWlUBd7vmv9Gf+R5JmFDh0g+
         /HDRPfAqhje9aMJhli7CmAXuDgayM6NQuuc123RserDa7LWZ7IkAZtfU8jWdgbsdjm2m
         xWzg==
X-Gm-Message-State: APjAAAWEF2IM+qpti5DFFVfFDt5UXkOORrZ9vBb5NDbxXreyhEjNxIhm
        3JUJ6Opm+6RW9gkxwQxE9M2G7gxa
X-Google-Smtp-Source: APXvYqzReosQGlflzDC7zzI73kwgTI2hGvYaiJBkiSECfqRtFc1mFi+nqHA/4Y1LuS0Kg5Rx94Ws5g==
X-Received: by 2002:a63:7887:: with SMTP id t129mr18321726pgc.440.1570234391484;
        Fri, 04 Oct 2019 17:13:11 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id p17sm7842053pfn.50.2019.10.04.17.13.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 17:13:10 -0700 (PDT)
Date:   Fri, 4 Oct 2019 17:13:08 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] git-rev-list.txt: prune options in synopsis
Message-ID: <645cc54c4c86493c855ec6b0b892a0bc8e999249.1570234118.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The synopsis section in git-rev-list.txt has grown to be a huge list
that probably needs its own synopsis. Since the list is huge, users may
be given the false impression that the list is complete, however it is
not. It is missing many of the available options.

Since the list of options in the synopsis is not only annoying but
actively harmful, replace it with `[<options>]` so users know to
explicitly look through the documentation for further information.

While we're at it, update the optional path notation so that it is more
modern.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
I initially wrote a patch to document --children in the synopsis
alongside --parents. However, I quickly realised that --children was
only one of many missing options. Other options included:

	--since
	--after
	--until
	--before
	--show-notes
	--all-match
	--invert-grep
	--basic-regexp
	--perl-regexp
	--exclude
	--reflog
	--alternate-refs
	--single-worktree
	--boundary
	--progress
	--simplify-by-decoration
	... stopped checking here

so I decided it wasn't worth it to keep this list around if it's so
incomplete when even the porcelain git-log.txt doesn't carry a huge list
in the synopsis.

I went through and manually checked each option to ensure that there was
a corresponding option in either rev-list-options.txt or
pretty-options.txt so we shouldn't lose any information by deleting this
list.

 Documentation/git-rev-list.txt | 54 +---------------------------------
 1 file changed, 1 insertion(+), 53 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 9392760b25..025c911436 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,59 +9,7 @@ git-rev-list - Lists commit objects in reverse chronological order
 SYNOPSIS
 --------
 [verse]
-'git rev-list' [ --max-count=<number> ]
-	     [ --skip=<number> ]
-	     [ --max-age=<timestamp> ]
-	     [ --min-age=<timestamp> ]
-	     [ --sparse ]
-	     [ --merges ]
-	     [ --no-merges ]
-	     [ --min-parents=<number> ]
-	     [ --no-min-parents ]
-	     [ --max-parents=<number> ]
-	     [ --no-max-parents ]
-	     [ --first-parent ]
-	     [ --remove-empty ]
-	     [ --full-history ]
-	     [ --not ]
-	     [ --all ]
-	     [ --branches[=<pattern>] ]
-	     [ --tags[=<pattern>] ]
-	     [ --remotes[=<pattern>] ]
-	     [ --glob=<glob-pattern> ]
-	     [ --ignore-missing ]
-	     [ --stdin ]
-	     [ --quiet ]
-	     [ --topo-order ]
-	     [ --parents ]
-	     [ --timestamp ]
-	     [ --left-right ]
-	     [ --left-only ]
-	     [ --right-only ]
-	     [ --cherry-mark ]
-	     [ --cherry-pick ]
-	     [ --encoding=<encoding> ]
-	     [ --(author|committer|grep)=<pattern> ]
-	     [ --regexp-ignore-case | -i ]
-	     [ --extended-regexp | -E ]
-	     [ --fixed-strings | -F ]
-	     [ --date=<format>]
-	     [ [ --objects | --objects-edge | --objects-edge-aggressive ]
-	       [ --unpacked ]
-	       [ --object-names | --no-object-names ]
-	       [ --filter=<filter-spec> [ --filter-print-omitted ] ] ]
-	     [ --missing=<missing-action> ]
-	     [ --pretty | --header ]
-	     [ --bisect ]
-	     [ --bisect-vars ]
-	     [ --bisect-all ]
-	     [ --merge ]
-	     [ --reverse ]
-	     [ --walk-reflogs ]
-	     [ --no-walk ] [ --do-walk ]
-	     [ --count ]
-	     [ --use-bitmap-index ]
-	     <commit>... [ \-- <paths>... ]
+'git rev-list' [<options>] <commit>... [[--] <path>...]
 
 DESCRIPTION
 -----------
-- 
2.23.0.687.g391267506c

