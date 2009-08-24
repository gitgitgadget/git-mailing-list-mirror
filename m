From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] remove ARM and Mozilla SHA1 implementations
Date: Mon, 24 Aug 2009 13:27:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908241318000.6044@xanadu.home>
References: <alpine.LFD.2.00.0908171940540.6044@xanadu.home>
 <alpine.DEB.1.00.0908180208160.8306@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0908240011010.6044@xanadu.home>
 <alpine.DEB.1.00.0908241333130.11375@intel-tinevez-2-302>
 <alpine.DEB.1.00.0908241849160.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 24 19:28:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfdKw-0007gY-Nn
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 19:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbZHXR1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 13:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbZHXR1u
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 13:27:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9333 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbZHXR1u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 13:27:50 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOW008J95BLHC21@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 24 Aug 2009 13:16:34 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0908241849160.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126947>

On Mon, 24 Aug 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 24 Aug 2009, Johannes Schindelin wrote:
> 
> > On Mon, 24 Aug 2009, Nicolas Pitre wrote:
> > 
> > > On Tue, 18 Aug 2009, Johannes Schindelin wrote:
> > > 
> > > > On Mon, 17 Aug 2009, Nicolas Pitre wrote:
> > > > 
> > > > > They are both slower than the new BLK_SHA1 implementation, so it is 
> > > > > pointless to keep them around.
> > > > > 
> > > > > Signed-off-by: Nicolas Pitre <nico@cam.org> ---
> > > > > 
> > > > > Someone else would need to make the call for the PPC version.
> > > > 
> > > > If I don't forget, I can test tomorrow on 2 different 32-bit PPCs and 
> > > > possibly one 64-bit PPC.
> > > 
> > > Did you forget?  ;-)
> > 
> > Yes.
> 
> At long last (XTools took a real long time to install here; it is an old 
> PowerPC running MacOSX):
> 
> Best of 10 "git rev-list --all" runs on a full Git repository (including 
> my own tree):
> 
> before 30ae47b4
> 
> 	1.85 real, 1.52 user, 0.28 sys
> 
> after 30ae47b4
> 
> 	1.86 real, 1.52 user, 0.28 sys
> 
> To be frank, the 1.85 looks like an outlier, so I think there is exactly 0 
> difference between the two.

Maybe there wasn't any _code_ difference after all.  According to the 
Makefile, only mingw defines NO_OPENSSL (although there might certainly 
be others).

TRy a build with PPC_SHA1=1, and then compare with BLK_SHA1=1.
And best is to time a fsck --full.


Nicolas
