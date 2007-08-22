From: Jon Loeliger <jdl@freescale.com>
Subject: Re: why git-reset needed after "cp -a" of a git repo?
Date: Wed, 22 Aug 2007 14:04:39 -0500
Message-ID: <1187809479.15321.15.camel@ld0161-tx32>
References: <200708221857.l7MIv5tD011053@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Erez Zadok <ezk@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Wed Aug 22 21:04:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INvVd-0007hm-Em
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 21:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764971AbXHVTEv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 15:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764967AbXHVTEu
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 15:04:50 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:62200 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764783AbXHVTEt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 15:04:49 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l7MJ4eKR022163;
	Wed, 22 Aug 2007 12:04:40 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l7MJ4dFW016781;
	Wed, 22 Aug 2007 14:04:40 -0500 (CDT)
In-Reply-To: <200708221857.l7MIv5tD011053@agora.fsl.cs.sunysb.edu>
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56406>

On Wed, 2007-08-22 at 13:57, Erez Zadok wrote:

> However, I noticed that after I copy a git repo (using v1.5.2.2), the index
> entries are all out of sync, and I need to run git-reset.  Why?  What's in
> the index file that changes after a cp -a or rsync that git depends on?  Is
> it atime's and if so, aren't they copied by cp -a or rsync?  If it depends
> on atime's, what happens if I mount my filesystem with noatime?  Or does
> git's index depends on inode numbers which change after a cp -a?  (BTW, I
> tried a variety of rsync options and none helped.)  I also briefly looked at
> the source code and wasn't able to find the answer.
> 
> So, is there a way to efficiently copy a git repo on a local or remote host
> w/o having to rerun git-reset afterwards?


Use "git update-index --refresh" to update time stamps in the index.

jdl
