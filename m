From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone sending unneeded objects
Date: Mon, 28 Sep 2009 00:18:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909280009250.4997@xanadu.home>
References: <alpine.LFD.2.00.0908082246020.440@xanadu.home>
 <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com>
 <vpqvdj6izt6.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0909251551290.4997@xanadu.home> <4ABD25FE.2040902@redhat.com>
 <alpine.LFD.2.00.0909251629330.4997@xanadu.home> <4ABD4F7B.4030701@redhat.com>
 <4ABD9C2C.60800@redhat.com> <alpine.LFD.2.00.0909262059520.4997@xanadu.home>
 <20090927020409.GK14660@spearce.org> <4ABEEB92.1020307@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Hin-Tak Leung <hintak.leung@gmail.com>
To: Jason Merrill <jason@redhat.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 06:18:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ms7hA-00013S-Qi
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 06:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbZI1ESa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 00:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbZI1ESa
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 00:18:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25483 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbZI1ES3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 00:18:29 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQN00MKMYM7ZIE0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 28 Sep 2009 00:18:07 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4ABEEB92.1020307@redhat.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129226>

On Sun, 27 Sep 2009, Jason Merrill wrote:

> On 09/26/2009 10:04 PM, Shawn O. Pearce wrote:
> > Actually, if those refs have not changed, quickfetch should kick in
> > and realize that all 410610 objects are reachable locally without
> > errors, permitting the client to avoid the object transfer.
> > 
> > However, if *ANY* of those refs were to change to something you
> > don't actually have, quickfetch would fail, and we would need to
> > fetch all 410610 objects.
> 
> Right.  That seems unfortunate to me; couldn't fetch do a bit more checking
> before it decides to download the whole world again?

The quickfetch test could be turned into a filter so refs that are 
already available locally could simply not be fetched on a per ref 
basis.  But that would be a rather expensive test which couldn't keep 
its "quick" qualifier anymore, and so for a case that shouldn't have 
happened normally anyway if git didn't have a bug with its clone 
operation as I've explained already.


Nicolas
