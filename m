Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1024F202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 20:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750990AbdGHUju (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 16:39:50 -0400
Received: from mail.eclipso.de ([217.69.254.104]:48794 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750910AbdGHUjt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 16:39:49 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Jul 2017 16:39:49 EDT
Received: from localhost.localdomain (136.ip-92-222-84.eu [92.222.84.136])
        by mail.eclipso.de with ESMTPS id 200DF4C2
        for <git@vger.kernel.org>; Sat, 08 Jul 2017 22:34:43 +0200 (CEST)
X-ESMTP-Authenticated-User: 00022B69
From:   astian <astian@eclipso.at>
To:     git@vger.kernel.org
Cc:     astian <astian@eclipso.at>
Subject: [PATCH 0/4] Misc. documentation fixes
Date:   Sat,  8 Jul 2017 20:34:09 +0000
Message-Id: <20170708203413.16442-1-astian@eclipso.at>
X-Mailer: git-send-email 2.13.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I was looking into adding a new option to git-send-email (and I may
later send the patches implementing that) but as I looked over the code
and associated documentation I found a few places where I thought
improvement could be made.  So here are some documentation fixes and
clarifications that you might find useful.

They apply cleanly on top of commit 8b2efe2a0 (Fifteenth batch for 2.14).

Note 1: even though I'm sending them as a "series", all of these are in
fact independent of each other.

Note 2: see below for a couple of patch-specific comments.

astian (4):
  Doc/config.txt: explain repeated sections
  Doc/config.txt: fix typos
  Doc/git-send-email.txt: clarify a couple of options

    Still to fix:
      --smtp-encryption:
        The current nomenclarure is braindamaged: what's currently
        called "ssl" should be called "tls", what's currently called
        "tls" should be called "starttls".

      --smtp-server-option:
        IMO the option is wrongly named: this option only works with a
        local sendmail-like binary.  When talking to that program, SMTP
        is not used.

  Doc/config.txt: fix documentation for smtpEncryption

    I don't know what's the story behind this, but IMO having
    "smtpEncryption" configurable from "sendemail.<identity>"
    subsections is useful and should be preserved.

    For example, one can set "ssl" (meaning TLS) as global configuration
    (under "sendemail"), but set it to "none" (that is, plain text) for
    a particular identity that actually connects to an i2p or onion
    server, i.e. through an already encrypted transport.

 Documentation/config.txt         |  5 +----
 Documentation/git-send-email.txt | 15 +++++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.13.2



