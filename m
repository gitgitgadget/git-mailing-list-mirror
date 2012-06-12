From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Mon, 11 Jun 2012 20:41:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch> <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <20120611172732.GB16086@thunk.org>
 <20120611183414.GD20134@sigill.intra.peff.net>
 <20120611211401.GA21775@thunk.org>
 <20120611213948.GB32061@sigill.intra.peff.net>
 <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ted Ts'o <tytso@mit.edu>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 02:41:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeFAj-0001hN-RB
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 02:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab2FLAlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 20:41:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34400 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012Ab2FLAlF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 20:41:05 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M5H00GCOB8FB7A0@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Jun 2012 20:41:03 -0400 (EDT)
In-reply-to: <20120611222308.GA10476@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199755>

On Mon, 11 Jun 2012, Jeff King wrote:

> On Mon, Jun 11, 2012 at 06:14:39PM -0400, Ted Ts'o wrote:
> 
> > One last thought: if a sysadmin is really hard up for space, (and if
> > the cruft objects include some really big sound or video files) one
> > advantage of labelling the cruft packs explicitly is that someone who
> > really needs the space could potentially find the oldest cruft files
> > and delete them, since they would be tagged for easy findability.
> 
> No! That's exactly what I was worried about with the name. It is _not_
> safe to do so. It's only safe after you have done a full repack to
> rescue any non-cruft objects.

To make it "safe", the cruft packs would have to be searchable for 
object retrieval, but not during object creation.  That nuance would 
affect the core code in subtle ways and I'm not sure if that would be 
worth it ... just for the safe handling of cruft.


Nicolas
