From: Dave Jones <davej@redhat.com>
Subject: Re: The big git command renaming..
Date: Fri, 29 Apr 2005 17:35:40 -0400
Message-ID: <20050429213540.GA1691@redhat.com>
References: <Pine.LNX.4.58.0504291416190.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 23:34:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRd6n-0006Qw-Tp
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbVD2Vhr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 17:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbVD2Vhl
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 17:37:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15842 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263019AbVD2Vfo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 17:35:44 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j3TLZewO010980;
	Fri, 29 Apr 2005 17:35:40 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j3TLZeO02205;
	Fri, 29 Apr 2005 17:35:40 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j3TLZexK002668;
	Fri, 29 Apr 2005 17:35:40 -0400
Received: (from davej@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id j3TLZejZ002666;
	Fri, 29 Apr 2005 17:35:40 -0400
X-Authentication-Warning: devserv.devel.redhat.com: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504291416190.18901@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 02:24:43PM -0700, Linus Torvalds wrote:
 > 
 > Ok, I hate to do this, since my fingers have already gotten used to the 
 > old names, but we clearly can't continue to use command names like 
 > "update-cache" or "read-tree" that are totally non-git-specific.
 > 
 > So I just pushed out a change that renames the commands to always have a 
 > "git-" prefix. In addition, I renamed "show-diff" to "diff-files", with 
 > together with the prefix means that it becomes "git-diff-files" when used.
 > 
 > Since I end up using tab-completion for almost all my work, and since
 > -within- the source directory there's no confusion, I didn't actually name
 > the source files with any git- prefix. Quite the reverse: I removed the
 > prefix from the two .c files that already had it (so git-mktag.c is now
 > just "mktag.c"), and the general rule for building the executable from a C 
 > file is now
 > 
 > 	git-%: %.c $(LIB_FILE)
 > 		$(CC) $(CFLAGS) -o $@ $(filter %.c,$^) $(LIBS)
 > 
 > 
 > this seemed to be a nice regular interface that means that binaries get 
 > installed with clear "git-" prefixes, but that I don't have to look at 
 > them when I edit the sources.

Can you push out a new tarball to kernel.org too please, to kill
some potential confusion in documentation/scripts ?

		Dave


