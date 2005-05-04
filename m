From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: git and symlinks as tracked content
Date: Wed, 04 May 2005 11:48:22 -0400
Message-ID: <4278EEC6.2090607@dwheeler.com>
References: <1115145234.21105.111.camel@localhost.localdomain>	<Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>	<Pine.LNX.4.58.0505031255000.30768@sam.ics.uci.edu>	<Pine.LNX.4.58.0505031304140.26698@ppc970.osdl.org> <7vr7got2tz.fsf@assigned-by-dhcp.cox.net> <42780185.7010204@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, Andreas Gal <gal@uci.edu>,
	Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 17:43:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTM0p-0006Ip-4u
	for gcvg-git@gmane.org; Wed, 04 May 2005 17:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVEDPsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 11:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVEDPsi
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 11:48:38 -0400
Received: from aibo.runbox.com ([193.71.199.94]:61416 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261889AbVEDPse (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 11:48:34 -0400
Received: from [10.9.9.110] (helo=snoopy.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DTM6m-0004GV-AQ; Wed, 04 May 2005 17:48:20 +0200
Received: from [129.246.254.14] (helo=[129.246.80.140])
	by snoopy.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DTM6m-0004Uf-0l; Wed, 04 May 2005 17:48:20 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42780185.7010204@zytor.com>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
 >Also, right now git will actually ignore most of the permission bits 
too.  
 >We can change that, and make it a dynamic setting somewhere (some flag in
 >a ".git/settings" file or something), but it does boil down to the fact
 >that a software development tree tracker wants different things than
 >something that tracks system settings.
...
 >So if you want to track system files, right now "raw git" is _not_ the 
way
 >to do it. You'd want something else.
...
 >But if you'd want to track other system directories with git, you'd
 >probably need to either (a) do serious surgery on git itself, or (probably
 >preferable) by (b) track the extra things you want "manually" using a file
 >(that is tracked in git) that describes the ownership and permission data.
 >
 >Whether git is really suitable for tracking non-source projects is
 >obviously debatable. It's not what it was designed for, and it _may_ be
 >able to do so partly just by luck.

I suspect there's a 95% point which is easily achieved, &
beyond that it's not clear it's worth it.

I recall seeing several source code directories that actually use symlinks
in their source, and thus would want them preserved by the SCM.
(Not arguing that's the BEST plan, merely an observation).
As this discussion has noted, that wouldn't be hard to add symlink
support to git, and WOULD be helpful for its primary purpose as SCM support.

Once you're there, it wouldn't be hard to add logic to add options to
(1) record the REAL permission bits, (2) record "." files, and
(3) recover the permission bits.  That would be enough to
store & recover in a distributed way a single person's home directory.
THAT might be darn useful, for those of us who float between
different systems & would like to use a single system for multiple purposes.
That's clearly beyond the scope of a typical SCM, but since
it's easy to get there, that'd make sense.

I'm ambivalent about supporting dev, uid/gid, and mtime, and how
it should be done; that may be beyond the "worth it" step.

--- David A. Wheeler

