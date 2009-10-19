From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 21:15:36 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910182112200.21739@xanadu.home>
References: <20091018144158.GA9789@gandalf.dynalias.org>
 <200910181703.20607.johan@herland.net>
 <20091018152054.GA3956@gamma.logic.tuwien.ac.at>
 <200910181923.19511.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Norbert Preining <preining@logic.at>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 03:16:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzgr1-00089A-Sq
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 03:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbZJSBPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 21:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753129AbZJSBPl
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 21:15:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50396 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbZJSBPh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 21:15:37 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRQ00IC5M609O00@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 18 Oct 2009 21:15:36 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200910181923.19511.johan@herland.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130633>

On Sun, 18 Oct 2009, Johan Herland wrote:

> On Sunday 18 October 2009, Norbert Preining wrote:
> > On So, 18 Okt 2009, Johan Herland wrote:
> > >     $ git describe
> > >     v1.0.4-14-g2414721
> > >
> > > where the "v1.0.4" part is the last tag that the current state is based
> > > on, the "14" part is the number of commit between that tag and the
> > > current
> > 
> > So if we have only one tag (initial) then it would count the number
> > of commits?
> 
> Yes. You can create the 'initial' tag with
> 
>   git rev-list HEAD | tail -n1 | xargs git tag initial
> 
> and from then on
> 
>   git describe --tags --match initial | cut -d'-' -f2

Even simpler, without any tag:

	git rev-list HEAD | wc -l

That should roughly give the equivalent of the SVN revision number.  
Valid only in one specific repository of course.


Nicolas
