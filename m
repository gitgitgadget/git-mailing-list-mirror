Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E31D1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 01:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbfJYBdB (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 21:33:01 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:38815 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfJYBdA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 21:33:00 -0400
Received: from localhost.localdomain (unknown [1.186.12.46])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0B6A2100002
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 01:32:57 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Subject: [PATCH 0/1] git-gui: remove unused global declarations
Date:   Fri, 25 Oct 2019 07:02:54 +0530
Message-Id: <20191025013255.7367-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A lot of places have unused global variables declared. Remove them.

It started as a couple of quick fixes and ended up in me writing an ugly
hacky script to catch all the instances of unused global declarations.
Lot more than I expected.

The script can be found at [0]. The script at [0] will only catch the
unused globals in 'proc's. But git-gui also has 'method's and
'constructor's. Just change '^proc' to '^constructor' or '^method'.

I manually checked each instance before removing just to be sure I'm not
doing something wrong. Still, a bit of testing would be appreciated.
Just apply this patch and go on about your business as usual. There
_should_ be no change in the behaviour. I tested some basic functions
like commit, push, etc, and they work fine for me.

[0] https://gist.github.com/prati0100/0f3ef903ad1658e76ea0b95f001b4865

Pratyush Yadav (1):
  git-gui: remove unused global declarations

 git-gui.sh                | 12 ++++--------
 lib/about.tcl             |  2 +-
 lib/blame.tcl             |  3 +--
 lib/branch_checkout.tcl   |  2 +-
 lib/branch_create.tcl     |  1 -
 lib/branch_delete.tcl     |  2 +-
 lib/browser.tcl           |  2 +-
 lib/checkout_op.tcl       |  4 +---
 lib/choose_font.tcl       |  2 +-
 lib/choose_repository.tcl |  6 +++---
 lib/class.tcl             |  1 -
 lib/commit.tcl            | 10 +++-------
 lib/console.tcl           |  2 +-
 lib/database.tcl          |  2 +-
 lib/diff.tcl              | 21 +++++++--------------
 lib/error.tcl             |  2 +-
 lib/index.tcl             |  9 ++++-----
 lib/line.tcl              |  2 +-
 lib/merge.tcl             |  5 ++---
 lib/mergetool.tcl         | 10 +++++-----
 lib/remote_add.tcl        |  5 ++---
 lib/search.tcl            |  4 ++--
 lib/sshkey.tcl            |  2 +-
 lib/tools_dlg.tcl         |  6 +++---
 24 files changed, 47 insertions(+), 70 deletions(-)

--
2.21.0

