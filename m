From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] git-repack: -b to pass --delta-base-offset
Date: Fri, 13 Oct 2006 14:29:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610131423200.2435@xanadu.home>
References: <200610131805.k9DI5QDH016016@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 13 20:29:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYRmh-0003Km-0j
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 20:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWJMS3X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 14:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWJMS3X
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 14:29:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17787 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750988AbWJMS3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 14:29:23 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7300BEW7CK9G70@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 13 Oct 2006 14:29:08 -0400 (EDT)
In-reply-to: <200610131805.k9DI5QDH016016@laptop13.inf.utfsm.cl>
X-X-Sender: nico@xanadu.home
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28853>

On Fri, 13 Oct 2006, Horst H. von Brand wrote:

> Junio C Hamano <junkio@cox.net> wrote:
> > This new option makes the resulting pack express the delta base
> > with more compact "offset" format.
> > 
> > Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> [...]
> 
> > @@ -35,6 +35,12 @@ OPTIONS
> >  	about people fetching via dumb protocols from it.  Use
> >  	with '-d'.
> >  
> > +-b::
> > +	Pass the `--delta-base-offset` to `git pack-objects`;
> > +	see gitlink:git-pack-objects[1].  Do not use this option
> > +	if you want the repository to be accessible by older
> > +	versions of git.
> > +
> 
> Need to tell which version is the cutoff (say before 1.4.3 won't work).

Before and including 1.4.3 actually.  

Oh and the description should be augmented with "... if you want the 
repository to be accessible by older versions of git when _not_ using 
the native GIT protocol." as the native protocol is able to select 
between either format on the fly regardless of the on-disk pack format.


Nicolas
