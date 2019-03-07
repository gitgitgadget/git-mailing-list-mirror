Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC6EC20248
	for <e@80x24.org>; Thu,  7 Mar 2019 08:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfCGIZi (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 03:25:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46433 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfCGIZb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 03:25:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id 196so10682380pgf.13
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 00:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8WL9ZbrE7a2jpQNGNaJt64GSFFJASkuawvNMC7m0Mns=;
        b=f4oKvwDMNspLeSrFguBpr+gPlWHQ9qdVCPgvr3XsFF+LbGzVl+YDELG/I9ERUtUfKf
         yDGXSE5XRH5jYrf0slAcrvnYgL1PefH7Hpt8WpyYEABBcbJGtcd6ThoQVO+u7TIIn32i
         PIE2ehlfgM3Q0c4l80rvtDkrJPT+oNMPZczEyo5MJveBo+JMojjmgh7XXYQEOwz2EcgY
         CSDktCPHOAs0QIB+GGNKN3cnM8KTpOHFG0AiU9ak2VxONKX7to3gC6ez48RhIwFDlrAt
         v+uS4VQKz7/4aA1/ZG9+029hLN1HuyLy08tSHnQ1HzkEyiMb9pQoVEs62ZjbmBRLmSJp
         yR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8WL9ZbrE7a2jpQNGNaJt64GSFFJASkuawvNMC7m0Mns=;
        b=nL9dKgz9Wj67XA5MOvuBDszV8Cw75svVwBTnIwDoS0n3Xp7L5AYOOvIXEBLVZeSrQ3
         HBjmGaQ1FvVNCuft5le8fdbLOlYQc1lR8BvZHdDpZh6C9rQMmdQOpo/C4Wg/9HRb6i46
         U2HKWqnzpla5olxdb7o2lDLYKo022y13OIB21xsDgYdgfWH1xlJNEvClWxxLK8ZaW7qb
         KlqYII3IsYVvDda2i61EJZsKf2W68eVot8QhewsJwbb29nTGMZRAU5ddOG1SY0K/wJmE
         c/SaA+28T5tPBWBRxmF/Sb0YoByZSxvYfsPU2/FtCy44WqDBfFmNFZouKR3DShnY/Esz
         g8OQ==
X-Gm-Message-State: APjAAAVR3M2H48c2wnZLg/6sU0yAwli2a7ESyDrHeo2oeJUWl+BPmyge
        nUDZUylAqh1VZ8B1dNdGKqTLA2BV
X-Google-Smtp-Source: APXvYqz+Edyv20NQAxxIfm8Nen/deCNpSiSzUmR5GpKwOHCAsAEj4xezSj38W072mCFddUwTFnJ7vQ==
X-Received: by 2002:a17:902:42d:: with SMTP id 42mr11928653ple.229.1551947130685;
        Thu, 07 Mar 2019 00:25:30 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id l64sm5109958pga.87.2019.03.07.00.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 00:25:30 -0800 (PST)
Date:   Thu, 7 Mar 2019 00:25:28 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/2] git-clean.txt: clarify ignore pattern files
Message-ID: <caf7156412dc5bef0d12476cf4ef59d9cfee6a54.1551947030.git.liu.denton@gmail.com>
References: <cover.1551938421.git.liu.denton@gmail.com>
 <cover.1551947030.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1551947030.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the git-clean documentation, -x and -e documented .gitignore,
$GIT_DIR/info/excludes but neglected to mention the file pointed to by
core.excludesFile.

Remove specific list of files and, instead, reference gitignore(5)
documentation so that information is consolidated and the git-clean
documentation is more precise.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Helped-by: Martin Ågren <martin.agren@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-clean.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 03056dad0d..db876f7dde 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -55,14 +55,13 @@ OPTIONS
 
 -e <pattern>::
 --exclude=<pattern>::
-	In addition to those found in .gitignore (per directory) and
-	$GIT_DIR/info/exclude, also consider these patterns to be in the
-	set of the ignore rules in effect.
+	Use the given exclude pattern in addition to the standard ignore rules
+	(see linkgit:gitignore[5]).
 
 -x::
-	Don't use the standard ignore rules read from .gitignore (per
-	directory) and $GIT_DIR/info/exclude, but do still use the ignore
-	rules given with `-e` options.  This allows removing all untracked
+	Don't use the standard ignore rules (see linkgit:gitignore[5]), but
+	still use the ignore rules given with `-e` options from the command
+	line.  This allows removing all untracked
 	files, including build products.  This can be used (possibly in
 	conjunction with 'git reset') to create a pristine
 	working directory to test a clean build.
-- 
2.21.0.368.gbf248417d7

