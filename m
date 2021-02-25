Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221A3C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 15:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B3164E83
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 15:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBYPDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 10:03:10 -0500
Received: from gate3.osm-gmbh.de ([194.77.68.107]:41767 "EHLO
        gate3.osm-gmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhBYPC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 10:02:56 -0500
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2021 10:02:55 EST
Received: from mail.osm-gmbh.de (vmmail.osm-gmbh.de [193.101.76.128])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gate3.osm-gmbh.de (Postfix) with ESMTPS id EC0883C07F
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 15:54:27 +0100 (CET)
Received: from pcmn.osm-gmbh.de (pcmn.osm-gmbh.de [193.101.76.39])
        by mail.osm-gmbh.de (OSM Mailserver) with ESMTP id F01AC3DC01E
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 15:54:27 +0100 (CET)
Date:   Thu, 25 Feb 2021 15:54:27 +0100 (CET)
From:   Martin Nicolay <m.nicolay@osm-ag.de>
Sender: martin@pcmn.osm-gmbh.de
Reply-To: Martin Nicolay <m.nicolay@osm-ag.de>
To:     git@vger.kernel.org
Subject: bug: setting GIT_DIR to $(git rev-parse --git-dir) changes
 behavior
Message-ID: <alpine.LSU.2.20.2102251549330.20742@cpza.bfz-tzou.qr>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
X-Virus-Scanned: by "The Virus" itself
X-Mailer: Pine 4.63
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

$ env | grep GIT
$ git --version
git version 2.30.1
$ git init t
Initialized empty Git repository in /tmp/t/.git/
$ mkdir t/foo
$ cd t/foo
$ git rev-parse --show-toplevel
/tmp/t
$ GIT_DIR=$(git rev-parse --git-dir) git rev-parse --show-toplevel
/tmp/t/foo
$ git rev-parse --git-dir
/tmp/t/.git

What did you expect to happen? (Expected behavior)

"git rev-parse --show-toplevel" should be the same in both invocation.

What happened instead? (Actual behavior)

"git rev-parse --show-toplevel" shows the current working directory if GIT_DIR is set.

What's different between what you expected and what actually happened?

Setting GIT_DIR to $(git rev-parse --git-dir) should not change anything.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.30.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.3.18-22-default #1 SMP Wed Jun 3 12:16:43 UTC 2020 (720aeba) x86_64
compiler info: gnuc: 9.1
libc info: glibc: 2.26
$SHELL (typically, interactive shell): /opt/local/bin/bash


[Enabled Hooks]
