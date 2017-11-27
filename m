Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68D6920A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbdK0Ezh (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:55:37 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:36027 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdK0Ezg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 23:55:36 -0500
Received: by mail-io0-f196.google.com with SMTP id 79so27360574ioi.3
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 20:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WttPVby9Qfm6Ko7rS80+5zFVFxgS9Uxk/F2iz2ITM1Q=;
        b=cqeGjF4gtPt9nV10GAKCVS5EEAmQG0bLgZ0Kl37pN8VZ4Wgm7ixgkWpvNH6VwATugZ
         cwjq+62jjsS5H7M+n8Br/FGNdqLzjMmP/kVbNAN1GmB2uSubEieUdtextZz9hUqbeVTs
         QrqU0j0KitRu7i6nmBsHhqkxc0iCVYOZos6LKWKNPqg/sz8SrlCEWk0p3CPpX6oXDZPT
         9XPgslO7w4UDOqhUWfCSI8DKW/GztD0W5KAlAsweRNYqHDQ4Wqflyz/G+Xq9PYrrombn
         hEDfK0gNOFz3iksOr2aZz95AXgTCzsUM21sk/n0qW7KpqkQsjsGNpxXjMLQXfJk42iOg
         5TiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WttPVby9Qfm6Ko7rS80+5zFVFxgS9Uxk/F2iz2ITM1Q=;
        b=jb/04R996KGbZ5HPzi4ojFCZKRybava9REVsXse21qOZ9Xt3F1GnILffhv8J0jE41S
         lLm4O1IznnaTRVjOhuKfWCspHwXQIq2HIQ7bZiVRw8+vdI12aahOGgzk7S6pOcp69eMD
         o43lbatBXrMp6YswfZKJcwc7VzVSdAxUcu9/fCOMLA33VRJSpXkmPZSLQbC15eVFQIw2
         tFbCy6tMwj5P4pCNQxLbpECDEOyy4t1oMHhJEyZEJ/kZSsHk3Qi2BUWqOE0v5IKru+MI
         CuasvG26ywnNK2An4ZeXPFbZ9p5Xj/d94K6z4jnheYDfHfoKIJbiSXqhVCKWi3TiSUTu
         XZrw==
X-Gm-Message-State: AJaThX7lJYsZ8iCMXevWp70RM2l1jzVKUFJQLTanyng7uxHx9cjG1Mtl
        0M/OtsgV+AjYeGpBVTXei98LcHT+
X-Google-Smtp-Source: AGs4zMZd4wOUGCHJYqg1vSKqkFRluL9G3KuuSYcQ17HCdtULSchU6g66F+iui2Y6eyM6H6Hsg/P+uw==
X-Received: by 10.107.104.18 with SMTP id d18mr37575551ioc.136.1511758536002;
        Sun, 26 Nov 2017 20:55:36 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm4606305ioe.13.2017.11.26.20.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2017 20:55:35 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, avarab@gmail.com,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 0/5] rebase -i: add config to abbreviate command names
Date:   Sun, 26 Nov 2017 23:55:09 -0500
Message-Id: <20171127045514.25647-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.0.321.g19bf2bb99cee.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

This series is a respin of something [1] I sent a few months ago. This
time, instead of shell, It's based on top of the C implementation of the
interactive rebase. I've also tried to address the comments that were
left in the last thread.

This series will add the 'rebase.abbreviateCommands' configuration
option to allow `git rebase -i` to default to the single-letter command
names when generating the todo list.

Using single-letter command names can present two benefits. First, it
makes it easier to change the action since you only need to replace a
single character (i.e.: in vim "r<character>" instead of
"ciw<character>").  Second, using this with a large enough value of
'core.abbrev' enables the lines of the todo list to remain aligned
making the files easier to read.

Changes since last time:
- Implement abbreviateCommands in rebase--helper
- Add note on the --[no-]autosquash option in rebase.autoSquash
- Add exec commands via the rebase--helper
- Add test case for rebase.abbreviateCommands

Liam Beguin (5):
  Documentation: move rebase.* configs to new file
  Documentation: use preferred name for the 'todo list' script
  rebase -i: add exec commands via the rebase--helper
  rebase -i: learn to abbreviate command names
  t3404: add test case for abbreviated commands

 Documentation/config.txt        |  31 +------------
 Documentation/git-rebase.txt    |  19 +-------
 Documentation/rebase-config.txt |  51 ++++++++++++++++++++
 builtin/rebase--helper.c        |  17 +++++--
 git-rebase--interactive.sh      |  23 +--------
 sequencer.c                     | 100 ++++++++++++++++++++++++++++++++++------
 sequencer.h                     |   5 +-
 t/t3404-rebase-interactive.sh   |  32 +++++++++++++
 8 files changed, 186 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/rebase-config.txt

[1] https://public-inbox.org/git/20170502040048.9065-1-liambeguin@gmail.com/
--
2.15.0.321.g19bf2bb99cee.dirty

