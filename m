From: "Ricky Nite" <ricky.nite@gmail.com>
Subject: Re: submodule init problem
Date: Wed, 25 Jul 2007 08:30:22 +0800
Message-ID: <d4b731510707241730u45755c0dwfde5e0b14b14f1da@mail.gmail.com>
References: <d4b731510707241709pcad0a4bj85b71892cd2de84c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 02:30:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDUlu-00083r-PN
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 02:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759060AbXGYAa1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 20:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759568AbXGYAa0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 20:30:26 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:5545 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759447AbXGYAaX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 20:30:23 -0400
Received: by py-out-1112.google.com with SMTP id d32so44318pye
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 17:30:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vsze4z9dEq1fypLxqdzIxNoLZCJ7DYofJmHfN/x/tWVquUjmP5sOp1E6bZNM0SwvageK99jyjUdaMw2IREB347dN1HQdpERtJv9ZVFbDKIhUGzYLApaI2s+/IMdtPkUBiXByg09oERCzTrVk3E8o80ETiYpaIWkssL1TCvn/syA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rev+nMdY46vokaYDkhuRUIF2mel4ErvdBB7oMUZVC/VGMmriAEHP3LJsW4HLBp7bbuVmSwemsyNcAncCZTMGkm4pDw/na6Ge8ojGw4UWQhyVzlSCJZysZmy8iNR9IOGDZVCQWpiMuEPFX1JipG56bmmZOUi96KFUXXqsaB9o7i0=
Received: by 10.64.210.3 with SMTP id i3mr108466qbg.1185323422604;
        Tue, 24 Jul 2007 17:30:22 -0700 (PDT)
Received: by 10.65.96.19 with HTTP; Tue, 24 Jul 2007 17:30:22 -0700 (PDT)
In-Reply-To: <d4b731510707241709pcad0a4bj85b71892cd2de84c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53663>

This problem doesn't seem to occur if I rename my submodules (but I
really don't want to):

rnite@linuskarl:~/git_dev$ mkdir moduleA
rnite@linuskarl:~/git_dev$ mkdir moduleB
rnite@linuskarl:~/git_dev$ cd moduleA
rnite@linuskarl:~/git_dev/moduleA$ echo "foo" > moduleAtop.v
rnite@linuskarl:~/git_dev/moduleA$ ~/bin/git init
Initialized empty Git repository in .git/
rnite@linuskarl:~/git_dev/moduleA$ ~/bin/git add moduleAtop
rnite@linuskarl:~/git_dev/moduleA$ ~/bin/git commit -a -m"imitial commit"
Created initial commit f8bc70b: imitial commit
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 moduleAtop.v
rnite@linuskarl:~/git_dev/moduleA$ cd ../moduleB
rnite@linuskarl:~/git_dev/moduleB$ echo "foo" > moduleBtop.v
rnite@linuskarl:~/git_dev/moduleB$ ~/bin/git init
Initialized empty Git repository in .git/
rnite@linuskarl:~/git_dev/moduleB$ ~/bin/git add moduleBtop.v
rnite@linuskarl:~/git_dev/moduleB$ ~/bin/git commit -a -m"imitial commit"
Created initial commit da426f3: imitial commit
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 moduleBtop.v
rnite@linuskarl:~/git_dev/moduleB$ cd ..
rnite@linuskarl:~/git_dev$ mkdir myproj2
rnite@linuskarl:~/git_dev$ cd myproj2
rnite@linuskarl:~/git_dev/myproj2$ ~/bin/git init
Initialized empty Git repository in .git/
rnite@linuskarl:~/git_dev/myproj2$ ~/bin/git submodule add ~/git_dev/moduleA
Initialized empty Git repository in /home/rnite/git_dev/myproj2/moduleA/.git/
remote: Generating pack...
remote: Done counting 3 objects.
Deltifying 3 objects...
 100% (3/3) done
Total 3 (delta 0), reused 0remote:  (delta 0)
Indexing 3 objects...
 100% (3/3) done
rnite@linuskarl:~/git_dev/myproj2$ ~/bin/git submodule add ~/git_dev/moduleB
Initialized empty Git repository in /home/rnite/git_dev/myproj2/moduleB/.git/
remote: Generating pack...
remote: Done counting 3 objects.
Deltifying 3 objects...
 100% (3/3) done
Total 3 (delta 0), reused 0remote:  (delta 0)
Indexing 3 objects...
 100% (3/3) done
rnite@linuskarl:~/git_dev/myproj2$ ~/bin/git submodule init
Submodule 'moduleA' (/home/rnite/git_dev/moduleA/.git) registered for
path 'moduleA'
Submodule 'moduleB' (/home/rnite/git_dev/moduleB/.git) registered for
path 'moduleB'

help,
RickyN

On 7/25/07, Ricky Nite <ricky.nite@gmail.com> wrote:
> Hello,
>
> I encountered this message in "git submodule init":
> "No url found for submodule path '<submodule>' in .gitmodules"
>
> But when I look at .gitmodules, the <submodule> url is there.
> Subsequently, I cannot do "git submodule update"
>
> Here's the full log:
> rnite@linuskarl:~/git_dev/myproj$ ~/bin/git --version
> git version 1.5.3.rc2.g11308
> rnite@linuskarl:~/git_dev$ mkdir flash
> rnite@linuskarl:~/git_dev$ mkdir flashboard
> rnite@linuskarl :~/git_dev$ cd flash
> rnite@linuskarl:~/git_dev/flash$ echo "foo" > flash.v
> rnite@linuskarl:~/git_dev/flash$ ~/bin/git init
> Initialized empty Git repository in .git/
> rnite@linuskarl:~/git_dev/flash$ ~/bin/git add flash.v
> rnite@linuskarl:~/git_dev/flash$ ~/bin/git commit -a -m "initial
> commit of flash module"
> Created initial commit c19874e: initial commit of flash module
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 flash.v
> rnite@linuskarl:~/git_dev/flash$ cd ../flashboard
> rnite@linuskarl:~/git_dev/flashboard$ echo "foo" > flashboard.v
> rnite@linuskarl:~/git_dev/flashboard$ ~/bin/git init
> Initialized empty Git repository in .git/
> rnite@linuskarl:~/git_dev/flashboard$ ~/bin/git add flashboard.v
> rnite@linuskarl:~/git_dev/flashboard$ ~/bin/git commit -a -m "initial
> commit of flashboard module"
> Created initial commit 45dff87: initial commit of flashboard module
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 flashboard.v
> rnite@linuskarl:~/git_dev/flashboard$ cd ..
> rnite@linuskarl :~/git_dev$ mkdir myproj
> rnite@linuskarl:~/git_dev$ cd myproj
> rnite@linuskarl:~/git_dev/myproj$ ~/bin/git init
> Initialized empty Git repository in .git/
> rnite@linuskarl:~/git_dev/myproj$ ~/bin/git submodule add ~/git_dev/flash
> Initialized empty Git repository in /home/rnite/git_dev/myproj/flash/.git/
> remote: Generating pack...
> remote: Done counting 3 objects.
> Deltifying 3 objects...
>  100% (3/3) done
> Total 3 (delta 0), reused 0remote:  (delta 0)
> Indexing 3 objects...
>  100% (3/3) done
> rnite@linuskarl:~/git_dev/myproj$ ~/bin/git submodule add ~/git_dev/flashboard
> Initialized empty Git repository in /home/rnite/git_dev/myproj/flashboard/.git/
> remote: Generating pack...
> remote: Done counting 3 objects.
> Deltifying 3 objects...
>  100% (3/3) done
> Total 3 (delta 0), reused 0remote:  (delta 0)
> Indexing 3 objects...
>  100% (3/3) done
> rnite@linuskarl:~/git_dev/myproj$ ~/bin/git submodule init
> No url found for submodule path 'flash' in .gitmodules
> rnite@linuskarl:~/git_dev/myproj$ cat .gitmodules
> [submodule "flash"]
>         path = flash
>         url = /home/rnite/git_dev/flash/.git
> [submodule "flashboard"]
>         path = flashboard
>         url = /home/rnite/git_dev/flashboard/.git
>
> I can add more submodules, but the message stays the same after "git
> submodule init" and I cannot do "git submodule update"
>
> help,
> RickyN
>
