From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Fetch by SHA missing
Date: Wed, 06 Oct 2010 16:35:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010061631420.3107@xanadu.home>
References: <alpine.LNX.2.01.1010052136280.21719@obet.zrqbmnf.qr>
 <4CAC110C.2000804@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jan Engelhardt <jengelh@medozas.de>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 06 22:35:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3aiP-0000aG-3E
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 22:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab0JFUfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 16:35:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62435 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab0JFUfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 16:35:46 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L9V002C1YJK0L40@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Oct 2010 16:35:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4CAC110C.2000804@viscovery.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158305>

On Wed, 6 Oct 2010, Johannes Sixt wrote:

> Am 10/5/2010 21:37, schrieb Jan Engelhardt:
> > Hi,
> > 
> > 
> > it is possible to select single heads/tags for download, but this does 
> > not work with SHA IDs as of 1.7.1.
> > 
> > $ git fetch linus 3c06806e690885ce978ef180c8f8b6f8c17fb4b4:x
> > fatal: Couldn't find remote ref 3c06806e690885ce978ef180c8f8b6f8c17fb4b4
> > $ git fetch linus refs/heads/master
> > remote: Counting objects: 1254, done.
> > remote: Compressing objects: 100% (234/234), done.
> > remote: Total 709 (delta 562), reused 602 (delta 475)
> > Receiving objects: 100% (709/709), 112.41 KiB, done.
> > Resolving deltas: 100% (562/562), completed with 212 local objects.
> > From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
> >  * branch            master     -> FETCH_HEAD
> 
> That's by design:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/73368/focus=73994
> 
> That is, when you accidentally push secret data, you can rewind your refs
> on the server. Even though the objects still live on the server (until
> they are garbage-collected) nobody will be able to fetch your secret stuff
> even if they happen to know the SHA1.

One improvement could be for the server to accept serving commits 
provided a raw SHA1 instead of a branch name if that SHA1 corresponds to 
a commit that is reachable through the actually exported refs.


Nicolas
