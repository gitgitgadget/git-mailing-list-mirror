Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814F31F576
	for <e@80x24.org>; Mon, 19 Feb 2018 11:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeBSLgb (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 06:36:31 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:62922 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752528AbeBSLga (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 06:36:30 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id njk7e9rCnoNnDnjkDeU6Ok; Mon, 19 Feb 2018 11:36:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519040189;
        bh=CN9PgWn1By9vBKvg3BBiE2g3wz+Wc1XGiQWJmpmNBYU=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=BNWg9fvXua7mK57uxbFluESoKLJyX0b42BVdl0dlmovAShzXaJvZbDT8AIW7GvHbb
         Z53p63NqCWN94wO3bOohtZ8V0v5feSHJxFs7h94EIFQUOxP2ArO1u0Po5BqTEMCyQj
         mbZ4aZ1luvdtxU6/t8Ud09s684iLwb8XKrHQgIlM=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=5rxgeBVgAAAA:8
 a=nN7BH9HXAAAA:8 a=tGVuKMeZVuHrdcQMkpMA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=RfR_gqz1fSpA9VikTjo0:22 a=PwKx63F5tFurRwaNxrlG:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 0/3] add -p: select individual hunk lines
Date:   Mon, 19 Feb 2018 11:36:16 +0000
Message-Id: <20180219113619.26566-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfCWcaYVGn3A1ox+5JbsQBoUEvA1MFOhzLAkG/6phJm6+iLTionWELXsSEdrvQgGQ72vAawYgd0Po7OqTxD9uK7H+/1WqM2SbU2GueRGg+DruETzS++3+
 OqFk5Oau0tQs0a5DccpSo6S5PHzK3JC52tfEpfE6wlG1fvtGy4jCEzrIrl/RNzGBMQndo6hJNBGeP5C/vHPwwhnCYUxs0R06rq86WUhZ7Zl9ONT8nq4GEat9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I need to update the add -i documentation but otherwise I think these
patches are OK so I thought I'd try and get some feedback. They build
on top of the recount fixes in [1]. The commit message for the first
patch describes the motivation:

"When I end up editing hunks it is almost always because I want to
stage a subset of the lines in the hunk. Doing this by editing the
hunk is inconvenient and error prone (especially so if the patch is
going to be reversed before being applied). Instead offer an option
for add -p to stage individual lines. When the user presses 'l' the
hunk is redrawn with labels by the insertions and deletions and they
are prompted to enter a list of the lines they wish to stage. Ranges
of lines may be specified using 'a-b' where either 'a' or 'b' may be
omitted to mean all lines from 'a' to the end of the hunk or all lines
from 1 upto and including 'b'."

[1] https://public-inbox.org/git/20180219112910.24471-1-phillip.wood@talktalk.net/T/#u

Phillip Wood (3):
  add -p: select individual hunk lines
  add -p: allow line selection to be inverted
  add -p: optimize line selection for short hunks

 git-add--interactive.perl  | 179 +++++++++++++++++++++++++++++++++++++++++++++
 t/t3701-add-interactive.sh |  63 ++++++++++++++++
 2 files changed, 242 insertions(+)

-- 
2.16.1

