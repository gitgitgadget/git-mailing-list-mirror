From: "Ricky Nite" <ricky.nite@gmail.com>
Subject: submodule init problem
Date: Wed, 25 Jul 2007 08:09:25 +0800
Message-ID: <d4b731510707241709pcad0a4bj85b71892cd2de84c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 02:09:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDURX-0003fX-8g
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 02:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813AbXGYAJ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 20:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757064AbXGYAJ1
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 20:09:27 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:46091 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786AbXGYAJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 20:09:26 -0400
Received: by py-out-1112.google.com with SMTP id d32so37160pye
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 17:09:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hsIk/5xMr4X99JqD+bSJsJ66+WBooeeS64v927N5eXH0v0weqvRtfWf0eA/A6dtTFeaQw9cORtqrfK/vAfGKfPj/VWuNpgvEG5axg2dbd5kGJe16usVTr1TXkrxAszMRlZsWuPsk81R9ljrl0lGsahFiH4MSrxsDBAPN08uZvmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bIrmuq5LsR9hD5z4ENuK2dEizhPyXUUsoa1VOadxhV5Y65vRo0Q/iIoAQa0IXtUsFUPukXk/uXzPbOxum3W5A8fk6G9Qt5m5QyI4Wy17WDZgY1TOqHa9CTT30iXhINoU3eWxBim9bhhA780f+g8QS9r0XxHxEvcnlhTFwQRj2es=
Received: by 10.65.126.16 with SMTP id d16mr72558qbn.1185322165945;
        Tue, 24 Jul 2007 17:09:25 -0700 (PDT)
Received: by 10.65.96.19 with HTTP; Tue, 24 Jul 2007 17:09:25 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53661>

Hello,

I encountered this message in "git submodule init":
"No url found for submodule path '<submodule>' in .gitmodules"

But when I look at .gitmodules, the <submodule> url is there.
Subsequently, I cannot do "git submodule update"

Here's the full log:
rnite@linuskarl:~/git_dev/myproj$ ~/bin/git --version
git version 1.5.3.rc2.g11308
rnite@linuskarl:~/git_dev$ mkdir flash
rnite@linuskarl:~/git_dev$ mkdir flashboard
rnite@linuskarl :~/git_dev$ cd flash
rnite@linuskarl:~/git_dev/flash$ echo "foo" > flash.v
rnite@linuskarl:~/git_dev/flash$ ~/bin/git init
Initialized empty Git repository in .git/
rnite@linuskarl:~/git_dev/flash$ ~/bin/git add flash.v
rnite@linuskarl:~/git_dev/flash$ ~/bin/git commit -a -m "initial
commit of flash module"
Created initial commit c19874e: initial commit of flash module
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 flash.v
rnite@linuskarl:~/git_dev/flash$ cd ../flashboard
rnite@linuskarl:~/git_dev/flashboard$ echo "foo" > flashboard.v
rnite@linuskarl:~/git_dev/flashboard$ ~/bin/git init
Initialized empty Git repository in .git/
rnite@linuskarl:~/git_dev/flashboard$ ~/bin/git add flashboard.v
rnite@linuskarl:~/git_dev/flashboard$ ~/bin/git commit -a -m "initial
commit of flashboard module"
Created initial commit 45dff87: initial commit of flashboard module
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 flashboard.v
rnite@linuskarl:~/git_dev/flashboard$ cd ..
rnite@linuskarl :~/git_dev$ mkdir myproj
rnite@linuskarl:~/git_dev$ cd myproj
rnite@linuskarl:~/git_dev/myproj$ ~/bin/git init
Initialized empty Git repository in .git/
rnite@linuskarl:~/git_dev/myproj$ ~/bin/git submodule add ~/git_dev/flash
Initialized empty Git repository in /home/rnite/git_dev/myproj/flash/.git/
remote: Generating pack...
remote: Done counting 3 objects.
Deltifying 3 objects...
 100% (3/3) done
Total 3 (delta 0), reused 0remote:  (delta 0)
Indexing 3 objects...
 100% (3/3) done
rnite@linuskarl:~/git_dev/myproj$ ~/bin/git submodule add ~/git_dev/flashboard
Initialized empty Git repository in /home/rnite/git_dev/myproj/flashboard/.git/
remote: Generating pack...
remote: Done counting 3 objects.
Deltifying 3 objects...
 100% (3/3) done
Total 3 (delta 0), reused 0remote:  (delta 0)
Indexing 3 objects...
 100% (3/3) done
rnite@linuskarl:~/git_dev/myproj$ ~/bin/git submodule init
No url found for submodule path 'flash' in .gitmodules
rnite@linuskarl:~/git_dev/myproj$ cat .gitmodules
[submodule "flash"]
        path = flash
        url = /home/rnite/git_dev/flash/.git
[submodule "flashboard"]
        path = flashboard
        url = /home/rnite/git_dev/flashboard/.git

I can add more submodules, but the message stays the same after "git
submodule init" and I cannot do "git submodule update"

help,
RickyN
