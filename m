From: "Rajkumar S" <rajkumars+git@gmail.com>
Subject: Tracking a branch using StGIT
Date: Fri, 15 Sep 2006 13:50:45 +0530
Message-ID: <64de5c8b0609150120h3aeee6dcv976da13134396654@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 10:20:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO8wN-0005wL-TP
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 10:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWIOIUr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 04:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWIOIUr
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 04:20:47 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:43349 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750733AbWIOIUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 04:20:46 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1323456nzf
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 01:20:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=cWM712H25F8g6RD+Nnpv3MXld3M3zdAmyrFA5f4QppQjq0YLA58t4nwJ3BqUfucahbDPNj6wXxg3FJDsDwH9DNeUlPIX0jFF0UJfi62ca4RMbyVx99DfcDEuIBBBKsqgLT/P2syYshRGmUhwKAEdYeCQ5jeVceL4KVzI0qijGLQ=
Received: by 10.65.59.17 with SMTP id m17mr11450498qbk;
        Fri, 15 Sep 2006 01:20:46 -0700 (PDT)
Received: by 10.65.248.1 with HTTP; Fri, 15 Sep 2006 01:20:45 -0700 (PDT)
To: catalin.marinas@gmail.com
Content-Disposition: inline
X-Google-Sender-Auth: 5b5b5750d6b2b080
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27067>

Hi,

I am using StGIT to track a branch of a remote git repository
(actually a remote cvs repository, which I am tracking cvsimport)

The remote repository git branch show:
  Package-Reorg-2005
  RELENG_1
  avendor
* master
  origin

My local repository has:

root@beastie:# stg branch -l
Available branches:
> s     MyBranch            | clone of "RELENG_1"
        Package-Reorg-2005  |
  s     RELENG_1            |
        avendor             |
        master              |
        origin              |

The .git/remotes/origin is
URL: /usr/local/pfSense/upstream/pfSense/.git
Pull: refs/heads/master:refs/heads/origin
Pull: refs/heads/avendor:refs/heads/avendor
Pull: refs/heads/Package-Reorg-2005:refs/heads/Package-Reorg-2005
Pull: refs/heads/RELENG_1:refs/heads/RELENG_1

My requirement is to track RELENG_1 branch with StGIT while
maintaining my own patches. but when I do a stg pull the messages are:

Popping all applied patches... done
Pulling from "origin"...
Trying really trivial in-index merge... fatal: Merge requires
file-level merging Nope. Merging HEAD with
c0a06b86b8431293214f5eb18e49fcb8117c6070 Merging:
997e28966d7b7964562232628cc4f64dccbead9e Execute after commands via sh
&
c0a06b86b8431293214f5eb18e49fcb8117c6070 Execute after commands via sh &
found 1 common ancestor(s):
1b08ecedad1e6a7199f12d1fad97373587c85454 Minor nitpick.  <br> after
firmware branch select box
CONFLICT (add/add): File usr/local/www/status_filter_reload.php added
non-identically in both branches. Adding as
usr/local/www/status_filter_reload.php~HEAD and
usr/local/www/status_filter_reload.php~c0a06b86b8431293214f5eb18e49fcb8117c6070
instead.
<snip>

It seems StGIT is trying to merge the origin branch from remote to
RELENG_1 of local. Is there a way to get RELENG_1 of remote to merge
with MyBranch (clone of "RELENG_1") of local?

raj
