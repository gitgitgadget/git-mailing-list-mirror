From: Nicolas Pitre <nico@cam.org>
Subject: git-svn woes
Date: Fri, 27 Feb 2009 15:37:16 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902271442270.5511@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 21:39:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld9Ud-0001my-My
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 21:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759284AbZB0Uhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 15:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759915AbZB0Uhb
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 15:37:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9183 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760753AbZB0Uh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 15:37:29 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KFQ00544RWKE7I0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 27 Feb 2009 15:36:21 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111709>


OK... I cannot pretend to be a newbie with git.  However it's the first 
time I try git-svn and it looks like a couple basic things aren't right.

I initially cloned svn://svn.berlios.de/openocd using "git svn clone -s".
So far so good.  Now I'm attempting to update using "git svn fetch" but 
the operation always fails with the following error:

|branch_from: /openocd/branches => /openocd/branches/xscale
|Found possible branch point: 
|svn://svn.berlios.de/openocd/openocd/branches/xscale => 
|svn://svn.berlios.de/openocd/branches/xscale, 1231
|Initializing parent: xscale@1231
|Found branch parent: (xscale) 657522f3f2d1ab8b679fd5b45ce4e9ca1974af18
|Following parent with do_switch
|Scanning for empty symlinks, this may take a while if you have many empty files
|You may disable this with `git config svn.brokenSymlinkWorkaround false'.
|This may be done in a different terminal without restarting git svn
|Malformed network data: Malformed network data at /home/nico/libexec/git-core/git-svn line 3333

Thing is... the repository never gets updated and by far.  According to 
"git svn info", the fetched revision is 1232, while a separate 
repository using native svn claims to be at revision 1383.

Furthermore, the "git svn info" command produces yet more errors, such 
as:

|Use of uninitialized value $lc_author in concatenation (.) or string at /home/nico/libexec/git-core/git-svn line 964.
|Use of uninitialized value $lc_rev in concatenation (.) or string at /home/nico/libexec/git-core/git-svn line 965.
|Use of uninitialized value $t in gmtime at /home/nico/libexec/git-core/git-svn line 4743.
|Use of uninitialized value $t in numeric comparison (<=>) at /home/nico/libexec/git-core/git-svn line 4744.
|Use of uninitialized value $t in subtraction (-) at /home/nico/libexec/git-core/git-svn line 4745.
|Use of uninitialized value $t in localtime at /home/nico/libexec/git-core/git-svn line 4746.

This is with git from current "next". I cannot spend time to try fixing 
the issue myself (especially as I'm not familiar at all with the inner 
workings of svn), so my only option at the moment is to give up on 
git-svn altogether.  :-(


Nicolas
