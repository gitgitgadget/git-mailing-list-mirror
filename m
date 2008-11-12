From: "Paul E. Rybski" <prybski@cs.cmu.edu>
Subject: running out of memory when doing a clone of a large repository?
Date: Wed, 12 Nov 2008 13:49:52 -0500
Message-ID: <491B2550.1050005@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 20:11:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0L7n-0006gD-R8
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 20:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbYKLTKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 14:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752453AbYKLTKO
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 14:10:14 -0500
Received: from SMTP.andrew.cmu.edu ([128.2.10.85]:43359 "EHLO
	smtp.andrew.cmu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbYKLTKM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 14:10:12 -0500
X-Greylist: delayed 1217 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Nov 2008 14:10:12 EST
Received: from [192.168.1.4] (HAMMERHEAD.CORAL.CS.CMU.EDU [128.2.195.176])
	(user=prybski mech=PLAIN (0 bits))
	by smtp.andrew.cmu.edu (8.13.8/8.13.8) with ESMTP id mACInqkk027192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 12 Nov 2008 13:49:52 -0500
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang 2.60 on 128.2.10.85
X-Scanned-By: MIMEDefang 2.60 on 128.2.10.85
X-PMX-Version: 5.4.6.353000, Antispam-Engine: 2.6.1.350677, Antispam-Data: 2008.11.12.183718
X-SMTP-Spam-Clean: 8% (BODY_SIZE_1900_1999 0, BODY_SIZE_5000_LESS 0, __C230066_P5 0, __CP_AGE_BODY 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0)
X-SMTP-Spam-Score: 8%
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100802>

Hi,
	I've recently started evaluating git for use on one of my projects.  I
used git-svn to convert a fairly large subversion repository and one of
its branches into two separate git repositories following the
instructions found here:

http://www.simplisticcomplexity.com/2008/03/05/cleanly-migrate-your-subversion-repository-to-a-git-repository/

>From that, I created a 1.5G repository from the trunk of the subversion
repo and a 1.1G repository from one of the branches.  I then tried to
clone the repositories from one machine to another via ssh and the
smaller 1.1G repository of the subversion branch (with 1932 commits)
came over just fine but the larger 1.5G repository of the subversion
trunk (5865 commits) died with the following error:

remote: Counting objects: 48415, done.
remote: warning: suboptimal pack - out of memory
error: git-upload-pack: git-pack-objects died with error.
fatal: git-upload-pack: aborting due to possible repository corruption
on the remote side.
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
fatal: index-pack failed

Is this simply because the git repository is too large for the machine
that's trying to send it over ssh?  Is there a way to restrict the
memory usage of git or do I need to get more RAM or somehow not import
the full subversion history of my original trunk?

I'm using Ubuntu 8.04.1 on both machines and using the Ubuntu packages
of git version 1.5.4.3.  The machine holding the repository is a 5-year
old AthlonXP 3200 with 1G RAM and 32-bit Ubuntu.  The machine I'm
cloning the repository on is a more recent Intel Dual Core Quad Q6600
with 4GRAM and 64-bit Ubuntu.

Any advice would be greatly appreciated.

Thanks!

-Paul

-- 
Paul E. Rybski, Ph.D., Systems Scientist
The Robotics Institute, Carnegie Mellon University
Phone: 412-268-7417, Fax: 412-268-7350
Web: http://www.cs.cmu.edu/~prybski
