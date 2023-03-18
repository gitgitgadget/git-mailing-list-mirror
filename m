Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD86BC7618E
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 19:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCRTV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Mar 2023 15:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCRTV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2023 15:21:27 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7777687
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 12:21:26 -0700 (PDT)
Date:   Sat, 18 Mar 2023 19:21:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679167279; x=1679426479;
        bh=KFWLl2etjabzEFnhxNAC+9KEVSkJgcnwM9pnIyULZss=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=bROuLi4d1nvo5sFfTUyEFuCT3puU0w98mvi6IAZI0S3DExz/2W+H6VLGBV2NURV03
         iO5hzColn2fCdt4oQYscwtXAICGJJpeqpVZMgmLzj4T/44JRmXxPHJ/waK2n193o9F
         OH/7SMOGTl39a5NGyYKmIPQZmVRJDf9kBG8wgo74r2PGYQLHF+UfozR1aL62PnvT6F
         HmDyNt7HEbliefeAVoofT3XxTN2HjLdwMpfooUcb841gIZCKX1gpdvev+FDFhdja6F
         4j660KK4U7IUrycaYQtdJBN6M9J/uPS2b+ABlcHk9Z9SN8jTFHcs6G+Ow1Pt7UBJ7k
         00VnCeaYgR6XQ==
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   dooagain <dooagain@protonmail.com>
Subject: Bug: git pull output and case sensitivity.
Message-ID: <-Va6f9aA736sZCXChvTLaUUSpAq9-ooSELLBrqRSXR5zAQwT7QSRryN1SGBWQj7J_KowBmZuhDHwIwAkrFFfyelwtkXJ-ri4yLPpmDpBqBU=@protonmail.com>
Feedback-ID: 5666827:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I configured my git repository to ignore case by executing `git config core=
.ignorecase true` then I executed `git pull` multiple times.

What did you expect to happen? (Expected behavior)

I expected the output of `git pull` to accurately tell me about new branche=
s.

What happened instead? (Actual behavior)

The output from `git pull` repeatedly claims that remote branches that diff=
er in casing only to my local ref are always considered "new" even when the=
y exist locally and are in sync with the remote branch.

What's different between what you expected and what actually happened?

Here is one example from the output from `git pull`:

* [new branch]              bug/#30k8z31/fixing_affordable_merge_fields -> =
origin/bug/#30k8z31/fixing_affordable_merge_fields

This is my local ref file:

.git/refs/remotes/origin/Bug/#30k8z31/fixing_affordable_merge_fields

The contents of my local ref is the same commit hash as the remote branch.

Anything else you want to add:

To me this seems like `git pull` is working as expected, but the output see=
ms incorrect.
This is problematic, because in the current repository there are hundreds o=
f branches that generate this output
so when `git pull` actually does have a problem it is very easy to miss.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.40.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Wed Aug 10 14:28:23 PDT =
2022; root:xnu-8020.141.5~2/RELEASE_ARM64_T6000 arm64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /opt/homebrew/bin/bash


[Enabled Hooks]
