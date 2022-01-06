Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41739C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 12:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbiAFMyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 07:54:17 -0500
Received: from mail1.rz.htw-berlin.de ([141.45.10.101]:42669 "EHLO
        mail1.rz.htw-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiAFMyR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 07:54:17 -0500
X-Greylist: delayed 1331 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jan 2022 07:54:17 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=htw-berlin.de; s=my; h=Subject:To:From:Date:From:To:Date:Subject;
        bh=MhyF2773ylwDB2QmeA55F8twfDM5fMg9YNH8T11EsEM=; b=pMp7RDDgNYBnKAgIZWh2Oaq6EB
        wGop0t2LicPRySQ4DDAmUcElcpe5uJdEkVPqNyTnkVOsl3nIz9FcfC+iohQ5dRIXkpVo6A8IJoweu
        GM4tjdKvKHPBThQ9df8nUBS/IRcmkI5IJvjkimd6T5NpB3M1qunVIxpFMOaRKWe1OqLWq+95WfIMg
        lsrieSC+41TbDpvhUIsCktmSZA9dNiC/kHG1IpMDLWruzo/vk7e5jmRjbaERVDwHlyVf9Qg2qhGXr
        FkcY4Wln82rLAbHEO6+0rPUcJA+ABqsxhkL1mjSoAJkjCY+oTmuxPB6LW6hZW8mS6pi+t12M8Qksa
        TlbPCnPA==;
Envelope-to: git@vger.kernel.org
Received: from webmail.htw-berlin.de ([141.45.70.36])
        by mail1.rz.htw-berlin.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <imiadmin@HTW-Berlin.de>)
        id 1n5Rvm-000KGU-RB
        for git@vger.kernel.org; Thu, 06 Jan 2022 13:32:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Jan 2022 13:32:03 +0100
From:   Imi Admin <imiadmin@HTW-Berlin.de>
To:     git@vger.kernel.org
Subject: Problem with credential.helper=store in git 2.32.0.windows.2
Organization: HTW Berlin
Message-ID: <8838ac786ed46b841e4172824b80564b@htw-berlin.de>
X-Sender: imiadmin@htw-berlin.de
User-Agent: Roundcube Webmail
X-HTW-AUTHENTICATED: yes
X-HTW-DELIVERED-TO: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

i've filled out the bug report below, maybe you can help me...

Best Sebastian

*****************************************************************************

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I sometimes have to use git commands on a remote Windows10 through a ssh 
shell (PowerShell Server, so powershell as the shell). I'm creating a 
credentials store file for these commands and set the local git 
configuration credential.helper=store to point to this file.
Here's my local git configuration:

PS C:\scripts> git config -l --show-origin
file:C:/Program 
Files/Git/etc/gitconfig	diff.astextplain.textconv=astextplain
file:C:/Program Files/Git/etc/gitconfig	filter.lfs.clean=git-lfs clean 
-- %f
file:C:/Program Files/Git/etc/gitconfig	filter.lfs.smudge=git-lfs smudge 
-- %f
file:C:/Program Files/Git/etc/gitconfig	filter.lfs.process=git-lfs 
filter-process
file:C:/Program Files/Git/etc/gitconfig	filter.lfs.required=true
file:C:/Program Files/Git/etc/gitconfig	http.sslbackend=openssl
file:C:/Program Files/Git/etc/gitconfig	http.sslcainfo=C:/Program 
Files/Git/mingw64/ssl/certs/ca-bundle.crt
file:C:/Program Files/Git/etc/gitconfig	core.autocrlf=true
file:C:/Program Files/Git/etc/gitconfig	core.fscache=true
file:C:/Program Files/Git/etc/gitconfig	core.symlinks=false
file:C:/Program Files/Git/etc/gitconfig	core.editor="C:\\Program 
Files\\Notepad++\\notepad++.exe" -multiInst -notabbar -nosession 
-noPlugin
file:C:/Program Files/Git/etc/gitconfig	pull.rebase=false
file:C:/Program Files/Git/etc/gitconfig	credential.helper=manager-core
file:C:/Program 
Files/Git/etc/gitconfig	credential.https://dev.azure.com.usehttppath=true
file:C:/Program Files/Git/etc/gitconfig	init.defaultbranch=master
file:.git/config	core.repositoryformatversion=0
file:.git/config	core.filemode=false
file:.git/config	core.bare=false
file:.git/config	core.logallrefupdates=true
file:.git/config	core.symlinks=false
file:.git/config	core.ignorecase=true
file:.git/config	remote.origin.url=https://mygitlab.de/mygroup/myrepo.git
file:.git/config	remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
file:.git/config	branch.master.remote=origin
file:.git/config	branch.master.merge=refs/heads/master
file:.git/config	user.name=myname
file:.git/config	user.email=my@email
file:.git/config	credential.helper=store --file 
C:/scripts/.git/.git-credentials

What did you expect to happen? (Expected behavior)

I'd expect that a 'git pull' against my remote simply works without 
asking me for a user name and password.

What happened instead? (Actual behavior)

My ssh connection hangs...

What's different between what you expected and what actually happened?

Please see above and below...

Anything else you want to add:

My approach worked in a prior git for windows version.
When i use the same approach on the same remote Windows 10 client via 
RDP in Powershell, i see that *before* git uses the credential store 
file, it displays the windows credential dialog. If i click 'cancel' in 
the dialog, git uses the credential store file:

PS C:\scripts> git pull
09:33:11.471005 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/bin
09:33:11.471005 git.c:455               trace: built-in: git pull
09:33:11.471005 run-command.c:667       trace: run_command: git fetch 
--update-head-ok
09:33:11.486629 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/libexec/git-core
09:33:11.502137 git.c:455               trace: built-in: git fetch 
--update-head-ok
09:33:11.502137 run-command.c:667       trace: run_command: GIT_DIR=.git 
git remote-https origin https://mygitlab.de/mygroup/myrepo.git
09:33:11.517762 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/libexec/git-core
09:33:11.517762 git.c:744               trace: exec: git-remote-https 
origin https://mygitlab.de/mygroup/myrepo.git
09:33:11.517762 run-command.c:667       trace: run_command: 
git-remote-https origin https://mygitlab.de/mygroup/myrepo.git
09:33:11.611382 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/libexec/git-core
09:33:11.720731 run-command.c:667       trace: run_command: 'git 
credential-manager-core get'
09:33:11.783217 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/libexec/git-core
09:33:11.798838 git.c:744               trace: exec: 
git-credential-manager-core get
09:33:11.798838 run-command.c:667       trace: run_command: 
git-credential-manager-core get
fatal: User cancelled the authentication prompt.
09:33:22.955081 run-command.c:667       trace: run_command: 'git 
credential-store --file C:/scripts/.git/.git-credentials get'
09:33:22.970702 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/libexec/git-core
09:33:22.970702 git.c:455               trace: built-in: git 
credential-store --file C:/scripts/.git/.git-credentials get
09:33:23.174185 run-command.c:667       trace: run_command: 'git 
credential-manager-core store'
09:33:23.236463 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/libexec/git-core
09:33:23.236463 git.c:744               trace: exec: 
git-credential-manager-core store
09:33:23.236463 run-command.c:667       trace: run_command: 
git-credential-manager-core store
09:33:23.689909 run-command.c:667       trace: run_command: 'git 
credential-store --file C:/scripts/.git/.git-credentials store'
09:33:23.705534 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/libexec/git-core
09:33:23.705534 git.c:455               trace: built-in: git 
credential-store --file C:/scripts/.git/.git-credentials store
09:33:23.892547 run-command.c:667       trace: run_command: git rev-list 
--objects --stdin --not --all --quiet --alternate-refs
09:33:23.924306 run-command.c:667       trace: run_command: git rev-list 
--objects --stdin --not --all --quiet --alternate-refs
09:33:23.924306 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/libexec/git-core
09:33:23.924306 git.c:455               trace: built-in: git rev-list 
--objects --stdin --not --all --quiet --alternate-refs
09:33:23.939814 run-command.c:1628      run_processes_parallel: 
preparing to run up to 1 tasks
09:33:23.939814 run-command.c:1660      run_processes_parallel: done
09:33:23.939814 run-command.c:667       trace: run_command: git 
maintenance run --auto --no-quiet
09:33:23.939814 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/libexec/git-core
09:33:23.939814 git.c:455               trace: built-in: git maintenance 
run --auto --no-quiet
09:33:23.939814 run-command.c:667       trace: run_command: git merge 
FETCH_HEAD
09:33:23.955440 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/libexec/git-core
09:33:23.955440 git.c:455               trace: built-in: git merge 
FETCH_HEAD
Already up to date.

The same happens when i try this with the ssh connection, but the 
command hangs when trying to exec git-credential-manager-core get:

PS C:\scripts> git pull
10:02:33.240054 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/bin
10:02:33.240054 git.c:455               trace: built-in: git pull
10:02:33.240054 run-command.c:667       trace: run_command: git fetch 
--update-head-ok
10:02:33.255676 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/libexec/git-core
10:02:33.255676 git.c:455               trace: built-in: git fetch 
--update-head-ok
10:02:33.255676 run-command.c:667       trace: run_command: GIT_DIR=.git 
git remote-https origin 
https://imiadmgit.f4.htw-berlin.de/f4-imi-li/windows-scripts.git
10:02:33.255676 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/libexec/git-core
10:02:33.255676 git.c:744               trace: exec: git-remote-https 
origin https://imiadmgit.f4.htw-berlin.de/f4-imi-li/windows-scripts.git
10:02:33.255676 run-command.c:667       trace: run_command: 
git-remote-https origin 
https://imiadmgit.f4.htw-berlin.de/f4-imi-li/windows-scripts.git
10:02:33.271297 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/libexec/git-core
10:02:33.380647 run-command.c:667       trace: run_command: 'git 
credential-manager-core get'
10:02:33.396268 exec-cmd.c:237          trace: resolved executable dir: 
C:/Program Files/Git/mingw64/libexec/git-core
10:02:33.396268 git.c:744               trace: exec: 
git-credential-manager-core get
10:02:33.396268 run-command.c:667       trace: run_command: 
git-credential-manager-core get

Anyway as far as i understood git should not exec 
git-credential-manager-core get at all with my local git configuration?

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.32.0.windows.2
cpu: x86_64
built from commit: 3d45ac813c4adf97fe3733c1f763ab6617d5add5
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19043
compiler info: gnuc: 10.3
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]

*****************************************************************************



-- 
Thanks, Sebastian
