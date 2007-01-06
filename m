From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Sat, 6 Jan 2007 01:06:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701060103190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
 <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
 <7v1wmalez6.fsf@assigned-by-dhcp.cox.net> <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
 <7vbqldfg56.fsf@assigned-by-dhcp.cox.net> <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
 <20070105193958.GE8753@spearce.org> <7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701051354590.3661@woody.osdl.org>
 <Pine.LNX.4.64.0701051439060.3661@woody.osdl.org> <7vac0xdr97.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701051457020.3661@woody.osdl.org> <7virflca43.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Chris Lee <chris133@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 06 01:07:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2z5e-0000ag-82
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 01:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbXAFAHF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 19:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbXAFAHF
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 19:07:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:41433 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750935AbXAFAHD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 19:07:03 -0500
Received: (qmail invoked by alias); 06 Jan 2007 00:07:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 06 Jan 2007 01:07:00 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virflca43.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36054>

Hi,

On Fri, 5 Jan 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> >> Ah, there are those annoying "using this as the merge base whose
> >> commit log is..." business.  I wonder if anybody is actually
> >> reading them (I once considered squelching that output).
> >
> > "output_commit_title()" used it. Not just for the merge base, but for the 
> > regular "merging X and Y" messages, I think.
> 
> Yes, what I really was wondering were (1) if the messages are
> useful, and (2) if so should that belong to git-merge not
> git-merge-recursive.

Since recursive merge performs possibly more than one merge, it belongs 
into merge-recursive.c, _if_ we want that message.

I found it helpful for "debugging" failed _recursive_ merges. I.e. I knew 
which of the recursive merges introduced the many, many conflicts. But I 
cannot remember off-hand if that was a test merge, and if it was before, 
or after, I sorted the merge bases by date.

Since the conflict markers now say which commit the conflicts came from, I 
am okay with removing the message, though.

Ciao,
Dscho
