Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6174DC35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 13:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338432072C
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 13:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgBINcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 08:32:20 -0500
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:39200 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727631AbgBINcU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Feb 2020 08:32:20 -0500
Received: from MTA-07-4.privateemail.com (mta-07.privateemail.com [198.54.127.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 37C90800D0
        for <git@vger.kernel.org>; Sun,  9 Feb 2020 08:19:24 -0500 (EST)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
        by MTA-07.privateemail.com (Postfix) with ESMTP id EA7FA60043;
        Sun,  9 Feb 2020 08:19:22 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.209])
        by MTA-07.privateemail.com (Postfix) with ESMTPA id 0C98860034;
        Sun,  9 Feb 2020 13:19:21 +0000 (UTC)
From:   "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
To:     git@vger.kernel.org
Cc:     "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Subject: [RFC PATCH 0/3] git-merge: update default commit message
Date:   Sun,  9 Feb 2020 16:16:20 +0300
Message-Id: <20200209131623.5827-1-darktemplar@dark-templar-archives.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patches updates default commit message for git-merge command.

First patch adds alternative commit message formatting where
each merged object is printed on new line and adds configuration option to enable it.

New format may look good for merges with a lot of objects, but
for merge with just one object old format may still look better.
To be able to use both formats, new format type 'autoselect' is added
in patch 2, and configuration option for format selection is reworked.

Patch 3 changes default message formatting to 'autoselect' introduced
in patch 2, thus changing default behaviour of git.

i.Dark_Templar (3):
  git-merge: add option to format default message using multiple lines
  Add merge commit message type autoselect logic
  Enable merge commit message type autoselect logic by default

 Documentation/config/fmt-merge-msg.txt |  13 +++
 builtin/fmt-merge-msg.c                | 127 ++++++++++++++++++++++++-
 2 files changed, 138 insertions(+), 2 deletions(-)

--
2.24.1

