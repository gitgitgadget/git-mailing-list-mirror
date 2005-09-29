From: Richard Curnow <rc@rc0.org.uk>
Subject: git push to a local directory with no .git in it
Date: Thu, 29 Sep 2005 23:25:59 +0000 (UTC)
Message-ID: <loom.20050930T011606-58@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 30 01:33:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL7tJ-0005R4-Me
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 01:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbVI2Xcj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 19:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVI2Xcj
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 19:32:39 -0400
Received: from main.gmane.org ([80.91.229.2]:28134 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751366AbVI2Xci (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 19:32:38 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EL7sG-0005Jg-0m
	for git@vger.kernel.org; Fri, 30 Sep 2005 01:31:36 +0200
Received: from rpcurnow.force9.co.uk ([84.92.131.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Sep 2005 01:31:36 +0200
Received: from rc by rpcurnow.force9.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Sep 2005 01:31:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.92.131.215 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050512 Firefox/1.0.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9525>

Background: I have to use plain FTP to upload content to my web site.  I keep a
local mirror of the entire site, then use an automated upload mechanism to do
the FTP step.

To release a git repository onto my site, I want to 'git push' from my working
area to the release area in the local mirror.  So what ends up as

    http://www.rpcurnow.force9.co.uk/git/mairix.git

lives in ~/homepage/git/mairix.git locally.  That directory contains
HEAD, refs, objects, hooks; I don't have a .git subdirectory in the middle.

If I cd to ~/gitwork/mairix (which is a regular working area) and do

    git push ~/homepage/git/mairix.git master:master

I get

fatal: /home/richard/homepage/git/mairix.git doesn't appear to be a git directory

presumably because there is no .git in it.

I could cd to ~/homepage/git/mairix.git and do things like

    GIT_DIR=. gitk --all

but what's the equivalent of this GIT_DIR trick when it's the remote end of
a 'git push' that has the problem?

Cheers
Richard
