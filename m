Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6C9B1FF7F
	for <e@80x24.org>; Sun, 11 Dec 2016 00:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbcLKAGs (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 19:06:48 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:33894 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752977AbcLKAGr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 19:06:47 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4D0A21FF7F;
        Sun, 11 Dec 2016 00:06:46 +0000 (UTC)
Date:   Sun, 11 Dec 2016 00:06:46 +0000
From:   Eric Wong <e@80x24.org>
To:     Juergen Kosel <juergen.kosel@gmx.de>
Cc:     git@vger.kernel.org
Subject: [PATCH] git-svn: document useLogAuthor and addAuthorFrom config keys
Message-ID: <20161211000646.GA19328@untitled>
References: <1936940c-c4c8-540c-eb99-b434e8d32d6c@gmx.de>
 <20161205225424.GA29771@starla>
 <6160a58b-5f86-384f-30b5-2a3826019157@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6160a58b-5f86-384f-30b5-2a3826019157@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Juergen Kosel <juergen.kosel@gmx.de> wrote:
> Am 05.12.2016 um 23:54 schrieb Eric Wong:
> > So, can you confirm that svn.addAuthorFrom and svn.useLogAuthor 
> > config keys work and can be documented?
> 
> yes, I can confirm, that adding this configuration keys works with git
> 2.1.4 work.
> I have added the config keys as follows:
> 
> git config --add --bool svn.useLogAuthor true
> git config --add --bool svn.addAuthorFrom true

Thanks for testing, patch below.

> > Even better would be for you to provide a patch to the 
> > documentation :) Otherwise, I can write one up sometime this week.
> 
> My English is not that well. So I prefer, if you update the
> documentation :-)

No problem, my asciidoc is a bit rusty, but I think
the formatted result will be fine.

(Btw, list convention here is to reply-to-all;
 it prevents vger from being a single-point-of-failure)

-------8<-------
Subject: [PATCH] git-svn: document useLogAuthor and addAuthorFrom config keys

We've always supported these config keys in git-svn,
so document them so users won't have to respecify them
on every invocation.

Reported-by: Juergen Kosel <juergen.kosel@gmx.de>
Signed-off-by: Eric Wong <e@80x24.org>
---
 Documentation/git-svn.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 5f9e65b0c..9bee9b0c4 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -664,13 +664,19 @@ creating the branch or tag.
 	When retrieving svn commits into Git (as part of 'fetch', 'rebase', or
 	'dcommit' operations), look for the first `From:` or `Signed-off-by:` line
 	in the log message and use that as the author string.
++
+[verse]
+config key: svn.useLogAuthor
+
 --add-author-from::
 	When committing to svn from Git (as part of 'commit-diff', 'set-tree' or 'dcommit'
 	operations), if the existing log message doesn't already have a
 	`From:` or `Signed-off-by:` line, append a `From:` line based on the
 	Git commit's author string.  If you use this, then `--use-log-author`
 	will retrieve a valid author string for all commits.
-
++
+[verse]
+config key: svn.addAuthorFrom
 
 ADVANCED OPTIONS
 ----------------
-- 
EW
