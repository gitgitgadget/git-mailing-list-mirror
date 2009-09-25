From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone sending unneeded objects
Date: Fri, 25 Sep 2009 16:47:52 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909251629330.4997@xanadu.home>
References: <m2tz0j154o.fsf@igel.home>
 <alpine.LFD.2.00.0908082246020.440@xanadu.home>
 <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com>
 <vpqvdj6izt6.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0909251551290.4997@xanadu.home> <4ABD25FE.2040902@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Hin-Tak Leung <hintak.leung@gmail.com>
To: Jason Merrill <jason@redhat.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 22:48:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrHi8-0000WV-7g
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 22:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbZIYUsC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 16:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbZIYUsB
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 16:48:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57759 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbZIYUsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 16:48:00 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQJ0038POFS9G50@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 Sep 2009 16:47:52 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4ABD25FE.2040902@redhat.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129112>

On Fri, 25 Sep 2009, Jason Merrill wrote:

> On 09/25/2009 03:53 PM, Nicolas Pitre wrote:
> > I did reproduce the issue with git:// back when this discussion started.
> > I also asked for more information about the remote which didn't come
> > forth.
> 
> Looking back, I only see you asking about the git version on the server, which
> is 1.6.4.
> 
> So again:
> 
> git clone git://gcc.gnu.org/git/gcc.git
>  (1399509 objects, ~600MB .git dir)
> git gc --prune=now (988906 objects, ~450MB .git dir)
> 
> ...then
> 
> git clone git://gcc.gnu.org/git/gcc.git --reference $firstclone
>  (573401 objects, ~550MB .git dir)
> git fsck (clean)
> git gc --prune=now (5 objects, ~7MB .git dir)
> 
> What's going on here?

Some screw up.

Do you have access to the remote machine?  Is it possible to have a 
tarball of the gcc.git directory from there?


Nicolas
