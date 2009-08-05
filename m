From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] RFC - Say goodbye to the rodent
Date: Wed, 05 Aug 2009 16:01:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908051558220.16073@xanadu.home>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com>
 <20090805190256.GA9004@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nazri Ramliy <ayiehere@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:01:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYmg6-00006q-Dj
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbZHEUBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbZHEUB3
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:01:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56991 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbZHEUB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:01:29 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KNX004805RN08Z0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Aug 2009 15:50:12 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090805190256.GA9004@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124959>

On Wed, 5 Aug 2009, Jeff King wrote:

> On Wed, Aug 05, 2009 at 05:51:40PM +0800, Nazri Ramliy wrote:
> 
> > The idea is that "git status --id" shows a unique id for each file in
> > its output (modified/staged/unknown/etc). The ids and the
> > corresponding filenames are stored in .git/FILE_IDS. This file gets
> > overwritten everytime you run "git status --id"
> 
> But files _already_ have a unique id: the filename. You never say why
> those unique ids must be cut-and-pasted using the mouse when your unique
> ids would be suitable for typing, but I'll assume it's because your
> unique ids are much shorter than your filenames.
> 
> There are already two classes of solutions to this problem:
> 
>   1. Make typing the filenames easier. Generally, this is accomplished
>      by tab completion. Even stock bash (and other shells) should
>      complete filenames easily, but you can also complete much more
>      using the programmable bash completion included with git.
> 
>      The main advantage of this approach is that it is totally
>      generalizable. Anytime you have to input a filename, you can use
>      it.
> 
>   2. Structure your workflow to iterate over the list of items to be
>      acted on, and then select actions for each item. This is what "git
>      add -i" does, as well as "git mergetool" and "git difftool".
> 
>      This can save a lot of typing over (1), but requires a new script
>      for every such workflow (e.g., the scripts above cover only adding,
>      resolving merges, and diffing; you would need a new script to
>      iterate over files, doing "git checkout" on each one, for example).

BTW I often use this incantation:

	xargs git add
	[paste list of files obtained from git status output]
	^D


Nicolas
