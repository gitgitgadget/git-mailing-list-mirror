From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone sending unneeded objects
Date: Fri, 25 Sep 2009 20:49:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909252045290.4997@xanadu.home>
References: <m2tz0j154o.fsf@igel.home>
 <alpine.LFD.2.00.0908082246020.440@xanadu.home>
 <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com>
 <vpqvdj6izt6.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0909251551290.4997@xanadu.home> <4ABD25FE.2040902@redhat.com>
 <alpine.LFD.2.00.0909251629330.4997@xanadu.home> <4ABD4F7B.4030701@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Hin-Tak Leung <hintak.leung@gmail.com>
To: Jason Merrill <jason@redhat.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 02:50:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrLUD-0002mt-53
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 02:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbZIZAtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 20:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbZIZAtY
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 20:49:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54749 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbZIZAtY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 20:49:24 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQJ003LTZMFMB41@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 Sep 2009 20:49:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4ABD4F7B.4030701@redhat.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129139>

On Fri, 25 Sep 2009, Jason Merrill wrote:

> On 09/25/2009 04:47 PM, Nicolas Pitre wrote:
> > Do you have access to the remote machine?  Is it possible to have a
> > tarball of the gcc.git directory from there?
> 
> http://gcc.gnu.org/gcc-git.tar.gz
> 
> I'll leave it there for a few days.

Thanks, I got it now.  And I was able to reproduce the issue locally.

Cloning the original repository does transfer objects which become 
unreferenced in the clone.  But cloning that cloned repository (before 
pruning the unreferenced objects) does not transfer those objects again.  

Just need to find out why.


Nicolas
