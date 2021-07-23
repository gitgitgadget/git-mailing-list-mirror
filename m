Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDF1C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2D360EB4
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhGWQqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhGWQqD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:46:03 -0400
X-Greylist: delayed 356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jul 2021 10:26:36 PDT
Received: from forward102o.mail.yandex.net (forward102o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9576EC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:26:36 -0700 (PDT)
Received: from sas1-a0dbea86c90a.qloud-c.yandex.net (sas1-a0dbea86c90a.qloud-c.yandex.net [IPv6:2a02:6b8:c08:3698:0:640:a0db:ea86])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id 187A566801B2
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 20:20:37 +0300 (MSK)
Received: from sas2-1cbd504aaa99.qloud-c.yandex.net (sas2-1cbd504aaa99.qloud-c.yandex.net [2a02:6b8:c14:7101:0:640:1cbd:504a])
        by sas1-a0dbea86c90a.qloud-c.yandex.net (mxback/Yandex) with ESMTP id VqOa9EK05R-KaHuK3Rm;
        Fri, 23 Jul 2021 20:20:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brighterdan.com; s=mail;
        t=1627060837; bh=gb/yo0+ArE061Y4ibEtMMEN5THVN4167/33NK42v/tk=;
        h=Date:Message-ID:Subject:From:To;
        b=KwBv9XkYaZyYA5qMl640E+0rPHnFFhnd5LXmT/MMsarIPHgr+b91dv8rX+HJ0Avxu
         7h/kdVv1oPxbhhm3Jio1q/yUAuCyUmiczIH2sBtWQmA+1i7kqdWHzmnoLtWIWRHLG5
         /kztpbk//idIBMewOxIwzvb+gI+eph74gzr5oDRA=
Authentication-Results: sas1-a0dbea86c90a.qloud-c.yandex.net; dkim=pass header.i=@brighterdan.com
Received: by sas2-1cbd504aaa99.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 4N7wnk27fv-Ka2CjliG;
        Fri, 23 Jul 2021 20:20:36 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     git@vger.kernel.org
From:   Daniel Santos <hello@brighterdan.com>
Subject: Git show only showing ASCII chars problem
Message-ID: <924b70af-1e55-0944-0f45-ab28cff1e98d@brighterdan.com>
Date:   Fri, 23 Jul 2021 18:20:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git show

What did you expect to happen? (Expected behaviour)
Show non-ASCII characters

What happened instead? (Actual behaviour)
`show` does not show non-ASCII characters such as ç , ã , õ ...

What's different between what you expected and what actually happened?
I expect for `git show` to show all of my machine locale characters, 
such as ç , without any problem

Anything else you want to add:
I am on Arch Linux and I installed git using pacman. That is all.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.32.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.52-1-lts #1 SMP Tue, 20 Jul 2021 16:46:09 +0000 x86_64
compiler info: gnuc: 11.1
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
