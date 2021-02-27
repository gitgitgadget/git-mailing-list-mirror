Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA087C433DB
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 19:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC8C64E4B
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 19:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhB0TXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 14:23:05 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58976 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230351AbhB0TU6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 Feb 2021 14:20:58 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2DA4E60DF8;
        Sat, 27 Feb 2021 19:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1614453575;
        bh=DnrvJ7AZdwIF0zB28lpZFqg6f6QOcLye/o2yFnVTHgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=XT9m6F0pbdfyx+NgRWRvXdDOLLG9WuneYRJYMkv0A+C7Mte5gthUCCcsrKeA5vkLE
         KyiLjcDgQXBsGAqlJA4IH4A/BHJR2pv6MmnfZGS3+bXwlBB5DkqFhFyQkNwVQvILOM
         vTCX27dvVkb77y4AeLk8jLuHUXp6202eXkeWtY+oYUp9/rk/bvdh5qf5sxXpCv2sV/
         tByPBDh41JwAHO+F23R+R2XhDOP6k4osRHXYNYRxXErdIBhLupjiH4Bvfh8QT5nu6A
         G/mcU6kZJET6HHfRA7Cy7twDNjwgr86JumtbU0ToUYqXch7LuB5g0VxbMQCLNrujEq
         qWH5afiDOHUOLYNYGmTLM7Nh5NSAqIJk+JQjNNEwh47Y/5wU5jjRjOFCfaH4maSojF
         /ez3H37cjzXRCWCuUxjRnP/IXPgDwY4cGAKkQMS6z/agg40TrmD0kfdaGau8+nVjxL
         zAQrZ7aQYTrjf+UeEVyZI8VY4NEFn8C1nqK0bEAH4Wyjkz8iZnw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/4] docs: note that archives are not stable
Date:   Sat, 27 Feb 2021 19:18:13 +0000
Message-Id: <20210227191813.96148-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.1.721.g45526154a5
In-Reply-To: <20210227191813.96148-1-sandals@crustytoothpaste.net>
References: <20210227191813.96148-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have in the past told users on the list that git archive does not
necessarily produce stable archives, but we've never explicitly
documented this.  Unfortunately, we've had people in the past who have
relied on the relative stability of our archives to their detriment and
then had breakage occur.

Let's tell people that we don't guarantee stable archives so that they
can make good choices about how they structure their tooling and don't
end up with problems if we need to change archives later.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-archive.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 9f8172828d..1f126cbdcc 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -30,6 +30,9 @@ extended pax header if the tar format is used; it can be extracted
 using 'git get-tar-commit-id'. In ZIP files it is stored as a file
 comment.
 
+The output of 'git archive' is not guaranteed to be stable and may change
+between versions.
+
 OPTIONS
 -------
 
