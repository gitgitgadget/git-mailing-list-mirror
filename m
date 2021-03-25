Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1B9C433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 16:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA31261A28
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 16:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhCYQ6I convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 25 Mar 2021 12:58:08 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60627 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhCYQ5r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 12:57:47 -0400
X-Originating-IP: 10.200.201.66
Received: from sogo16.sd4.0x35.net (sogo16.sd4.0x35.net [10.200.201.66])
        (Authenticated sender: transient@anthonyv.be)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPA id 8947540009
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 16:57:46 +0000 (UTC)
From:   "transient@anthonyv.be" <transient@anthonyv.be>
To:     git@vger.kernel.org
User-Agent: SOGoMail 5.0.1
MIME-Version: 1.0
Date:   Thu, 25 Mar 2021 17:57:46 +0100
Subject: Bug =?utf-8?q?report=3A?= gitk is unable to handle OpenJDK repository
Message-ID: <5085-605cc100-dd-414bfa80@70853048>
X-Forward: 127.0.0.1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
Clone https://github.com/openjdk/jdk
Launch gitk with `gitk --all` and wait for all commits to be read
Scroll down

What did you expect to happen? (Expected behavior)
Scrolling down, though possibly slow due to the large repository size, works as expected all the way back to the initial commit.

What happened instead? (Actual behavior)
At some point, the following error occurs and it's impossible to scroll neither up nor down without the error occuring.

The error is:
Error: expected integer but got ""
expected integer but got ""
expected integer but got ""
    (reading increment)
    invoked from within
"incr i [lindex $varcrow($v) $a]"
    (procedure "rowofcommit" line 22)
    invoked from within
"rowofcommit $id"
    (procedure "nextuse" line 15)
    invoked from within
"nextuse $p $r"
    (procedure "make_idlist" line 23)
    invoked from within
"make_idlist $row"
    (procedure "layoutrows" line 21)
    invoked from within
"layoutrows $rl1 $r"
    (procedure "drawcommits" line 36)
    invoked from within
"drawcommits $row $endrow"
    (procedure "drawvisible" line 53)
    invoked from within
"drawvisible"
    (procedure "scrollcanv" line 3)
    invoked from within
"scrollcanv .tf.histframe.csb 0.30222245490955735 0.3026978351352059"

What's different between what you expected and what actually happened?
The error occuring and the inability to recover from it.

[System Info]
git version: git version 2.30.2.windows.1
cpu: x86_64
built from commit: 37f0a4afad027cf030747a1ef45537ba86162960
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
uname: Windows 10.0 19042 
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>

[Enabled Hooks]

Kind regards,
Anthony

