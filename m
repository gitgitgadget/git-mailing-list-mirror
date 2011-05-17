From: Jesse Reynolds <jessedreynolds@gmail.com>
Subject: error 'cannot create thread' doing clone or fetch
Date: Tue, 17 May 2011 17:52:44 +0930
Message-ID: <BANLkTi=p3CbQD_EzJATenGsxz5m3=KLtMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 10:22:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMFYL-0001xh-PM
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 10:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572Ab1EQIWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 04:22:49 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37685 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab1EQIWq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 04:22:46 -0400
Received: by wwa36 with SMTP id 36so283652wwa.1
        for <git@vger.kernel.org>; Tue, 17 May 2011 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=AUQ3dw86GkAyZ0Y6Akvf+2gw+9O9L1Ag2ONKrIcob2I=;
        b=kI+xL1sZ1l01NHpIHbFdGNZIY35EyoDRiPESBGrY6gqIp493UL/LxbgC9LgU2cLE7V
         ywlaAJOFSvWIBBFLP95F0HyAgIQtZSCI6wlUtIR9goQ7YOCN530yejMj6UvCNOp9L5hY
         cbZ6ZEgaMcYJKSpWoKnSQKzdPhXOUNkjyRVMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=XmX3ewZblSv+q5Vj+zJUFikFVnCZ1c5vVWARRa5tdVtY8fMW3CikL2jb/Qy2LyAJ6v
         eoQoZfz8AEfbbACZ+qAaTzNtJGkw4W+xq6flr/V8NPEBe+RvpKfCiFxugBqK0xonl3Ar
         olnfKG9X4A9x4MZjayg9JEyrGNneEUe14bWEo=
Received: by 10.216.235.158 with SMTP id u30mr301334weq.104.1305620564929;
 Tue, 17 May 2011 01:22:44 -0700 (PDT)
Received: by 10.216.39.205 with HTTP; Tue, 17 May 2011 01:22:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173793>

Hello

I have just installed git 1.7.5 on Solaris 9, SPARC, using a package
from sunfreeware.com. I've created a new repository with 'git init'
and done a commit. Now I'm trying to set up a shared repository but it
seems there is some issue preventing git from creating a thread for
the 'sideband demultiplexer'.

First trying to do a git fetch --bare locally to create the shared
repository fails:

$ git --bare init --shared
Initialized empty shared Git repository in /pub/lots.git/
$ git --bare fetch /home/jesse/src/lots master:master
error: cannot create thread: Unknown error
fatal: fetch-pack: unable to fork off sideband demultiplexer
$ Broken Pipe

I worked around the above error by using 'git clone --bare' instead.
But now from a remote box I'm unable to do a clone over ssh for the
same reason:

$ git clone ssh://test03/pub/lots.git
Cloning into lots...
error: cannot create thread: Unknown error
fatal: fetch-pack: unable to fork off sideband demultiplexer
$ error: git upload-pack: git-pack-objects died with error.
fatal: git upload-pack: aborting due to possible repository corruption
on the remote side.

Any help greatly appreciated.

I've searched the mailing list and online and can't seem to find
anyone else having this issue. Then again my search skills don't seem
to be what they once used to be!

Cheers
Jesse
