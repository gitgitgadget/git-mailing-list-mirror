Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071D9C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 09:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94EDD208B3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 09:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgKFJMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 04:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgKFJMp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 04:12:45 -0500
X-Greylist: delayed 478 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Nov 2020 01:12:45 PST
Received: from black.spass-am-geraet.de (black.spass-am-geraet.de [IPv6:2a01:4f8:210:2018::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA76C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 01:12:45 -0800 (PST)
Received: by black.spass-am-geraet.de (Postfix, from userid 602)
        id 42B902390B; Fri,  6 Nov 2020 10:04:43 +0100 (CET)
Date:   Fri, 6 Nov 2020 10:04:43 +0100
From:   Daniel =?iso-8859-1?Q?H=F6pfl?= <daniel@hoepfl.de>
To:     git@vger.kernel.org
Subject: Suppressing filter-branch warning
Message-ID: <20201106090443.GA20407@black.spass-am-geraet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

What did you do before the bug happened? (Steps to reproduce your issue)
git filter-branch -f --env-filter '' --tag-name-filter cat -- HEAD

What did you expect to happen? (Expected behavior)
See below (difference).

What happened instead? (Actual behavior)
When using git filter-branch, the following message is shown:

----------8<-----------------------------------------------------
WARNING: git-filter-branch has a glut of gotchas generating mangled history
         rewrites.  Hit Ctrl-C before proceeding to abort, then use an
         alternative filtering tool such as 'git filter-repo'
         (https://github.com/newren/git-filter-repo/) instead.  See the
         filter-branch manual page for more details; to squelch this warning,
         set FILTER_BRANCH_SQUELCH_WARNING=1.
----------8<-----------------------------------------------------

You can suppress this by setting the environment variable shown.

What's different between what you expected and what actually happened?

Normally, when git introduces this kind of change, there is a
git config variable that one can set to suppress it.
That way one has fine grade control when to suppress it (one repo only...globally).

Anything else you want to add:

-/-

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.29.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 4.19.0-10-amd64 #1 SMP Debian 4.19.132-1 (2020-07-24) x86_64
compiler info: gnuc: 8.3
libc info: glibc: 2.28
$SHELL (typically, interactive shell): /bin/bash

