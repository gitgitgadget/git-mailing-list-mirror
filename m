Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82CF820248
	for <e@80x24.org>; Thu,  7 Mar 2019 08:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfCGIZf (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 03:25:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44235 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfCGIZd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 03:25:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id a3so10861964pff.11
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 00:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fmkuL2LNVi5f5+n2ISyjcBHbIX6McxLIHWePpT2KzS4=;
        b=oCi+1hcf3b+SLwPkD/SWqRC5d43WxTm9B3ymAOtZMJC7qdSJnbG/LH1ZlWvnI+jRei
         aeFIUDGurkchOE4H+8j0CSQKsYAzduClsEqYcO+qwIeVRoRQUa28uXHB0oB35St4SPDr
         TpXOLBh3+Bq592nSrhilhDbBDp7auB7l5mTMp+/eCk8zMmmlxetn68ClmMdBwhyirGxX
         KIj7RLjO2zvKyT2BxyAS9FkELLhCOyFziO7TjJigSt3iCfWFxFzcyDLj8zfvCyfU6fsz
         SkdTrpSn3rG9PE/gGUOL2tys7lBhmuYA7CLMdzZrN4d3D5SrHPzUVnFLJ/tQg5W0ESgn
         qsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fmkuL2LNVi5f5+n2ISyjcBHbIX6McxLIHWePpT2KzS4=;
        b=slA3rZMMQq7E1XjKPend2QCfIXzwvD59HT5KzkXeNOPNxt8rQZixKKEerYYJttqc2B
         sKyLpT0mVch0GtxGGIcG0Ion0BMpty4c8bWwK6d3wWczYOuK918B2d6OuamZAsYHkYcg
         zN8+kzw53T081rhderStkRmf32cjrXz6yHcYe8hjixOnyjaTAvjjUnlKwyPV35fTTSy2
         pvyKrEYdiT9YhYVb7Y01F8HZRAof2weAOH6aVQxrO1fR/RGudcfR0bgzo4GYaTyIaOsv
         ZCGf109FdeTOlHWaLTZjxbnY8db/lhr7QVCtKMId1nEjcbhlw3e8w1iw94RWqDf63nuF
         i4ZA==
X-Gm-Message-State: APjAAAVWPEDkU8GvoIir+zbZnrZ/ZmOqDjoRSGV2E/2b6j6g9xHU2Nx4
        J3DB7ACGFqR/9SKBE6N28U+QFayK
X-Google-Smtp-Source: APXvYqyumm8Fm9gIIeuEoV04L8WmTge1m4liCNWskauPTkNdH1COpgpMc2FtlvxV4XqmUxtV/dxKAg==
X-Received: by 2002:a17:902:7082:: with SMTP id z2mr11310571plk.251.1551947132989;
        Thu, 07 Mar 2019 00:25:32 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id h65sm5326252pgc.93.2019.03.07.00.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 00:25:32 -0800 (PST)
Date:   Thu, 7 Mar 2019 00:25:30 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/2] Docs: move core.excludesFile from git-add to gitignore
Message-ID: <f1bc7d5eb1ad15427f6d14c19c90595d09acabe5.1551947030.git.liu.denton@gmail.com>
References: <cover.1551938421.git.liu.denton@gmail.com>
 <cover.1551947030.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551947030.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was a section on configuration mentioning core.excludesFile in
git-add.txt. However, the core.excludesFile config variable is not
exclusive to git-add. Move this description to gitignore.txt to be more
generic.
---
 Documentation/git-add.txt   | 9 ---------
 Documentation/gitignore.txt | 8 ++++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 37bcab94d5..8b0e4c7fa8 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -193,15 +193,6 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	for command-line options).
 
 
-CONFIGURATION
--------------
-
-The optional configuration variable `core.excludesFile` indicates a path to a
-file containing patterns of file names to exclude from git-add, similar to
-$GIT_DIR/info/exclude.  Patterns in the exclude file are used in addition to
-those in info/exclude.  See linkgit:gitignore[5].
-
-
 EXAMPLES
 --------
 
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 1c94f08ff4..b5bc9dbff0 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -132,6 +132,14 @@ full pathname may have special meaning:
  - Other consecutive asterisks are considered regular asterisks and
    will match according to the previous rules.
 
+CONFIGURATION
+-------------
+
+The optional configuration variable `core.excludesFile` indicates a path to a
+file containing patterns of file names to exclude, similar to
+`$GIT_DIR/info/exclude`.  Patterns in the exclude file are used in addition to
+those in `$GIT_DIR/info/exclude`.
+
 NOTES
 -----
 
-- 
2.21.0.368.gbf248417d7

