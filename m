From: Nicolas Pitre <nico@cam.org>
Subject: Re: Debugging strange "corrupt pack" errors on SuSE 9
Date: Wed, 20 Jun 2007 01:12:39 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706200102380.20596@xanadu.home>
References: <46a038f90706191936m121a94e4x1e59dff4fe217988@mail.gmail.com>
 <alpine.LFD.0.99.0706192313290.20596@xanadu.home>
 <46a038f90706192117x53420c04o27f05e8fa6c338a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	jonathan.newman@catalyst.net.nz
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 07:12:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0sUk-000853-In
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 07:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756806AbXFTFMl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 01:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757415AbXFTFMl
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 01:12:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37202 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257AbXFTFMk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 01:12:40 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJX00AV45530250@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 20 Jun 2007 01:12:39 -0400 (EDT)
In-reply-to: <46a038f90706192117x53420c04o27f05e8fa6c338a5@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50533>

On Wed, 20 Jun 2007, Martin Langhoff wrote:

> On 6/20/07, Nicolas Pitre <nico@cam.org> wrote:
> 
> > But because you push to a local repository (a mounted USB stick is
> > considered a local repo) then you don't get to negociate the pack
> > capabilities of the final destination, and therefore more "bad" delta
> > objects might sneak in again.
> 
> How does that work? So any repo we push _from_ can override (and muck
> up) the destination repo, ignoring its config?
> 
> That sounds a bit broken - the pack being built for a local
> destination should respect the settings of the destination repo.

But it does!  The problem is that _you_ are cheating it by removing the 
USB stick and mounting it somewhere else.

Then you're using cogito which bypasses things.

If you use pure git on the client machine, and actually use git-pull or 
git-fetch _without_ the -l switch then validation of the updated data 
will occur and there would be no way to muck up the destination repo.


Nicolas
