From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 08 Jul 2010 19:15:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1007081910480.6020@xanadu.home>
References: <20100701121711.GF1333@thunk.org>
 <AANLkTikVNkObOxGQhDJ5Qau-vYn2YcomHQW2p2zsMof9@mail.gmail.com>
 <alpine.LFD.2.00.1007081559300.6020@xanadu.home>
 <201007082320.05017.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Avery Pennarun <apenwarr@gmail.com>, Theodore Tso <tytso@mit.edu>,
	Jeff King <peff@peff.net>, Will Palmer <wmpalmer@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 01:16:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX0Ke-0004Yo-HX
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 01:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758809Ab0GHXP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 19:15:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15725 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758782Ab0GHXPK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 19:15:10 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L5900A1RHX9EV70@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 08 Jul 2010 19:15:10 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <201007082320.05017.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150619>

On Thu, 8 Jul 2010, Jakub Narebski wrote:

> If I remember correctly with pack v4 some operations like getting size
> of tree object needs encoding to current format, so they are slower than
> they should be (and perhaps a bit slower than current implementation).
> But that should be I think rare (well, unless one streams to 
> 'git cat-file --batch / --batch-check').

I didn't write the code to recreate canonical object format yet, but I 
suspect that the pack v4 object encoding will have to carry the size for 
the canonical version.

> Would pack v4 need index v4?

So far, no.

> By the way, rev-cache project was started mainly to make "counting
> objects" part of clone / fetch faster.  Would pack v4 offer the same
> without rev-cache?

That's indeed the main goal.


Nicolas
