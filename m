From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Wed, 22 Apr 2009 19:07:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904221858370.6741@xanadu.home>
References: <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
 <20090407142147.GA4413@atjola.homenet>
 <alpine.LFD.2.00.0904071321520.6741@xanadu.home>
 <20090407181259.GB4413@atjola.homenet>
 <alpine.LFD.2.00.0904071454250.6741@xanadu.home>
 <20090407202725.GC4413@atjola.homenet>
 <alpine.LFD.2.00.0904080041240.6741@xanadu.home>
 <20090410T203405Z@curie.orbis-terrarum.net>
 <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904141542161.6741@xanadu.home>
 <20090414T202206Z@curie.orbis-terrarum.net>
 <1240362948.22240.76.camel@maia.lan>
 <alpine.LFD.2.00.0904221011340.6741@xanadu.home> <49EF93CA.20207@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Nick Edelen <sirnot@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 01:09:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwlZG-0007lE-1z
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 01:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbZDVXHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 19:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbZDVXHv
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 19:07:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24976 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbZDVXHu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 19:07:50 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KII002P7YWUJKT0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Apr 2009 19:07:43 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <49EF93CA.20207@vilain.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117280>

On Thu, 23 Apr 2009, Sam Vilain wrote:

> Nicolas Pitre wrote:
> >> Now that the GSoC projects have been announced I can give you the good
> >> news that one of our two projects is to optimise this stage in
> >> git-daemon; I'm hoping we can get it down to being almost as cheap as
> >> the workaround you described in your post. I'll certainly be using your
> >> repository as a test case :-)
> >
> > Please keep me in the loop as much as possible. I'd prefer we're not in
> > disagreement over the implementation only after final patches are posted
> > to the list.
> 
> Thanks Nico, given your close working knowledge of the pack-objects
> code this will be very much appreciated. Perhaps you can first help
> out by telling me what you have to say about moving object enumeration
> from upload-pack to pack-objects?

It is like a 25-line patch or so.  I did it once, although the shalow 
clone support was missing from it.  And somehow I managed to lose the 
patch while doing some reshuffling of unrelated bigger changes.

Basically, you can pass the revision arguments to pack-objects directly 
instead of passing them to rev-list and piping rev-list's output to 
pack-objects.

Nicolas
