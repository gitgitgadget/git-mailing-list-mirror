From: Tim Janik <timj@imendio.com>
Subject: git-svn breaks on gtk+ import
Date: Fri, 7 Mar 2008 19:00:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0803071844510.27175@master.birnet.private>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Mar 07 19:23:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXhDm-0004Ar-UR
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 19:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762086AbYCGSVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 13:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762168AbYCGSVs
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 13:21:48 -0500
Received: from mx02.hansenet.de ([213.191.73.26]:37778 "EHLO
	webmail.hansenet.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762086AbYCGSVq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 13:21:46 -0500
X-Greylist: delayed 1254 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Mar 2008 13:21:46 EST
Received: from birnet.org (85.176.207.234) by webmail.hansenet.de (7.3.118.12)
        id 47CBEF7600F7E2BE; Fri, 7 Mar 2008 19:00:41 +0100
Received: from master.birnet.private (timj@localhost [127.0.0.1])
	by birnet.org (8.13.8/8.13.8/Debian-3) with ESMTP id m27I0cqq027505
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 7 Mar 2008 19:00:39 +0100
Received: (from timj@localhost)
	by master.birnet.private (8.13.8/8.13.8/Submit) id m27I0bLv027504;
	Fri, 7 Mar 2008 19:00:37 +0100
X-X-Sender: timj@master.birnet.private
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76507>

hi Eric.

with git-svn from git 1.5.4.3, imports of the Gtk+ repository fail:

   git-svn clone -T trunk -b branches -t tags -r 19001 http://svn.gnome.org/svn/gtk+
   Using existing [svn-remote "svn"]
   Using higher level of URL: http://svn.gnome.org/svn/gtk+ => http://svn.gnome.org/svn/gtk%2B/http:
   No such file or directory: PROPFIND request failed on '/svn/gtk%252B/http%3A': Could not open the requested SVN filesystem at /usr/bin/git-svn line 1352

trying the same for glib works fine:

   git-svn clone -T trunk -b branches -t tags -r 6601 http://svn.gnome.org/svn/glib
   [...]
   r6601 = 987f6388b211281d08fce0e63936d9e612ed4d4f (trunk)
   Checked out HEAD:
     http://svn.gnome.org/svn/glib/trunk r6601

looks like the '+' in the the http://svn.gnome.org/svn/gtk+ repository
name isn't handled correctly.

---
ciaoTJ
