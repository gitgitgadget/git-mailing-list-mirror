From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] fix pread()'s short read in index-pack
Date: Fri, 10 Oct 2008 10:54:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810101051280.26244@xanadu.home>
References: <20081009195518.GA1497@blimp.localhost>
 <alpine.LFD.2.00.0810092140500.26244@xanadu.home>
 <81b0412b0810092352n2a9cb5d2m6a0550354af0b397@mail.gmail.com>
 <20081010141756.GB8203@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 16:56:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoJP6-0007Cy-Gy
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 16:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368AbYJJOyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 10:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756514AbYJJOyd
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 10:54:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19248 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbYJJOyc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 10:54:32 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8J00G8H2PQAFJ0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 10 Oct 2008 10:53:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081010141756.GB8203@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97939>

On Fri, 10 Oct 2008, Shawn O. Pearce wrote:

> Alex Riesen <raa.lkml@gmail.com> wrote:
> > 2008/10/10 Nicolas Pitre <nico@cam.org>:
> > >
> > > Since v1.6.0.2~13^2~ the completion of a thin pack uses sha1write() for
> > > its ability to compute a SHA1 on the written data.  This also provides
> > > data buffering which, along with commit 92392b4a45, will confuse pread()
> > > whenever an appended object is 1) freed due to memory pressure because
> > > of the depth-first delta processing, and 2) needed again because it has
> > > many delta children, and 3) its data is still buffered by sha1write().
> > 
> > BTW, I run into complications trying to test the fix on Shawn's
> > master: conflicts,
> > and my trivial resolution wasn't good enough.
> 
> Huh.
> 
> Color me confused.  What the heck was the base version?
> 
> Near as I can tell Nico wrote this fix against a8032d12 (sha1write:
> don't copy full sized buffers).  This is in Junio's master.
> 
> But the changes conflict with what is in Junio's maint.  So the
> patch doesn't apply cleanly due to the sha1flush function's
> signature changing.
> 
> And the changes conflict with 9126f009 (fix openssl headers
> conflicting with custom SHA1 implementations), which is in my
> master, and was written by Nico.
> 
> ;-)

Whatever.

Your truly is still recovering from a knee surgery and therefore is 
literally on drugs.

> Anyway, its merged now.

Thanks.  The important thing is that it must be included in what would 
be v1.6.0.3.


Nicolas
