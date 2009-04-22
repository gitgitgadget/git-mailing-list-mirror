From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Thu, 23 Apr 2009 01:30:29 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904230129290.10279@pacific.mpi-cbg.de>
References: <alpine.LFD.2.00.0904070903020.6741@xanadu.home> <20090407142147.GA4413@atjola.homenet> <alpine.LFD.2.00.0904071321520.6741@xanadu.home> <20090407181259.GB4413@atjola.homenet> <alpine.LFD.2.00.0904071454250.6741@xanadu.home> <20090407202725.GC4413@atjola.homenet>
 <alpine.LFD.2.00.0904080041240.6741@xanadu.home> <20090410T203405Z@curie.orbis-terrarum.net> <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904141542161.6741@xanadu.home> <20090414T202206Z@curie.orbis-terrarum.net>
 <1240362948.22240.76.camel@maia.lan> <alpine.LFD.2.00.0904221011340.6741@xanadu.home> <49EF93CA.20207@vilain.net> <alpine.LFD.2.00.0904221858370.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>,
	Nick Edelen <sirnot@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 23 01:31:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwluj-0004iu-Hf
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 01:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbZDVXaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 19:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbZDVXaE
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 19:30:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:47440 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751732AbZDVXaB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 19:30:01 -0400
Received: (qmail invoked by alias); 22 Apr 2009 23:29:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 23 Apr 2009 01:29:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IN582AqhIryb1wbMXu7mehI7TAiJszwZ6SIuemV
	orF+/d1FMucl2E
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0904221858370.6741@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117282>

Hi,

On Wed, 22 Apr 2009, Nicolas Pitre wrote:

> On Thu, 23 Apr 2009, Sam Vilain wrote:
> 
> > Nicolas Pitre wrote:
> > >> Now that the GSoC projects have been announced I can give you the good
> > >> news that one of our two projects is to optimise this stage in
> > >> git-daemon; I'm hoping we can get it down to being almost as cheap as
> > >> the workaround you described in your post. I'll certainly be using your
> > >> repository as a test case :-)
> > >
> > > Please keep me in the loop as much as possible. I'd prefer we're not in
> > > disagreement over the implementation only after final patches are posted
> > > to the list.
> > 
> > Thanks Nico, given your close working knowledge of the pack-objects
> > code this will be very much appreciated. Perhaps you can first help
> > out by telling me what you have to say about moving object enumeration
> > from upload-pack to pack-objects?
> 
> It is like a 25-line patch or so.  I did it once, although the shalow 
> clone support was missing from it.  And somehow I managed to lose the 
> patch while doing some reshuffling of unrelated bigger changes.
> 
> Basically, you can pass the revision arguments to pack-objects directly 
> instead of passing them to rev-list and piping rev-list's output to 
> pack-objects.

I seem to remember that somebody sent a patch within the last two weeks 
implementing that, and if my memory does not fail me, in response to one 
of your mails mentioning this wish.

Ciao,
Dscho
