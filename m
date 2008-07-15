From: Nicolas Pitre <nico@cam.org>
Subject: Re: Closing the merge window for 1.6.0
Date: Mon, 14 Jul 2008 23:30:39 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807142307440.12484@xanadu.home>
References: <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
 <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
 <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
 <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
 <7vzlokhpk7.fsf@gitster.siamese.dyndns.org>
 <20080714085555.GJ32184@machine.or.cz>
 <alpine.DEB.1.00.0807141256310.8950@racer>
 <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org>
 <alpine.LFD.1.10.0807141351540.12484@xanadu.home>
 <20080715025127.GC1700@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Gerrit Pape <pape@smarden.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 05:31:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIbGO-0003pK-V5
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 05:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbYGODal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 23:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbYGODal
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 23:30:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62289 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbYGODak (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 23:30:40 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4100DIR32FK612@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Jul 2008 23:30:15 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080715025127.GC1700@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88513>

On Tue, 15 Jul 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Mon, 14 Jul 2008, Gerrit Pape wrote:
> > 
> > > On Mon, Jul 14, 2008 at 12:57:56PM +0100, Johannes Schindelin wrote:
> > > > On Mon, 14 Jul 2008, Petr Baudis wrote:
> > > > > I'm saying this because I believe the best conservative upper bound for 
> > > > > backwards compatibility is Git version in Debian stable. It gets 
> > > > > probably the most stale from all the widely used software distributions 
> > > > > using Git, and it *is* quite widely used. Etch carries v1.4.4.4, which 
> > > > > fails miserably on the new packs.
> > 
> > Maybe we can release 1.4.5 with the ability to read index v2?  That 
> > wouldn't be hard to backport the reading part of it.
> 
> If we consider that supporting 1.4.4.4 clients is still a priority,
> due to the widespread distribution of that version in a popular
> version of Debian, we shouldn't be rushing the index v2 or OFS_DELTA
> functionality on by default in 1.6.0.  

OFS_DELTA is supported by 1.4.4.4 so that's a non issue.

> Instead we would wait until Debian stable (and most other widely 
> popular distributions) are on a modern enough version of Git to 
> understand this format.

I don't think we should have git development be dictated by some 
discutable policy from one distribution.

IMHO git prior 1.5.0 is so horrible as general usability goes, and so 
different from what everybody is discussing on the net, that no one sane 
should still be using it. Even ourselves (i.e. the git community) are 
not supporting git 1.4.4 anymore so this hardly can be a priority.

As far as I know, there is no other widely popular distribution other 
than Debian using git prior 1.5.0 in their latest release. If Debian 
people want to support git 1.4.4 although we called thatversion obsolete 
_long_ ago then that's their problem.  We should not be bound by that 
external policy to which we never agreed with.

Now I proposed a compromise which consists of making 1.4.4.4+1 able to 
cope with index v2.  That should fall into Debian's "major usability 
fix" category.  I think that is a far better compromize than delaying 
index v2 even further.

> Really.  As much as I'd love to see the switch to v2 made by default
> I don't think we can/should do it unless the majority of the user
> base will be able to grok it.  And Debian etch sounds like it won't.

I truly hope the majority of the user is _not_ using 1.4.4.4.  Otherwise 
I may only have pity for them.


Nicolas
