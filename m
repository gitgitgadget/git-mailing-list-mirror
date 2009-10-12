From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Filesystem has no item: Working copy path [...] does not exist in 
	repository at /usr/bin/git-svn line 3856
Date: Mon, 12 Oct 2009 17:48:46 +0200
Message-ID: <9accb4400910120848n6a1e4036l5e45ce3882deb5aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 17:58:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxNHN-0003Ws-Qz
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 17:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbZJLPtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 11:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbZJLPtZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 11:49:25 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:41382 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420AbZJLPtX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 11:49:23 -0400
Received: by bwz6 with SMTP id 6so3205431bwz.37
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 08:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=b5NKELZdMHbKhJLOYvTtIbUY3EcqpSpo9/F9fxXi69Y=;
        b=iXcsLAyhHG1pTgcHJCfdCKdLSCz7rxt6QgNqDK/LIdzowg2L7euQtmZBGYKEjF0yGP
         Ec/9Oe4IvvCnG4dHslTiXnhy22MaYxheAgFxR8AeHcWityRmCTdp00ZIOC9M2mKr+dkV
         opvAy5wFMp0wANzJA0qVgy+wboL22OWO8vtKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=vUbi/nRzkIhJrdf6EKogAq3/Zo6XcbmFB034V5C1yoL6poQ3NmhB5+h2adg4TcEa1/
         ThYUZPMUHoC+ZLkwMsdkW2PuZLXLNjnTddPRcFE0ZqXPj0ts8DIHo3+6wcDG0GPSYYNq
         yhT9vmGr3T6/uNQiYC6RCiG2tMY4+vLsdBHeU=
Received: by 10.204.162.143 with SMTP id v15mr5191795bkx.50.1255362526511; 
	Mon, 12 Oct 2009 08:48:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130029>

Hi,
i'm trying to clone a public SVN repo (user = guest, password is
empty/blank/not neeeded)

this was my steps:

$ git --version
git version 1.5.6.5
$ mkdir plugins
$ cd plugins
$ git svn init http://svn.liferay.com/repos/public/plugins -T trunk -b
branches # doesn't have tags
$ git svn fetch
[...]
# it takes hours.....
[...]
r25355 = ee13a19e656e6f96b1ebb562b10ee7fa688921df (svn/trunk)
Filesystem has no item: Working copy path 'plugins/branches/trunk'
does not exist in repository at /usr/bin/git-svn line 3856


after that revision it give me that error... and then stops.
if I issue again the git svn fetch it keep telling me the error and I
can't complete the cloning.

I've edited my .git/config between git svn init and git svn fetch
adding "svn" to the target branch and url name

[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[svn-remote "svn"]
	url = http://svn.liferay.com/repos/public
	fetch = plugins/trunk:refs/remotes/svn/trunk
	branches = plugins/branches/*:refs/remotes/svn/*

you can use
git svn fetch --revision 25255:HEAD

to make it take less time (hours anyway)...

Any help will be appreciated,

thanks,
regards,
Daniele
