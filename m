From: Jeff Garzik <jeff@garzik.org>
Subject: git 1.4.0 usability problem
Date: Sun, 18 Jun 2006 09:40:06 -0400
Message-ID: <449557B6.1080907@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jun 18 15:40:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrxVg-0008MN-Qe
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 15:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWFRNkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 09:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWFRNkN
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 09:40:13 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:15595 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932233AbWFRNkM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 09:40:12 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1FrxVa-0004Sg-WA
	for git@vger.kernel.org; Sun, 18 Jun 2006 13:40:11 +0000
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22081>

Now that kernel 2.6.17 is out, I updated all my repositories to be based 
against that kernel.  And for each repository I updated, my merge was 
rejected, due to an error similar to:

> fatal: Untracked working tree file '.gitignore' would be overwritten by merge.

I am only able to merge if I delete files in the working directory, so 
that git stops complaining on merge.

This behavior is new with git 1.4.0, which Fedora Extras just added.  I 
verified that merges work as expected in git 1.3.3, the last version 
Fedora Extras shipped prior to 1.4.0.

This behavior is a definite regression, that impacts workflow :(

Here is how to reproduce:

git clone -l $url/torvalds/linux-2.6.git tmp-2.6
cd tmp-2.6
cp .git/refs/tags/v2.6.12 .git/refs/heads/tmp
git checkout -f tmp
git pull . master
# watch OBVIOUS FAST-FORWARD MERGE complain about untracked
# working tree files

Regards,

	Jeff
