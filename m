From: "Wink Saville" <wink@saville.com>
Subject: Git branching & pulling
Date: Fri, 18 May 2007 22:40:17 -0700
Message-ID: <d4cf37a60705182240s414243a6wae69d26f70f64dd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 07:40:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpHfz-00089I-89
	for gcvg-git@gmane.org; Sat, 19 May 2007 07:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817AbXESFkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 01:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755805AbXESFkT
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 01:40:19 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:29217 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817AbXESFkS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 01:40:18 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1574504nza
        for <git@vger.kernel.org>; Fri, 18 May 2007 22:40:18 -0700 (PDT)
Received: by 10.115.107.1 with SMTP id j1mr1283600wam.1179553217551;
        Fri, 18 May 2007 22:40:17 -0700 (PDT)
Received: by 10.114.137.15 with HTTP; Fri, 18 May 2007 22:40:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47716>

Hello,

I'm having trouble understanding branching and pull.

Using git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
I can create a branch off the master and do a pull:

wink@ic2d1:~/linux/linux-2.6$ git-checkout master
Switched to branch "master"
wink@ic2d1:~/linux/linux-2.6$ git-checkout -b test
Switched to a new branch "test"
wink@ic2d1:~/linux/linux-2.6$ git-pull
Already up-to-date.



But from some reason using
git://git.kernel.org/pub/scm/linux/kernel/git/avi/kvm.git
the following happens

wink@ic2d1:~/linux/kvm-linux-2.6$ git-checkout master
Already on branch "master"
wink@ic2d1:~/linux/kvm-linux-2.6$ git-checkout -b test
Switched to a new branch "test"
wink@ic2d1:~/linux/kvm-linux-2.6$ git-pull
Warning: No merge candidate found because value of config option
         "branch.test.merge" does not match any remote branch fetched.
No changes.



What I notice is that in kvm.git that .git/remotes is empty while on
linux-2.6.git
.git/remotes has origin and it contains:

URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Pull: refs/heads/master:refs/heads/origin


Another difference is that the .git/config file of kvm.git has quite a
few items:

[core]
 repositoryformatversion = 0
 filemode = true
 bare = false
 logallrefupdates = true
[remote "origin"]
 url = git://git.kernel.org/pub/scm/linux/kernel/git/avi/kvm.git
 fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
 remote = origin
 merge = refs/heads/master



While linux-2.6.git is quite sparse:

[core]
        repositoryformatversion = 0
        filemode = true



Could someone give me some insight or point me at a url or doc
that could shed some light on what is happening and why git-pull
doesn't work on kvm.git.

Thanks,

Wink Saville
