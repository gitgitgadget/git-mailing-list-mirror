From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
Date: Sun, 11 Sep 2005 14:24:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
 <20050911185711.GA22556@mars.ravnborg.org> <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
 <20050911194630.GB22951@mars.ravnborg.org> <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
 <52irx7cnw5.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Peter Osterlund <petero2@telia.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 23:25:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEZJs-00081L-Mq
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 23:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbVIKVYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 17:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbVIKVYz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 17:24:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57751 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750881AbVIKVYy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 17:24:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8BLOnBo026257
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Sep 2005 14:24:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8BLOm1k022803;
	Sun, 11 Sep 2005 14:24:48 -0700
To: Roland Dreier <rolandd@cisco.com>
In-Reply-To: <52irx7cnw5.fsf@cisco.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8334>



On Sun, 11 Sep 2005, Roland Dreier wrote:
> 
> Does "everything" include someone doing
> 
>     git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/whatever.git

Nope. Only server-side smart protocols will handle this.

There is such an anonymous server, btw: "git-daemon" implements anonymous 
access much more efficient than rsync/http. Sadly, kernel.org still 
doesn't offer it (but it's now used in the wild, ie I've done a couple of 
merges with people running the git daemon).

> In other words, is the git network transport smart enough to handle
> the alternates path?

The _git_ network transport is. rsync and http aren't.

		Linus
