From: Sassy Natan <sassyn@gmail.com>
Subject: GIT & Symbolic Links
Date: Mon, 12 Mar 2012 18:44:46 +0200
Message-ID: <CACHQFzEJATc2hiSdAgoGg3vssQ-CShF+89TOkzVwaf_ujYy+3w@mail.gmail.com>
References: <CACHQFzEqe-SwpCgjgGRDdzcUQW_+8-TdLsRV6KbKorvq7dJi+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:45:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S78Mz-0007sQ-Jx
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875Ab2CLQpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:45:09 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62493 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab2CLQpH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:45:07 -0400
Received: by bkcik5 with SMTP id ik5so2792742bkc.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 09:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=stgEg2i5CXkvXF7Az3inWTH7CMdxDm38gadyyX8H1Ws=;
        b=ci9TDbXT5inPtGbe7osmieyDSvV3tWglQc2o+pNAp0gY4eL9MUf8BUPorJsOYrw8UY
         Ti4N46wmfVzZj0oGqrf7aDmj/f+jKb9kCHERx5VR/G50En2naIcCG8bRL2hjyAf+uVCa
         xkdIcolXV0y1kUhtWqXDHfpuoQLAD9XCWyYC3TzE5ebXtr6wVogD5cF/Ad818dNwMDDo
         +cSle+4b5GAe5Iv+bRIJ6DYb6mDEjg2eVfr1Xk9w++PAZ0Nwlti7+zmf8Fr6jrKWBxNf
         6p/gc5WSMIxNzQEAqMvSV3ecuHbM6GPH2QrcsJvHP+SmeRUGtKqMdZ4HpmdBsuGo+fri
         HlJQ==
Received: by 10.204.156.23 with SMTP id u23mr5080116bkw.18.1331570706229; Mon,
 12 Mar 2012 09:45:06 -0700 (PDT)
Received: by 10.204.53.81 with HTTP; Mon, 12 Mar 2012 09:44:46 -0700 (PDT)
In-Reply-To: <CACHQFzEqe-SwpCgjgGRDdzcUQW_+8-TdLsRV6KbKorvq7dJi+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192905>

Hi Group,

I'm consider myself as a new baby when it come to GiT.
But I have just migrate my users from SVN to GIT and I have some
questions in mind I want to share with you.

Is it possible to do the following:

Say I have a really big GiT repo (something around 1GB) name DEV.
In the SVN days, each of my developers (100 Users) had to clone a
local copy of the DEV Repo in his home folder, so total of 100GB was
used in my shared storage (NFS Drive) where something around 85% was
actually just a copy of the same files.

When I used the De-Duplication function (Under ZFS File System) I
could easy see how the volume is shrinking, but I more inserting in
different kind of solution, now when it comes to GIT.

So for the example let's consider that user A clone the DEV GIT Repo
into his/her home folder (/home/A/DEV)
User B want to clone the same Repo. But now, I don't want user B to
clone the all tree and files, but instead to have a symbolic links to
the /home/A/DEV folder.
All files and directories in the /home/B/DEV will be a links to the /home/A/DEV.

Once user B actually want to change a file, ?somehow? the git brake
the link, and have a local copy of that specific file.
When the file is push back the link become back.

While trying to get some feedback in the IRC roon, some users point me
to git-annex and unionfs.
Both project seems to be cool, git-annex really have nice options, but
I don't see how this going to help me.

Regarding unionfs - well I'm still not sure.

Maybe someone can help here...

Thanks
