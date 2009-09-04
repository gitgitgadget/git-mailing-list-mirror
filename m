From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special 
 case
Date: Fri, 4 Sep 2009 20:02:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909041930450.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org> <fabb9a1e0909032229k5e6e2ed5mc11e8ff9c16dfcc0@mail.gmail.com> <alpine.LNX.2.00.0909041114440.28290@iabervon.org> <7vy6ouk4io.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 20:01:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjd63-0005GW-1o
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 20:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179AbZIDSBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 14:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757177AbZIDSBD
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 14:01:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:40898 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757175AbZIDSBC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 14:01:02 -0400
Received: (qmail invoked by alias); 04 Sep 2009 18:01:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 04 Sep 2009 20:01:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Kr/Bo1eWK03gOr85dCdhXQyg9WdDrNOCm7dnG6I
	ya+byUzfz0rCF7
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vy6ouk4io.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127753>

Hi,

On Fri, 4 Sep 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > It turns out that the method used to form URLs that use a helper 
> > doesn't generalize well to other cases, because it interferes with the 
> > ssh-style locations. Instead, some different mechanism needs to be 
> > made up to handle arbitrary handlers that git doesn't know about. 
> > Since we want to keep supporting "http://something", that'll have to 
> > be a special case anyway, and so we might as well handle it by having 
> > git know what helpers to use for things that we've always supported, 
> > and use a single descriptive name for the helper that handles that 
> > collection of URLs.
> >
> > As of this version, the idea is that there will be three ways helpers 
> > get selected:
> >
> >  - git selects a helper based on the URL being something traditionally 
> >    supported internally; that is, git recognizes the URL and knows 
> >    what to run, if possible, to handle it
> >
> >  - git uses the "vcs" option if it is set
> >
> >  - something with the URL that we don't understand well enough yet to 
> >    design, but which doesn't seem to be possible to fit in as a single 
> >    rule with the first item.
> 
> Thanks for a clear description.
> 
> I do not see that there is much difference between the above description
> and what Dscho is advocating, and I do not see anything to get excited
> about as Dscho seems to do.

I mainly take exception at complicating things with a "vcs" config 
variable.

The way you describe it, I like it, as I do not see any mention of said 
config variable there.

If you allow "git clone <URL>" for foreign vcs URLs, you do not need the 
"vcs" variable.  If you require that variable, you cannot allow an easy 
clone, and you will earn my opposition.

Ciao,
Dscho
