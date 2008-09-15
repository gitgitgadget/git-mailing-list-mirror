From: Nicolas Pitre <nico@cam.org>
Subject: Re: How to replace a single corrupt, packed object?
Date: Mon, 15 Sep 2008 12:26:36 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809151223570.6279@xanadu.home>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LFD.1.10.0808102139050.22892@xanadu.home>
 <alpine.DEB.1.00.0809151603390.13830@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_8euWsgZRoi9GJ/XzVCbZMg)"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 15 18:28:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfGw5-0006Ld-J3
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 18:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743AbYIOQ1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 12:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754687AbYIOQ1R
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 12:27:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20990 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbYIOQ1R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 12:27:17 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K78009DIWCCFT80@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 15 Sep 2008 12:26:36 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0809151603390.13830@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95919>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_8euWsgZRoi9GJ/XzVCbZMg)
Content-type: TEXT/PLAIN; charset=ISO-8859-15
Content-transfer-encoding: 8BIT

On Mon, 15 Sep 2008, Johannes Schindelin wrote:

> On Sun, 10 Aug 2008, Nicolas Pitre wrote:
> 
> > On Fri, 8 Aug 2008, Johannes Schindelin wrote:
> > 
> > > my auto gc kicked in, and shows this:
> > > 
> > > fatal: corrupt packed object for 2c1e128aa51e3a64bd61556c0cd488628b423ccf
> > > error: failed to run repack
> > > 
> > > Fortunately, I have the uncorrupted object somewhere else.  So I copy the 
> > > single object as a loose one, and all is fine.  Right?
> > > 
> > > Wrong.
> > 
> > Well, to be sure things are then right or wrong, just do a 
> > 
> > 	git show 2c1e128aa51e3a64bd61556c0cd488628b423ccf
> > 
> > If you can't see the object before, and are able to see it once it has 
> > been copied over, then things are "right".
> > 
> > > Repack still picks up the corrupt object instead of the good one.  
> > > What's the best way out?
> > 
> > How do you repack?  The only way to get rid of a corrupted object in 
> > that case is to 'git repack -a -f'.
> 
> Turns out I am a complete, utter moron.  And I am sure René will quote me 
> on that.
> 
> Git would probably have taken the copied-over object, and now took the 
> copied-over pack (finally!).
> 
> My mistake was to keep the .keep file.  And the corrupt object was -- you 
> guessed it -- in the corresponding .pack file.

OK.  Then I'll dig my patch out and write a test for it before 
submitting it to Junio.


Nicolas

--Boundary_(ID_8euWsgZRoi9GJ/XzVCbZMg)--
