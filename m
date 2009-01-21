From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: how to git a read only directory
Date: Wed, 21 Jan 2009 18:46:19 +0200
Message-ID: <4977515B.9030807@panasas.com>
References: <20090121083354.GG6970@b2j> <4977164B.4020706@panasas.com> <20090121155256.GB6966@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Boaz Harrosh <bharrosh@panasas.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 17:47:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPgF7-0003vU-7u
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 17:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbZAUQq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 11:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbZAUQq1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 11:46:27 -0500
Received: from gw-ca.panasas.com ([66.104.249.162]:3235 "EHLO
	laguna.int.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751544AbZAUQq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 11:46:27 -0500
Received: from daytona.int.panasas.com ([172.17.28.41]) by laguna.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 21 Jan 2009 08:46:22 -0800
Received: from bh-buildlin2.bhalevy.com ([172.17.28.136]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 21 Jan 2009 11:46:20 -0500
User-Agent: Thunderbird/3.0a2 (X11; 2008072418)
In-Reply-To: <20090121155256.GB6966@b2j>
X-OriginalArrivalTime: 21 Jan 2009 16:46:21.0352 (UTC) FILETIME=[CA016280:01C97BE7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106627>

bill lam wrote:
> On Wed, 21 Jan 2009, Boaz Harrosh wrote:
>> I created a master project folder under ~home, init a new git repo,
>> then symlink /etc/ onto an etc/ in the project dir, added all etc/
>> files. I like the extra a/etc/fstab in the patch files better then
>> a/fstab.
> 
> I create a symlink in ~/gitrepo/etc to /etc and git init an empty repo
> there. However it failed in symlink when I tried to add files.  Could
> you give more detail how to do it?  Meanwhile I use worktree method as
> suggested by Michael.
> 

What? I don't know this is what I did:

[~] $ mkdir gitrepo; cd gitrepo
[gitrepo] $ git-init
[gitrepo] $ ln -s /etc
[gitrepo] $ git-add /etc/fstab
[gitrepo] $ git-commit -s
  Edit commit message in editor
[gitrepo] $ git-show
commit fd6a4a72bf91526b56528f4036c525f6d6fd3dc0
Author: Boaz Harrosh <bharrosh@panasas.com>
Date:   Wed Jan 21 18:36:58 2009 +0200

    {REMOVEME} etc/fstab test

    Signed-off-by: Boaz Harrosh <bharrosh@panasas.com>

diff --git a/etc/fstab b/etc/fstab
new file mode 100644
index 0000000..2e3f8d3
--- /dev/null
+++ b/etc/fstab
@@ -0,0 +1,18 @@
+LABEL=/fc7              /                       ext3    noatime         1 1
+LABEL=/usr0             /usr0                   ext3    noatime         1 2
+LABEL=/boot             /boot                   ext2    noatime         1 2
+LABEL=/fc10             /alt                    ext3    defaults        1 2
+tmpfs                   /dev/shm                tmpfs   defaults        0 0
+devpts                  /dev/pts                devpts  gid=5,mode=620  0 0
+sysfs                   /sys                    sysfs   defaults        0 0
+proc                    /proc                   proc    defaults        0 0
+LABEL=SWAP-sda7         swap                    swap    defaults        0 0
+panstor:/main          /mnt/panstor            nfs     soft,intr,rsize=65536,wsize=65536 0 0
  <... snip ...>

So in short I did nothing. I have git 1.6.0.1

Boaz
