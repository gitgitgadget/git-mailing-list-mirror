From: Jonathon Mah <me@JonathonMah.com>
Subject: BUG: make install with FileVault on Mac OS X
Date: Mon, 7 Jul 2008 23:31:59 +0930
Message-ID: <282F8DDA-01FA-4E5B-A58F-279831E78C39@JonathonMah.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 07 16:18:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFrXd-000253-5Q
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 16:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbYGGORL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 10:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbYGGORK
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 10:17:10 -0400
Received: from bld-mail11.adl2.internode.on.net ([203.16.214.75]:48412 "EHLO
	mail.internode.on.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753557AbYGGORJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 10:17:09 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jul 2008 10:17:08 EDT
Received: from [192.168.120.11] (unverified [220.245.146.150]) 
	by mail.internode.on.net (SurgeMail 3.8f2) with ESMTP id 22959551-1927428 
	for <git@vger.kernel.org>; Mon, 07 Jul 2008 23:32:00 +0930 (CST)
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87611>

Hi,
(I don't subscribe to this list, so please copy me in on replies)

Mac OS X 10.5.4, Git 1.5.6.2

I use FileVault for my home directory: my files are stored on an  
encrypted disk image which is mounted on my home (/Users/jonathon).  
When I run "sudo make install", perllocal.pod gets written to:

/Users/jonathon/System/Library/Perl/5.8.8/darwin-thread-multi-2level/ 
perllocal.pod

under my home directory instead of at the root of the drive.  
Presumably this is because it's writing to /System at the root of the  
current mount, not at the rooty-root.

perl/perl.mak:9 reads:
#   MakeMaker ARGV: (q[PREFIX=/Users/jonathon])

which is later used to prefix /System. I don't have expertise in this  
area, so I'm hoping someone else can correct the error.


Thanks!



Jonathon Mah
me@JonathonMah.com
