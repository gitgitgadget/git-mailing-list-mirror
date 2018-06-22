Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F131F597
	for <e@80x24.org>; Fri, 22 Jun 2018 15:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933997AbeFVPt7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 11:49:59 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34625 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933968AbeFVPt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 11:49:57 -0400
Received: by mail-oi0-f67.google.com with SMTP id i205-v6so6550851oib.1
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 08:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FhcsC7ej3v59tAki64Xi+bJ//HtfcuNwrn4M5omazQE=;
        b=f7Uo3t1kbAS8fXfVnDlWyUfy3ATcwvUThO7uym282KBty6ekwNyMV60uLM6fgFQD/u
         cbUKJUq7bBFH630WMIXq4NhwXlVg/193ySVMBHJndanTxadL8fQTLTETLN2H9LpVzlbi
         7Bo0Dn0MzigqX692tsJP97LRJI8LTYV2eOnM0aFBktUklNjSBdw9W+b7DvrjpHP9zb/h
         1TeHMVXepk+xfVn6O/rHSBhGFO0nCRx59J43jTAnqOgHDFiTBUzH/5xGibI4jiVwv7KW
         bJAyfXMCgFoUC2jfPpdhw8z/LWw+lnXAuWq4NzzUKg3bZ3DKZzTSjBd/a8Z1lYC8+R9j
         tidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FhcsC7ej3v59tAki64Xi+bJ//HtfcuNwrn4M5omazQE=;
        b=DOiAegeO6VqvD1fPa0S9B4iw3f6TMdRuQkKFebR7AodG/0b1UV2EIe9A7ywSK5uCD9
         gH43kRPNy/pD9ewj+7AHJoQXzqMtVFJwoSvyXA6wIWUxful3BTfMyEp9sCelTrwCo1cR
         +37sd9UlUdnJ+iPH7IuJtVQs/F4eNzpGtoGTsDssqpHKBV7GfTHIamjzfO+6b2d0aiVM
         lpILOtfynXEa+bEnHFOmJjYXxZwL19+Ma0oKiklBgRabbCXGUN6o4RUCOhUuoNcAs5f0
         udMsJCbJVGtQiMe0+G3X6jpeRS3fl0vlKZIzQXlkz6sR4SYjkgJSxO4ipmhd8Vi2uSAX
         L3xw==
X-Gm-Message-State: APt69E2v+ih/dT9J8rTiJoQvzJ8Z00TraUXiNPO+gQ5hEd00kPiy3WHI
        BybFoA8OiMuU/ThZz6AYDDrUQynDMHM=
X-Google-Smtp-Source: ADUXVKLD8Onfkxu4nGHS3XLnzL5zumKvVpsJxv55yy5SZHCADLWT3IFjDwFzTb0ZJ7QD5l6OeHQUbA==
X-Received: by 2002:aca:4d0c:: with SMTP id a12-v6mr1076947oib.37.1529682596406;
        Fri, 22 Jun 2018 08:49:56 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id 200-v6sm6286242oib.49.2018.06.22.08.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 08:49:55 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:49:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v3 7/7] contrib/git-jump/git-jump: jump to exact location
Message-ID: <81c077c86d9e538a8ee094252a7b8e6beb05e224.1529682173.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529682173.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529682173.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take advantage of 'git-grep(1)''s new option, '--column' in order to
teach Peff's 'git-jump' script how to jump to the correct column for any
given match.

'git-grep(1)''s output is in the correct format for Vim's jump list, so
no additional cleanup is necessary.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 contrib/git-jump/README   | 12 ++++++++++--
 contrib/git-jump/git-jump |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 4484bda410..2f618a7f97 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -25,6 +25,13 @@ git-jump will feed this to the editor:
 foo.c:2: printf("hello word!\n");
 -----------------------------------
 
+Or, when running 'git jump grep', column numbers will also be emitted,
+e.g. `git jump grep "hello"` would return:
+
+-----------------------------------
+foo.c:2:9: printf("hello word!\n");
+-----------------------------------
+
 Obviously this trivial case isn't that interesting; you could just open
 `foo.c` yourself. But when you have many changes scattered across a
 project, you can use the editor's support to "jump" from point to point.
@@ -35,7 +42,8 @@ Git-jump can generate four types of interesting lists:
 
   2. The beginning of any merge conflict markers.
 
-  3. Any grep matches.
+  3. Any grep matches, including the column of the first match on a
+     line.
 
   4. Any whitespace errors detected by `git diff --check`.
 
@@ -82,7 +90,7 @@ which does something similar to `git jump grep`. However, it is limited
 to positioning the cursor to the correct line in only the first file,
 leaving you to locate subsequent hits in that file or other files using
 the editor or pager. By contrast, git-jump provides the editor with a
-complete list of files and line numbers for each match.
+complete list of files, lines, and a column number for each match.
 
 
 Limitations
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 80ab0590bc..931b0fe3a9 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -52,7 +52,7 @@ mode_merge() {
 # editor shows them to us in the status bar.
 mode_grep() {
 	cmd=$(git config jump.grepCmd)
-	test -n "$cmd" || cmd="git grep -n"
+	test -n "$cmd" || cmd="git grep -n --column"
 	$cmd "$@" |
 	perl -pe '
 	s/[ \t]+/ /g;
-- 
2.18.0
