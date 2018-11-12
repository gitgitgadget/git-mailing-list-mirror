Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E4DA1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 18:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbeKMExn (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 23:53:43 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:47804
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727530AbeKMExn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Nov 2018 23:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1542049151;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=2cceTBKbqoU6hkuN4eHan9oB77RBoZZ6RNel+2Z1Mf4=;
        b=W03pswB27hdPeQIm7iEkSgg7LVKM2wPN2yo/ShxcmWSF6d/zxn0ByeE8kpgSPH4l
        GzU5BxeIdQTMdDEGBS3lRlZodzHuQMVMBnIqEInf40DeGfZEpt8uQ3CsXDx47j4jXrl
        LwWk+JgPnCi/EQym9NXGeJskcBNKR8OhX++T5riY=
From:   Fredi Fowler <inredikawb@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020167094ab871-ca8d8728-0102-4d93-a4ff-d554b4aec59f-000000@eu-west-1.amazonses.com>
Subject: [RFC PATCH] Using no- for options instead of duplication
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Nov 2018 18:59:11 +0000
X-SES-Outgoing: 2018.11.12-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/merge-options.txt | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 63a3fc09548ab..fc1122ded51a0 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -1,5 +1,4 @@
---commit::
---no-commit::
+--[no-]commit::
 	Perform the merge and commit the result. This option can
 	be used to override --no-commit.
 +
@@ -7,9 +6,8 @@ With --no-commit perform the merge but pretend the merge
 failed and do not autocommit, to give the user a chance to
 inspect and further tweak the merge result before committing.
 
---edit::
 -e::
---no-edit::
+--[no-]edit::
 	Invoke an editor before committing successful mechanical merge to
 	further edit the auto-generated merge message, so that the user
 	can explain and justify the merge. The `--no-edit` option can be
@@ -58,8 +56,7 @@ set to `no` at the beginning of them.
 With --no-log do not list one-line descriptions from the
 actual commits being merged.
 
---signoff::
---no-signoff::
+--[no-]signoff::
 	Add Signed-off-by line by the committer at the end of the commit
 	log message.  The meaning of a signoff depends on the project,
 	but it typically certifies that committer has
@@ -69,17 +66,15 @@ actual commits being merged.
 +
 With --no-signoff do not add a Signed-off-by line.
 
---stat::
 -n::
---no-stat::
+--[no-]stat::
 	Show a diffstat at the end of the merge. The diffstat is also
 	controlled by the configuration option merge.stat.
 +
 With -n or --no-stat do not show a diffstat at the end of the
 merge.
 
---squash::
---no-squash::
+--[no-]squash::
 	Produce the working tree and index state as if a real merge
 	happened (except for the merge information), but do not actually
 	make a commit, move the `HEAD`, or record `$GIT_DIR/MERGE_HEAD`
@@ -112,8 +107,7 @@ option can be used to override --squash.
 	a trusted key.  If the tip commit of the side branch is not signed
 	with a valid key, the merge is aborted.
 
---summary::
---no-summary::
+--[no-]summary::
 	Synonyms to --stat and --no-stat; these are deprecated and will be
 	removed in the future.
 
@@ -126,8 +120,7 @@ ifndef::git-pull[]
 --verbose::
 	Be verbose.
 
---progress::
---no-progress::
+--[no-]progress::
 	Turn progress on/off explicitly. If neither is specified,
 	progress is shown if standard error is connected to a terminal.
 	Note that not all merge strategies may support progress

--
https://github.com/git/git/pull/553
