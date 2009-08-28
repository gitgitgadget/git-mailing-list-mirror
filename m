From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees
 with various fanout schemes
Date: Fri, 28 Aug 2009 10:48:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908281046560.7434@intel-tinevez-2-302>
References: <1251337437-16947-1-git-send-email-johan@herland.net> <1251337437-16947-9-git-send-email-johan@herland.net> <7v7hwp6ebb.fsf@alter.siamese.dyndns.org> <200908271135.31794.johan@herland.net> <alpine.DEB.1.00.0908271243120.7562@intel-tinevez-2-302>
 <7vprahq8iv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 10:48:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgx85-0004uh-Co
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 10:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbZH1IsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 04:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbZH1IsK
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 04:48:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:56659 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752463AbZH1IsI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 04:48:08 -0400
Received: (qmail invoked by alias); 28 Aug 2009 08:48:09 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 28 Aug 2009 10:48:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19I/NZd/H5IUJ0kgdXMh52S/NeTMYcMdDgxPJfZgE
	YnVb9GsLXuxe/Z
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vprahq8iv.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127281>

Hi,

On Thu, 27 Aug 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I half-agree, the code should decide which fanout scheme to use, but 
> > _only_ when producing new notes.
> >
> > I imagine that it could merge the existing notes, and try to make sure 
> > that there are no more blobs in a given subtree than a certain 
> > threshold; if that threshold is reached, it could fan-out using 
> > 2-digit subtrees, merging what needs merging (by concatenation) along 
> > the way.
> >
> > The natural precedence of shallower paths/longer basenames should cope 
> > well with that (i.e. prefer to show abcd/... over ab/cd/...).
> 
> Oh, if the plan for merging the trees is such that it takes care of 
> "multiple notes pointing at the same commit" issues like you outline, 
> then I can see it would work nicely.
> 
> At that point, fan-out would become merely an implementation detail, 
> something the end user never needs to worry about, just like what base 
> object is chosen to represent another object in a packfile.

Oh, that's where you're coming from!  Now I understand your concerns; it 
never occurred to me that the user should be encouraged to add notes to 
the tree herself.  I was always under the impression that the fan-out is 
an implementation detail best hidden from the user.

Ciao,
Dscho
