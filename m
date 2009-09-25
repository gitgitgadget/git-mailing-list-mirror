From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone sending unneeded objects
Date: Fri, 25 Sep 2009 15:53:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909251551290.4997@xanadu.home>
References: <m2tz0j154o.fsf@igel.home>
 <alpine.LFD.2.00.0908082246020.440@xanadu.home>
 <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com>
 <vpqvdj6izt6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jason Merrill <jason@redhat.com>, git@vger.kernel.org,
	Hin-Tak Leung <hintak.leung@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 25 21:53:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrGr0-0001S3-3U
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 21:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbZIYTxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 15:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbZIYTxH
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 15:53:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19994 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbZIYTxF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 15:53:05 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQJ008DWLWLK8G0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 Sep 2009 15:53:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <vpqvdj6izt6.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129109>

On Fri, 25 Sep 2009, Matthieu Moy wrote:

> Jason Merrill <jason@redhat.com> writes:
> 
> > On 08/09/2009 03:43 AM, Andreas Schwab wrote:
> >> Nicolas Pitre<nico@cam.org>  writes:
> >>
> >>> If you do a clone using the git:// protocol and the server sends you
> >>> only the ref for the trunk branch,
> >>
> >> A clone will fetch all branches from refs/heads/*.
> >>
> >>> then it should send you only objects reachable from that branch.
> >>
> >> Apparantly this does not work.  I'd guess the extra objects are needed
> >> due to the delta compression.
> >
> > I just tried doing a clone of the GCC repository, then git gc
> > --prune=now, and another clone specifying --reference to the first,
> > and it wanted to download all the unreachable objects again.  So it
> > doesn't seem to be a compression issue.
> >
> > This is with git 1.6.4 on both ends.
> 
> Which protocol did you use?
> 
> If you use git:// or ssh://, it's normally a security feature that Git
> sends you only reachable objects. If it doesn't, it's a serious bug.

I did reproduce the issue with git:// back when this discussion started. 
I also asked for more information about the remote which didn't come 
forth.


Nicolas
