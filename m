From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Unexpected error: short SHA1 is ambiguous
Date: Sat, 26 Jun 2010 23:35:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006262323310.24097@xanadu.home>
References: <AANLkTikSUBgySbxtKO1iB-GYFgxaL5lY0mfbb5f_xxMS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 05:36:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSifI-00085X-48
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 05:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377Ab0F0Df0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 23:35:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37054 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab0F0Df0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 23:35:26 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L4N006Y2LZ04K00@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 26 Jun 2010 23:35:25 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTikSUBgySbxtKO1iB-GYFgxaL5lY0mfbb5f_xxMS@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149788>

On Sat, 26 Jun 2010, Jay Soffian wrote:

> In my copy of git.git:
> 
> $ git rev-list aabb^0 --
> error: short SHA1 aabb is ambiguous.
> fatal: bad revision 'aabb'
> 
> $ git rev-list --all --objects | grep ^aabb
> aabb2e515c334cbca9d9ae9873a188cef2c9b3ba
> aabb9750fddbc28091c46780ccf7b835b62b04c7 Documentation/hooks.txt
> aabb1bcbe2b8ce00ced1a749cbab5c1646e0e1f2 Documentation
> 
> So a couple things:
> 
> 1. Since I restricted to commits with ^0, and there's only one such
> commit, shouldn't rev-list give me what I want? (rev-parse similarly
> fails).

No, the ^0 is not restricting anything.  It merely says you want to walk 
through zero parents from the specified commit, but the commit 
specification is ambiguous (3 possibilities exist).

> 2. Shouldn't rev-list spit out whatever matches, even if it's
> ambiguous? (I can understand that rev-parse wouldn't, but rev-list,
> well, I expect a list of SHA1s from it.)

rev-list will give you a range of commits.  But again, which range do 
you want? There are 3 possible starting points when only specifying 
aabb.


Nicolas
