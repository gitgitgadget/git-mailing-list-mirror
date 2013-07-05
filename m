From: David Rothenberger <daveroth@acm.org>
Subject: git-svn "Temp file with moniker 'svn_delta' already in use" and skelta
 mode
Date: Fri, 05 Jul 2013 13:48:32 -0700
Message-ID: <kr7beq$ilk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 05 22:55:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvD28-0006eq-SZ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 22:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373Ab3GEUzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 16:55:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:39103 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961Ab3GEUzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 16:55:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UvD20-0006WH-0T
	for git@vger.kernel.org; Fri, 05 Jul 2013 22:55:04 +0200
Received: from c-24-16-16-7.hsd1.wa.comcast.net ([24.16.16.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 22:55:04 +0200
Received: from daveroth by c-24-16-16-7.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 22:55:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-16-7.hsd1.wa.comcast.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229681>

I recently upgraded my Subversion server to 1.8.0 and started
receiving the following error from "git svn fetch":

Temp file with moniker 'svn_delta' already in use at /usr/lib/perl5/vendor_perl/5.10/Git.pm line 1024.

This occurs only when using an http:// URL; svn:// URLs work fine.

I think this is related to skelta mode [1] with serf. When I add
"SVNAllowBulkUpdates Prefer" to mod_dav configuration, the error
goes away. (Similarly, if I add "http-bulk-updates = yes" to
~/.subversion/servers.)

The server is running WanDisco's 1.8.0 distribution on 64-bit Debian
7.0. The client is Cygwin: svn version 1.8.0 and git version
1.8.3.2.

I initially reported this to the subversion users mailing list, but
was (not so politely) told to report this to the git-svn authors.
I'm not so sure, since the problem goes away simply by downgrading
the subversion-perl bindings back to 1.7.

[1] http://subversion.apache.org/docs/release-notes/1.8.html#serf-skelta-default

-- 
David Rothenberger  ----  daveroth@acm.org

Teutonic:
        Not enough gin.
