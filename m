From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] make 'git clone' ask the remote only for objects it cares
 about
Date: Sat, 26 Sep 2009 20:26:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909262023070.4997@xanadu.home>
References: <alpine.LFD.2.00.0908082246020.440@xanadu.home>
 <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com>
 <vpqvdj6izt6.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0909251551290.4997@xanadu.home> <4ABD25FE.2040902@redhat.com>
 <alpine.LFD.2.00.0909251629330.4997@xanadu.home> <4ABD4F7B.4030701@redhat.com>
 <alpine.LFD.2.00.0909252045290.4997@xanadu.home>
 <alpine.LFD.2.00.0909252314260.4997@xanadu.home>
 <20090926195039.GG14660@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Merrill <jason@redhat.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Hin-Tak Leung <hintak.leung@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 27 02:27:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrhbR-0001II-C2
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 02:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbZI0A0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 20:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbZI0A0r
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 20:26:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25535 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbZI0A0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 20:26:46 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQL0094ST8PKJ10@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 26 Sep 2009 20:26:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090926195039.GG14660@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129188>

On Sat, 26 Sep 2009, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@fluxnic.net> wrote:
> > Current behavior of 'git clone' when not using --mirror is to fetch 
> > everything from the peer, and then filter out unwanted refs just before 
> > writing them out to the cloned repository.  This may become highly 
> > inefficient if the peer has an unusual ref namespace, or if it simply 
> > has "remotes" refs of its own, and those locally unwanted refs are 
> > connecting to a large set of objects which becomes unreferenced as soon 
> > as they are fetched.
> ...
> > +static void write_remote_refs(const struct ref *local_refs, const char *reflog)
> 
> Here reflog is now unused.  I'm going to squash this in.

Yeah, I noticed.  Since I didn't know what was the original intent for 
it, I just left it there.


Nicolas
