Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B86CC0044D
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49811206D5
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCOBrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:47:31 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:34598 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCOBrb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 21:47:31 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Mar 2020 21:47:30 EDT
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 1091E3A5DEA
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 22:42:03 +0000 (UTC)
X-Originating-IP: 103.227.98.14
Received: from localhost.localdomain (unknown [103.227.98.14])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 57887C0004;
        Sat, 14 Mar 2020 22:42:01 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Jonathan Gilbert <JonathanG@iQmetrix.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v1 0/2] git-gui: reduce Tcl version requirement from 8.6 to 8.5
Date:   Sun, 15 Mar 2020 04:11:57 +0530
Message-Id: <20200314224159.14174-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.26.0.rc1.11.g30e9940356
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Some MacOS distributions ship with Tcl 8.5. This means we can't use
TclOO. So, use our homegrown class.tcl instead.

While here, fix a potential variable name collision by creating a
separate namespace for a chord's script evaluation.

Jonathan,

Can you please test the patches the same way you tested your original
series just to be sure we don't break anything? A review would also be
nice.

Pratyush Yadav (2):
  git-gui: reduce Tcl version requirement from 8.6 to 8.5
  git-gui: create a new namespace for chord script evaluation

 git-gui.sh    |  4 ++--
 lib/chord.tcl | 56 +++++++++++++++++++++++++--------------------------
 lib/index.tcl | 10 +++++----
 3 files changed, 35 insertions(+), 35 deletions(-)

--
2.26.0.rc1.11.g30e9940356

