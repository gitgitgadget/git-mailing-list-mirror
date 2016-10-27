Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717302022A
	for <e@80x24.org>; Thu, 27 Oct 2016 06:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933811AbcJ0GYq (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 02:24:46 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:41870
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933502AbcJ0GYp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Oct 2016 02:24:45 -0400
X-Greylist: delayed 6612 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Oct 2016 02:24:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1477541608;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=xNt9TA7Anwgdx79T+67EadTC3lmVWSRYU9PhjLQbqjI=;
        b=cY4tbIaiEgZ18SDO/eurG3SgiGG3P8rK5kQtU/YdijmJIIEQMR1gfDP/fSBIzVEM
        sZ/h6NEnc70vdjmw4okgvfMHw24rke9YMh/WmRzBs9t/doDHE3r/OjZpklMi1BL+g0C
        XU+VKgE5KlmjwBOaZNDZWKiRzcONGSXL2l4O4+yI=
From:   Cody Sehl <cody.sehl@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201580457bdd2-99237b54-5e36-4430-bb8d-7e9088aed522-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Update git rebase documentation to clarify HEAD behavior
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Oct 2016 04:13:28 +0000
X-SES-Outgoing: 2016.10.27-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first few paragraphs in the git-rebase.txt documentation lay out the steps git takes during a rebase:
1. everything from `<upstream>..HEAD` is saved to a temporary area
2. `HEAD` is set to `<upstream>`
3. the changes held in the temporary area are applied one by one in order on top of the new `HEAD`

The second step was described using the phrase `The current branch is reset to <upstream>`, which is true (because `HEAD` == current branch), but not clear.
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index de222c8..c47ca11 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -33,7 +33,7 @@ of commits that would be shown by `git log <upstream>..HEAD`; or by
 description on `--fork-point` below); or by `git log HEAD`, if the
 `--root` option is specified.
 
-The current branch is reset to <upstream>, or <newbase> if the
+HEAD is reset to <upstream>, or <newbase> if the
 --onto option was supplied.  This has the exact same effect as
 `git reset --hard <upstream>` (or <newbase>).  ORIG_HEAD is set
 to point at the tip of the branch before the reset.

--
https://github.com/git/git/pull/301
