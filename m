From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: fsck missing dangling commits that are candidate heads?
Date: Tue, 3 Apr 2007 19:41:26 +0000 (UTC)
Message-ID: <loom.20070403T213135-68@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 21:42:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYotC-0008QE-B4
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 21:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966207AbXDCTlp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 15:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966192AbXDCTlp
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 15:41:45 -0400
Received: from main.gmane.org ([80.91.229.2]:49490 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966207AbXDCTlo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 15:41:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HYoso-0001f7-Dr
	for git@vger.kernel.org; Tue, 03 Apr 2007 21:41:34 +0200
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 21:41:34 +0200
Received: from scallegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 21:41:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) Gecko/20060601 Firefox/2.0.0.3 (Ubuntu-edgy))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43643>

Hi,

on git 1.5.0.6, I have done the following:

work work

git commit -a

git reset HEAD^         (assume a mistake)

git fsck

the last fsck shows nothing...
Is this correct? Shouldn't the latest commit (the one made unreachable by the
reset) be reported as dangling and as a candidate branch head?

Also git lost-found misses the commit...
But it is there... I can find it manually in the object database and tag it.

And finally...

Also git gc --prune seems to miss the commit... so when we gc useless objects
appear to be kept around.

Is this correct?

Thanks,

Sergio
