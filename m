From: Jochen Roemling <jochen@roemling.net>
Subject: Re: change of git-diff-tree and symlinks
Date: Sun, 29 May 2005 16:16:53 +0200
Message-ID: <4299CED5.5070508@roemling.net>
References: <20050525111711.GA27492@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 16:15:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcOYu-0000qa-7W
	for gcvg-git@gmane.org; Sun, 29 May 2005 16:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVE2ORF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 10:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVE2ORF
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 10:17:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:50892 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261317AbVE2OQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 10:16:58 -0400
Received: from p54AAFF39.dip.t-dialin.net [84.170.255.57] (helo=[10.3.24.50])
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML21M-1DcOb23jvu-0008Hs; Sun, 29 May 2005 16:16:56 +0200
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050525111711.GA27492@vrfy.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:35bace2e8eeec41a1b9500b782c09cc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello Kay,

I'm planning to use cogito/git for tracking development of my (PHP 
based) website. Although this is the first time in my life I'm using 
something that smells like a SCM, it seems to work great. The only thing 
lacking is a working gitweb installation.
I downloaded the gitweb.cgi script from 
kernel.org/pub/software/scm/gitweb, but it dates already May 23rd.

In your mail below from May 25 you state that there have been quite some 
changes to git-diff-tree:

Kay Sievers wrote:

>Hi,
>I'm catching up with gitweb.cgi to parse the changed output. Works fine
>so far and is really much easier to parse. Here is something that does
>not work anymore. See the difference between:
>
>   http://www.kernel.org/git/?p=linux/hotplug/udev.git;a=commit;h=49cedafaf893bfe348eb7598227f1a11ae24bfd6
>   http://ehlo.org/~kay/gitweb.cgi?p=linux/hotplug/udev.git;a=commit;h=49cedafaf893bfe348eb7598227f1a11ae24bfd6
>
>On my box is the lates git with the adapted gitweb.cgi. Here is the raw
>output of the old git-diff-tree:
>  kay@dhcp-188:~/src/udev> /home/kay/src/cogito/git-diff-tree -r 49cedafaf893bfe348eb7598227f1a11ae24bfd6 17f2b1a7e0d10334af7f9622848788add125dea8
>  *120000->100644 blob 2d78258b1a0fe49afabc8c16a352117df5dc338a->2d78258b1a0fe49afabc8c16a352117df5dc338a test/sys/block/cciss!c0d0/device
>  *120000->100644 blob 2d78258b1a0fe49afabc8c16a352117df5dc338a->2d78258b1a0fe49afabc8c16a352117df5dc338a test/sys/block/rd!c0d0/device
>  *120000->100644 blob 2d78258b1a0fe49afabc8c16a352117df5dc338a->2d78258b1a0fe49afabc8c16a352117df5dc338a test/sys/block/sda/device
>  *120000->100644 blob 1c776568bdc9dc750addd0885dded6b008a44460->1c776568bdc9dc750addd0885dded6b008a44460 test/sys/bus/pci/devices/0000:00:09.0
>  *120000->100644 blob e000c77614a23ad57fed284bd007ed7c1cb7872e->e000c77614a23ad57fed284bd007ed7c1cb7872e test/sys/bus/pci/devices/0000:00:1e.0
>  ...
>
>The new one shows simply nothing.
>Shouldn't it print the mode changes like the old one?
>
>  
>
and that might be the reason why I'm getting "nothing" when I'm clicking 
on a "commitdiff" link.
After investigating further, I found out that the object type ("blob" in 
the example above) is no longer printed by git-diff-tree.
Also there is a new parameter '-p' that allows the output of a patch 
directly instead of creating it with the help of temporary files as you 
do it in gitweb.
Unfortunately my perl knowledge is really poor and I didn't get it to 
work. After I changed the call to git-diff-tree to use the '-p' switch, 
I'm getting a "403 Forbidden - Reading diff-tree failed" message, but 
the same command on the command line works perfectly well. I don't know 
what is wrong there.

Could you please post a downloadable current release of gitweb to 
kernel.org that works with the current git? If not, please tell me what 
git release is installed at kernel.org so that I can use that branch to 
get it to work with gitweb.

And as a last side note it would be helpfull if you could include a 
release number in the gitweb footer as you did in the very beginning so 
that we know if something changed and there is new stuff to explore...

... keep up the great work!

Jochen
