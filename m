From: Matthias Fechner <idefix@fechner.net>
Subject: Cannot push a commit
Date: Sun, 15 Jan 2012 10:09:52 +0100
Message-ID: <4F1297E0.1060703@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 10:38:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmMYD-0004Ns-6c
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 10:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560Ab2AOJib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jan 2012 04:38:31 -0500
Received: from anny.lostinspace.de ([80.190.182.2]:31767 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab2AOJia (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 04:38:30 -0500
X-Greylist: delayed 1704 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Jan 2012 04:38:29 EST
Received: from server.idefix.lan (ppp-88-217-26-89.dynamic.mnet-online.de [88.217.26.89])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.5/8.14.5) with ESMTP id q0F99ulu047784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 15 Jan 2012 10:10:02 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (localhost [IPv6:::1])
	by server.idefix.lan (Postfix) with ESMTP id 4EEC7394A
	for <git@vger.kernel.org>; Sun, 15 Jan 2012 10:09:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at fechner.net
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ofj25GiIclb9 for <git@vger.kernel.org>;
	Sun, 15 Jan 2012 10:09:55 +0100 (CET)
Received: from [IPv6:2001:a60:f035:1:92e:1cf9:c174:8615] (unknown [IPv6:2001:a60:f035:1:92e:1cf9:c174:8615])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by server.idefix.lan (Postfix) with ESMTPSA id 01FA9393F
	for <git@vger.kernel.org>; Sun, 15 Jan 2012 10:09:52 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
X-Enigmail-Version: 1.3.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.7 (anny.lostinspace.de [80.190.182.2]); Sun, 15 Jan 2012 10:10:02 +0100 (CET)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188593>

Dear List,

I have a big problem with a file which I cannot push to my central git
repository.
The file can be found here:
http://dl.fechner.net/APP_UD.sch

What I did to reproduce it:
On my server (freebsd with git 1.7.8.3)
cd
mkdir git-test
cd git-test
git init --bare

On my client a windows pc with tortoise git 1.7.6.0 and git 1.7.8.msysgit.0
I cloned the repository over ssh
Added a small test.txt file, commit and pushed it to the server,
everything is fine.
Then a copied the file above to the local repo, added it and commited it.
If I try to push it, I get the error message:
git.exe push --progress  "origin" master:master

Counting objects: 4, done.
Compressing objects: 100% (3/3)
Writing objects: 100% (3/3), 80.00 KiB | 137 KiB/s
Writing objects: 100% (3/3), 91.63 KiB | 137 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0)
fatal: early EOF
error: unpack failed: unpack-objects abnormal exit
To idefix@fechner.net:git-test
! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to 'idefix@fechner.net:git-test'

git config -l shows on the windows pc:
core.symlinks=false
core.autocrlf=false
color.diff=auto
color.status=auto
color.branch=auto
color.interactive=true
pack.packsizelimit=2g
help.format=html
http.sslcainfo=/bin/curl-ca-bundle.crt
sendemail.smtpserver=/bin/msmtp.exe
diff.astextplain.textconv=astextplain
rebase.autosquash=true
user.name=Matthias Fechner
user.email=idefix@fechner.net
core.autocrlf=false
core.safecrlf=false
core.repositoryformatversion=0
core.filemode=false
core.bare=false
core.logallrefupdates=true
core.symlinks=false
core.ignorecase=true
core.hidedotfiles=dotGitOnly
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
remote.origin.url=idefix@fechner.net:git-test
remote.origin.puttykeyfile=
branch.master.remote=origin
branch.master.merge=refs/heads/master

How can I solve this problem?
Is this maybe a bug in git?

Thanks a lot
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
