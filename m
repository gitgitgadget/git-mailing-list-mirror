From: Jeff King <peff@peff.net>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
	#04; Mon, 19)
Date: Wed, 21 Jan 2009 14:07:57 -0500
Message-ID: <20090121190757.GB21686@coredump.intra.peff.net>
References: <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net> <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:10:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPiS5-0001oq-Vc
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbZAUTH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbZAUTH7
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:07:59 -0500
Received: from peff.net ([208.65.91.99]:56137 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbZAUTH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:07:59 -0500
Received: (qmail 16847 invoked by uid 107); 21 Jan 2009 19:08:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Jan 2009 14:08:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2009 14:07:57 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901210216440.19014@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106644>

On Wed, Jan 21, 2009 at 02:26:56AM +0100, Johannes Schindelin wrote:

> Well, in this case, you will find that the "bug" is _at most_ some 
> binaries not being found.
> [...]
> (Actually, with my new patch, the may be replaced, but _only_ if 
> necessary, and the same thing would apply as I said earlier: the binary 
> would not be found, or a binary from the PATH would be run without 
> valgrind; but the next runs will not have the problem.)

You can run a random binary from the PATH. So I have asked git to test
the version in the repository using valgrind, and to report success only
if both the git command itself succeeds and valgrind reports zero
errors. But it might run some other random version of git, not using
valgrind, and if _that_ succeeds, report success. And you don't think
that is a bug?

I'll grant it is an unlikely race to lose. I guess I just prefer my
races to be non-existent.

-Peff
