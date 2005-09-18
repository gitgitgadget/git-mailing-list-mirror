From: Dave Jones <davej@redhat.com>
Subject: Re: Fix archive-destroying "git repack -a -d" bug
Date: Sat, 17 Sep 2005 23:18:37 -0400
Message-ID: <20050918031837.GB23405@redhat.com>
References: <Pine.LNX.4.58.0509171839590.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Sep 18 05:21:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGphu-0002Xz-Fz
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 05:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVIRDSw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 23:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVIRDSw
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 23:18:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10722 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751286AbVIRDSv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Sep 2005 23:18:51 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j8I3Iclw003196;
	Sat, 17 Sep 2005 23:18:38 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j8I3IcV26566;
	Sat, 17 Sep 2005 23:18:38 -0400
Received: from nwo.kernelslacker.org (vpn83-125.boston.redhat.com [172.16.83.125])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j8I3IcfI014766;
	Sat, 17 Sep 2005 23:18:38 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.4/8.13.4) with ESMTP id j8I3IcLR028295;
	Sat, 17 Sep 2005 23:18:38 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.4/8.13.4/Submit) id j8I3IbiO028294;
	Sat, 17 Sep 2005 23:18:37 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509171839590.26803@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8776>

On Sat, Sep 17, 2005 at 06:46:40PM -0700, Linus Torvalds wrote:
 > 
 > Using "git repack -a -d" can destroy your git archive if you use it twice 
 > in succession.
 > 
 > Why? Because the new pack will be called the same as the old pack. And we 
 > delete the old packs _after_ we've moved the new pack to the .git/objects/ 
 > directory, which means that we'll delete the new pack too!

Hmm, I'm sure I've done this several times in my x86info git repo
(http://www.codemonkey.org.uk/projects/x86info/x86info.git)

It seems to look ok to git-fsck-cache though. Would that pick up
any breakage if present ?

Running git-whatchanged, the history seems to go all the way
back to the beginning of its cvs doppelganger.

		Dave
