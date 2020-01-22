Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ABCC32771
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 03:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502BD21835
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 03:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oB6UtxQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAVDpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:45:53 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44104 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727141AbgAVDpx (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Jan 2020 22:45:53 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7067A6044F;
        Wed, 22 Jan 2020 03:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579664751;
        bh=1lb2heRWLO8V3aD4p3E19TyPGymiczgy66rsWg5I7IE=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oB6UtxQvAu2w00cxtSRBYuHzRNiuJ2gQsnpvoqxG+On0FR79zSGDHAu3axAkNwd/X
         LslbpVr59Cz3wcXNWcJa61FoEOtFwlUYilngyYO040JheFa1hnp0fr/AFhhTI0LS9a
         6YpyGKmEOBWnhTBQ7b12eUryYXveqGkL7dWyaPy3fuuNVEZXCCRq6KBHKTD3IROEgy
         PXepwwnM9RZYsgkpAQoduPCJ9hcUfkD/WO6P8TxYjfcpefeKynD3yo8ozcqHVp891G
         U9l/EsPrdHv8Mz0hfH8lI4iuDUAE507Ycys2jF1vTVQboWBwto1Giq6/wwhX5F09Q+
         BpwmbdKP+Txwzz9GDJ5se9Pa3GA+UpGBLvkAG+cBrWdL1HZdWfR0M7oZbheiI95R0f
         2RKfHeJkQPSu3AbaPrPeAJD2o3Igh0NHfIRAWDFYNHsIGPe9W+v2QZFNl6knYBTJ6h
         Xlcxvrv5lYxgV9o7yx5mpA26Hd0o+EEvC4D2UieA3HmvDojRHX1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 0/5] Documentation for common user misconceptions
Date:   Wed, 22 Jan 2020 03:45:38 +0000
Message-Id: <20200122034543.18927-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v5 of a series improving the documentation to cover common user
misconceptions.

Changes from v4:
* Add a reference to git(1) for environment variables.
* Remove duplicated text.
* Add Peff's sign-off.

Changes from v3:
* Restructure docs around git-commit(1).
* Improve wording about templating as suggested by Peff.
* Document ordering between user.*, author.*, and committer.*.
* Document the environment variables more thoroughly.

Changes from v2:
* Move author and committer information to git-commit(1) where people
  will look for it.
* Move guidance on user.name format to git-commit(1) as well and mention
  a shortened form of the advice in the `user.name` description.
* Use a parenthetical to describe a "personal name" without contrasting
  it with a username.
* Offer a potential solution for people who want to ignore tracked
  files by recommending a templating mechanism.
* Be slightly more verbose about why memory is wasted with
  http.postBuffer.

Changes from v1:
* Remove parenthetical which was confusing.
* Add two more patches.

brian m. carlson (5):
  doc: move author and committer information to git-commit(1)
  docs: expand on possible and recommended user config options
  doc: provide guidance on user.name format
  doc: dissuade users from trying to ignore tracked files
  docs: mention when increasing http.postBuffer is valuable

 Documentation/config/http.txt      |  8 ++++++
 Documentation/config/user.txt      |  7 +++++-
 Documentation/git-commit-tree.txt  | 22 +---------------
 Documentation/git-commit.txt       | 40 +++++++++++++++++++++++++++---
 Documentation/git-update-index.txt | 16 ++++++++++++
 Documentation/git.txt              | 27 ++++++++++++++++++--
 6 files changed, 93 insertions(+), 27 deletions(-)

Range-diff against v4:
1:  0433792871 ! 1:  fe2dcea128 doc: move author and committer information to git-commit(1)
    @@ Documentation/config/user.txt: committer.email::
      	Instruct Git to avoid trying to guess defaults for `user.email`
     
      ## Documentation/git-commit-tree.txt ##
    -@@ Documentation/git-commit-tree.txt: tend to just write the result to the file that is pointed at by
    - `.git/HEAD`, so that we can always see what the last committed
    - state was.
    - 
    -+A commit comment is read from stdin. If a changelog
    -+entry is not provided via "<" redirection, 'git commit-tree' will just wait
    -+for one to be entered and terminated with ^D.
    -+
    - OPTIONS
    - -------
    - <tree>::
     @@ Documentation/git-commit-tree.txt: OPTIONS
      	Do not GPG-sign commit, to countermand a `--gpg-sign` option
      	given earlier on the command line.
2:  8745faf560 = 2:  8d4940efab docs: expand on possible and recommended user config options
3:  277a151e2c ! 3:  a82522e479 doc: provide guidance on user.name format
    @@ Documentation/config/user.txt: committer.email::
     -	See linkgit:git-commit[1] for more information.
     ++
     +Note that the `name` forms of these variables conventionally refer to
    -+some form of a personal name.
    -+See linkgit:git-commit[1] for more information on these settings and
    -+the `credential.username` option if you're looking for authentication
    -+credentials instead.
    ++some form of a personal name.  See linkgit:git-commit[1] and the
    ++environment variables section of linkgit:git[1] for more information on
    ++these settings and the `credential.username` option if you're looking
    ++for authentication credentials instead.
      
      user.useConfigOnly::
      	Instruct Git to avoid trying to guess defaults for `user.email`
4:  6b593861b5 ! 4:  1c95dec93e doc: dissuade users from trying to ignore tracked files
    @@ Commit message
         common case of configuration files, since there are well-known
         approaches used successfully in many environments.
     
    +    Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## Documentation/git-update-index.txt ##
5:  960c80eda3 = 5:  51335b1a49 docs: mention when increasing http.postBuffer is valuable
