From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] upload-pack: squelch progress indicator if client does not
 request sideband
Date: Tue, 16 Jun 2009 15:46:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906161542590.16467@xanadu.home>
References: <200906142238.51725.j6t@kdbg.org>
 <7vprd4hito.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0906161354010.16467@xanadu.home>
 <200906162041.16608.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 21:47:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGecs-0006WN-16
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 21:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757127AbZFPTrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 15:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756770AbZFPTrH
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 15:47:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20214 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbZFPTrG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 15:47:06 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KLC00LVPK9Y6O30@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Jun 2009 15:46:46 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200906162041.16608.j6t@kdbg.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121708>

On Tue, 16 Jun 2009, Johannes Sixt wrote:

> On Dienstag, 16. Juni 2009, Nicolas Pitre wrote:
> > On Mon, 15 Jun 2009, Junio C Hamano wrote:
> > > Stated differently, I think "not using sideband _and_ spawned via daemon"
> > > would be an indication that "the client won't see the progress anyway
> > > even if it were sent."  So the question becomes "will it be a small
> > > enough change to detect if the upload-pack is driven by the daemon in the
> > > codepath J6t added 'if (!use_sideband)' to, and if so shouldn't we do
> > > so?"
> >
> > I don't think it is worth it at all.  The regression is purely cosmetic,
> > and I suspect you'll have a really hard time finding someone still using
> > those ancient git clients anyway.  Remember that such clients are unable
> > to fetch with HTTP from repositories using version 2 of the pack index
> > by default already.  That's why we created version 1.4.4.5.
> 
> Keep in mind that there could exist clients outside git.git that use modern
> pack-index or unpack-objects, but omit sideband support.

And that would be an abominable thing to make special support for such 
clients.  If they're fancy enough to want progress display, they should 
comply with what moderately recent native git clients do and get 
sideband support.


Nicolas
