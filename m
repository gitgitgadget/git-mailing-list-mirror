From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] cvsserver: Fix req_update to handle packed refs
Date: Thu, 4 Oct 2007 22:58:32 +0200
Message-ID: <20071004205832.GF31659@planck.djpig.de>
References: <1191525680-10481-1-git-send-email-frank@lichtenheld.de> <46a038f90710041343g5b6a5a30gcd0c9f18d265fa28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 22:59:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdXmq-000584-5N
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 22:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759543AbXJDU6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 16:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759468AbXJDU6o
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 16:58:44 -0400
Received: from planck.djpig.de ([85.10.192.180]:4346 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757920AbXJDU6m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 16:58:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 79F1D88231;
	Thu,  4 Oct 2007 22:58:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PYiAsZGEhbMe; Thu,  4 Oct 2007 22:58:32 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id D3D4188232; Thu,  4 Oct 2007 22:58:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46a038f90710041343g5b6a5a30gcd0c9f18d265fa28@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60001>

On Fri, Oct 05, 2007 at 09:43:55AM +1300, Martin Langhoff wrote:
> On 10/5/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> > cvsserver returns a list of existing modules on command
> > 'update' without a module specified (apparently this is
> > used by some clients to get a list of available modules,
> > the CVS cli client doesn't support it).
> >
> > Fix this code to work correctly in presence of packed refs.
> > (Use git-branch instead of reading refs/heads/)
> 
> ACK - good stuff - thanks!
> 
> There is one minor issue around this I suspect - refs with slashes in
> them. Without this patch, only refs that literally sit in refs/heads
> will be returned. With git branches, you could see oldbranches/foo
> being returned to the client.
> 
> IIRC - the behaviour cvsserver supports here is completely
> unspecified, and clients will probably error out in weird and wacky
> ways. I'd perhaps filter out any headref with a slash.

cvsserver also horribly breaks for module names with slashs in them.
Something that might be good to be fixed, too.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
