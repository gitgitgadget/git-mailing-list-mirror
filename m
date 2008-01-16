From: Mike <fromlists@talkingspider.com>
Subject: Samba NTFS error "Could not rename the lock file?"
Date: Tue, 15 Jan 2008 22:13:31 -0500
Message-ID: <478D765B.90905@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 04:20:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEypX-0000ZB-BH
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 04:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671AbYAPDUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 22:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756657AbYAPDUP
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 22:20:15 -0500
Received: from relay00.pair.com ([209.68.5.9]:1299 "HELO relay00.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756494AbYAPDUN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 22:20:13 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2008 22:20:13 EST
Received: (qmail 23456 invoked from network); 16 Jan 2008 03:13:31 -0000
Received: from unknown (HELO ?192.168.1.100?) (unknown)
  by unknown with SMTP; 16 Jan 2008 03:13:31 -0000
X-pair-Authenticated: 72.225.213.70
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70610>


git version 1.5.2.1

I have my repository on a linux server and I'm trying to create a "git 
clone" on an NTFS samba mount. So for example:

$ git clone /www/git/amflex /mnt/NTFS80gigsamba/amflex
Could not rename the lock file?
Could not rename the lock file?
Could not rename the lock file?
Could not rename the lock file?
Initialized empty Git repository in /mnt/NTFS80gigsamba/amflex/.git/
remote: Generating pack...
remote: Done counting 156 objects.
remote: Deltifying 156 objects...
remote:  100% (156/156) done
Indexing 156 objects...
remote: Total 156 (delta 58), reused 0 (delta 0)
  100% (156/156) done
Resolving 58 deltas...
  100% (58/58) done
Could not rename the lock file?
Could not rename the lock file?

This isn't permissions because I can manually create, rename, delete all 
the files on the samba mount, using the same login account, no problem.

fstab for the samba mount is:

//192.168.1.100/NTFS80gigsamba /mnt/NTFS80gigsamba 
user,auto,file_mode=0777,dir_mode=0777,credentials=/etc/samba/auth.mike,uid=dmke 
0 0
