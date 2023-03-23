Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B54C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjCWQrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjCWQrE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:04 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CCACC26
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:32 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id C327C2422C
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhz-Azv-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:35 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH 0/8] sequencer refactoring
Date:   Thu, 23 Mar 2023 17:22:27 +0100
Message-Id: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a preparatory series for the separately posted 'rebase --rewind' patch,
but I think it has value in itself.


Oswald Buddenhagen (8):
  rebase: simplify code related to imply_merge()
  rebase: move parse_opt_keep_empty() down
  sequencer: pass around rebase action explicitly
  sequencer: create enum for edit_todo_list() return value
  rebase: preserve interactive todo file on checkout failure
  sequencer: simplify allocation of result array in
    todo_list_rearrange_squash()
  sequencer: pass `onto` to complete_action() as object-id
  rebase: improve resumption from incorrect initial todo list

 builtin/rebase.c              |  63 +++++++--------
 builtin/revert.c              |   3 +-
 rebase-interactive.c          |  36 ++++-----
 rebase-interactive.h          |  27 ++++++-
 sequencer.c                   | 139 +++++++++++++++++++---------------
 sequencer.h                   |  15 ++--
 t/t3404-rebase-interactive.sh |  34 ++++++++-
 7 files changed, 196 insertions(+), 121 deletions(-)

-- 
2.40.0.152.g15d061e6df

