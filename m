From: Perry Wagle <wagle@mac.com>
Subject: device files should be handled by git
Date: Wed, 26 Jun 2013 20:27:56 -0700
Message-ID: <21095513-708E-4F82-88D0-A312B74BA7F4@mac.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 27 06:28:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us3od-0005xa-HQ
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 06:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978Ab3F0E2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 00:28:11 -0400
Received: from nk11p04mm-asmtpout001.mac.com ([17.158.236.236]:62677 "EHLO
	nk11p04mm-asmtp001.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750871Ab3F0E2K convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 00:28:10 -0400
X-Greylist: delayed 3612 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jun 2013 00:28:10 EDT
Received: from tuple.ftrdhcpuser.net
 (static-50-43-34-150.bvtn.or.frontiernet.net [50.43.34.150])
 by nk11p04mm-asmtp001.mac.com
 (Oracle Communications Messaging Server 7u4-26.01(7.0.4.26.0) 64bit (built Jul
 13 2012)) with ESMTPSA id <0MP100B5J8AKZQ30@nk11p04mm-asmtp001.mac.com> for
 git@vger.kernel.org; Thu, 27 Jun 2013 03:27:57 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.10.8794,1.0.431,0.0.0000
 definitions=2013-06-27_02:2013-06-26,2013-06-27,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 ipscore=0 suspectscore=43 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=6.0.2-1305010000
 definitions=main-1306260271
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229086>

Hi --

I have a disk image of a small embedded device whose root file system I'd like to check-in to git as a means of distributing its GPL'd software.  In that disk image are device files, which GIT studiously ignores.  If symlinks are handled (contents being the path that the symlink points at), I don't see why device files can't be handled (contents being the type (char or block) and the major and minor device number).  TAR, for example, handles this fine, except that using tar in git sort-of goes against the granularity of the objects being modified (like adding a bunch of extra "sd??" devices), such that you are modifying a whole tar ball instead of the individual (device) files.

Is there a reason not to handle device files other than "its not traditional"?  That's the only reason given in google or the IRC channel.

Thanks!

-- Perry
