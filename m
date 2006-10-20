From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 10:41:08 -0400
Message-ID: <20061020144108.GC17497@coredump.intra.peff.net>
References: <20061018214143.GF19194@spearce.org> <7vwt6xxofi.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org> <Pine.LNX.4.64.0610181910440.1971@xanadu.home> <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org> <7vac3tx900.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610190747060.3962@g5.osdl.org> <20061019160750.GS17794@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0610190936440.3962@g5.osdl.org> <20061020002032.GA7162@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 20 16:42:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GavZO-0001s2-FL
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 16:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946265AbWJTOlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 10:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946361AbWJTOlM
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 10:41:12 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:48015 "HELO
	peff.net") by vger.kernel.org with SMTP id S1946265AbWJTOlK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 10:41:10 -0400
Received: (qmail 27793 invoked from network); 20 Oct 2006 10:41:09 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 20 Oct 2006 10:41:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Oct 2006 10:41:08 -0400
To: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20061020002032.GA7162@delft.aura.cs.cmu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29479>

On Thu, Oct 19, 2006 at 08:20:32PM -0400, Jan Harkes wrote:

> It looks like you were really close. When we cannot resolve a delta, we
> just write it to the packfile and we don't queue it. If it can be
> resolved we write it as a full object.

If I understand correctly, if we see an unresolvable delta, we are just
making the assumption that its base has arrived (or will arrive) in the
same pack (without checking).  This means that we could end up with a
corrupted repository if the sender gives us a bad pack. I believe that
git's network interaction has been designed specifically to avoid such
possibilities (e.g., verifying completeness and integrity of downloaded
objects).

-Peff
