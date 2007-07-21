From: Jeff King <peff@peff.net>
Subject: Re: gitk problems: can't unset "idinlist(...)"
Date: Sat, 21 Jul 2007 01:59:18 -0400
Message-ID: <20070721055918.GA22399@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org> <20070721050912.GB20622@coredump.intra.peff.net> <alpine.LFD.0.999.0707202226130.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 07:59:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC7zz-0001aA-Ja
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 07:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764824AbXGUF7W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 01:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764780AbXGUF7V
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 01:59:21 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1446 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764480AbXGUF7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 01:59:20 -0400
Received: (qmail 13819 invoked from network); 21 Jul 2007 05:59:48 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 21 Jul 2007 05:59:48 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Jul 2007 01:59:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707202226130.27249@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53142>

On Fri, Jul 20, 2007 at 10:53:10PM -0700, Linus Torvalds wrote:

> With "arch/i386", I get the 7ed409 one, with "arch/i386 arch/x86_64" I get 
> a complaint about 57d1c91fa. In neither case do I see the reason.

Oops, I thought you were using a different command line.

> 	git log --topo-order --parents --pretty=one arch/i386/ arch/x86_64/
> 
> and search for it, it first shows up as a parent for commit 9fdb62af92: 
> and not just _one_ parent, but three! So it looks like the parent 
> simplification is broken, and maybe gitk is unhappy for that reason.

OK, that should make it easier to find (note also that 9fdb62af92 is an
octopus, which might be related).

> Junio, didn't we have some parent simplification patches recently?

v1.5.2 works, so I am bisecting.

-Peff
