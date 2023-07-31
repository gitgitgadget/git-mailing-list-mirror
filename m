Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A1AC001DC
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 12:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjGaMP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 08:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGaMP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 08:15:27 -0400
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jul 2023 05:15:23 PDT
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830CA197
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 05:15:23 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3260E1F545
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 12:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1690805288;
        bh=8siEccvdSoHDPAummTPpX/jN+Iu1enh1BJ2AqpE/VYA=;
        h=From:To:Subject:Date:From;
        b=43zJsmhCXUaoxKxj8EEkB4NoZu8lDxSv3cRuCQ916voZah5tRnC+W/Lo3suJfqZ/d
         yLkpylOOXpMeG3+mcpJlc2NWwOmCqg+H2avaBr+s4qWdijaA/lcGeetI85PIp9f5wZ
         xM12kFn9e+WqaR3l7lnXhSkmhxRpmY9GZ4km3Zd4=
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] sha256/gcrypt fixes
Date:   Mon, 31 Jul 2023 12:08:05 +0000
Message-Id: <20230731120808.1230210-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed problems requiring patches 2 and 3 while eyeballing
the code, but had to come up with the first one to fix
SANITIZE=leak, first.

Eric Wong (3):
  sha256/gcrypt: fix build with SANITIZE=leak
  sha256/gcrypt: fix memory leak with SHA-256 repos
  sha256/gcrypt: die on gcry_md_open failures

 sha256/gcrypt.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)
