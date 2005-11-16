From: Franck <vagabon.xyz@gmail.com>
Subject: [QUESTION] Access to a huge GIT repository.
Date: Wed, 16 Nov 2005 13:24:25 +0100
Message-ID: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Nov 16 13:26:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcML3-00007J-LG
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 13:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbVKPMY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 07:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbVKPMY1
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 07:24:27 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:12164 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030301AbVKPMY0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 07:24:26 -0500
Received: by zproxy.gmail.com with SMTP id v1so1770058nzb
        for <git@vger.kernel.org>; Wed, 16 Nov 2005 04:24:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i0CroBKK7JPdEbCZ3DogKI6pCz+ocg6QwR9a7cQOa78rUpXDCidQowQIMWH5XBKdha7/iRAjdzR5zpFq/ZWx1+ud650KXSDuJiZx6VB1+bf8Gq3fyVx4IK8W6Iym6Ta9UPbiTKLz7IYkRjW2BGVmL19sGbfni2DyrTm04/QbAXU=
Received: by 10.36.224.48 with SMTP id w48mr3868114nzg;
        Wed, 16 Nov 2005 04:24:26 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Wed, 16 Nov 2005 04:24:25 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12022>

Hi,

I'm trying to clone a small part of a big repository. This repository
contains several branchs that are useless for me. Actually this
repository is the linux-mips one, and branchs are used to track each
kernel minor version. That is to say it contains 4 branchs which are
linux-2.0, linux-2.2, linux-2.4 and master (linux-2.6).

I'd like to clone this repository without grabbing linux-2.0,
linux-2.2, linux-2.4 branchs. I tried several things like:

        $ git init-db
        $ git fetch rsync://ftp.linux-mips.org/git/linux.git master

But all tries download every objects of each branchs. I believe that's
because of (a) the protocol used to access of the remote repo (b) the
master branch has been created from linux-2.4 branch so its first
commit object contains a branch 2.4 commit obj as parent object (let's
call it the "father" object). Is that correct ?

So I downloaded the whole thing, and try to remove "father" object and
right after run a 'git prune'. But unfortunately I can't find it
anywhere in .git directory. I did:

        $ git-verify-pack < .git/objects/pack/*.idx
        $ git-unpack-objects < .git/objects/pack/*.pack

But I can't find "father object" anywhere in .git/objects directory.
Still it's referenced by .git/objects/pack/pack-....idx file.

Can anybody give me some advices ?

Thanks
--
               Franck
