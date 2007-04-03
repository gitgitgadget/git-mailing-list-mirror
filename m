From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Distribution of longest common hash prefixes
Date: Tue, 3 Apr 2007 10:50:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031046150.6730@woody.linux-foundation.org>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
 <Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
 <86bqi6kae7.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0704020938470.6730@woody.linux-foundation.org>
 <86y7laitlz.fsf@blue.stonehenge.com> <86r6r2isva.fsf@blue.stonehenge.com>
 <m3r6r1jsmq.fsf@lugabout.jhcloos.org> <867istcrhr.fsf@blue.stonehenge.com>
 <20070403172123.GD27706@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	James Cloos <cloos@jhcloos.com>, git@vger.kernel.org,
	Peter Eriksen <s022018@student.dtu.dk>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 19:52:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYnAW-0006KT-EV
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 19:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbXDCRvF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 13:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbXDCRvF
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 13:51:05 -0400
Received: from smtp.osdl.org ([65.172.181.24]:34027 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161035AbXDCRvC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 13:51:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l33HoaPD017334
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 10:50:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l33HoYdM031537;
	Tue, 3 Apr 2007 10:50:34 -0700
In-Reply-To: <20070403172123.GD27706@spearce.org>
X-Spam-Status: No, hits=-0.458 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43634>



On Tue, 3 Apr 2007, Shawn O. Pearce wrote:
> 
> Well, the other thing is those 2 commits at 9 bytes probably were
> not that way a year ago.  One of those might have only needed 8,
> and the other is newer, so now you need 9.

Well, neither of the the two objects at 9 bytes may not be (and probably 
aren't) commits and of the 32 8-nibble cases who knows how many are 
actually commits (probably none), so an 8-byte SHA1 is *probably* unique 
at least if you just look at commits.

Remove the "--objects" to find out.

> What the above tells me is that 8 is almost a safe default for our
> abbreviations, but isn't safe enough, as there are collisions past 8.

Yeah, the short SHA1 form is obviously always going to be risky. But in 
practice, since people almost always use it just for commits, it's 
probably good enough in practice, and even if you get a collision in 8 
nibbles, most of the time it will probably be trivial to figure out which 
one was meant, so it's not like it's a disaster if somebody ends up 
reporting a bug with a non-unique abbreviation.

		Linus
