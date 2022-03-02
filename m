Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56AAC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 16:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbiCBQrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiCBQro (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 11:47:44 -0500
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 08:47:00 PST
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1D8D0045
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 08:47:00 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id AB3A27E12E; Wed,  2 Mar 2022 11:38:16 -0500 (EST)
User-agent: mu4e 1.7.0; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     git@vger.kernel.org
Subject: gitk external diff on Windows
Date:   Wed, 02 Mar 2022 11:27:20 -0500
Message-ID: <87fso0qphj.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm running git version 2.28.0.windows.1 on Windows and trying to set it
up to run winmerge as the external diff tool.  I am pretty sure I used
to do this following the instructions here:

https://igorsgames.wordpress.com/2015/05/28/using-winmerge-as-an-external-diff-tool-in-gitk/

When I point gitk to the batch file and try to open the external diff
tool, nothing happens.  Winmerge does not open, nor do I get an error
from gitk.  I noticed the next box below on the preferences screen
contains "cmd /c" so I tried prefixing the path to the batch file with
that, and instead I get an error that says:

cmd /c C:/Program Files/WinMerge/winmerge.bat: command failed: couldn't
execute "cmd \c C:\Program Files\WinMerge\winmerge.bat": no such file or
directory.

Why does nothing happen in the first case, and why in the second case is
gitk apparently changing regular slashes into back-slashes before
trying to pass the string directly to CreateProcess as the name of the
executable binary, rather than to a shell or ShellExecute or something?

Also I just tried having the batch file echo something to a text file to
see if it was running at all or if winmerge just isn't opening, and the
text file ( full path to my home directory to make sure permissions
aren't a problem ) isn't created, so the batch file isn't executing even
though there is no error given by gitk.
