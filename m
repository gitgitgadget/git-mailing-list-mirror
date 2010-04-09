From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Fri, 09 Apr 2010 15:18:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004091508340.7232@xanadu.home>
References: <loom.20100406T161552-321@post.gmane.org>
 <alpine.LFD.2.00.1004061709360.7232@xanadu.home> <4BBC1ED3.6020008@gmail.com>
 <alpine.LFD.2.00.1004070842580.7232@xanadu.home> <4BBECE44.4040608@gmail.com>
 <vpqr5mp6o1q.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Vitaly Berov <vitaly.berov@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 09 21:18:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Jj1-0004A2-Jf
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 21:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457Ab0DITS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 15:18:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24784 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab0DITS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 15:18:28 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L0M006NXIYRV8E0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 Apr 2010 15:18:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <vpqr5mp6o1q.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144459>

On Fri, 9 Apr 2010, Matthieu Moy wrote:

> Vitaly Berov <vitaly.berov@gmail.com> writes:
> 
> > Objects amount: 3997548.
> > Size of the repository: ~57Gb.
> [...]
> > By the way, we have a large amount of binary files in our rep.
> 
> This is clearly not the kind of repositories Git is good at. I
> encourage you to continue this discussion, and try to find a way to
> get it working, but the standard approach (probably a "my 2 cents"
> kind of advices, but ...) would be:
> 
> * Split your repo into smaller ones (submodules ...)
> 
> * Avoid versionning binary files

I still think that Git ought to "just work" with such a repository.
There are things that should be done for that, like applying the 
core.bigFileThreshold configuration variable to more places, such as 
delta compression, object creation, diff generation, etc.

Of course Git won't be as good at saving disk space in that case, but 
when your repo is 57GB you probably don't care much if it grows to 80GB 
but cloning it is twice as fast.

Yet, I still don't think the current issue with the receiving end of a 
clone taking 6 hours in "Resolving deltas" is normal, independently of 
core.bigFileThreshold.


Nicolas
