Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827F6C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E83C610CB
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 12:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhDKMzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 08:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbhDKMzB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 08:55:01 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A05DC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 05:54:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1618145683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3BceZWtAxn0nIUzB8PHjo0qqSzQFcCCfK9Fx3Wcu/Ys=;
        b=YTFbVGl2zGnNMxBBb9NqYJpQJ36/q7ms+i8BcFd/54CVJHEkUeXWNbY7wUOvguCi+q7s9j
        zyW8t8Imsvk/iJAKTShSaJJoS3l6fc7uMURTjLaZzAADEY4rmqcs5jUqC0EEgRCshiy6Jh
        ukHuCq7666L2pQKz4agySuzuqP+KYSKuzbjDIIAiCoLuaz/pSAcDHn9sOZwW7AB9RGYw/u
        AyfBx3cL1uDX2swmqT6XDvty13R7YSnghJj7/Gg0tsoxxbmWT3n3r0wFFjWhOMMxOa/s49
        9I9UI8Xi7fKW2GO9vP26x6f66BMePeS7kB+osStht0CgpO9fBoz0SYea2YQ2MA==
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH v2 0/3] git-send-email: improve SSL configuration
Date:   Sun, 11 Apr 2021 08:54:28 -0400
Message-Id: <20210411125431.28971-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following feedback on v1, this splits the changes up into 3 commits,
including a new change which makes any value other than 'ssl',
'starttls', or nothing into an error. This also removes 'ssl/tls' in
favor of 'ssl' to avoid confusion, and avoids taking a stance on the
matter of the deprecation of either approach.

Drew DeVault (3):
  git-send-email(1): improve smtp-encryption docs
  git-send-email: die on invalid smtp_encryption
  git-send-email: rename 'tls' to 'starttls'

 Documentation/git-send-email.txt | 9 +++++++--
 git-send-email.perl              | 9 ++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.31.1

