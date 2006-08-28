From: Jeff King <peff@peff.net>
Subject: Re: Starting to think about sha-256?
Date: Mon, 28 Aug 2006 14:32:52 -0400
Message-ID: <20060828183252.GC2950@coredump.intra.peff.net>
References: <44F1DCB7.6020804@garzik.org> <m31wr1exbf.fsf@defiant.localdomain> <Pine.LNX.4.64.0608271343120.27779@g5.osdl.org> <Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0608271522390.27779@g5.osdl.org> <656C30A1EFC89F6B2082D9B6@localhost> <Pine.LNX.4.64.0608281034440.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david.lang@digitalinsight.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 28 20:33:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHlur-00038b-PJ
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 20:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWH1Scy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 14:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWH1Scy
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 14:32:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:61899 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751208AbWH1Scy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 14:32:54 -0400
Received: (qmail 3451 invoked from network); 28 Aug 2006 14:32:14 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 28 Aug 2006 14:32:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Aug 2006 14:32:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608281034440.27779@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26173>

On Mon, Aug 28, 2006 at 10:56:01AM -0700, Linus Torvalds wrote:

> However, the "earlier will override" is very much what you want from a 
> security standpoint: remember that the git model is that you should 
> primarily trust only your _own_ repository. So if you do a "git pull", the 

This concept breaks down somewhat if you are pulling from two
repositories (one good and one evil). If I pull from the evil repo
first, that will become my "earlier" object, and I will never get the
colliding object from the good repo.

Executing such an attack might not be that hard, either (once we get
over that little hump of creating collisions at will!). The owner of
'evil' has to know a SHA1 that will be in 'good' before it makes it to
'good'. However, I imagine we frequently see SHA1s migrate from more
central repos (like .../torvalds/linux-2.6.git) to less central ones
(subsystem / port maintainers, etc).

-Peff
