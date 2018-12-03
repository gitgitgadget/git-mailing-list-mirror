Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BD1D211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 17:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeLCRe7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 12:34:59 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:58590 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeLCRe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 12:34:59 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 437sZM1Xwhz5tlV
        for <git@vger.kernel.org>; Mon,  3 Dec 2018 18:34:51 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3278612DF
        for <git@vger.kernel.org>; Mon,  3 Dec 2018 18:34:50 +0100 (CET)
To:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] rebase docs: fix incorrect format of the section Behavioral
 Differences
Message-ID: <f26b53e3-e7d1-f0fe-cdd3-dd734beb1628@kdbg.org>
Date:   Mon, 3 Dec 2018 18:34:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The text body of section Behavioral Differences is typeset as code,
but should be regular text. Remove the indentation to achieve that.

While here, prettify the language:

- use "the x backend" instead of "x-based rebase";
- use present tense instead of future tense;

and use subsections instead of a list.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Cf. https://git-scm.com/docs/git-rebase#_behavioral_differences

I actually did not test the result, because I don't have the
infrastructure.

The sentence "The am backend sometimes does not" is not very useful,
but is not my fault ;) It would be great if it could be made more
specific, but I do not know the details.

 Documentation/git-rebase.txt | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 80793bad8d..dff17b3178 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -550,24 +550,28 @@ Other incompatible flag pairs:
 BEHAVIORAL DIFFERENCES
 -----------------------
 
- * empty commits:
+There are some subtle differences how the backends behave.
 
-    am-based rebase will drop any "empty" commits, whether the
-    commit started empty (had no changes relative to its parent to
-    start with) or ended empty (all changes were already applied
-    upstream in other commits).
+Empty commits
+~~~~~~~~~~~~~
+
+The am backend drops any "empty" commits, regardless of whether the
+commit started empty (had no changes relative to its parent to
+start with) or ended empty (all changes were already applied
+upstream in other commits).
 
-    merge-based rebase does the same.
+The merge backend does the same.
 
-    interactive-based rebase will by default drop commits that
-    started empty and halt if it hits a commit that ended up empty.
-    The `--keep-empty` option exists for interactive rebases to allow
-    it to keep commits that started empty.
+The interactive backend drops commits by default that
+started empty and halts if it hits a commit that ended up empty.
+The `--keep-empty` option exists for the interactive backend to allow
+it to keep commits that started empty.
 
-  * directory rename detection:
+Directory rename detection
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-    merge-based and interactive-based rebases work fine with
-    directory rename detection.  am-based rebases sometimes do not.
+The merge and interactive backends work fine with
+directory rename detection.  The am backend sometimes does not.
 
 include::merge-strategies.txt[]
 
-- 
2.19.1.1133.g2dd3d172d2
