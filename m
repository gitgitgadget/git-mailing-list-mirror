From: carbonated beverage <ramune@net-ronin.org>
Subject: empty ident error on pull
Date: Fri, 17 Feb 2006 23:05:00 -0800
Message-ID: <20060218070500.GA12259@prophet.net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Feb 18 08:05:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAM9W-0000yb-KG
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 08:05:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWBRHFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 02:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWBRHFE
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 02:05:04 -0500
Received: from S0106000ea6c7835e.no.shawcable.net ([70.67.106.153]:65169 "EHLO
	prophet.net-ronin.org") by vger.kernel.org with ESMTP
	id S1750937AbWBRHFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 02:05:03 -0500
Received: from ramune by prophet.net-ronin.org with local (Exim 3.35 #1 (Debian))
	id 1FAM9N-0003Cq-00
	for <git@vger.kernel.org>; Fri, 17 Feb 2006 23:05:01 -0800
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16395>

I'm tracking the Linux kernel repo via git, and got the following:

barbeque/zarathustra:linux-2.6: git pull
Unpacking 885 objects
 100% (885/885) done
* refs/heads/origin: fast forward to branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
Auto-following refs/tags/v2.6.16-rc4
Unpacking 1 objects
 100% (1/1) done
* refs/tags/v2.6.16-rc4: storing tag 'v2.6.16-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
Trying really trivial in-index merge...
Wonderful.
fatal: empty ident  <barbeque@zarathustra.internal.psychosnugglebunnies.net.> not allowed

Then I tried the following:

barbeque/zarathustra:linux-2.6: git-fsck-objects
dangling tree 47678b69f7dcc6d5fcae007d1e4fe511fd260e5b
barbeque/zarathustra:linux-2.6: git prune
barbeque/zarathustra:linux-2.6: git-fsck-objects
barbeque/zarathustra:linux-2.6: git pull
* refs/heads/origin: same as branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
Trying really trivial in-index merge...
Wonderful.
fatal: empty ident  <barbeque@zarathustra.internal.psychosnugglebunnies.net.> not allowed

Okay... so... what now?  I'm still a bit clueless when it comes to git.  Using
it for some of my personal projects has gotten me a bit more comfortable with
it, but my usage is still along the lines of "CVS without warts", for now.

(And yes, it's the concept of the index file that's still throwing me for
a loop :-)

I was tracking the repo with "current" versions of git until I got the above
error message the first time.  Went to a 1.1.6 tarball of git, pulled the
repro from scratch, all seemed well.  Upgraded to 1.2.1, tried a pull today,
and got the above.

The system above is a Debian/sarge amd64 system, using gcc 3.3.5.

-- DN
Daniel
