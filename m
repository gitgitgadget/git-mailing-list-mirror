Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C51DC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 23:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 779F4206D6
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 23:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgD1XY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:24:58 -0400
Received: from p3plsmtps2ded02.prod.phx3.secureserver.net ([208.109.80.59]:58918
        "EHLO p3plsmtps2ded02.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgD1XY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 19:24:58 -0400
X-Greylist: delayed 675 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Apr 2020 19:24:58 EDT
Received: from mail.mailscreen.com ([192.169.216.63])
        by : HOSTING RELAY : with ESMTP
        id TZP8jii7X7xHxTZP8jQQmT; Tue, 28 Apr 2020 16:12:42 -0700
X-SECURESERVER-ACCT: 192.169.216.63
x-originating-ip: 192.169.216.63
X-CMAE-Analysis: v=2.3 cv=I7cbu+og c=1 sm=1 tr=0
 a=Lb3IGWfh0WRM6Myxhpp6wQ==:117 a=Lb3IGWfh0WRM6Myxhpp6wQ==:17
 a=8nJEP1OIZ-IA:10 a=cl8xLZFz6L8A:10 a=4W0BXsk7zeDR5EMJxEAA:9
 a=wPNLvfGTeEIA:10 a=xmFk3Ph7cxNIZb1jWd-e:22 a=p-dnK0njbqwfn1k4-x12:22
 a=MURpYVOlrLSSKvKaDb7l:22
Received: by mail.mailscreen.com (Postfix, from userid 48)
        id C79A84480128; Tue, 28 Apr 2020 16:12:42 -0700 (MST)
Received: from 70.121.79.40
        (SquirrelMail authenticated user robsimpson@mailscreen.com)
        by socialwebmail.com with HTTP;
        Tue, 28 Apr 2020 19:12:42 -0400
Message-ID: <60af77100df823b4112c08e6c1b8533f.squirrel@socialwebmail.com>
Date:   Tue, 28 Apr 2020 19:12:42 -0400
Subject: Git error message suggests an invalid switch
From:   "Robert Simpson" <no-reply@MailScreen.com>
To:     "Git Bug Reports" <git@vger.kernel.org>
User-Agent: SquirrelMail/1.4.23 [SVN]-1.el7.20190710
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-CMAE-Envelope: MS4wfFg7AaThAZTlXt5LWwm3142M6xEbhWcjioPz69vYUvn40DWHJBqgiEcttDFw0qy33I6DNByJA2M6QcAdJiqeDAjjDHoaEmXsZQT5UOwFdDp7ZxRSeCTH
 +1hOU6MAPM0DUxNGRYfAqF1FhOSFAYf4SAVyzr7cxs2W/gwXq9bYeGdU0qWpl946WYxb0tYHIdrBKA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command below shows an error message that says "try -b". However "-b"
is not a valid switch for the command, as indicated by "unknown swtich
'b'" when that has been added to the command.

--------------------------------------------------------------------
git switch "master" --track "origin/master"

fatal: missing branch name; try -b

git switch -b "master" --track "origin/master"

error: unknown switch `b'
usage: git switch [<options>] [<branch>]

    -c, --create <branch>
                          create and switch to a new branch
    -C, --force-create <branch>
                          create/reset and switch to a branch
    --guess               second guess 'git switch <no-such-branch>'
    --discard-changes     throw away local modifications
    -q, --quiet           suppress progress reporting
    --recurse-submodules[=<checkout>]
                          control recursive updating of submodules
    --progress            force progress reporting
    -m, --merge           perform a 3-way merge with the new branch
    --conflict <style>    conflict style (merge or diff3)
    -d, --detach          detach HEAD at named commit
    -t, --track           set upstream info for new branch
    -f, --force           force checkout (throw away local modifications)
    --orphan <new-branch>
                          new unparented branch
    --overwrite-ignore    update ignored files (default)
    --ignore-other-worktrees
                          do not check if another worktree is holding the
given ref

