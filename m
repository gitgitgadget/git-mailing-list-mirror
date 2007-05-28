From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form
 after-the-fact annotations on commits
Date: Mon, 28 May 2007 19:48:27 +0200
Message-ID: <200705281948.27329.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <200705281840.50814.johan@herland.net>
 <alpine.LFD.0.98.0705280957070.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 28 19:48:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsjKn-0006Zx-2H
	for gcvg-git@gmane.org; Mon, 28 May 2007 19:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbXE1Rsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 13:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbXE1Rsi
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 13:48:38 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35861 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbXE1Rsi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 13:48:38 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIR0020PISW4200@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 19:48:32 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIR0041ZISSCF90@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 19:48:28 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIR006CFISR1I40@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 28 May 2007 19:48:28 +0200 (CEST)
In-reply-to: <alpine.LFD.0.98.0705280957070.26602@woody.linux-foundation.org>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48631>

On Monday 28 May 2007, Linus Torvalds wrote:
> 
> On Mon, 28 May 2007, Johan Herland wrote:
> > 
> > I still don't see what makes note objects inherently more expensive than
> > commit objects. Except for the refs, of course, but we're getting rid
> > of those (at least replacing them with a more efficient reverse mapping).
> 
> It's exactly the refs that I worry about.
> 
> Anything that needs to read in all notes at startup is going to be _slow_.
> 
> In contrast, commits we read when (and only when) we need them.

Ok. But the reverse mapping will help with this, won't it?
We'll look up the interesting commits and find their associated
note objects directly.

BTW, if you use "git-note -l <commit>" it'll go directly to <commit>'s
subdir in refs/notes and never look at any other notes.

Of course, this currently does not help the plumbing much, which uses
for_each_note_ref() instead...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
