Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DAA61F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 22:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeJKFvO (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:51:14 -0400
Received: from newman.cs.utexas.edu ([128.83.139.110]:50603 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKFvO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:51:14 -0400
Received: from vyasa.cs.utexas.edu (vyasa.cs.utexas.edu [128.83.130.99])
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id w9AMQvur034698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Oct 2018 17:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
        s=default; t=1539210419;
        bh=J+QaBRIl+VZkbUlQ1oVKg9a95ECPuHM8FMiB1d709LQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4Ib0h3gA1p3Oq23AMHYAZlnHlaIgBnHx7AOyZtexHsvetiP0noZv04XifNEDmFm0
         +4sYVJH3Mv2zIO7CU2Zmjq7AHmT/R1h9AFoCEyBSjjvNNNR3gx2sNjy+hIB/MuguUu
         wjsDS+ymDeqVF8i6uGsZ8a6ivrCAcjD5HmYQHpDc=
Received: (from mihir@localhost)
        by vyasa.cs.utexas.edu (8.15.2/8.15.2/Submit) id w9AMQvuF019912;
        Wed, 10 Oct 2018 17:26:57 -0500
From:   Mihir Mehta <mihir@cs.utexas.edu>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Mihir Mehta <mihir@cs.utexas.edu>
Subject: [PATCH] doc: fix a typo and clarify a sentence
Date:   Wed, 10 Oct 2018 17:26:54 -0500
Message-Id: <20181010222654.19871-1-mihir@cs.utexas.edu>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <xmqq36tdla1a.fsf@gitster-ct.c.googlers.com>
References: <xmqq36tdla1a.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.9 (newman.cs.utexas.edu [128.83.139.110]); Wed, 10 Oct 2018 17:26:59 -0500 (CDT)
X-Virus-Scanned: clamav-milter 0.98.7 at newman
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that git-merge-base was unlikely to actually be a git command,
and tried it in my shell. Seeing that it doesn't work, I cleaned up two
places in the docs where it appears.

Signed-off-by: Mihir Mehta <mihir@cs.utexas.edu>
---
 Documentation/git-diff.txt                  | 4 ++--
 Documentation/howto/update-hook-example.txt | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index b180f1fa5..030f162f3 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -72,10 +72,10 @@ two blob objects, or changes between two files on disk.
 	This form is to view the changes on the branch containing
 	and up to the second <commit>, starting at a common ancestor
 	of both <commit>.  "git diff A\...B" is equivalent to
-	"git diff $(git-merge-base A B) B".  You can omit any one
+	"git diff $(git merge-base A B) B".  You can omit any one
 	of <commit>, which has the same effect as using HEAD instead.
 
-Just in case if you are doing something exotic, it should be
+Just in case you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
 in the last two forms that use ".." notations, can be any
 <tree>.
diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.txt
index a5193b1e5..89821ec74 100644
--- a/Documentation/howto/update-hook-example.txt
+++ b/Documentation/howto/update-hook-example.txt
@@ -80,7 +80,7 @@ case "$1" in
       info "The branch '$1' is new..."
     else
       # updating -- make sure it is a fast-forward
-      mb=$(git-merge-base "$2" "$3")
+      mb=$(git merge-base "$2" "$3")
       case "$mb,$2" in
         "$2,$mb") info "Update is fast-forward" ;;
 	*)	  noff=y; info "This is not a fast-forward update.";;
-- 
2.19.0

