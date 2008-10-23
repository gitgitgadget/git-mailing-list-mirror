From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC PATCH 4/5] pack-objects: avoid reading uninitalized data
Date: Thu, 23 Oct 2008 12:47:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810231246040.26244@xanadu.home>
References: <20081022202810.GA4439@coredump.intra.peff.net>
 <20081022203103.GD4547@coredump.intra.peff.net>
 <alpine.LFD.2.00.0810222107540.26244@xanadu.home>
 <20081023153329.GC10804@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 23 18:48:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt3MJ-0007Sm-44
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 18:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbYJWQrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 12:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657AbYJWQrL
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 12:47:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12256 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbYJWQrK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 12:47:10 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K97006TRAMFPFQG@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 23 Oct 2008 12:47:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081023153329.GC10804@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98976>

On Thu, 23 Oct 2008, Jeff King wrote:

> On Wed, Oct 22, 2008 at 09:11:16PM -0400, Nicolas Pitre wrote:
> 
> > >  	for (;;) {
> > > -		struct object_entry *entry = *list++;
> > > +		struct object_entry *entry;
> > >  		struct unpacked *n = array + idx;
> > >  		int j, max_depth, best_base = -1;
> > >  
> > > @@ -1384,6 +1384,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
> > >  			progress_unlock();
> > >  			break;
> > >  		}
> > 
> > ---> Please preserve the empty line here so the previous code
> >      chunk still appears logically separate.
> > 
> > > +		entry = *list++;
> > >  		(*list_size)--;
> > >  		if (!entry->preferred_base) {
> > >  			(*processed)++;
> 
> Er, there was no empty line there (or else there would have been a '-'
> line in the diff).

Oh, right.  I'm confused.
Nevermind...


Nicolas
